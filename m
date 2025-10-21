Return-Path: <linux-pci+bounces-38949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 808FBBF8F36
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 23:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F19E0352859
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68401339A4;
	Tue, 21 Oct 2025 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="k+frwqSR"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31571284671;
	Tue, 21 Oct 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082563; cv=none; b=bxxPo6rvS2bk+aAcIBIm8jaaFkgD+TUjppMnG1dX0yQSiC1sqClyo6L/lVvq1QZToP1eEnjw7RdHGuFXKpmh0SYKMJH/RWCrV0xpQcuWPPbwObqmZBKTbEZ7UW4Wq+sOHinP8iogmcif6610xOHETm2nOkXqGLRFZjulXwhoKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082563; c=relaxed/simple;
	bh=SXNnleGSyhR4oPSuVgZ/uhNUwKh3kdhc6OmEQN+XRZY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r61JNeAVOWA2nvrd9i16To7zzEMvu5vt1gZNibW8gJMyvvoLK4AAJXg4NksUUT0Amp+97cSxbB8ieh36pIJ++Gc/aLO6euHdLg3BeCgo3bBhpwhS9PuOmiQXeaEiLHiSslvCmzuYlN7mSODEyqBmUWkO+hSyW3k51zH7BrB6yGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=k+frwqSR; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761082561; x=1792618561;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=SXNnleGSyhR4oPSuVgZ/uhNUwKh3kdhc6OmEQN+XRZY=;
  b=k+frwqSRAuUWX5vOSx8fbxlWbMkt2mhYdY6fSNwSydkFtMsNNxAA9bsC
   d/uz5Jgr/Zj0eedJiJ0PFlTegpUgni/Zue61CiXxvhXtcVKycFHC44XDO
   yayr5hW7it9k0wwyqRRVG/ov7WEPrF1SMOlPBuTd5MC3DtBa0H7Pdx7Gm
   i/PnMbHCReL0eWQKoU5aj0AkWjqxo4CydKA4DGSRMy9C1HsZtA9l1cjah
   ldTFRUSsZOnDkIS2PMtbhRE/yyyB0Ze69ZT5sBvZYG3E8TUldOPYaOffz
   xwHEBxfs++S0lwuS7eVXkYDzpbXHc/acVOfLyMepKV8MWJlIKDK4/essS
   w==;
X-CSE-ConnectionGUID: bm8Ao4P3ThurfkRoEKHZdA==
X-CSE-MsgGUID: Z9ZvF/S+QcGdW2Yi3jRCkQ==
X-IronPort-AV: E=Sophos;i="6.18,263,1751241600"; 
   d="scan'208";a="5433445"
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 21:36:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:25981]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.167:2525] with esmtp (Farcaster)
 id c0da4554-94b8-4153-9551-841755373c56; Tue, 21 Oct 2025 21:36:00 +0000 (UTC)
