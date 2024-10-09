Return-Path: <linux-pci+bounces-14023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70820995FBD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 08:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05E81F2161C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 06:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA681DA5F;
	Wed,  9 Oct 2024 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Ts9kBSWd"
X-Original-To: linux-pci@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA628EF
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455200; cv=none; b=V+s5+nyNh09ZMs/OLkYo8QF0yQ5uLlVzcBBy4pFQ/qBwHhxZ2CanreB+5VXOfmrbC5FyPcoF0eBY2oa3YIxZnI1TRAcdVpBi4178FPHdZe/xBj1tfKdLi/mUYL1Vj9YehhWdhQJF63kom+ogfe5o+p+pYqilvr99uD6wl6hY8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455200; c=relaxed/simple;
	bh=jyRnZA3o/QyzUfmgZSYdmPbndfEfk/FECjjiInTvpzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RvLDrxWF0UvnecCSAQuDE2lAuCYuyxIHOcsLjBBLAA48CztQg/tDs+/Xqt1aqj+cDvquzH6A6rbQkcClCH7jqYN/lPh8jxuxK/GuiERwcTmsgGHbm9gcJw4N9CRJqzRXpEH0dvf7dYUHZuIVplNao2ccX6iqGhjx8xMDuCe8rV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Ts9kBSWd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 516102087C;
	Wed,  9 Oct 2024 08:26:29 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id potZFKupWQs0; Wed,  9 Oct 2024 08:26:28 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5FD492082B;
	Wed,  9 Oct 2024 08:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5FD492082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728455188;
	bh=jyRnZA3o/QyzUfmgZSYdmPbndfEfk/FECjjiInTvpzQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Ts9kBSWd30vTztwOnAmUseSbgu4sgZfYTlGib7JSFFI6iXxL4y7omv/SJ8CkaBRQ7
	 rY/7Tkg2ht46I/fLQ/J7i2cagRI2IIWVRCJvSE5WtbhYODF2hYwkiGFZ1/UJnIcfFL
	 qJBS2hTbf0yrPuF82RTQ39mLJyYMufDf1xtz5MHLPEGIw8X09ufSdlnhBNK/QdnR09
	 cOAPtpvfOE0RGkN2sa2+4sg8ZiIiDBUs1+TyIrukABStRXCFYDFThUFzTTuXVLVEwa
	 7MbBnHboxJDAmwT/S4Hc3pUPactdz9dqbIbVAgewMjaRKz7ifUCHDepSyyqZlceOsd
	 k7QjEA918XWdw==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 08:26:28 +0200
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mbx-essen-01.secunet.de (10.53.40.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 08:26:28 +0200
Received: from mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75]) by
 mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75%6]) with mapi id
 15.01.2507.039; Wed, 9 Oct 2024 08:26:28 +0200
From: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
To: "lukas@wunner.de" <lukas@wunner.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "mika.westerberg@linux.intel.com"
	<mika.westerberg@linux.intel.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mpearson-lenovo@squebb.ca"
	<mpearson-lenovo@squebb.ca>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "minipli@grsecurity.net"
	<minipli@grsecurity.net>
Subject: Re: UAF during boot on MTL based devices with attached dock
Thread-Topic: UAF during boot on MTL based devices with attached dock
Thread-Index: AQHbCmrFODsoF+chTk2MBvuiMq/CLbJlMIIAgAF4p4CAAeJvgIAMc3aAgAEtYQCABU7ogIABYqAAgAEUA4A=
Date: Wed, 9 Oct 2024 06:26:27 +0000
Message-ID: <f23dd8afad2074c851c64d89044d7b3756d102c8.camel@secunet.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
	 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
	 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
	 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
	 <Zv6gT96pHg2Jglxv@wunner.de> <Zv-dIHDXNNYomG2Y@wunner.de>
	 <bdc3963903e7c4aeec7c34ac0d46c4368152a8c2.camel@secunet.com>
	 <ZwU6ijD8I5hzMv9X@wunner.de>
In-Reply-To: <ZwU6ijD8I5hzMv9X@wunner.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <3413639A96B00943B1942A4329F0D0EB@secunet.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

