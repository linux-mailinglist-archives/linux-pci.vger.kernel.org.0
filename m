Return-Path: <linux-pci+bounces-43844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1708ACE9A43
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 13:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9FA3302BA98
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 12:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FCF2D738A;
	Tue, 30 Dec 2025 12:22:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647B12C3254;
	Tue, 30 Dec 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767097342; cv=none; b=JJi55UWm/t3kuQuz2RF27do4CSpkYPPq1H3g59z3kFicivtu88BAFOKhGxoWWEdJflrUpDKujtbBAvfg2YxNRF6ELEKuGb6/mkEu4QpBy1zyv4L1P4ewj+WRjg2dxuMnolzs+77C/L0givS25OnHCuF845iTJBI1Mi/jrn5BsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767097342; c=relaxed/simple;
	bh=tjn6bbw5ra6ngw0M/OaHqu61uKvzag7hE58uMCw1iBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bHtD6OgyRESBt13kK/PkAjOvPjK9ANZkkH1pW5BXpZ/pXna8ppfHMypY2UrVcCQEpfawIot6JJH5xawqTxMCWpQUVJTNBnC1oa4nnEWeKyO2xMW+wwcob0nQuxhuspwGbpw2JAnkAaFtJ35ZwVVdh8aMRmb+Q1I9uW87J28Oz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 30 Dec 2025 20:21:56 +0800 (GMT+08:00)
