Return-Path: <linux-pci+bounces-33829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE33B21C9A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C62685117
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1BB2E5B21;
	Tue, 12 Aug 2025 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V3Dwu01p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293F2E5B03
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974951; cv=none; b=Nd12AefpGTf9TPJHDZG+JaBdzhjKdBBnlLcLTfGopQqwGlTeAB/z9s5+mmtGbz8xMus26P4l+VnMVas+TZBfgs2pvaOaKnBbSgpQdeHNJKB3a2MVqoqbFZlyTCxSmc4WLk7UXslhbE1ij5pctngwVcoN2eGNu9qb4KUeara+oyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974951; c=relaxed/simple;
	bh=TdVoEqWDIu5mCLUVekfqcS9wK66E/F9nnL/y51P3pEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Ujk1rs4CokIV0RTDWVgOOW77BseP2TTUF5X9C5VebD4j/au0X2A2G96Bl5fDK3WcIKCpnJCHaZcURU+TA8py4VxHNhao6j3UYE+C/K/rIEUFkd3MxNjvi6VOM2i2RjJSOqhjZTJvs5wztvJNJHvieWBRzufngEjVtVN5cO6vSsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V3Dwu01p; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250812050228epoutp03a9ce0ee24ff17ff45a24002a538cc881~a7GrAKzcZ0070500705epoutp03M
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250812050228epoutp03a9ce0ee24ff17ff45a24002a538cc881~a7GrAKzcZ0070500705epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974948;
	bh=EBzSCiCSIVFrfQVxZfEKGPmo5+c0wpF19H3LS0hAlsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3Dwu01p157JU9aDuPtciupnpj/piBbAP4NfqmIbZlCvVibQbhNYllNXmMsCdFXE4
	 YSGIwf+uMtY/rK/dPrpXWD0W7ffG/CdxU83FICGZrBw9Udlr73m2VqItvCvR5ME3kr
	 EWCX9KK9Xn/Ejvy4BhcBfZNCsV936c2lXDaVwuzo=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250812050227epcas5p23ec69f59c3845ad521eef053b9827029~a7Gqjk6LU0479704797epcas5p2u;
	Tue, 12 Aug 2025 05:02:27 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c1KBB2ZBpz2SSKY; Tue, 12 Aug
	2025 05:02:26 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250811154729epcas5p456ddb0d1ba34b992204f54724b57a401~awQktGyX_2612226122epcas5p44;
	Mon, 11 Aug 2025 15:47:29 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154727epsmtip10f1370b9b4a42104a2120af22d683fe8~awQiFM6iH2596225962epsmtip1G;
	Mon, 11 Aug 2025 15:47:27 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 08/12] dt-bindings: phy: Add PCIe PHY support for FSD SoC
Date: Mon, 11 Aug 2025 21:16:34 +0530
Message-ID: <20250811154638.95732-9-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154729epcas5p456ddb0d1ba34b992204f54724b57a401
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154729epcas5p456ddb0d1ba34b992204f54724b57a401
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154729epcas5p456ddb0d1ba34b992204f54724b57a401@epcas5p4.samsung.com>

Since Tesla FSD SoC uses Samsung PCIe PHY, add support in
exynos PCIe PHY bindings.

In Tesla FSD SoC, the two PHY instances, although having identical
hardware design and register maps, are placed in different locations
(Placement and routing) inside the SoC and have distinct
PHY-to-Controller topologies. (One instance is connected to two PCIe
controllers, while the other is connected to only one). As a result,
they experience different analog environments, including varying
channel losses and noise profiles.

Since these PHYs lack internal adaptation mechanisms and f/w based
tuning, manual register programming is required for analog tuning.
To ensure optimal signal integrity, it is essential to use different
register values for each PHY instance, despite their identical hardware
design. This is because the same register values may not be suitable
for both instances due to their differing environments and topologies.

Due to this, we are using two PHY compatibles for different PHY
instances.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 .../bindings/phy/samsung,exynos-pcie-phy.yaml | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
index 41df8bb08ff7..6295472696db 100644
--- a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
@@ -15,10 +15,14 @@ properties:
     const: 0
 
   compatible:
-    const: samsung,exynos5433-pcie-phy
+    enum:
+      - samsung,exynos5433-pcie-phy
+      - tesla,fsd-pcie-phy0
+      - tesla,fsd-pcie-phy1
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   samsung,pmu-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -30,6 +34,25 @@ properties:
     description: phandle for FSYS sysreg interface, used to control
                  sysreg registers bits for PCIe PHY
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - tesla,fsd-pcie-phy0
+              - tesla,fsd-pcie-phy1
+    then:
+      properties:
+        reg:
+          items:
+            - description: PHY
+            - description: PCS
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
 required:
   - "#phy-cells"
   - compatible
-- 
2.49.0


