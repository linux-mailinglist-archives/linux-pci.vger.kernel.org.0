Return-Path: <linux-pci+bounces-39484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E080C122CF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 01:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7C2D351BCE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 00:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E371AA7BF;
	Tue, 28 Oct 2025 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MHZ8Agea"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3D2F5E;
	Tue, 28 Oct 2025 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611807; cv=none; b=HKTwCuOkQgH/h8I4YERzh33v6wbWo1AZsXEWv9bEHv7VOOLzOKoIMfJMs6fym8z0nc1te1mOVBJzC4N7rkEVU+1V838X8G/im9cy5cMtkvWCDjy27nMszdYW5GqQQn9Ygh3OnLJ1I/9l0KqZOZ0VJQ+mNTkTms1BSv8yhrSxFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611807; c=relaxed/simple;
	bh=IOVvQiJpGvp6+xA294rJerEG3dTHQnXxn46jZXjb5wY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hF027/aeHCZEzFmw1zhdl/5jIKmpzlaXvB3QfX9wGPi9w9b9Trp0lJtWo/OkFNzP+5RIMiYe2QYMqmRTZIyoHe7YX0aTaWlUpQ2B9A6wgU7LR/A8srVYSBOXcOPftspN4Fi6kADSwxqyd/2SOMAnmvR2lmRc0NfIBKXZirt/pH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MHZ8Agea; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761611806; x=1793147806;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=IOVvQiJpGvp6+xA294rJerEG3dTHQnXxn46jZXjb5wY=;
  b=MHZ8AgeaCjyEt2/ATdpHwmTnzSYo8MP7fOnjyRwzmDQBBJWr2AwL2OLp
   s9+fwuixAILG0J8SRyEJKjNZGLQswAOUc3nOQ4eNUNdEeEDKJsCTlJf5/
   jgTud9+aUzM9NC+fw2h+I0jWcxkMG8muetGGae0Z/4Hb9nhCEOm595rvC
   HOTO6oorRX/oO6f6FAfElIPw3i7/vUs+4uybcEEzj24+kgyM7x8MMXyRx
   /u4KaEG9+tqwftjuHPxdNyHFqaBVV0kunad3ityFFQ+Nfc8Oqc18kBIGO
   y4towwEQlTPgZvEBvCuqmIQNfWdM5yLUK5NO4duHRC5R4n4OkXDc1r0N3
   Q==;
X-CSE-ConnectionGUID: 26SJ8qqZRE+FNdoNM3ro3g==
X-CSE-MsgGUID: YiTQtjjxR1CtkjkcG+NhGw==
X-IronPort-AV: E=Sophos;i="6.19,260,1754956800"; 
   d="scan'208";a="5635122"
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 00:36:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:26105]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.51:2525] with esmtp (Farcaster)
 id 9f41d556-68c3-4916-acdf-260b786a1eb9; Tue, 28 Oct 2025 00:36:45 +0000 (UTC)
