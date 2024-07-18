Return-Path: <linux-pci+bounces-10494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD31C934B6F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 12:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6661C20A89
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4D12C7FB;
	Thu, 18 Jul 2024 10:02:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A48824AC
	for <linux-pci@vger.kernel.org>; Thu, 18 Jul 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296945; cv=none; b=DUyvoZJThUFQmNF7YAM5ECpIvrROE9qnDxFygDk5H0VTcR3IxL2JiXJgqJyEe6jcDgmwjhsnPARAb7NNnm5U8n8X3SQtwGAhkAe0k3HEHGMvnH1PRU1L0nfytUAU54Ce5aib+9llYAdTrSo0r3wZnpTYjvmmTriXr7ixUkIH73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296945; c=relaxed/simple;
	bh=VLNrsDp1/dwijE+YFKkb8kkskdhh80i1siuDq/8eO2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MxvpzPNDITBLiMRwaBMWefDI7SqywJpmIjchu8KMW+QpvotzmKg4RhCVTEcH5rAYwfjFeO9mOmVQtrE00YofoJxyCmN6wXRSGMJHxoSpWiEplTWNrv2MLlypG36vaHxLPF+ylo1ijju62pEu+BBsS+3SWHnEi5ZpmpImD/rqHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-80-_z23Jv5lPxy11QywTJfvFg-1; Thu, 18 Jul 2024 11:02:20 +0100
X-MC-Unique: _z23Jv5lPxy11QywTJfvFg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 18 Jul
 2024 11:01:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 18 Jul 2024 11:01:41 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Stewart Hildebrand' <stewart.hildebrand@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Thomas Zimmermann <tzimmermann@suse.de>, "Arnd
 Bergmann" <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, Yongji Xie
	<elohimes@gmail.com>, =?utf-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 0/8] PCI: Align small (<4k) BARs
Thread-Topic: [PATCH v2 0/8] PCI: Align small (<4k) BARs
Thread-Index: AQHa17cKP+9xH7dU/kmzREQ0omlV2bH64QzQgABNsICAAQylQA==
Date: Thu, 18 Jul 2024 10:01:41 +0000
Message-ID: <6cd271759286482db8d390823f408b05@AcuMS.aculab.com>
References: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
 <0da056616de54589bc1d4b95dcdf5d3d@AcuMS.aculab.com>
 <a4e2fdae-0db3-46de-b95d-bf6ef7b61b33@amd.com>
