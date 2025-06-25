Return-Path: <linux-pci+bounces-30677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91FAE943C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 04:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D23B4520
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 02:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2A1F5413;
	Thu, 26 Jun 2025 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bYcxi80B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3692264C3
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905465; cv=none; b=t5CNcgVUDjpugwvsS0jWiXr8Cs2/2KrpaKgqrev1A1RBbSPvhWIF6sRV29Txe+CLzGFedhjpvqPEIDGbQFHc/MhR7GOi/+385yCABewcY930UHM+e9ugo2Xbbj+v2O6z3TAHWm0bWDvF9DonMTnAr+4Z6dsAfOnMwkGvboVTPo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905465; c=relaxed/simple;
	bh=LrU4wRIkHrX3QPVfUgQqz2szQ8/0JFdxMkj+VmYkUn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=j/Zm7xUDM6DnrKT+Tw4FKg2e2wjemvOq2tGi7NphBO3/6aKjT720zduDtEIJ1aPRGZoe0AzqwMTeZiTuvpFGYG9FYHJRFzeT9LBOOYbMyHJ79OdyPJzi8UjHlq67qVcnxR6na5FBYOwxq/RGmRrQ9GsNpWtFQVqyoTWzvHoUwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bYcxi80B; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250626023741epoutp02ff4044843b8a8ad0496deac8623d8ce1~Mdz2xQSko2347023470epoutp02x
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250626023741epoutp02ff4044843b8a8ad0496deac8623d8ce1~Mdz2xQSko2347023470epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750905462;
	bh=ujct3ldDGWWQEWKX47buqf1vYrAR4bu4IG0VwJz4Ea4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYcxi80BxCBz048ruk+HNpUOCbjxEHjY7a/OpEZO3LA2MXux52q+xXPWZZWNmP8hT
	 sPVuPdi3MDF4yRlfdOo3uEEYP9y2qHE+qo3J24s6TdTxVnLl0nKPRvK0s3QDYrYre1
	 pQleNyKzOuWC0WBlJQpLOPt6R9hW1QnYEqeES2HM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250626023741epcas5p496162c0bb4cf12950d4bace903c720f4~Mdz2BkYUA1443814438epcas5p4M;
	Thu, 26 Jun 2025 02:37:41 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.183]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bSNBq32X1z2SSKf; Thu, 26 Jun
	2025 02:37:39 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03~MV1oJTTWu0056800568epcas5p3W;
	Wed, 25 Jun 2025 16:53:19 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250625165316epsmtip2a6224bb8663ab3eedbccc0797d0ad7bf~MV1lZ_oLN1750817508epsmtip2W;
	Wed, 25 Jun 2025 16:53:16 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-fsd@tesla.com
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v2 07/10] dt-bindings: phy: Add PHY bindings support for FSD
 SoC
Date: Wed, 25 Jun 2025 22:22:26 +0530
Message-ID: <20250625165229.3458-8-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625165229.3458-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03
References: <20250625165229.3458-1-shradha.t@samsung.com>
	<CGME20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03@epcas5p3.samsung.com>

Document PHY device tree bindings for Tesla FSD SoCs.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 .../bindings/phy/samsung,exynos-pcie-phy.yaml | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
index 41df8bb08ff7..4dc20156cdde 100644
--- a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
@@ -15,10 +15,13 @@ properties:
     const: 0
 
   compatible:
-    const: samsung,exynos5433-pcie-phy
+    enum:
+      - samsung,exynos5433-pcie-phy
+      - tesla,fsd-pcie-phy
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   samsung,pmu-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -30,6 +33,24 @@ properties:
     description: phandle for FSYS sysreg interface, used to control
                  sysreg registers bits for PCIe PHY
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - tesla,fsd-pcie-phy
+    then:
+      description:
+        The PHY controller nodes are represented in the aliases node
+        using the following format 'pciephy{n}'. Depending on whether
+        n is 0 or 1, the phy init sequence is chosen.
+      properties:
+        reg:
+          items:
+            - description: PHY
+            - description: PCS
+
 required:
   - "#phy-cells"
   - compatible
-- 
2.49.0


