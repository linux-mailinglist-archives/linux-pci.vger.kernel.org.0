Return-Path: <linux-pci+bounces-35439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5CB43659
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657E316F6B9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFDB2D061E;
	Thu,  4 Sep 2025 08:57:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FED2D2395;
	Thu,  4 Sep 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976266; cv=none; b=AwnOVVGL6jg3TH5WuxBXsI6gagq400B2rCZ89cQz9ikGeUwrAzfOVhWgfXRFH8ZHSlRGKmxlaGVa7jRc15GzqZbqdiLYzynEj4IqMXKkHHzSQpk8w/vWXGAS6lhxtRTTshori2fwpMkTugxtDCBpVIghP2XfgES8eHtCDlNQp8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976266; c=relaxed/simple;
	bh=PecU5S/YvplRGNNqQebJDBuQ2AEn8c874tdcD5AFogE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=E2F37RKmkJob+bDmcONzO/TWuzZlCt9IwpbCfXTlVGy52QJbwq92SWiGsWkMppGTg9dnAOuQ5WWssJU/K8+YnXztbObd5Hi93nA3SfiVlB1by4zjd/zuR0eyXG83pCX4LvXHvLlnOz5DYZe6amI7KVE4vjaBSd7pnln6UmAMng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 4 Sep 2025 16:57:17 +0800 (GMT+08:00)
Date: Thu, 4 Sep 2025 16:57:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
	johan+linaro@kernel.org, quic_schintav@quicinc.com,
	shradha.t@samsung.com, cassel@kernel.org,
	thippeswamy.havalige@amd.com, mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v2 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host
 controller driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <jghozurjqyhmtunivotitgs67h6xo4sb46qcycnbbwyvjcm4ek@vgq75olazmoi>
References: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
 <20250829082405.1203-1-zhangsenchuan@eswincomputing.com>
 <jghozurjqyhmtunivotitgs67h6xo4sb46qcycnbbwyvjcm4ek@vgq75olazmoi>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4fa48331.ce3.19913f1cc89.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgDHZpVtVLlopF_IAA--.24357W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAgEPBmi4b
	dEVxAABs2
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

