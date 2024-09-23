Return-Path: <linux-pci+bounces-13357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0143097E7C8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 10:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63E2280E99
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 08:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD618EFF8;
	Mon, 23 Sep 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="z22FlKjr"
X-Original-To: linux-pci@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7174416
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081004; cv=none; b=syJxoqn1WTCGkwEa2KyY9CP+vyvGc6bv3QKBt07/ciQqm4ufilDMTZWnzV1YnbY+3tXnnh/Z2+qX1ffqaCikAgVlxfKIwMrFui/rHMmZdJuqxStLvJN5suZBjH7rNmD4wEp9VU4k5btmqVgb4J9sYntTlsXksQmOrkLAhV6jv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081004; c=relaxed/simple;
	bh=cyadxMcfkj/6L/yEPUYdF8g6LcSjSKKDuUtz5iqN4kQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WIzpMIhXtUBzJMAps6CLztC2pmereShe8HH+G4X3mDSbA/RDT68YwpHMpEewkmhTrKTKXwYIZBCCpXf2ZxaNaSYftUSCDiF9N5nj8nN/Znb95X37l6HVnGTTyCpSv6Kc2JDbh8zShi3m60bagvhOOFsIwG8OorQ8i3SReWt1lTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=z22FlKjr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7D1042050A;
	Mon, 23 Sep 2024 10:43:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kthAfhuc6Be; Mon, 23 Sep 2024 10:43:20 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E073320520;
	Mon, 23 Sep 2024 10:43:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E073320520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1727080999;
	bh=cyadxMcfkj/6L/yEPUYdF8g6LcSjSKKDuUtz5iqN4kQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=z22FlKjr0x3qR46ydl7aslsP/xj4ZfNfic/ehssaF7YZFUzrP5EPrHwwJcp+zz4Ij
	 N0eZv+TJ5LijDWbSOS4sXkS0KaxgCMjhO6ArurjLpElus5emJxnE5+qPqvThNM6VR1
	 UgENMFzhNsdb9LCTJ4Hw0Q0lnNp7GGkQwkuXNy5igwMy3XwYk3tk4qKTLni5w6khd9
	 pUMbZDb1VgrBhaO8j3FOPmAoMAix8zYQw9v7tQSFpMkP5Ere0GVgiSioIUy8NHAKZs
	 YNJDBgMSVGV7bLXyB4Dz3TlarbkRvv1GpQEcI3cPGh1l/UT9aMdXr10QHGauivLHAw
	 m71QxwwEsZjiQ==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 10:43:19 +0200
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 mbx-essen-01.secunet.de (10.53.40.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 10:43:19 +0200
Received: from mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75]) by
 mbx-essen-01.secunet.de ([fe80::1522:bd4f:78cd:ce75%6]) with mapi id
 15.01.2507.039; Mon, 23 Sep 2024 10:43:19 +0200
From: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mpearson-lenovo@squebb.ca"
	<mpearson-lenovo@squebb.ca>
Subject: Re: UAF during boot on MTL based devices with attached dock
Thread-Topic: UAF during boot on MTL based devices with attached dock
Thread-Index: AQHbCmrFODsoF+chTk2MBvuiMq/CLbJkr1KAgABDlwA=
Date: Mon, 23 Sep 2024 08:43:19 +0000
Message-ID: <99a2aa0d9f3768f250510db0abe6b32079f6a047.camel@secunet.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
	 <20240923044123.GT275077@black.fi.intel.com>
In-Reply-To: <20240923044123.GT275077@black.fi.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FC9F3C8D32E464ABE4CCF0B1D5BF649@secunet.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

