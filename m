Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D50262C6E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 11:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIIJsr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 05:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgIIJsn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 05:48:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2FBC061573;
        Wed,  9 Sep 2020 02:48:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so1688579pfd.5;
        Wed, 09 Sep 2020 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xBeT7ji1PTrfYSg3T1f+pJVuPViXQCdYbmPK9A6+WZA=;
        b=CILdFy79tfNXqFWAOKTl9VdLO5sdkrT0a1HwM1dJcwVYrIJTgRVoI37Gp1RZfxdoK0
         esNIOxh7dajZgzVOqJ8CGR/Q1ud4t6RJa5osiPkVOcePHocxe6WnVyQz4KPQefL/8lAg
         86rF+S9C2dVICakUtmLIqjQr0He67moTXmRfU82DIkCx489XeVGiD4pUY8PMPQU6aouz
         oJ04uf7unh/EBzK9GghcMFg+8636Ns541O77CYe7PKzQzamsjgBNyQIBdfiktpxkUqdH
         NpN37ovC9aHBalCfQCM70yOE5xJfUiKaA2VuvmTm6VtHxe+zhuL/pHUTyDOP/bQzRBBo
         VMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xBeT7ji1PTrfYSg3T1f+pJVuPViXQCdYbmPK9A6+WZA=;
        b=N4dirCHcR9eegViP9A6SIQT1Oc7feM5cxrqc8RACGQvWl9z8JFdOx/bCsG6EaHUFS3
         vS2iJxApqwFUr+bA3yp5Qoxb8Hx8SGvkXxG/7O2Ae+Fuob0Z0tG2wjq1HVvRQV9IUrgx
         an0khvBY2pvlQ+as1Bx1W0nTIEyj5Orp+is4x7g3gTDSYuS0is4Y+mQLu5pYo3LYwmiR
         npYiSKIAL30wcaP5TFukqHg15O70fVLf+/iikfO4ZMEUtl7sA6AMbEsWHsQaLgyaclFB
         RiGu2UvlAzz6jMGPm4DiMTV+5SU2GFN0pW/Cdg1WWggDT5e2UIklXr1cZGceDjSoekp2
         g4OQ==
X-Gm-Message-State: AOAM531/yqMkirvMs2bKudFJWyW+YMD6j6+svqYFIMAHxYTXbFooGgjv
        hnpNuofzHUo4//VZt1473Jc=
X-Google-Smtp-Source: ABdhPJyj9MzbBmD2hmVjGmXz8Rfa/6KQDI6aV4UJpLizxPHoc5LwELi27icfrEYC4YNxvebiwlT+6Q==
X-Received: by 2002:a62:93:0:b029:13e:d13d:a085 with SMTP id 141-20020a6200930000b029013ed13da085mr177527pfa.28.1599644923208;
        Wed, 09 Sep 2020 02:48:43 -0700 (PDT)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u14sm2224149pfc.203.2020.09.09.02.48.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:48:42 -0700 (PDT)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
Date:   Wed,  9 Sep 2020 17:48:31 +0800
Message-Id: <1599644912-29245-2-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599644912-29245-1-git-send-email-wuht06@gmail.com>
References: <1599644912-29245-1-git-send-email-wuht06@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hongtao Wu <billows.wu@unisoc.com>

This series adds PCIe bindings for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
---
 .../devicetree/bindings/pci/sprd-pcie.yaml         | 101 +++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sprd-pcie.yaml b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
new file mode 100644
index 0000000..c52edfb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
@@ -0,0 +1,101 @@
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
+      - const: sprd,pcie-rc
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
+  sprd-pcie-poweron-syscons:
+    minItems: 1
+    description: Global register.
+      The first value is the phandle to the global registers required to
+      confige PCIe phy, clock and so on.
+      The second value is the global register type which indicates whether it
+      is a set/clear register or not.
+      The third value is the time to delay after the global register is set or
+      cleared.
+      The fourth value is the global register address.
+      The fifth value is the the mask value that the global register must
+      be operate.
+      The sixth value is the value that will be set to the global register.
+      Note that Some Unisoc global registers have not been upstreamed.
+      The global register and its mask can't be found in linux kernel,
+      so we use an offset address and a number to instead them.
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
+            compatible = "sprd,pcie-rc";
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
+            sprd,pcie-poweron-syscons =
+                <&ap_ipa_ahb_regs 0 0 0x0000 0x40 0x40>,
+                <&ap_ipa_ahb_regs 0 0 0x0000 0x20 0x20>;
+            sprd,pcie-poweroff-syscons =
+                <&ap_ipa_ahb_regs 0 0 0x0000 0x20 0x0>,
+                <&ap_ipa_ahb_regs 0 0 0x0000 0x40 0x0>;
+        };
+    };
--
2.7.4

