Return-Path: <linux-pci+bounces-13647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2298A3E9
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 15:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0561F28875
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA1818C011;
	Mon, 30 Sep 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Vih0aST7"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC21DA3D;
	Mon, 30 Sep 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701453; cv=none; b=C1ocIgloDe7S8amkGiYmO2annpBz7sSpwDxMatwlXbRDvOp4A/UgGTQvpuMmWR+9qB9Y+Cnq+BCm9978/RQlBdY33CH1LDJmTEi+34sgSpE5oaDYRynHtjAyNW0T0IzuzuDRzoQ3F6aAC+FTURQpuU+nzFBrDdKQTA0Rh6L2iHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701453; c=relaxed/simple;
	bh=X1w+aHZ1aSEC/ce63NVfAhp4cMR5ClhM0fpq2w+I4m4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=drnQ2hA2r3oM5d7slGyO97IXlqnMSM6KLYjhEOvEnHR1NfA6Mc9PakZ26IrxA4briopsU2Eb5PjWZokg1mtmufLUFpB37KWgXvyZ7Eq9t7/zl+u61EbujJWlzVZm4dzdackptSWeSGATz5H9wEMC4iiCwf8OfA9rAnp5Fm3eHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Vih0aST7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727701451; x=1759237451;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=X1w+aHZ1aSEC/ce63NVfAhp4cMR5ClhM0fpq2w+I4m4=;
  b=Vih0aST7MeAzYbKrxOKgVfhRu35Bz2JPfLM080jR0DuM3ClTSttEUn2q
   tf+RZ35KqUqQa1C6/mxScnHDX9hw9n//YQcepOHhGLYL4nMrE0tp2ojeS
   GK9OlvOsSAaDVsqQ/IiKi53LhLM75MdfqRakad16AlG0+4NKruxgRWsBu
   aQ5Gyxzx5XcXUOb/7FqFA3bt2P8AaxxU31JtuXSik2bNq7MM9E76hsUV7
   Ke/oSSmrzYh6H8D+xeMIvLn5p3DMm7E9m5yX2K3V4+tNSQUCLJAsixIUW
   +gaYwhEDhtWzWP5CE3t/KVXzOVyMzHNqsIp79qwHKnVqzVDztE+Pt6kJx
   g==;
X-CSE-ConnectionGUID: vO9Oy7ojQeG5B541OJjihw==
X-CSE-MsgGUID: 5bccPyKoRgKxoVZkWYFVeQ==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="35659350"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 06:04:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 06:04:02 -0700
Received: from DEN-DL-M31857.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 06:03:57 -0700
Message-ID: <e3fca0f385e489cc30fc79c09d642c110125fd89.camel@microchip.com>
Subject: Re: [PATCH v6 2/7] reset: mchp: sparx5: Use the second reg item
 when cpu-syscon is not present
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Simon
 Horman" <horms@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
	<dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Andrew
 Lunn" <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Allan
 Nielsen" <allan.nielsen@microchip.com>, Luca Ceresoli
	<luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 30 Sep 2024 15:03:56 +0200
In-Reply-To: <20240930121601.172216-3-herve.codina@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
	 <20240930121601.172216-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSGVydmUsCgpPbiBNb24sIDIwMjQtMDktMzAgYXQgMTQ6MTUgKzAyMDAsIEhlcnZlIENvZGlu