SGkgTWlrYSwNCg0KdGhlIGxvZ3MgSSBzaGFyZWQgd2l0aCBJbHBvIGEgZmV3IG1pbnV0ZXMgYWdv
IHdpbGwgYWxyZWFkeSBjb250YWluIGFjdGl2YXRlZCB0aHVuZGVyYm9sdCBsb2dnaW5nLg0KDQpU
aGFuayB5b3UgJiBiZXN0IHJlZ2FyZHMsDQpEZW5uaXMNCg0KDQpPbiBNb24sIDIwMjQtMDktMjMg
YXQgMDc6NDEgKzAzMDAsIG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20gd3JvdGU6DQo+
IEhpLA0KPiANCj4gT24gVGh1LCBTZXAgMTksIDIwMjQgYXQgMDg6MDY6MDNBTSArMDAwMCwgV2Fz
c2VuYmVyZywgRGVubmlzIHdyb3RlOg0KPiA+IEhpIHRvZ2V0aGVyLA0KPiA+IA0KPiA+IHdlIGFy
ZSBmYWNpbmcgaW50byBpc3N1ZXMgd2hpY2ggc2VlbXMgdG8gYmUgUENJIHJlbGF0ZWQgYW5kIGFz
a2luZyBmb3IgeW91ciBlc3RpbWF0aW9ucy4NCj4gPiANCj4gPiBCYWNrZ3JvdW5kOg0KPiA+IFdl
IHdhbnQgdG8gYm9vdCB1cCBhbiBJbnRlbCBNZXRlb3JMYWtlIGJhc2VkIHN5c3RlbSAoZS5nLiBM
ZW5vdm8gVGhpbmtQYWQgWDEzIEdlbjUpIHdpdGggdGhlIExlbm92byBUaHVuZGVyYm9sdCA0DQo+
ID4gdW5pdmVyc2FsIGRvY2sgYXR0YWNoZWQgZHVyaW5nIGJvb3QuIE9uIHNvbWUgZGV2aWNlcyBp
dCBpcyBuZWFybHkgMTAwJSByZXByb2R1Y2libGUgdGhhdCB0aGUgYm9vdCB3aWxsIGZhaWwuIE90
aGVyDQo+ID4gc3lzdGVtcyB3aWxsIG5ldmVyIHNob3cgdGhpcyBpc3N1ZSAoZS5nLiBvbGRlciBk
ZXZpY2VzIGJhc2VkIG9uIFJhcHRvckxha2Ugb3IgQWxkZXJMYWtlIHBsYXRmb3JtKS4NCj4gPiAN
Cj4gPiBXZSBkaWQgc29tZSBkZWJ1Z2dpbmcgb24gdGhpcyBhbmQgY2FtZSB0byB0aGUgY29uY2x1
c2lvbiB0aGF0IHRoZXJlIGlzIGEgdXNlLWFmdGVyLWZyZWUgaW4gcGNpX3Nsb3RfcmVsZWFzZS4N
Cj4gPiBUaGUgVGh1bmRlcmJvbHQgNCBEb2NrIHdpbGwgZXhwb3NlIGEgUENJIGhpZXJhcmNoeSBh
dCBmaXJzdCBhbmQgc2hvcnRseSBhZnRlciB0aGF0LCBkdWUgdG8gdGhlIGRldmljZSBpcw0KPiA+
IGluYWNjZXNzaWJsZSwNCj4gPiBpdCB3aWxsIHJlbGVhc2UgdGhlIGFkZGl0aW9uYWwgYnVzZXMv
cG9ydHMuIFRoaXMgc2VlbXMgdG8gZW5kIHVwIGluIGEgcmFjZSB3aGVyZSBwY2lfc2xvdF9yZWxl
YXNlIGFjY2Vzc2VzICZzbG90LQ0KPiA+ID5idXMNCj4gPiB3aGljaCBhcyBhbHJlYWR5IGZyZWVk
Og0KPiA+IA0KPiA+IDAwMDA6MDAgW3Jvb3QgYnVzXQ0KPiA+ICAgICAgIC0+IDAwMDA6MDA6MDcu
MCBbYnJpZGdlIHRvIDIwLTQ5XQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgIC0+IDAwMDA6MjA6
MDAuMCBbYnJpZGdlIHRvIDIxLTQ5XQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC0+IDAwMDA6MjE6MDAuMCBbYnJpZGdlIHRvIDIyXQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDAwMDA6MjE6MDEuMCBbYnJpZGdlIHRvIDIzLTJlXQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAwMDA6MjE6MDIuMCBb
YnJpZGdlIHRvIDJmLTNhXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDAwMDA6MjE6MDMuMCBbYnJpZGdlIHRvIDNiLTQ4XQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDAwMDA6MjE6MDQuMCBbYnJpZGdlIHRvIDQ5XQ0KPiA+ICAg
ICAgICAgIDAwMDA6MDA6MDcuMiBbYnJpZGdlIHRvIDUwLTc5XQ0KPiA+IA0KPiA+IA0KPiA+IFdl
IGFyZSBjdXJyZW50bHkgcnVubmluZyBvbiBrZXJuZWwgNi44LjEyLiBCZWNhdXNlIHRoaXMga2Vy
bmVsIGlzIG91dCBvZiBzdXBwb3J0IEkgdHJpZWQgaXQgb24gNi4xMS4gVGhpcyBrZXJuZWwNCj4g
PiBzaG93cw0KPiA+IGV4YWN0bHkgdGhlIHNhbWUgaXNzdWUuIEkgYXR0YWNoZWQgdHdvIGxvZyBm
aWxlczoNCj4gPiBkbWVzZy1yYW1vb3BzLTA6IEJhc2VkIG9uIGtlcm5lbCA2LjExIHdpdGggYWRk
ZWQga2VybmVsIGNvbW1hbmQgbGluZSBvcHRpb24gInNsYWJfZGVidWciIGluIG9yZGVyIHRvIGZv
cmNlIGEga2VybmVsDQo+ID4gT29wcw0KPiA+IHdoaWxlIGFjY2Vzc2luZyBmcmVlZCBtZW1vcnku
DQo+ID4gZG1lc2ctcmFtb29wcy0wLXBjaV9kYmc6IFRoaXMgaXQgbGlrZSBkbWVzZy1yYW1vb3Bz
LTAgd2l0aCBhZGRpdGlvbmFsIGtlcm5lbCBjb21tYW5kIGxpbmUgb3B0aW9uICciZHluZGJnPWZp
bGUNCj4gPiBkcml2ZXJzL3BjaS8qICtwIiBpZ25vcmVfbG9nbGV2ZWwnIGluIG9yZGVyIHRvIGdp
dmUgeW91IG1vcmUgaW5zaWdodCB3aGF0cyBoYXBwZW5pbmcgb24gdGhlIHBjaSBidXMuDQo+IA0K
PiBDYW4geW91IHJ1biB0aGUgc2FtZSB3aXRoIHRoZSB2Ni4xMSBidXQgYWRkIGFsc28gInRodW5k
ZXJib2x0LmR5bmRiZz0rcCINCj4gaW4gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgYW5kIHByb3Zp
ZGUgbWUgdGhhdCBsb2c/DQoNCg==

