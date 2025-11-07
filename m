Return-Path: <linux-pci+bounces-40564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 597A2C3E9E6
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 07:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CC284E1FF3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 06:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BD2877D7;
	Fri,  7 Nov 2025 06:27:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E978279327;
	Fri,  7 Nov 2025 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762496850; cv=none; b=CzsWpGwALEDAaS4+0OZEsmCNZiFxJ5Yq4lgiIxCi+sB2naWQPu18oIqq0I63MIcngjJFWUdH7ue2SVK8GOeUDWQYe6opTNO2hsuhAbxjXczIXLDCmj/EKHJZQuxU/1BRCJbAmD4CyyyexHfglAzxpaoPwubv2MBsZxpJf9svEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762496850; c=relaxed/simple;
	bh=1xjpieqHeM59LEB9+HHGl4iCAgFiOjKdAsjb4ZTHO9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Ixv3+SaoxuS7t/Ox7w5F21+Tsjz8xFTsDhCXlNcD0HodRPB0e2ZKx4S7zzV3urjB31pivMXyddEgr6H1Bwe9Pwsc6QsYo+q/xjy/cMnbGgHHIaSgUz0nuninGuLD6FtxUIBh/qOcvqZb0N41UkDlnIpB6R9wHNsFfUK9sHo/JLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 7 Nov 2025 14:27:15 +0800 (GMT+08:00)
