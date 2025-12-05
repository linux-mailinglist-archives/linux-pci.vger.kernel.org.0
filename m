Return-Path: <linux-pci+bounces-42690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C363CA7267
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 11:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8726C30DB582
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DBF322A26;
	Fri,  5 Dec 2025 10:25:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E852E3148A1;
	Fri,  5 Dec 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930313; cv=none; b=uV6GLWqsQZ0q3TSpyWJlpD/p/kbzzUONVNgOnNjOg6zHUy2g7DL2FtvuXhHgJwirRCR+uBrNPtEq/fhbU/AMP7HiMoGTBPha+8bSBq7tUnaxgQ9wXFtOopd43us6H9OKjF1ufJyQpHpRWhlUce9J/i6LtGbyqiIBVL+3VnXadBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930313; c=relaxed/simple;
	bh=8bdBGQ0yzqszi+JdPvW8l3AhaQzAQD1l/NNZYUOAIwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=K9Ka8DbAJ6F1LMl/Lf7/De9MIjVJtBcgXEo+25LmdIhgfiKuJ4nrv2kACIVBOiXjgCtmBkfbs/AYYCFkeiBtQElkESNcN4+irQCPyvctikdJIwDV3gRWVjJwwgANsbsgyLGgJW+Ks1mPTRMql/G8P+3aEfyx4h9eH37MFWIvHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 5 Dec 2025 18:24:33 +0800 (GMT+08:00)
