Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D267F98
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2019 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfGNPJh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Jul 2019 11:09:37 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:48472 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfGNPJh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Jul 2019 11:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563116976; x=1594652976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=afLAhRTmyXqD4WvsD9i4GDCBH1C8z4LWY6KP9KTmfPY=;
  b=Bxp/vQGobnuymPUNWuM1DrIHn3YLfl+oHEudwgA5sI/mrUR8YiSiy0Ib
   2UvSafDv8GkGnW1wUzOrdFuLu7YwNhx86ranaw7hVAzINPrP5pX4VTaOq
   QkxJikgmOgX/DqheqN4cQoLLI7+VpO9FcH+S1xaQzV+3/1e+xwtTtCQKM
   E=;
X-IronPort-AV: E=Sophos;i="5.62,490,1554768000"; 
   d="scan'208";a="811086998"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 14 Jul 2019 15:09:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 54A9AA1EE5;
        Sun, 14 Jul 2019 15:09:29 +0000 (UTC)
Received: from EX13D02UWB001.ant.amazon.com (10.43.161.240) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 14 Jul 2019 15:09:29 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D02UWB001.ant.amazon.com (10.43.161.240) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 14 Jul 2019 15:09:28 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Sun, 14 Jul 2019 15:09:28 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/8] PCI: Add quirk to disable MSI support for Amazon's
 Annapurna Labs host bridge
Thread-Topic: [PATCH 4/8] PCI: Add quirk to disable MSI support for Amazon's
 Annapurna Labs host bridge
Thread-Index: AQHVNz7pFJOUVU8rpUq6BZp0rOsVi6bG9iOAgANHogA=
Date:   Sun, 14 Jul 2019 15:09:28 +0000
Message-ID: <2cac43401f0cf76acb645b98c6543204f12d5c05.camel@amazon.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
         <20190710164519.17883-5-jonnyc@amazon.com>
         <20190712130419.GA46935@google.com>
