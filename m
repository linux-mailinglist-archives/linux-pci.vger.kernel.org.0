Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3696C2617F6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 19:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgIHRqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731627AbgIHQOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 12:14:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE2C0619C8;
        Tue,  8 Sep 2020 06:47:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v196so11009161pfc.1;
        Tue, 08 Sep 2020 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vEeD+VXX6EgpEyq5WLEylmJlyUmYwirw1P8EEbyTNrY=;
        b=r82UMhrLbpyXvGsztYdIMwyANMsMOnh9WOmNANg6xvVgEMHshZh1z14/pZlH7936IU
         4Oc84VjWekOJ50FpBe0J7BcBWV6ihIlmbIv0Ex+rK7IjOSxjSIDjpcoUfsnC3Ao5p1Xj
         ZQzqAVbspeMlpuc6r734YmovnwDvTwKoYZUX3mfeRDQmGALWATTKJvX2cZwMBZbjlO2/
         +q8joZACetc/zrCG6f5Vp7ZRB2Tq579sBFMhy5BjXB5oBVmlG6rPa5LCTCYIbm9z9ldP
         zQwWnrlVdiYiiAV7p3Q+xsuVfxdEtqy11pG1RLYqqxp9ssAuuSZITxNbsCvTZnMG00lf
         v+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vEeD+VXX6EgpEyq5WLEylmJlyUmYwirw1P8EEbyTNrY=;
        b=R8b8I7+ko+DaH9ywCYfkpoX38Rj5To3sMTu1z5eeDwwQ8NYiN1UQVz5GmoGtyh2bNm
         zkvzfhCgzpEqbsQE34kmNknfBYcOSeG8CTPlmynp3dqI6O4FuvoAw6ZI7ehb+TOZ0zsQ
         tA9j6MOCC739Ji/4Z6ORVwSwxtOZB4q788MZJaIs8AOnbPEZTABwTkfRjac9vOSw3i5N
         +jIJ8oEfspwQzxvsgGcEWJA71EYkA5jxGbXLv0Rgi8YynPouCKOipjvHZew77JarDdn/
         tw6AViwzVq70x75vksGqJkBBU7SYuMotRNi1LxI2TVNiYNONKo+WK0yA/n2zUZI1Wb6n
         kvhA==
X-Gm-Message-State: AOAM530AnJW4fXxhNOlOChxrJU3E4ajPtfHmqNMYumZ+0WiA5MffnnHn
        GD88WBWLboZR2aiorKXxA30=
X-Google-Smtp-Source: ABdhPJwt4o4+fGyToCCVKG7lxfm6Tn0a7dmXZbQQQLwAYHAH/f2ikEdxWWZcWu3nfJDDMKeYaza5gA==
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr23464081plr.86.1599572853387;
        Tue, 08 Sep 2020 06:47:33 -0700 (PDT)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j35sm14852313pgi.91.2020.09.08.06.47.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 06:47:32 -0700 (PDT)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Billows Wu <billows.wu@unisoc.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
Date:   Tue,  8 Sep 2020 21:47:20 +0800
Message-Id: <1599572841-2652-2-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599572841-2652-1-git-send-email-wuht06@gmail.com>
References: <1599572841-2652-1-git-send-email-wuht06@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Billows Wu <billows.wu@unisoc.com>

This series adds PCIe bindings for Unisoc SoCs.
This controller is based on Designware PCIe IP.

Signed-off-by: Billows Wu <billows.wu@unisoc.com>
---
 .../devicetree/bindings/pci/sprd-pcie.yaml         | 101 +++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sprd-pcie.yaml b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
new file mode 100644
index 0000000..40c2408
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
+  - Billows Wu <billows.wu@unisoc.com>
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

