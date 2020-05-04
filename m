Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E46B1C35BA
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 11:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgEDJaY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 05:30:24 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37578 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728332AbgEDJaY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 05:30:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1B3E44C83F;
        Mon,  4 May 2020 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1588584617; x=
        1590399018; bh=l8YyxS9uDlCI9MCFiztVWP9X9eXKGKHr5sjTpETxpzw=; b=I
        7bIOrPEx671evbELDoyyA1KtP6IE63urHYA1LvEBSyBBSKsAzsrrCloZOKNqoUjM
        joz/KUvnD8I2rGJTM/OKxCF/pTIToxYFBx+WTg66Iotn43qlWoko3hrAXaWauOly
        8ilim+y6Z6v3iQ8MnVT/tVfXR16MwX4fjM0dPBZTKU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jLyhXI_zpbzk; Mon,  4 May 2020 12:30:17 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A87B64C83D;
        Mon,  4 May 2020 12:30:17 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (172.17.10.102) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 4 May 2020 12:30:18 +0300
Received: from T-EXCH-02.corp.yadro.com ([fe80::487b:cc6b:e67a:919]) by
 T-EXCH-02.corp.yadro.com ([fe80::487b:cc6b:e67a:919%14]) with mapi id
 15.01.0669.032; Mon, 4 May 2020 12:30:18 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "rajatja@google.com" <rajatja@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>, "sr@denx.de" <sr@denx.de>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v8 00/24] PCI: Allow BAR movement during boot and hotplug
Thread-Topic: [PATCH v8 00/24] PCI: Allow BAR movement during boot and hotplug
Thread-Index: AQHWHMELxA8G8DuaFUSceLQx32lhaqiOTciAgAkzqYA=
Date:   Mon, 4 May 2020 09:30:18 +0000
Message-ID: <5278f3e1fbdafa92b4b44effb64c443bbbf0852e.camel@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
         <7cd27165-0d30-0ef1-dde3-104c9878bd37@amd.com>