In-Reply-To: <a4e2fdae-0db3-46de-b95d-bf6ef7b61b33@amd.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogU3Rld2FydCBIaWxkZWJyYW5kDQo+IFNlbnQ6IDE3IEp1bHkgMjAyNCAxOTozMQ0KLi4u
DQo+ID4gRm9yIG1vcmUgbm9ybWFsIGhhcmR3YXJlIGp1c3QgZW5zdXJpbmcgdGhhdCB0d28gc2Vw
YXJhdGUgdGFyZ2V0cyBkb24ndCBzaGFyZQ0KPiA+IGEgcGFnZSB3aGlsZSBhbGxvd2luZyAoZWcp
IHR3byAxayBCQVIgdG8gcmVzaWRlIGluIHRoZSBzYW1lIDY0ayBwYWdlIHdvdWxkDQo+ID4gZ2l2
ZSBzb21lIHNlY3VyaXR5Lg0KPiANCj4gQWxsb3cgbWUgdG8gdW5kZXJzdGFuZCB0aGlzIGJldHRl
ciwgd2l0aCBhbiBleGFtcGxlOg0KPiANCj4gUENJIERldmljZSBBDQo+ICAgICBCQVIgMSAoMWsp
DQo+ICAgICBCQVIgMiAoMWspDQo+IA0KPiBQQ0kgRGV2aWNlIEINCj4gICAgIEJBUiAxICgxaykN
Cj4gICAgIEJBUiAyICgxaykNCj4gDQo+IFdlIGFsaWduIGFsbCBCQVJzIHRvIDRrLiBBZGRpdGlv
bmFsbHksIGFyZSB5b3Ugc2F5aW5nIGl0IHdvdWxkIGJlIG9rIHRvDQo+IGxldCBib3RoIGRldmlj
ZSBBIEJBUnMgdG8gcmVzaWRlIGluIHRoZSBzYW1lIDY0ayBwYWdlLCB3aGlsZSBkZXZpY2UgQg0K
PiBCQVJzIHdvdWxkIG5lZWQgdG8gcmVzaWRlIGluIGEgc2VwYXJhdGUgNjRrIHBhZ2U/IEkuZS4g
aGF2aW5nIHR3byBsZXZlbHMNCj4gb2YgYWxpZ25tZW50OiBQQUdFX1NJWkUgb24gYSBwZXItZGV2
aWNlIGJhc2lzLCBhbmQgNGsgb24gYSBwZXItQkFSDQo+IGJhc2lzPw0KPiANCj4gSWYgSSB1bmRl
cnN0YW5kIHlvdSBjb3JyZWN0bHksIHRoZXJlJ3MgY3VycmVudGx5IG5vIGxvZ2ljIGluIHRoZSBQ
Q0kNCj4gc3Vic3lzdGVtIHRvIGVhc2lseSBzdXBwb3J0IHRoaXMsIHNvIHRoYXQgaXMgYSByYXRo
ZXIgbGFyZ2UgYXNrLiBJJ20NCj4gYWxzbyBub3Qgc3VyZSB0aGF0IGl0J3MgbmVjZXNzYXJ5Lg0K
DQpUaGF0IGlzIHdoYXQgSSB3YXMgdGhpbmtpbmcsIGJ1dCBpdCBwcm9iYWJseSBkb2Vzbid0IG1h
dHRlci4NCkl0IHdvdWxkIG9ubHkgYmUgbmVjZXNzYXJ5IGlmIHRoZSBzeXN0ZW0gd291bGQgb3Ro
ZXJ3aXNlIHJ1biBvdXQNCm9mIFBDSShlKSBhZGRyZXNzIHNwYWNlLg0KDQpFdmVuIGFmdGVyIEkg
cmVkdWNlZCBvdXIgRlBHQXMgQkFScyBmcm9tIDMyTUIgdG8gJ29ubHknIDRNQiAoMU1CICsgMU1C
ICsgOGspDQp3ZSBzdGlsbCBnZXQgaXNzdWVzIHdpdGggc29tZSBQQyBiaW9zIGZhaWxpbmcgdG8g
YWxsb2NhdGUgdGhlIHJlc291cmNlcw0KaW4gc29tZSBzbG90cyAtIGJ1dCB0aGVzZSBhcmUgb2xk
IHg4Ni02NCBzeXN0ZW1zIHRoYXQgbWlnaHQgaGF2ZSBiZWVuIGV4cGVjdGVkDQp0byBydW4gMzJi
aXQgd2luZG93cy4NClRoZSByZXF1aXJlbWVudCB0byB1c2UgYSBzZXBhcmF0ZSBCQVIgZm9yIE1T
SVggcHJldHR5IG11Y2ggZG91YmxlcyB0aGUNCnJlcXVpcmVkIGFkZHJlc3Mgc3BhY2UuDQoNCkFz
IGFuIGFzaWRlLCBpZiBhIFBDSWUgZGV2aWNlIGFza3MgZm9yOg0KCUJBUi0wICg0aykNCglCQVIt
MSAoOGspDQoJQkFSLTIgKDRrKQ0KKHdoaWNoIGlzIGEgYml0IHNpbGx5KQ0KZG9lcyBpdCBnZXQg
cGFja2VkIGludG8gMTZrIHdpdGggbm8gcGFkZGluZyBieSBhc3NpZ25pbmcgQkFSLTIgYmV0d2Vl
bg0KQkFSLTAgYW5kIEJBUi0xLCBvciBpcyBpdCBhbGwgcGFkZGVkIG91dCB0byAzMmsuDQpJJ2Qg
cHJvYmFibHkgYWRkIGEgY29tbWVudCB0byBzYXkgaXQgaXNuJ3QgZG9uZSA6LSkNCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==


