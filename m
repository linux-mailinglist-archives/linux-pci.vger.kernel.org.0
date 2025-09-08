Return-Path: <linux-pci+bounces-35667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F11BDB48DED
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 14:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E151B25B21
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4441B302CAB;
	Mon,  8 Sep 2025 12:46:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914F301000;
	Mon,  8 Sep 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335585; cv=none; b=VIXo0EVrJEg1arCEYjUtz+Uu1yUnk2QHz6AE1oZoaPgfbeaVrsFaQrupko5oX3OGpmzX/jydvAsaTxwuJVYxtRhKNLrqNZM256/WXZcTtCK5xjquJkrQn/aDk7IjN9dkzL2gHwCLpBjBDRjEsnUQFmhax3I/vaZn5myTpjotk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335585; c=relaxed/simple;
	bh=afOs1M4GZPYUCn+Vya0bO80XIj0JApTsibTr78PESvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhSVIWEGke+Ml71hwgpgOPkKeW5Y3w4PBTJGn41zZw6KvPFUqcnw67nIe/5hzFp1/LgKlJhe93biyoY4uYR7YA2QrALZ8jEUPYTyiGrz8diN+q/H5gkJLyJUOohaKL7nUl3ZNTjTrMAp5y+JJ03J5v6FyFJu+ORoGVoHRgjN7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cL5hc06nVz2TT8P;
	Mon,  8 Sep 2025 20:23:28 +0800 (CST)
