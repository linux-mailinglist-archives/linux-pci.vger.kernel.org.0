Return-Path: <linux-pci+bounces-38946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91DBF8D55
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 22:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A244A4E48A5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0536E2836B1;
	Tue, 21 Oct 2025 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="g5H3ZkhC"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D081350A33;
	Tue, 21 Oct 2025 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080150; cv=none; b=QDqCw+aAliGiFW1fhETgAGLM7SW8gUoaKkTkFeB1EUwKi7CR4UteNTuAjZgx4/pFt9pGiznCSIU84FXRwQdeEpGKDlTK1kEJ2TYIWmxFAFuBZo5HW1e2zecK5PcTnhJf2LPC8qJ+eeXDR6F7bW8+LxH8BKqjg0kK5T2KdaLs7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080150; c=relaxed/simple;
	bh=fiFBQjjENS/G7imXV4/j9mYKOjsTIr/TdtGp6kOnMkM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bo3kpoqKZY2GFQmLhjXZqOdF7odH38rUsunP1CH27DzmAFiofQbhy6DNXI9+WiTD3Te7X57bU4V66HSebg9T8llH9vvqYOo7dcUBJORhsG4tV1GqSJvjBASHo/PwNUDsE9a64IoyhIFv8cypQn4Lr4rjCETrcKFvyFrok1CYRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=g5H3ZkhC; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761080149; x=1792616149;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=fiFBQjjENS/G7imXV4/j9mYKOjsTIr/TdtGp6kOnMkM=;
  b=g5H3ZkhCKas7yGFk8qDxEaPGuSJgrLu5NuS3JVM6ecrE7ph6+l1cZkNl
   k/JbJoli1kuqS3dW4iBCTi9IDIogKS9kA3TvaW2dUN21YezXeuoI6QyaT
   MCfzIXPY5YvXxn0AwlbWg2tgGE1HN+wklQoT0j5bAfy6O3tQYzLaOU6Zy
   dheY8ZbZduVT3Ih1Gqd8EJfXC9vhSPRIjnOw/JX9TFgvb55pm2sHqL3cp
   Dad4VLqgoiQlg3Ayb3JE8AdWo6XKLPRLsJnzH1gvOAvDmnGQsv5UINija
   xfQ2I4g+iaiJO951jekIDPasEWKMYMzN4GMoqHkLVGcsVLKyUcJWTajYg
   Q==;
X-CSE-ConnectionGUID: 2vScnSQpRwiRk/dMiLDA6g==
X-CSE-MsgGUID: KKOT/EbzSv20zn9ltT/FDQ==
X-IronPort-AV: E=Sophos;i="6.19,245,1754956800"; 
   d="scan'208";a="5420279"
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 20:55:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:4023]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.51:2525] with esmtp (Farcaster)
 id 92bc11a8-80de-446d-9a67-b80609ead33f; Tue, 21 Oct 2025 20:55:46 +0000 (UTC)
