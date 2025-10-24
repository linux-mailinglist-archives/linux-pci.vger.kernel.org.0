Return-Path: <linux-pci+bounces-39212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725AC03FFB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 03:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB0A1AA1C3B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 01:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D517F4F6;
	Fri, 24 Oct 2025 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDOL5Of3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130AC8405C;
	Fri, 24 Oct 2025 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268297; cv=none; b=ScBgC/KdE8s+lvHzZn1EpP84CYbg7Mke8kWMuOpeILQlgxYQ2iB4N8Up2KFJzQbzgzkaFkH31AUQPZHRJrmDwUpmqBk8Xvz3XbmwcHwjh9p5cEHTOmDby5Q3HI4mAKJdhy/XX1wzRurBkCr+bW27qGGq7J/e6kxDfiB20jdICnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268297; c=relaxed/simple;
	bh=sYVXJNowzbBXxfqAUDkJRSvbLsY6hEvJ0xreENX8QjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrKVCivLiLx7YM6LYtfMumucNgK++VUutIFv+pPlJgle8Z9tUYn0Ey1F/s5KTKM4HddleSUf2xbPH8pKcQRjN7CZbYG6mpcmy6TTSEt4SbHzP1kwwQzcO7wtRu/exiXfiaHtrfRugcI0vgUYVtKzHz1iXilNIQMlEzQlj8pO/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDOL5Of3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C692C4CEE7;
	Fri, 24 Oct 2025 01:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761268296;
	bh=sYVXJNowzbBXxfqAUDkJRSvbLsY6hEvJ0xreENX8QjA=;
	h=From:To:Cc:Subject:Date:From;
	b=aDOL5Of3SFEs05ZeCCWzGdwaQgK1mGDYDzetpmy0klLs8uy6LjtI/xQRTvtNN7/78
	 H0QKxn5mSWURrg8GWUbWR38DaYZAGco/RdqbSJ06v1fEVaHIOkZi1b6Rou3wVphYcg
	 YdzV3mebZe1L3yF7x2RCHE5X5AGlbj0gvZK3/d/MU20dN5jnAYvMokKrq516zOaCx0
	 qQqCZCUeT9fR0l2hElbXxiXjs6EDkkAhcPzEHXYkIPMleyP3KWPH2faorCi/BCRFYF
	 PzU2dUjfrFI7VjV+rD4xgCTb4RFw5qGIOOfRcyaJKF7CJgLhS8X3EA5Q6T9Z40I6QM
	 43FMNhnV/A21A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: amlogic,axg-pcie: Fix select schema
Date: Thu, 23 Oct 2025 20:11:21 -0500
Message-ID: <20251024011122.26001-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amlogic,axg-pcie binding was never enabled as the 'select' schema
expects a single compatible value, but the binding has a fallback
compatible. Fix the 'select' by adding a 'contains'. With this, several
errors in the clock and reset properties are exposed. Some of the names
aren't defined in the common DWC schema and the order of clocks entries
doesn't match .dts files.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/amlogic,axg-pcie.yaml          | 17 +++++++++--------
 .../bindings/pci/snps,dw-pcie-common.yaml       |  6 +++---
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
index 79a21ba0f9fd..bee694ff45f3 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
@@ -20,9 +20,10 @@ allOf:
 select:
   properties:
     compatible:
-      enum:
-        - amlogic,axg-pcie
-        - amlogic,g12a-pcie
+      contains:
+        enum:
+          - amlogic,axg-pcie
+          - amlogic,g12a-pcie
   required:
     - compatible
 
@@ -51,15 +52,15 @@ properties:
 
   clocks:
     items:
+      - description: PCIe PHY clock
       - description: PCIe GEN 100M PLL clock
       - description: PCIe RC clock gate
-      - description: PCIe PHY clock
 
   clock-names:
     items:
+      - const: general
       - const: pclk
       - const: port
-      - const: general
 
   phys:
     maxItems: 1
@@ -88,7 +89,7 @@ required:
   - reg
   - reg-names
   - interrupts
-  - clock
+  - clocks
   - clock-names
   - "#address-cells"
   - "#size-cells"
@@ -115,8 +116,8 @@ examples:
         reg = <0xf9800000 0x400000>, <0xff646000 0x2000>, <0xf9f00000 0x100000>;
         reg-names = "elbi", "cfg", "config";
         interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
-        clocks = <&pclk>, <&clk_port>, <&clk_phy>;
-        clock-names = "pclk", "port", "general";
+        clocks = <&clk_phy>, <&pclk>, <&clk_port>;
+        clock-names = "general", "pclk", "port";
         resets = <&reset_pcie_port>, <&reset_pcie_apb>;
         reset-names = "port", "apb";
         phys = <&pcie_phy>;
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 34594972d8db..6339a76499b2 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -115,11 +115,11 @@ properties:
             above for new bindings.
           oneOf:
             - description: See native 'dbi' clock for details
-              enum: [ pcie, pcie_apb_sys, aclk_dbi, reg ]
+              enum: [ pcie, pcie_apb_sys, aclk_dbi, reg, port ]
             - description: See native 'mstr/slv' clock for details
               enum: [ pcie_bus, pcie_inbound_axi, pcie_aclk, aclk_mst, aclk_slv ]
             - description: See native 'pipe' clock for details
-              enum: [ pcie_phy, pcie_phy_ref, link ]
+              enum: [ pcie_phy, pcie_phy_ref, link, general ]
             - description: See native 'aux' clock for details
               enum: [ pcie_aux ]
             - description: See native 'ref' clock for details.
@@ -176,7 +176,7 @@ properties:
             - description: See native 'phy' reset for details
               enum: [ pciephy, link ]
             - description: See native 'pwr' reset for details
-              enum: [ turnoff ]
+              enum: [ turnoff, port ]
 
   phys:
     description:
-- 
2.51.0


