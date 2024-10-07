Return-Path: <linux-pci+bounces-13975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E19933D5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA499B26305
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DCB1DBB34;
	Mon,  7 Oct 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mgcayhyl"
X-Original-To: linux-pci@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB191DB373
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319766; cv=none; b=PpryJ4QNXcoizN+5lk6XC6aDQpqwyPqvyxrtJd7N6pYgdQ2tlbH447yxa16P3z3f0jesJSVTWRX5QuObupmI4AHH7Qvxm/QnrMUDwS2Q+QAADUlE7ScNrIcE9AUMxtll1iyjMwXmyiWtjLb8f/ZVcb4CokEQ4SAkQYtXhE7uZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319766; c=relaxed/simple;
	bh=x8Lg99xw1JyPI0bqmO+QVKd03TKGpCqeUCNBtv0A0pY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CT2vf0RaXRvYfWlgOAC/+jee+3NUdp9oKjvofdCRQxajM/g8egEu3LoC+hLo+smLrRYzXEtL30c0qplFZz1SQNOodhabSC4LHvDB1Xhj4Kn995MyKDDVYB3utKVC7whdP18yK3+VkOQt16eZht4BxatB9OsdzOYFnabKOUiUPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mgcayhyl; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 260D3201A7;
	Mon,  7 Oct 2024 18:49:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h5TOfzSBRokK; Mon,  7 Oct 2024 18:49:21 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0EE99200BC;
	Mon,  7 Oct 2024 18:49:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0EE99200BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728319761;
	bh=x8Lg99xw1JyPI0bqmO+QVKd03TKGpCqeUCNBtv0A0pY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=mgcayhyls4IOFgR/VNZX4Qk21E+MeUdUe2cMRZz+2kraTaBQ/wB772bq1ObEKsY+0
	 neeQfEWSJdo3RJ3Mt/J167DIi2IWYp22/uRt5Nj52NyMfJj9qDjbbP5jPR40rL98XZ
	 Ead4ic6nlZCIA7G3YXOptxdLsKT2BqfgYURcLyQ1CHy2QeEoAbzgZokVX07UfbDGuC
	 of0Jdy33f2hX/yEmCqk97zn+5OspFFIQNtJjxv2FqUURVem+Yh1MG78luVicWOoCe3
	 yfBloFeLPI7um83wg4EX1eA+PqLq+Zb62QxG9UZFXdSskOK8Ldo4FVw49KChn+blke
	 eyvqkOB3binzQ==
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 18:49:20 +0200
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 18:49:20 +0200
Received: from mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75]) by
 mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75%6]) with mapi id
 15.01.2507.039; Mon, 7 Oct 2024 18:49:20 +0200
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
Thread-Index: AQHbCmrFODsoF+chTk2MBvuiMq/CLbJlMIIAgAF4p4CAAeJvgIAMc3aAgAEtYQCABU7ogA==
Date: Mon, 7 Oct 2024 16:49:19 +0000
Message-ID: <bdc3963903e7c4aeec7c34ac0d46c4368152a8c2.camel@secunet.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
	 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
	 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
	 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
	 <Zv6gT96pHg2Jglxv@wunner.de> <Zv-dIHDXNNYomG2Y@wunner.de>
In-Reply-To: <Zv-dIHDXNNYomG2Y@wunner.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <B050F2CAA8B63F4AB9271D83A52B5BF1@secunet.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

