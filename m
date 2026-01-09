Return-Path: <linux-pci+bounces-44356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01ED08DD7
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 12:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC95D301B30B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8E33CE91;
	Fri,  9 Jan 2026 11:22:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7433C53A;
	Fri,  9 Jan 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957746; cv=none; b=l5+kh/zxu2bvFrfGpZ2a+iCPZYnRT9RXgx6ddmrIGldBJwRqaT6W31ZqcmOXpYLJpajPVBnPOaaqENx6D747/WEqSuZy/DhamP9pXTagKAq8TF4TVNMY43/FmOpjULpp07lPMJeyHw7JWwE1+5yRgYlV+sBGQi3SRpNB1QtVsPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957746; c=relaxed/simple;
	bh=jIs/n+q2hzat89JPtfaBAB/r9j8g4oYU5XEHdUUpqDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=YqXW19oXzh0eP1WOYmLjHc6YQAss8M0ZbOc//+rRxF1Y4Sz+sV/dl5olQP7zkA/9urpHqWetsMNvc4J1AVVESt0N5pbRVCjIAmD7kaA4M2XG04d4MCyLUzT8lcbAeOZN1mCH6zLn8tXXY2JEegwsfLhnlAgzt7CZ6vVDkXzZTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 9 Jan 2026 19:22:02 +0800 (GMT+08:00)
