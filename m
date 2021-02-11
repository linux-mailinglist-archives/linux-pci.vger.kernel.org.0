Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E0E31917A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 18:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhBKRss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 12:48:48 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55590 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231539AbhBKRqI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 12:46:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 85695412FB;
        Thu, 11 Feb 2021 17:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1613065521; x=
        1614879922; bh=/FT6EOQCcwNWggllD96Iyja2jj1GBdrtlABMuQdTpxQ=; b=b
        +OIUWXacplsbHsrRch5hRM/oVZ/2p/oLPLGmMWE60k/n2Hcr4E70yE9L4hTAo0W2
        /ElySnx+vAewsjR69wDGeP8cQ0K2FpMSYi37iojcjR0NK9e2rnDsdhCk1+AVl6mL
        +vFQbHZKWhOUIfxSVjzr1DcvBe5I+QWhrmy8Tb68Bk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id elDlYgmbv0YK; Thu, 11 Feb 2021 20:45:21 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id E83E3411FF;
        Thu, 11 Feb 2021 20:45:20 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (172.17.100.103) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 11 Feb 2021 20:45:20 +0300
Received: from T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272]) by
 T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272%14]) with mapi id
 15.01.0669.032; Thu, 11 Feb 2021 20:45:20 +0300
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
Thread-Index: AQHW1WT234xzlvvTV0WAimI1cHAduao9LYkAgABgu4CABcepgIADoByAgADzoQCACgJRgIABDByAgABmKIA=
Date:   Thu, 11 Feb 2021 17:45:20 +0000
Message-ID: <52dd963fc697059d3db39c25eda222f4b7197761.camel@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
         <20210128145316.GA3052488@bjorn-Precision-5520>
         <20210128203929.GB6613@wunner.de>
         <20210201125523.GN2542@lahna.fi.intel.com>
         <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
         <20210204104912.GE2542@lahna.fi.intel.com>
         <afc5d363476d445cfdf04b0ec4db9275db803af3.camel@yadro.com>
         <20210211113941.GF2542@lahna.fi.intel.com>
