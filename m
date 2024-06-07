Return-Path: <linux-pci+bounces-8450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061BC9001BC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122AB1C218F4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6727E14F11B;
	Fri,  7 Jun 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDqy/3U7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEE187328;
	Fri,  7 Jun 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758888; cv=none; b=slcCsGrNGGbsXl+otYoX6QU8icbaXTEXP7JvKm2DzivU2zSm2vRuq9hNotuf6ZuU26kbIqm9aO1tCWr8JUiAB9DjhXhAE3nDm7YYbxeiKAqq1c1QKSVKvJ0os7wCGppm42N1HZl/ySFcKdvUaFkMKustKQNJN+ae0WI5bI/9TbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758888; c=relaxed/simple;
	bh=LMjwYuvyKA1YAKV2HODt4aKJwV3L3lQE3Wy4MEim00w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hVkf7AR8htoe3LCRe4ZISjrg2B9ZXBzpU+5GP1ieNN0nVkXs6F33DgJeIkqma43fTp8uFLaBT8YcQoTAgJv9+jzp+kP+oWw5jjFDcF/EavJaoIK0HX10lT8mjukkeELHLI16/0Fk1eo5tdEh3GqiWqWVHTssW0pXf7JKsd7zsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDqy/3U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03961C2BBFC;
	Fri,  7 Jun 2024 11:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758887;
	bh=LMjwYuvyKA1YAKV2HODt4aKJwV3L3lQE3Wy4MEim00w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lDqy/3U7vkwac/SZKhxKkAqeXDUvwUy/sSJIB/4NFMwUUeMzp81eegzB7Xin1d0Iy
	 GNSrfwnxetujeFn+LXwnDvDftwLglMJOHxTCyFxD00Gif8Kx6KEnOrdlCgbKHK7of3
	 3jjas16G4ZnFYMduTgNqjckwrPaJFOwESuEwBXxbPpNgd4KaXiZP1WCCHjhMBD78tq
	 L43CEglDvu/CPSyAr64kKg7LeWfAPhnc46JyuYiTuo8Su37cGzu/Uzyrxl6Pf5645V
	 xwXKIEWb0lDbxLaGBnfqPi9F+uQ/OBB3AWHw3W7Cp8vfUaHdQeX1I2QoY8XnmTZMPS
	 0w+AMjV5qmyEQ==
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 07 Jun 2024 13:14:24 +0200
Subject: [PATCH v5 04/13] dt-bindings: PCI: rockchip-dw-pcie: Prepare for
 Endpoint mode support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-rockchip-pcie-ep-v1-v5-4-0a042d6b0049@kernel.org>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
In-Reply-To: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8140; i=cassel@kernel.org;
 h=from:subject:message-id; bh=LMjwYuvyKA1YAKV2HODt4aKJwV3L3lQE3Wy4MEim00w=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKSXk/01LIJa3sT6JKTt3ha0ZW0Z4E63x5z9QqsOrqh5
 fTX4wkPOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR7BKG/4Exq/ZN5Dj3TOtu
 9eWIBTs6w1zePf247lFfKv/LcJ+ig90M/8uV0k91G735sdhL4ZD1Vk3XkxztX7KE649Hq5UrRcz
 VYQYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Refactor the rockchip-dw-pcie binding to move generic properties to a new
rockchip-dw-pcie-common binding that can be shared by both RC and EP mode.

No functional change intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/pci/rockchip-dw-pcie-common.yaml      | 111 +++++++++++++++++++++
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  93 +----------------
 2 files changed, 114 insertions(+), 90 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
new file mode 100644
index 000000000000..60d190a77580
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare based PCIe RC/EP controller on Rockchip SoCs
+
+maintainers:
+  - Shawn Lin <shawn.lin@rock-chips.com>
+  - Simon Xue <xxm@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |+
+  Generic properties for the DesignWare based PCIe RC/EP controller on Rockchip
+  SoCs.
+
+properties:
+  clocks:
+    minItems: 5
+    items:
+      - description: AHB clock for PCIe master
+      - description: AHB clock for PCIe slave
+      - description: AHB clock for PCIe dbi
+      - description: APB clock for PCIe
+      - description: Auxiliary clock for PCIe
+      - description: PIPE clock
+      - description: Reference clock for PCIe
+
+  clock-names:
+    minItems: 5
+    items:
+      - const: aclk_mst
+      - const: aclk_slv
+      - const: aclk_dbi
+      - const: pclk
+      - const: aux
+      - const: pipe
+      - const: ref
+
+  interrupts:
+    items:
+      - description:
+          Combined system interrupt, which is used to signal the following
+          interrupts - phy_link_up, dll_link_up, link_req_rst_not, hp_pme,
+          hp, hp_msi, link_auto_bw, link_auto_bw_msi, bw_mgt, bw_mgt_msi,
+          edma_wr, edma_rd, dpa_sub_upd, rbar_update, link_eq_req, ep_elbi_app
+      - description:
+          Combined PM interrupt, which is used to signal the following
+          interrupts - linkst_in_l1sub, linkst_in_l1, linkst_in_l2,
+          linkst_in_l0s, linkst_out_l1sub, linkst_out_l1, linkst_out_l2,
+          linkst_out_l0s, pm_dstate_update
+      - description:
+          Combined message interrupt, which is used to signal the following
+          interrupts - ven_msg, unlock_msg, ltr_msg, cfg_pme, cfg_pme_msi,
+          pm_pme, pm_to_ack, pm_turnoff, obff_idle, obff_obff, obff_cpu_active
+      - description:
+          Combined legacy interrupt, which is used to signal the following
+          interrupts - inta, intb, intc, intd
+      - description:
+          Combined error interrupt, which is used to signal the following
+          interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
+          tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
+          nf_err_rx, f_err_rx, radm_qoverflow
+
+  interrupt-names:
+    items:
+      - const: sys
+      - const: pmc
+      - const: msg
+      - const: legacy
+      - const: err
+
+  num-lanes: true
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie-phy
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    oneOf:
+      - const: pipe
+      - items:
+          - const: pwr
+          - const: pipe
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - num-lanes
+  - phys
+  - phy-names
+  - power-domains
+  - resets
+  - reset-names
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 5f719218c472..550d8a684af3 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: DesignWare based PCIe controller on Rockchip SoCs
+title: DesignWare based PCIe Root Complex controller on Rockchip SoCs
 
 maintainers:
   - Shawn Lin <shawn.lin@rock-chips.com>
