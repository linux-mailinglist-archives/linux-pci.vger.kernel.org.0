Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D035630E3B7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 21:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhBCUAo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 15:00:44 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:49822 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231696AbhBCUAl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 15:00:41 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id A567241253;
        Wed,  3 Feb 2021 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1612382395; x=
        1614196796; bh=nNazUy+mZ3RjN3M3Tx+GUj1B/fOJldYF/TIYxuQC0lU=; b=X
        iVIlP6cqVLkk2TXxavgU6KKM5yxyCz/47/Om/0mq7MigztSQQvNcGOKWxnhAsbkN
        83kSEiIEp+rj7OIKGpS7MF2K1QWNM/3sm9Vssjn5a0jey0+SdL9k1Xm24ViN4mO1
        RtETuh03cIpJU1r+GNWVrHgAXA1r73kmxFta1AZ1Dw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ayz8d242ICkG; Wed,  3 Feb 2021 22:59:55 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 819C4411D9;
        Wed,  3 Feb 2021 22:59:54 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (172.17.100.103) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 3 Feb 2021 22:59:53 +0300
Received: from T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272]) by
 T-EXCH-03.corp.yadro.com ([fe80::39f4:7b05:b1d3:5272%14]) with mapi id
 15.01.0669.032; Wed, 3 Feb 2021 22:59:54 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "rajatja@google.com" <rajatja@google.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "linux@yadro.com" <linux@yadro.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Topic: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Thread-Index: AQHW1WT234xzlvvTV0WAimI1cHAduao9LYkAgAnDqIA=