YSB3cm90ZToKPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IEluIHRo
ZSBMQU45NjZ4IFBDSSBkZXZpY2UgdXNlIGNhc2UsIHN5c2NvbiBjYW5ub3QgYmUgdXNlZCBhcyBz
eXNjb24KPiBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IHJlbW92YWwgWzFdLiBBIHN5c2NvbiBkZXZp
Y2UgaXMgYSBjb3JlCj4gInN5c3RlbSIKPiBkZXZpY2UgYW5kIG5vdCBhIGRldmljZSBhdmFpbGFi
bGUgaW4gc29tZSBhZGRvbiBib2FyZHMgYW5kIHNvLCBpdCBpcwo+IG5vdAo+IHN1cHBvc2VkIHRv
IGJlIHJlbW92ZWQuCj4gCj4gSW4gb3JkZXIgdG8gcmVtb3ZlIHRoZSBzeXNjb24gdXNhZ2UsIHVz
ZSBhIGxvY2FsIG1hcHBpbmcgb2YgYSByZWcKPiBhZGRyZXNzIHJhbmdlIHdoZW4gY3B1LXN5c2Nv
biBpcyBub3QgcHJlc2VudC4KPiAKPiBMaW5rOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI0MDkyMzEwMDc0MS4xMTI3NzQzOUBib290bGluLmNvbS/CoFsxXQo+IFNpZ25lZC1vZmYt
Ynk6IEhlcnZlIENvZGluYSA8aGVydmUuY29kaW5hQGJvb3RsaW4uY29tPgo+IC0tLQo+IMKgZHJp
dmVycy9yZXNldC9yZXNldC1taWNyb2NoaXAtc3Bhcng1LmMgfCAxNiArKysrKysrKysrKysrKyst
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LW1pY3JvY2hpcC1zcGFyeDUuYwo+IGIv
ZHJpdmVycy9yZXNldC9yZXNldC1taWNyb2NoaXAtc3Bhcng1LmMKPiBpbmRleCA2MzZlODVjMzg4
YjAuLjFjMDk1ZmE0MWQ2OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LW1pY3Jv
Y2hpcC1zcGFyeDUuYwo+ICsrKyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtbWljcm9jaGlwLXNwYXJ4
NS5jCj4gQEAgLTExNCw4ICsxMTQsMjIgQEAgc3RhdGljIGludCBtY2hwX3NwYXJ4NV9yZXNldF9w
cm9iZShzdHJ1Y3QKPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+IAo+IMKgwqDCoMKgwqDCoMKgIGVyciA9IG1j
aHBfc3Bhcng1X21hcF9zeXNjb24ocGRldiwgImNwdS1zeXNjb24iLCAmY3R4LQo+ID5jcHVfY3Ry
bCk7Cj4gLcKgwqDCoMKgwqDCoCBpZiAoZXJyKQo+ICvCoMKgwqDCoMKgwqAgc3dpdGNoIChlcnIp
IHsKPiArwqDCoMKgwqDCoMKgIGNhc2UgMDoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBicmVhazsKPiArwqDCoMKgwqDCoMKgIGNhc2UgLUVOT0RFVjoKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvKgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBUaGUg
Y3B1LXN5c2NvbiBkZXZpY2UgaXMgbm90IGF2YWlsYWJsZS4KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogRmFsbCBiYWNrIHdpdGggSU8gbWFwcGluZyAoaS5lLiBtYXBwaW5nIGZy
b20gcmVnCj4gcHJvcGVydHkpLgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBtY2hwX3NwYXJ4NV9tYXBfaW8o
cGRldiwgMSwgJmN0eC0+Y3B1X2N0cmwpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChlcnIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBlcnI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gK8Kg
wqDCoMKgwqDCoCBkZWZhdWx0Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gZXJyOwo+ICvCoMKgwqDCoMKgwqAgfQo+ICsKPiDCoMKgwqDCoMKgwqDCoCBlcnIgPSBtY2hw
X3NwYXJ4NV9tYXBfaW8ocGRldiwgMCwgJmN0eC0+Z2NiX2N0cmwpOwo+IMKgwqDCoMKgwqDCoMKg
IGlmIChlcnIpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7Cj4g
LS0KPiAyLjQ2LjEKPiAKCkxHVE0KClJldmlld2VkLWJ5OiBTdGVlbiBIZWdlbHVuZCA8U3RlZW4u
SGVnZWx1bmRAbWljcm9jaGlwLmNvbT4KCkJSClN0ZWVuCg==


