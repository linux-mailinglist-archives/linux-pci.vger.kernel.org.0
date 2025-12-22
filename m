Return-Path: <linux-pci+bounces-43503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D76CD4D7E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 08:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54AC33004F17
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D8227F005;
	Mon, 22 Dec 2025 07:09:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD181F3BA2;
	Mon, 22 Dec 2025 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387371; cv=none; b=X+Of4EzU6OW34PBHbsOBubyl9n/Who/f4M/HBWVj7VLbaaqiLfjHbdYbe6rOKWs09t7yZnsH1x658swn2DT4eQfXKdSuNCdJIwWOHKqg2EhUaKwWk4ah95KA1NvpX4Es3WB2slbAbhUmWHuD+HA9gj3gVQw7c6Fs8Srz9O1twlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387371; c=relaxed/simple;
	bh=uYieviZC3bt7SdDstleCuB527RQ4cgBArXpkx2U7IVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=hZRQT5odUrJCZYocPYAoKpDsRlrHZHyFias1yLNny2YruFKuQ6qF3ZJUTZGPXxou/rzVGw7M0fsVfa6eJAwPoabC9MhLVfB0cNl9kHFJB+/vy9HfKUqRvFJdhLcyOMtxqAmAwbIQdVQ8zNk8yxxxjmDx2QOmfoRhvKa7kqHMxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 22 Dec 2025 15:08:59 +0800 (GMT+08:00)
Date: Mon, 22 Dec 2025 15:08:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "ALOK TIWARI" <alok.a.tiwari@oracle.com>
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
Subject: Re: Re: [External] : [PATCH v8 2/2] PCI: eic7700: Add Eswin PCIe
 host controller driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <af02c6ff-3a9e-441c-9f99-0528492b56ff@oracle.com>
References: <20251215095928.1712-1-zhangsenchuan@eswincomputing.com>
 <20251215100200.1752-1-zhangsenchuan@eswincomputing.com>
 <af02c6ff-3a9e-441c-9f99-0528492b56ff@oracle.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2b041b80.1771.19b44e3d22e.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgBnq66L7khpb7GIAA--.4763W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAQEEBmlII
	QcibgAAsJ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Ck9uIDEyLzE1LzIwMjUgMzozMiBQTSwgemhhbmdzZW5jaHVhbkBlc3dpbmNvbXB1dGluZy5jb20g
d3JvdGU6Cj4gPiArCS8qCj4gPiArCSAqIFRPRE86IFNpbmNlIHRoZSBSb290IFBvcnQgbm9kZSBp
cyBzZXBhcmF0ZWQgb3V0IGJ5IHBjaWUgZGV2aWNldHJlZSwKPiA+ICsJICogdGhlIERXQyBjb3Jl
IGluaXRpYWxpemF0aW9uIGNvZGUgY2FuJ3QgcGFyc2UgdGhlIG51bS1sYW5lcyBhdHRyaWJ1dGUK
PiA+ICsJICogaW4gdGhlIFJvb3QgUG9ydC4gQmVmb3JlIGVudGVyaW5nIHRoZSBEV0MgY29yZSBp
bml0aWFsaXphdGlvbiBjb2RlLAo+ID4gKwkgKiB0aGUgcGxhdGZvcm0gZHJpdmVyIGNvZGUgcGFy
c2VzIHRoZSBSb290IFBvcnQgbm9kZS4gVGhlIEVJQzc3MDAgb25seQo+ID4gKwkgKiBzdXBwb3J0
cyBvbmUgUm9vdCBQb3J0IG5vZGUsIGFuZCB0aGUgbnVtLWxhbmVzIGF0dHJpYnV0ZSBpcyBzdWl0
YWJsZQo+ID4gKwkgKiBmb3IgdGhlIGNhc2Ugb2Ygb25lIFJvb3QgUm9ydC4KPiAKPiBSb3J0IC0+
IFBvcnQKCk9rZXksIHRoYW5rcy4KQWZ0ZXIgYmVpbmcgcmV2aWV3ZWQgYnkgb3RoZXIgbWFpbnRh
aW5lcnMsIEkgd2lsbCBmaXggaXQgaW4gdGhlIHY5IHBhdGNoLgoKS2luZCByZWdhcmRzLApTZW5j
aHVhbiBaaGFuZw==