Received: from kwepemf100016.china.huawei.com (unknown [7.202.181.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 84058140144;
	Mon,  8 Sep 2025 20:26:41 +0800 (CST)
Received: from kwepemh100012.china.huawei.com (7.202.181.97) by
 kwepemf100016.china.huawei.com (7.202.181.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 20:26:41 +0800
Received: from kwepemh100012.china.huawei.com ([7.202.181.97]) by
 kwepemh100012.china.huawei.com ([7.202.181.97]) with mapi id 15.02.1544.011;
 Mon, 8 Sep 2025 20:26:41 +0800
From: "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, leijitang
	<leijitang@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "christian.brauner@ubuntu.com"
	<christian.brauner@ubuntu.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBQQ0k6IEZpeCB0aGUgaW50IG92ZXJmbG93IGluIHBy?=
 =?gb2312?B?b2NfYnVzX3BjaV93cml0ZSgp?=
Thread-Topic: [PATCH] PCI: Fix the int overflow in proc_bus_pci_write()
Thread-Index: AQHcHlLCxNjG0vq+ekSoebDAQnqcsLSEijIAgASwClA=
Date: Mon, 8 Sep 2025 12:26:41 +0000
Message-ID: <d156ebaee8ac4491876cdf75d8847fe1@huawei.com>
References: <20250905104730.2833673-1-bobo.shaobowang@huawei.com>
 <20250905204848.GA1322742@bhelgaas>
In-Reply-To: <20250905204848.GA1322742@bhelgaas>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogQmpvcm4gSGVsZ2FhcyBbbWFpbHRv
OmhlbGdhYXNAa2VybmVsLm9yZ10NCj4gt6LLzcqxvOQ6IDIwMjXE6jnUwjbI1SA0OjQ5DQo+IMrV
vP7IyzogV2FuZ3NoYW9ibyAoYm9ibykgPGJvYm8uc2hhb2Jvd2FuZ0BodWF3ZWkuY29tPg0KPiCz
rcvNOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsZWlq
aXRhbmcNCj4gPGxlaWppdGFuZ0BodWF3ZWkuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgY2hyaXN0aWFuLmJyYXVuZXJAdWJ1
bnR1LmNvbTsNCj4gbGludXgtaGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZw0KPiDW98ziOiBSZTog
W1BBVENIXSBQQ0k6IEZpeCB0aGUgaW50IG92ZXJmbG93IGluIHByb2NfYnVzX3BjaV93cml0ZSgp
DQo+IA0KPiBbK2NjIGxpbnV4LWhhcmRlbmluZ10NCj4gDQo+IE9uIEZyaSwgU2VwIDA1LCAyMDI1
IGF0IDA2OjQ3OjMwUE0gKzA4MDAsIFdhbmcgU2hhb0JvIHdyb3RlOg0KPiA+IEZvbGxvd2luZyB0
ZXN0Y2FzZSBjYW4gdHJpZ2dlciBhIHNvZnRsb2NrdXAgQlVHLg0KPiA+IHN5c2NhbGwoX19OUl9w
d3JpdGV2LCAvKmZkPSovLi4uLCAvKnZlYz0qLy4uLiwgLyp2bGVuPSovLi4uLA0KPiA+ICAgICAg
ICAgLypwb3NfbD0qLzB4ODAwMTAwMDAsIC8qcG9zX2g9Ki8weDEwMCk7DQo+ID4NCj4gPiB3YXRj
aGRvZzogQlVHOiBzb2Z0IGxvY2t1cCAtIENQVSMxMSBzdHVjayBmb3IgMjJzISBbdGVzdDo1Mzdd
IE1vZHVsZXMNCj4gPiBsaW5rZWQgaW46DQo+ID4gQ1BVOiAxMSBQSUQ6IDUzNyBDb21tOiB0ZXN0
IE5vdCB0YWludGVkIDUuMTAuMCsgIzY3IEhhcmR3YXJlIG5hbWU6DQo+ID4gUUVNVSBTdGFuZGFy
ZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xMy4wLTF1YnVudHUxLjENCj4gPiAw
NC8wMS8yMDE0DQo+ID4gUklQOiAwMDEwOnBjaV91c2VyX3dyaXRlX2NvbmZpZ19kd29yZCsweDY3
LzB4YzANCj4gPiBDb2RlOiAwMCAwMCA0NCA4OSBlMiA0OCA4YiA4NyBlMCAwMCAwMCAwMCA0OCA4
YiA0MCAyMCBlOCA5ZSA1NCA3ZSAwMA0KPiA+IDQ4IGM3IGM3IDIwIDQ4IGEyIDgzIDQxIDg5IGMw
IGM2IDA3IDAwIDBmIDFmIDQwIDAwIGZiIDQ1IDg1IGMwIDw3ZT4gMTINCj4gPiA0MSA4ZCA4MCA3
ZiBmZiBmZiBmZiA0MSBiOCBkZSBmZiBmZiBmZiA4MyBmOCAwOCA3NiAwYyA1YiA0NA0KPiA+IFJT
UDogMDAxODpmZmZmYzkwMDAxNmMzZDMwIEVGTEFHUzogMDAwMDAyNDYNCj4gPiBSQVg6IDAwMDAw
MDAwMDAwMDAwMDAgUkJYOiBmZmZmODg4MDQyMDU4MDAwIFJDWDoNCj4gMDAwMDAwMDAwMDAwMDAw
NQ0KPiA+IFJEWDogZmZmZjg4ODAwNDA1OGEwMCBSU0k6IDAwMDAwMDAwMDAwMDAwNDYgUkRJOiBm
ZmZmZmZmZjgzYTI0ODIwDQo+ID4gUkJQOiAwMDAwMDAwMDAwMDAwMDAwIFIwODogMDAwMDAwMDAw
MDAwMDAwMCBSMDk6DQo+IDAwMDAwMDAwMDAwMDAwMDENCj4gPiBSMTA6IGZmZmY4ODgwMDVjMjU5
MDAgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjoNCj4gMDAwMDAwMDA4MGM0ODY4MA0KPiA+IFIx
MzogMDAwMDAwMDAyMGMzODY4NCBSMTQ6IDAwMDAwMDAwODAwMTAwMDAgUjE1Og0KPiBmZmZmODg4
MDA0NzAyNDA4DQo+ID4gRlM6ICAwMDAwMDAwMDNhZTkxODgwKDAwMDApIEdTOmZmZmY4ODgwMWYz
ODAwMDAoMDAwMCkNCj4gPiBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+ID4gQ1M6ICAwMDEwIERT
OiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiA+IENSMjogMDAwMDAwMDAy
MGMwMDAwMCBDUjM6IDAwMDAwMDAwMDZmMmMwMDAgQ1I0Og0KPiAwMDAwMDAwMDAwMDAwNmUwDQo+
ID4gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6DQo+IDAw
MDAwMDAwMDAwMDAwMDANCj4gPiBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZm
ZmUwZmYwIERSNzoNCj4gMDAwMDAwMDAwMDAwMDQwMCBDYWxsDQo+ID4gVHJhY2U6DQo+ID4gIHBy
b2NfYnVzX3BjaV93cml0ZSsweDIyYy8weDI2MA0KPiA+ICBwcm9jX3JlZ193cml0ZSsweDQwLzB4
OTANCj4gPiAgZG9fbG9vcF9yZWFkdl93cml0ZXYucGFydC4wKzB4OTcvMHhjMA0KPiA+ICBkb19p
dGVyX3dyaXRlKzB4ZjYvMHgxNTANCj4gPiAgdmZzX3dyaXRldisweDk3LzB4MTMwDQo+ID4gID8g
ZmlsZXNfY2dyb3VwX2FsbG9jX2ZkKzB4NWMvMHg3MA0KPiA+ICA/IGRvX3N5c19vcGVuYXQyKzB4
MWM5LzB4MzIwDQo+ID4gIF9feDY0X3N5c19wd3JpdGV2KzB4YjEvMHgxMDANCj4gPiAgZG9fc3lz
Y2FsbF82NCsweDJiLzB4NDANCj4gPiAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4
NmMvMHhkNg0KPiA+DQo+ID4gVGhlIHBvc19sIHBhcmFtZXRlciBmb3IgcHdyaXRldiBzeXNjYWxs
IG1heSBiZSBhbiBpbnRlZ2VyIG5lZ2F0aXZlDQo+ID4gdmFsdWUsIHdoaWNoIHdpbGwgbWFrZSB0
aGUgdmFyaWFibGUgcG9zIGluIHByb2NfYnVzX3BjaV93cml0ZSgpDQo+ID4gbmVnYXRpdmUgYW5k
IHZhcmlhYmxlIGNudCBhIHZlcnkgbGFyZ2UgbnVtYmVyLg0KPiANCj4gU291bmRzIGxpa2UgYSBw
cm9ibGVtOyBoYXZlIHlvdSBsb29rZWQgZm9yIHNpbWlsYXIgcHJvYmxlbXMgaW4gb3RoZXINCj4g
LnByb2Nfd3JpdGUoKSBhbmQgLnByb2NfcmVhZCgpIGZ1bmN0aW9ucz8gIHZhbGlkYXRlX2ZsYXNo
X3dyaXRlKCkgaXMgb25lDQo+IHRoYXQgYWxzbyBsb29rcyBzdXNwaWNpb3VzIHRvIG1lLg0KPiAN
Cj4gSSB0aGluayB5b3UncmUgZGVzY3JpYmluZyB0aGlzIGNvZGU6DQo+IA0KPiAgIHN0YXRpYyBz
c2l6ZV90IHByb2NfYnVzX3BjaV93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBf
X3VzZXINCj4gKmJ1ZiwNCj4gCQkJCSAgICBzaXplX3QgbmJ5dGVzLCBsb2ZmX3QgKnBwb3MpDQo+
ICAgew0KPiAgICAgICAgIGludCBwb3MgPSAqcHBvczsNCj4gICAgICAgICBpbnQgc2l6ZSA9IGRl
di0+Y2ZnX3NpemU7DQo+ICAgICAgICAgaW50IGNudCwgcmV0Ow0KPiANCj4gICAgICAgICBpZiAo
cG9zICsgbmJ5dGVzID4gc2l6ZSkNCj4gICAgICAgICAgICAgICAgIG5ieXRlcyA9IHNpemUgLSBw
b3M7DQo+ICAgICAgICAgY250ID0gbmJ5dGVzOw0KPiAJLi4uDQo+IAl3aGlsZSAoY250ID49IDQp
IHsNCj4gCQkuLi4NCj4gICAgICAgICAgICAgICAgIHBvcyArPSA0Ow0KPiAgICAgICAgICAgICAg
ICAgY250IC09IDQ7DQo+IAl9DQo+IA0KPiBwcm9jX2J1c19wY2lfcmVhZCgpIGlzIHF1aXRlIHNp
bWlsYXIgYnV0ICJwb3MiLCAiY250IiwgYW5kICJzaXplIiBhcmUNCj4gdW5zaWduZWQ6DQo+IA0K
PiAgIHN0YXRpYyBzc2l6ZV90IHByb2NfYnVzX3BjaV9yZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBj
aGFyIF9fdXNlciAqYnVmLA0KPiAJCQkJICAgc2l6ZV90IG5ieXRlcywgbG9mZl90ICpwcG9zKQ0K
PiAgIHsNCj4gICAgICAgICB1bnNpZ25lZCBpbnQgcG9zID0gKnBwb3M7DQo+ICAgICAgICAgdW5z
aWduZWQgaW50IGNudCwgc2l6ZTsNCj4gDQo+IEl0IHNlZW1zIGxpa2UgdGhleSBzaG91bGQgdXNl
IHRoZSBzYW1lIHN0cmF0ZWd5IHRvIGF2b2lkIHRoaXMgcHJvYmxlbS4NCj4gDQoNClRoYW5rcywg
aXQncyBiZXR0ZXIgdG8gdXNlIHVuc2lnbmVkIGludCB0byB0byBhdm9pZCB0aGlzIHByb2JsZW0u
DQoNCi0gV2FuZyBTaGFvQm8NCg==