RGVhciBNYW5pdmFubmFuCgpUaGFuayB5b3UgZm9yIHlvdXIgdGhvcm91Z2ggcmV2aWV3LkhlcmUg
YXJlIHNvbWUgb2YgbXkgY2xhcmlmaWNhdGlvbnMgYW5kIHF1ZXN0aW9ucy4KTG9va2luZyBmb3J3
YXJkIHRvIHlvdXIgYW5zd2VyLCBUaGFuayB5b3UgdmVyeSBtdWNoLgoKPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiTWFuaXZhbm5hbiBTYWRoYXNpdmFtIiA8bWFuaUBrZXJu
ZWwub3JnPgo+IFNlbmQgdGltZTpNb25kYXksIDAxLzA5LzIwMjUgMTQ6NDA6NDEKPiBUbzogemhh
bmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20KPiBDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbSwg
bHBpZXJhbGlzaUBrZXJuZWwub3JnLCBrd2lsY3p5bnNraUBrZXJuZWwub3JnLCByb2JoQGtlcm5l
bC5vcmcsIGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZywgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcsIHAuemFiZWxAcGVuZ3V0cm9uaXguZGUsIGpvaGFuK2xpbmFyb0Br
ZXJuZWwub3JnLCBxdWljX3NjaGludGF2QHF1aWNpbmMuY29tLCBzaHJhZGhhLnRAc2Ftc3VuZy5j
b20sIGNhc3NlbEBrZXJuZWwub3JnLCB0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tLCBtYXlh
bmsucmFuYUBvc3MucXVhbGNvbW0uY29tLCBpbm9jaGlhbWFAZ21haWwuY29tLCBuaW5neXVAZXN3
aW5jb21wdXRpbmcuY29tLCBsaW5taW5AZXN3aW5jb21wdXRpbmcuY29tLCBwaW5rZXNoLnZhZ2hl
bGFAZWluZm9jaGlwcy5jb20KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gUENJOiBlaWM3
NzAwOiBBZGQgRXN3aW4gZWljNzcwMCBQQ0llIGhvc3QgY29udHJvbGxlciBkcml2ZXIKCgo+ID4g
KwkvKiBjb25maWcgZXN3aW4gdmVuZG9yIGlkIGFuZCBlaWM3NzAwIGRldmljZSBpZCAqLwo+ID4g
Kwlkd19wY2llX3dyaXRlbF9kYmkocGNpLCBQQ0lFX1RZUEVfREVWX1ZFTkRfSUQsIDB4MjAzMDFm
ZTEpOwo+IAo+IERvZXMgaXQgbmVlZCB0byBiZSBjb25maWd1cmVkIGFsbCB0aGUgdGltZT8KCkNs
YXJpZmljYXRpb27vvJoKT3VyIGhhcmR3YXJlIGluaXRpYWxpemF0aW9uIGRpZCBub3QgY29uZmln
dXJlIHRoZSBkZXZpY2UgSWQgYW5kIHZlbmRvciBJZC4KTm93LCB3ZSBjYW4gb25seSByZXdyaXRl
IHRoZSBkZXZpY2UgSWQgYW5kIHZlbmRvciBJZCBpbiB0aGUgY29kZS4KCj4gCj4gPiArCj4gPiAr
CS8qIGxhbmUgZml4IGNvbmZpZywgcmVhbCBkcml2ZXIgTk9UIG5lZWQsIGRlZmF1bHQgeDQgKi8K
PiAKPiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICdyZWFkbCBkcml2ZXIgTk9UIG5lZWQnPwo+IAoKQ2xh
cmlmaWNhdGlvbu+8mgpTb3JyeSwgdGhpcyB3YXMgYWRkZWQgZHVyaW5nIHRoZSBjb21wYXRpYmls
aXR5IHBsYXRmb3JtIHRlc3QuIEl0IGlzIG5vdCBuZWVkZWQgZm9yIHJlYWwgZGV2aWNlcy4gCkkg
d2lsbCByZW1vdmUgaXQgbGF0ZXIuCgo+ID4gKwl2YWwgPSBkd19wY2llX3JlYWRsX2RiaShwY2ks
IFBDSUVfUE9SVF9NVUxUSV9MQU5FX0NUUkwpOwo+ID4gKwl2YWwgJj0gMHhmZmZmZmY4MDsKPiA+
ICsJdmFsIHw9IDB4NDQ7Cj4gPiArCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSUVfUE9SVF9N
VUxUSV9MQU5FX0NUUkwsIHZhbCk7Cj4gPiArCj4gPiArCXZhbCA9IGR3X3BjaWVfcmVhZGxfZGJp
KHBjaSwgREVWSUNFX0NPTlRST0xfREVWSUNFX1NUQVRVUyk7Cj4gPiArCXZhbCAmPSB+KDB4NyA8
PCA1KTsKPiA+ICsJdmFsIHw9ICgweDIgPDwgNSk7Cj4gPiArCWR3X3BjaWVfd3JpdGVsX2RiaShw
Y2ksIERFVklDRV9DT05UUk9MX0RFVklDRV9TVEFUVVMsIHZhbCk7Cj4gPiArCj4gPiArCS8qICBj
b25maWcgc3VwcG9ydCAzMiBtc2kgdmVjdG9ycyAqLwo+ID4gKwl2YWwgPSBkd19wY2llX3JlYWRs
X2RiaShwY2ksIFBDSUVfRFNQX1BGMF9NU0lfQ0FQKTsKPiA+ICsJdmFsICY9IH5QQ0lFX01TSV9N
VUxUSVBMRV9NU0dfTUFTSzsKPiA+ICsJdmFsIHw9IFBDSUVfTVNJX01VTFRJUExFX01TR18zMjsK
PiA+ICsJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJRV9EU1BfUEYwX01TSV9DQVAsIHZhbCk7
Cj4gPiArCj4gPiArCS8qIGRpc2FibGUgbXNpeCBjYXAgKi8KPiAKPiBXaHk/IEh3IGRvZXNuJ3Qg
c3VwcG9ydCBNU0ktWCBidXQgaXQgYWR2ZXJ0aXNlcyBNU0ktWCBjYXBhYmlsaXR5Pwo+IAoKSSdt
IG5vdCBxdWl0ZSBzdXJlIHdoYXQgdGhpcyBjb21tZW50IG1lYW5zPyBJbmRlZWQsIG91ciBoYXJk
d2FyZSBkb2Vzbid0IHN1cHBvcnQgTVNJLVguCldlIGNhbid0IGRpc2FibGUgdGhlIE1TSS1YIGNh
cGFiaWxpdHkgdXNpbmcgdGhlIFBDSUVfTkVYVF9DQVBfUFRSIHJlZ2lzdGVyPyBUaGVuIHdoaWNo
IApyZWdpc3RlciBpcyBuZWVkZWQgdG8gZGlzYWJsZSB0aGUgTVNJLVggY2FwYWJpbGl0eT8KCj4g
PiArCXZhbCA9IGR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9ORVhUX0NBUF9QVFIpOwo+ID4g
Kwl2YWwgJj0gMHhmZmZmMDBmZjsKPiA+ICsJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJRV9O
RVhUX0NBUF9QVFIsIHZhbCk7Cj4gPiArCj4gPiArCXJldHVybiAwOwo+ID4gKwo+ID4gK2Vycl9j
bG9jazoKPiA+ICsJcmVzZXRfY29udHJvbF9hc3NlcnQocGNpZS0+cGVyc3QpOwo+ID4gK2Vycl9w
ZXJzdDoKPiA+ICsJZXN3aW5fcGNpZV9wb3dlcl9vZmYocGNpZSk7Cj4gPiArCXJldHVybiByZXQ7
Cj4gPiArfQo+ID4gKwoKCgoKQmVzdCBSZWdhcmRzLApTZW5jaHVhbiBaaGFuZwoKCgo=