In-Reply-To: <7cd27165-0d30-0ef1-dde3-104c9878bd37@amd.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <65DA2CE39FFD104BB5C2CC8C4BDD3A16@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gQ2hyaXN0aWFuLA0KDQpPbiBUdWUsIDIwMjAtMDQtMjggYXQgMTQ6NTkgKzAyMDAsIENo
cmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+IFdlbGwgdGhhdCBpcyBhIHJlYWxseSBuaWNlIHN1cnBy
aXNlLiBKdXN0IEZZSSB0aGUgc2l0dWF0aW9uIHdpdGggR1BVcw0KPiBpcyANCj4gZXNzZW50aWFs
bHkgdGhpczoNCj4gDQo+IGEpIFRoZSBCQVIgdG8gYWNjZXNzIHZpZGVvIG1lbW9yeSB3aXRoIHRo
ZSBDUFUgaXMgYnkgZGVmYXVsdCBvbmx5DQo+IDI1Nk1CIA0KPiBpbiBzaXplIGZvciBiYWNrd2Fy
ZCBjb21wYXRpYmlsaXR5IHdpdGggMzJiaXQgV2luZG93cyA3IGFuZCBvbGRlci4NCj4gDQo+IGIp
IE1vZGVybiBHUFVzIGVhc2lseSBoYXZlIDE2R0Igb2YgdmlkZW8gbWVtb3J5LCBidXQgbW9zdCBv
ZiB0aGF0DQo+IHVzZWQgDQo+IHRvIGJlIGFjY2Vzc2VkIG9ubHkgcmFyZWx5IGJ5IHRoZSBDUFUu
IFVuZm9ydHVuYXRlbHkgdGhpcyBoYXMNCj4gY2hhbmdlZCANCj4gcmVjZW50bHkgYnkgZ2V0dGlu
ZyBtb3JlIG1vZGVybiBncmFwaGljcyBBUElzIGluIHVzZXJzcGFjZSAoVnVsa2FuKS4NCj4gDQo+
IGMpIEJvdGggTlZpZGlhIGFzIHdlbGwgYXMgQU1EIHVzZWQgdG8gaGF2ZSBhIG1lY2hhbmlzbSB0
byBtYXANCj4gZGlmZmVyZW50IA0KPiBzdHVmZiBpbnRvIHRoZSAyNTZNQiB3aW5kb3csIGJ1dCBB
TUQgZHJvcHBlZCB0aGlzIGFiaWxpdHkgcXVpdGUgc29tZSANCj4gdGltZSBhZ28gYmVjYXVzZSBp
dCB3YXMgcmF0aGVyIGluZWZmaWNpZW50Lg0KPiANCj4gZCkgSW5zdGVhZCBmb3IgaGFyZCBvZiB0
aGUgbGFzdCA1IHllYXJzIEFNRCBpbXBsZW1lbnRzIHRoZSBQQ0kNCj4gc3RhbmRhcmQgDQo+IGZv
ciBkeW5hbWljIEJBUiByZXNpemluZy4gU28gd2hhdCB3ZSBkbyBpcyB0byBleHRlbmQgdGhlIDI1
Nk1CIEJBUg0KPiBpbnRvIA0KPiAxNkdCIChvciB3aGF0ZXZlciBpcyBuZWVkZWQpIG9uY2UgdGhl
IE9TIGlzIHN0YXJ0ZWQgYW5kIHRoZSBkcml2ZXINCj4gbG9hZHMuDQo+IA0KPiBUaGUgcHJvYmxl
bSB3aXRoIHRoaXMgYXBwcm9hY2ggaXMgdGhhdCBzb21ldGltZXMgYnJpZGdlcyBjYW4ndCBiZSAN
Cj4gcmVjb25maWd1cmVkIGFuZCBCQVJzIHJlc2l6ZWQgYmVjYXVzZSB3ZSBoYXZlIG90aGVyIEJB
UnMgY3VycmVudGx5DQo+IGluIA0KPiB1c2UgdW5kZXIgdGhlIHNhbWUgYnJpZGdlLg0KPiANCj4g
U28gbG9uZyBzdG9yeSBzaG9ydCB5b3UgaGF2ZSBmaXhlZCBteSBCQVIgcmVzaXppbmcgcHJvYmxl
bSB3aXRoIHRoaXMgDQo+IHBhdGNoc2V0IGFzIHdlbGwgOkQNCj4gDQoNClRoYW5rcyBmb3IgaW50
cm9kdWNpbmcgdG8gdGhpcyBwcm9ibGVtLCBpdCBpcyBub3QgeWV0IGNvdmVyZWQgYnkNCnRoaXMg
Y29kZSwgc28gSSdsbCBtb2RpZnkgdGhlIHBjaV9yZXNpemVfcmVzb3VyY2UoKTogbGV0IGl0IHRy
eSBhcw0KaXQgZG9lcyBub3csIGFuZCBpZiB0aGF0IGRpZG4ndCB3b3JrIC0gdHJ5IHBjaV9yZXNj
YW5fYnVzKCksIHdoaWNoDQptb3ZlcyBCQVJzLg0KDQpUbyB0ZXN0IHRoaXMsIGRvIEkgbmVlZCB0
byB0cmlnZ2VyIGEgQkFSIHJlc2l6aW5nIG1hbnVhbGx5LCBvcg0KZHJtL2FtZGdwdSB3aWxsIGRv
IGl0IGF1dG9tYXRpY2FsbHkgZHVyaW5nIGluaXQ/DQoNCk1heSB0aGVzZSByZXNpemVkIEJBUiBj
aGFuZ2UgdGhlaXIgc3RhcnQgYWRkcmVzcyBkdXJpbmcgaW5pdD8NCg0KPiBBbSAyNy4wNC4yMCB1
bSAyMDoyMyBzY2hyaWViIFNlcmdlaSBNaXJvc2huaWNoZW5rbzoNCj4gPiAuLi4NCj4gPiANCj4g
PiBEcml2ZXJzIGluZGljYXRlIHRoZWlyIHN1cHBvcnQgb2YgdGhlIGZlYXR1cmUgYnkgaW1wbGVt
ZW50aW5nIHRoZQ0KPiA+IG5ldyBob29rcw0KPiA+IC5yZXNjYW5fcHJlcGFyZSgpIGFuZCAucmVz
Y2FuX2RvbmUoKSBpbiB0aGUgc3RydWN0IHBjaV9kcml2ZXIuIElmIGENCj4gPiBkcml2ZXINCj4g
PiBkb2Vzbid0IHlldCBzdXBwb3J0IHRoZSBmZWF0dXJlLCBCQVJzIG9mIGl0cyBkZXZpY2VzIHdp
bGwgYmUNCj4gPiBjb25zaWRlcmVkIGFzDQo+ID4gaW1tb3ZhYmxlIGFuZCBoYW5kbGVkIGluIHRo
ZSBzYW1lIHdheSBhcyByZXNvdXJjZXMgd2l0aCB0aGUNCj4gPiBQQ0lfRklYRUQgZmxhZzoNCj4g
PiB0aGV5IGFyZSBndWFyYW50ZWVkIHRvIHJlbWFpbiB1bnRvdWNoZWQuDQo+IA0KPiBDb3VsZCB3
ZSBsZXQgcmVzY2FuX3ByZXBhcmUoKSBvcHRpb25hbGx5IHJldHVybiBhbiBlcnJvciBhbmQgdGhl
biANCj4gY29uc2lkZXIgdGhlIEJBUnMgaW4gcXVlc3Rpb24gbm90IG1vdmFibGUgZm9yIHRoZSBj
dXJyZW50IHJlc2Nhbj8gDQo+IEFsdGVybmF0aXZlbHkgd291bGQgaXQgYmUgYWxsb3dlZCBpbiB0
aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIA0KPiByZXNjYW5fcHJlcGFyZSgpIGNhbGxiYWNrIHRv
IHVwZGF0ZSB0aGUgUENJX0ZJWEVEIGZsYWdzIG9uIHRoZSBCQVJzPw0KPiANCj4gUHJvYmxlbSBp
cyB0aGF0IHdlIGNhbid0IGtub3cgYmVmb3JlaGFuZCBpZiBhIEJBUiBpcyBjdXJyZW50bHkgaW4g
dXNlDQo+IG9yIA0KPiBub3Qgb3IgaWYgd2UgY2FuIGJsb2NrIHRoZSB1c2VzIHVudGlsIHRoZSBy
ZXNjYW4gaXMgY29tcGxldGVkLg0KDQpJIGd1ZXNzIG9uZSBtb3JlIG9wdGlvbmFsIGhvb2sgbWF5
IGJlIGFkZGVkIHRvIHRoZSBwY2lfZHJpdmVyOg0KDQogIGJvb2wgKCpiYXJfZml4ZWQpKHN0cnVj
dCBwY2lfZGV2ICpkZXYsIHN0cnVjdCByZXNvdXJjZSAqcmVzKTsNCg0KU28gYSBkcml2ZXIgY2Fu
IG1hcmsgc29tZSBCQVJzIGFzIGZpeGVkLCBhbmQgc29tZSAtIGFzIG1vdmFibGUsIGluDQpydW50
aW1lLCBkZXBlbmRpbmcgb24gY3VycmVudCBjb25kaXRpb25zLg0KDQpJZiByZXNjYW5fcHJlcGFy
ZSgpIGFuZCByZXNjYW5fZG9uZSgpIGhvb2tzIGFyZSBzZXQsIGJ1dCBiYXJfZml4ZWQoKQ0KaXNu
J3QsIGNvbnNpZGVyIGV2ZXJ5IEJBUiBhcyBtb3ZhYmxlLiBJZiBiYXJfZml4ZWQoKSBpcyBzZXQg
YW5kIHJldHVybnMNCmZhbHNlLCB0aGUgZHJpdmVyIG11c3Qgbm90IHVzZSBpdCBiZXR3ZWVuIHJl
c2Nhbl9wcmVwYXJlKCkgYW5kDQpyZXNjYW5fZG9uZSgpLg0KDQpCZXN0IHJlZ2FyZHMsDQpTZXJn
ZQ0K
