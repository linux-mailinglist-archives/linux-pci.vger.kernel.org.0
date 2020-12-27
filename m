Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A111C2E3142
	for <lists+linux-pci@lfdr.de>; Sun, 27 Dec 2020 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgL0NNP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Dec 2020 08:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgL0NNN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Dec 2020 08:13:13 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1060C061795;
        Sun, 27 Dec 2020 05:12:32 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id p18so5755276pgm.11;
        Sun, 27 Dec 2020 05:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tg20jcKJdNMzDs8lrF5E15qRBXlejHgS8UGhy/VgAws=;
        b=hu5tebPbN+KZQQdIE3nFYBToxMTqh8Zy9ATAd2QewZGA0KMnEA/C5z/fQWXj3lw52y
         OxqWOr21AewD+8kFvEK5x0g/K/lhhM7egc5QLjq0/iXuqzpIayZR//1nrgWBAB/jr6dH
         SXxj7EUuWH0EI8/5O+1ngIVGS1k80Km6hx6hCPo6rQZ1U2064Ru2qsB5UgF/9HH3OFbd
         TRxQxQ/yTh9MD0Lf8BJbTDPv1Nvk2dpJTxx6J6rX17TViHbMj7zqwAIHRO1cs+p3bKjj
         04j3zRalaHXFWo4f66azIQyTeboJBcZ40w+nsAO1MgqU+EEZ9CAXNRp5DtPyJ7I27cuu
         grdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tg20jcKJdNMzDs8lrF5E15qRBXlejHgS8UGhy/VgAws=;
        b=cUw74z4+8TJ+qUkdz52ROnP3/SOW/RCadxS5gycVpK45IIuX8STpjqpPW6vfv43SNZ
         lu5e1aMb9hCNOMOAL7IxlqG+wvqrGeha94BBt7cSrbMBTo2OqVrkE7vTB5rKUE7tq7uu
         bjPddVmq/jCv+6m2qDf3sFWaOIj8Fc4EvdG7iRTdKSghpHsd2fzZOEDsJjJ/nj9z57jz
         Ip6W1iE5Zn7sOdmvCsr1NF419sNZs3OTPhNqXbtW+aUWojsOd4XmHnNq8356qecAigzV
         PHNxMA7T9DKw3xaBHMNqBDThebsfNws2fptIMkdnAHhGRM9AzgdkIBUdU+7TNaZvp+c3
         2+Aw==
X-Gm-Message-State: AOAM5315cJDj7m9zWoPzA5cUXDwV0Ugqoltg2C6M+XM1osegtJbhjAWQ
        MARCRzDUU14ftQXqV5NQcs+qJi2B7D4=
X-Google-Smtp-Source: ABdhPJygwf6lozBT3u0G6JO9r0Oo/BC7ibt3zh1kZdHG2BKidZmJk5RP9oNsAOCyDUJDxe50csWNdA==
X-Received: by 2002:a63:fa0b:: with SMTP id y11mr7377162pgh.35.1609074752328;
        Sun, 27 Dec 2020 05:12:32 -0800 (PST)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j15sm33510269pfn.180.2020.12.27.05.12.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Dec 2020 05:12:31 -0800 (PST)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
Date:   Sun, 27 Dec 2020 21:12:13 +0800
Message-Id: <1609074734-9336-2-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609074734-9336-1-git-send-email-wuht06@gmail.com>
References: <1609074734-9336-1-git-send-email-wuht06@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hongtao Wu <billows.wu@unisoc.com>

This series adds PCIe bindings for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
---
 .../devicetree/bindings/pci/sprd-pcie.yaml         | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sprd-pcie.yaml b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
new file mode 100644
index 0000000..fe47172
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sprd-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoC PCIe Host Controller Device Tree Bindings
+
+maintainers:
+  - Hongtao Wu <billows.wu@unisoc.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: sprd,ums9520-pcie
+
+  reg:
+    minItems: 2
+    items:
+      - description: Controller control and status registers.
+      - description: PCIe configuration registers.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+
+  ranges:
+    maxItems: 2
+
+  num-lanes:
+    maximum: 1
+    description: Number of lanes to use for this port.
+
+  interrupts:
+    minItems: 1
+    description: Builtin MSI controller and PCIe host controller.
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  sprd,regmap-aon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Phandle to the AON system controller node (to access the
+      AON_ACCESS_PCIE_EN register on ums9520).
+  sprd,regmap-pmu:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Phandle to the PMU system controller node (to access the PERST_N_ASSERT
+      register on ums9520).
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - num-lanes
+  - ranges
+  - interrupts
+  - interrupt-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    ipa {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie0: pcie@2b100000 {
+            compatible = "sprd,ums9520-pcie";
+            reg = <0x0 0x2b100000 0x0 0x2000>,
+                  <0x2 0x00000000 0x0 0x2000>;
+            reg-names = "dbi", "config";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges = <0x01000000 0x0 0x00000000 0x2 0x00002000 0x0 0x00010000>,
+                     <0x03000000 0x0 0x10000000 0x2 0x10000000 0x1 0xefffffff>;
+            num-lanes = <1>;
+            interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi";
+
+            sprd,regmap-aon = <&aon_regs>;
+            sprd,regmap-pmu = <&pmu_regs>;
+        };
+    };
--
2.7.4

