Return-Path: <linux-pci+bounces-43038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D30EDCBD51A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 11:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAC3A300AFCC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB932B9B9;
	Mon, 15 Dec 2025 10:11:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2BE32AADA;
	Mon, 15 Dec 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793492; cv=none; b=icVnY7R+4eRMWAsX9THwwRAps8R8yTte0COG+m4tnYSym0zpzd5bA53QNnN9Xk9dL1kQ4JEtqNFx5bTCzlXVJcj2q1sqZREOU6FFMoms8G4Qc5xtHOxf3WYKoqYF9bVaCB9ihXnqah23axX2CwS6eAp0M68sFTqJzY8c0536Vsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793492; c=relaxed/simple;
	bh=gQAa3FnEUqhpIXfwSUW+KeoA1lZnkjES0QvQaFyuf+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=T0s5KV1DH2iJlK0w0DtyFJSi8s1aoeBv03XzQTPL/BTaZwWc38TjoizZFqaGm2MV9aiBTsin1QmVpcd2REw4eSPZZbh9XNPLpJ9NMXU5gRitmk4+NKPtWYf1x99a1bVtvouXsZhqTFI/lzn2S1tc/UOf1P3tlZ8jRzhxUtf5emk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 15 Dec 2025 18:11:07 +0800 (GMT+08:00)
Date: Mon, 15 Dec 2025 18:11:07 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>
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
Subject: Re: Re: Re: [PATCH v7 2/3] PCI: eic7700: Add Eswin PCIe host
 controller driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20251211160752.GA3594705@bhelgaas>