In-Reply-To: <20210211113941.GF2542@lahna.fi.intel.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C5A8282F41FA24E822E40155DB5AB9F@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTAyLTExIGF0IDEzOjM5ICswMjAwLCBtaWthLndlc3RlcmJlcmdAbGludXgu
aW50ZWwuY29tDQp3cm90ZToNCj4gT24gV2VkLCBGZWIgMTAsIDIwMjEgYXQgMDc6NDA6MDZQTSAr
MDAwMCwgU2VyZ2VpIE1pcm9zaG5pY2hlbmtvDQo+IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMS0w
Mi0wNCBhdCAxMjo0OSArMDIwMCwgTWlrYSBXZXN0ZXJiZXJnDQo+ID4gd3JvdGU6DQo+ID4gPiAu
Li4NCj4gPiBUaGUgYnJhbmNoIGlzIGZpbmFsbHkgcmVhZHksIHNvIGlmIHlvdSBzdGlsbCBoYXZl
IHRpbWUgZm9yIHRoYXQsDQo+ID4gcGxlYXNlDQo+ID4gdGFrZSBhIGxvb2s6DQo+ID4gDQo+ID4g
aHR0cHM6Ly9naXRodWIuY29tL1lBRFJPLUtOUy9saW51eC90cmVlL3lhZHJvL3BjaWVfaG90cGx1
Zy9tb3ZhYmxlX2JhcnNfdjkuMQ0KPiANCj4gVGhhbmtzIGZvciBzaGFyaW5nIQ0KPiANCj4gSSB0
cmllZCB0aGlzIHNlcmllcyBvbiB0b3Agb2YgdjUuMTEtcmM3IG9uIGEgRGVsbCBYUFMgOTM4MCBz
byB0aGF0IEkNCj4gaGF2ZSB0d28gVEJUMyBkZXZpY2VzIGNvbm5lY3RlZC4gRWFjaCBkZXZpY2Ug
aW5jbHVkZXMgUENJZSBzd2l0Y2ggYW5kDQo+IGENCj4geEhDSSBlbmRwb2ludC4NCj4gDQo+IFdo
YXQgSSBzZWUgdGhhdCB0aGUgaG90cGx1ZyBkb3duc3RyZWFtIHBvcnQgZG9lcyBub3QgaGF2ZSBl
bm91Z2ggYnVzDQo+IG51bWJlcnMgKGFuZCBvdGhlciByZXNvdXJjZXMgYWxsb2NhdGVkKSBzbyB3
aGVuIGF0dGFjaGluZyB0aGUgc2Vjb25kDQo+IGRldmljZSBpdCBkb2VzIG5vdCBmaXQgdGhlcmUg
YW55bW9yZS4gVGhlIHJlc3VsdGluZyAnbHNwY2kgLXQnIG91dHB1dA0KPiBsb29rcyBsaWtlIGJl
bG93Og0KPiANCj4gLVswMDAwOjAwXS0rLTAwLjANCj4gICAgICAgICAgICArLTAyLjANCj4gICAg
ICAgICAgICArLTA0LjANCj4gICAgICAgICAgICArLTA4LjANCj4gICAgICAgICAgICArLTEyLjAN
Cj4gICAgICAgICAgICArLTE0LjANCj4gICAgICAgICAgICArLTE0LjINCj4gICAgICAgICAgICAr
LTE1LjANCj4gICAgICAgICAgICArLTE1LjENCj4gICAgICAgICAgICArLTE2LjANCj4gICAgICAg
ICAgICArLTFjLjAtWzAxXS0tLS0wMC4wDQo+ICAgICAgICAgICAgKy0xYy42LVswMl0tLS0tMDAu
MA0KPiAgICAgICAgICAgICstMWQuMC1bMDMtM2JdLS0tLTAwLjAtWzA0LTNiXS0tKy0wMC4wLVsw
NV0tLS0tMDAuMA0KPiAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ky0wMS4wLVswNi0xZl0tLS0tMDAuMC0NCj4gWzA3LTA5XS0tKy0wMi4wLVswOF0tLS0tMDAuMA0K
PiAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICANCj4gICAgICAgXC0wNC4wLVswOV0tLS0tMDAuMC1bMGFdLS0NCj4gICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICstMDIuMC1bMjBdLS0tLTAw
LjANCj4gICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwtMDQuMC1b
MjEtM2JdLS0NCj4gICAgICAgICAgICArLTFkLjQtWzNjXS0tLS0wMC4wDQo+ICAgICAgICAgICAg
Ky0xZi4wDQo+ICAgICAgICAgICAgKy0xZi4zDQo+ICAgICAgICAgICAgKy0xZi40DQo+ICAgICAg
ICAgICAgXC0xZi41DQo+IA0KPiBTbyB0aGUgbGFzdCBQQ0lFIHN3aXRjaCBpcyBub3QgdmlzaWJs
ZSBhbnltb3JlLCBhbmQgdGhlIHhIQ0kgb24gdGhlDQo+IHNlY29uZCBUQlQgZGV2aWNlIGlzIG5v
dCBmdW5jdGlvbmFsIGVpdGhlci4NCj4gDQo+IE9uIHRoZSBtYWlubGluZSBrZXJuZWwgSSBnZXQg
dGhpczoNCj4gDQo+IC1bMDAwMDowMF0tKy0wMC4wDQo+ICAgICAgICAgICAgKy0wMi4wDQo+ICAg
ICAgICAgICAgKy0wNC4wDQo+ICAgICAgICAgICAgKy0wOC4wDQo+ICAgICAgICAgICAgKy0xMi4w
DQo+ICAgICAgICAgICAgKy0xNC4wDQo+ICAgICAgICAgICAgKy0xNC4yDQo+ICAgICAgICAgICAg
Ky0xNS4wDQo+ICAgICAgICAgICAgKy0xNS4xDQo+ICAgICAgICAgICAgKy0xNi4wDQo+ICAgICAg
ICAgICAgKy0xYy4wLVswMV0tLS0tMDAuMA0KPiAgICAgICAgICAgICstMWMuNi1bMDJdLS0tLTAw
LjANCj4gICAgICAgICAgICArLTFkLjAtWzAzLTNiXS0tLS0wMC4wLVswNC0zYl0tLSstMDAuMC1b
MDVdLS0tLTAwLjANCj4gICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICstMDEuMC1bMDYtMWZdLS0tLTAwLjAtDQo+IFswNy0xZl0tLSstMDIuMC1bMDhdLS0tLTAwLjAN
Cj4gICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgDQo+ICAgICAgIFwtMDQuMC1bMDktMWZdLS0tLTAwLjAtWzBhLTFmXS0t
Ky0wMi4wLVswYl0tLS0tMDAuMA0KPiAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICANCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcLTA0LjAtWzBjLTFmXS0tDQo+ICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICArLTAyLjAtWzIwXS0tLS0wMC4wDQo+ICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcLTA0LjAtWzIxLTNiXS0tDQo+ICAg
ICAgICAgICAgKy0xZC40LVszY10tLS0tMDAuMA0KPiAgICAgICAgICAgICstMWYuMA0KPiAgICAg
ICAgICAgICstMWYuMw0KPiAgICAgICAgICAgICstMWYuNA0KPiAgICAgICAgICAgIFwtMWYuNQ0K
PiANCj4gSW4gdGhpcyB0b3BvbG9neSBJIGNhbiBhZGQgeWV0IGFub3RoZXIgVEJUIGRldmljZSBh
bmQgdGhlcmUgYXJlIHN0aWxsDQo+IHJlc291cmNlcyBhdmFpbGFibGUgYW5kIGFsbCB0aGUgZW5k
cG9pbnRzIGFyZSBmdW5jdGlvbmFsIHRvby4NCj4gDQo+IEkgY2FuIHNlbmQgeW91IHRoZSBmdWxs
IGRtZXNnIGFuZCBsc3BjaSAtdnYgb3V0cHV0IGlmIG5lZWRlZC4NCg0KDQpXaGF0IGEgcGl0eS4g
WWVzLCBwbGVhc2UsIEkgd291bGQgb2YgY291cnNlIGxpa2UgdG8gdGFrZSBhIGxvb2sgd2h5DQp0
aGF0IGhhcHBlbmVkLCBhbmQgY29tcGFyZSwgd2hhdCB3ZW50IHdyb25nIChiZWZvcmUgYW5kIGFm
dGVyIHRoZQ0KaG90cGx1ZzogbHNwY2kgLXR2LCBkbWVzZyAtdCBhbmQgL3Byb2MvaW9tZW0gd2l0
aCAvcHJvYy9pb3BvcnRzLCBpZiBpdA0Kd291bGRuJ3QgYmUgdG9vIG11Y2ggdHJvdWJsZSkuDQoN
ClRoZSBmaXJzdCBwYXRjaHNldCB3YXNuJ3QgaW50ZW5kZWQgdG8gY2hhbmdlIHRoZSBidXMgbnVt
YmVycyBiZWhhdmlvciwNCnNvIEkgYWxzbyBoYXZlIHRvIGNoZWNrIHRoYXQgbG9jYWxseS4gQW5k
IGRlc3BpdGUgb2YgbGFjayBvZiBidXMNCm51bWJlcnMsIG5ldyBlbmRwb2ludHMgc3RpbGwgc2hv
dWxkIGJlIHZpc2libGUsIHRoaXMgaXMgZm9yIG1lIHRvIGNoZWNrDQphcyB3ZWxsLg0KDQpUaGFu
a3MgYSBsb3QgZm9yIHRlc3RpbmchDQoNClNlcmdlDQo=
