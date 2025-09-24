Return-Path: <linux-pci+bounces-36830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6708CB985BE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 08:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836FE19C3CC6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D522DFA4;
	Wed, 24 Sep 2025 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sbCtCT2g"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158A20E704;
	Wed, 24 Sep 2025 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694440; cv=none; b=ro9TEkas4LjzPGACfqVU9ma5dH8N6GRTucsvJDck48EfHQEOoBFEd2e83uvJFx32Zhnz5l9/J2d840nPlpp+OMnLr36A3CQWMvHl6b/tWiAVUMVQmrPE400SqIp89knVCWviNC3a7qgG9ky9MXnjuK/+0GUG9XI/8ggyFef5hVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694440; c=relaxed/simple;
	bh=oL5K5vqLXDjohbzGu1q9kXasuqJsPhJHn3iFihsVwYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g1T8TF5ZDblCZ30H/VkkNUb+dvlb/9wv2kvabrbYfYrq0OWjOjzijfKLUbgy5IUwQ3hInXrW5WxT2F06kUvhSLh+zQ/X9CCamgC6u9AcrqTho1UWqF4anxQ5c4VEU7hgJ1pWvwWHwcildbtfYZ7Io4CxLrPP8Vs+huoolHdXiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sbCtCT2g; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758694438; x=1790230438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oL5K5vqLXDjohbzGu1q9kXasuqJsPhJHn3iFihsVwYQ=;
  b=sbCtCT2gEnlSFMePiqoTTTDfyDvqDYsmCdL+p/ftpuAsIO3bfAKCYd0i
   cjZes+ikNG1GxmsI6Jcp3ZOHf4YWleIVpcA5zdy4sEsXqJTBz3XOBn8W1
   t9zVcMgXieCGSPS5Qu3MDqN0Yu+GB+wZ1uQySBMo48YuFfde3MLh4H7US
   Sf3T8MTgsEkIq1gAoCBLpo/3LrfVcrtb2rBxgW7HuTRBb+sQXWusASg2C
   1nsPE6haFQUQWxC5frrvABZNykDdTq8kqHlu3tmQ2MZJtHXoA+Qwf/wLn
   8ueDaqoTzfacnkGeZwBpAEXdXHsn45Veuao8rzprHZb3b6yF6O3bf3B4u
   g==;
X-CSE-ConnectionGUID: zJCroIsQSdmcKOPQ2SVXNA==
X-CSE-MsgGUID: ER1XdZmMSJ+0IpSaHds0Rw==
X-IronPort-AV: E=Sophos;i="6.18,290,1751241600"; 
   d="scan'208";a="3645442"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:13:58 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:6491]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.168:2525] with esmtp (Farcaster)
 id 032be64e-1622-49e8-a2e4-203efa474f45; Wed, 24 Sep 2025 06:13:58 +0000 (UTC)
