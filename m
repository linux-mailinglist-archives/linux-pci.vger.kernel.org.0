Return-Path: <linux-pci+bounces-41847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECDDC779A4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 07:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF94E3F4B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B70255E26;
	Fri, 21 Nov 2025 06:48:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF08238C07;
	Fri, 21 Nov 2025 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763707733; cv=none; b=jxm25sAwXGavXGxvSnkkFANp9lr7buWAnIG5xLE7mtPFU8qTAwLFstB+eVot0Z1btSf/mF7bRyFKOBlr0uoqqO8lkDnS8DxLOAA1gLxnsnzICDQNpNLPsZgE3zJpH5vLHXKq91Koz1leIoUmWsIQFL0vm6yIDIiK6/genzgk/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763707733; c=relaxed/simple;
	bh=fS5PgzwvioGL5pHjmQTgLKdllFC+X3iN9pvEDO4sWNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=K0mxB8SdnYkBnH4WO1JkN8niHWfhm83I0tGmgHlpiKT4u/XGY0/7a/9/+PI45UN/SePBUcl3G2nuYZr2UcWH+4nhLvfkRmlvyygmUhR0baOh0eU1h2stYyPvlxJkGGvLA54vJVSiwp4lGR9yJFCngTdrwSUcX2noUR7AvaJJkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 21 Nov 2025 14:48:20 +0800 (GMT+08:00)
Date: Fri, 21 Nov 2025 14:48:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	p.zabel@pengutronix.de, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com,
	Frank.li@nxp.com
