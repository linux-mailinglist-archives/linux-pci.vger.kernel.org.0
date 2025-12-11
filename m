Return-Path: <linux-pci+bounces-42945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7D4CB5C34
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA66C3008EA0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1230C342;
	Thu, 11 Dec 2025 12:05:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DF5298CC4;
	Thu, 11 Dec 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765454748; cv=none; b=vGXa7GMADpb/M5Z6X9BN46GS0dd+d6jD2AqZdrPgjRiCDsEImbqndQOlfvaTa0t8WKNEJ5+0KlUST2oEQeWIUilDORWXIQZr4zL2QK5M9vwR4VmAAG2eZfKtEqsGwcQw6uoWgLLLAC+ZrbIRyV/v1MMcK4uBWJZZ0PiPx5mK3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765454748; c=relaxed/simple;
	bh=VCirnhUPPMmS1WMzIoagoCnV/IRHr8M0spM8q8nwpQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=tJ7/4qfDttPzEJN+3BYdA4MwXIPXfFT9YqHqkUGOKEJ6zZyhoqMO9OvhfREgEmhAtt/noDb6u8quM1z+MyVmBDknG+PrVPT6nqtkW/FdM2EKXE1EOM/e0CEunJ5Z6y+SM6pq9O1NEUy432iY9AcdUccz+SwqFwyGMeNj7QLfQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 11 Dec 2025 20:05:19 +0800 (GMT+08:00)
Date: Thu, 11 Dec 2025 20:05:19 +0800 (GMT+08:00)
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
Subject: Re: Re: [PATCH v7 2/3] PCI: eic7700: Add Eswin PCIe host controller
 driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20251210164327.GA3477281@bhelgaas>
