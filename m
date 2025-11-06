Return-Path: <linux-pci+bounces-40481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC11C3A2B5
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2252C422949
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892003090FB;
	Thu,  6 Nov 2025 10:03:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283030CDA8;
	Thu,  6 Nov 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423388; cv=none; b=tB0HgZlEcwo7dF8uT26eQ3npxdSm3+Nb6Vb/1f+OFelAX7zRlBmgbHX4pwwxXCtml3MvoYlKk3KOidIiFYX4O4oPsGF2bsYA3brLt0EJdYhzq72LhvsHum91M3Jh85eRljlhD9QpgyR181HNDgiUCXvbLkX4pRfU4TR024mQzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423388; c=relaxed/simple;
	bh=XeZIE5n7gAYpZUb+WGsobDp63rpvo6ZQvTzCOegPdYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=fKd3DVvYhf47MyuGKdH7VOOfjey+t7HGsdNz4OQhrs3EjPbe2KamTvIVF9pMD5aOmZlNxAiK1sFDq/BcMEWdOXeVHLCmKaHHZvlc8sQOKEcSMVS7Clw7pOYMkAvS2QXWo6p/3OWyyUiVxbHPtK6y2LdP51VmCafym5Rb8VwaIyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 6 Nov 2025 18:02:55 +0800 (GMT+08:00)
Date: Thu, 6 Nov 2025 18:02:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, will@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: Skip PME_Turn_Off and L2/L3 transition if
 no device is available
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20251106061326.8241-4-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251106061326.8241-4-manivannan.sadhasivam@oss.qualcomm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3d960043.c46.19a589e8637.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgDnK69Pcgxpjt46AA--.1010W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAgESBmkLf
	FoYnQABsX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQG9zcy5xdWFsY29tbS5jb20+Cj4gU2VuZCB0
