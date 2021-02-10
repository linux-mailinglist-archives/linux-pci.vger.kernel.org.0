Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE0317068
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 20:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhBJTlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 14:41:09 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:37672 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232742AbhBJTk4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 14:40:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 662A54124F;
        Wed, 10 Feb 2021 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1612986008; x=
        1614800409; bh=ur6MGwThh7YTYY1GUMFltTEurCvPhYjulaH5PguVfqM=; b=V
        zo1TeTrfU+wozHBlZvquwkpGV7b19E+YfmIeJUR/JiqX6WQImaa8dzK+RdXbqGTh
        hPH31D5a+3cpQRX/z4wA8cRMklEhWoyQC+zW898OlYqrI3VWe9KCGrBLWaGDGV5d
        Dv8fQCkzLuG/6K31CROmSI/cyccR0jJWbwBogmyNC4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id opYYxEr6UExe; Wed, 10 Feb 2021 22:40:08 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 14DA8404CB;
        Wed, 10 Feb 2021 22:40:06 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (172.17.100.103) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 10 Feb 2021 22:40:06 +0300
Received: from T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272]) by
 T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272%14]) with mapi id
 15.01.0669.032; Wed, 10 Feb 2021 22:40:06 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "christian@kellner.me" <christian@kellner.me>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Topic: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Index: AQHW1WT234xzlvvTV0WAimI1cHAduao9LYkAgABgu4CABcepgIADoByAgADzoQCACgJRgA==
Date:   Wed, 10 Feb 2021 19:40:06 +0000
Message-ID: <afc5d363476d445cfdf04b0ec4db9275db803af3.camel@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
         <20210128145316.GA3052488@bjorn-Precision-5520>
         <20210128203929.GB6613@wunner.de>
         <20210201125523.GN2542@lahna.fi.intel.com>
         <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
         <20210204104912.GE2542@lahna.fi.intel.com>
