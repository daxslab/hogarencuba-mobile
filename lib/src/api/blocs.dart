import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import 'repository.dart';

class Blocs {
    final _repository = Repository();
    
    final BehaviorSubject<
        Response> _subject = BehaviorSubject<
        Response>();
    
    homes() async {
        try {
            Response response = await _repository.homes();
            _subject.sink.add(response);
        } catch (error) {
            _subject.addError(null);
        }
    }
    
    dispose() {
        _subject.close();
    }
    
    BehaviorSubject<Response> get subject => _subject;
}

final blocs = Blocs();