In-Reply-To: <20190712130419.GA46935@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.115]
Content-Type: text/plain; charset="utf-8"
Content-ID: <55739D4A49BDD04D8FD5432054916642@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTEyIGF0IDA4OjA0IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUaHUsIEp1bCAxMSwgMjAxOSBhdCAwNTo1NjoyNVBNICswMzAwLCBKb25hdGhhbiBDaG9j
cm9uIHdyb3RlOg0KPiA+IE9uIHNvbWUgcGxhdGZvcm1zLCB0aGUgaG9zdCBicmlkZ2UgZXhwb3Nl
cyBhbiBNU0ktWCBjYXBhYmlsaXR5IGJ1dA0KPiA+IGRvZXNuJ3QgYWN0dWFsbHkgc3VwcG9ydCBp
dC4NCj4gPiBUaGlzIGNhdXNlcyBhIGNyYXNoIGR1cmluZyBpbml0aWFsaXphdGlvbiBieSB0aGUg
cGNpZXBvcnQgZHJpdmVyLA0KPiA+IHNpbmNlDQo+ID4gaXQgdHJpZXMgdG8gY29uZmlndXJlIHRo
ZSBNU0ktWCBjYXBhYmlsaXR5Lg0KPiANCj4gTml0OiBUaGUgZm9ybWF0dGluZyBhYm92ZSBpcyBq
YXJyaW5nIHRvIHJlYWQgYmVjYXVzZSBJIGNhbid0IHRlbGwNCj4gd2hldGhlciBpdCdzIG9uZSBw
YXJhZ3JhcGggb3IgdHdvLg0KPiANCj4gRWl0aGVyIHJld3JhcCBpdCBpbnRvIGEgc2luZ2xlIHBh
cmFncmFwaCBvciBhZGQgYSBibGFuayBsaW5lIHRvIG1ha2UNCj4gdHdvIHBhcmFncmFwaHMuICBJ
IG5vdGljZWQgdGhpcyBlbHNld2hlcmUsIHRvbywgaW4gYSBjb21tZW50LCBJDQo+IHRoaW5rLg0K
PiANCkFjay4NCg0KPiBzL2hvc3QgYnJpZGdlL1Jvb3QgUG9ydC8sIGlmIEkgdW5kZXJzdGFuZCBj
b3JyZWN0bHkuDQo+IA0KQWNrLg0KDQpCVFcsIHdoYXQgaXMgdGhlIG1haW4gZGlmZmVyZW5jZSBi
ZXR3ZWVuIHRoZSAyIHRlcm1zLCBzaW5jZSB0aGV5IHNlZW0NCnRvIGJlIChtaXN0YWtlbmx5Pykg
dXNlZCBpbnRlcmNoYW5nZWFibHk/DQoNCj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoZSAib24gc29t
ZSBwbGF0Zm9ybXMuLi4iIHBhcnQuICBEbyB5b3UgbWVhbiB0aGF0DQo+IG9uICpldmVyeSogcGxh
dGZvcm0sIHRoaXMgcGFydGljdWxhciBob3N0IGJyaWRnZSAoaWRlbnRpZmllZCBieQ0KPiBbMWMz
NjowMDMxXSkgYWR2ZXJ0aXNlcyBhbiBNU0ktWCBjYXBhYmlsaXR5IHRoYXQgZG9lc24ndCB3b3Jr
Pw0KPiANCj4gT3IgYXJlIHRoZXJlIHNvbWUgcGxhdGZvcm1zIHRoYXQgY29uZmlndXJlIHRoZSBi
cmlkZ2Ugc28gaXQgZG9lc24ndA0KPiBhZHZlcnRpc2UgTVNJLVggYXQgYWxsLCB3aGlsZSBvdGhl
ciBwbGF0Zm9ybXMgY29uZmlndXJlIGl0IHNvIGl0DQo+ICpkb2VzKiBhZHZlcnRpc2UgTVNJLVg/
DQo+IA0KVGhlIE1TSS14IGNhcGFiaWxpdHkgaXNuJ3Qgc3VwcG9ydGVkIGZvciB0aGlzIHNwZWNp
ZmljIGhvc3QgYnJpZGdlDQooWzFjMzY6MDAzMV0pLiBPbiBzb21lIHBsYXRmb3JtcywgaXQgaXMg
Y29uZmlndXJlZCB0byBub3QgYWR2ZXJ0aXNlIHRoZQ0KY2FwYWJpbGl0eSBhdCBhbGwsIHdoaWxl
IG9uIG90aGVycyBpdCAobWlzdGFrZW5seSkgZG9lcyBhZHZlcnRpc2UgaXQuDQoNCkkndmUgdXBk
YXRlZCB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gYmUgbW9yZSBleHBsaWNpdC4NCg0KPiBJZiB0aGVy
ZSdzIGEgbGluZSBvciB0d28gb2YgZGlhZ25vc3RpY3MgZnJvbSB0aGUgY3Jhc2ggeW91IGNvdWxk
DQo+IGluY2x1ZGUgaGVyZSwgdGhhdCB3b3VsZCBoZWxwIHBlb3BsZSB3aG8gZW5jb3VudGVyIHRo
ZSBjcmFzaCBmaW5kDQo+IHRoZSBzb2x1dGlvbi4NCj4gDQpTdXJlLCBJJ2xsIGFkZCBhIHBhcnRp
YWwgc3RhY2t0cmFjZSAoYSBiaXQgbW9yZSB0aGFuIGEgY291cGxlIG9mIGxpbmVzLA0KYnV0IEkg
ZmVlbCBpdCB3aWxsIGJlIHRvbyBhbWJpZ3VvdXMgb3RoZXJ3aXNlKS4NCg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEpvbmF0aGFuIENob2Nyb24gPGpvbm55Y0BhbWF6b24uY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3BjaS9xdWlya3MuYyB8IDggKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9xdWly
a3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQo+ID4gaW5kZXggMTE4NTBiMDMwNjM3Li4wZmI3
MGQ3NTU5NzcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMNCj4gPiArKysg
Yi9kcml2ZXJzL3BjaS9xdWlya3MuYw0KPiA+IEBAIC0yOTI1LDYgKzI5MjUsMTQgQEANCj4gPiBE
RUNMQVJFX1BDSV9GSVhVUF9GSU5BTChQQ0lfVkVORE9SX0lEX0FUVEFOU0lDLCAweDEwYTEsDQo+
ID4gIAkJCXF1aXJrX21zaV9pbnR4X2Rpc2FibGVfcWNhX2J1Zyk7DQo+ID4gIERFQ0xBUkVfUENJ
X0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfQVRUQU5TSUMsIDB4ZTA5MSwNCj4gPiAgCQkJcXVp
cmtfbXNpX2ludHhfZGlzYWJsZV9xY2FfYnVnKTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHF1
aXJrX2FsX21zaV9kaXNhYmxlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ID4gK3sNCj4gPiArCWRl
di0+bm9fbXNpID0gMTsNCj4gPiArCWRldl93YXJuKCZkZXYtPmRldiwgIkFubmFwdXJuYSBMYWJz
IHBjaWUgcXVpcmsgLSBkaXNhYmxpbmcNCj4gPiBNU0lcbiIpOw0KPiANCj4gcy9wY2llL1BDSWUv
IGluIEVuZ2xpc2ggdGV4dCwgY29tbWVudHMsIHByaW50ayBzdHJpbmdzLCBldGMuDQo+IA0KQWNr
Lg0KDQo+IEFjdHVhbGx5LCBJIHRoaW5rIHRoZSB3aG9sZSAiQW5uYXB1cm5hIExhYnMgcGNpZSBx
dWlyayIgcGFydCBpcw0KPiBwcm9iYWJseSB1bm5lY2Vzc2FyeSwgc2luY2Ugd2UgY2FuIGlkZW50
aWZ5IHRoZSBkZXZpY2UgdmlhIHRoZQ0KPiBkZXZfcHJpbnRrKCkgaW5mby4NCj4gDQpBY2suDQoN
Cj4gU3BlYWtpbmcgb2Ygd2hpY2gsIHlvdSBjYW4gdXNlICJwY2lfd2FybihkZXYpIiBoZXJlIHRv
IGJlIGNvbnNpc3RlbnQNCj4gd2l0aCB0aGUgcmVzdCBvZiB0aGUgZmlsZS4NCj4gDQpBY2suDQoN
Cj4gPiArfQ0KPiA+ICtERUNMQVJFX1BDSV9GSVhVUF9DTEFTU19GSU5BTChQQ0lfVkVORE9SX0lE
X0FNQVpPTl9BTk5BUFVSTkFfTEFCUywNCj4gPiAweDAwMzEsDQo+ID4gKwkJCSAgICAgIFBDSV9D
TEFTU19CUklER0VfUENJLCA4LA0KPiA+IHF1aXJrX2FsX21zaV9kaXNhYmxlKTsNCj4gDQo+IFdo
eSBkbyB5b3UgdXNlIHRoZSBjbGFzcyBmaXh1cCBoZXJlIGluc3RlYWQgb2YgdGhlIHNpbXBsZXIN
Cj4gREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoKT8gIFJlcXVpcmluZyB0aGUgY2xhc3MgdG8gbWF0
Y2gNCj4gUENJX0NMQVNTX0JSSURHRV9QQ0kgc3VnZ2VzdHMgdGhhdCB0aGVyZSBtYXkgYmUgb3Ro
ZXIgWzFjMzY6MDAzMV0NCj4gZGV2aWNlcyB0aGF0IGFyZSBub3QgUm9vdCBQb3J0cy4gIElmIHRo
YXQncyB0aGUgY2FzZSwgcGxlYXNlIG1lbnRpb24NCj4gaXQgc28gaXQncyBjbGVhciB3aHkgd2Ug
bmVlZCBERUNMQVJFX1BDSV9GSVhVUF9DTEFTU19GSU5BTCgpLiAgSWYNCj4gbm90LA0KPiBqdXN0
IHVzZSBERUNMQVJFX1BDSV9GSVhVUF9GSU5BTCgpLg0KPiANClRoaXMgaXMgaW5kZWVkIHRoZSBj
YXNlLiBXaGF0IGRvIHlvdSBzYXkgYWJvdXQgYWRkaW5nIHRoZSBmb2xsb3dpbmcNCmNvbW1lbnQg
YmVmb3JlIHRoZSBmdW5jdGlvbidzIGRlZmluaXRpb246DQovKg0KICogQW1hem9uJ3MgQW5uYXB1
cm5hIExhYnMgMWMzNjowMDMxIFJvb3QgUG9ydHMgZG9uJ3Qgc3VwcG9ydCBNU0ktWCwgc28NCml0
DQogKiBzaG91bGQgYmUgZGlzYWJsZWQgb24gcGxhdGZvcm1zIHdoZXJlIHRoZSBkZXZpY2UgKG1p
c3Rha2VubHkpDQphZHZlcnRpc2VzIGl0Lg0KICoNCiAqIFRoZSAwMDMxIGRldmljZSBpZCBpcyBy
ZXVzZWQgZm9yIG90aGVyIG5vbiBSb290IFBvcnQgZGV2aWNlIHR5cGVzLA0KICogdGhlcmVmb3Jl
IHRoZSBxdWlyayBpcyByZWdpc3RlcmVkIGZvciB0aGUgUENJX0NMQVNTX0JSSURHRV9QQ0kgY2xh
c3MNCm9ubHkuDQogKi8NCg0KPiAgI2VuZGlmIC8qIENPTkZJR19QQ0lfTVNJICovDQogDQogLyoN
Ci0tIA0KMi4xNy4xDQoNCg0K
