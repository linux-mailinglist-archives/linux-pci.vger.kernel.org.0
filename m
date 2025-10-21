Return-Path: <linux-pci+bounces-38933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F46BF7F35
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 19:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 633CF4E8F7E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BB34846F;
	Tue, 21 Oct 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y7zUSrek"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D12E718F;
	Tue, 21 Oct 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068780; cv=none; b=X51ZSGqrbGLF09oucl9MX+9f6rZSGEuswR3MwDFPfMI/umKQSXYuoucH96iyKpffzrLRdnhYQfL4e8PKEagrEzNxZ3i6yVwZZnYPnCLfrQCKB0z636OcfMP8oJyVkEIQO636nMgWQ0QFA9/EOE3q8GQrxLBP/Kktw8PSDUnQo7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068780; c=relaxed/simple;
	bh=aYqM551WXgRWcIxaDDOdYAjJq+79sGBmvMwwGursdzo=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F4dVZcQX8xUU5kIWJKMXayPYpATgSLHQBu/FyyR3G5Gme8G/bVx+njRAPYXWRLQB0DV9zmNpKjMR+n5bqOHGJqyVt1Mp9IEyCbnlaVLeGg0dBPbrmEvt7qH9edNBJe5jRlGPxRLtfoy/Te7Kvn/o7lYVIGRBT/iVSwZvg6+JGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y7zUSrek; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761068778; x=1792604778;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=aYqM551WXgRWcIxaDDOdYAjJq+79sGBmvMwwGursdzo=;
  b=Y7zUSrekEwGtfq2j/7+h4kraDEzZT3BwoXzbRRcqaItgtWSPpTGYrjt8
   EhtqKtSIiRVSwfy2zDRBrM6PlfF5SdXk2BIwOpxquDAsFmm1lHok2mOq2
   RX4DbAecwxg4X0NKDp/kTB4orEXnbCwtOPR5ZG3WGl2VvjZ7FdClKKlR2
   kaOZ3NT3rGmiuDskvf7Xhl2aaabynaV3rruH6llH/ktsncyAXDVkcX2N6
   TMExA49X+AIR65B2HhC/zwUvAo1K+WyUK/dI0VI0bVYMrvU/Jk/Wf01mY
   rxvjpB+wUiJ1vlFEPs5yjU/PFlMcfgEOvTXr3xMHMCpUr1DMkadTcYJ61
   A==;
X-CSE-ConnectionGUID: v8diPBoXTWOd3sF/Vw2+Xg==
X-CSE-MsgGUID: yjXNLWvyQoiOmCuQRMv8SQ==
X-IronPort-AV: E=Sophos;i="6.19,245,1754956800"; 
   d="scan'208";a="5228112"
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 17:46:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:25913]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.196:2525] with esmtp (Farcaster)
 id e87fd396-6f95-4dbf-a220-ca3b6b5c9337; Tue, 21 Oct 2025 17:46:17 +0000 (UTC)
