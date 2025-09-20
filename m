Return-Path: <linux-pci+bounces-36599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF488B8D1F4
	for <lists+linux-pci@lfdr.de>; Sun, 21 Sep 2025 00:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671A9189DB7C
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCC1A9FBF;
	Sat, 20 Sep 2025 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qJElSNh0"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7029A1;
	Sat, 20 Sep 2025 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758407985; cv=none; b=OlH8GyU5Cpxh0ht0HCrGp03VDcpP0EvXSIlxJZWQrDmVCZfkEatCmYCVBNiosEmQj2LcX/JEZGEGXLwbS+vXABXgH3gFyYfYyAWM6h5UdLP1KkxOsMlE8e+gBs3KNs8nlb5cJF7nyjWBveZzqMRjugg6d4CjZCaiqVAt2uAEivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758407985; c=relaxed/simple;
	bh=3a1SsYh9uMBLXpEutb5l2RGyNz0DWB6z1QkTKc1HTZo=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aV/NyFsUMv/tN3PN1vt0uJrZBAIrf87PcoeMHRolGQWi9d5MkunrNY5RCnMzsAbs5jIrRC0Bgc3sLzi81udNyLRcw1D3F3ZMe/I2Ka9N7VJivYRWF2Ash3+zUZ6Vkv9jhd1vdEOsLRJMphKFCKD4ZVeTvZlvGVHm40UylJ1huag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qJElSNh0; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758407984; x=1789943984;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=3a1SsYh9uMBLXpEutb5l2RGyNz0DWB6z1QkTKc1HTZo=;
  b=qJElSNh05PPrWNC/SpxgymHdJh8Fw1v+RusNSKPbmZZFj6R380YMtIyp
   jUtWyIhSroIJHAWhUhDKLj8dGJmHPXxQ4tA66EJMuvf58M3a8St/vx07C
   WGYaVLMp6OR/iEiy7V6wwyy6vaMu6hzJCRkuq9S2dfCMmMonwSLalQC7Z
   PLBSeo8AN+TcTfSSzGZPYJI7XNAnNRvPF26tCcG0PblbpQSEsOSgaML+b
   fumgljkbX+8UmQQxEN6t1reKhrHhpesKY1xrVM+O/UoQJf1KfrHqxSPlV
   CySPs2/3ujNWB0ONKZmPETC+NCMsIa5affI2xxEb+4UMkmcGJoh8CWw3v
   Q==;
X-CSE-ConnectionGUID: GBDImWXqTeOeO0/tZEZN/g==
X-CSE-MsgGUID: NuHHHRL+STyTscmtqd2ZSQ==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="3244153"
Subject: Re: [PATCH] PCI: xilinx-xdma: Enable legacy interrupts
Thread-Topic: [PATCH] PCI: xilinx-xdma: Enable legacy interrupts
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 22:39:43 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:61299]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.110:2525] with esmtp (Farcaster)
 id 23c1ffd4-2ce3-4e70-8b70-02ad243df737; Sat, 20 Sep 2025 22:39:43 +0000 (UTC)
