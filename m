Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E1A769D5D
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjGaQ5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjGaQ5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 12:57:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E351738;
        Mon, 31 Jul 2023 09:57:29 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-210-008.ewe-ip-backbone.de [91.248.210.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32C7A660711A;
        Mon, 31 Jul 2023 17:57:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690822647;
        bh=npeFno7/4xXEliCLqiK0LPZUBtteZmocE1lXLzTmkRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhM0NQxBoHNCpFxRTlBMTy47J0nMxULpp7yTETbkLrKPBq/zHBN241Bg5fkW3mIac
         u+t5bGt3gcwzqJzsZF6oBBaED5OBYGsjS6NVWAkThJL3J1f18sG/jDuVKH6pE9iGgc
         TSrdouiUpNuH2wZBKtSF/sCZD5vSp7rerdYkIOzkrBiNEGV3AnN5+8WrXeU7tsCkRB
         Xs5FpMI8WQZG/dmas5PmIwfQ39nnMfs/JFiY5fvpdLT50qynVJKioAZ8KBBDKPiRVL
         MrCLIkVhiUJyIEDdA9hjB8QB3B+8tzamJkVkbQPd1+bk+95dZ9rSTsiS2U9xKbONlH
         oQ3YLwRbEiB9g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2AAAC4800A5; Mon, 31 Jul 2023 18:57:25 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 2/5] dt-bindings: PCI: dwc: rockchip: Fix interrupt-names issue
Date:   Mon, 31 Jul 2023 18:57:20 +0200
Message-Id: <20230731165723.53069-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731165723.53069-1-sebastian.reichel@collabora.com>
References: <20230731165723.53069-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The RK356x (and RK3588) have 5 ganged interrupts. For example the
"legacy" interrupt combines "inta/intb/intc/intd" with a register
providing the details, which specific interrupt triggered. The
interrupts from the second level are part of the Synopsys DW PCIe
System Information Interface (SII). Some of them are listed in the
Interrupt Signals section, the others are mostly common SII output
signals. The grouping and the ganged interrupt controllers are
specific to the Rockchip implementation.

Currently the binding is not specifying these interrupts resulting
in a bunch of errors for all rk356x/rk3588 boards using PCIe.

Fix this by specifying the interrupts and add them to the example
to prevent regressions.

This changes the reference from snps,dw-pcie.yaml to
snps,dw-pcie-common.yaml, since the interrupts are vendor
specific and should not be listed in the generic file. The
only other bit from the generic binding are the reg-names,
which are overwritten by this binding.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/pci/rockchip-dw-pcie.yaml        | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index a4f61ced5e88..7836b9a5547c 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -17,7 +17,8 @@ description: |+
   snps,dw-pcie.yaml.
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
@@ -60,6 +61,39 @@ properties:
       - const: aux
       - const: pipe
 
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
   msi-map: true
 
   num-lanes: true
@@ -108,6 +142,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     bus {
         #address-cells = <2>;
@@ -127,6 +162,12 @@ examples:
                           "aclk_dbi", "pclk",
                           "aux";
             device_type = "pci";
+            interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "sys", "pmc", "msg", "legacy", "err";
             linux,pci-domain = <2>;
             max-link-speed = <2>;
             msi-map = <0x2000 &its 0x2000 0x1000>;
-- 
2.40.1