Date: Tue, 30 Dec 2025 20:21:56 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: Re: [PATCH v9 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <37ef98c2-b13f-4292-8db7-df90237c7ce1@wanadoo.fr>
References: <20251229113021.1859-1-zhangsenchuan@eswincomputing.com>
 <20251229113208.1893-1-zhangsenchuan@eswincomputing.com>
 <37ef98c2-b13f-4292-8db7-df90237c7ce1@wanadoo.fr>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c3f7e8f.1ca5.19b6f3533e6.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgBnq67kw1NpSW6MAA--.5459W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAgEMBmlSr
	X0gwAABsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gPiBGcm9tOiBTZW5jaHVhbiBaaGFuZyA8emhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5j
b20+Cj4gPiAKPiA+IEFkZCBkcml2ZXIgZm9yIHRoZSBFc3dpbiBFSUM3NzAwIFBDSWUgaG9zdCBj
b250cm9sbGVyLCB3aGljaCBpcyBiYXNlZCBvbgo+ID4gdGhlIERlc2lnbldhcmUgUENJZSBjb3Jl
LCBJUCByZXZpc2lvbiA1Ljk2YS4gVGhlIFBDSWUgR2VuLjMgY29udHJvbGxlcgo+ID4gc3VwcG9y
dHMgYSBkYXRhIHJhdGUgb2YgOCBHVC9zIGFuZCA0IGNoYW5uZWxzLCBzdXBwb3J0IElOVHggYW5k
IE1TSQo+ID4gaW50ZXJydXB0cy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogWXUgTmluZyA8bmlu
Z3l1QGVzd2luY29tcHV0aW5nLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbmdodWkgT3UgPG91
eWFuZ2h1aUBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTZW5jaHVhbiBa
aGFuZyA8emhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiAtLS0KPiAKPiBIaSwK
PiAKPiA+ICtzdGF0aWMgaW50IGVpYzc3MDBfcGNpZV9ob3N0X2luaXQoc3RydWN0IGR3X3BjaWVf
cnAgKnBwKQo+ID4gK3sKPiA+ICsJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJv
bV9wcChwcCk7Cj4gPiArCXN0cnVjdCBlaWM3NzAwX3BjaWUgKnBjaWUgPSB0b19laWM3NzAwX3Bj
aWUocGNpKTsKPiA+ICsJc3RydWN0IGVpYzc3MDBfcGNpZV9wb3J0ICpwb3J0Owo+ID4gKwl1MzIg
dmFsOwo+ID4gKwlpbnQgcmV0Owo+ID4gKwo+ID4gKwlwY2llLT5udW1fY2xrcyA9IGRldm1fY2xr
X2J1bGtfZ2V0X2FsbF9lbmFibGVkKHBjaS0+ZGV2LCAmcGNpZS0+Y2xrcyk7Cj4gCj4gSXMgdGhp
cyB0aGUgY29ycmVjdCBwbGFjZSB0byBjYWxsIHRoaXMgZnVuY3Rpb24/CgpUaGFua3MgZm9yIHlv
dXIgc3VnZ2VzdGlvbi4KVGhlcmUgbWF5IGJlIGNhc2VzIHdoZXJlIG1lbW9yeSBpcyBhbGxvY2F0
ZWQgYnV0IG5vdCByZWxlYXNlZC4gSSB3aWxsIGZpeCBpdAppbiB0aGUgbmV4dCBwYXRjaC4KCj4g
Cj4gZWljNzcwMF9wY2llX2hvc3RfaW5pdCgpIGlzIGNhbGxlZCBmcm9tIGVpYzc3MDBfcGNpZV9y
ZXN1bWVfbm9pcnEoKSBhbmQgCj4gY2FsbGluZyBhIGRldm0gZnVuY3Rpb24gZnJvbSBhIHJlc3Vt
ZSBmdW5jdGlvbiBpcyByZWFsbHkgdW51c3VhbCBhbmQgaXMgCj4gbGlrZWx5IHRvIGxlYWsgbWVt
b3J5Lgo+IAo+ID4gKwlpZiAocGNpZS0+bnVtX2Nsa3MgPCAwKQo+ID4gKwkJcmV0dXJuIGRldl9l
cnJfcHJvYmUocGNpLT5kZXYsIHBjaWUtPm51bV9jbGtzLAo+ID4gKwkJCQkgICAgICJGYWlsZWQg
dG8gZ2V0IHBjaWUgY2xvY2tzXG4iKTsKPiA+ICsKPiA+ICsJLyoKPiA+ICsJICogVGhlIFBXUiBh
bmQgREJJIHJlc2V0IHNpZ25hbHMgYXJlIHJlc3BlY3RpdmVseSB1c2VkIHRvIHJlc2V0IHRoZQo+
ID4gKwkgKiBQQ0llIGNvbnRyb2xsZXIgYW5kIHRoZSBEQkkgcmVnaXN0ZXIuCj4gPiArCSAqCj4g
PiArCSAqIFRoZSBQRVJTVCMgc2lnbmFsIGlzIGEgcmVzZXQgc2lnbmFsIHRoYXQgc2ltdWx0YW5l
b3VzbHkgY29udHJvbHMgdGhlCj4gPiArCSAqIFBDSWUgY29udHJvbGxlciwgUEhZLCBhbmQgRW5k
cG9pbnQuIEJlZm9yZSBjb25maWd1cmluZyB0aGUgUEhZLCB0aGUKPiA+ICsJICogUEVSU1QjIHNp
Z25hbCBtdXN0IGZpcnN0IGJlIGRlYXNzZXJ0ZWQuCj4gPiArCSAqCj4gPiArCSAqIFRoZSBleHRl
cm5hbCByZWZlcmVuY2UgY2xvY2sgaXMgc3VwcGxpZWQgc2ltdWx0YW5lb3VzbHkgdG8gdGhlIFBI
WQo+ID4gKwkgKiBhbmQgRVAuIFdoZW4gdGhlIFBIWSBpcyBjb25maWd1cmFibGUsIHRoZSBlbnRp
cmUgY2hpcCBhbHJlYWR5IGhhcwo+ID4gKwkgKiBzdGFibGUgcG93ZXIgYW5kIHJlZmVyZW5jZSBj
bG9jay4gVGhlIFBIWSB3aWxsIGJlIHJlYWR5IHdpdGhpbiAyMG1zCj4gPiArCSAqIGFmdGVyIHdy
aXRpbmcgYXBwX2hvbGRfcGh5X3JzdCByZWdpc3RlciBiaXQgb2YgRUxCSSByZWdpc3RlciBzcGFj
ZS4KPiA+ICsJICovCj4gPiArCXJldCA9IHJlc2V0X2NvbnRyb2xfYnVsa19kZWFzc2VydChFSUM3
NzAwX05VTV9SU1RTLCBwY2llLT5yZXNldHMpOwo+ID4gKwlpZiAocmV0KSB7Cj4gPiArCQlkZXZf
ZXJyKHBjaWUtPnBjaS5kZXYsICJGYWlsZWQgdG8gZGVhc3NlcnQgcmVzZXRzXG4iKTsKPiA+ICsJ
CXJldHVybiByZXQ7Cj4gPiArCX0KPiA+ICsKPiA+ICsJLyogQ29uZmlndXJlIFJvb3QgUG9ydCB0
eXBlICovCj4gPiArCXZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpLT5lbGJpX2Jhc2UgKyBQQ0lFRUxC
SV9DVFJMMF9PRkZTRVQpOwo+ID4gKwl2YWwgJj0gflBDSUVFTEJJX0NUUkwwX0RFVl9UWVBFOwo+
ID4gKwl2YWwgfD0gRklFTERfUFJFUChQQ0lFRUxCSV9DVFJMMF9ERVZfVFlQRSwgUENJX0VYUF9U
WVBFX1JPT1RfUE9SVCk7Cj4gPiArCXdyaXRlbF9yZWxheGVkKHZhbCwgcGNpLT5lbGJpX2Jhc2Ug
KyBQQ0lFRUxCSV9DVFJMMF9PRkZTRVQpOwo+ID4gKwo+ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5
KHBvcnQsICZwY2llLT5wb3J0cywgbGlzdCkgewo+ID4gKwkJcmV0ID0gZWljNzcwMF9wY2llX3Bl
cnN0X3Jlc2V0KHBvcnQsIHBjaWUpOwo+ID4gKwkJaWYgKHJldCkKPiA+ICsJCQlnb3RvIGVycl9w
ZXJzdDsKPiA+ICsJfQo+ID4gKwo+ID4gKwkvKiBDb25maWd1cmUgYXBwX2hvbGRfcGh5X3JzdCAq
Lwo+ID4gKwl2YWwgPSByZWFkbF9yZWxheGVkKHBjaS0+ZWxiaV9iYXNlICsgUENJRUVMQklfQ1RS
TDBfT0ZGU0VUKTsKPiA+ICsJdmFsICY9IH5QQ0lFRUxCSV9BUFBfSE9MRF9QSFlfUlNUOwo+ID4g
Kwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaS0+ZWxiaV9iYXNlICsgUENJRUVMQklfQ1RSTDBfT0ZG
U0VUKTsKPiA+ICsKPiA+ICsJLyogVGhlIG1heGltdW0gd2FpdGluZyB0aW1lIGZvciB0aGUgY2xv
Y2sgc3dpdGNoIGxvY2sgaXMgMjBtcyAqLwo+ID4gKwlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXQo
cGNpLT5lbGJpX2Jhc2UgKyBQQ0lFRUxCSV9TVEFUVVMwX09GRlNFVCwgdmFsLAo+ID4gKwkJCQkg
ISh2YWwgJiBQQ0lFRUxCSV9QTV9TRUxfQVVYX0NMSyksIDEwMDAsCj4gPiArCQkJCSAyMDAwMCk7
Cj4gPiArCWlmIChyZXQpIHsKPiA+ICsJCWRldl9lcnIocGNpLT5kZXYsICJUaW1lb3V0IHdhaXRp
bmcgZm9yIFBNX1NFTF9BVVhfQ0xLIHJlYWR5XG4iKTsKPiA+ICsJCWdvdG8gZXJyX3BoeV9pbml0
Owo+ID4gKwl9Cj4gPiArCj4gPiArCS8qCj4gPiArCSAqIENvbmZpZ3VyZSBFU1dJTiBWSUQ6RElE
IGZvciBSb290IFBvcnQgYXMgdGhlIGRlZmF1bHQgdmFsdWVzIGFyZQo+ID4gKwkgKiBpbnZhbGlk
Lgo+ID4gKwkgKi8KPiA+ICsJZHdfcGNpZV9kYmlfcm9fd3JfZW4ocGNpKTsKPiA+ICsJZHdfcGNp
ZV93cml0ZXdfZGJpKHBjaSwgUENJX1ZFTkRPUl9JRCwgUENJX1ZFTkRPUl9JRF9FU1dJTik7Cj4g
PiArCWR3X3BjaWVfd3JpdGV3X2RiaShwY2ksIFBDSV9ERVZJQ0VfSUQsIFBDSV9ERVZJQ0VfSURf
RVNXSU4pOwo+ID4gKwlkd19wY2llX2RiaV9yb193cl9kaXMocGNpKTsKPiA+ICsKPiA+ICsJcmV0
dXJuIDA7Cj4gPiArCj4gPiArZXJyX3BoeV9pbml0Ogo+ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5
KHBvcnQsICZwY2llLT5wb3J0cywgbGlzdCkKPiA+ICsJCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KHBv
cnQtPnBlcnN0KTsKPiA+ICtlcnJfcGVyc3Q6Cj4gPiArCXJlc2V0X2NvbnRyb2xfYnVsa19hc3Nl
cnQoRUlDNzcwMF9OVU1fUlNUUywgcGNpZS0+cmVzZXRzKTsKPiA+ICsKPiA+ICsJcmV0dXJuIHJl
dDsKPiA+ICt9Cj4gCj4gLi4uCj4gCj4gPiArREVGSU5FX05PSVJRX0RFVl9QTV9PUFMoZWljNzcw
MF9wY2llX3BtLCBlaWM3NzAwX3BjaWVfc3VzcGVuZF9ub2lycSwKPiA+ICsJCQllaWM3NzAwX3Bj
aWVfcmVzdW1lX25vaXJxKTsKPiA+ICsKPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCBlaWM3NzAwX3BjaWVfb2ZfbWF0Y2hbXSA9IHsKPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJl
c3dpbixlaWM3NzAwLXBjaWUiIH0sCj4gPiArCXt9LAo+IAo+IE5pdHBpY2s6IE5vIG5lZWQgZm9y
IHRyYWlsaW5nIGNvbW1hIGFmdGVyIGEgdGVybWluYXRvci4KCk9rZXksIHRoYW5rcy4KCktpbmQg
cmVnYXJkcywKU2VuY2h1YW4gWmhhbmcKCg==