DQpPbiBUdWUsIDIwMjQtMTAtMDggYXQgMTU6NTggKzAyMDAsIEx1a2FzIFd1bm5lciB3cm90ZToN
Cj4gT24gTW9uLCBPY3QgMDcsIDIwMjQgYXQgMDQ6NDk6MTlQTSArMDAwMCwgV2Fzc2VuYmVyZywg
RGVubmlzIHdyb3RlOg0KPiA+ID4gVGhlIHVucGx1ZyBldmVudCBoYXBwZW5zIGF0IHRoZSB0b3Ag
b2YgdGhlIGhpZXJhcmNoeSAoYmVsb3cgdGhlIFJvb3QgUG9ydCkuDQo+ID4gPiBTbyBwY2lfYnVz
X2FkZF9kZXZpY2VzKCkgYmluZHMgdGhlIFJvb3QgUG9ydCwgaXRzIGRyaXZlciBzdGFydHMgc3Rv
cHBpbmcNCj4gPiA+IGFuZCByZW1vdmluZyB0aGUgaGllcmFyY2h5IGJlbG93LCBhbGwgdGhlIHdo
aWxlIHBjaV9idXNfYWRkX2RldmljZXMoKQ0KPiA+ID4gY29udGludWVzIGJpbmRpbmcgZHJpdmVy
cyB0byB0aGUgY2hpbGQgZGV2aWNlcy4NCj4gPiA+IA0KPiA+ID4gQ291bGQgeW91IHRyeSB0aGlz
IHBhdGNoIChpbiBhZGRpdGlvbiB0byB0aGUgb25lIGJlbG93IGFuZCB0byB0aGUgb25lDQo+ID4g
PiBJIHNlbnQgeWVzdGVyZGF5KToNCj4gPiA+IA0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjQxMDAzMDg0MzQyLjI3NTAxLTEtYnJnbEBiZ2Rldi5wbC8NCj4gPiA+IA0KPiA+
ID4gSXQgc2hvdWxkIHByZXZlbnQgcGNpX2J1c19hZGRfZGV2aWNlcygpIGZyb20gcmFjaW5nIHdp
dGggcGNpZWhwIHN0b3BwaW5nDQo+ID4gPiBhbmQgcmVtb3ZpbmcgZGV2aWNlcy4NCj4gPiANCj4g
PiBJIGNoZWNrZWQgdGhlIGNvbWJpbmF0aW9uIG9mIGFsbCAzIHBhdGNoZXMgYXMgd2VsbC4gSW4g
dGhlIGVuZCBpdCBiZWhhdmVzDQo+ID4gdGhlIHNhbWUgbGlrZSBpZiBJIGFwcGx5IHRoZSBmaXJz
dCBwYXRjaCBvbmx5ICh0aGUgb25lIHlvdSBzZW50IHRoZSBkYXkNCj4gPiBiZWZvcmUpLg0KPiAN
Cj4gVGhhbmtzIGEgbG90IGZvciB0ZXN0aW5nIGFuZCB0aGUgZGV0YWlsZWQgZmVlZGJhY2suDQo+
IA0KPiBXb3VsZCBpdCBiZSBwb3NzaWJsZSBmb3IgeW91IHRvIHRyeSB0aGUgYWJvdmUtbGlua2Vk
IHBhdGNoIGFsb25lDQo+IChvbiB0b3Agb2YgYSByZWNlbnQgc3RvY2sga2VybmVsKSwgaS5lLiB3
aXRob3V0IHRoZSByZWZjb3VudGluZw0KPiBmaXggdGhhdCB5b3Ugc2F5IHdhcyBzdWZmaWNpZW50
IHRvIGF2b2lkIHRoZSBVQUY/DQo+IA0KPiBBbmQgSSdkIGFsc28gYXBwcmVjaWF0ZSBpZiB5b3Ug
Y291bGQgdHJ5IHRoZSBtYXRjaF9kcml2ZXIgYXBwcm9hY2ggLi4uDQo+IA0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvWnYtZElIRFhOTllvbUcyWUB3dW5uZXIuZGUvDQo+IA0KPiAuLi4g
YWxvbmUsIGkuZS4gd2l0aG91dCBhbnkgb3RoZXIgcGF0Y2hlcy4NCj4gDQo+IEl0J3MgaW50ZXJl
c3RpbmcgdGhhdCB0aGUgcmVmY291bnRpbmcgZml4IHdhcyBzdWZmaWNpZW50IHRvIGF2b2lkDQo+
IHRoZSBVQUYgYnV0IEkgY2FuJ3QgZ2V0IG92ZXIgdGhlIGZhY3QgdGhhdCB0aGUgcGNpZXBvcnQg
ZHJpdmVyIGlzDQo+IHVuYm91bmQgZnJvbSBwY2lfcmVtb3ZlX2J1c19kZXZpY2UoKSwgd2hlbiBp
dCBzaG91bGQgbm8gbG9uZ2VyIGJlDQo+IGJvdW5kIGluIHRoZSBmaXJzdCBwbGFjZS4gIE15IGlt
cHJlc3Npb24gaXMgdGhhdCB0ZWFyZG93biBvZiB0aGUNCj4gaGllcmFyY2h5IGJ5IHBjaWVocCBy
YWNlcyB3aXRoIGRyaXZlciBiaW5kaW5nIGFmdGVyIHRoZSBpbml0aWFsDQo+IHJvb3QgYnVzIHNj
YW4sIHNvIHdlIHByb2JhYmx5IHNob3VsZCB0cnkgdG8gYXZvaWQgdGhhdC4gIEknZCBsaWtlDQo+
IHRvIGNvbmZpcm0gKG9yIGRpc3Byb3ZlKSB0aGF0IGh1bmNoLg0KPiANCj4gVGhlIHJlZmNvdW50
aW5nIGZpeCBjb3VsZCBiZSBhcHBsaWVkIGFzIGEgc2FmZXR5IG5ldCBidXQgbm9ybWFsbHkNCj4g
c2hvdWxkbid0IGJlIG5lY2Vzc2FyeSBpZiBkcml2ZXIgdW5iaW5kaW5nIGhhcHBlbnMgaW4gcGNp
X3N0b3BfZGV2KCkNCj4gYW5kIHRoZSBkZXZpY2UgcmVtYWlucyB1bmJvdW5kIGFmdGVyd2FyZHMu
ICBUaGUgbWF0Y2hfZHJpdmVyIHBhdGNoDQo+IHNob3VsZCBhY2hpZXZlIHRoYXQuICBBbmQgdGhl
IG90aGVyIHBhdGNoIGJ5IEJhcnRvc3ogKGxpbmtlZCBhYm92ZSkNCj4gc2hvdWxkIGFjaGlldmUg
dGhlIHNhbWUgYnkgc2VyaWFsaXppbmcgZHJpdmVyIGJpbmRpbmcgYWZ0ZXIgYnVzDQo+IGVudW1l
cmF0aW9uIHdpdGggZHJpdmVyIHVuYmluZGluZyBieSBwY2llaHAuDQo+IA0KPiBGaW5hbGx5LCBJ
J2QgYXBwcmVjaWF0ZSBpZiB5b3UgY291bGQgc2VuZCBtZSBkbWVzZyBvdXRwdXQgd2l0aCB0aGUN
Cj4gcmVmY291bnRpbmcgZml4IGFwcGxpZWQuICBBcyBzYWlkIGJlZm9yZSwgdGhlIE1UTCBUaHVu
ZGVyYm9sdCBjb250cm9sbGVyDQo+IGNsYWltcyB0aGF0IHRoZSBsaW5rIGFuZCBzbG90IHByZXNl
bmNlIGJpdHMgYXJlIGNsZWFyZWQsIHNvIGl0DQo+IGRlLWVudW1lcmF0ZXMgZXZlcnl0aGluZyBh
dHRhY2hlZCB2aWEgVGh1bmRlcmJvbHQuICBJJ20gd29uZGVyaW5nDQo+IGlmIGl0IHRoZW4gcmUt
ZW51bWVyYXRlcyB0aGUgVGh1bmRlcmJvbHQtYXR0YWNoZWQgZGV2aWNlcyBzbyB0aGV5J3JlDQo+
IGFjdHVhbGx5IHVzYWJsZT8NCkkgd2lsbCBkZWZpbml0ZWx5IGRvIHRoYXQgYnV0IHVuZm9ydHVu
YXRlbHkgaXQgd2lsbCB0YWtlIHNvbWUgdGltZS4gSSB3aWxsIGJlIE9PTyBmb3IgdGhlIG5leHQg
MiB3ZWVrcyBzdGFydGluZyBmcm9tDQp0b2RheS4NCj4gDQo+IEknbSBob3BpbmcgTWlrYSBjYW4g
Y2xhcmlmeSB3aXRoIEludGVsIFRodW5kZXJib2x0IENvRSB3aGV0aGVyIHRoaXMNCj4gaXMgYSBo
YXJkd2FyZSBpc3N1ZSBpbiBNVEwgdGhhdCBjYW4gZS5nLiBiZSBmaXhlZCB0aHJvdWdoIGEgZmly
bXdhcmUNCj4gb3IgQklPUyB1cGRhdGUuDQo+IA0KPiBUaGFua3MhDQo+IA0KPiBMdWthcw0KDQo=

