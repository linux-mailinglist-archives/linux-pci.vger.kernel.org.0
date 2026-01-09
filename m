Return-Path: <linux-pci+bounces-44357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D6CD08DE9
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 12:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 833B6301BE92
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3B350D68;
	Fri,  9 Jan 2026 11:23:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACAD2FD69F;
	Fri,  9 Jan 2026 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957816; cv=none; b=JN6lqc6bkDrSxFC5P4h8zCP1sLKxhkUTg+1zUcMLZn+pgbmTac0FeAfragL0QIjfpyI0QV7vK97hzpdqxoV+9EB4B7JzBE3W2VH2/7YwllFI9k2C2BO2Z/84l+n9EkFOMfCslg8FOVD5DrdC/RTwTK1smp7X5lMjGnEDy3WMBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957816; c=relaxed/simple;
	bh=0stQzMsZmDNiH6Qln6FwiN3pW8ecpJNWONBqh7RF9Lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=cJbLWN5MK5dkmBNy53Ih1ySAmTBM6+KSgzmRxfkSXg+b4NL7k6+jqNUykAi+0OYTAGYKkmv8w0GnfBy88PhsHKGdQS6i0Usv+eOGeb4rbfBm+A5sTuYxNmLeu09beeHeRjSLuv0P4TJNGCo2vo3tGxys4Ymh69F3F2BNkO2WFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 9 Jan 2026 19:23:07 +0800 (GMT+08:00)
Date: Fri, 9 Jan 2026 19:23:07 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christian.bruel@foss.st.com,
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com, "Niklas Cassel" <cassel@kernel.org>,
	sumit.kumar@oss.qualcomm.com