X-Farcaster-Flow-ID: 9f41d556-68c3-4916-acdf-260b786a1eb9
Received: from EX19D032UWA004.ant.amazon.com (10.13.139.56) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 28 Oct 2025 00:36:37 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA004.ant.amazon.com (10.13.139.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 28 Oct 2025 00:36:37 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.029; Tue, 28 Oct 2025 00:36:37 +0000
From: "Bandi, Ravi Kumar" <ravib@amazon.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>
CC: "thippeswamy.havalige@amd.com" <thippeswamy.havalige@amd.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Stefan Roese <stefan.roese@mailbox.org>, "Musham,
 Sai Krishna" <sai.krishna.musham@amd.com>, Sean Anderson
	<sean.anderson@linux.dev>, "Yeleswarapu, Nagaradhesh"
	<nagaradhesh.yeleswarapu@amd.com>
Thread-Index: AQHcKoFWBnk90o/gZUOv7QYU+iHxwrTJOZeAgA2kSICAABLnAA==
Date: Tue, 28 Oct 2025 00:36:36 +0000
Message-ID: <C863FB65-E6B8-48B8-A2FF-779330D9BE5A@amazon.com>
References: <20251027232847.GA1488235@bhelgaas>
In-Reply-To: <20251027232847.GA1488235@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <34DBB2AF1B6DC649B354F3E881A47C26@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gT24gT2N0IDI3LCAyMDI1LCBhdCA0OjI44oCvUE0sIEJqb3JuIEhlbGdhYXMgPGhlbGdh
YXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQg
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiBbK2NjIFN0ZWZhbiBldCBh
bF0NCj4gDQo+IE9uIFN1biwgT2N0IDE5LCAyMDI1IGF0IDEyOjM5OjI1UE0gKzA1MzAsIE1hbml2
YW5uYW4gU2FkaGFzaXZhbSB3cm90ZToNCj4+IE9uIFNhdCwgMjAgU2VwIDIwMjUgMjI6NTI6MzIg
KzAwMDAsIFJhdmkgS3VtYXIgQmFuZGkgd3JvdGU6DQo+Pj4gVGhlIHBjaWUteGlsaW54LWRtYS1w
bCBkcml2ZXIgZG9lcyBub3QgZW5hYmxlIElOVHggaW50ZXJydXB0cw0KPj4+IGFmdGVyIGluaXRp
YWxpemluZyB0aGUgcG9ydCwgcHJldmVudGluZyBJTlR4IGludGVycnVwdHMgZnJvbQ0KPj4+IFBD
SWUgZW5kcG9pbnRzIGZyb20gZmxvd2luZyB0aHJvdWdoIHRoZSBYaWxpbnggWERNQSByb290IHBv
cnQNCj4+PiBicmlkZ2UuIFRoaXMgaXNzdWUgYWZmZWN0cyBrZXJuZWwgNi42LjAgYW5kIGxhdGVy
IHZlcnNpb25zLg0KPj4+IA0KPj4+IFRoaXMgcGF0Y2ggYWxsb3dzIElOVHggaW50ZXJydXB0cyBn
ZW5lcmF0ZWQgYnkgUENJZSBlbmRwb2ludHMNCj4+PiB0byBmbG93IHRocm91Z2ggdGhlIHJvb3Qg
cG9ydC4gVGVzdGVkIHRoZSBmaXggb24gYSBib2FyZCB3aXRoDQo+Pj4gdHdvIGVuZHBvaW50cyBn
ZW5lcmF0aW5nIElOVHggaW50ZXJydXB0cy4gSW50ZXJydXB0cyBhcmUNCj4+PiBwcm9wZXJseSBk
ZXRlY3RlZCBhbmQgc2VydmljZWQuIFRoZSAvcHJvYy9pbnRlcnJ1cHRzIG91dHB1dA0KPj4+IHNo
b3dzOg0KPj4+IA0KPj4+IFsuLi5dDQo+PiANCj4+IEFwcGxpZWQsIHRoYW5rcyENCj4+IA0KPj4g
WzEvMV0gUENJOiB4aWxpbngteGRtYTogRW5hYmxlIElOVHggaW50ZXJydXB0cw0KPj4gICAgICBj
b21taXQ6IGMwOThjMTNmNDM2NWU2NzUwMDA5YmU0ZDkwZGJhMzZmYTRhMTliNGUNCj4gDQo+IFBy
ZXR0eSBzdXJlIHdlIGhhdmUgY29uZmlybWF0aW9uIHRoYXQgd2UgZG9uJ3QgbmVlZCBlaXRoZXIg
dGhpcyBwYXRjaA0KPiBvciBTdGVmYW4ncyBwYXRjaCwgc28gSSByZW1vdmVkIHRoZSBwY2kvY29u
dHJvbGxlci94aWxpbngtZG1hIGJyYW5jaC4NCj4gDQo+IEl0IHdhcyBhdCAyMDAyNDc4ZTUwMzQg
KCJQQ0k6IHhpbGlueC14ZG1hOiBFbmFibGUgSU5UeCBpbnRlcnJ1cHRzIikgaW4NCj4gY2FzZSB3
ZSBuZWVkIHRvIHJlc3VycmVjdCBpdC4NCj4gDQo+IElJVUMsIFN0ZWZhbiBjb25maXJtZWQgdGhh
dCBoZSBkaWRuJ3QgbmVlZCB0aGlzIHBhdGNoIChSYXZpJ3MpIFsxXSwNCj4gYW5kIHRoYXQgYWZ0
ZXIgVml2YWRvIGlzIGZpeGVkIHRvIGdlbmVyYXRlIHRoZSBjb3JyZWN0IGludGVycnVwdC1tYXAs
DQo+IGhpcyBwYXRjaCAoU3RlZmFuJ3MpIHdvbid0IGJlIG5lZWRlZCBlaXRoZXIgWzJdLg0KPiAN
Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjliYzVlOTItMDRjOS00NzVhLWJhM2Qt
YTVlYTI2ZjFjOTVhQG1haWxib3gub3JnDQo+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzljN2U0M2MzLTI0ZTktNGIwOC1hNmNlLTIwMzViNTAyMjZmNEBtYWlsYm94Lm9yZw0KDQpIZWxs
byBCam9ybiwgYW5kIE1hbmkgZXQgYWwuLA0KDQpUaGFuayB5b3UgZm9yIHRha2luZyB0aGUgdGlt
ZSB0byByZXZpZXcgdGhlIHBhdGNoIGFuZCBleHBsYWluIHRoZSByZWFzb25pbmcuDQoNClNpbmNl
cmx5LA0KUmF2aQ0KDQo=