@@ -12,12 +12,13 @@ maintainers:
   - Heiko Stuebner <heiko@sntech.de>
 
 description: |+
-  RK3568 SoC PCIe host controller is based on the Synopsys DesignWare
+  RK3568 SoC PCIe Root Complex controller is based on the Synopsys DesignWare
   PCIe IP and thus inherits all the common properties defined in
   snps,dw-pcie.yaml.
 
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/rockchip-dw-pcie-common.yaml#
 
 properties:
   compatible:
@@ -40,61 +41,6 @@ properties:
       - const: apb
       - const: config
 
-  clocks:
-    minItems: 5
-    items:
-      - description: AHB clock for PCIe master
-      - description: AHB clock for PCIe slave
-      - description: AHB clock for PCIe dbi
-      - description: APB clock for PCIe
-      - description: Auxiliary clock for PCIe
-      - description: PIPE clock
-      - description: Reference clock for PCIe
-
-  clock-names:
-    minItems: 5
-    items:
-      - const: aclk_mst
-      - const: aclk_slv
-      - const: aclk_dbi
-      - const: pclk
-      - const: aux
-      - const: pipe
-      - const: ref
-
-  interrupts:
-    items:
-      - description:
-          Combined system interrupt, which is used to signal the following
-          interrupts - phy_link_up, dll_link_up, link_req_rst_not, hp_pme,
-          hp, hp_msi, link_auto_bw, link_auto_bw_msi, bw_mgt, bw_mgt_msi,
-          edma_wr, edma_rd, dpa_sub_upd, rbar_update, link_eq_req, ep_elbi_app
-      - description:
-          Combined PM interrupt, which is used to signal the following
-          interrupts - linkst_in_l1sub, linkst_in_l1, linkst_in_l2,
-          linkst_in_l0s, linkst_out_l1sub, linkst_out_l1, linkst_out_l2,
-          linkst_out_l0s, pm_dstate_update
-      - description:
-          Combined message interrupt, which is used to signal the following
-          interrupts - ven_msg, unlock_msg, ltr_msg, cfg_pme, cfg_pme_msi,
-          pm_pme, pm_to_ack, pm_turnoff, obff_idle, obff_obff, obff_cpu_active
-      - description:
-          Combined legacy interrupt, which is used to signal the following
-          interrupts - inta, intb, intc, intd
-      - description:
-          Combined error interrupt, which is used to signal the following
-          interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
-          tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
-          nf_err_rx, f_err_rx, radm_qoverflow
-
-  interrupt-names:
-    items:
-      - const: sys
-      - const: pmc
-      - const: msg
-      - const: legacy
-      - const: err
-
   legacy-interrupt-controller:
     description: Interrupt controller node for handling legacy PCI interrupts.
     type: object
@@ -119,47 +65,14 @@ properties:
 
   msi-map: true
 
-  num-lanes: true
-
-  phys:
-    maxItems: 1
-
-  phy-names:
-    const: pcie-phy
-
-  power-domains:
-    maxItems: 1
-
   ranges:
     minItems: 2
     maxItems: 3
 
-  resets:
-    minItems: 1
-    maxItems: 2
-
-  reset-names:
-    oneOf:
-      - const: pipe
-      - items:
-          - const: pwr
-          - const: pipe
-
   vpcie3v3-supply: true
 
 required:
-  - compatible
-  - reg
-  - reg-names
-  - clocks
-  - clock-names
   - msi-map
-  - num-lanes
-  - phys
-  - phy-names
-  - power-domains
-  - resets
-  - reset-names
 
 unevaluatedProperties: false
 

-- 
2.45.2


