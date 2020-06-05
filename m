Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603FE1EF50E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgFEKKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 06:10:04 -0400
Received: from ms.asus.com ([103.10.4.13]:30077 "EHLO ms.asus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgFEKKE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jun 2020 06:10:04 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2020 06:09:57 EDT
Received: from tp-ex16-v11.corpnet.asus ([172.22.47.21])
  by ms.asus.com with ESMTP; 05 Jun 2020 18:02:46 +0800
Received: from TP-MD-V01.corpnet.asus (172.22.47.17) by
 TP-EX16-V11.corpnet.asus (172.22.47.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 5 Jun 2020 18:02:45 +0800
Received: from TP-MD-V01.corpnet.asus (172.22.47.17) by TP-MD-V01.corpnet.asus
 (172.22.47.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Jun 2020
 18:02:45 +0800
Received: from TP-MD-V01.corpnet.asus ([fe80::ec39:a96a:6470:e2d3]) by
 TP-MD-V01.corpnet.asus ([fe80::ec39:a96a:6470:e2d3%3]) with mapi id
 15.01.1913.007; Fri, 5 Jun 2020 18:02:45 +0800
From:   =?utf-8?B?UmljaGFyZCBIc3Uo6Kix6IKy5b2wKQ==?= 
        <Richard_Hsu@asmedia.com.tw>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?utf-8?B?UmljaGFyZCBIc3Uo6Kix6IKy5b2wKQ==?= 
        <Richard_Hsu@asmedia.com.tw>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Richard Hsu <saraon640529@gmail.com>,
        =?utf-8?B?WWQgVHNlbmco5pu+6KOV6YGUKQ==?= <Yd_Tseng@asmedia.com.tw>,
        =?utf-8?B?SmVzc2UxIENoYW5nKOW8teWci+WZqCk=?= 
        <Jesse1_Chang@asmedia.com.tw>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        kbuild test robot <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] gpio:asm28xx-18xx: new driver
Thread-Topic: [PATCH] gpio:asm28xx-18xx: new driver
Thread-Index: AQHWOkJkYOa/7ea8mkKXsoI7RCLxT6jH0yOAgABk1YCAAOrEAIAAiXyw
Date:   Fri, 5 Jun 2020 10:02:44 +0000
Message-ID: <a12daf08b056431394272f52174aaa71@asmedia.com.tw>
References: <CAMpxmJX8U-uNYJPQxmkox=YTSvXVPrWss2y5MS81_bg43Co8Lg@mail.gmail.com>
 <20200604175515.GA1076951@bjorn-Precision-5520>
 <CAMRc=McWFpFAC3ziWdOEYkc0YwkN-Jqf7vZpxbCBLPoe=oewdg@mail.gmail.com>
In-Reply-To: <CAMRc=McWFpFAC3ziWdOEYkc0YwkN-Jqf7vZpxbCBLPoe=oewdg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.78.106.30]
X-TM-SNTS-SMTP:         A0089FC7E9ED9691ABFB0B3D4AECC64CC5BBDB61DBD930EA579853895A1FA53E2000:9
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-14.0.0.3031-8.5.1024-25462.005
X-TM-AS-Result: No-10--20.884700-8.000000
X-TMASE-MatchedRID: MVXmEgvcpVTUL3YCMmnG4vVY7U3NX8JgUb4EdIZGxuCPJT26aPghEksI
        xi34LbJS1oNG09ZWIjnlialA8Nln076QE1CQltOnaFAKyqG5M2IQAiYeAVgD3v5RW979ljm0rdp
        X0cpLdod2mzSFmhL2YlWZ2k1sBZgjgrOBJP860l2fnpEcofNXJa3Vr31o77bZmJBe2bRXwlP2Tq
        4vVkH7QV01WNOfyipFF448p0FfPUAzPQQUbmWdb5zEHTUOuMX3t3aeg7g/usCe9toQ6h6LE462G
        g+W5SqYRvmsVtJsdUqBv6+b+rhZvHaIbEjxkzvhtgyUiC29Qd6//2i/GlO8gOD3XFrJfgvzLUw/
        JiHjFV3qasocX+e5NgjAEA9CGIGZM9Yz9mROdONn3ejPjd19cfHZkvpjqH0nVz8J52OVy+TnKKt
        0v0a5BTQQCW5XXCoF5YaTeP6wu49QsilTGCZzpFHmrymVJ0uQ+li7VJuaaADLkl8e9W70i4PvfD
        9+PDihsgMYOyESP06w6oiXe1MVILvBOvwiH06oqJSK+HSPY++HgDwpGasZ7SBQRBOQhaJiMWM94
        lj32bRiDZThmCaG8SeMunxsvgMrn/nVWd4TWXe0pHkVd9vKzBiDIOPlOJG1E5liaVGW3KwjntTp
        RNAjt30tCKdnhB58pTwPRvSoXL2y5/tFZu9S3Ku6xVHLhqfxwrbXMGDYqV+FR9Hau8GO7gP90fJ
        P9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.884700-8.000000
X-TMASE-Version: SMEX-14.0.0.3031-8.5.1024-25462.005
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4gSGVsZ2FzcywNCiAgICBUaGFua3MgZm9yIHlvdXIgZGV0YWlsZWQgZXhwbGFuYXRp
b24uDQpIaSBCYXJ0b3N6IEdvbGFzemV3c2tpLA0KICAgIEkgYW0gZ3JhdGVmdWwgZm9yIHlvdXIg
c3VnZ2VzdGlvbi4gVGhlIGRyaXZlciBvZiBicmlkZ2UgaXMgYSBwY2kgYnVzIGRyaXZlci4gSXQg
aXNuJ3Qgd3JpdHRlbiBieSB1cyBhbmQgaXMgbW9yZSBjb21wbGV4LiBJIGhhdmUgemVybyBrbm93
bGVkZ2Ugb2YNCiB0aGUgUENJIHN1Yi1zeXN0ZW0sIGFuZCBwZXJoYXBzIGl0KHBjaSBidXMgZHJp
dmVyKSBkb24ndCB1c2UgZ3BpbyBzdWJzeXN0ZW0gd2l0aCAvc3lzL2NsYXNzL2dwaW8vKHN5c2Zz
IGludGVyZmFjZSkgdGhhdCBJIG5lZWQuIEkganVzdCBmb2xsb3cgdGhlIG90aGVyIGRyaXZlcihn
cGlvLWFtZDgxMTEuYykncw0KZnJhbWV3b3JrIGFuZCBtYXliZSBpdCBjYW4gYmUgdXNlZCBhZ2Fp
bi4gVGhhbmsgeW91IA0KDQpCUiwNCiAgUmljaGFyZA0KDQoNCiAgICAgICANCiAgICANCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJyZ2xA
YmdkZXYucGw+IA0KU2VudDogRnJpZGF5LCBKdW5lIDUsIDIwMjAgMzo1NiBQTQ0KVG86IEJqb3Ju
IEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4NCkNjOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxi
Z29sYXN6ZXdza2lAYmF5bGlicmUuY29tPjsgUmljaGFyZCBIc3UgPHNhcmFvbjY0MDUyOUBnbWFp
bC5jb20+OyBSaWNoYXJkIEhzdSjoqLHogrLlvbApIDxSaWNoYXJkX0hzdUBhc21lZGlhLmNvbS50
dz47IFlkIFRzZW5nKOabvuijlemBlCkgPFlkX1RzZW5nQGFzbWVkaWEuY29tLnR3PjsgSmVzc2Ux
IENoYW5nKOW8teWci+WZqCkgPEplc3NlMV9DaGFuZ0Bhc21lZGlhLmNvbS50dz47IExpbnVzIFdh
bGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFz
QGdvb2dsZS5jb20+OyBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT47IGtidWlsZC1h
bGxAbGlzdHMuMDEub3JnOyBsaW51eC1ncGlvIDxsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZz47
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGdwaW86YXNt
Mjh4eC0xOHh4OiBuZXcgZHJpdmVyDQoNCmN6dy4sIDQgY3plIDIwMjAgbyAxOTo1NSBCam9ybiBI
ZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+IG5hcGlzYcWCKGEpOg0KPg0KPiA+ID4gKyAgICAg
ICAvKiBXZSBsb29rIGZvciBvdXIgZGV2aWNlIC0gQXNtZWRpYSAyOFhYIGFuZCAxOFhYIEJyaWRn
ZQ0KPiA+ID4gKyAgICAgICAgKiBJIGRvbid0IGtub3cgYWJvdXQgYSBzeXN0ZW0gd2l0aCB0d28g
c3VjaCBicmlkZ2VzLA0KPiA+ID4gKyAgICAgICAgKiBzbyB3ZSBjYW4gYXNzdW1lIHRoYXQgdGhl
cmUgaXMgbWF4LiBvbmUgZGV2aWNlLg0KPiA+ID4gKyAgICAgICAgKg0KPiA+ID4gKyAgICAgICAg
KiBXZSBjYW4ndCB1c2UgcGxhaW4gcGNpX2RyaXZlciBtZWNoYW5pc20sDQo+ID4gPiArICAgICAg
ICAqIGFzIHRoZSBkZXZpY2UgaXMgcmVhbGx5IGEgbXVsdGlwbGUgZnVuY3Rpb24gZGV2aWNlLA0K
PiA+ID4gKyAgICAgICAgKiBtYWluIGRyaXZlciB0aGF0IGJpbmRzIHRvIHRoZSBwY2lfZGV2aWNl
IGlzIGFuIGJ1cw0KPiA+ID4gKyAgICAgICAgKiBkcml2ZXIgYW5kIGhhdmUgdG8gZmluZCAmIGJp
bmQgdG8gdGhlIGRldmljZSB0aGlzIHdheS4NCj4gPiA+ICsgICAgICAgICovDQo+ID4gPiArDQo+
ID4gPiArICAgICAgIGZvcl9lYWNoX3BjaV9kZXYocGRldikgew0KPiA+ID4gKyAgICAgICAgICAg
ICAgIGVudCA9IHBjaV9tYXRjaF9pZChwY2lfdGJsLCBwZGV2KTsNCj4gPiA+ICsgICAgICAgICAg
ICAgICBpZiAoZW50KSB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAvKiBCZWNhdXNl
IEdQSU8gUmVnaXN0ZXJzIG9ubHkgd29yayBvbiBVcHN0cmVhbSBwb3J0LiAqLw0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgdHlwZSA9IHBjaV9wY2llX3R5cGUocGRldik7DQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBpZiAodHlwZSA9PSBQQ0lfRVhQX1RZUEVfVVBTVFJFQU0p
IHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2luZm8oJnBkZXYt
PmRldiwgIkFTTUVESUEtMjh4eC8xOHh4IEluaXQgVXBzdHJlYW0gZGV0ZWN0ZWRcbiIpOw0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGZvdW5kOw0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiA+ICsg
ICAgICAgfQ0KPiA+ID4gKyAgICAgICBnb3RvIG91dDsNCj4gPiA+ICsNCj4gPg0KPiA+IEJqb3Ju
OiBpcyB0aGlzIGFwcHJvYWNoIHJlYWxseSBjb3JyZWN0PyBJdCBsb29rcyB2ZXJ5IHN0cmFuZ2Ug
dG8gbWUgDQo+ID4gYW5kIGV2ZW4gaWYgd2Ugd2VyZSB0byBkbyB0aGlzIGtpbmQgb2YgbG9va3Vw
IEknZCBleHBlY3QgdGhlcmUgdG8gYmUgDQo+ID4gYSByZWFsIHBjaSBkZXZpY2UgcmVnaXN0ZXJl
ZCBhcyBjaGlsZCBvZiBwZGV2IGhlcmUgc28gdGhhdCB3ZSBjYW4gDQo+ID4gaGF2ZSBhIHByb3Bl
ciBkcml2ZXIgaW4gcGxhY2Ugd2l0aCBwcm9iZSgpIGV0IGFsLg0KPg0KPiBObywgdGhpcyBpcyBw
cmV0dHkgYnJva2VuLiAgVGhlIG1vZGVsIGlzIHRoYXQgb25lIFBDSSBkZXZpY2UgZ29lcyB3aXRo
IA0KPiBvbmUgZHJpdmVyLiAgSWYgdGhlcmUgYXJlIHR3byBiaXRzIG9mIGZ1bmN0aW9uYWxpdHkg
YXNzb2NpYXRlZCB3aXRoIGEgDQo+IHNpbmdsZSBQQ0kgZGV2aWNlLCBpdCdzIHVwIHRvIHRoZSBz
aW5nbGUgUENJIGRyaXZlciB0byBzb3J0IHRoYXQgb3V0Lg0KPg0KPiBUaGUgY29tbWVudCBhYm92
ZSBtZW50aW9ucyAibXVsdGlwbGUgZnVuY3Rpb24gZGV2aWNlLCIgd2hpY2ggbWF5IGxlYWQgDQo+
IHRvIHNvbWUgY29uZnVzaW9uIGFib3V0IHRoZSB0ZXJtaW5vbG9neS4gIEluIHRoZSBQQ0kgc3Bl
Y3MsIHRoZSANCj4gc21hbGxlc3QgYWRkcmVzc2FibGUgdW5pdCBvZiBQQ0kgaGFyZHdhcmUgaXMg
dGhlICJGdW5jdGlvbi4iICBBIA0KPiAiRGV2aWNlIiBtYXkgY29uc2lzdCBvZiBvbmUgb3IgbW9y
ZSBGdW5jdGlvbnMuICBBIERldmljZSB3aXRoIG1vcmUgDQo+IHRoYW4gb25lIEZ1bmN0aW9uIGlz
IHJlZmVycmVkIHRvIGluIHRoZSBzcGVjIGFzIGEgIk11bHRpLUZ1bmN0aW9uIA0KPiBEZXZpY2Ui
Lg0KPg0KPiBUaGVzZSBQQ0kgRnVuY3Rpb25zIGFyZSBhZGRyZXNzZWQgYnkgYSAoZG9tYWluLCBi
dXMsIGRldmljZSwgZnVuY3Rpb24pIA0KPiB0dXBsZS4gIEZvciBleGFtcGxlLCBteSBzeXN0ZW0g
aGFzIHRoZXNlOg0KPg0KPiAgIDAwMDA6MDA6MTQuMCBJbnRlbCBVU0IgMy4wIHhIQ0kgQ29udHJv
bGxlcg0KPiAgIDAwMDA6MDA6MTQuMiBJbnRlbCBUaGVybWFsIFN1YnN5c3RlbQ0KPg0KPiBUaGVz
ZSB0d28gRnVuY3Rpb25zIGFyZSBwYXJ0cyBvZiB0aGUgMDAwMDowMDoxNCBNdWx0aS1GdW5jdGlv
biBEZXZpY2UuDQo+DQo+IEluIExpbnV4LCBhICJzdHJ1Y3QgcGNpX2RldiIgcmVmZXJzIHRvIGEg
c2luZ2xlIEZ1bmN0aW9uLCBzbyB0aGVyZSdzIGEgDQo+IHBjaV9kZXYgZm9yIDAwMDA6MDA6MTQu
MCBhbmQgYW5vdGhlciBmb3IgMDAwMDowMDoxNC4yLiAgVGhlc2UgYXJlIA0KPiBwcmV0dHkgbXVj
aCBpbmRlcGVuZGVudCwgYW5kIGNhbiBiZSBjbGFpbWVkIGJ5IHR3byBzZXBhcmF0ZSBkcml2ZXJz
Lg0KPg0KPiBCdXQgSSB0aGluayB0aGUgIm11bHRpcGxlIGZ1bmN0aW9uIGRldmljZSIgY29tbWVu
dCBpbiAqdGhpcyogcGF0Y2ggDQo+IHByb2JhYmx5IGRvZXNuJ3QgcmVmZXIgdG8gYSAiTXVsdGkt
RnVuY3Rpb24gRGV2aWNlIiBhcyB1c2VkIGluIHRoZSBQQ0kgDQo+IHNwZWNzLiAgSXQgcHJvYmFi
bHkgbWVhbnMgYSBzaW5nbGUgUENJIEZ1bmN0aW9uIHRoYXQgaGFzIHR3byBraW5kcyBvZiANCj4g
ZnVuY3Rpb25hbGl0eS4NCj4NCj4gSW4gdGhlIExpbnV4IG1vZGVsLCB0aGF0IG1lYW5zIHRoZSBG
dW5jdGlvbiBzaG91bGQgYmUgY2xhaW1lZCBieSBhIA0KPiBzaW5nbGUgZHJpdmVyLCBhbmQgdGhh
dCBkcml2ZXIgaXMgcmVzcG9uc2libGUgZm9yIGNvb3JkaW5hdGluZyB0aGUgdHdvIA0KPiBwaWVj
ZXMgb2YgZnVuY3Rpb25hbGl0eS4NCj4NCg0KVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgZXhwbGFu
YXRpb24hDQoNClJpY2hhcmQ6IGluIHRoaXMgY2FzZSBJIHRoaW5rIGl0J3MgcHJldHR5IGNsZWFy
IG5vdyB0aGF0IHdoYXRldmVyIGRyaXZlciBzdXBwb3J0cyB0aGUgImJyaWRnZSIgbWVudGlvbmVk
IGluIHRoZSBjb21tZW50IC0gbmVlZHMgdG8gYmUgZXh0ZW5kZWQgd2l0aCBHUElPIGZ1bmN0aW9u
YWxpdHkuDQoNCkJhcnQNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KVGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHRvIGl0IGNv
bnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGFuZCBhcmUgaW50ZW5kZWQgc29sZWx5IGZv
ciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsIHRvIHdob20gaXQgDQppcyBhZGRyZXNzZWQuSWYg
eW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvciByZWNlaXZlIGl0IGFjY2lkZW50
YWxseSwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IGUtbWFpbCBhbmQg
ZGVsZXRlIA0KdGhlIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyBmcm9tIHlvdXIgY29tcHV0
ZXIgc3lzdGVtLCBhbmQgZGVzdHJveSBhbGwgaGFyZCBjb3BpZXMuIElmIGFueSwgcGxlYXNlIGJl
IGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIA0KZGlzY2xvc3VyZSwgY29weWluZywgZGlz
dHJpYnV0aW9uIG9yIGFueSBhY3Rpb24gdGFrZW4gb3Igb21pdHRlZCBpbiByZWxpYW5jZSBvbiB0
aGlzLCBpcyBpbGxlZ2FsIGFuZCBwcm9oaWJpdGVkLiBGdXJ0aGVybW9yZSwgYW55IHZpZXdzIA0K
b3Igb3BpbmlvbnMgZXhwcmVzc2VkIGFyZSBzb2xlbHkgdGhvc2Ugb2YgdGhlIGF1dGhvciBhbmQg
ZG8gbm90IHJlcHJlc2VudCB0aG9zZSBvZiBBU01lZGlhIFRlY2hub2xvZ3kgSW5jLiBUaGFuayB5
b3UgZm9yIHlvdXIgY29vcGVyYXRpb24uDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0K