Subject: Re: Re: [PATCH v9 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <4f3rhkrlp3jypajh77rohqgpoujivpxq6g3o6vrt6u7u5j2atd@gd5o3vtlhapp>
References: <20260105223037.GA332950@bhelgaas>
 <3c8d6749.1f49.19b93552d97.Coremail.zhangsenchuan@eswincomputing.com>
 <4f3rhkrlp3jypajh77rohqgpoujivpxq6g3o6vrt6u7u5j2atd@gd5o3vtlhapp>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6757aa97.21d8.19ba27ef220.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgDnK68b5WBpVoKSAA--.6507W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAQECBmlf3
	AofuAADsA
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

K2NjIFN1bWl0Cgo+IE9uIFR1ZSwgSmFuIDA2LCAyMDI2IGF0IDA4OjQzOjExUE0gKzA4MDAsIHpo
YW5nc2VuY2h1YW4gd3JvdGU6Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMi8yXSBQQ0k6
IGVpYzc3MDA6IEFkZCBFc3dpbiBQQ0llIGhvc3QgY29udHJvbGxlciBkcml2ZXIKPiA+ID4gCj4g
PiA+IFsrY2MgTmlrbGFzLCBsaXN0IHZzIGFycmF5IG9mIHBvcnRzXQo+ID4gPiAKPiA+ID4gT24g
TW9uLCBEZWMgMjksIDIwMjUgYXQgMDc6MzI6MDdQTSArMDgwMCwgemhhbmdzZW5jaHVhbkBlc3dp
bmNvbXB1dGluZy5jb20gd3JvdGU6Cj4gPiA+ID4gRnJvbTogU2VuY2h1YW4gWmhhbmcgPHpoYW5n
c2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gPiA+IAo+ID4gPiA+IEFkZCBkcml2ZXIg
Zm9yIHRoZSBFc3dpbiBFSUM3NzAwIFBDSWUgaG9zdCBjb250cm9sbGVyLCB3aGljaCBpcyBiYXNl
ZCBvbgo+ID4gPiA+IHRoZSBEZXNpZ25XYXJlIFBDSWUgY29yZSwgSVAgcmV2aXNpb24gNS45NmEu
IFRoZSBQQ0llIEdlbi4zIGNvbnRyb2xsZXIKPiA+ID4gPiBzdXBwb3J0cyBhIGRhdGEgcmF0ZSBv
ZiA4IEdUL3MgYW5kIDQgY2hhbm5lbHMsIHN1cHBvcnQgSU5UeCBhbmQgTVNJCj4gPiA+ID4gaW50
ZXJydXB0cy4KPiA+ID4gCj4gPiA+ID4gK3N0YXRpYyBpbnQgZWljNzcwMF9wY2llX3BhcnNlX3Bv
cnQoc3RydWN0IGVpYzc3MDBfcGNpZSAqcGNpZSwKPiA+ID4gPiArCQkJCSAgIHN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbm9kZSkKPiA+ID4gPiArewo+ID4gPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0g
cGNpZS0+cGNpLmRldjsKPiA+ID4gPiArCXN0cnVjdCBlaWM3NzAwX3BjaWVfcG9ydCAqcG9ydDsK
PiA+ID4gPiArCj4gPiA+ID4gKwlwb3J0ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwb3J0
KSwgR0ZQX0tFUk5FTCk7Cj4gPiA+ID4gKwlpZiAoIXBvcnQpCj4gPiA+ID4gKwkJcmV0dXJuIC1F
Tk9NRU07Cj4gPiA+ID4gKwo+ID4gPiA+ICsJcG9ydC0+cGVyc3QgPSBvZl9yZXNldF9jb250cm9s
X2dldF9leGNsdXNpdmUobm9kZSwgInBlcnN0Iik7Cj4gPiA+ID4gKwlpZiAoSVNfRVJSKHBvcnQt
PnBlcnN0KSkgewo+ID4gPiA+ICsJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBQRVJTVCMg
cmVzZXRcbiIpOwo+ID4gPiA+ICsJCXJldHVybiBQVFJfRVJSKHBvcnQtPnBlcnN0KTsKPiA+ID4g
PiArCX0KPiA+ID4gPiArCj4gPiA+ID4gKwkvKgo+ID4gPiA+ICsJICogVE9ETzogU2luY2UgdGhl
IFJvb3QgUG9ydCBub2RlIGlzIHNlcGFyYXRlZCBvdXQgYnkgcGNpZSBkZXZpY2V0cmVlLAo+ID4g
PiA+ICsJICogdGhlIERXQyBjb3JlIGluaXRpYWxpemF0aW9uIGNvZGUgY2FuJ3QgcGFyc2UgdGhl
IG51bS1sYW5lcyBhdHRyaWJ1dGUKPiA+ID4gPiArCSAqIGluIHRoZSBSb290IFBvcnQuIEJlZm9y
ZSBlbnRlcmluZyB0aGUgRFdDIGNvcmUgaW5pdGlhbGl6YXRpb24gY29kZSwKPiA+ID4gPiArCSAq
IHRoZSBwbGF0Zm9ybSBkcml2ZXIgY29kZSBwYXJzZXMgdGhlIFJvb3QgUG9ydCBub2RlLiBUaGUg
RUlDNzcwMCBvbmx5Cj4gPiA+ID4gKwkgKiBzdXBwb3J0cyBvbmUgUm9vdCBQb3J0IG5vZGUsIGFu
ZCB0aGUgbnVtLWxhbmVzIGF0dHJpYnV0ZSBpcyBzdWl0YWJsZQo+ID4gPiA+ICsJICogZm9yIHRo
ZSBjYXNlIG9mIG9uZSBSb290IFBvcnQuCj4gPiA+ID4gKwkgKi8KPiA+ID4gPiArCWlmICghb2Zf
cHJvcGVydHlfcmVhZF91MzIobm9kZSwgIm51bS1sYW5lcyIsICZwb3J0LT5udW1fbGFuZXMpKQo+
ID4gPiA+ICsJCXBjaWUtPnBjaS5udW1fbGFuZXMgPSBwb3J0LT5udW1fbGFuZXM7Cj4gPiA+ID4g
Kwo+ID4gPiA+ICsJSU5JVF9MSVNUX0hFQUQoJnBvcnQtPmxpc3QpOwo+ID4gPiA+ICsJbGlzdF9h
ZGRfdGFpbCgmcG9ydC0+bGlzdCwgJnBjaWUtPnBvcnRzKTsKPiA+ID4gCj4gPiA+IE5pa2xhcyBy
YWlzZWQgYW4gaW50ZXJlc3RpbmcgcXVlc3Rpb24gYWJvdXQgd2hldGhlciBhIGxpc3Qgb3IgYW4g
YXJyYXkKPiA+ID4gaXMgdGhlIGJlc3QgZGF0YSBzdHJ1Y3R1cmUgZm9yIHRoZSBzZXQgb2YgUm9v
dCBQb3J0czoKPiA+ID4gCj4gPiA+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9hVnZrbWtk
NW1XUG14ZWlTQHJ5emVuCj4gPiA+IAo+ID4gPiBNaWdodCBoYXZlIHRvIGl0ZXJhdGUgb3ZlciB0
aGUgY2hpbGQgbm9kZXMgdHdpY2UgKG9uY2UgdG8gY291bnQsIGFnYWluCj4gPiA+IGZvciBlaWM3
NzAwX3BjaWVfcGFyc2VfcG9ydCgpKSwgYnV0IG90aGVyd2lzZSB0aGUgYXJyYXkgaXMgcHJvYmFi
bHkKPiA+ID4gc2ltcGxlciBjb2RlLgo+ID4gCj4gPiBBZnRlciByZWFkaW5nIHBhdGNoJ3MgY29t
bWVudHMsIGxpc3RzIGFuZCBhcnJheXMgc2VlbSB0byBiZSBnb29kIGNob2ljZXMsCj4gPiBJIGRv
bid0IGhhdmUgYW55IHBhcnRpY3VsYXJseSBnb29kIGlkZWFzIGZvciB0aGUgdGltZSBiZWluZy4g
QW55d2F5LCB0aGlzCj4gPiBpcyBhIHZlcnkgZ29vZCBwYXRjaCB0aGF0IHN1cHBvcnRzIG11bHRp
cGxlIFJvb3QgUG9ydHMgcmVzb2x1dGlvbnMuCj4gPiAKPiAKPiBJIHN0aWxsIHByZWZlciB1c2lu
ZyBsaXN0cyBmb3IgdGhlIHJlYXNvbnMgbWVudGlvbmVkIGluIHRoYXQgdGhyZWFkLgoKTGlzdHMg
YW5kIGFycmF5cyBkbyBub3QgaGF2ZSB0b28gb2J2aW91cyBkaXNhZHZhbnRhZ2VzLiBGb3IgbWUs
IGkgcHJlZmVyCnRvIHVzZSBsaXN0LiBXZSBjYW4gdXNlIHRoZSBzdGFuZGFyZCBrZXJuZWwgbGlu
a2VkIGxpc3QgQVBJLCB3aGljaCBoYXMgYSAKcmljaCBzZXQgb2YgaGVscGVyIGZ1bmN0aW9ucy4g
SXQgaXMgZGV2ZWxvcGVyLWZyaWVuZGx5IGFuZCBkb2VzIG5vdCByZXF1aXJlIApmYW1pbGlhcml0
eSB3aXRoIG90aGVyIEFQSS4KCkluIGFkZGl0aW9uLCBJIHNhdyB0aGF0IHRoZSBkZXZpY2Ugbm9k
ZXMgImFtZCx2ZXJzYWwyLW1kYi1ob3N0LnlhbWwiIGFuZCAKInNvcGhnbyxzZzIwNDQtcGNpZS55
YW1sIiBoYXZlIG5vZGVzIHRoYXQgYXJlIG5vdCBQb3J0LiBXaWxsIHRoaXMgYWZmZWN0IAp0aGUg
bm9kZSB0cmF2ZXJzYWw/CgpLaW5kIHJlZ2FyZHMsClNlbmNodWFuCgo+IAo+ID4gPiAKPiA+ID4g
PiArCXJldHVybiAwOwo+ID4gPiA+ICt9Cgo=

