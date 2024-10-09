Return-Path: <linux-pci+bounces-14025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225C9960E5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E607B24EF5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054F17BB21;
	Wed,  9 Oct 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qVQ8E+o7"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720315C144;
	Wed,  9 Oct 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459047; cv=none; b=Q7zfVj0TFWhvvURQg5fmjOeXe9niNcPdnJdK3u88DARiE7lKMi7ieV7Z+qVfGhwzscbLocAQM3IY/JPyvdH+J6IAfYNdv0Jzjh53ViGPfy//3D70CGMboiGAFQMeJINacQ7NCbvnDeAg5/5QPUangTexnYzrFFEkXhpF8Mj0Uhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459047; c=relaxed/simple;
	bh=TyPX5RsfEu869eEFs5gjuF1hH+zRkucYDdNB+syyCO4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RX4ZmDQ/CJ1BkbPg5PluuGv1aZR7G1iK34F4aj8Rt55IHumZv12wQ5JcYHCEyVpRkbQO++KcaJVsv5RSUyY3thGzS8BbrVUt1tPN0YM6TLFvIC1xTwwKZFUcjgmCHMmGDurCFeccHwuB/lUAT1ZPdvzf+DiRV5UqB+S0Eo+Bcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qVQ8E+o7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728459045; x=1759995045;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TyPX5RsfEu869eEFs5gjuF1hH+zRkucYDdNB+syyCO4=;
  b=qVQ8E+o7rEEZmcRaokE3ZmEGmf1wEwlYvHFM9Tkx9094sBRxMxQy1FCY
   xGxUAJtDUqzIvetk4LD+ZWGLPUEoUtF0UuQXuiS5dABjwgLbcvZA0ybP4
   nnp5ByLzF4SxIHUz3hlH+fd2H3zx32SgKyI1mnPAu5FT2yhq0e1VGwgfe
   6Vvp11bNT97p49qCKUS9W+9sPAkei6o7UzPpBvE1Smel8hNCJdiyP76Gh
   jvqDNIGOeRZGnQW1vep2qX7KWJKH8DbYO2uNffI/0TuTjDM3OIsr0QJj9
   7055CONlmrpXK3BjeOxlQRdemdi0I8/mO+xaUH69Xp5fRRN6u66jJlcG4
   g==;
X-CSE-ConnectionGUID: qFEgkva4S1qo/8hhkxFAyg==
X-CSE-MsgGUID: qVQ3upl8TUe5VnRoOX3tPQ==
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="36104240"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2024 00:30:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 9 Oct 2024 00:29:58 -0700
Received: from DEN-DL-M31857.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 9 Oct 2024 00:29:53 -0700
Message-ID: <71fb65a929e5d5be86f95ab76591beb77e641c14.camel@microchip.com>
Subject: Re: [PATCH v7 3/6] reset: mchp: sparx5: Map cpu-syscon locally in
 case of LAN966x
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
Date: Wed, 9 Oct 2024 09:29:52 +0200
In-Reply-To: <20241003081647.642468-4-herve.codina@bootlin.com>
References: <20241003081647.642468-1-herve.codina@bootlin.com>
	 <20241003081647.642468-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSGVydmUsCgpPbiBUaHUsIDIwMjQtMTAtMDMgYXQgMTA6MTYgKzAyMDAsIEhlcnZlIENvZGlu
