Return-Path: <linux-pci+bounces-40482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5BFC3A360
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 11:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C52189B1C3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B330E0ED;
	Thu,  6 Nov 2025 10:13:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196F27FB0E;
	Thu,  6 Nov 2025 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424000; cv=none; b=uJhv4kOvoVB2gzNPX5iOn8eNgzFutb7QfY3yeZ8DZMrd1RBTYKSU4JGjCT6zJZ7/kIQ8vB7hg5YPcI+WfWG9bpJ5rgVtdiy9FfjyNWso1GrUyHoS3Ad1IiwPI9u5Dm8ow8hck79xuhdfSvKZA+sCy2ssUwAPsiwRxRjQVyjxtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424000; c=relaxed/simple;
	bh=Am44JZtlFDySM0nLZUxPWEMD6BQqB8nTw3EZgYKByTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Izn4KIkjG2NK21b1QCF8OPqJ5wN2+aofj8+gKw/5IwWUXaEnXKkZJNItXlvzeQ4Ul1ow08MyihKTf5ywz/XoXF2Dy0a3pxfdMxk97uowIJkf10bzjRDO1Pn1pNdvRbj4LVm+v1DjjCPlixMa1Yb6lhGtfWo3Q9YHL67BX1s6t5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 6 Nov 2025 18:13:05 +0800 (GMT+08:00)
Date: Thu, 6 Nov 2025 18:13:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, will@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: qcom: Check for the presence of a device
 instead of Link up during suspend
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20251106061326.8241-3-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251106061326.8241-3-manivannan.sadhasivam@oss.qualcomm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <35086b08.c4e.19a58a7d6bc.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgBnq66xdAxpneA6AA--.1003W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAgESBmkLf
	FoZKwABsg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQG9zcy5xdWFsY29tbS5jb20+Cj4gU2VuZCB0
aW1lOlRodXJzZGF5LCAwNi8xMS8yMDI1IDE0OjEzOjI1Cj4gVG86IGxwaWVyYWxpc2lAa2VybmVs
Lm9yZywga3dpbGN6eW5za2lAa2VybmVsLm9yZywgbWFuaUBrZXJuZWwub3JnLCBiaGVsZ2Fhc0Bn
b29nbGUuY29tCj4gQ2M6IHdpbGxAa2VybmVsLm9yZywgbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgcm9iaEBrZXJuZWwub3JnLCBsaW51eC1h
cm0tbXNtQHZnZXIua2VybmVsLm9yZywgemhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20s
ICJNYW5pdmFubmFuIFNhZGhhc2l2YW0iIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1Ab3NzLnF1YWxj
b21tLmNvbT4KPiBTdWJqZWN0OiBbUEFUQ0ggMi8zXSBQQ0k6IHFjb206IENoZWNrIGZvciB0aGUg
cHJlc2VuY2Ugb2YgYSBkZXZpY2UgaW5zdGVhZCBvZiBMaW5rIHVwIGR1cmluZyBzdXNwZW5kCj4g
Cj4gVGhlIHN1c3BlbmQgaGFuZGxlciBjaGVja3MgZm9yIHRoZSBQQ0llIExpbmsgdXAgdG8gZGVj
aWRlIHdoZW4gdG8gdHVybiBvZmYKPiB0aGUgY29udHJvbGxlciByZXNvdXJjZXMuIEJ1dCB0aGlz
IGNoZWNrIGlzIHJhY3kgYXMgdGhlIFBDSWUgTGluayBjYW4gZ28KPiBkb3duIGp1c3QgYWZ0ZXIg
dGhpcyBjaGVjay4KPiAKPiBTbyB1c2UgdGhlIG5ld2x5IGludHJvZHVjZWQgQVBJLCBwY2lfcm9v
dF9wb3J0c19oYXZlX2RldmljZSgpIHRoYXQgY2hlY2tzCj4gZm9yIHRoZSBwcmVzZW5jZSBvZiBh
IGRldmljZSB1bmRlciBhbnkgb2YgdGhlIFJvb3QgUG9ydHMgdG8gcmVwbGFjZSB0aGUKPiBMaW5r
IHVwIGNoZWNrLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFu
aXZhbm5hbi5zYWRoYXNpdmFtQG9zcy5xdWFsY29tbS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jIHwgNiArKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1xY29tLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLXFjb20uYwo+IGluZGV4IDgwNWVkYmJmZTdlYi4uYjJiODllMmU0OTE2IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jCj4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1xY29tLmMKPiBAQCAtMjAxOCw2ICsyMDE4
LDcgQEAgc3RhdGljIGludCBxY29tX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikKPiAgc3RhdGljIGludCBxY29tX3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNl
ICpkZXYpCj4gIHsKPiAgCXN0cnVjdCBxY29tX3BjaWUgKnBjaWU7Cj4gKwlzdHJ1Y3QgZHdfcGNp
ZV9ycCAqcHA7Cj4gIAlpbnQgcmV0ID0gMDsKPiAgCj4gIAlwY2llID0gZGV2X2dldF9kcnZkYXRh
KGRldik7Cj4gQEAgLTIwNTMsOCArMjA1NCw5IEBAIHN0YXRpYyBpbnQgcWNvbV9wY2llX3N1c3Bl
bmRfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KQo+ICAJICogcG93ZXJkb3duIHN0YXRlLiBUaGlz
IHdpbGwgYWZmZWN0IHRoZSBsaWZldGltZSBvZiB0aGUgc3RvcmFnZSBkZXZpY2VzCj4gIAkgKiBs
aWtlIE5WTWUuCj4gIAkgKi8KPiAtCWlmICghZHdfcGNpZV9saW5rX3VwKHBjaWUtPnBjaSkpIHsK
PiAtCQlxY29tX3BjaWVfaG9zdF9kZWluaXQoJnBjaWUtPnBjaS0+cHApOwo+ICsJcHAgPSAmcGNp
ZS0+cGNpLT5wcDsKPiArCWlmICghcGNpX3Jvb3RfcG9ydHNfaGF2ZV9kZXZpY2UocHAtPmJyaWRn
ZS0+YnVzKSkgewoKSSdtIGEgbGl0dGxlIGNvbmZ1c2VkLgpUaGUgcGNpX3Jvb3RfcG9ydHNfaGF2
ZV9kZXZpY2UgZnVuY3Rpb24gY2FuIGhlbHAgY2hlY2sgaWYgdGhlcmUgaXMgYW55IGRldmljZSAK
YXZhaWxhYmxlIHVuZGVyIHRoZSBSb290IFBvcnRzLCBpZiB0aGVyZSBpcyBhIGRldmljZSBhdmFp
bGFibGUsIHRoZSByZXNvdXJjZSAKY2Fubm90IGJlIHJlbGVhc2VkLCBpcyBpdCBhbHNvIG5lY2Vz
c2FyeSB0byByZWxlYXNlIHJlc291cmNlcyB3aGVuIGVudGVyaW5nIAp0aGUgTDIvTDMgc3RhdGU/
Cgo+ICsJCXFjb21fcGNpZV9ob3N0X2RlaW5pdChwcCk7Cj4gIAkJcGNpZS0+c3VzcGVuZGVkID0g
dHJ1ZTsKPiAgCX0KPiAgCj4gLS0gCj4gMi40OC4xCgpCZXN0IFJlZ2FyZHMKU2VuY2h1YW4gWmhh
bmc=