SGksDQoNCnRoYW5rIHlvdSBmb3IgeW91ciBhZGRpdGlvbmFsIG1haWwuDQoNCk9uIEZyaSwgMjAy
NC0xMC0wNCBhdCAwOTo0NSArMDIwMCwgTHVrYXMgV3VubmVyIHdyb3RlOg0KPiBPbiBUaHUsIE9j
dCAwMywgMjAyNCBhdCAwMzo0Njo1NVBNICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+ID4g
T24gV2VkLCBTZXAgMjUsIDIwMjQgYXQgMDM6Mzg6MzRQTSArMDAwMCwgV2Fzc2VuYmVyZywgRGVu
bmlzIHdyb3RlOg0KPiA+ID4gWyAgICAyLjg1ODA2M10gT29wczogZ2VuZXJhbCBwcm90ZWN0aW9u
IGZhdWx0LCBwcm9iYWJseSBmb3Igbm9uLWNhbm9uaWNhbCBhZGRyZXNzIDB4NmI2YjZiNmI2YjZi
NmI2YjogMDAwMCBbIzFdDQo+ID4gPiBQUkVFTVBUIFNNUCBOT1BUSQ0KPiA+ID4gWyAgICAyLjg1
ODA3MV0gQ1BVOiAxMyBVSUQ6IDAgUElEOiAxMzcgQ29tbTogaXJxLzE1Ni1wY2llaHAgTm90IHRh
aW50ZWQgNi4xMS4wLWRldmVsKyAjMw0KPiA+ID4gWyAgICAyLjg1ODA5MF0gSGFyZHdhcmUgbmFt
ZTogTEVOT1ZPIDIxTFZTMUNWMDAvMjFMVlMxQ1YwMCwgQklPUyBONDVFVDE4VyAoMS4wOCApIDA3
LzA4LzIwMjQNCj4gPiA+IFsgICAgMi44NTgwOTddIFJJUDogMDAxMDpkZXZfZHJpdmVyX3N0cmlu
ZysweDEyLzB4NDANCj4gPiA+IFsgICAgMi44NTgxMTFdIENvZGU6IDVjIGMzIGNjIGNjIGNjIGNj
IDY2IDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIGYz
IDBmIDFlIGZhIDBmIDFmIDQ0DQo+ID4gPiAwMCAwMCA0OCA4YiA0NyA2OCA0OCA4NSBjMCA3NCAw
OCA8NDg+IDhiIDAwIGMzIGNjIGNjIGNjIGNjIDQ4IDhiIDQ3IDYwIDQ4IDg1IGMwIDc1IGVmIDQ4
IDhiIDk3IGE4IDAyDQo+ID4gPiBbICAgIDIuODU4MTIzXSBSU1A6IDAwMDA6ZmZmZjk0OTMwMDlj
ZmEwMCBFRkxBR1M6IDAwMDEwMjAyDQo+ID4gPiBbICAgIDIuODU4MTMyXSBSQVg6IDZiNmI2YjZi
NmI2YjZiNmIgUkJYOiBmZmZmOGU1MzAyOWNiOTE4IFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+
ID4gWyAgICAyLjg1ODEzOV0gUkRYOiBmZmZmZmZmZmE1ODZiMThhIFJTSTogZmZmZjhlNTMwMjlj
YjkxOCBSREk6IGZmZmY4ZTUzMDI5Y2I5MTgNCj4gPiA+IFsgICAgMi44NTgxNDRdIFJCUDogZmZm
Zjk0OTMwMDljZmIxMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBmZmZmOGU1MzA0ZjYxMDAw
DQo+ID4gPiBbICAgIDIuODU4MTUwXSBSMTA6IGZmZmY5NDkzMDA5Y2ZiMjAgUjExOiAwMDAwMDAw
MDAwMDA1NjI3IFIxMjogZmZmZmZmZmZhNjRkYjE4OA0KPiA+ID4gWyAgICAyLjg1ODE1Nl0gUjEz
OiA2YjZiNmI2YjZiNmI2YjZiIFIxNDogMDAwMDAwMDAwMDAwMDA4MCBSMTU6IGZmZmY4ZTUzMDJi
MWMwYzANCj4gPiA+IFsgICAgMi44NTgxNjFdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBH
UzpmZmZmOGU1YTUwMTQwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gPiA+IFsg
ICAgMi44NTgxNjldIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAw
NTAwMzMNCj4gPiA+IFsgICAgMi44NTgxNzVdIENSMjogMDAwMDAwMDAwMDAwMDAwMCBDUjM6IDAw
MDAwMDAzMDE2MmUwMDEgQ1I0OiAwMDAwMDAwMDAwZjcwZWYwDQo+ID4gPiBbICAgIDIuODU4MTgy
XSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAw
MDAwMDAwMDAwMA0KPiA+ID4gWyAgICAyLjg1ODE4N10gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERS
NjogMDAwMDAwMDBmZmZmMDdmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDANCj4gPiA+IFsgICAgMi44
NTgxOTNdIFBLUlU6IDU1NTU1NTU0DQo+ID4gPiBbICAgIDIuODU4MTk2XSBDYWxsIFRyYWNlOg0K
PiA+IA0KPiA+IFsuLi5dDQo+ID4gPiBbICAgIDIuODU4MjU4XSAgX19keW5hbWljX2Rldl9kYmcr
MHgxNzAvMHgyMTANCj4gPiA+IFsgICAgMi44NTgyODddICBwY2lfZGVzdHJveV9zbG90KzB4NTkv
MHg2MA0KPiA+ID4gWyAgICAyLjg1ODI5Nl0gIHBjaWVocF9yZW1vdmUrMHgyZS8weDUwDQo+ID4g
PiBbICAgIDIuODU4MzA0XSAgcGNpZV9wb3J0X3JlbW92ZV9zZXJ2aWNlKzB4MzAvMHg1MA0KPiA+
ID4gWyAgICAyLjg1ODMxMV0gIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDE5Zi8w
eDIwMA0KPiA+ID4gWyAgICAyLjg1ODMyMl0gIGJ1c19yZW1vdmVfZGV2aWNlKzB4YzYvMHgxMzAN
Cj4gPiA+IFsgICAgMi44NTgzMzVdICBkZXZpY2VfZGVsKzB4MTY1LzB4M2YwDQo+ID4gPiBbICAg
IDIuODU4MzQ4XSAgZGV2aWNlX3VucmVnaXN0ZXIrMHgxNy8weDYwDQo+ID4gPiBbICAgIDIuODU4
MzU1XSAgcmVtb3ZlX2l0ZXIrMHgxZi8weDMwDQo+ID4gPiBbICAgIDIuODU4MzYxXSAgZGV2aWNl
X2Zvcl9lYWNoX2NoaWxkKzB4NmEvMHhiMA0KPiA+ID4gWyAgICAyLjg1ODM2OF0gIHBjaWVfcG9y
dGRydl9yZW1vdmUrMHgyZi8weDYwDQo+ID4gPiBbICAgIDIuODU4Mzc0XSAgcGNpX2RldmljZV9y
ZW1vdmUrMHgzZi8weGEwDQo+ID4gPiBbICAgIDIuODU4MzgzXSAgZGV2aWNlX3JlbGVhc2VfZHJp
dmVyX2ludGVybmFsKzB4MTlmLzB4MjAwDQo+ID4gPiBbICAgIDIuODU4MzkyXSAgYnVzX3JlbW92
ZV9kZXZpY2UrMHhjNi8weDEzMA0KPiA+ID4gWyAgICAyLjg1ODM5OF0gIGRldmljZV9kZWwrMHgx
NjUvMHgzZjANCj4gPiA+IFsgICAgMi44NTg0MTNdICBwY2lfcmVtb3ZlX2J1c19kZXZpY2UrMHg5
MS8weDE0MA0KPiA+ID4gWyAgICAyLjg1ODQyMl0gIHBjaV9yZW1vdmVfYnVzX2RldmljZSsweDNl
LzB4MTQwDQo+ID4gPiBbICAgIDIuODU4NDMwXSAgcGNpZWhwX3VuY29uZmlndXJlX2RldmljZSsw
eDk4LzB4MTYwDQo+ID4gPiBbICAgIDIuODU4NDM5XSAgcGNpZWhwX2Rpc2FibGVfc2xvdCsweDY5
LzB4MTMwDQo+ID4gPiBbICAgIDIuODU4NDQ3XSAgcGNpZWhwX2hhbmRsZV9wcmVzZW5jZV9vcl9s
aW5rX2NoYW5nZSsweDI4MS8weDRjMA0KPiA+ID4gWyAgICAyLjg1ODQ1Nl0gIHBjaWVocF9pc3Qr
MHgxNGEvMHgxNTANCj4gPiANCj4gPiBDb3VsZCB5b3UgdHJ5IHRoZSBwYXRjaCBiZWxvdyBhbmQg
cmVwb3J0IGJhY2sgaWYgaXQgZml4ZXMgdGhlIGlzc3VlPw0KPiANCj4gU28gdGhlIHBhdGNoIEkg
c2VudCB5b3UgeWVzdGVyZGF5IHdhcyBiYXNlZCBvbiB0aGUgaW5zaWdodCB0aGF0DQo+IGluIHRo
ZSBzdGFjayB0cmFjZSBhYm92ZSwgcGNpX2Rlc3Ryb3lfc2xvdCgpIGFjY2Vzc2VzIHNsb3QtPmJ1
cw0KPiBhZnRlciBidXMgaGFzIGJlZW4gZGVzdHJveWVkLg0KWWVzLCB0aGUgcmVzdWx0cyBhcmUg
bG9va2luZyB2ZXJ5IGdvb2QgbGlrZSBJIG1lbnRpb25lZCBpbiB0aGUgbWFpbCBiZWZvcmUuDQoN
Cj4gDQo+IFRoZSBzbG90IGlzIG5vdCBhIGNoaWxkIG9mIGJ1cywgc28gZG9lc24ndCBpbXBsaWNp
dGx5IGhvbGQgYSByZWZlcmVuY2UNCj4gb24gYnVzLiAgVGhlIG9ubHkga29iamVjdHMgaG9sZGlu
ZyByZWZlcmVuY2VzIG9uIGJ1cyBhcmUgdGhlIGNoaWxkDQo+IGRldmljZXMgb2YgdGhlIGJ1cywg
YW5kIHRoZXkncmUgZGVzdHJveWVkIGJlZm9yZSB0aGUgYnVzIGdldHMgZGVzdHJveWVkLg0KPiBU
aGUgbG9naWNhbCBjb25jbHVzaW9uIHdhcyB0aGF0IHNsb3QgbmVlZHMgdG8gaG9sZCBhIHJlZmVy
ZW5jZSBvbiBidXMNCj4gdG8gYXZvaWQgYSB1c2UtYWZ0ZXItZnJlZS4NCk9rLCB5ZXMuIFRoaXMg
ZXhwbGFpbnMgd2h5IHRoaXMgaGFwcGVucyBtb3JlIG9mdGVuIGJ5IGFkZGluZy9yZW1vdmUgYSBw
Y2kgYnVzIGhpZXJhcmNoeSBpbiBjb21wYXJpc29uIHRvIGEgc2luZ2xlDQpkZXZpY2UuDQoNCj4g
DQo+IEhvd2V2ZXIgbG9va2luZyBhdCB0aGUgc3RhY2t0cmFjZSB3aXRoIGEgZnJlc2ggcGFpciBv
ZiBleWViYWxscywNCj4gSSBub3RpY2UgdGhlcmUncyBhbiBvZGRpdHkgaGVyZTogIFRoZSBrZXJu
ZWwgbm9ybWFsbHkgdW5iaW5kcyBkcml2ZXJzDQo+IGZyb20gUENJIGRldmljZXMgaW4gcGNpX3N0
b3BfZGV2KCkuICBUaGUgYWN0dWFsIHJlbW92YWwgb2YgdGhlIGRldmljZXMNCj4gaGFwcGVucyBp
biBhIHNlcGFyYXRlIHN0ZXAsIHBjaV9yZW1vdmVfYnVzX2RldmljZSgpLg0KPiANCj4gSSBub3Rl
IHRoYXQgaW4geW91ciBzdGFja3RyYWNlLCBkcml2ZXIgdW5iaW5kaW5nIGhhcHBlbnMgZnJvbQ0K
PiBwY2lfcmVtb3ZlX2J1c19kZXZpY2UoKS4gIFRoYXQncyB1bmV4cGVjdGVkLiAgVGhlIGRyaXZl
ciBzaG91bGQNCj4gaGF2ZSBhbHJlYWR5IGJlZW4gdW5ib3VuZCBlYXJsaWVyIGluIHBjaV9zdG9w
X2RldigpLg0KPiANCj4gUGVyaGFwcyB0aGUgcGNpZXBvcnQgZHJpdmVyIHdhcyByZWJvdW5kIHRv
IHRoZSBkZXZpY2UgYWZ0ZXIgaXQgd2FzDQo+IGFscmVhZHkgdW5ib3VuZC4gIFRoZSBwYXRjaCBi
ZWxvdyBzaG91bGQgcHJldmVudCB0aGF0Lg0KPiANCj4gVGhlcmUgYXJlIG5vIG1lc3NhZ2VzIHRo
b3VnaCB0aGF0IHdvdWxkIHByb3ZlIHJlYmluZGluZyBvZiBhIGhvdHBsdWcgcG9ydC4NCj4gDQo+
IFRoZSB1bnBsdWcgZXZlbnQgaGFwcGVucyBhdCB0aGUgdG9wIG9mIHRoZSBoaWVyYXJjaHkgKGJl
bG93IHRoZSBSb290IFBvcnQpLg0KPiBTbyBwY2lfYnVzX2FkZF9kZXZpY2VzKCkgYmluZHMgdGhl
IFJvb3QgUG9ydCwgaXRzIGRyaXZlciBzdGFydHMgc3RvcHBpbmcNCj4gYW5kIHJlbW92aW5nIHRo
ZSBoaWVyYXJjaHkgYmVsb3csIGFsbCB0aGUgd2hpbGUgcGNpX2J1c19hZGRfZGV2aWNlcygpDQo+
IGNvbnRpbnVlcyBiaW5kaW5nIGRyaXZlcnMgdG8gdGhlIGNoaWxkIGRldmljZXMuDQo+IA0KPiBD
b3VsZCB5b3UgdHJ5IHRoaXMgcGF0Y2ggKGluIGFkZGl0aW9uIHRvIHRoZSBvbmUgYmVsb3cgYW5k
IHRvIHRoZSBvbmUNCj4gSSBzZW50IHllc3RlcmRheSk6DQo+IA0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyNDEwMDMwODQzNDIuMjc1MDEtMS1icmdsQGJnZGV2LnBsLw0KPiANCj4g
SXQgc2hvdWxkIHByZXZlbnQgcGNpX2J1c19hZGRfZGV2aWNlcygpIGZyb20gcmFjaW5nIHdpdGgg
cGNpZWhwIHN0b3BwaW5nDQo+IGFuZCByZW1vdmluZyBkZXZpY2VzLg0KDQpJIGNoZWNrZWQgdGhl
IGNvbWJpbmF0aW9uIG9mIGFsbCAzIHBhdGNoZXMgYXMgd2VsbC4gSW4gdGhlIGVuZCBpdCBiZWhh
dmVzIHRoZSBzYW1lIGxpa2UgaWYgSSBhcHBseSB0aGUgZmlyc3QgcGF0Y2ggb25seQ0KKHRoZSBv
bmUgeW91IHNlbnQgdGhlIGRheSBiZWZvcmUpLiBBbGwgMyBzb3VuZHMgcGxhdXNpYmxlIHRvIG1l
IGJ1dCBpbiBteSB0ZXN0aW5nIGVudmlyb25tZW50IGl0IGlzIHN1ZmZpY2llbnQgdG8gYXBwbHkN
CnRoZSBmaXJzdCBvbmUgb25seSBpbiBvcmRlciB0byBnZXQgdGhpcyBVQUYgZml4ZWQuDQoNCkZv
ciBtZSB0aGlzIGlzIHNvbWV0aGluZyB3aGljaCBzaG91bGQgYmUgaW50ZWdyYXRlZCBpbnRvIHRo
ZSBzdG9jayBrZXJuZWwgdG8gbWFrZSB1c2VycyBvZiBMZW5vdm8gVGh1bmRlcmJvbHQgNCBkb2Nr
cyBpbg0KY29tYmluYXRpb24gd2l0aCBhIG1ldGVvciBsYWtlIGJhc2VkIGRldmljZSBoYXBweSA7
KQ0KDQo+IA0KPiBCVFcsIGFyZSB5b3UgdXNpbmcgYSBzdG9jayBrZXJuZWwgb3IgZG8geW91IGhh
dmUgYW55IGN1c3RvbSBwYXRjaGVzDQo+IChzdWNoIGFzIGdyc2VjdXJpdHkpIGFwcGxpZWQgb24g
dG9wIHdoaWNoIG1pZ2h0IGxlYWQgdG8gYSBkaWZmZXJlbnQNCj4gYmVoYXZpb3IgdGhhbiBhIHN0
b2NrIGtlcm5lbD8NCkluaXRpYWxseSBJIGhhZCBjdXN0b20gcGF0Y2hlcyBhcHBsaWVkIChlLmcu
IGdyc2VjdXJpdHkpIGFuZCB3ZSByYW4gaW50byB0aGlzIGlzc3VlLiBCZWZvcmUgcmVwb3J0aW5n
IGl0IGhlcmUgSSBkb3VibGUNCmNoZWNrZWQgdGhpcyB1c2luZyBhIHN0b2NrIGtlcm5lbC4gVGhl
cmUsIG5vIGFkZGl0aW9uYWwgcGF0Y2hlcyB3aGVyZSBhcHBsaWVkIChqdXN0IG5lZWQgdG8gYWRk
IHNsYWJfZGVidWcgaW4gdGhlDQpjb21tYW5kIGxpbmUgaW4gb3JkZXIgdG8gbWFrZSB0aGlzIFVB
RiB2aXNpYmxlIChsaWtlIGdyc2VjdXJpdHkgZGlkIGl0IG9uIG91ciBzaWRlKS4NCg0KSW4gbXkg
dGVzdHMgSSBkaWQgdGhlIGZpcnN0IGl0ZXJhdGlvbiB1c2luZyBhZGRpdGlvbmFsIHBhdGNoZXMg
YXMgd2VsbCAob3VyIGRlZmF1bHQgc3lzdGVtL2JlaGF2aW9yKS4gVGhpcyBpcyBiZWNhdXNlIEkN
CmhhdmUgS0FTQU4gZW5hYmxlZCBtZWFud2hpbGUgYW5kIHRoZSBpc3N1ZSBpcy93YXMgc3RpbGwg
MTAwJSByZXByb2R1Y2libGUuIFVzaW5nIGEgc3RvY2sga2VybmVsIGl0IGZhaWxlZCBpbiByb3Vu
ZCBhYm91dA0KNTAlIG9mIHRoZSB0cmllcyAoS0FTQU4gZGlzYWJsZWQsIG9ubHkgc2V0ICdzbGFi
X2RlYnVnJykuIEFmdGVyIGVuYWJsaW5nIEtBU0FOIGl0IHdhcyBub3QgcmVwcm9kdWNpYmxlIGFu
eSBtb3JlLiBUaHVzLCBJDQp0b29rIHRoZSBzeXN0ZW0gd2hlcmUgdGhlIHJlcHJvZHVjaWJpbGl0
eSB3YXMgZXZlbiBiZXR0ZXIuIEFmdGVyIHRoaXMgSSBkb3VibGUgY2hlY2tlZCB0aGUgcmVzdWx0
cyB1c2luZyBhIHN0b2NrIGtlcm5lbC4NClRoaXMgb25lIGJlaGF2ZXMgZXhhY3RseSB0aGUgc2Ft
ZSBsaWtlIHRoZSBtb2RpZmllZCBrZXJuZWwgd2UgYXJlIHVzaW5nIChhZnRlciBhcHBseWluZyB0
aGUgcGF0Y2hlcykuDQoNClRoYW5rIHlvdSAmIGJlc3QgcmVnYXJkcywNCkRlbm5pcw0KDQoNCg0K
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBMdWthcw0KPiANCj4gLS0gPjggLS0NCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9yZW1vdmUuYyBiL2RyaXZlcnMvcGNpL3JlbW92ZS5jDQo+IGlu
ZGV4IDM4N2RiOTIuLjFiMzhkNzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL3JlbW92ZS5j
DQo+ICsrKyBiL2RyaXZlcnMvcGNpL3JlbW92ZS5jDQo+IEBAIC0zNiw2ICszNiw3IEBAIHN0YXRp
YyB2b2lkIHBjaV9zdG9wX2RldihzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiAgCWlmIChwY2lfZGV2
X2lzX2FkZGVkKGRldikpIHsNCj4gIAkJZGV2aWNlX2Zvcl9lYWNoX2NoaWxkKGRldi0+ZGV2LnBh
cmVudCwgZGV2X29mX25vZGUoJmRldi0+ZGV2KSwNCj4gIAkJCQkgICAgICBwY2lfcHdyY3RsX3Vu
cmVnaXN0ZXIpOw0KPiArCQlkZXYtPm1hdGNoX2RyaXZlciA9IGZhbHNlOw0KPiAgCQlkZXZpY2Vf
cmVsZWFzZV9kcml2ZXIoJmRldi0+ZGV2KTsNCj4gIAkJcGNpX3Byb2NfZGV0YWNoX2RldmljZShk
ZXYpOw0KPiAgCQlwY2lfcmVtb3ZlX3N5c2ZzX2Rldl9maWxlcyhkZXYpOw0KDQo=