Date: Fri, 9 Jan 2026 19:22:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Manivannan Sadhasivam" <mani@kernel.org>, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christian.bruel@foss.st.com,
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com, "Niklas Cassel" <cassel@kernel.org>
Subject: Re: Re: [PATCH v9 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260106174348.GA365798@bhelgaas>
References: <20260106174348.GA365798@bhelgaas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6607c5b8.21d6.19ba27df74f.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgDnK6_a5GBpM4KSAA--.6506W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAQECBmlf3
	AofuAAAsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+IE9uIFR1ZSwgSmFuIDA2LCAyMDI2IGF0IDA4OjQzOjExUE0gKzA4MDAsIHpoYW5nc2VuY2h1
YW4gd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCBEZWMgMjksIDIwMjUgYXQgMDc6MzI6MDdQTSArMDgw
MCwgemhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20gd3JvdGU6Cj4gPiA+ID4gPiBGcm9t
OiBTZW5jaHVhbiBaaGFuZyA8emhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20+Cj4gPiA+
ID4gPiAKPiA+ID4gPiA+IEFkZCBkcml2ZXIgZm9yIHRoZSBFc3dpbiBFSUM3NzAwIFBDSWUgaG9z
dCBjb250cm9sbGVyLCB3aGljaCBpcyBiYXNlZCBvbgo+ID4gPiA+ID4gdGhlIERlc2lnbldhcmUg
UENJZSBjb3JlLCBJUCByZXZpc2lvbiA1Ljk2YS4gVGhlIFBDSWUgR2VuLjMgY29udHJvbGxlcgo+
ID4gPiA+ID4gc3VwcG9ydHMgYSBkYXRhIHJhdGUgb2YgOCBHVC9zIGFuZCA0IGNoYW5uZWxzLCBz
dXBwb3J0IElOVHggYW5kIE1TSQo+ID4gPiA+ID4gaW50ZXJydXB0cy4KPiA+ID4gPiAKPiA+ID4g
PiA+ICtjb25maWcgUENJRV9FSUM3NzAwCj4gPiA+ID4gPiArCXRyaXN0YXRlICJFc3dpbiBFSUM3
NzAwIFBDSWUgY29udHJvbGxlciIKPiA+ID4gPiAKPiA+ID4gPiA+ICsvKiBWZW5kb3IgYW5kIGRl
dmljZSBJRCB2YWx1ZSAqLwo+ID4gPiA+ID4gKyNkZWZpbmUgUENJX1ZFTkRPUl9JRF9FU1dJTgkJ
MHgxZmUxCj4gPiA+ID4gPiArI2RlZmluZSBQQ0lfREVWSUNFX0lEX0VTV0lOCQkweDIwMzAKPiA+
ID4gPiAKPiA+ID4gPiBVc3VhbGx5IHRoZSBkZXZpY2UgbmFtZSBpcyBhIGxpdHRsZSBtb3JlIHRo
YW4ganVzdCB0aGUgdmVuZG9yLiAgV2hhdAo+ID4gPiA+IGlmIEVzd2luIGV2ZXIgbWFrZXMgYSBz
ZWNvbmQgZGV2aWNlPwo+ID4gPiAKPiA+ID4gT2tleSwgdGhhbmtzLgo+ID4gPiBQZXJoYXBzIGl0
J3MgYSBwcm9ibGVtLiBNYXliZSBQQ0lfREVWSUNFX0lEX0VJQzc3MDAgaXMgYmV0dGVyPwo+IAo+
IENoZWNrIHBjaV9pZHMuaCBhbmQgZm9sbG93IHRoZSBzdHlsZSB1c2VkIHRoZXJlLiAgRGV2aWNl
IElEIG1hY3Jvcwo+IHR5cGljYWxseSBpbmNsdWRlIGJvdGggdGhlIHZlbmRvciBhbmQgdGhlIGRl
dmljZS4KCk9rZXksIHRoYW5rcy4KCj4gCj4gPiA+ID4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kcml2ZXIgZWljNzcwMF9wY2llX2RyaXZlciA9IHsKPiA+ID4gPiA+ICsJLnByb2JlID0gZWlj
NzcwMF9wY2llX3Byb2JlLAo+ID4gPiA+IAo+ID4gPiA+IFRoaXMgZHJpdmVyIGlzIHRyaXN0YXRl
IGJ1dCBoYXMgbm8gLnJlbW92ZSgpIGNhbGxiYWNrLiAgU2VlbXMgbGlrZSBpdAo+ID4gPiA+IHNo
b3VsZCBoYXZlIG9uZT8KPiA+ID4gCj4gPiA+IEluIHYyIHBhdGNoLCBJIHJlZmVycmVkIHRvIE1h
bmkncyBjb21tZW50cyBhbmQgcmVtb3ZlZCB0aGUgLnJlbW92ZSgpCj4gPiA+IGNhbGxiYWNrLCBh
cyBmb2xsb3dzOgo+ID4gPiAiU2luY2UgdGhpcyBjb250cm9sbGVyIGltcGxlbWVudHMgaXJxY2hp
cCB1c2luZyB0aGUgRFdDIGNvcmUgZHJpdmVyLAo+ID4gPiBpdCBpcyBub3Qgc2FmZSB0byByZW1v
dmUgaXQgZHVyaW5nIHJ1bnRpbWUuIgo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1wY2kvamdob3p1cmpxeWhtdHVuaXZvdGl0Z3M2N2g2eG80c2I0NnFjeWNuYmJ3eXZqY200ZWtA
dmdxNzVvbGF6bW9pLwo+ID4gPiAKPiA+ID4gSW4gYWRkaXRpb24sIHJlbW92ZSAucmVtb3ZlKCkg
Y2FsbGJhY2ssIGJlY2F1c2UgdGhpcyBkcml2ZXIgaGFzIGJlZW4gCj4gPiA+IG1vZGlmaWVkIHRv
IGJ1aWx0aW5fcGxhdGZvcm1fZHJpdmVyIGFuZCBkb2VzIG5vdCBzdXBwb3J0IEhvdFBsdWcsIAo+
ID4gPiB0aGVyZWZvcmUsIHRoZSAucmVtb3ZlKCkgY2FsbGJhY2sgaXMgbm90IG5lZWRlZC4gRG8g
eW91IGhhdmUgYW55Cj4gPiA+IGJldHRlciBzdWdnZXN0aW9ucz8KPiA+IAo+ID4gWWVzLCBidWls
dGluX3BsYXRmb3JtX2RyaXZlcigpIHdvdWxkbid0IGFsbG93IHRoZSB1c2VycyB0byByZW1vdmUK
PiA+IHRoZSBtb2R1bGUuIFNvIHJlbW92ZSgpIGNhbGxiYWNrIHdpbGwgYmVjb21lIHVzZWxlc3Mu
IFRoZSByZWFzb24gd2h5Cj4gPiB0aGlzIGRyaXZlciBpcyB0cmlzdGF0ZSBpcyB0aGF0IGl0IGNv
dWxkIGJlIGxvYWRlZCBmcm9tIHJvb3RmcyBhbmQKPiA+IG5vdCBhbHdheXMgc3RhdGljYWxseSBi
dWlsdCB0byB0aGUga2VybmVsIGltYWdlLgo+IAo+IFRoaXMgLnJlbW92ZSgpIHZzIElSUSB0aGlu
ZyBpcyBhIHBlcmVubmlhbCBpc3N1ZSBhbmQgaXQncyBoYXJkIHRvIGtub3cKPiB3aGF0IHN0eWxl
IG5ldyBkcml2ZXJzIHNob3VsZCBjb3B5Lgo+IAo+IFRoZXJlIGFyZSBsb3RzIG9mIERXQy1iYXNl
ZCBkcml2ZXJzIHRoYXQgYXJlIHRyaXN0YXRlLCBpbXBsZW1lbnQKPiAucmVtb3ZlKCksIGFuZCB1
c2UgbW9kdWxlX3BsYXRmb3JtX2RyaXZlcigpIChlLmcuLCBidDEsIGtpcmluLAo+IHRlZ3JhMTk0
LCByY2FyLWdlbjQsIGV4eW5vcywgazEsIHN0bTMyKS4gIElzIHRoZXJlIHNvbWV0aGluZyBkaWZm
ZXJlbnQKPiBhYm91dCB0aGUgd2F5IHRoZXkgaW1wbGVtZW50IGlycWNoaXAgdGhhdCBtYWtlcyAu
cmVtb3ZlKCkgc2FmZT8KCkhpIEJqb3JuLCBNYW5pLAoKVGhlIGNvbW1lbnRzIGFyZSBhcyBmb2xs
b3dzOgoiWW91IGNhbiBtYWtlIGl0IHRyaXN0YXRlIGFzIHlvdSd2ZSB1c2VkIGJ1aWx0aW5fcGxh
dGZvcm1fZHJpdmVyKCkgd2hpY2gKZ3VhcmFudGVlcyB0aGF0IHRoaXMgZHJpdmVyIHdvbid0IGJl
IHJlbW92ZWQgb25jZSBsb2FkZWQuIgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kv
dWlqZzQ3c3V2bHV2YW1mdHl4d2M2NWtsMzRlbzJldTJhZjJvNWFpYTRudTQ1aGFucWNAZ3JjcjJi
amdwaDJpLwoKRG8gbm90IGFkZCB0aGUgcmVtb3ZlIGNhbGxiYWNrLiBJdCBuZWVkcyB0byBiZSBz
ZXQgdG8gYSBib29s77yaCkluIHY2IHBhdGNoLCBpdCB3YXMgbWVudGlvbmVkIHRvIHNldCB0cmlz
dGF0ZS4gTm93LCBhZnRlciBjYXJlZnVsIApjb25zaWRlcmF0aW9uLCBzZXR0aW5nIHRyaXN0YXRl
IGNhbiBhbGxvdyBsb2FkaW5nIGFzIGEgbW9kdWxlLCBidXQgdGhlIApkcml2ZXIgaW1wbGVtZW50
YXRpb24gZG9lcyBub3QgaGF2ZSBhIHJlbW92ZSBmdW5jdGlvbi4gSWYgaXQgZXhpc3RzIGluIAp0
aGUgZm9ybSBvZiBhIG1vZHVsZSwgYWZ0ZXIgdGVzdGluZywgV2hlbiBpbnNtb2QgZHJpdmVyIGlz
IGZvbGxvd2VkIGJ5IApybW1vZCBkcml2ZXIsIHRoZSByZXNvdXJjZXMgY2Fubm90IGJlIHJlbGVh
c2VkLCBhbmQgcHJvYmxlbXMgd2lsbCBvY2N1cgp3aGVuIGluc21vZCBkcml2ZXIgaXMgdXNlZCBh
Z2Fpbi4gU28gSSB0aGluayB0aGF0IGlmIHRoZSByZW1vdmUgY2FsbGJhY2sKZnVuY3Rpb24gaXMg
bm90IHByb3ZpZGVkIGluIHRoZSBmb3JtIG9mIGJ1aWx0aW4sIGl0IGNhbiBvbmx5IGJlIHNldCB0
byAKYm9vbC4KCkFkZCB0aGUgcmVtb3ZlIGNhbGxiYWNrLiBJdCBjYW4gbWFrZSBpdCB0cmlzdGF0
ZToKUXVlc3Rpb25zIGFib3V0IHJlbW92aW5nIGl0IGR1cmluZyBydW50aW1lLiBJIGRvbid0IGhh
dmUgYSB2ZXJ5IGdvb2QgaWRlYS4KSSBzdGlsbCBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHdoeSBp
dCdzIG5vdCBzYWZlLiBDb3VsZCB5b3UgZXhwbGFpbiBpdCB0byAKbWU/CgpBdCBwcmVzZW50LCBy
ZWZlciB0byBvdGhlciBtYW51ZmFjdHVyZXJzLCBpIHRoaW5rIHRoZXJlIGFyZSB0d28gd2F5cyB0
byAKYWNoaWV2ZSBpdC4KMS5TZXQgYSBib29sLiBEbyBub3QgYWRkIHRoZSByZW1vdmUgZnVuY3Rp
b24sIG1vZHVsZSBsb2FkaW5nIGlzIG5vdCAKYWxsb3dlZCwgYW5kIHRoZSBkcml2ZXIgY3VycmVu
dGx5IGRvZXMgbm90IHN1cHBvcnQgSG90UGx1Zy4KMi5TZXQgYSB0cmlzdGF0ZSwgYWRkIC5yZW1v
dmUgY2FsbGJhY2suCgpJIHRoaW5rIHRoZSBmaXJzdCBvbmUgbWlnaHQgYmUgYmV0dGVyIGZvciBt
ZSwgYmVjYXVzZSB0aGVyZSBpcyBubyBuZWVkIAp0byBhZGQgdGhlIHJlbW92ZSBmdW5jdGlvbiwg
bXkgdW5kZXJzdGFuZGluZyBtaWdodCBhbHNvIGJlIGluY29ycmVjdC4gClBsZWFzZSByZXZpZXcg
aXQgZm9yIG1lLiBUaGFua3PvvIEKCktpbmQgcmVnYXJkcywKU2VuY2h1YW4KCgo=