aW1lOlRodXJzZGF5LCAwNi8xMS8yMDI1IDE0OjEzOjI2Cj4gVG86IGxwaWVyYWxpc2lAa2VybmVs
Lm9yZywga3dpbGN6eW5za2lAa2VybmVsLm9yZywgbWFuaUBrZXJuZWwub3JnLCBiaGVsZ2Fhc0Bn
b29nbGUuY29tCj4gQ2M6IHdpbGxAa2VybmVsLm9yZywgbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgcm9iaEBrZXJuZWwub3JnLCBsaW51eC1h
cm0tbXNtQHZnZXIua2VybmVsLm9yZywgemhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20s
ICJNYW5pdmFubmFuIFNhZGhhc2l2YW0iIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1Ab3NzLnF1YWxj
b21tLmNvbT4KPiBTdWJqZWN0OiBbUEFUQ0ggMy8zXSBQQ0k6IGR3YzogU2tpcCBQTUVfVHVybl9P
ZmYgYW5kIEwyL0wzIHRyYW5zaXRpb24gaWYgbm8gZGV2aWNlIGlzIGF2YWlsYWJsZQo+IAo+IElm
IHRoZXJlIGlzIG5vIGRldmljZSBhdmFpbGFibGUgdW5kZXIgdGhlIFJvb3QgUG9ydHMsIHRoZXJl
IGlzIG5vIHBvaW50IGluCj4gc2VuZGluZyBQTUVfVHVybl9PZmYgYW5kIHdhaXRpbmcgZm9yIEwy
L0wzIHRyYW5zaXRpb24sIGl0IHdpbGwgcmVzdWx0IGluIGEKPiB0aW1lb3V0Lgo+IAo+IEhlbmNl
LCBza2lwIHRob3NlIHN0ZXBzIGlmIG5vIGRldmljZSBpcyBhdmFpbGFibGUgZHVyaW5nIHN1c3Bl
bmQuIFRoZQo+IHJlc3VtZSBmbG93IHJlbWFpbnMgdW5jaGFuZ2VkLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQG9zcy5xdWFs
Y29tbS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS1ob3N0LmMgfCA1ICsrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykK
PiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLWhvc3QuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1o
b3N0LmMKPiBpbmRleCAyMGM5MzMzYmNiMWMuLmI2YjgxMzllOTFlMyAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jCj4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYwo+IEBAIC0y
MCw2ICsyMCw3IEBACj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KPiAgCj4g
ICNpbmNsdWRlICIuLi8uLi9wY2kuaCIKPiArI2luY2x1ZGUgIi4uL3BjaS1ob3N0LWNvbW1vbi5o
Igo+ICAjaW5jbHVkZSAicGNpZS1kZXNpZ253YXJlLmgiCj4gIAo+ICBzdGF0aWMgc3RydWN0IHBj
aV9vcHMgZHdfcGNpZV9vcHM7Cj4gQEAgLTExMjksNiArMTEzMCw5IEBAIGludCBkd19wY2llX3N1
c3BlbmRfbm9pcnEoc3RydWN0IGR3X3BjaWUgKnBjaSkKPiAgCXUzMiB2YWw7Cj4gIAlpbnQgcmV0
Owo+ICAKPiArCWlmICghcGNpX3Jvb3RfcG9ydHNfaGF2ZV9kZXZpY2UocGNpLT5wcC5icmlkZ2Ut
PmJ1cykpCj4gKwkJZ290byBzdG9wX2xpbms7Cj4gKwo+ICAJLyoKPiAgCSAqIElmIEwxU1MgaXMg
c3VwcG9ydGVkLCB0aGVuIGRvIG5vdCBwdXQgdGhlIGxpbmsgaW50byBMMiBhcyBzb21lCj4gIAkg
KiBkZXZpY2VzIHN1Y2ggYXMgTlZNZSBleHBlY3QgbG93IHJlc3VtZSBsYXRlbmN5Lgo+IEBAIC0x
MTYyLDYgKzExNjYsNyBAQCBpbnQgZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2ll
ICpwY2kpCj4gIAkgKi8KPiAgCXVkZWxheSgxKTsKPiAgCj4gK3N0b3BfbGluazoKPiAgCWR3X3Bj
aWVfc3RvcF9saW5rKHBjaSk7Cj4gIAlpZiAocGNpLT5wcC5vcHMtPmRlaW5pdCkKPiAgCQlwY2kt
PnBwLm9wcy0+ZGVpbml0KCZwY2ktPnBwKTsKPiAtLSAKPiAyLjQ4LjEKCmhpLCBNYW5pdmFubmFu
CgpJJ2QgbGlrZSB5b3VyIGFkdmljZSBvbiBhIGZldyB0aGluZ3MuCgpJZiB0aGVyZSBpcyBubyBk
ZXZpY2UgYXZhaWxhYmxlIHVuZGVyIHRoZSBSb290IFBvcnRzLCB0aGUgZHdfcGNpZV93YWl0X2Zv
cl9saW5rCmZ1bmN0aW9uIGluIGR3X3BjaWVfcmVzdW1lX25vaXJxIHN0aWxsIG5lZWQgdG8gd2Fp
dCBmb3IgdGhlIGxpbmtfdXA/IE90aGVyd2lzZQpsaW5rdXAgd2lsbCBUSU1FRE9VVC4gQXQgdGhp
cyB0aW1lLCB3aGVuIHRoZSByZXN1bWUgZnVuY3Rpb24gcmV0dXJuLCAtRVRJTUVET1VUIApyZXR1
cm5lZCB3aGljaCB3aWxsIHJhaXNlICJQTTogZmFpbGVkIHRvIHJlc3VtZSBub2lycTogZXJyb3Ig
LTExMCIuCgpDdXJyZW50bHksIGluIHRoZSBwY2ktaW14Ni5jL3BjaS1sYXllcnNjYXBlLmMvcGNp
ZS1zdG0zMi5jIGZpbGUsIHRoZSAKZHdfcGNpZV9yZXN1bWVfbm9pcnEgZnVuY3Rpb24gaXMgZGly
ZWN0bHkgcmV0dXJuZWQgYWZ0ZXIgdXNlLgpEb2VzIHRoZSBwY2lfcm9vdF9wb3J0c19oYXZlX2Rl
dmljZSBmdW5jdGlvbiBoZWxwIHZlbmRvciBhdm9pZCAKdGhpcyBwcm9ibGVtPwoKQmVzdCBSZWdh
cmRzLApTZW5jaHVhbiBaaGFuZw==