Date: Fri, 7 Nov 2025 14:27:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>,
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	will@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: Re: [PATCH 2/3] PCI: qcom: Check for the presence of a device
 instead of Link up during suspend
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <nhjlanhzndhlbtfohnkypwuzpw6nw43cysjmoam3qv4rrs22hr@ic3hgtfoeb6e>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251106061326.8241-3-manivannan.sadhasivam@oss.qualcomm.com>
 <35086b08.c4e.19a58a7d6bc.Coremail.zhangsenchuan@eswincomputing.com>
 <nhjlanhzndhlbtfohnkypwuzpw6nw43cysjmoam3qv4rrs22hr@ic3hgtfoeb6e>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <311e1152.cc3.19a5cff7033.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgBnq65DkQ1peDpIAA--.1088W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAQETBmkMz
	YETNQAAsa
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIiA8bWFuaUBrZXJuZWwub3JnPgo+IFNlbmQgdGltZTpUaHVyc2RheSwgMDYvMTEvMjAy
NSAxOTo1NzoxNgo+IFRvOiB6aGFuZ3NlbmNodWFuIDx6aGFuZ3NlbmNodWFuQGVzd2luY29tcHV0
aW5nLmNvbT4KPiBDYzogIk1hbml2YW5uYW4gU2FkaGFzaXZhbSIgPG1hbml2YW5uYW4uc2FkaGFz
aXZhbUBvc3MucXVhbGNvbW0uY29tPiwgbHBpZXJhbGlzaUBrZXJuZWwub3JnLCBrd2lsY3p5bnNr
aUBrZXJuZWwub3JnLCBiaGVsZ2Fhc0Bnb29nbGUuY29tLCB3aWxsQGtlcm5lbC5vcmcsIGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIHJvYmhA
a2VybmVsLm9yZywgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmcKPiBTdWJqZWN0OiBSZTog
W1BBVENIIDIvM10gUENJOiBxY29tOiBDaGVjayBmb3IgdGhlIHByZXNlbmNlIG9mIGEgZGV2aWNl
IGluc3RlYWQgb2YgTGluayB1cCBkdXJpbmcgc3VzcGVuZAo+IAo+IE9uIFRodSwgTm92IDA2LCAy
MDI1IGF0IDA2OjEzOjA1UE0gKzA4MDAsIHpoYW5nc2VuY2h1YW4gd3JvdGU6Cj4gPiAKPiA+IAo+
ID4gCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZXMtLS0tLQo+ID4gPiBGcm9tOiAiTWFuaXZh
bm5hbiBTYWRoYXNpdmFtIiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQG9zcy5xdWFsY29tbS5jb20+
Cj4gPiA+IFNlbmQgdGltZTpUaHVyc2RheSwgMDYvMTEvMjAyNSAxNDoxMzoyNQo+ID4gPiBUbzog
bHBpZXJhbGlzaUBrZXJuZWwub3JnLCBrd2lsY3p5bnNraUBrZXJuZWwub3JnLCBtYW5pQGtlcm5l
bC5vcmcsIGJoZWxnYWFzQGdvb2dsZS5jb20KPiA+ID4gQ2M6IHdpbGxAa2VybmVsLm9yZywgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgcm9i
aEBrZXJuZWwub3JnLCBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZywgemhhbmdzZW5jaHVh
bkBlc3dpbmNvbXB1dGluZy5jb20sICJNYW5pdmFubmFuIFNhZGhhc2l2YW0iIDxtYW5pdmFubmFu
LnNhZGhhc2l2YW1Ab3NzLnF1YWxjb21tLmNvbT4KPiA+ID4gU3ViamVjdDogW1BBVENIIDIvM10g
UENJOiBxY29tOiBDaGVjayBmb3IgdGhlIHByZXNlbmNlIG9mIGEgZGV2aWNlIGluc3RlYWQgb2Yg
TGluayB1cCBkdXJpbmcgc3VzcGVuZAo+ID4gPiAKPiA+ID4gVGhlIHN1c3BlbmQgaGFuZGxlciBj
aGVja3MgZm9yIHRoZSBQQ0llIExpbmsgdXAgdG8gZGVjaWRlIHdoZW4gdG8gdHVybiBvZmYKPiA+
ID4gdGhlIGNvbnRyb2xsZXIgcmVzb3VyY2VzLiBCdXQgdGhpcyBjaGVjayBpcyByYWN5IGFzIHRo
ZSBQQ0llIExpbmsgY2FuIGdvCj4gPiA+IGRvd24ganVzdCBhZnRlciB0aGlzIGNoZWNrLgo+ID4g
PiAKPiA+ID4gU28gdXNlIHRoZSBuZXdseSBpbnRyb2R1Y2VkIEFQSSwgcGNpX3Jvb3RfcG9ydHNf
aGF2ZV9kZXZpY2UoKSB0aGF0IGNoZWNrcwo+ID4gPiBmb3IgdGhlIHByZXNlbmNlIG9mIGEgZGV2
aWNlIHVuZGVyIGFueSBvZiB0aGUgUm9vdCBQb3J0cyB0byByZXBsYWNlIHRoZQo+ID4gPiBMaW5r
IHVwIGNoZWNrLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNp
dmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1Ab3NzLnF1YWxjb21tLmNvbT4KPiA+ID4gLS0tCj4g
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXFjb20uYyB8IDYgKysrKy0tCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4g
PiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNv
bS5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1xY29tLmMKPiA+ID4gaW5kZXgg
ODA1ZWRiYmZlN2ViLi5iMmI4OWUyZTQ5MTYgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtcWNvbS5jCj4gPiA+IEBAIC0yMDE4LDYgKzIwMTgsNyBAQCBzdGF0aWMg
aW50IHFjb21fcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gPiAg
c3RhdGljIGludCBxY29tX3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4g
PiA+ICB7Cj4gPiA+ICAJc3RydWN0IHFjb21fcGNpZSAqcGNpZTsKPiA+ID4gKwlzdHJ1Y3QgZHdf
cGNpZV9ycCAqcHA7Cj4gPiA+ICAJaW50IHJldCA9IDA7Cj4gPiA+ICAKPiA+ID4gIAlwY2llID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7Cj4gPiA+IEBAIC0yMDUzLDggKzIwNTQsOSBAQCBzdGF0aWMg
aW50IHFjb21fcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikKPiA+ID4gIAkg
KiBwb3dlcmRvd24gc3RhdGUuIFRoaXMgd2lsbCBhZmZlY3QgdGhlIGxpZmV0aW1lIG9mIHRoZSBz
dG9yYWdlIGRldmljZXMKPiA+ID4gIAkgKiBsaWtlIE5WTWUuCj4gPiA+ICAJICovCj4gPiA+IC0J
aWYgKCFkd19wY2llX2xpbmtfdXAocGNpZS0+cGNpKSkgewo+ID4gPiAtCQlxY29tX3BjaWVfaG9z
dF9kZWluaXQoJnBjaWUtPnBjaS0+cHApOwo+ID4gPiArCXBwID0gJnBjaWUtPnBjaS0+cHA7Cj4g
PiA+ICsJaWYgKCFwY2lfcm9vdF9wb3J0c19oYXZlX2RldmljZShwcC0+YnJpZGdlLT5idXMpKSB7
Cj4gPiAKPiA+IEknbSBhIGxpdHRsZSBjb25mdXNlZC4KPiA+IFRoZSBwY2lfcm9vdF9wb3J0c19o
YXZlX2RldmljZSBmdW5jdGlvbiBjYW4gaGVscCBjaGVjayBpZiB0aGVyZSBpcyBhbnkgZGV2aWNl
IAo+ID4gYXZhaWxhYmxlIHVuZGVyIHRoZSBSb290IFBvcnRzLCBpZiB0aGVyZSBpcyBhIGRldmlj
ZSBhdmFpbGFibGUsIHRoZSByZXNvdXJjZSAKPiA+IGNhbm5vdCBiZSByZWxlYXNlZCwgaXMgaXQg
YWxzbyBuZWNlc3NhcnkgdG8gcmVsZWFzZSByZXNvdXJjZXMgd2hlbiBlbnRlcmluZyAKPiA+IHRo
ZSBMMi9MMyBzdGF0ZT8KPiA+IAo+IAo+IEl0IGlzIHVwdG8gdGhlIGNvbnRyb2xsZXIgZHJpdmVy
IHRvIGRlY2lkZS4gT25jZSB0aGUgbGluayBlbnRlcnMgTDIvTDMsIHRoZQo+IGRldmljZSB3aWxs
IGJlIGluIEQzQ29sZCBzdGF0ZS4gU28gdGhlIGNvbnRyb2xsZXIgY2FuIGp1c3QgZGlzYWJsZSBh
bGwgUENJZQo+IHJlc291cmNlcyB0byBzYXZlIHBvd2VyLgo+IAo+IEJ1dCBpdCBpcyBub3QgcG9z
c2libGUgdG8gdHJhbnNpdGlvbiBhbGwgUENJZSBkZXZpY2VzIHRvIEQzQ29sZCBkdXJpbmcgc3Vz
cGVuZCwKPiBmb3IgaW5zdGFuY2UgTlZNZS4gSSdtIGhvcGluZyB0byBmaXggaXQgdG9vIGluIHRo
ZSBjb21pbmcgZGF5cy4KPiAKSGksIE1hbml2YW5uYW4KClRoYW5rIHlvdSBmb3IgeW91ciBleHBs
YW5hdGlvbi4KCkJ5IHRoZSB3YXksIGluIHY1IHBhdGNoLCBJIHJlbW92ZWQgdGhlIGR3X3BjaWVf
bGlua191cCBqdWRnbWVudCwgYW5kIGN1cnJlbnRseQpyZXNvdXJjZXMgYXJlIGRpcmVjdGx5IHJl
bGVhc2VkLgpBdCBwcmVzZW50LCBpIGhhdmUgY29tcGxldGVkIHRoZSBwY2llIHY1IHBhdGNoIHdp
dGhvdXQgYWRkaW5nIHRoZSAKcGNpX3Jvb3RfcG9ydHNfaGF2ZV9kZXZpY2UgZnVuY3Rpb24uIERv
IEkgbmVlZCB0byB3YWl0IGZvciB5b3UgdG8gbWVyZ2UgaXQgCmJlZm9yZSBzZW5kaW5nIHRoZSBW
NSBwYXRjaD8KCktpbmQgcmVnYXJkcywKU2VuY2h1YW4gWmhhbmc=

