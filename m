Return-Path: <linux-pci+bounces-13969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5D9932FC
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 18:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD19AB22823
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618A1DA0E0;
	Mon,  7 Oct 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zuFcZMMI"
X-Original-To: linux-pci@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365F1D4152
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318060; cv=none; b=rFT81600EMB54kV7hhSSXdXTnr6UHYBuXXOxVrpO+R7cpUmSeEjzuHSlhvh4GKR7uL+n9M35oS+Dfj9hh6BOgwEi8AdcdhGNsGKONBjgaeJrJoGYr0dod9rcb2Vyqp647ChQbvwsjEwDNC2tTNv9bphQycTsgaj7iyKkJ/Jzirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318060; c=relaxed/simple;
	bh=2aDLlZ5RctR8VBFbpTRUIaoGpxLSp74zIBEQpxd1pVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fkslTecKDBcKiKAGIkjn+mSPttrWo579IQU1WB/qYgx3NYdpe3g8l3Vmtf0DRcnXis5dUsGT7mynHdAGR4VxIWASYaEXJinx7ErP7mlbxj4mRfvmkTlrIad56HjaE9nTFU8e1EmEmKG3drorHsNLQpB7DMPcvQDtX2x97lmP7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zuFcZMMI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E79BF2050A;
	Mon,  7 Oct 2024 18:20:54 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3IH-QS-PaJBI; Mon,  7 Oct 2024 18:20:54 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3ED2B201AE;
	Mon,  7 Oct 2024 18:20:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3ED2B201AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728318054;
	bh=2aDLlZ5RctR8VBFbpTRUIaoGpxLSp74zIBEQpxd1pVs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=zuFcZMMIzqK6aPasavjjaOv9jIATMQamkbLj7wyEnmKKS1FBveaFq0gmSiI2p9xoR
	 oBtMkSpl+tbK6Dul/SMv2vNqpum9q4rCPjfMs/coO2sFv9woEBog8rNtRYTVI6g90e
	 gv9SNUL8nYc0EyRRDclEhDEi458ad171xcjpykeVR3B9PrS3F7/tUnGZVTFm7UT6o/
	 llqpIDYbfD4IfaRVsoOQWUSAudJ0i78wnhRjjf7ShuW/u8M1GLO3Pl9cC2BRtI/vxR
	 /K7YX/N6qnDPFtRnKlHCW8AKYvF3QV1SIDZVmcM5XFigX8CXK9GyzLNKOfcqDYOYlr
	 1g/1SdxVkvEag==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 18:20:54 +0200
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mbx-essen-01.secunet.de (10.53.40.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 18:20:53 +0200
Received: from mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75]) by
 mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75%6]) with mapi id
 15.01.2507.039; Mon, 7 Oct 2024 18:20:53 +0200
From: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
To: "lukas@wunner.de" <lukas@wunner.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "mika.westerberg@linux.intel.com"
	<mika.westerberg@linux.intel.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mpearson-lenovo@squebb.ca"
	<mpearson-lenovo@squebb.ca>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "minipli@grsecurity.net"
	<minipli@grsecurity.net>
Subject: Re: UAF during boot on MTL based devices with attached dock
Thread-Topic: UAF during boot on MTL based devices with attached dock
Thread-Index: AQHbCmrFODsoF+chTk2MBvuiMq/CLbJlMIIAgAF4p4CAAeJvgIAMc3aAgAZ0VgA=
Date: Mon, 7 Oct 2024 16:20:53 +0000
Message-ID: <bc627f822f3e9162741f7ee7f8d1bd13cf905680.camel@secunet.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
	 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
	 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
	 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
	 <Zv6gT96pHg2Jglxv@wunner.de>
In-Reply-To: <Zv6gT96pHg2Jglxv@wunner.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EE4636A05D3444E86CBD07F5051775C@secunet.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

