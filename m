Return-Path: <linux-pci+bounces-27932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EFBABB9D0
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C471B66383
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0952749C5;
	Mon, 19 May 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IvLgBCEl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49D274648
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647004; cv=none; b=qnE2nCmwi+VO68P+VQ2tR0L0tOpo74X0WdupUUuGTrSQ4CVqeyb3cZV8VKZMw7vXypnYIG9wp2bhtLhgJ8AtFAAskxxng+WkUeqjqldhW19Yx7Kf92MqeEwW2sbduyp4gT4w5TkRBzUqs2XUzfRy7sUxDKSqwPqpjnH+vMae9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647004; c=relaxed/simple;
	bh=pLpdyLnnLg8RqNMVrQvGnrEx5EzmgLtIkoNdov0Ray0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=EvSmTbNTAGsOryb2MEai+wCYTLq/ABBL0FYSErwADNu6ppFF2erhk8WVy7eeCoIdNLatqo3m6jdoTCVlszSlvTXfRSssyZEOf7FCmQrJS5LftH1zPNL6JS1y7BdV5AySlM+TStuhMAuqfuTMVSaVVt+kQqwLr7CEBH+qbYXyRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IvLgBCEl; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250519093001epoutp04cbe06a76e110f291d7ce435e1fb1f385~A47Ai6nJt1669016690epoutp04R
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:30:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250519093001epoutp04cbe06a76e110f291d7ce435e1fb1f385~A47Ai6nJt1669016690epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747647001;
	bh=HuTIFNEhjuQ85+QQGzAj+OEG2nYx+LsLsWxFAqZ7y7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IvLgBCEl5pTCow6NOOqjyk6Gmz8F/b/2sdeNFArtgBhv15nlINVfFavUliJs/EWOT
	 fZuunkwRM5gX0G972BkdGNIL8myI5mWSisEf+ES0Ov/9zf99PI4qV9bfTSp6OPUDCV
	 4Oe3mNf/5ogWJF0M0tugqgwH9fc64pfQ/sLffbpI=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250519093000epcas5p3c547f22a4a3250d09ced6e4c9d37dbc1~A46--ak0E1502815028epcas5p3U;
	Mon, 19 May 2025 09:30:00 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.182]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b1C863Wsfz6B9m4; Mon, 19 May
	2025 09:29:58 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250518193252epcas5p3e4d1d329f1e5616e842801ceb26728b6~AtgF5nFzO0813608136epcas5p3D;
	Sun, 18 May 2025 19:32:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250518193252epsmtrp2afa5e6b63a5605d32da707ac5717baef~AtgF4rZI70226302263epsmtrp2b;
	Sun, 18 May 2025 19:32:52 +0000 (GMT)
X-AuditID: b6c32a2a-d63ff70000002265-dc-682a35e4c1eb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.6B.08805.4E53A286; Mon, 19 May 2025 04:32:52 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250518193249epsmtip1c2eae81d2f215bb8b46b8b517bb25941~AtgCoIpr01176111761epsmtip1I;
	Sun, 18 May 2025 19:32:49 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH 07/10] dt-bindings: phy: Add PHY bindings support for FSD
 SoC
Date: Mon, 19 May 2025 01:01:49 +0530
Message-ID: <20250518193152.63476-8-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518193152.63476-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnO4TU60Mg2lXuCwezNvGZvF30jF2
	iyVNGRZr9p5jsph/5ByrxY1fbawWK77MZLc42vqf2eLlrHtsFg09v1ktNj2+xmpxedccNouz
	846zWUxY9Y3F4uz3BUwWLX9aWCzWHrnLbnG3pZPV4v+eHewWvYdrLXbeOcHsIOrx+9ckRo+d
	s+6yeyzYVOqxaVUnm8eda3vYPJ5cmc7ksXlJvUffllWMHke+Tmfx+LxJLoArissmJTUnsyy1
	SN8ugSuj/fV0poId7BXfj09ibWDsYuti5OSQEDCR6Pr7nbGLkYtDSGA3o8T+SbdZIRKSEp8v
	rmOCsIUlVv57zg5iCwl8YpTYfj4ZxGYT0JJo/NrFDGKLCJxglOi7ZQkyiFngPZPEzAW/wJqF
	BXwlrrzbAGazCKhK7HnbztLFyMHBK2Al8aG7GsSUEJCX6O+QAKngFLCW2LZ+KhPEKiuJhU92
	MoLYvAKCEidnPmEBsZmBypu3zmaewCgwC0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnF
	pXnpesn5uZsYwZGopbWDcc+qD3qHGJk4GA8xSnAwK4nwrtqskSHEm5JYWZValB9fVJqTWnyI
	UZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QDE6vGcv9Wqw0nbHbsjLePvrcp82FWTYj6
	lfmS91a0FCTJ3nwg9He/FOPnptxOl6s2vqKXn3AEb+486bBm5blFahdkVMrTZq66HKf6Yek1
	7d3nPQTO5nhP31r+85N94frIorMfrx+LiTnokOBsfV/npvtOj86mfWzLF2ZNuHD5VkrF0+9l
	/Knf257XvxfmuzKFgbGq9F/B3wf+52927NHdUPGjfa2j1alzPjzpCgcd8vsNtonmXDjq8PhN
	o8GvC68OR0xdd1508qfU7siH1+98POt2mzNr7onpZoJmErsUBX8VlVeeDP/xpDhL3CH6MR+j
	WdVLQZOJG/20b5zdk77utOeR0lgjs3uW+vFR3zjd2pVYijMSDbWYi4oTAV1WeJEzAwAA
X-CMS-MailID: 20250518193252epcas5p3e4d1d329f1e5616e842801ceb26728b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193252epcas5p3e4d1d329f1e5616e842801ceb26728b6
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193252epcas5p3e4d1d329f1e5616e842801ceb26728b6@epcas5p3.samsung.com>

Document PHY device tree bindings for Tesla FSD SoCs.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 .../devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
index 41df8bb08ff7..3a5bff0fb82d 100644
--- a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
@@ -15,10 +15,14 @@ properties:
     const: 0
 
   compatible:
-    const: samsung,exynos5433-pcie-phy
+    oneOf:
+      - enum:
+          - samsung,exynos5433-pcie-phy
+          - tesla,fsd-pcie-phy
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   samsung,pmu-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.49.0