In-Reply-To: <20210204104912.GE2542@lahna.fi.intel.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1436AB617BBD2840BAC0039003EB9EB9@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTAyLTA0IGF0IDEyOjQ5ICswMjAwLCBNaWthIFdlc3RlcmJlcmcNCndyb3Rl
Og0KPiBPbiBXZWQsIEZlYiAwMywgMjAyMSBhdCAwODoxNzoxNFBNICswMDAwLCBTZXJnZWkgTWly
b3NobmljaGVua28NCj4gd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIxLTAyLTAxIGF0IDE0OjU1ICsw
MjAwLCBNaWthIFdlc3RlcmJlcmcgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEphbiAyOCwgMjAyMSBh
dCAwOTozOToyOVBNICswMTAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwg
SmFuIDI4LCAyMDIxIGF0IDA4OjUzOjE2QU0gLTA2MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+
ID4gPiA+ID4gT24gRnJpLCBEZWMgMTgsIDIwMjAgYXQgMDg6Mzk6NDVQTSArMDMwMCwgU2VyZ2Vp
DQo+ID4gPiA+ID4gTWlyb3NobmljaGVua28NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+
IC4uLg0KPiA+ID4gPiANCj4gPiA+ID4gSSBpbnRlbmRlZCB0byByZXZpZXcgYW5kIHRlc3QgdGhp
cyBpdGVyYXRpb24gb2YgdGhlIHNlcmllcyBtb3JlDQo+ID4gPiA+IGNsb3NlbHksIGJ1dCBoYXZl
bid0IGJlZW4gYWJsZSB0byBjYXJ2ZSBvdXQgdGhlIHJlcXVpcmVkIHRpbWUuDQo+ID4gPiA+IEkn
bSBhZGRpbmcgc29tZSBUaHVuZGVyYm9sdCBmb2xrcyB0byBjYyBpbiB0aGUgaG9wZSB0aGF0IHRo
ZXkNCj4gPiA+ID4gY2FuIGF0IGxlYXN0IHRlc3QgdGhlIHNlcmllcyBvbiB0aGVpciBkZXZlbG9w
bWVudCBicmFuY2guDQo+ID4gPiA+IEdldHRpbmcgdGhpcyB1cHN0cmVhbWVkIHNob3VsZCByZWFs
bHkgYmUgaW4gdGhlIGJlc3QgaW50ZXJlc3QNCj4gPiA+ID4gb2YgSW50ZWwgYW5kIG90aGVyIHBy
b211bGdhdG9ycyBvZiBUaHVuZGVyYm9sdC4NCj4gPiA+IA0KPiA+ID4gU3VyZS4gSXQgc2VlbXMg
dGhhdCB0aGlzIHNlcmllcyB3YXMgc3VibWl0dGVkIGluIERlY2VtYmVyIHNvDQo+ID4gPiBwcm9i
YWJseQ0KPiA+ID4gbm90IGFwcGxpY2FibGUgdG8gdGhlIHBjaS5naXQvbmV4dCBhbnltb3JlLiBB
bnl3YXlzLCBJIGNhbiBnaXZlDQo+ID4gPiBpdCBhDQo+ID4gPiB0cnkNCj4gPiA+IG9uIGEgVEJU
IGNhcGFibGUgc3lzdGVtIGlmIHNvbWVvbmUgdGVsbHMgbWUgd2hhdCBleGFjdGx5IHRvIHRlc3QN
Cj4gPiA+IDstKQ0KPiA+ID4gUHJvYmFibHkgYXQgbGVhc3QgdGhhdCB0aGUgZXhpc3RpbmcgZnVu
Y3Rpb25hbGl0eSBzdGlsbCB3b3JrcyBidXQNCj4gPiA+IHNvbWV0aGluZyBlbHNlIG1heWJlIHRv
bz8NCj4gPiANCj4gPiBGb3Igc2V0dXBzIHRoYXQgd29ya2VkIGZpbmUsIHRoZSBvbmx5IGV4cGVj
dGVkIGNoYW5nZSBpcyBhIHBvc3NpYmxlDQo+ID4gbGl0dGxlIGRpZmZlcmVudCBCQVIgbGF5b3V0
IChpbiAvcHJvYy9pb21lbSksIGFuZCB0aGVyZSBzaG91bGQgdGhlDQo+ID4gc2FtZQ0KPiA+IHF1
YW50aXR5IChvciBtb3JlKSBvZiBCQVJzIGFzc2lnbmVkIHRoYW4gYmVmb3JlLg0KPiA+IA0KPiA+
IEJ1dCBpZiB0aGVyZSBhcmUgYW55IHByb2JsZW1hdGljIHNldHVwcywgd2hpY2ggd2VyZW4ndCBh
YmxlIHRvDQo+ID4gYXJyYW5nZQ0KPiA+IG5ldyBCQVJzLCB0aGlzIHBhdGNoc2V0IG1heSBwdXNo
IGEgYml0IGZ1cnRoZXIuDQo+IA0KPiBHb3QgaXQuDQo+IA0KPiA+IEluIGEgZmV3IGRheXMgSSds
bCBwcm92aWRlIGFuIHVwZGF0ZWQgYnJhbmNoIGZvciBvdXIgbWlycm9yIG9mIHRoZQ0KPiA+IGtl
cm5lbCBvbiBHaXRodWIsIHdpdGggYSBjb21wbGV0ZSBhbmQgYnVtcGVkIHNldCBvZiBwYXRjaGVz
LA0KPiA+IHJlZHVjaW5nDQo+ID4gdGhlIHN0ZXBzIHJlcXVpcmVkIHRvIHRlc3QgdGhlbS4NCj4g
DQo+IFNvdW5kcyBnb29kLCB0aGFua3MhDQoNCkhpIE1pa2EsDQoNClRoZSBicmFuY2ggaXMgZmlu
YWxseSByZWFkeSwgc28gaWYgeW91IHN0aWxsIGhhdmUgdGltZSBmb3IgdGhhdCwgcGxlYXNlDQp0
YWtlIGEgbG9vazoNCg0KaHR0cHM6Ly9naXRodWIuY29tL1lBRFJPLUtOUy9saW51eC90cmVlL3lh
ZHJvL3BjaWVfaG90cGx1Zy9tb3ZhYmxlX2JhcnNfdjkuMQ0KDQoNCkFuZCBhIGJpdCBvZmYgdG9w
aWM6IEkndmUgYWxzbyB1cGRhdGVkIHRoZSBicmFuY2ggd2l0aCBhIGNvbXBsZXRlIHNldA0Kb2Yg
b3VyIGhvdHBsdWctcmVsYXRlZCBwYXRjaGVzLCBpbmNsdWRpbmcgYW4gUkZDIHNlcmllcyBvZiBt
b3ZhYmxlIGJ1cw0KbnVtYmVycyBmb3IgaG90LWFkZGluZyBsYXJnZSBhbmQvb3IgbmVzdGVkIHN3
aXRjaGVzIChhdCB0aGUgY29zdCBvZg0KYnJlYWtpbmcgdGhlIHN5c2ZzK3Byb2NzZiBBQkkpLiBJ
biBjYXNlIG9uZSBpcyBldmVyIGdvaW5nIHRvIHRyeSB0aGF0LA0KdGhlIHBjaT1yZWFsbG9jLG1v
dmFibGVfYnVzZXMga2VybmVsIGNvbW1hbmQgbGluZSBhcmd1bWVudHMgYXJlIG5lZWRlZDoNCg0K
aHR0cHM6Ly9naXRodWIuY29tL1lBRFJPLUtOUy9saW51eC9jb21taXRzL3lhZHJvL3BjaWVfaG90
cGx1Zy9tb3ZhYmxlX2J1c2VzX3Y5LjENCg0KVGhhbmtzIQ0KDQpTZXJnZQ0K