X-Farcaster-Flow-ID: 032be64e-1622-49e8-a2e4-203efa474f45
Received: from EX19D032UWA004.ant.amazon.com (10.13.139.56) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 24 Sep 2025 06:13:55 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA004.ant.amazon.com (10.13.139.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 24 Sep 2025 06:13:55 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.020; Wed, 24 Sep 2025 06:13:55 +0000
From: "Bandi, Ravi Kumar" <ravib@amazon.com>
To: "mani@kernel.org" <mani@kernel.org>, "thippeswamy.havalige@amd.com"
	<thippeswamy.havalige@amd.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Index: AQHcKoFWBnk90o/gZUOv7QYU+iHxwrSh38GA
Date: Wed, 24 Sep 2025 06:13:55 +0000
Message-ID: <AB21188C-0467-4378-AD3B-34093EC88AA9@amazon.com>
References: <C47CF283-C0C4-4ACF-BE07-3E87153D6EC6@amazon.com>
 <20250920225232.18757-1-ravib@amazon.com>
In-Reply-To: <20250920225232.18757-1-ravib@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F0679158EB19D4092812EA5536C56AD@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8gTWFuaSwgVGhpcHBlc3dhbXksDQoNCkEgZ2VudGxlIHJlbWluZGVyIHRvIHJldmlldyBw
YXRjaCB2Mi4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBhZGRpdGlvbmFsIGlu
Zm9ybWF0aW9uLiBUaGFua3MuDQoNClNpbmNlcmVseSwNClJhdmkNCg0KPiBPbiBTZXAgMjAsIDIw
MjUsIGF0IDM6NTLigK9QTSwgQmFuZGksIFJhdmkgS3VtYXIgPHJhdmliQGFtYXpvbi5jb20+IHdy
b3RlOg0KPiANCj4gVGhlIHBjaWUteGlsaW54LWRtYS1wbCBkcml2ZXIgZG9lcyBub3QgZW5hYmxl
IElOVHggaW50ZXJydXB0cw0KPiBhZnRlciBpbml0aWFsaXppbmcgdGhlIHBvcnQsIHByZXZlbnRp
bmcgSU5UeCBpbnRlcnJ1cHRzIGZyb20NCj4gUENJZSBlbmRwb2ludHMgZnJvbSBmbG93aW5nIHRo
cm91Z2ggdGhlIFhpbGlueCBYRE1BIHJvb3QgcG9ydA0KPiBicmlkZ2UuIFRoaXMgaXNzdWUgYWZm
ZWN0cyBrZXJuZWwgNi42LjAgYW5kIGxhdGVyIHZlcnNpb25zLg0KPiANCj4gVGhpcyBwYXRjaCBh
bGxvd3MgSU5UeCBpbnRlcnJ1cHRzIGdlbmVyYXRlZCBieSBQQ0llIGVuZHBvaW50cw0KPiB0byBm
bG93IHRocm91Z2ggdGhlIHJvb3QgcG9ydC4gVGVzdGVkIHRoZSBmaXggb24gYSBib2FyZCB3aXRo
DQo+IHR3byBlbmRwb2ludHMgZ2VuZXJhdGluZyBJTlR4IGludGVycnVwdHMuIEludGVycnVwdHMg
YXJlDQo+IHByb3Blcmx5IGRldGVjdGVkIGFuZCBzZXJ2aWNlZC4gVGhlIC9wcm9jL2ludGVycnVw
dHMgb3V0cHV0DQo+IHNob3dzOg0KPiANCj4gWy4uLl0NCj4gMzI6ICAgICAgICAzMjAgICAgICAg
ICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAxNiBMZXZlbCAgICAgNDAwMDAwMDAwLmF4aS1wY2llLCBh
emRydg0KPiA1MjogICAgICAgIDQ3MCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgIDE2IExl
dmVsICAgICA1MDAwMDAwMDAuYXhpLXBjaWUsIGF6ZHJ2DQo+IFsuLi5dDQo+IA0KPiBDaGFuZ2Vz
IHNpbmNlIHYxOjoNCj4gLSBGaXhlZCBjb21taXQgbWVzc2FnZSBwZXIgcmV2aWV3ZXIncyBjb21t
ZW50cw0KPiANCj4gRml4ZXM6IDhkNzg2MTQ5ZDc4YyAoIlBDSTogeGlsaW54LXhkbWE6IEFkZCBY
aWxpbnggWERNQSBSb290IFBvcnQgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU2lnbmVkLW9mZi1ieTogUmF2aSBLdW1hciBCYW5kaSA8cmF2aWJAYW1hem9uLmNvbT4N
Cj4gLS0tDQo+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtZG1hLXBsLmMgfCA2
ICsrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhpbGlueC1kbWEtcGwuYyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtZG1hLXBsLmMNCj4gaW5kZXggYjAzN2M4ZjMx
NWU0Li5jYzUzOTI5MmQxMGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS14aWxpbngtZG1hLXBsLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LXhpbGlueC1kbWEtcGwuYw0KPiBAQCAtNjU5LDYgKzY1OSwxMiBAQCBzdGF0aWMgaW50IHhpbGlu
eF9wbF9kbWFfcGNpZV9zZXR1cF9pcnEoc3RydWN0IHBsX2RtYV9wY2llICpwb3J0KQ0KPiAJCXJl
dHVybiBlcnI7DQo+IAl9DQo+IA0KPiArCS8qIEVuYWJsZSBpbnRlcnJ1cHRzICovDQo+ICsJcGNp
ZV93cml0ZShwb3J0LCBYSUxJTlhfUENJRV9ETUFfSU1SX0FMTF9NQVNLLA0KPiArCQkgICBYSUxJ
TlhfUENJRV9ETUFfUkVHX0lNUik7DQo+ICsJcGNpZV93cml0ZShwb3J0LCBYSUxJTlhfUENJRV9E
TUFfSURSTl9NQVNLLA0KPiArCQkgICBYSUxJTlhfUENJRV9ETUFfUkVHX0lEUk5fTUFTSyk7DQo+
ICsNCj4gCXJldHVybiAwOw0KPiB9DQo+IA0KPiAtLSANCj4gMi40Ny4zDQo+IA0KDQo=