References: <20251211160752.GA3594705@bhelgaas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <58ea0c1e.13e2.19b217e0b5b.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgDnK6+73j9pzJSFAA--.4284W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAQERBmk+5
	oYl1gACsR
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAyLzNdIFBDSTogZWljNzcwMDogQWRkIEVzd2lu
IFBDSWUgaG9zdCBjb250cm9sbGVyIGRyaXZlcgo+IAo+IFBsZWFzZSBhdm9pZCB0aGUgcG9pbnRs
ZXNzIHF1b3RlIG9mIGFsbCB0aGUgaGVhZGVycyAoYWJvdmUpIGlmIHlvdQo+IGNhbi4gIFRoYXQg
anVzdCBjbHV0dGVycyB0aGUgdGhyZWFkLiAgQWxzbyB0cmltIGNvbnRleHQgdGhhdCBpcyBub3QK
PiByZWxldmFudC4gIE1vcmUgaGludHMgaGVyZTogaHR0cHM6Ly9zdWJzcGFjZS5rZXJuZWwub3Jn
L2V0aXF1ZXR0ZS5odG1sCgpPa2V5LCB0aGFua3MuCgo+IAo+ID4gPiBPbiBUdWUsIERlYyAwMiwg
MjAyNSBhdCAwNTowNDowNlBNICswODAwLCB6aGFuZ3NlbmNodWFuQGVzd2luY29tcHV0aW5nLmNv
bSB3cm90ZToKPiA+ID4gPiBGcm9tOiBTZW5jaHVhbiBaaGFuZyA8emhhbmdzZW5jaHVhbkBlc3dp
bmNvbXB1dGluZy5jb20+Cj4gPiA+ID4gCj4gPiA+ID4gQWRkIGRyaXZlciBmb3IgdGhlIEVzd2lu
IEVJQzc3MDAgUENJZSBob3N0IGNvbnRyb2xsZXIsIHdoaWNoIGlzIGJhc2VkIG9uCj4gPiA+ID4g
dGhlIERlc2lnbldhcmUgUENJZSBjb3JlLCBJUCByZXZpc2lvbiA1Ljk2YS4gVGhlIFBDSWUgR2Vu
LjMgY29udHJvbGxlcgo+ID4gPiA+IHN1cHBvcnRzIGEgZGF0YSByYXRlIG9mIDggR1QvcyBhbmQg
NCBjaGFubmVscywgc3VwcG9ydCBJTlR4IGFuZCBNU0kKPiA+ID4gPiBpbnRlcnJ1cHRzLgo+IAo+
ID4gPiA+ICtzdGF0aWMgaW50IGVpYzc3MDBfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQo+ID4gPiA+IC4uLgo+ID4gPiA+ICsJcGNpLT5ub19wbWVfaGFuZHNoYWtlID0g
cGNpZS0+ZGF0YS0+bm9fcG1lX2hhbmRzaGFrZTsKPiA+ID4gCj4gPiA+IFRoaXMgbmVlZHMgdG8g
Z28gaW4gdGhlIDMvMyAiUENJOiBkd2M6IEFkZCBub19wbWVfaGFuZHNoYWtlIGZsYWcgYW5kCj4g
PiA+IHNraXAgUE1FX1R1cm5fT2ZmIGJyb2FkY2FzdCIgcGF0Y2ggYmVjYXVzZSAibm9fcG1lX2hh
bmRzaGFrZSIgZG9lc24ndAo+ID4gPiBleGlzdCB5ZXQgc28gdGhpcyBwYXRjaCBkb2Vzbid0IGJ1
aWxkIGJ5IGl0c2VsZi4KPiA+IAo+ID4gRG8gSSBuZWVkIHRvIGFkanVzdCB0aGUgb3JkZXIgb2Yg
dGhlIHBhdGNoZXM/Cj4gPiAzLzIgIlBDSTogZHdjOiBBZGQgbm9fcG1lX2hhbmRzaGFrZSBmbGFn
IGFuZCBza2lwIFBNRV9UdXJuX09mZiBicm9hZGNhc3QiCj4gPiAzLzMgIlBDSTogZWljNzcwMDog
QWRkIEVzd2luIFBDSWUgaG9zdCBjb250cm9sbGVyIGRyaXZlciIKPiA+IAo+ID4gT3IgbWVyZ2Ug
UGF0Y2ggMi8zIGFuZCBQYXRjaCAzLzM/Cj4gCj4gSSB0aGluayB0aGUgYmVzdCB0aGluZyB3b3Vs
ZCBiZSB0byBsZWF2ZSBkd19wY2llX3N1c3BlbmRfbm9pcnEoKSBhbG9uZwo+IGFuZCBpbXBsZW1l
bnQgZWljNzcwMF9wY2llX3N1c3BlbmRfbm9pcnEoKSB3aXRob3V0IGNhbGxpbmcgaXQuCj4gCj4g
ZHdfcGNpZV9zdXNwZW5kX25vaXJxKCkgaXMgYWxyZWFkeSBwcm9ibGVtYXRpYyBbMV0sIGFuZCB3
ZSBkb24ndCBuZWVkCj4gbW9yZSBjb21wbGljYXRpb24gdGhlcmUuICBFdmVuIHdpdGhvdXQgY2Fs
bGluZwo+IGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpLCB5b3VyIGVpYzc3MDBfcGNpZV9zdXNwZW5k
X25vaXJxKCkgd2lsbCBiZQo+IHByZXR0eSBzaW1wbGUuICBKdXN0IGFkZCBhIGNvbW1lbnQgYWJv
dXQgd2h5IHlvdSBkb24ndCB1c2UKPiBkd19wY2llX3N1c3BlbmRfbm9pcnEoKS4KPiAKPiBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMjUxMTE0MjEzNTQwLkdBMjMzNTg0
NUBiaGVsZ2Fhcy8KClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIGhhdmUgc2VudCB0aGUg
VjggcGF0Y2gsIGFuZCByZW1vdmUKZHdfcGNpZV9zdXNwZW5kX25vaXJxL2R3X3BjaWVfcmVzdW1l
X25vaXJxIGluIHRoZSBkcml2ZXIgZmlsZS4KCktpbmQgcmVnYXJkcywKU2VuY2h1YW4gWmhhbmcK
Cg==

