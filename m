Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F753399F1C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 12:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCKlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 06:41:12 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:39506 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFCKlM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 06:41:12 -0400
Received: by mail-pj1-f47.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so5216595pjp.4
        for <linux-pci@vger.kernel.org>; Thu, 03 Jun 2021 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1PUdWT8u4uVKn934qZyRyKaFpSaDcuxgXKUIM2NUcww=;
        b=JQd0CW00L5PfyoKqy241YpEHRLDpXL7J428pHGoLWV5gL4KfpN45zGESE3IzqZl5Ps
         2JIOOKC9MJyyb6LtsnE9qwCfMBkbmZiMVk/ZEPIjmE/gLqPvYM62uS37g0TpRg94m0pK
         yTm1pQRWAkdAKAVmOkTp2PZakbgaCUbYMbxEcTQHEM8NgKXQvhoTkrzzQGhR6xq0iiKF
         BQPL2FIwjZ19vcmniXY6qF7UJJo9QbK1IWshTNZoTsZiawgJoj0612tHAGBZYYXu4r71
         D8YQvSgJujk6ITifGfShobCC+YmFuhROTG0O1UOuE9X7m/GRTOuiB3lVGhgnBTWPH9Ij
         r3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1PUdWT8u4uVKn934qZyRyKaFpSaDcuxgXKUIM2NUcww=;
        b=AEiPGr2hNqrCABFiqXq1UnX66mMv8XmAg5MpfvRm70IVvdw9h/4uf0mMsxMidl2SWa
         10RXXReQs5IuNOGcNLVsUNyvEAqp0IKzugaEItuOzFRJzDqc8Ceeoqx+TW6AFxjZHOlM
         NixeISbzwN4XwDw3Jpm9tRAgkc8AoSzq8yjBre8GMceymRs2MNk3i5g0I8c8dk0zfPvK
         ekC0bojQ7OBIMmZQPQliAw23KTTt1bM4yIcwbfy1RjBxiiG/KBQFuNOqRvB0QYj816Z0
         PORrFYObFIZ4DobJrNgh7cE/DRlFkymR516hXBbZuzkCVu1PBvITj9ew1RzLFSPohfMT
         x+Yg==
X-Gm-Message-State: AOAM532El7zhfcDgO9CBNltqX9zejy4GCSv30EwLOl1/tqtRdgi4HORV
        zJfxKNqdELfFTW/i6ij77IxJ
X-Google-Smtp-Source: ABdhPJxILU2zQtIZwfvk5zV2uJrCJhKVKLv/i58JTXA5joJs94szP/0rR3KDxLDg5Nxp0mI935HNIA==
X-Received: by 2002:a17:902:bcc7:b029:ed:6f73:ffc4 with SMTP id o7-20020a170902bcc7b02900ed6f73ffc4mr34721411pls.1.1622716707528;
        Thu, 03 Jun 2021 03:38:27 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.41])
        by smtp.gmail.com with ESMTPSA id v67sm2053370pfb.193.2021.06.03.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:38:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP controller
Date:   Thu,  3 Jun 2021 16:08:12 +0530
Message-Id: <20210603103814.95177-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
References: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree binding for Qualcomm PCIe EP controller used in platforms
like SDX55. The EP controller is based on the Designware core with
Qualcomm specific wrappers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
new file mode 100644
index 000000000000..3e357cb03a5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PCIe Endpoint Controller binding
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+allOf:
+  - $ref: "pci-ep.yaml#"
+
+properties:
+  compatible:
+    const: qcom,sdx55-pcie-ep
+
+  reg:
+    items:
+      - description: Qualcomm specific PARF configuration registers
+      - description: Designware PCIe registers
+      - description: External local bus interface registers
+      - description: Address Translation Unit (ATU) registers
+      - description: Memory region used to map remote RC address space
+      - description: Qualcomm specific TCSR registers
+
+  reg-names:
+    items:
+      - const: parf
+      - const: dbi
+      - const: elbi
+      - const: atu
+      - const: addr_space
+      - const: tcsr
+
+  clocks:
+    items:
+      - description: PCIe Auxiliary clock
+      - description: PCIe CFG AHB clock
+      - description: PCIe Master AXI clock
+      - description: PCIe Slave AXI clock
+      - description: PCIe Slave Q2A AXI clock
+      - description: PCIe Sleep clock
+      - description: PCIe Reference clock
+
+  clock-names:
+    items:
+      - const: aux
+      - const: cfg
+      - const: bus_master
+      - const: bus_slave
+      - const: slave_q2a
+      - const: sleep
+      - const: ref
+
+  interrupts:
+    maxItems: 1
+    description: PCIe Global interrupt
+
+  interrupt-names:
+    const: global
+
+  reset-gpios:
+    description: GPIO that is being used as PERST# input signal
+    maxItems: 1
+
+  wake-gpios:
+    description: GPIO that is being used as WAKE# output signal
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: core
+
+  power-domains:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pciephy
+
+  num-lanes:
+    default: 2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - reset-gpios
+  - resets
+  - reset-names
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdx55.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pcie_ep: pcie-ep@40000000 {
+        compatible = "qcom,sdx55-pcie-ep";
+        reg = <0x01c00000 0x3000>,
+              <0x40000000 0xf1d>,
+              <0x40000f20 0xc8>,
+              <0x40001000 0x1000>,
+              <0x42000000 0x1000>,
+              <0x01fcb000 0x1000>;
+        reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+                    "tcsr";
+
+        clocks = <&gcc GCC_PCIE_AUX_CLK>,
+             <&gcc GCC_PCIE_CFG_AHB_CLK>,
+             <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+             <&gcc GCC_PCIE_SLV_AXI_CLK>,
+             <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+             <&gcc GCC_PCIE_SLEEP_CLK>,
+             <&gcc GCC_PCIE_0_CLKREF_CLK>;
+        clock-names = "aux", "cfg", "bus_master", "bus_slave",
+                      "slave_q2a", "sleep", "ref";
+
+        interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "global";
+        reset-gpios = <&tlmm 57 GPIO_ACTIVE_HIGH>;
+        wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+        resets = <&gcc GCC_PCIE_BCR>;
+        reset-names = "core";
+        power-domains = <&gcc PCIE_GDSC>;
+        phys = <&pcie0_lane>;
+        phy-names = "pciephy";
+        max-link-speed = <3>;
+        num-lanes = <2>;
+
+        status = "disabled";
+    };
-- 
2.25.1

