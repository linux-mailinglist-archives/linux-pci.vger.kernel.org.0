Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080BA14F017
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 16:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgAaPsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 10:48:52 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:39138 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728974AbgAaPsw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 10:48:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6C38E479A4;
        Fri, 31 Jan 2020 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1580485729; x=
        1582300130; bh=GlEsX7Vr+IgTfFKNu7SXeedV0/G9x7b9zPFcwN1peZs=; b=l
        jUpTkI7JSbD5H7klJZ2tORj74Lfsydx4zB640fV7Q3mGMauh5r7Rzem9DHgg/G8e
        gMMXyuJXA9sDg5BOCP7uuX++I/xZyEQkTVhymoW/UISD9dsQypg3EKkVa7cV05vr
        wbF9vx/Kesx/23PJ5o11sBd0NnVlyS+DvbnhjSW750=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aCXnRpbS9bfs; Fri, 31 Jan 2020 18:48:49 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 02F7A4799F;
        Fri, 31 Jan 2020 18:48:49 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (172.17.10.102) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 31 Jan 2020 18:48:48 +0300
Received: from T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23]) by
 T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23%14]) with mapi id
 15.01.0669.032; Fri, 31 Jan 2020 18:48:48 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH v7 20/26] PNP: Don't reserve BARs for PCI when enabled
 movable BARs
Thread-Topic: [PATCH v7 20/26] PNP: Don't reserve BARs for PCI when enabled
 movable BARs