Subject: Re: Re: [PATCH v6 3/3] PCI: dwc: Add no_suspport_L2 flag and skip
 PME_Turn_Off broadcast
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <dux47crrf6ranvexkpzw667hzmkgfguqadseco52svgvglalye@alxqq4ybu672>
References: <20251120101018.1477-1-zhangsenchuan@eswincomputing.com>
 <20251120101236.1538-1-zhangsenchuan@eswincomputing.com>
 <dux47crrf6ranvexkpzw667hzmkgfguqadseco52svgvglalye@alxqq4ybu672>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <11367b43.6d3.19aa52bc596.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgDnK680CyBpFzB9AA--.2279W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAQENBmkfQ
	oMSzAAAsi
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIiA8bWFuaUBrZXJuZWwub3JnPgo+IFNlbmQgdGltZTpUaHVyc2RheSwgMjAvMTEvMjAy
NSAyMDo0NTozOAo+IFRvOiB6aGFuZ3NlbmNodWFuQGVzd2luY29tcHV0aW5nLmNvbQo+IENjOiBi
aGVsZ2Fhc0Bnb29nbGUuY29tLCBrcnprK2R0QGtlcm5lbC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5v
cmcsIGxwaWVyYWxpc2lAa2VybmVsLm9yZywga3dpbGN6eW5za2lAa2VybmVsLm9yZywgcm9iaEBr
ZXJuZWwub3JnLCBwLnphYmVsQHBlbmd1dHJvbml4LmRlLCBqaW5nb29oYW4xQGdtYWlsLmNvbSwg
Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20sIGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcs
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
LCBjaHJpc3RpYW4uYnJ1ZWxAZm9zcy5zdC5jb20sIG1heWFuay5yYW5hQG9zcy5xdWFsY29tbS5j
b20sIHNocmFkaGEudEBzYW1zdW5nLmNvbSwga3Jpc2huYS5jaHVuZHJ1QG9zcy5xdWFsY29tbS5j
b20sIHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20sIGlub2NoaWFtYUBnbWFpbC5jb20sIG5p
bmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxpbm1pbkBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtl
c2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwgb3V5YW5naHVpQGVzd2luY29tcHV0aW5nLmNvbSwg
RnJhbmsubGlAbnhwLmNvbQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMy8zXSBQQ0k6IGR3Yzog
QWRkIG5vX3N1c3Bwb3J0X0wyIGZsYWcgYW5kIHNraXAgUE1FX1R1cm5fT2ZmIGJyb2FkY2FzdAo+
IAo+IE9uIFRodSwgTm92IDIwLCAyMDI1IGF0IDA2OjEyOjM1UE0gKzA4MDAsIHpoYW5nc2VuY2h1
YW5AZXN3aW5jb21wdXRpbmcuY29tIHdyb3RlOgo+ID4gRnJvbTogU2VuY2h1YW4gWmhhbmcgPHpo
YW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gCj4gPiBUaGUgRVNXSU4gRUlDNzcw
MCBzb2MgZG9lcyBub3Qgc3VwcG9ydCBlbnRlciBMMiBsaW5rIHN0YXRlLiBUaGVyZWZvcmUgYWRk
Cj4gPiBub19zdXNwcG9ydF9MMiBmbGFnIHNraXAgUE1FX1R1cm5fT2ZmIGJyb2FkY2FzdCBhbmQg
bGluayBzdGF0ZSBjaGVjayBjb2RlLAo+ID4gb3RoZXIgZHJpdmVyIGNhbiByZXVzZSB0aGlzIGZs
YWcgaWYgbWVldCB0aGUgc2ltaWxhciBzaXR1YXRpb24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6
IFl1IE5pbmcgPG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
YW5naHVpIE91IDxvdXlhbmdodWlAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gU2lnbmVkLW9mZi1i
eTogU2VuY2h1YW4gWmhhbmcgPHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29tPgo+IAo+
IERvZXMgdGhpcyBwYXRjaCB3b3JrIGZvciB5b3U/Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtcGNpLzIwMjUxMTE5LXBjaS1kd2Mtc3VzcGVuZC1yZXdvcmstdjEtMS1hYWQxMDQ4Mjg1
NjJAb3NzLnF1YWxjb21tLmNvbS8KCmlmIHRoZSBQQ0llIGxpbmsgaXMgbm90IHVwLCB0aGlzIHN1
aXRzIG1lIHRvbywgYnV0IGlmIHRoZSBQQ0llIGxpbmsgdXAsIApvdXIgaGFyZHdhcmUgZG9lcyBu
b3Qgc3VwcG9ydCBlbnRlcmluZyB0aGUgTDIgbGluayBzdGF0ZS4gQXQgdGhpcyBwb2ludCwgCml0
IGlzIGFsc28gbmVjZXNzYXJ5IHRvIHNraXAgdGhlIGJyb2FkY2FzdCBQTUVfVHVybl9PZmYgbWVz
c2FnZSBhbmQgd2FpdApmb3IgTDIgdHJhbnNpdGlvbi4KCktpbmQgcmVnYXJkcywKU2VuY2h1YW4g
WmhhbmcKCj4gCj4gPiAtLS0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUtaG9zdC5jIHwgNCArKysrCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmggICAgICB8IDEgKwo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLWhvc3QuYwo+ID4gaW5kZXggZTkyNTEzYzViZGE1Li5hMjAzNTc3NjA2ZTUg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUtaG9zdC5jCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUtaG9zdC5jCj4gPiBAQCAtMTE1Niw2ICsxMTU2LDkgQEAgaW50IGR3X3BjaWVfc3VzcGVu
ZF9ub2lycShzdHJ1Y3QgZHdfcGNpZSAqcGNpKQo+ID4gIAlpZiAoZHdfcGNpZV9yZWFkd19kYmko
cGNpLCBvZmZzZXQgKyBQQ0lfRVhQX0xOS0NUTCkgJiBQQ0lfRVhQX0xOS0NUTF9BU1BNX0wxKQo+
ID4gIAkJcmV0dXJuIDA7Cj4gPiAKPiA+ICsJaWYgKHBjaS0+bm9fc3VzcHBvcnRfTDIpCj4gPiAr
CQlnb3RvIHN0b3BfbGluazsKPiA+ICsKPiA+ICAJaWYgKHBjaS0+cHAub3BzLT5wbWVfdHVybl9v
ZmYpIHsKPiA+ICAJCXBjaS0+cHAub3BzLT5wbWVfdHVybl9vZmYoJnBjaS0+cHApOwo+ID4gIAl9
IGVsc2Ugewo+ID4gQEAgLTExODIsNiArMTE4NSw3IEBAIGludCBkd19wY2llX3N1c3BlbmRfbm9p
cnEoc3RydWN0IGR3X3BjaWUgKnBjaSkKPiA+ICAJICovCj4gPiAgCXVkZWxheSgxKTsKPiA+IAo+
ID4gK3N0b3BfbGluazoKPiA+ICAJZHdfcGNpZV9zdG9wX2xpbmsocGNpKTsKPiA+ICAJaWYgKHBj
aS0+cHAub3BzLT5kZWluaXQpCj4gPiAgCQlwY2ktPnBwLm9wcy0+ZGVpbml0KCZwY2ktPnBwKTsK
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUuaCBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oCj4gPiBp
bmRleCBlOTk1ZjY5MmExZWMuLjE3MGE3MzI5OWNlNSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaAo+ID4gQEAgLTUzOSw2ICs1MzksNyBA
QCBzdHJ1Y3QgZHdfcGNpZSB7Cj4gPiAgCSAqIHVzZV9wYXJlbnRfZHRfcmFuZ2VzIHRvIHRydWUg
dG8gYXZvaWQgdGhpcyB3YXJuaW5nLgo+ID4gIAkgKi8KPiA+ICAJYm9vbAkJCXVzZV9wYXJlbnRf
ZHRfcmFuZ2VzOwo+ID4gKwlib29sCQkJbm9fc3VzcHBvcnRfTDI7Cj4gPiAgfTsKPiA+IAo+ID4g
ICNkZWZpbmUgdG9fZHdfcGNpZV9mcm9tX3BwKHBvcnQpIGNvbnRhaW5lcl9vZigocG9ydCksIHN0
cnVjdCBkd19wY2llLCBwcCkKPiA+IC0tCj4gPiAyLjI1LjEKPiA+IAo+IAo+IC0tIAo+IOCuruCu
o+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40K

