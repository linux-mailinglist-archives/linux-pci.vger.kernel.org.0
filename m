Return-Path: <linux-pci+bounces-10434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03408933D8C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2281F25021
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ABB3FB1B;
	Wed, 17 Jul 2024 13:22:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F21802A9
	for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222522; cv=none; b=ByZVWxxSjDEI+Sh/g1PNpd4A1n8bbXFP6ycfUHHtB+PMuOQUQkP1mPErLjdT3aBgijcMH1ao88o3W4kxgcmYk0BMoFzZhEaqqvzhOmfrVMuVCUeIOI3ozmL605OIrex+Pg+WQX8itnaWa4kRR5l1w5m7IuxKUy0dw/7I838csO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222522; c=relaxed/simple;
	bh=AAGKJwRgry5A+DoK9XTiMGfzqNj7J98miGC5LflmdCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=L2TknmaWHt8j9fSgkJbMwsgUgt+qFN8UiDc4m4r1SlAElHS1uB+xdWyMCem1eF6I86mVKE2gK+yEzIHvqKxR97/taEpNyzl4FgjTUcm/DiWnzMi/ZhUOhJiRBv9I0xclW1HBbclr0aHd3KIMxuOgnV8kl2GNZw13GW5se3Wy8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-120-3pLnuI2YPKGnDs_ikR4uGQ-1; Wed, 17 Jul 2024 14:21:58 +0100
X-MC-Unique: 3pLnuI2YPKGnDs_ikR4uGQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jul
 2024 14:21:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 17 Jul 2024 14:21:19 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: David Laight <David.Laight@ACULAB.COM>, 'Stewart Hildebrand'
	<stewart.hildebrand@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Thomas Zimmermann
	<tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg
	<sam@ravnborg.org>, Yongji Xie <elohimes@gmail.com>,
	=?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] PCI: Align small (<4k) BARs
Thread-Topic: [PATCH v2 0/8] PCI: Align small (<4k) BARs
Thread-Index: AQHa17cKP+9xH7dU/kmzREQ0omlV2bH64QzQgAAH5ZA=
Date: Wed, 17 Jul 2024 13:21:19 +0000
Message-ID: <9c6845d49fa14d84bb7ada1022147276@AcuMS.aculab.com>
References: <20240716193246.1909697-1-stewart.hildebrand@amd.com>
 <0da056616de54589bc1d4b95dcdf5d3d@AcuMS.aculab.com>
In-Reply-To: <0da056616de54589bc1d4b95dcdf5d3d@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDE3IEp1bHkgMjAyNCAxNDoxNQ0KPiANCj4gRnJv
bTogU3Rld2FydCBIaWxkZWJyYW5kDQo+ID4gU2VudDogMTYgSnVseSAyMDI0IDIwOjMzDQo+ID4N
Cj4gPiBUaGlzIHNlcmllcyBzZXRzIHRoZSBkZWZhdWx0IG1pbmltdW0gcmVzb3VyY2UgYWxpZ25t
ZW50IHRvIDRrIGZvciBtZW1vcnkNCj4gPiBCQVJzLiBJbiBwcmVwYXJhdGlvbiwgaXQgbWFrZXMg
YW4gb3B0aW1pemF0aW9uIGFuZCBhZGRyZXNzZXMgc29tZSBjb3JuZXINCj4gPiBjYXNlcyBvYnNl
cnZlZCB3aGVuIHJlYWxsb2NhdGluZyBCQVJzLiBJIGNvbnNpZGVyIHRoZSBwcmVwYXBhdG9yeQ0K
PiA+IHBhdGNoZXMgdG8gYmUgcHJlcmVxdWlzaXRlcyB0byBjaGFuZ2luZyB0aGUgZGVmYXVsdCBC
QVIgYWxpZ25tZW50Lg0KPiANCj4gU2hvdWxkIHRoZSBCQVJzIGJlIHBhZ2UgYWxpZ25lZCBvbiBz
eXN0ZW1zIHdpdGggbGFyZ2UgcGFnZXM/DQo+IEF0IGxlYXN0IGFzIGFuIG9wdGlvbiBmb3IgaHlw
ZXJ2aXNvciBwYXNzLXRocm91Z2ggYW5kIGFueSB0aGFuIGNhbiBiZSBtbWFwKCllZA0KPiBpbnRv
IHVzZXJzcGFjZS4NCg0KVGhlIGFjdHVhbCBwYXRjaCBzYXlzIFBBR0VfU0laRSAuLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K