X-Farcaster-Flow-ID: e87fd396-6f95-4dbf-a220-ca3b6b5c9337
Received: from EX19D032UWA001.ant.amazon.com (10.13.139.62) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 17:46:17 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA001.ant.amazon.com (10.13.139.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 17:46:17 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.020; Tue, 21 Oct 2025 17:46:17 +0000
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
Thread-Index: AQHcKoFWBnk90o/gZUOv7QYU+iHxwrTNCbqAgAAGagA=
Date: Tue, 21 Oct 2025 17:46:17 +0000
Message-ID: <AB5963BB-A896-4CFA-AF27-31164705DF5A@amazon.com>
References: <20251021172309.GA1198438@bhelgaas>
In-Reply-To: <20251021172309.GA1198438@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <20ED62179285C540AE886CB28A73D7D2@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQo+IE9uIE9jdCAyMSwgMjAyNSwgYXQgMTA6MjPigK9BTSwgQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fh
c0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRl
ZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IFsrY2MgU3RlZmFuLCBTZWFu
XQ0KPiANCj4gT24gU2F0LCBTZXAgMjAsIDIwMjUgYXQgMTA6NTI6MzJQTSArMDAwMCwgUmF2aSBL
dW1hciBCYW5kaSB3cm90ZToNCj4+IFRoZSBwY2llLXhpbGlueC1kbWEtcGwgZHJpdmVyIGRvZXMg
bm90IGVuYWJsZSBJTlR4IGludGVycnVwdHMNCj4+IGFmdGVyIGluaXRpYWxpemluZyB0aGUgcG9y
dCwgcHJldmVudGluZyBJTlR4IGludGVycnVwdHMgZnJvbQ0KPj4gUENJZSBlbmRwb2ludHMgZnJv
bSBmbG93aW5nIHRocm91Z2ggdGhlIFhpbGlueCBYRE1BIHJvb3QgcG9ydA0KPj4gYnJpZGdlLiBU
aGlzIGlzc3VlIGFmZmVjdHMga2VybmVsIDYuNi4wIGFuZCBsYXRlciB2ZXJzaW9ucy4NCj4+IA0K
Pj4gVGhpcyBwYXRjaCBhbGxvd3MgSU5UeCBpbnRlcnJ1cHRzIGdlbmVyYXRlZCBieSBQQ0llIGVu
ZHBvaW50cw0KPj4gdG8gZmxvdyB0aHJvdWdoIHRoZSByb290IHBvcnQuIFRlc3RlZCB0aGUgZml4
IG9uIGEgYm9hcmQgd2l0aA0KPj4gdHdvIGVuZHBvaW50cyBnZW5lcmF0aW5nIElOVHggaW50ZXJy
dXB0cy4gSW50ZXJydXB0cyBhcmUNCj4+IHByb3Blcmx5IGRldGVjdGVkIGFuZCBzZXJ2aWNlZC4g
VGhlIC9wcm9jL2ludGVycnVwdHMgb3V0cHV0DQo+PiBzaG93czoNCj4+IA0KPj4gWy4uLl0NCj4+
IDMyOiAgICAgICAgMzIwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTYgTGV2ZWwgICAg
IDQwMDAwMDAwMC5heGktcGNpZSwgYXpkcnYNCj4+IDUyOiAgICAgICAgNDcwICAgICAgICAgIDAg
IHBsX2RtYTpSQy1FdmVudCAgMTYgTGV2ZWwgICAgIDUwMDAwMDAwMC5heGktcGNpZSwgYXpkcnYN
Cj4+IFsuLi5dDQo+PiANCj4+IENoYW5nZXMgc2luY2UgdjE6Og0KPj4gLSBGaXhlZCBjb21taXQg
bWVzc2FnZSBwZXIgcmV2aWV3ZXIncyBjb21tZW50cw0KPj4gDQo+PiBGaXhlczogOGQ3ODYxNDlk
NzhjICgiUENJOiB4aWxpbngteGRtYTogQWRkIFhpbGlueCBYRE1BIFJvb3QgUG9ydCBkcml2ZXIi
KQ0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IFJhdmkg
S3VtYXIgQmFuZGkgPHJhdmliQGFtYXpvbi5jb20+DQo+IA0KPiBIaSBSYXZpLCBvYnZpb3VzbHkg
eW91IHRlc3RlZCB0aGlzLCBidXQgSSBkb24ndCBrbm93IGhvdyB0byByZWNvbmNpbGUNCj4gdGhp
cyB3aXRoIFN0ZWZhbidzIElOVHggZml4IGF0DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyNTEwMjExNTQzMjIuOTczNjQwLTEtc3RlZmFuLnJvZXNlQG1haWxib3gub3JnDQo+IA0KPiBE
b2VzIFN0ZWZhbidzIGZpeCBuZWVkIHRvIGJlIHNxdWFzaGVkIGludG8gdGhpcyBwYXRjaD8NCg0K
SGkgQmpvcm4sDQoNClN1cmUsIHdlIGNhbiBzcXVhc2ggU3RlZmFu4oCZcyBmaXggaW50byB0aGlz
Lg0KDQpUaGFua3MNClJhdmkNCg0KPiANCj4+IC0tLQ0KPj4gZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLXhpbGlueC1kbWEtcGwuYyB8IDYgKysrKysrDQo+PiAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUteGlsaW54LWRtYS1wbC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhpbGlu
eC1kbWEtcGwuYw0KPj4gaW5kZXggYjAzN2M4ZjMxNWU0Li5jYzUzOTI5MmQxMGEgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWRtYS1wbC5jDQo+PiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWRtYS1wbC5jDQo+PiBAQCAt
NjU5LDYgKzY1OSwxMiBAQCBzdGF0aWMgaW50IHhpbGlueF9wbF9kbWFfcGNpZV9zZXR1cF9pcnEo
c3RydWN0IHBsX2RtYV9wY2llICpwb3J0KQ0KPj4gICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+
PiAgICAgIH0NCj4+IA0KPj4gKyAgICAgLyogRW5hYmxlIGludGVycnVwdHMgKi8NCj4+ICsgICAg
IHBjaWVfd3JpdGUocG9ydCwgWElMSU5YX1BDSUVfRE1BX0lNUl9BTExfTUFTSywNCj4+ICsgICAg
ICAgICAgICAgICAgWElMSU5YX1BDSUVfRE1BX1JFR19JTVIpOw0KPj4gKyAgICAgcGNpZV93cml0
ZShwb3J0LCBYSUxJTlhfUENJRV9ETUFfSURSTl9NQVNLLA0KPj4gKyAgICAgICAgICAgICAgICBY
SUxJTlhfUENJRV9ETUFfUkVHX0lEUk5fTUFTSyk7DQo+PiArDQo+PiAgICAgIHJldHVybiAwOw0K
Pj4gfQ0KPj4gDQo+PiAtLQ0KPj4gMi40Ny4zDQo+PiANCg0K