X-Farcaster-Flow-ID: 23c1ffd4-2ce3-4e70-8b70-02ad243df737
Received: from EX19D032UWA004.ant.amazon.com (10.13.139.56) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 20 Sep 2025 22:39:43 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA004.ant.amazon.com (10.13.139.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 20 Sep 2025 22:39:43 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.020; Sat, 20 Sep 2025 22:39:43 +0000
From: "Bandi, Ravi Kumar" <ravib@amazon.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Index: AQHcKkZ7CT5uBPbZrkSRzox+cc3ml7ScqlAA
Date: Sat, 20 Sep 2025 22:39:42 +0000
Message-ID: <C47CF283-C0C4-4ACF-BE07-3E87153D6EC6@amazon.com>
References: <20250919231330.886-1-ravib@amazon.com>
 <472oclxowztq4zfvtqjdrn4whe2hpcecgmgmsrkw2gwfuvac7r@xrgouxxp3qva>
In-Reply-To: <472oclxowztq4zfvtqjdrn4whe2hpcecgmgmsrkw2gwfuvac7r@xrgouxxp3qva>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0C24B00BA1D574FBB32E7AAF46C9175@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8gTWFuaSwNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLg0KDQo+IE9uIFNl
cCAyMCwgMjAyNSwgYXQgODo1MeKAr0FNLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbmlAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJv
bSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiBPbiBGcmksIFNlcCAxOSwgMjAyNSBh
dCAxMToxMzozMFBNICswMDAwLCBSYXZpIEt1bWFyIEJhbmRpIHdyb3RlOg0KPiANCj4gKyBUaGlw
cGVzd2FteSAoYXV0aG9yIG9yIDhkNzg2MTQ5ZDc4YykNCg0KVGhhbmtzIGZvciBhZGRpbmcuDQoN
Cj4gDQo+PiBTdGFydGluZyB3aXRoIGtlcm5lbCA2LjYuMCwgbGVnYWN5IGludGVycnVwdHMgZnJv
bSBQQ0llIGVuZHBvaW50cw0KPj4gZG8gbm90IGZsb3cgdGhyb3VnaCB0aGUgWGlsaW54IFhETUEg
cm9vdCBwb3J0IGJyaWRnZSBiZWNhdXNlDQo+PiBpbnRlcnJ1cHRzIGFyZSBub3QgZW5hYmxlZCBh
ZnRlciBpbml0aWFsaXppbmcgdGhlIHBvcnQuDQo+PiANCj4+IFRoaXMgaXNzdWUgaXMgc2VlbiBh
ZnRlciBYRE1BIGRyaXZlciByZWNlaXZlZCBzdXBwb3J0IGZvciBRRE1BIGFuZA0KPj4gdW5kZXJ3
ZW50IHJlbGV2YW50IGNvZGUgcmVzdHJ1Y3R1cmluZyBvZiBvbGQgeGRtYS1wbCBkcml2ZXIgdG8N
Cj4+IHhpbGlueC1kbWEtcGwgKHJlZiBjb21taXQ6IDhkNzg2MTQ5ZDc4YykuDQo+PiANCj4gDQo+
IFRoZSBhYm92ZSBtZW50aW9uZWQgY29tbW1pdCBhZGRlZCBhIG5ldyBkcml2ZXIuIFNvIEkgZG9u
J3Qgc2VlIHdoZW4gdGhlIGRyaXZlcg0KPiByZXN0cnVjdHVyaW5nIGhhcHBlbmVkLg0KDQpBY2su
IEnigJl2ZSB1cGRhdGVkIHRoZSBjb21taXQgbWVzc2FnZSBpbiB0aGUgdjIuDQoNCj4gDQo+PiBU
aGlzIHBhdGNoIHJlLWVuYWJsZXMgbGVnYWN5IGludGVycnVwdHMgdG8gdXNlIHdpdGggUENJZSBl
bmRwb2ludHMNCj4+IHdpdGggbGVnYWN5IGludGVycnVwdHMuDQo+IA0KPiBzL2xlZ2FjeS9JTlR4
LCBoZXJlIGFuZCBldmVyeXdoZXJlLg0KDQpBY2suIFRha2VuIGNhcmUgaW4gdjIuDQoNCj4gDQo+
PiBUZXN0ZWQgdGhlIGZpeCBvbiBhIGJvYXJkIHdpdGggdHdvIGVuZHBvaW50cw0KPj4gZ2VuZXJh
dGluZyBsZWdhY3kgaW50ZXJydXB0cy4gSW50ZXJydXB0cyBhcmUgcHJvcGVybHkgZGV0ZWN0ZWQg
YW5kDQo+PiBzZXJ2aWNlZC4gVGhlIC9wcm9jL2ludGVycnVwdHMgb3V0cHV0IHNob3dzOg0KPj4g
Wy4uLl0NCj4+IDMyOiAgICAgICAgMzIwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTYg
TGV2ZWwgICAgIDQwMDAwMDAwMC5heGktcGNpZSwgYXpkcnYNCj4+IDUyOiAgICAgICAgNDcwICAg
ICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTYgTGV2ZWwgICAgIDUwMDAwMDAwMC5heGktcGNp
ZSwgYXpkcnYNCj4+IFsuLi5dDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFJhdmkgS3VtYXIgQmFu
ZGkgPHJhdmliQGFtYXpvbi5jb20+DQo+IA0KPiBNaXNzaW5nIEZpeGVzIHRhZyBhbmQgeW91IHNo
b3VsZCBDQyBzdGFibGUgbGlzdCBmb3IgYmFja3BvcnRpbmcuDQoNCkFjay4gQWRkZWQgdGhlIHRh
ZyBhbmQgQ0PigJllZCBzdGFibGUgbGlzdCBpbiB2Mi4NCg0KSeKAmWxsIHN1Ym1pdCB2MiB3aXRo
IHRoZSBjb21tZW50cyBpbmNvcnBvcmF0ZWQsIHBsZWFzZSByZXZpZXcuDQoNClRoYW5rcywNClJh
dmkNCg0KPiANCj4gLSBNYW5pDQo+IA0KPj4gLS0tDQo+PiBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUteGlsaW54LWRtYS1wbC5jIHwgNiArKysrKysNCj4+IDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS14aWxpbngtZG1hLXBsLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54
LWRtYS1wbC5jDQo+PiBpbmRleCBiMDM3YzhmMzE1ZTQuLmNjNTM5MjkyZDEwYSAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtZG1hLXBsLmMNCj4+ICsr
KyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtZG1hLXBsLmMNCj4+IEBAIC02
NTksNiArNjU5LDEyIEBAIHN0YXRpYyBpbnQgeGlsaW54X3BsX2RtYV9wY2llX3NldHVwX2lycShz
dHJ1Y3QgcGxfZG1hX3BjaWUgKnBvcnQpDQo+PiAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4+
ICAgICAgfQ0KPj4gDQo+PiArICAgICAvKiBFbmFibGUgaW50ZXJydXB0cyAqLw0KPj4gKyAgICAg
cGNpZV93cml0ZShwb3J0LCBYSUxJTlhfUENJRV9ETUFfSU1SX0FMTF9NQVNLLA0KPj4gKyAgICAg
ICAgICAgICAgICBYSUxJTlhfUENJRV9ETUFfUkVHX0lNUik7DQo+PiArICAgICBwY2llX3dyaXRl
KHBvcnQsIFhJTElOWF9QQ0lFX0RNQV9JRFJOX01BU0ssDQo+PiArICAgICAgICAgICAgICAgIFhJ
TElOWF9QQ0lFX0RNQV9SRUdfSURSTl9NQVNLKTsNCj4+ICsNCj4+ICAgICAgcmV0dXJuIDA7DQo+
PiB9DQo+PiANCj4+IC0tDQo+PiAyLjQ3LjMNCj4+IA0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K61
4K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0KDQo=