Date:   Wed, 3 Feb 2021 19:59:54 +0000
Message-ID: <de82694ed11f2c8a996d3701da04a8ee87fe6be5.camel@yadro.com>
References: <20210128145316.GA3052488@bjorn-Precision-5520>
In-Reply-To: <20210128145316.GA3052488@bjorn-Precision-5520>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C5707E3B86B6A4C82E4ABAEF1A70100@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNCk9uIFRodSwgMjAyMS0wMS0yOCBhdCAwODo1MyAtMDYwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gSSBjYW4gY2VydGFpbmx5IHNlZSBzY2VuYXJpb3Mgd2hlcmUgdGhpcyBm
dW5jdGlvbmFsaXR5IHdpbGwgYmUNCj4gdXNlZnVsLA0KPiBidXQgdGhlIHNlcmllcyBjdXJyZW50
bHkgZG9lc24ndCBtZW50aW9uIGJ1ZyByZXBvcnRzIHRoYXQgaXQNCj4gZml4ZXMuICBJDQo+IHN1
c3BlY3QgdGhlcmUgKmFyZSogc29tZSByZWxhdGVkIGJ1ZyByZXBvcnRzLCBlLmcuLCBmb3IgVGh1
bmRlcmJvbHQNCj4gaG90cGx1Zy4gIFdlIHNob3VsZCBkaWcgdGhlbSB1cCwgaW5jbHVkZSBwb2lu
dGVycyB0byB0aGVtLCBhbmQgZ2V0DQo+IHRoZQ0KPiByZXBvcnRlcnMgdG8gdGVzdCB0aGUgc2Vy
aWVzIGFuZCBwcm92aWRlIGZlZWRiYWNrLg0KDQpJdCBuZXZlciBvY2N1cnJlZCB0byBtZSB0byBh
Y3R1YWxseSBzZWFyY2ggZm9yIHJlcG9ydHMsIHRoYW5rcy4NCg0KPiBXZSBoYWQgc29tZSByZXZp
ZXcgdHJhZmZpYyBvbiBlYXJsaWVyIHZlcnNpb25zLCBidXQgYXMgZmFyIGFzIEkgY2FuDQo+IHNl
ZSwgbm9ib2R5IGhhcyBzdGVwcGVkIHVwIHdpdGggYW55IGFjdHVhbCBzaWducyBvZiBhcHByb3Zh
bCwgZS5nLiwNCj4gVGVzdGVkLWJ5LCBSZXZpZXdlZC1ieSwgb3IgQWNrZWQtYnkgdGFncy4gIFRo
YXQncyBhIHByb2JsZW0gYmVjYXVzZQ0KPiB0aGlzIHRvdWNoZXMgYSBsb3Qgb2Ygc2Vuc2l0aXZl
IGNvZGUgYW5kIEkgZG9uJ3Qgd2FudCB0byBiZSBzdHVjaw0KPiBmaXhpbmcgaXNzdWVzIGFsbCBi
eSBteXNlbGYuICBXaGVuIGlzc3VlcyBjcm9wIHVwLCBJIGxvb2sgdG8gdGhlDQo+IGF1dGhvciBh
bmQgcmV2aWV3ZXJzIHRvIGhlbHAgb3V0Lg0KDQpJbmRlZWQsIEkgaGFkIG9ubHkgYSBmZXcgaW5m
b3JtYWwgcGVyc29uYWwgcmVzcG9uc2VzIFtmcm9tIG91dHNpZGUgb2YNCm91ciBjb21wYW55XToN
CiAtIHNvbWUgbWFjaGluZXMgaGF2ZSBubyByZWdyZXNzaW9ucyB3aXRoIHRoZSBrZXJuZWwgYnVp
bHQgd2l0aCBDbGFuZy0NCjEyK0xUTytJQVM7DQogLSBOVk1lIGhvdHBsdWcgc3RhcnRlZCB3b3Jr
aW5nIGZvciBBTUQgRXB5YyB3aXRoIGEgUEVYIHN3aXRjaDsNCiAtIEFub3RoZXIgc3lzdGVtIHdp
dGggc2V2ZXJhbCBQRVggc3dpdGNoZXMgaXMgdW5kZXIgb25nb2luZw0KZXhwZXJpbWVudHMuDQoN
ClByb3ZpZGluZyBhbiBhYmlsaXR5IHRvIHF1aWNrbHkgcmV0dXJuIHRvIHRoZSBvbGQgQkFScyBh
bGxvY2F0aW5nIGlzDQp0aGUgcmVhc29uIHdoeSBJIGtlZXAgd3JhcHBpbmcgdGhlIG1vc3QgaW50
cnVzaXZlIGNvZGUgd2l0aCAiaWYNCihwY2lfY2FuX21vdmVfYmFycykiLiBPcmlnaW5hbGx5IEkg
d2FudGVkIGl0IHRvIGJlIGRpc2FibGVkIGJ5IGRlZmF1bHQsDQphdmFpbGFibGUgZm9yIHRob3Nl
IHRydWx5IGRlc3BlcmF0ZS4gQnV0IHRoZXJlIHdhcyBhbiBvYmplY3Rpb24gdGhhdA0KdGhlIGNv
ZGUgd2lsbCBub3QgYmUgZXZlciB0ZXN0ZWQgdGhpcyB3YXkuDQoNCj4gQWxvbmcgdGhhdCBsaW5l
LCBJJ20gYSBsaXR0bGUgY29uY2VybmVkIGFib3V0IGhvdyB3ZSB3aWxsIGJlIGFibGUgdG8NCj4g
cmVwcm9kdWNlIGFuZCBkZWJ1ZyBwcm9ibGVtcy4gIElzc3VlcyB3aWxsIGxpa2VseSBkZXBlbmQg
b24gdGhlDQo+IHRvcG9sb2d5LCB0aGUgcmVzb3VyY2VzIG9mIHRoZSBzcGVjaWZpYyBkZXZpY2Vz
IGludm9sdmVkLCBhbmQgYQ0KPiBzcGVjaWZpYyBzZXF1ZW5jZSBvZiBob3RwbHVnIG9wZXJhdGlv
bnMuICBUaG9zZSBtYXkgYmUgaGFyZCB0bw0KPiByZXByb2R1Y2UgZXZlbiBmb3IgdGhlIHJlcG9y
dGVyLiAgTWF5YmUgdGhpcyBpcyBub3RoaW5nIG1vcmUgdGhhbiBhDQo+IGdyZXAgcGF0dGVybiB0
byBleHRyYWN0IHJlbGV2YW50IGV2ZW50cyBmcm9tIGRtZXNnLiAgSWRlYWwsIGJ1dCBtYXliZQ0K
PiBpbXByYWN0aWNhbCwgd291bGQgYmUgYSB3YXkgdG8gcmVwcm9kdWNlIHRoaW5ncyBpbiBhIFZN
IHVzaW5nIHFlbXUNCj4gYW5kDQo+IGEgc2NyaXB0IHRvIHNpbXVsYXRlIGhvdHBsdWdzLg0KDQpJ
IGhhdmVuJ3QgeWV0IHRyaWVkIHRoZSBxZW11IGZvciBQQ0kgZGVidWdnaW5nLCBkZWZpbml0ZWx5
IG5lZWQgdG8gdGFrZQ0KYSBsb29rLiBUbyBoZWxwIHdpdGggdGhhdCwgdGhlIHBhdGNoc2V0IGlz
IHN1cHBsaWVkIHdpdGggYWRkaXRpb25hbA0KcHJpbnRzLCBidXQgQ09ORklHX1BDSV9ERUJVRz15
IGlzIHN0aWxsIHByZWZlcnJlZC4gQSBzaW11bGF0aW9uIHdpbGwNCnJldmVhbCBpZiBhZGRpdGlv
bmFsIGRlYnVnIG1lc3NhZ2VzIGFyZSBuZWVkZWQuDQoNCj4gPiBUaGUgZmVhdHVyZSBpcyB1c2Fi
bGUgbm90IG9ubHkgZm9yIGhvdHBsdWcsIGJ1dCBhbHNvIGZvciBib290aW5nDQo+ID4gd2l0aCBh
DQo+ID4gY29tcGxldGUgc2V0IG9mIEJBUnMgYXNzaWduZWQsIGFuZCBmb3IgUmVzaXphYmxlIEJB
UnMuDQo+IA0KPiBJJ20gaW50ZXJlc3RlZCBpbiBtb3JlIGRldGFpbHMgYWJvdXQgYm90aCBvZiB0
aGVzZS4gIFdoYXQgZG9lcyAiYQ0KPiBjb21wbGV0ZSBzZXQgb2YgQkFScyBhc3NpZ25lZCIgbWVh
bj8gIE9uIHg4NiwgdGhlIEJJT1MgdXN1YWxseQ0KPiBhc3NpZ25zDQo+IGFsbCB0aGUgQkFScyBh
aGVhZCBvZiB0aW1lLCBidXQgSSBrbm93IHRoYXQncyBub3QgdGhlIGNhc2UgZm9yIGFsbA0KPiBh
cmNoZXMuDQoNClVzdWFsbHkgeWVzLCBidXQgd2UgaGF2ZSBhdCBsZWFzdCBvbmUgeDg2IFBDIHRo
YXQgc2tpcHMgc29tZSBCQVJzIChuZWVkDQp0byBjaGVjayBvdXQgYWdhaW4gaXRzIHBhcnRpY3Vs
YXIgbW9kZWwgYW5kIHZlcnNpb24sIElJUkMgdGhhdCB3YXMNClozNzAtRikgLS0gbm90IHRoZSBj
cnVjaWFsIG9uZXMgbGlrZSBCQVIwLCB0aG91Z2guIFRoYXQgcmVhbGx5IGdvdCBtZQ0KYnkgc3Vy
cHJpc2UsIHNvIG5vdyBpdCBpcyBvbmUgbW9yZSBjYXNlIGNvdmVyZWQuDQoNCj4gRm9yIFJlc2l6
YWJsZSBCQVJzLCBpcyB0aGUgcG9pbnQgdGhhdCB0aGlzIGFsbG93cyBtb3JlIGZsZXhpYmlsaXR5
IGluDQo+IHJlc2l6aW5nIEJBUnMgYmVjYXVzZSB3ZSBjYW4gbm93IG1vdmUgdGhpbmdzIG91dCBv
ZiB0aGUgd2F5Pw0KDQpOb3Qgb25seSB0aGluZ3Mgb3V0IG9mIHRoZSB3YXksIGJ1dCBtb3N0IGlt
cG9ydGFudGx5IHRoZSBicmlkZ2Ugd2luZG93cw0KYXJlIG5vdyBmbG9hdGluZyBhcyB3ZWxsLiBT
byBpdCdzIG1vcmUgZnJlZWRvbSBmb3IgYSBuZXcgQkFSIHRvDQoiY2hvb3NlIiBhIHBsYWNlLg0K
DQpBbiBhd2Z1bGx5IHN5bnRoZXRpYyBleGFtcGxlOg0KDQp8ICAgICAgICAgICAgICAgICAgICAg
ICBSQyBBZGRyZXNzIFNwYWNlICAgICAgICAgICAgICAgICAgICAgICB8DQp8IG9yaWcgR1BVIEJB
UiB8IGZpeGVkIEJBUiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQp8ICAg
ICAgICAgICAgICB8IGZpeGVkIEJBUiB8ICAgICBSZXNpemVkIEdQVSBCQVIgICAgICAgIHwgICAg
ICB8DQoNCj4gPiBUZXN0ZWQgb24gYSBudW1iZXIgb2YgeDg2XzY0IG1hY2hpbmVzIHdpdGhvdXQg
YW55IHNwZWNpYWwga2VybmVsDQo+ID4gY29tbWFuZA0KPiA+IGxpbmUgYXJndW1lbnRzIChzb21l
IG9mIHRoZW0gLS0gd2l0aCBvbGRlciB2OCByZXZpc2lvbiBvZiB0aGlzDQo+ID4gcGF0Y2hzZXQp
Og0KPiA+ICAtIFBDOiBpNy01OTMwSyArIEFTVVMgWDk5LUE7DQo+ID4gIC0gUEM6IGk1LTg1MDAg
KyBBU1VTIFozNzAtRjsNCj4gPiAgLSBQQzogQU1EIFJ5emVuIDcgMzcwMFggKyBBU1JvY2sgWDU3
MCArIEFNRCA1NzAwIFhUIChSZXNpemFibGUNCj4gPiBCQVJzKTsNCj4gPiAgLSBTdXBlcm1pY3Jv
IFN1cGVyIFNlcnZlci9IMTFTU0wtaTogQU1EIEVQWUMgNzI1MTsNCj4gPiAgLSBIUCBQcm9MaWFu
dCBETDM4MCBHNTogWGVvbiBYNTQ2MDsNCj4gPiAgLSBEZWxsIEluc3Bpcm9uIE41MDEwOiBpNSBN
IDQ4MDsNCj4gPiAgLSBEZWxsIFByZWNpc2lvbiBNNjYwMDogaTctMjkyMFhNLg0KPiANCj4gRG9l
cyB0aGlzIHRlc3Rpbmcgc2hvdyBubyBjaGFuZ2UgaW4gYmVoYXZpb3IgYW5kIG5vIHJlZ3Jlc3Np
b25zLCBvcg0KPiBkb2VzIGl0IHNob3cgdGhhdCB0aGlzIHNlcmllcyBmaXhlcyBjYXNlcyB0aGF0
IHByZXZpb3VzbHkgZGlkIG5vdA0KPiB3b3JrPyAgSWYgdGhlIGxhdHRlciwgc29tZSBidWd6aWxs
YSByZXBvcnRzIHdpdGggYmVmb3JlL2FmdGVyIGRtZXNnDQo+IGxvZ3Mgd291bGQgZ2l2ZSBzb21l
IGluc2lnaHQgaW50byBob3cgdGhpcyB3b3JrcyBhbmQgYWxzbyBzb21lIGdvb2QNCj4ganVzdGlm
aWNhdGlvbi4NCg0KQm90aCwgYWN0dWFsbHksIGJ1dCB0aGUgZG1lc2cgbG9ncyB3ZXJlIG5ldmVy
IHB1Ymxpc2hlZCwgc28gdGhleSB3aWxsDQpiZSB0aGUgbmV4dCBzdGVwIC0tIGNvbWJpbmVkIHdp
dGggcWVtdSBzY3JpcHRzLCBpZiBpdCB3b3Jrcy4NCg0KPiA+IFRoaXMgcGF0Y2hzZXQgaXMgYSBw
YXJ0IG9mIG91ciB3b3JrIG9uIGFkZGluZyBzdXBwb3J0IGZvciBob3QtDQo+ID4gYWRkaW5nDQo+
ID4gY2hhaW5zIG9mIGNoYXNzaXMgZnVsbCBvZiBvdGhlciBicmlkZ2VzLCBOVk1FIGRyaXZlcywg
U0FTIEhCQXMsDQo+ID4gR1BVcywgZXRjLg0KPiA+IHdpdGhvdXQgc3BlY2lhbCByZXF1aXJlbWVu
dHMgc3VjaCBhcyBIb3QtUGx1ZyBDb250cm9sbGVyLA0KPiA+IHJlc2VydmF0aW9uIG9mDQo+ID4g
YnVzIG51bWJlcnMgb3IgbWVtb3J5IHJlZ2lvbnMgYnkgZmlybXdhcmUsIGV0Yy4NCj4gDQo+IFRo
aXMgaXMgYSBsaXR0bGUgYml0IG9mIGEgY2hpY2tlbiBhbmQgZWdnIHNpdHVhdGlvbi4gIEkgc3Vz
cGVjdCBtYW55DQo+IHBlb3BsZSB3b3VsZCBsaWtlIHRoaXMgZnVuY3Rpb25hbGl0eSwgYnV0IGN1
cnJlbnRseSB3ZSBlaXRoZXIgYXZvaWQNCj4gaXQNCj4gYmVjYXVzZSBpdCdzICJrbm93biBub3Qg
dG8gd29yayIgb3Igd2UgaGFjayBhcm91bmQgaXQgd2l0aCB0aGUNCj4gZmlybXdhcmUgcmVzZXJ2
YXRpb25zIHlvdSBtZW50aW9uLg0KDQpUaGUgY3VycmVudCAodjkpIHBhdGNoc2V0IGJlY2FtZSBt
b3JlIHN5bWJpb3RpYyB3aXRoIG90aGVyIGhvdHBsdWcNCmZhY2lsaXRpZXM6IGl0IHN0YXJ0ZWQg
dG8gcmVzcGVjdCBwY2k9aHBtZW1zaXplIGV0YywgYW5kIG9ubHkgZHJvcHMgaXQNCmlmIHN1Y2gg
YWxsb2NhdGlvbiBpcyBpbXBvc3NpYmxlLg0KDQpBdHRlbnRpb24gQnV0dG9uIGZvciBBc3Npc3Rl
ZCBIb3RwbHVnIChwY2llaHAgZHJpdmVyKSB3YXMgYWx3YXlzDQpzdXBwb3J0ZWQuIEl0IGlzIGFs
c28gZnVsbHkgY29tcGF0aWJsZSB3aXRoIERQQy4NCg0KVGhlIGdvYWwgaXMgdG8gc3F1ZWV6ZSBh
cyBtdWNoIGFzIHBvc3NpYmxlIGV2ZW4gd2l0aG91dCBzcGVjaWFsDQpodytmdytzdyBzdXBwb3J0
LCB3aGVuIHRoZSBvbmx5IGF2YWlsYWJsZSB0b29sIGlzIGEgbWFudWFsIHJlc2NhbiB2aWENCnN5
c2ZzLg0KDQpTZXJnZQ0K