X-Farcaster-Flow-ID: 92bc11a8-80de-446d-9a67-b80609ead33f
Received: from EX19D032UWA004.ant.amazon.com (10.13.139.56) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 20:55:41 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA004.ant.amazon.com (10.13.139.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 20:55:41 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.020; Tue, 21 Oct 2025 20:55:41 +0000
From: "Bandi, Ravi Kumar" <ravib@amazon.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "mani@kernel.org" <mani@kernel.org>, "thippeswamy.havalige@amd.com"
	<thippeswamy.havalige@amd.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "michal.simek@amd.com" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Stefan Roese <stefan.roese@mailbox.org>, "Sean
 Anderson" <sean.anderson@linux.dev>
Thread-Index: AQHcKoFWBnk90o/gZUOv7QYU+iHxwrTNCbqAgAAGagCAABd2AIAAHXUA
Date: Tue, 21 Oct 2025 20:55:41 +0000
Message-ID: <467D7D30-DC05-4612-87BA-7E980A9C0A4A@amazon.com>
References: <20251021191004.GA1205652@bhelgaas>
In-Reply-To: <20251021191004.GA1205652@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFFB64FF13DFA24CAFB2EC3B7E23B2C5@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gT24gT2N0IDIxLCAyMDI1LCBhdCAxMjoxMOKAr1BNLCBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5k
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiANCj4gT24gVHVlLCBPY3QgMjEs
IDIwMjUgYXQgMDU6NDY6MTdQTSArMDAwMCwgQmFuZGksIFJhdmkgS3VtYXIgd3JvdGU6DQo+Pj4g
T24gT2N0IDIxLCAyMDI1LCBhdCAxMDoyM+KAr0FNLCBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPj4+IE9uIFNhdCwgU2VwIDIwLCAyMDI1IGF0IDEwOjUyOjMyUE0g
KzAwMDAsIFJhdmkgS3VtYXIgQmFuZGkgd3JvdGU6DQo+Pj4+IFRoZSBwY2llLXhpbGlueC1kbWEt
cGwgZHJpdmVyIGRvZXMgbm90IGVuYWJsZSBJTlR4IGludGVycnVwdHMNCj4+Pj4gYWZ0ZXIgaW5p
dGlhbGl6aW5nIHRoZSBwb3J0LCBwcmV2ZW50aW5nIElOVHggaW50ZXJydXB0cyBmcm9tDQo+Pj4+
IFBDSWUgZW5kcG9pbnRzIGZyb20gZmxvd2luZyB0aHJvdWdoIHRoZSBYaWxpbnggWERNQSByb290
IHBvcnQNCj4+Pj4gYnJpZGdlLiBUaGlzIGlzc3VlIGFmZmVjdHMga2VybmVsIDYuNi4wIGFuZCBs
YXRlciB2ZXJzaW9ucy4NCj4+Pj4gDQo+Pj4+IFRoaXMgcGF0Y2ggYWxsb3dzIElOVHggaW50ZXJy
dXB0cyBnZW5lcmF0ZWQgYnkgUENJZSBlbmRwb2ludHMNCj4+Pj4gdG8gZmxvdyB0aHJvdWdoIHRo
ZSByb290IHBvcnQuIFRlc3RlZCB0aGUgZml4IG9uIGEgYm9hcmQgd2l0aA0KPj4+PiB0d28gZW5k
cG9pbnRzIGdlbmVyYXRpbmcgSU5UeCBpbnRlcnJ1cHRzLiBJbnRlcnJ1cHRzIGFyZQ0KPj4+PiBw
cm9wZXJseSBkZXRlY3RlZCBhbmQgc2VydmljZWQuIFRoZSAvcHJvYy9pbnRlcnJ1cHRzIG91dHB1
dA0KPj4+PiBzaG93czoNCj4+Pj4gDQo+Pj4+IFsuLi5dDQo+Pj4+IDMyOiAgICAgICAgMzIwICAg
ICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTYgTGV2ZWwgICAgIDQwMDAwMDAwMC5heGktcGNp
ZSwgYXpkcnYNCj4+Pj4gNTI6ICAgICAgICA0NzAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50
ICAxNiBMZXZlbCAgICAgNTAwMDAwMDAwLmF4aS1wY2llLCBhemRydg0KPj4+PiBbLi4uXQ0KPj4+
PiANCj4+Pj4gQ2hhbmdlcyBzaW5jZSB2MTo6DQo+Pj4+IC0gRml4ZWQgY29tbWl0IG1lc3NhZ2Ug
cGVyIHJldmlld2VyJ3MgY29tbWVudHMNCj4+Pj4gDQo+Pj4+IEZpeGVzOiA4ZDc4NjE0OWQ3OGMg
KCJQQ0k6IHhpbGlueC14ZG1hOiBBZGQgWGlsaW54IFhETUEgUm9vdCBQb3J0IGRyaXZlciIpDQo+
Pj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFJhdmkg
S3VtYXIgQmFuZGkgPHJhdmliQGFtYXpvbi5jb20+DQo+Pj4gDQo+Pj4gSGkgUmF2aSwgb2J2aW91
c2x5IHlvdSB0ZXN0ZWQgdGhpcywgYnV0IEkgZG9uJ3Qga25vdyBob3cgdG8gcmVjb25jaWxlDQo+
Pj4gdGhpcyB3aXRoIFN0ZWZhbidzIElOVHggZml4IGF0DQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI1MTAyMTE1NDMyMi45NzM2NDAtMS1zdGVmYW4ucm9lc2VAbWFpbGJveC5vcmcN
Cj4+PiANCj4+PiBEb2VzIFN0ZWZhbidzIGZpeCBuZWVkIHRvIGJlIHNxdWFzaGVkIGludG8gdGhp
cyBwYXRjaD8NCj4+IA0KPj4gU3VyZSwgd2UgY2FuIHNxdWFzaCBTdGVmYW7igJlzIGZpeCBpbnRv
IHRoaXMuDQo+IA0KPiBJIGtub3cgd2UgKmNhbiogc3F1YXNoIHRoZW0uDQo+IA0KPiBJIHdhbnQg
dG8ga25vdyB3aHkgdGhpbmdzIHdvcmtlZCBmb3IgeW91IGFuZCBTdGVmYW4gd2hlbiB0aGV5DQo+
ICp3ZXJlbid0KiBzcXVhc2hlZDoNCj4gDQo+ICAtIFdoeSBkaWQgSU5UeCB3b3JrIGZvciB5b3Ug
ZXZlbiB3aXRob3V0IFN0ZWZhbidzIHBhdGNoLiAgRGlkIHlvdQ0KPiAgICBnZXQgSU5UeCBpbnRl
cnJ1cHRzIGJ1dCBub3QgdGhlIHJpZ2h0IG9uZXMsIGUuZy4sIGRpZCB0aGUgZGV2aWNlDQo+ICAg
IHNpZ25hbCBJTlRBIGJ1dCBpdCB3YXMgcmVjZWl2ZWQgYXMgSU5UQj8NCg0KSSBzYXcgdGhhdCBp
bnRlcnJ1cHRzIHdlcmUgYmVpbmcgZ2VuZXJhdGVkIGJ5IHRoZSBlbmRwb2ludCBkZXZpY2UsIGJ1
dCBJIGRpZG7igJl0IHNwZWNpZmljYWxseSBjaGVjayBpZiB0aGV5IHdlcmUgY29ycmVjdGx5IHRy
YW5zbGF0ZWQgaW4gdGhlIGNvbnRyb2xsZXIuIEkgbm90aWNlZCB0aGF0IHRoZSBuZXcgZHJpdmVy
IHdhc24ndCBleHBsaWNpdGx5IGVuYWJsaW5nIHRoZSBpbnRlcnJ1cHRzLCBzbyBteSBmaXJzdCBh
cHByb2FjaCB3YXMgdG8gZW5hYmxlIHRoZW0sIHdoaWNoIGhlbHBlZCB0aGUgaW50ZXJydXB0cyBm
bG93IHRocm91Z2guDQoNCj4gDQo+ICAtIFdoeSBkaWQgU3RlZmFuJ3MgcGF0Y2ggd29yayBmb3Ig
aGltIGV2ZW4gd2l0aG91dCB5b3VyIHBhdGNoLiAgSG93DQo+ICAgIGNvdWxkIFN0ZWZhbidzIElO
VHggd29yayB3aXRob3V0IHRoZSBDU1Igd3JpdGVzIHRvIGVuYWJsZQ0KPiAgICBpbnRlcnJ1cHRz
Pw0KDQpJJ20gbm90IGVudGlyZWx5IHN1cmUgaWYgdGhlcmUgYXJlIGFueSBvdGhlciBkZXBlbmRl
bmNpZXMgaW4gdGhlIEZQR0EgYml0c3RyZWFtLiBJJ2xsIGludmVzdGlnYXRlIGZ1cnRoZXIgYW5k
IGdldCBiYWNrIHRvIHlvdS4NCg0KPiANCj4gIC0gV2h5IHlvdSBtZW50aW9uZWQgImtlcm5lbCA2
LjYuMCBhbmQgbGF0ZXIgdmVyc2lvbnMuIiAgOGQ3ODYxNDlkNzhjDQo+ICAgIGFwcGVhcmVkIGlu
IHY2LjcsIHNvIHdoeSB3b3VsZCB2Ni42LjAgd291bGQgYmUgYWZmZWN0ZWQ/DQoNCkFwb2xvZ2ll
cyBmb3Igbm90IGNsZWFybHkgbWVudGlvbmluZyB0aGUgdmVyc2lvbiBlYXJsaWVyLiBUaGlzIGlz
IGZyb20gdGhlIGxpbnV4LXhsbnggdHJlZSBvbiB0aGUgeGxueF9yZWJhc2VfdjYuNiBicmFuY2gs
IHdoaWNoIGluY2x1ZGVzIHRoZSBuZXcgWGlsaW54IHJvb3QgcG9ydCBkcml2ZXIgd2l0aCBRRE1B
IHN1cHBvcnQ6DQpodHRwczovL2dpdGh1Yi5jb20vWGlsaW54L2xpbnV4LXhsbngvYmxvYi94bG54
X3JlYmFzZV92Ni42X0xUUy9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWRtYS1w
bC5jDQoNCkluIGVhcmxpZXIgdmVyc2lvbnMsIHRoZSBkcml2ZXIgd2FzOg0KaHR0cHM6Ly9naXRo
dWIuY29tL1hpbGlueC9saW51eC14bG54L2Jsb2IveGxueF9yZWJhc2VfdjYuMV9MVFNfMjAyMy4x
X3VwZGF0ZS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGRtYS1wbC5jDQpUaGlzIG9sZGVy
IGRyaXZlciBoYWQgbm8gaXNzdWVzIHdpdGggaW50ZXJydXB0cy4NCg0KVGhlIG5ldyBkcml2ZXIg
aW50cm9kdWNlZCBpbiB2Ni43IGFuZCBsYXRlciBpcyBhIHJld3JpdGUgb2YgdGhlIG9sZCBvbmUs
IG5vdyB3aXRoIFFETUEgc3VwcG9ydCwgd2hpY2ggaGFzIGlzc3VlcyB3aXRoIElOVHggaW50ZXJy
dXB0cy4NCg0KVGhhbmsgeW91Lg0KDQo+IA0KPj4+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUteGlsaW54LWRtYS1wbC5jDQo+Pj4+IEBAIC02NTksNiArNjU5LDEyIEBAIHN0YXRp
YyBpbnQgeGlsaW54X3BsX2RtYV9wY2llX3NldHVwX2lycShzdHJ1Y3QgcGxfZG1hX3BjaWUgKnBv
cnQpDQo+Pj4+ICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+Pj4+ICAgICB9DQo+Pj4+IA0KPj4+
PiArICAgICAvKiBFbmFibGUgaW50ZXJydXB0cyAqLw0KPj4+PiArICAgICBwY2llX3dyaXRlKHBv
cnQsIFhJTElOWF9QQ0lFX0RNQV9JTVJfQUxMX01BU0ssDQo+Pj4+ICsgICAgICAgICAgICAgICAg
WElMSU5YX1BDSUVfRE1BX1JFR19JTVIpOw0KPj4+PiArICAgICBwY2llX3dyaXRlKHBvcnQsIFhJ
TElOWF9QQ0lFX0RNQV9JRFJOX01BU0ssDQo+Pj4+ICsgICAgICAgICAgICAgICAgWElMSU5YX1BD
SUVfRE1BX1JFR19JRFJOX01BU0spOw0KPj4+PiArDQo+Pj4+ICAgICByZXR1cm4gMDsNCj4+Pj4g
fQ0KDQo=

