Return-Path: <linux-pci+bounces-8003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7F8D3180
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D141C20DF4
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219B91802D6;
	Wed, 29 May 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caItURaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22416A38C;
	Wed, 29 May 2024 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971379; cv=none; b=NlZNh+LXbJKfxSI5BxIgzBV5YH10CG8mjVqm6CrU2KMwjP6MCV7W4aurSAhR+Aw2hwvQroE0yIWgHflnDA2FyPdpvEB9zzOxbR7kKRUpEmeJ9vpJBtxhENK+7mVRX0DAGtXL4vYkcmVVenftuud1RRPd1EKEb5YwyGWH3sPFL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971379; c=relaxed/simple;
	bh=nWtMO3Tq70/oK25PGlvcS03OBMjbjH2pdvYUD7wjcIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNoIsbtj+EfMgvUicDqMRQokEOKQXPYXheqxH8fLoDYOnF/4bvw5KbfR0aSAP0KLDNwr/Kj8UcAFKHxxGBASwaQqIWGWrVCEPuay/SbXJQOD8fwnK37evq1KsRrgqisRBR1By61SHF66VlE8gLmlbWsgW8diK9VORz/BY716Q60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caItURaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17907C32786;
	Wed, 29 May 2024 08:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716971378;
	bh=nWtMO3Tq70/oK25PGlvcS03OBMjbjH2pdvYUD7wjcIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=caItURaDaOim13+0rLMOpCIqrjMpzl+h1Cj4mOwPzjLByJATqglAhJs1TmoCSQp4X
	 fb2MFPCqPaYdp6shprAM5Ct9dg+oZhZn7C1E+/dBwjMpHKQ2X2zlfCfDR6gT4w7YaI
	 HgCn5gtSSAS79R5OLSKYirntMsbfsFmzPqv43lPG5eY/77XJEVtRHNEEhy+eh10Lu3
	 Cw3HaoxvMERBXIPPP0k0KD5+kw8WB0DNLbMurSstaVcaKcMByLLqSOfLXkdc2lMmrq
	 I3Sf7+HjwHEeMFIhMwx3TnKEiu4ezO9ZC39l/jnVp83igVZ0D/cEh73Xki5kROJeqI
	 Q1jewmNvmGGrw==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 29 May 2024 10:29:00 +0200
Subject: [PATCH v4 06/13] dt-bindings: rockchip: Add DesignWare based PCIe
 Endpoint controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-rockchip-pcie-ep-v1-v4-6-3dc00fe21a78@kernel.org>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5534; i=cassel@kernel.org;
 h=from:subject:message-id; bh=nWtMO3Tq70/oK25PGlvcS03OBMjbjH2pdvYUD7wjcIo=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLCnoc2zrrSPHn3/J3Nd/cUnZe+EDr9fdaTwsonp45sy
 Lss9d3mSEcpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAmErmO4a+4UeWTExGxWgIL
 ZWM95Z7czpOL37P9+WWHrQ8rvTkWdskx/LOWu3f2xvn3gr9qvqoe/7Xi0k4OG17eL4nBQQXce/a
 od3ACAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Document DT bindings for PCIe Endpoint controller found in Rockchip SoCs.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/rockchip-dw-pcie-common.yaml      | 14 ++++
 .../bindings/pci/rockchip-dw-pcie-ep.yaml          | 95 ++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
index ec5e6a3d048e..cc9adfc7611c 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
@@ -39,6 +39,7 @@ properties:
       - const: ref
 
   interrupts:
+    minItems: 5
     items:
       - description:
           Combined system interrupt, which is used to signal the following
@@ -63,14 +64,27 @@ properties:
           interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
           tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
           nf_err_rx, f_err_rx, radm_qoverflow
+      - description:
+          eDMA write channel 0 interrupt
+      - description:
+          eDMA write channel 1 interrupt
+      - description:
+          eDMA read channel 0 interrupt
+      - description:
+          eDMA read channel 1 interrupt
 
   interrupt-names:
+    minItems: 5
     items:
       - const: sys
       - const: pmc
       - const: msg
       - const: legacy
       - const: err
+      - const: dma0
+      - const: dma1
+      - const: dma2
+      - const: dma3
 
   num-lanes: true
 
diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
new file mode 100644
index 000000000000..e0c8668afc01
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare based PCIe Endpoint controller on Rockchip SoCs
+
+maintainers:
+  - Niklas Cassel <cassel@kernel.org>
+
+description: |+
+  RK3588 SoC PCIe Endpoint controller is based on the Synopsys DesignWare
+  PCIe IP and thus inherits all the common properties defined in
+  snps,dw-pcie-ep.yaml.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+  - $ref: /schemas/pci/rockchip-dw-pcie-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-pcie-ep
+      - rockchip,rk3588-pcie-ep
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers
+      - description: Data Bus Interface (DBI) shadow registers
+      - description: Rockchip designed configuration registers
+      - description: Memory region used to map remote RC address space
+      - description: Address Translation Unit (ATU) registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: apb
+      - const: addr_space
+      - const: atu
+
+required:
+  - interrupts
+  - interrupt-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/rk3588-power.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie3x4_ep: pcie-ep@fe150000 {
+            compatible = "rockchip,rk3588-pcie-ep";
+            clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
+                     <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
+                     <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
+            clock-names = "aclk_mst", "aclk_slv",
+                          "aclk_dbi", "pclk",
+                          "aux", "pipe";
+            interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH 0>;
+            interrupt-names = "sys", "pmc", "msg", "legacy", "err",
+                              "dma0", "dma1", "dma2", "dma3";
+            max-link-speed = <3>;
+            num-lanes = <4>;
+            phys = <&pcie30phy>;
+            phy-names = "pcie-phy";
+            power-domains = <&power RK3588_PD_PCIE>;
+            reg = <0xa 0x40000000 0x0 0x00100000>,
+                  <0xa 0x40100000 0x0 0x00100000>,
+                  <0x0 0xfe150000 0x0 0x00010000>,
+                  <0x9 0x00000000 0x0 0x40000000>,
+                  <0xa 0x40300000 0x0 0x00100000>;
+            reg-names = "dbi", "dbi2", "apb", "addr_space", "atu";
+            resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
+            reset-names = "pwr", "pipe";
+        };
+    };
+...

-- 
2.45.1