References: <20251210164327.GA3477281@bhelgaas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <68c6494b.1244.19b0d4d2b8c.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgDnK69_szpp+RKEAA--.4044W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAgENBmk5o
	PodHgABsA
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQmpvcm4gSGVsZ2FhcyIg
PGhlbGdhYXNAa2VybmVsLm9yZz4KPiBTZW5kIHRpbWU6VGh1cnNkYXksIDExLzEyLzIwMjUgMDA6
NDM6MjcKPiBUbzogemhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20KPiBDYzogYmhlbGdh
YXNAZ29vZ2xlLmNvbSwgbWFuaUBrZXJuZWwub3JnLCBrcnprK2R0QGtlcm5lbC5vcmcsIGNvbm9y
K2R0QGtlcm5lbC5vcmcsIGxwaWVyYWxpc2lAa2VybmVsLm9yZywga3dpbGN6eW5za2lAa2VybmVs
Lm9yZywgcm9iaEBrZXJuZWwub3JnLCBwLnphYmVsQHBlbmd1dHJvbml4LmRlLCBqaW5nb29oYW4x
QGdtYWlsLmNvbSwgZ3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20sIGxpbnV4LXBjaUB2Z2Vy
Lmtlcm5lbC5vcmcsIGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnLCBjaHJpc3RpYW4uYnJ1ZWxAZm9zcy5zdC5jb20sIG1heWFuay5yYW5hQG9z
cy5xdWFsY29tbS5jb20sIHNocmFkaGEudEBzYW1zdW5nLmNvbSwga3Jpc2huYS5jaHVuZHJ1QG9z
cy5xdWFsY29tbS5jb20sIHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20sIGlub2NoaWFtYUBn
bWFpbC5jb20sIEZyYW5rLmxpQG54cC5jb20sIG5pbmd5dUBlc3dpbmNvbXB1dGluZy5jb20sIGxp
bm1pbkBlc3dpbmNvbXB1dGluZy5jb20sIHBpbmtlc2gudmFnaGVsYUBlaW5mb2NoaXBzLmNvbSwg
b3V5YW5naHVpQGVzd2luY29tcHV0aW5nLmNvbQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi8z
XSBQQ0k6IGVpYzc3MDA6IEFkZCBFc3dpbiBQQ0llIGhvc3QgY29udHJvbGxlciBkcml2ZXIKPiAK
PiBPbiBUdWUsIERlYyAwMiwgMjAyNSBhdCAwNTowNDowNlBNICswODAwLCB6aGFuZ3NlbmNodWFu
QGVzd2luY29tcHV0aW5nLmNvbSB3cm90ZToKPiA+IEZyb206IFNlbmNodWFuIFpoYW5nIDx6aGFu
Z3NlbmNodWFuQGVzd2luY29tcHV0aW5nLmNvbT4KPiA+IAo+ID4gQWRkIGRyaXZlciBmb3IgdGhl
IEVzd2luIEVJQzc3MDAgUENJZSBob3N0IGNvbnRyb2xsZXIsIHdoaWNoIGlzIGJhc2VkIG9uCj4g
PiB0aGUgRGVzaWduV2FyZSBQQ0llIGNvcmUsIElQIHJldmlzaW9uIDUuOTZhLiBUaGUgUENJZSBH
ZW4uMyBjb250cm9sbGVyCj4gPiBzdXBwb3J0cyBhIGRhdGEgcmF0ZSBvZiA4IEdUL3MgYW5kIDQg
Y2hhbm5lbHMsIHN1cHBvcnQgSU5UeCBhbmQgTVNJCj4gPiBpbnRlcnJ1cHRzLgo+IAo+ID4gK3N0
YXRpYyBpbnQgZWljNzcwMF9wY2llX2hvc3RfaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApCj4g
PiAuLi4KPiA+ICsJLyoKPiA+ICsJICogVGhlIFBXUiBhbmQgREJJIFJlc2V0IHNpZ25hbHMgYXJl
IHJlc3BlY3RpdmVseSB1c2VkIHRvIHJlc2V0IHRoZQo+ID4gKwkgKiBQQ0llIGNvbnRyb2xsZXIg
YW5kIHRoZSBEQkkgcmVnaXN0ZXJzLgo+ID4gKwkgKiBUaGUgUEVSU1QjIHNpZ25hbCBpcyBhIHJl
c2V0IHNpZ25hbCB0aGF0IHNpbXVsdGFuZW91c2x5IGNvbnRyb2xzIHRoZQo+ID4gKwkgKiBQQ0ll
IGNvbnRyb2xsZXIsIFBIWSwgYW5kIEVuZHBvaW50Lgo+ID4gKwkgKiBCZWZvcmUgY29uZmlndXJp
bmcgdGhlIFBIWSwgdGhlIFBFUlNUIyBzaWduYWwgbXVzdCBmaXJzdCBiZQo+ID4gKwkgKiBkZWFz
c2VydGVkLgo+ID4gKwkgKiBUaGUgZXh0ZXJuYWwgcmVmZXJlbmNlIGNsb2NrIGlzIHN1cHBsaWVk
IHNpbXVsdGFuZW91c2x5IHRvIHRoZSBQSFkKPiA+ICsJICogYW5kIEVQLiBXaGVuIHRoZSBQSFkg
aXMgY29uZmlndXJhYmxlLCB0aGUgZW50aXJlIGNoaXAgYWxyZWFkeSBoYXMKPiA+ICsJICogc3Rh
YmxlIHBvd2VyIGFuZCByZWZlcmVuY2UgY2xvY2suCj4gPiArCSAqIFRoZSBQSFkgd2lsbCBiZSBy
ZWFkeSB3aXRoaW4gMjBtcyBhZnRlciB3cml0aW5nIGFwcF9ob2xkX3BoeV9yc3QKPiA+ICsJICog
cmVnaXN0ZXIgb2YgRUxCSSByZWdpc3RlciBzcGFjZS4KPiAKPiBBZGQgYmxhbmsgbGluZXMgYmV0
d2VlbiBwYXJhZ3JhcGhzLgo+IAo+ID4gK3N0YXRpYyBpbnQgZWljNzcwMF9wY2llX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiAuLi4KPiA+ICsJcGNpLT5ub19wbWVfaGFu
ZHNoYWtlID0gcGNpZS0+ZGF0YS0+bm9fcG1lX2hhbmRzaGFrZTsKPiAKPiBUaGlzIG5lZWRzIHRv
IGdvIGluIHRoZSAzLzMgIlBDSTogZHdjOiBBZGQgbm9fcG1lX2hhbmRzaGFrZSBmbGFnIGFuZAo+
IHNraXAgUE1FX1R1cm5fT2ZmIGJyb2FkY2FzdCIgcGF0Y2ggYmVjYXVzZSAibm9fcG1lX2hhbmRz
aGFrZSIgZG9lc24ndAo+IGV4aXN0IHlldCBzbyB0aGlzIHBhdGNoIGRvZXNuJ3QgYnVpbGQgYnkg
aXRzZWxmLgoKSGksIEJqb3JuCgpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4KRG8gSSBuZWVkIHRv
IGFkanVzdCB0aGUgb3JkZXIgb2YgdGhlIHBhdGNoZXM/CjMvMiAiUENJOiBkd2M6IEFkZCBub19w
bWVfaGFuZHNoYWtlIGZsYWcgYW5kIHNraXAgUE1FX1R1cm5fT2ZmIGJyb2FkY2FzdCIKMy8zICJQ
Q0k6IGVpYzc3MDA6IEFkZCBFc3dpbiBQQ0llIGhvc3QgY29udHJvbGxlciBkcml2ZXIiCgpPciBt
ZXJnZSBQYXRjaCAyLzMgYW5kIFBhdGNoIDMvMz8KCktpbmQgcmVnYXJkcywKU2VuY2h1YW4gWmhh
bmcKPiAKPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgZWljNzcwMF9wY2llX3Bt
X29wcyA9IHsKPiA+ICsJTk9JUlFfU1lTVEVNX1NMRUVQX1BNX09QUyhlaWM3NzAwX3BjaWVfc3Vz
cGVuZF9ub2lycSwKPiA+ICsJCQkJICBlaWM3NzAwX3BjaWVfcmVzdW1lX25vaXJxKQo+ID4gK307
Cj4gCj4gVXNlIERFRklORV9OT0lSUV9ERVZfUE1fT1BTKCkgaW5zdGVhZC4gIFRoZSBjb2xsZWN0
aW9uIG9mIFBNLXJlbGF0ZWQKPiBtYWNyb3MgaXMgY29uZnVzaW5nIHRvIHNheSB0aGUgbGVhc3Qs
IGFuZCB0aGV5J3JlIG5vdCB1c2VkCj4gY29uc2lzdGVudGx5IGFjcm9zcyB0aGUgUENJZSBkcml2
ZXJzLCBidXQgSSAqdGhpbmsqIHRoZSBydWxlIG9mIHRodW1iCj4gc2hvdWxkIGJlOgo+IAo+ICAg
UHJlZmVyIERFRklORV9OT0lSUV9ERVZfUE1fT1BTKCkgb3ZlciBOT0lSUV9TWVNURU1fU0xFRVBf
UE1fT1BTKCkKPiAgIHdoZW4gcG9zc2libGUgYW5kIG9taXQgcG1fc2xlZXBfcHRyKCkgYW5kIHBt
X3B0cigpLgoKT2tleSwgdGhhbmtzLgpJIHdpbGwgdXNlIHRoZSBmb2xsb3dpbmcgY29tYmluYXRp
b27vvJoKREVGSU5FX05PSVJRX0RFVl9QTV9PUFMoZWljNzcwMF9wY2llX3BtLCBlaWM3NzAwX3Bj
aWVfc3VzcGVuZF9ub2lycSwKICAgICAgICAgICAgICAgICAgICAgICAgZWljNzcwMF9wY2llX3Jl
c3VtZV9ub2lycSk7Ci5wbSA9ICZlaWM3NzAwX3BjaWVfcG0s