YSB3cm90ZToKPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IEluIHRo
ZSBMQU45NjZ4IFBDSSBkZXZpY2UgdXNlIGNhc2UsIHRoZSBzeXNjb24gQVBJIGNhbm5vdCBiZSB1
c2VkIGFzCj4gaXQgZG9lcyBub3Qgc3VwcG9ydCBkZXZpY2UgcmVtb3ZhbCBbMV0uIEEgc3lzY29u
IGRldmljZSBpcyBhIGNvcmUKPiAic3lzdGVtIiBkZXZpY2UgYW5kIG5vdCBhIGRldmljZSBhdmFp
bGFibGUgaW4gc29tZSBhZGRvbiBib2FyZHMgYW5kCj4gc28sCj4gaXQgaXMgbm90IHN1cHBvc2Vk
IHRvIGJlIHJlbW92ZWQuIFRoZSBzeXNjb24gQVBJIGZvbGxvd3MgdGhpcwo+IGFzc3VtcHRpb24K
PiBidXQgdGhpcyBhc3N1bXB0aW9uIGlzIG5vIGxvbmdlciB2YWxpZCBpbiB0aGUgTEFOOTY2eCB1
c2UgY2FzZS4KPiAKPiBJbiBvcmRlciB0byBhdm9pZCB0aGUgdXNlIG9mIHRoZSBzeXNjb24gQVBJ
IGFuZCBzbywgc3VwcG9ydCBmb3IKPiByZW1vdmFsLAo+IHVzZSBhIGxvY2FsIG1hcHBpbmcgb2Yg
dGhlIHN5c2NvbiBkZXZpY2UuCj4gCj4gTGluazoKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNDA5MjMxMDA3NDEuMTEyNzc0MzlAYm9vdGxpbi5jb20vwqBbMV0KPiBTaWduZWQtb2Zm
LWJ5OiBIZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4KPiAtLS0KPiDCoGRy
aXZlcnMvcmVzZXQvcmVzZXQtbWljcm9jaGlwLXNwYXJ4NS5jIHwgMzUKPiArKysrKysrKysrKysr
KysrKysrKysrKysrLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC1taWNyb2NoaXAt
c3Bhcng1LmMKPiBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtbWljcm9jaGlwLXNwYXJ4NS5jCj4gaW5k
ZXggNjM2ZTg1YzM4OGIwLi40OGE2MmQ1ZGE3OGQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9yZXNl
dC9yZXNldC1taWNyb2NoaXAtc3Bhcng1LmMKPiArKysgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LW1p
Y3JvY2hpcC1zcGFyeDUuYwo+IEBAIC02Miw2ICs2MiwyOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHJlc2V0X2NvbnRyb2xfb3BzCj4gc3Bhcng1X3Jlc2V0X29wcyA9IHsKPiDCoMKgwqDCoMKgwqDC
oCAucmVzZXQgPSBzcGFyeDVfcmVzZXRfbm9vcCwKPiDCoH07Cj4gCj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgcmVnbWFwX2NvbmZpZyBtY2hwX2xhbjk2Nnhfc3lzY29uX3JlZ21hcF9jb25maWcKPiA9
IHsKPiArwqDCoMKgwqDCoMKgIC5yZWdfYml0cyA9IDMyLAo+ICvCoMKgwqDCoMKgwqAgLnZhbF9i
aXRzID0gMzIsCj4gK8KgwqDCoMKgwqDCoCAucmVnX3N0cmlkZSA9IDQsCj4gK307Cj4gKwo+ICtz
dGF0aWMgc3RydWN0IHJlZ21hcCAqbWNocF9sYW45NjZ4X3N5c2Nvbl90b19yZWdtYXAoc3RydWN0
IGRldmljZQo+ICpkZXYsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RydWN0Cj4gZGV2aWNlX25vZGUgKnN5c2Nvbl9ucCkKPiArewo+ICvCoMKgwqDCoMKg
wqAgc3RydWN0IHJlZ21hcF9jb25maWcgcmVnbWFwX2NvbmZpZyA9Cj4gbWNocF9sYW45NjZ4X3N5
c2Nvbl9yZWdtYXBfY29uZmlnOwo+ICvCoMKgwqDCoMKgwqAgcmVzb3VyY2Vfc2l6ZV90IHNpemU7
Cj4gK8KgwqDCoMKgwqDCoCB2b2lkIF9faW9tZW0gKmJhc2U7Cj4gKwo+ICvCoMKgwqDCoMKgwqAg
YmFzZSA9IGRldm1fb2ZfaW9tYXAoZGV2LCBzeXNjb25fbnAsIDAsICZzaXplKTsKPiArwqDCoMKg
wqDCoMKgIGlmIChJU19FUlIoYmFzZSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIEVSUl9DQVNUKGJhc2UpOwo+ICsKPiArwqDCoMKgwqDCoMKgIHJlZ21hcF9jb25maWcu
bWF4X3JlZ2lzdGVyID0gc2l6ZSAtIDQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIGRldm1f
cmVnbWFwX2luaXRfbW1pbyhkZXYsIGJhc2UsICZyZWdtYXBfY29uZmlnKTsKPiArfQo+ICsKPiDC
oHN0YXRpYyBpbnQgbWNocF9zcGFyeDVfbWFwX3N5c2NvbihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2LCBjaGFyCj4gKm5hbWUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCByZWdtYXAgKip0YXJnZXQp
Cj4gwqB7Cj4gQEAgLTcyLDcgKzk0LDE4IEBAIHN0YXRpYyBpbnQgbWNocF9zcGFyeDVfbWFwX3N5
c2NvbihzdHJ1Y3QKPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIGNoYXIgKm5hbWUsCj4gwqDCoMKg
wqDCoMKgwqAgc3lzY29uX25wID0gb2ZfcGFyc2VfcGhhbmRsZShwZGV2LT5kZXYub2Zfbm9kZSwg
bmFtZSwgMCk7Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKCFzeXNjb25fbnApCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PREVWOwo+IC3CoMKgwqDCoMKgwqAgcmVnbWFw
ID0gc3lzY29uX25vZGVfdG9fcmVnbWFwKHN5c2Nvbl9ucCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqAg
LyoKPiArwqDCoMKgwqDCoMKgwqAgKiBUaGUgc3lzY29uIEFQSSBkb2Vzbid0IHN1cHBvcnQgc3lz
Y29uIGRldmljZSByZW1vdmFsLgo+ICvCoMKgwqDCoMKgwqDCoCAqIFdoZW4gdXNlZCBpbiBMQU45
NjZ4IFBDSSBkZXZpY2UsIHRoZSBjcHUtc3lzY29uIGRldmljZQo+IG5lZWRzIHRvIGJlCj4gK8Kg
wqDCoMKgwqDCoMKgICogcmVtb3ZlZCB3aGVuIHRoZSBQQ0kgZGV2aWNlIGlzIHJlbW92ZWQuCj4g
K8KgwqDCoMKgwqDCoMKgICogSW4gY2FzZSBvZiBMQU45NjZ4LCBtYXAgdGhlIHN5c2NvbiBkZXZp
Y2UgbG9jYWxseSB0bwo+IHN1cHBvcnQgdGhlCj4gK8KgwqDCoMKgwqDCoMKgICogZGV2aWNlIHJl
bW92YWwuCj4gK8KgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoCBpZiAob2ZfZGV2aWNl
X2lzX2NvbXBhdGlibGUocGRldi0+ZGV2Lm9mX25vZGUsCj4gIm1pY3JvY2hpcCxsYW45NjZ4LXN3
aXRjaC1yZXNldCIpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZ21hcCA9IG1j
aHBfbGFuOTY2eF9zeXNjb25fdG9fcmVnbWFwKCZwZGV2LT5kZXYsCj4gc3lzY29uX25wKTsKPiAr
wqDCoMKgwqDCoMKgIGVsc2UKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWdtYXAg
PSBzeXNjb25fbm9kZV90b19yZWdtYXAoc3lzY29uX25wKTsKPiDCoMKgwqDCoMKgwqDCoCBvZl9u
b2RlX3B1dChzeXNjb25fbnApOwo+IMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIocmVnbWFwKSkg
ewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBQVFJfRVJSKHJlZ21hcCk7
Cj4gLS0KPiAyLjQ2LjEKPiAKClRoaXMgbG9va3MgZ29vZCB0byBtZS4KClJldmlld2VkLWJ5OiBT
dGVlbiBIZWdlbHVuZCA8U3RlZW4uSGVnZWx1bmRAbWljcm9jaGlwLmNvbT4KCkJSClN0ZWVuCg==