X-Farcaster-Flow-ID: c0da4554-94b8-4153-9551-841755373c56
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 21:36:00 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA003.ant.amazon.com (10.13.139.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 21:35:59 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.020; Tue, 21 Oct 2025 21:35:59 +0000
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
Thread-Index: AQHcKoFWBnk90o/gZUOv7QYU+iHxwrTNCbqAgAAGagCAABd2AIAAHXUAgAAJFYCAAAIugA==
Date: Tue, 21 Oct 2025 21:35:59 +0000
Message-ID: <79EDC9D1-5C29-4A9B-A615-304DCA37BE03@amazon.com>
References: <20251021212801.GA1224310@bhelgaas>
In-Reply-To: <20251021212801.GA1224310@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D1600E8DA36334899D6D67FE4A7241E@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gT24gT2N0IDIxLCAyMDI1LCBhdCAyOjI44oCvUE0sIEJqb3JuIEhlbGdhYXMgPGhlbGdh
YXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQg
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IA0KPiBPbiBUdWUsIE9jdCAyMSwg
MjAyNSBhdCAwODo1NTo0MVBNICswMDAwLCBCYW5kaSwgUmF2aSBLdW1hciB3cm90ZToNCj4+PiBP
biBUdWUsIE9jdCAyMSwgMjAyNSBhdCAwNTo0NjoxN1BNICswMDAwLCBCYW5kaSwgUmF2aSBLdW1h
ciB3cm90ZToNCj4+Pj4+IE9uIE9jdCAyMSwgMjAyNSwgYXQgMTA6MjPigK9BTSwgQmpvcm4gSGVs
Z2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4+IE9uIFNhdCwgU2VwIDIwLCAy
MDI1IGF0IDEwOjUyOjMyUE0gKzAwMDAsIFJhdmkgS3VtYXIgQmFuZGkgd3JvdGU6DQo+Pj4+Pj4g
VGhlIHBjaWUteGlsaW54LWRtYS1wbCBkcml2ZXIgZG9lcyBub3QgZW5hYmxlIElOVHggaW50ZXJy
dXB0cw0KPj4+Pj4+IGFmdGVyIGluaXRpYWxpemluZyB0aGUgcG9ydCwgcHJldmVudGluZyBJTlR4
IGludGVycnVwdHMgZnJvbQ0KPj4+Pj4+IFBDSWUgZW5kcG9pbnRzIGZyb20gZmxvd2luZyB0aHJv
dWdoIHRoZSBYaWxpbnggWERNQSByb290IHBvcnQNCj4+Pj4+PiBicmlkZ2UuIFRoaXMgaXNzdWUg
YWZmZWN0cyBrZXJuZWwgNi42LjAgYW5kIGxhdGVyIHZlcnNpb25zLg0KPj4+Pj4+IA0KPj4+Pj4+
IFRoaXMgcGF0Y2ggYWxsb3dzIElOVHggaW50ZXJydXB0cyBnZW5lcmF0ZWQgYnkgUENJZSBlbmRw
b2ludHMNCj4+Pj4+PiB0byBmbG93IHRocm91Z2ggdGhlIHJvb3QgcG9ydC4gVGVzdGVkIHRoZSBm
aXggb24gYSBib2FyZCB3aXRoDQo+Pj4+Pj4gdHdvIGVuZHBvaW50cyBnZW5lcmF0aW5nIElOVHgg
aW50ZXJydXB0cy4gSW50ZXJydXB0cyBhcmUNCj4+Pj4+PiBwcm9wZXJseSBkZXRlY3RlZCBhbmQg
c2VydmljZWQuIFRoZSAvcHJvYy9pbnRlcnJ1cHRzIG91dHB1dA0KPj4+Pj4+IHNob3dzOg0KPj4+
Pj4+IA0KPj4+Pj4+IFsuLi5dDQo+Pj4+Pj4gMzI6ICAgICAgICAzMjAgICAgICAgICAgMCAgcGxf
ZG1hOlJDLUV2ZW50ICAxNiBMZXZlbCAgICAgNDAwMDAwMDAwLmF4aS1wY2llLCBhemRydg0KPj4+
Pj4+IDUyOiAgICAgICAgNDcwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTYgTGV2ZWwg
ICAgIDUwMDAwMDAwMC5heGktcGNpZSwgYXpkcnYNCj4+Pj4+PiBbLi4uXQ0KPj4+Pj4+IA0KPj4+
Pj4+IENoYW5nZXMgc2luY2UgdjE6Og0KPj4+Pj4+IC0gRml4ZWQgY29tbWl0IG1lc3NhZ2UgcGVy
IHJldmlld2VyJ3MgY29tbWVudHMNCj4+Pj4+PiANCj4+Pj4+PiBGaXhlczogOGQ3ODYxNDlkNzhj
ICgiUENJOiB4aWxpbngteGRtYTogQWRkIFhpbGlueCBYRE1BIFJvb3QgUG9ydCBkcml2ZXIiKQ0K
Pj4+Pj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
UmF2aSBLdW1hciBCYW5kaSA8cmF2aWJAYW1hem9uLmNvbT4NCj4+Pj4+IA0KPj4+Pj4gSGkgUmF2
aSwgb2J2aW91c2x5IHlvdSB0ZXN0ZWQgdGhpcywgYnV0IEkgZG9uJ3Qga25vdyBob3cgdG8gcmVj
b25jaWxlDQo+Pj4+PiB0aGlzIHdpdGggU3RlZmFuJ3MgSU5UeCBmaXggYXQNCj4+Pj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTEwMjExNTQzMjIuOTczNjQwLTEtc3RlZmFuLnJvZXNl
QG1haWxib3gub3JnDQo+Pj4+PiANCj4+Pj4+IERvZXMgU3RlZmFuJ3MgZml4IG5lZWQgdG8gYmUg
c3F1YXNoZWQgaW50byB0aGlzIHBhdGNoPw0KPj4+PiANCj4+Pj4gU3VyZSwgd2UgY2FuIHNxdWFz
aCBTdGVmYW7igJlzIGZpeCBpbnRvIHRoaXMuDQo+Pj4gDQo+Pj4gSSBrbm93IHdlICpjYW4qIHNx
dWFzaCB0aGVtLg0KPj4+IA0KPj4+IEkgd2FudCB0byBrbm93IHdoeSB0aGluZ3Mgd29ya2VkIGZv
ciB5b3UgYW5kIFN0ZWZhbiB3aGVuIHRoZXkNCj4+PiAqd2VyZW4ndCogc3F1YXNoZWQ6DQo+Pj4g
DQo+Pj4gLSBXaHkgZGlkIElOVHggd29yayBmb3IgeW91IGV2ZW4gd2l0aG91dCBTdGVmYW4ncyBw
YXRjaC4gIERpZCB5b3UNCj4+PiAgIGdldCBJTlR4IGludGVycnVwdHMgYnV0IG5vdCB0aGUgcmln
aHQgb25lcywgZS5nLiwgZGlkIHRoZSBkZXZpY2UNCj4+PiAgIHNpZ25hbCBJTlRBIGJ1dCBpdCB3
YXMgcmVjZWl2ZWQgYXMgSU5UQj8NCj4+IA0KPj4gSSBzYXcgdGhhdCBpbnRlcnJ1cHRzIHdlcmUg
YmVpbmcgZ2VuZXJhdGVkIGJ5IHRoZSBlbmRwb2ludCBkZXZpY2UsDQo+PiBidXQgSSBkaWRu4oCZ
dCBzcGVjaWZpY2FsbHkgY2hlY2sgaWYgdGhleSB3ZXJlIGNvcnJlY3RseSB0cmFuc2xhdGVkIGlu
DQo+PiB0aGUgY29udHJvbGxlci4gSSBub3RpY2VkIHRoYXQgdGhlIG5ldyBkcml2ZXIgd2Fzbid0
IGV4cGxpY2l0bHkNCj4+IGVuYWJsaW5nIHRoZSBpbnRlcnJ1cHRzLCBzbyBteSBmaXJzdCBhcHBy
b2FjaCB3YXMgdG8gZW5hYmxlIHRoZW0sDQo+PiB3aGljaCBoZWxwZWQgdGhlIGludGVycnVwdHMg
ZmxvdyB0aHJvdWdoLg0KPiANCj4gT0ssIEknbGwgYXNzdW1lIHRoZSBpbnRlcnJ1cHRzIGhhcHBl
bmVkIGJ1dCB0aGUgZHJpdmVyIG1pZ2h0IG5vdCBoYXZlDQo+IGJlZW4gYWJsZSB0byBoYW5kbGUg
dGhlbSBjb3JyZWN0bHksIGUuZy4sIGl0IHdhcyBwcmVwYXJlZCBmb3IgSU5UQSBidXQNCj4gZ290
IElOVEIgb3Igc2ltaWxhci4NCj4gDQo+Pj4gLSBXaHkgZGlkIFN0ZWZhbidzIHBhdGNoIHdvcmsg
Zm9yIGhpbSBldmVuIHdpdGhvdXQgeW91ciBwYXRjaC4gIEhvdw0KPj4+ICAgY291bGQgU3RlZmFu
J3MgSU5UeCB3b3JrIHdpdGhvdXQgdGhlIENTUiB3cml0ZXMgdG8gZW5hYmxlDQo+Pj4gICBpbnRl
cnJ1cHRzPw0KPj4gDQo+PiBJJ20gbm90IGVudGlyZWx5IHN1cmUgaWYgdGhlcmUgYXJlIGFueSBv
dGhlciBkZXBlbmRlbmNpZXMgaW4gdGhlDQo+PiBGUEdBIGJpdHN0cmVhbS4gSSdsbCBpbnZlc3Rp
Z2F0ZSBmdXJ0aGVyIGFuZCBnZXQgYmFjayB0byB5b3UuDQo+IA0KPiBTdGVmYW4gY2xhcmlmaWVk
IGluIGEgcHJpdmF0ZSBtZXNzYWdlIHRoYXQgaGUgaGFkIGFwcGxpZWQgeW91ciBwYXRjaA0KPiBm
aXJzdCwgc28gdGhpcyBteXN0ZXJ5IGlzIHNvbHZlZC4NCg0KVGhhbmtzIGZvciBjb25maXJtaW5n
Lg0KDQo+IA0KPj4+IC0gV2h5IHlvdSBtZW50aW9uZWQgImtlcm5lbCA2LjYuMCBhbmQgbGF0ZXIg
dmVyc2lvbnMuIg0KPj4+IDhkNzg2MTQ5ZDc4YyBhcHBlYXJlZCBpbiB2Ni43LCBzbyB3aHkgd291
bGQgdjYuNi4wIHdvdWxkIGJlDQo+Pj4gYWZmZWN0ZWQ/DQo+PiANCj4+IEFwb2xvZ2llcyBmb3Ig
bm90IGNsZWFybHkgbWVudGlvbmluZyB0aGUgdmVyc2lvbiBlYXJsaWVyLiBUaGlzIGlzDQo+PiBm
cm9tIHRoZSBsaW51eC14bG54IHRyZWUgb24gdGhlIHhsbnhfcmViYXNlX3Y2LjYgYnJhbmNoLCB3
aGljaA0KPj4gaW5jbHVkZXMgdGhlIG5ldyBYaWxpbnggcm9vdCBwb3J0IGRyaXZlciB3aXRoIFFE
TUEgc3VwcG9ydDoNCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9YaWxpbngvbGludXgteGxueC9ibG9i
L3hsbnhfcmViYXNlX3Y2LjZfTFRTL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngt
ZG1hLXBsLmMNCj4+IA0KPj4gSW4gZWFybGllciB2ZXJzaW9ucywgdGhlIGRyaXZlciB3YXM6DQo+
PiBodHRwczovL2dpdGh1Yi5jb20vWGlsaW54L2xpbnV4LXhsbngvYmxvYi94bG54X3JlYmFzZV92
Ni4xX0xUU18yMDIzLjFfdXBkYXRlL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14ZG1hLXBs
LmMNCj4+IFRoaXMgb2xkZXIgZHJpdmVyIGhhZCBubyBpc3N1ZXMgd2l0aCBpbnRlcnJ1cHRzLg0K
Pj4gDQo+PiBUaGUgbmV3IGRyaXZlciBpbnRyb2R1Y2VkIGluIHY2LjcgYW5kIGxhdGVyIGlzIGEg
cmV3cml0ZSBvZiB0aGUgb2xkDQo+PiBvbmUsIG5vdyB3aXRoIFFETUEgc3VwcG9ydCwgd2hpY2gg
aGFzIGlzc3VlcyB3aXRoIElOVHggaW50ZXJydXB0cy4NCj4gDQo+IE9LLCB0aGlzIHNvdW5kcyBs
aWtlIG91dC1vZi10cmVlIGhpc3RvcnkgdGhhdCBpcyBub3QgcmVsZXZhbnQgaW4gdGhlDQo+IG1h
aW5saW5lIGtlcm5lbCwgc28gTWFuaSBkaWQgdGhlIHJpZ2h0IHRoaW5nIGluIG9taXR0aW5nIGl0
Lg0KPiANCj4gSSB0aGluayB0aGUgYmVzdCB0aGluZyB0byBkbyBpcyB0byBzcXVhc2ggU3RlZmFu
J3MgcGF0Y2ggaW50byB0aGlzIG9uZQ0KPiBzbyB3ZSBlbmQgdXAgd2l0aCBhIHNpbmdsZSBwYXRj
aCB0aGF0IG1ha2VzIElOVHggd29yayBjb3JyZWN0bHkuDQo+IA0KPiBSYXZpIGFuZCBTdGVmYW4s
IGRvZXMgdGhhdCBzZWVtIE9LIHRvIHlvdT8NCg0KU3VyZSwgSeKAmW0gT0ssIHRoYW5rIHlvdS4N
Cg0KPiANCj4+Pj4+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWRt
YS1wbC5jDQo+Pj4+Pj4gQEAgLTY1OSw2ICs2NTksMTIgQEAgc3RhdGljIGludCB4aWxpbnhfcGxf
ZG1hX3BjaWVfc2V0dXBfaXJxKHN0cnVjdCBwbF9kbWFfcGNpZSAqcG9ydCkNCj4+Pj4+PiAgICAg
ICAgICAgIHJldHVybiBlcnI7DQo+Pj4+Pj4gICAgfQ0KPj4+Pj4+IA0KPj4+Pj4+ICsgICAgIC8q
IEVuYWJsZSBpbnRlcnJ1cHRzICovDQo+Pj4+Pj4gKyAgICAgcGNpZV93cml0ZShwb3J0LCBYSUxJ
TlhfUENJRV9ETUFfSU1SX0FMTF9NQVNLLA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgWElMSU5Y
X1BDSUVfRE1BX1JFR19JTVIpOw0KPj4+Pj4+ICsgICAgIHBjaWVfd3JpdGUocG9ydCwgWElMSU5Y
X1BDSUVfRE1BX0lEUk5fTUFTSywNCj4+Pj4+PiArICAgICAgICAgICAgICAgIFhJTElOWF9QQ0lF
X0RNQV9SRUdfSURSTl9NQVNLKTsNCj4+Pj4+PiArDQo+Pj4+Pj4gICAgcmV0dXJuIDA7DQo+Pj4+
Pj4gfQ0KPj4gDQoNCg==