Date: Fri, 5 Dec 2025 18:24:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Christian Bruel" <christian.bruel@foss.st.com>
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com
Subject: Re: Re: [PATCH v7 3/3] PCI: dwc: Add no_pme_handshake flag and skip
 PME_Turn_Off broadcast
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <0d37ef61-4407-470b-975d-5f7a147f7f10@foss.st.com>
References: <20251202090225.1602-1-zhangsenchuan@eswincomputing.com>
 <20251202090434.1653-1-zhangsenchuan@eswincomputing.com>
 <0d37ef61-4407-470b-975d-5f7a147f7f10@foss.st.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <560d3705.f47.19aee0abfc2.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgBnq67hsjJpSc2BAA--.3498W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAgEHBmkxt
	-ojKgABsf
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQ2hyaXN0aWFuIEJydWVs
IiA8Y2hyaXN0aWFuLmJydWVsQGZvc3Muc3QuY29tPgo+IFNlbmQgdGltZTpXZWRuZXNkYXksIDAz
LzEyLzIwMjUgMTg6MDk6MDYKPiBUbzogemhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20s
IGJoZWxnYWFzQGdvb2dsZS5jb20sIG1hbmlAa2VybmVsLm9yZywga3J6aytkdEBrZXJuZWwub3Jn
LCBjb25vcitkdEBrZXJuZWwub3JnLCBscGllcmFsaXNpQGtlcm5lbC5vcmcsIGt3aWxjenluc2tp
QGtlcm5lbC5vcmcsIHJvYmhAa2VybmVsLm9yZywgcC56YWJlbEBwZW5ndXRyb25peC5kZSwgamlu
Z29vaGFuMUBnbWFpbC5jb20sIGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tLCBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnLCBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZywgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZywgbWF5YW5rLnJhbmFAb3NzLnF1YWxjb21tLmNvbSwgc2hyYWRo
YS50QHNhbXN1bmcuY29tLCBrcmlzaG5hLmNodW5kcnVAb3NzLnF1YWxjb21tLmNvbSwgdGhpcHBl
c3dhbXkuaGF2YWxpZ2VAYW1kLmNvbSwgaW5vY2hpYW1hQGdtYWlsLmNvbSwgRnJhbmsubGlAbnhw
LmNvbQo+IENjOiBuaW5neXVAZXN3aW5jb21wdXRpbmcuY29tLCBsaW5taW5AZXN3aW5jb21wdXRp
bmcuY29tLCBwaW5rZXNoLnZhZ2hlbGFAZWluZm9jaGlwcy5jb20sIG91eWFuZ2h1aUBlc3dpbmNv
bXB1dGluZy5jb20KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDMvM10gUENJOiBkd2M6IEFkZCBu
b19wbWVfaGFuZHNoYWtlIGZsYWcgYW5kIHNraXAgUE1FX1R1cm5fT2ZmIGJyb2FkY2FzdAo+IAo+
IEhlbGxvLAo+IAo+IE9uIDEyLzIvMjUgMTA6MDQsIHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRp
bmcuY29tIHdyb3RlOgo+ID4gRnJvbTogU2VuY2h1YW4gWmhhbmcgPHpoYW5nc2VuY2h1YW5AZXN3
aW5jb21wdXRpbmcuY29tPgo+ID4gCj4gPiBUaGUgRVNXSU4gRUlDNzcwMCBTb0MgbGFja3MgaGFy
ZHdhcmUgc3VwcG9ydCBmb3IgdGhlIEwyL0wzIGxvdy1wb3dlcgo+ID4gbGluayBzdGF0ZXMuIEl0
IGNhbm5vdCBlbnRlciB0aGUgTDIvTDMgcmVhZHkgc3RhdGUgdGhyb3VnaCB0aGUKPiA+IFBNRV9U
dXJuX09mZi9QTUVfVG9fQWNrIGhhbmRzaGFrZSBwcm90b2NvbC4gVG8gYWRkcmVzcyB0aGlzLCBh
ZGQgYQo+ID4gbm9fcG1lX2hhbmRzaGFrZSBmbGFnIHNraXAgUE1FX1R1cm5fT2ZmIGJyb2FkY2Fz
dCBhbmQgbGluayBzdGF0ZSBjaGVjawo+ID4gY29kZSwgb3RoZXIgZHJpdmVyIGNhbiByZXVzZSB0
aGlzIGZsYWcgaWYgbWVldCB0aGUgc2ltaWxhciBzaXR1YXRpb24uCj4gCj4gV2hhdCBhYm91dCB0
ZXN0aW5nICFQTUVfU1VQUE9SVCBpbiB0aGUgUE0gQ2FwYWJpbGl0aWVzIFJlZ2lzdGVyLAo+IG9y
IGp1c3QgcmUtdXNlIHRoZSBzdHJ1Y3QgcGNpX2RldiBwbWVfc3VwcG9ydCBmbGFnID8KPiAKCkhp
LCBDaHJpc3RpYW4KClRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9ucy4KT3VyIGhhcmR3YXJl
IHN1cHBvcnRzIGdlbmVyYXRpbmcgUE1FIywgc3VwcG9ydHMgTDBzL0wxL0wxLjEgbG93LXBvd2Vy
IG1vZGUsCmJ1dCBMMi9MMyBsb3ctcG93ZXIgbGluayBzdGF0ZSBpcyBub3Qgc3VwcG9ydGVkLiBJ
dCBjYW5ub3QgZW50ZXIgdGhlIEwyL0wzCnJlYWR5IHN0YXRlIHRocm91Z2ggdGhlIFBNRV9UdXJu
X09mZi9QTUVfVG9fQWNrIGhhbmRzaGFrZSBwcm90b2NvbC4KClRocm91Z2ggdGhlIFBNIENhcGFi
aWxpdGllcyBSZWdpc3RlciwgaXQgY2FuIGJlIHNlZW4gdGhhdCBQTUUjIGlzIHN1cHBvcnRlZC4K
VGhlIHBtZV9zdXBwb3J0IGZsYWcgaXMgYWJvdXQgd2hldGhlciBQTUUjIGdlbmVyYXRpb24gaXMg
c3VwcG9ydGVkLCB3aGljaCBpcyAKbm90IHZlcnkgc3VpdGFibGUgZm9yIHVzLgoKS2luZCByZWdh
cmRzLApTZW5jaHVhbiBaaGFuZwoKPiAKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogWXUgTmluZyA8
bmluZ3l1QGVzd2luY29tcHV0aW5nLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbmdodWkgT3Ug
PG91eWFuZ2h1aUBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTZW5jaHVh
biBaaGFuZyA8emhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiAtLS0KPiA+ICAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDQgKysr
Kwo+ID4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCAgICAg
IHwgMSArCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9z
dC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYwo+
ID4gaW5kZXggMzcyMjA3YzMzYTg1Li44MzAyYmM3YTZjYmYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jCj4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jCj4gPiBAQCAt
MTE2OCw2ICsxMTY4LDkgQEAgaW50IGR3X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNp
ZSAqcGNpKQo+ID4gICAJaWYgKGR3X3BjaWVfcmVhZHdfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VY
UF9MTktDVEwpICYgUENJX0VYUF9MTktDVExfQVNQTV9MMSkKPiA+ICAgCQlyZXR1cm4gMDsKPiA+
IAo+ID4gKwlpZiAocGNpLT5ub19wbWVfaGFuZHNoYWtlKQo+ID4gKwkJZ290byBzdG9wX2xpbms7
Cj4gPiArCj4gPiAgIAlpZiAocGNpLT5wcC5vcHMtPnBtZV90dXJuX29mZikgewo+ID4gICAJCXBj
aS0+cHAub3BzLT5wbWVfdHVybl9vZmYoJnBjaS0+cHApOwo+ID4gICAJfSBlbHNlIHsKPiA+IEBA
IC0xMTk0LDYgKzExOTcsNyBAQCBpbnQgZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19w
Y2llICpwY2kpCj4gPiAgIAkgKi8KPiA+ICAgCXVkZWxheSgxKTsKPiA+IAo+ID4gK3N0b3BfbGlu
azoKPiA+ICAgCWR3X3BjaWVfc3RvcF9saW5rKHBjaSk7Cj4gPiAgIAlpZiAocGNpLT5wcC5vcHMt
PmRlaW5pdCkKPiA+ICAgCQlwY2ktPnBwLm9wcy0+ZGVpbml0KCZwY2ktPnBwKTsKPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oCj4gPiBpbmRleCAzMTY4
NTk1MWEwODAuLmU4MDU3ZGIzMDNkMCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaAo+ID4gQEAgLTU0OSw2ICs1NDksNyBAQCBzdHJ1Y3Qg
ZHdfcGNpZSB7Cj4gPiAgIAkgKiB1c2VfcGFyZW50X2R0X3JhbmdlcyB0byB0cnVlIHRvIGF2b2lk
IHRoaXMgd2FybmluZy4KPiA+ICAgCSAqLwo+ID4gICAJYm9vbAkJCXVzZV9wYXJlbnRfZHRfcmFu
Z2VzOwo+ID4gKwlib29sCQkJbm9fcG1lX2hhbmRzaGFrZTsKPiA+ICAgfTsKPiA+IAo+ID4gICAj
ZGVmaW5lIHRvX2R3X3BjaWVfZnJvbV9wcChwb3J0KSBjb250YWluZXJfb2YoKHBvcnQpLCBzdHJ1
Y3QgZHdfcGNpZSwgcHApCj4gPiAtLQo+ID4gMi4yNS4xCj4gPiAK