SGksDQoNCnRoYW5rIHlvdSBmb3IgeW91ciBtYWlsIQ0KDQpPbiBUaHUsIDIwMjQtMTAtMDMgYXQg
MTU6NDYgKzAyMDAsIEx1a2FzIFd1bm5lciB3cm90ZToNCj4gT24gV2VkLCBTZXAgMjUsIDIwMjQg
YXQgMDM6Mzg6MzRQTSArMDAwMCwgV2Fzc2VuYmVyZywgRGVubmlzIHdyb3RlOg0KPiA+IFsgICAg
Mi44NTgwNjNdIE9vcHM6IGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5v
bi1jYW5vbmljYWwgYWRkcmVzcyAweDZiNmI2YjZiNmI2YjZiNmI6IDAwMDAgWyMxXQ0KPiA+IFBS
RUVNUFQgU01QIE5PUFRJDQo+ID4gWyAgICAyLjg1ODA3MV0gQ1BVOiAxMyBVSUQ6IDAgUElEOiAx
MzcgQ29tbTogaXJxLzE1Ni1wY2llaHAgTm90IHRhaW50ZWQgNi4xMS4wLWRldmVsKyAjMw0KPiA+
IFsgICAgMi44NTgwOTBdIEhhcmR3YXJlIG5hbWU6IExFTk9WTyAyMUxWUzFDVjAwLzIxTFZTMUNW
MDAsIEJJT1MgTjQ1RVQxOFcgKDEuMDggKSAwNy8wOC8yMDI0DQo+ID4gWyAgICAyLjg1ODA5N10g
UklQOiAwMDEwOmRldl9kcml2ZXJfc3RyaW5nKzB4MTIvMHg0MA0KPiA+IFsgICAgMi44NTgxMTFd
IENvZGU6IDVjIGMzIGNjIGNjIGNjIGNjIDY2IDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkw
IDkwIDkwIDkwIDkwIDkwIDkwIDkwIGYzIDBmIDFlIGZhIDBmIDFmIDQ0IDAwDQo+ID4gMDAgNDgg
OGIgNDcgNjggNDggODUgYzAgNzQgMDggPDQ4PiA4YiAwMCBjMyBjYyBjYyBjYyBjYyA0OCA4YiA0
NyA2MCA0OCA4NSBjMCA3NSBlZiA0OCA4YiA5NyBhOCAwMg0KPiA+IFsgICAgMi44NTgxMjNdIFJT
UDogMDAwMDpmZmZmOTQ5MzAwOWNmYTAwIEVGTEFHUzogMDAwMTAyMDINCj4gPiBbICAgIDIuODU4
MTMyXSBSQVg6IDZiNmI2YjZiNmI2YjZiNmIgUkJYOiBmZmZmOGU1MzAyOWNiOTE4IFJDWDogMDAw
MDAwMDAwMDAwMDAwMA0KPiA+IFsgICAgMi44NTgxMzldIFJEWDogZmZmZmZmZmZhNTg2YjE4YSBS
U0k6IGZmZmY4ZTUzMDI5Y2I5MTggUkRJOiBmZmZmOGU1MzAyOWNiOTE4DQo+ID4gWyAgICAyLjg1
ODE0NF0gUkJQOiBmZmZmOTQ5MzAwOWNmYjEwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IGZm
ZmY4ZTUzMDRmNjEwMDANCj4gPiBbICAgIDIuODU4MTUwXSBSMTA6IGZmZmY5NDkzMDA5Y2ZiMjAg
UjExOiAwMDAwMDAwMDAwMDA1NjI3IFIxMjogZmZmZmZmZmZhNjRkYjE4OA0KPiA+IFsgICAgMi44
NTgxNTZdIFIxMzogNmI2YjZiNmI2YjZiNmI2YiBSMTQ6IDAwMDAwMDAwMDAwMDAwODAgUjE1OiBm
ZmZmOGU1MzAyYjFjMGMwDQo+ID4gWyAgICAyLjg1ODE2MV0gRlM6ICAwMDAwMDAwMDAwMDAwMDAw
KDAwMDApIEdTOmZmZmY4ZTVhNTAxNDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0K
PiA+IFsgICAgMi44NTgxNjldIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAw
MDAwODAwNTAwMzMNCj4gPiBbICAgIDIuODU4MTc1XSBDUjI6IDAwMDAwMDAwMDAwMDAwMDAgQ1Iz
OiAwMDAwMDAwMzAxNjJlMDAxIENSNDogMDAwMDAwMDAwMGY3MGVmMA0KPiA+IFsgICAgMi44NTgx
ODJdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAw
MDAwMDAwMDAwMDAwDQo+ID4gWyAgICAyLjg1ODE4N10gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERS
NjogMDAwMDAwMDBmZmZmMDdmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANCj4gPiBbICAgIDIuODU4
MTkzXSBQS1JVOiA1NTU1NTU1NA0KPiA+IFsgICAgMi44NTgxOTZdIENhbGwgVHJhY2U6DQo+IA0K
PiBbLi4uXQ0KPiA+IFsgICAgMi44NTgyNThdICBfX2R5bmFtaWNfZGV2X2RiZysweDE3MC8weDIx
MA0KPiA+IFsgICAgMi44NTgyODddICBwY2lfZGVzdHJveV9zbG90KzB4NTkvMHg2MA0KPiA+IFsg
ICAgMi44NTgyOTZdICBwY2llaHBfcmVtb3ZlKzB4MmUvMHg1MA0KPiA+IFsgICAgMi44NTgzMDRd
ICBwY2llX3BvcnRfcmVtb3ZlX3NlcnZpY2UrMHgzMC8weDUwDQo+ID4gWyAgICAyLjg1ODMxMV0g
IGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDE5Zi8weDIwMA0KPiA+IFsgICAgMi44
NTgzMjJdICBidXNfcmVtb3ZlX2RldmljZSsweGM2LzB4MTMwDQo+ID4gWyAgICAyLjg1ODMzNV0g
IGRldmljZV9kZWwrMHgxNjUvMHgzZjANCj4gPiBbICAgIDIuODU4MzQ4XSAgZGV2aWNlX3VucmVn
aXN0ZXIrMHgxNy8weDYwDQo+ID4gWyAgICAyLjg1ODM1NV0gIHJlbW92ZV9pdGVyKzB4MWYvMHgz
MA0KPiA+IFsgICAgMi44NTgzNjFdICBkZXZpY2VfZm9yX2VhY2hfY2hpbGQrMHg2YS8weGIwDQo+
ID4gWyAgICAyLjg1ODM2OF0gIHBjaWVfcG9ydGRydl9yZW1vdmUrMHgyZi8weDYwDQo+ID4gWyAg
ICAyLjg1ODM3NF0gIHBjaV9kZXZpY2VfcmVtb3ZlKzB4M2YvMHhhMA0KPiA+IFsgICAgMi44NTgz
ODNdICBkZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwrMHgxOWYvMHgyMDANCj4gPiBbICAg
IDIuODU4MzkyXSAgYnVzX3JlbW92ZV9kZXZpY2UrMHhjNi8weDEzMA0KPiA+IFsgICAgMi44NTgz
OThdICBkZXZpY2VfZGVsKzB4MTY1LzB4M2YwDQo+ID4gWyAgICAyLjg1ODQxM10gIHBjaV9yZW1v
dmVfYnVzX2RldmljZSsweDkxLzB4MTQwDQo+ID4gWyAgICAyLjg1ODQyMl0gIHBjaV9yZW1vdmVf
YnVzX2RldmljZSsweDNlLzB4MTQwDQo+ID4gWyAgICAyLjg1ODQzMF0gIHBjaWVocF91bmNvbmZp
Z3VyZV9kZXZpY2UrMHg5OC8weDE2MA0KPiA+IFsgICAgMi44NTg0MzldICBwY2llaHBfZGlzYWJs
ZV9zbG90KzB4NjkvMHgxMzANCj4gPiBbICAgIDIuODU4NDQ3XSAgcGNpZWhwX2hhbmRsZV9wcmVz
ZW5jZV9vcl9saW5rX2NoYW5nZSsweDI4MS8weDRjMA0KPiA+IFsgICAgMi44NTg0NTZdICBwY2ll
aHBfaXN0KzB4MTRhLzB4MTUwDQo+IA0KPiBDb3VsZCB5b3UgdHJ5IHRoZSBwYXRjaCBiZWxvdyBh
bmQgcmVwb3J0IGJhY2sgaWYgaXQgZml4ZXMgdGhlIGlzc3VlPw0KPiANCj4gVGhhbmtzIQ0KPiAN
Cj4gTHVrYXMNCj4gDQo+IC0tID44IC0tDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
c2xvdC5jIGIvZHJpdmVycy9wY2kvc2xvdC5jDQo+IGluZGV4IDBmODdjYWRlMTBmNy4uZWQ2NDVj
N2E0ZTRiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9zbG90LmMNCj4gKysrIGIvZHJpdmVy
cy9wY2kvc2xvdC5jDQo+IEBAIC03OSw2ICs3OSw3IEBAIHN0YXRpYyB2b2lkIHBjaV9zbG90X3Jl
bGVhc2Uoc3RydWN0IGtvYmplY3QgKmtvYmopDQo+ICAJdXBfcmVhZCgmcGNpX2J1c19zZW0pOw0K
PiAgDQo+ICAJbGlzdF9kZWwoJnNsb3QtPmxpc3QpOw0KPiArCXBjaV9idXNfcHV0KHNsb3QtPmJ1
cyk7DQo+ICANCj4gIAlrZnJlZShzbG90KTsNCj4gIH0NCj4gQEAgLTI2MSw3ICsyNjIsNyBAQCBz
dHJ1Y3QgcGNpX3Nsb3QgKnBjaV9jcmVhdGVfc2xvdChzdHJ1Y3QgcGNpX2J1cyAqcGFyZW50LCBp
bnQgc2xvdF9uciwNCj4gIAkJZ290byBlcnI7DQo+ICAJfQ0KPiAgDQo+IC0Jc2xvdC0+YnVzID0g
cGFyZW50Ow0KPiArCXNsb3QtPmJ1cyA9IHBjaV9idXNfZ2V0KHBhcmVudCk7DQo+ICAJc2xvdC0+
bnVtYmVyID0gc2xvdF9ucjsNCj4gIA0KPiAgCXNsb3QtPmtvYmoua3NldCA9IHBjaV9zbG90c19r
c2V0Ow0KPiBAQCAtMjY5LDYgKzI3MCw3IEBAIHN0cnVjdCBwY2lfc2xvdCAqcGNpX2NyZWF0ZV9z
bG90KHN0cnVjdCBwY2lfYnVzICpwYXJlbnQsIGludCBzbG90X25yLA0KPiAgCXNsb3RfbmFtZSA9
IG1ha2Vfc2xvdF9uYW1lKG5hbWUpOw0KPiAgCWlmICghc2xvdF9uYW1lKSB7DQo+ICAJCWVyciA9
IC1FTk9NRU07DQo+ICsJCXBjaV9idXNfcHV0KHNsb3QtPmJ1cyk7DQo+ICAJCWtmcmVlKHNsb3Qp
Ow0KPiAgCQlnb3RvIGVycjsNCj4gIAl9DQoNCkkgdGVzdGVkIHRoZSBwYXRjaC4gRm9yIG1lIHRo
aXMgaXMgdGhlIGJyZWFrdGhyb3VnaC4gSSB0cmllZCBpdCB2ZXJ5IGhhcmQgKHJ1bm5pbmcgYXV0
b21hdGVkIGJvb3QtdXAgYW5kIHNodXQtZG93bg0Kc2VxdWVuY2VzIHRoZSBob2xlIGRheSkuIEZv
ciBtZSBpdCB3YXMgbm90IHBvc3NpYmxlIHRvIHJ1biBpbnRvIHRoZSBVQUYgYW55IG1vcmUuIFRo
aXMgd2lsbCBkZWZpbml0ZWx5IGZpeCB0aGUgaXNzdWUgd2UNCnJhbiBpbnRvISBBdCBsZWFzdCBJ
IGNhbiBub3QgcmVwcm9kdWNlIGl0IGFueSBtb3JlIDspDQoNClRoYW5rIHlvdSAmIGJlc3QgcmVn
YXJkcywNCkRlbm5pcw0K