Thread-Index: AQHV1rj44by8f/x6+0yfyZX82BRb86gDhOSAgAE3OIA=
Date:   Fri, 31 Jan 2020 15:48:48 +0000
Message-ID: <d744d743a8a2512ebcd31818cdc76400cfd0086e.camel@yadro.com>
References: <20200130211453.GA127287@google.com>
In-Reply-To: <20200130211453.GA127287@google.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7B5861FCC9B384393B05276D4A4F5C9@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gQmpvcm4sDQoNCk9uIFRodSwgMjAyMC0wMS0zMCBhdCAxNToxNCAtMDYwMCwgQmpvcm4g
SGVsZ2FhcyB3cm90ZToNCj4gT24gV2VkLCBKYW4gMjksIDIwMjAgYXQgMDY6Mjk6MzFQTSArMDMw
MCwgU2VyZ2VpIE1pcm9zaG5pY2hlbmtvDQo+IHdyb3RlOg0KPiA+IFdoZW4gdGhlIE1vdmFibGUg
QkFScyBmZWF0dXJlIGlzIHN1cHBvcnRlZCwgdGhlIFBDSSBzdWJzeXN0ZW0gaXMNCj4gPiBhYmxl
IHRvDQo+ID4gZGlzdHJpYnV0ZSBleGlzdGluZyBCQVJzIGFuZCBhbGxvY2F0ZSB0aGUgbmV3IG9u
ZXMgaXRzZWxmLCB3aXRob3V0DQo+ID4gbmVlZCB0bw0KPiA+IHJlc2VydmUgZ2FwcyBieSBCSU9T
Lg0KPiA+IA0KPiA+IENDOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRl
bC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2VyZ2VpIE1pcm9zaG5pY2hlbmtvIDxzLm1pcm9z
aG5pY2hlbmtvQHlhZHJvLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wbnAvc3lzdGVtLmMg
fCA2ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG5wL3N5c3RlbS5jIGIvZHJpdmVycy9wbnAvc3lzdGVt
LmMNCj4gPiBpbmRleCA2OTUwNTAzNzQxZWIuLjE2Y2QyNjBhNjA5ZCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BucC9zeXN0ZW0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvcG5wL3N5c3RlbS5jDQo+
ID4gQEAgLTEyLDYgKzEyLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvcG9ydC5oPg0KPiA+ICANCj4gPiBAQCAtNTgsNiAr
NTksMTEgQEAgc3RhdGljIHZvaWQgcmVzZXJ2ZV9yZXNvdXJjZXNfb2ZfZGV2KHN0cnVjdA0KPiA+
IHBucF9kZXYgKmRldikNCj4gPiAgCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiA+ICAJaW50IGk7
DQo+ID4gIA0KPiA+ICsjaWZkZWYgQ09ORklHX1BDSQ0KPiA+ICsJaWYgKHBjaV9jYW5fbW92ZV9i
YXJzKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArI2VuZGlmDQo+IA0KPiBJIGRvbid0IHVuZGVyc3Rh
bmQgdGhpcy4gIFRoZSByZWFzb24gdGhpcyBmdW5jdGlvbiBleGlzdHMgaXMgc28gd2UNCj4ga2Vl
cCB0cmFjayBvZiB0aGUgcmVzb3VyY2VzIGNvbnN1bWVkIGJ5IFBOUCBkZXZpY2VzIGFuZCB3ZSBj
YW4ga2VlcA0KPiBmcm9tIGFzc2lnbmluZyB0aG9zZSByZXNvdXJjZXMgdG8gb3RoZXIgdGhpbmdz
IGxpa2UgUENJIGRldmljZXMuDQo+IA0KPiBBZG1pdHRlZGx5IHdlIGN1cnJlbnRseSBvbmx5IGRv
IHRoaXMgZm9yIFBOUDBDMDEgYW5kIFBOUDBDMDIgZGV2aWNlcywNCj4gYnV0IHdlIHJlYWxseSBz
aG91bGQgZG8gaXQgZm9yIGFsbCBQTlAgZGV2aWNlcy4NCj4gDQo+IFdoeSBkb2VzIE1vdmFibGUg
QkFScyBtZWFuIHRoYXQgd2Ugbm8gbG9uZ2VyIG5lZWQgdGhpcyBpbmZvcm1hdGlvbj8NCj4gVGhl
IHdob2xlIHBvaW50IGlzIHRoYXQgdGhpcyBpbmZvcm1hdGlvbiBpcyBuZWVkZWQgKmR1cmluZyog
UENJDQo+IHJlc291cmNlIGFsbG9jYXRpb24sIHNvIEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgaWRl
YSB0aGF0ICJiZWNhdXNlIHRoZQ0KPiBQQ0kgc3Vic3lzdGVtIGlzIGFibGUgdG8gZGlzdHJpYnV0
ZSBleGlzdGluZyBCQVJzIGFuZCBhbGxvY2F0ZSB0aGUNCj4gbmV3DQo+IG9uZXMgaXRzZWxmIiwg
d2UgZG9uJ3QgbmVlZCB0byBrbm93IGFib3V0IFBOUCByZXNvdXJjZXMgdG8gYXZvaWQuDQo+IA0K
DQpPaC4gSSd2ZSBtYWRlIHRoaXMgcGF0Y2ggaW4gYXNzdW1wdGlvbiB0aGF0IG5vbi1QQ0kgUE5Q
IGRldmljZXMgc2hvdWxkDQpub3QgcmVzaWRlIGluIHRoZSBQQ0kgYWRkcmVzcyBzcGFjZSwgYW5k
IFBDSSBQTlAgZGV2aWNlcyBiZWhhdmUgbGlrZQ0KdXN1YWwgUENJIGRldmljZXMgLSB3aXRoIEJB
UnMgaGFuZGxlZCBieSB0aGUgY29tbW9uIFBDSSBzdWJzeXN0ZW0uDQoNCkRvIEkgdW5kZXJzdGFu
ZCBjb3JyZWN0bHkgYWZ0ZXIgZGlnZ2luZyBhIGJpdCBpbnRvIGRyaXZlcnMvcG5wLCB0aGF0DQpz
b21lIG9mIHRoZXNlIHJlc291cmNlcyBhcmUgc29tZSBraW5kIG9mICJpbnZpc2libGUiIEJBUnMs
IHdoaWNoIGFyZQ0KdXNlZCBieSBkcml2ZXJzLCBidXQgdGhlIFBDSSBzdWJzeXN0ZW0gY2FuJ3Qg
InNlZSIgdGhlbSwgc28gdGhhdCdzIHdoeQ0KdGhlIFBOUCByZXNlcnZlcyB0aGVtPw0KDQpJbiB0
aGlzIGNhc2UgSSBuZWVkIGp1c3QgdG8gZGlzY2FyZCB0aGlzIHBhdGNoIGFuZCB0byBtb2RpZnkg
dGhlDQpwY2lfYnVzX3JlbGVhc2Vfcm9vdF9icmlkZ2VfcmVzb3VyY2VzKCkgYWRkZWQgaW4gcGF0
Y2ggMDYvMjYgLSByZW1vdmUNCnRoZSBwY2lfYnVzX2Zvcl9lYWNoX3Jlc291cmNlKHJvb3RfYnVz
LCByLCBpKSBibG9jayB0aGVyZSwgd2hpY2gNCnJlbGVhc2VzIHN1Y2ggbm9uLUJBUiByZXNvdXJz
ZXMuIEkndmUganVzdCBjaGVja2VkIHRoYXQgaXQgd29ya3MsIHNvDQp0aGUgbmV4dCB2ZXJzaW9u
IC0gdjggLSBvZiB0aGlzIHBhdGNoc2V0IHdpbGwgYmUgYSBiaXQgbGlnaHRlci4gVGhhbmsNCnlv
dSBmb3IgcG9pbnRpbmcgdGhhdCBvdXQhDQoNCkJlc3QgcmVnYXJkcywNClNlcmdlDQoNCg0KPiA+
ICAJZm9yIChpID0gMDsgKHJlcyA9IHBucF9nZXRfcmVzb3VyY2UoZGV2LCBJT1JFU09VUkNFX0lP
LCBpKSk7DQo+ID4gaSsrKSB7DQo+ID4gIAkJaWYgKHJlcy0+ZmxhZ3MgJiBJT1JFU09VUkNFX0RJ
U0FCTEVEKQ0KPiA+ICAJCQljb250aW51ZTsNCj4gPiAtLSANCj4gPiAyLjI0LjENCj4gPiANCg==
