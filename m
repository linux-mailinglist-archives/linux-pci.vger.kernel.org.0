Return-Path: <linux-pci+bounces-7232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF878BFE40
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97BD1F2316A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087779DDB;
	Wed,  8 May 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vktt/yrI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D678C93;
	Wed,  8 May 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174046; cv=none; b=IejmYEDcWt98O9Vb7gtoFXR64EH2hQ8342a1skEPLFfwVu0xW10b/cKDX+cPMwupbb4GmlvHUy6UPK9OQtt84kBpW3nbkFK7yTohi6gIIbtx3SnMKFsdPJ9WDkRxRsULc2h+xEBS+AHzu7J1BmlsVn+WpnJt5HQJQWUNRZvL6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174046; c=relaxed/simple;
	bh=a8pOODpzbTzj+peyc7fdoQaLOJmTFE1MbIu3A7gppK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xec+1ZtjoxtbXip+n9/5QZHi2pVBLztj15lFxveNgFurmmIfomiEEsE7XWj75DOhF4f1aZC1JcCBmI9LqOZDQ4FeOEeJ8DrFG8VU3hotVYUNTQzG8uhUziqfgkp63A9zQQihakS/YhB6L7O2SsaNxCCDRNJAHkxoNGColGCPVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vktt/yrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9DBC113CC;
	Wed,  8 May 2024 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174045;
	bh=a8pOODpzbTzj+peyc7fdoQaLOJmTFE1MbIu3A7gppK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vktt/yrIRb+w57yK1TOUCi7rIqMxLAswuWCuG3RJnyldv4h96z9XngR9eERN3JQZp
	 zCrpHzgBY2neE82YwYP9yUUoK+HzLjS3ueVGwCgBvF3430D8gDDGeJ3u1V192GXpw6
	 gRH4JNa3tHlFkOQddcxlpSFtjsJqAzfAriSbFHhNBeT5bUQkVI9yGDRJR9sOYay/NF
	 Zmm5OxiFEZJLft/G98hra3gH3wQRi3K8y9pwOtbuXCQhjiMFdt0WLntupadfAgYEJj
	 SsFEzKgyOxiion42kYtWE+vLsXlPVWrg/8D0NrMqh82ffEhFvXDoJI9TabuFpj6zJH
	 FGiyXZjCkARvQ==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:37 +0200
Subject: [PATCH v3 06/13] dt-bindings: rockchip: Add DesignWare based PCIe
 Endpoint controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-6-1748e202b084@kernel.org>
References: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
In-Reply-To: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
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
 h=from:subject:message-id; bh=a8pOODpzbTzj+peyc7fdoQaLOJmTFE1MbIu3A7gppK0=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKsq+oLEl/zvyoO0X82l3l9eXNTq1Qf04fcrxuilorod
 K1YJ23WUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgImwX2D4n7sw92bTqRxmibIi
 82erDXgO5n74OkdgWUZMJeeWE7/aYxgZtn56e61Lf8YjtSX8TlsWn/+3bpHxe5euDu20gPYztz/
 7MgMA
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
2.44.0


