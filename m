Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0CC24D1C4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHUJwS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgHUJwL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 05:52:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D27C061386;
        Fri, 21 Aug 2020 02:52:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m71so827587pfd.1;
        Fri, 21 Aug 2020 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BjfQ0AkfS3kL9HDk+Q/YejZuzmMLr9t4tJRavtedkMY=;
        b=Bjuznksh9MDo9roP54IrWhceOK8huD7RRJ5h4yKgGVYlHY3O1yKLO48hjItK3aQWBo
         t9n/GPp6ToDMoa4/Jl9/iUhbxHUNoBklfx/RO5XvmY6MY3Kpgsy/9Ywh4q6kqGEdocyI
         LOZNOEl4/qqrHQDPd3R3uicYNFGN5HE61D7PhzXLmw7SdpZKmk7X7rSVT+An+LMOFpD5
         U/YaX85co6MLwEpanPiLgbCUGZpisGPvMbVY5L1uzS6hjRdzs9kOjNfhL93MlPSvJs8Z
         LKKjcdYQXYesDBiK7PnUM7wXgduly5bRi4gijVDZm3JdLtddn8SGtMUFJn9Pko0uzV9N
         zYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BjfQ0AkfS3kL9HDk+Q/YejZuzmMLr9t4tJRavtedkMY=;
        b=oPumH5uHpzAPbb+nC7j8aH4kpvetFVdFYn4YSqAFZq9ICIFF+UlmcVoYPM7J2YbxaX
         9I0vlPZzJF7o58llwAdyLrhxIN4DxMgJDpGVxdEG0/gvmxwygJe98XK2OVU3TyqGZNTr
         pV/5Q+XTZj5FMw91FCTQ5AnFNUta/r8rrXgVAqJfkFGJOYVC9lmAObnZWPp70Gnwedmp
         FkUACLuyi5eaDjqM8fIVBrIGY+iQv+Ew8KC9h5Ew+Bno+3xw15N5z/NoJ0r6DHL0XSs7
         14chZz+1gYB2nFcHBP3C4aEjJXA98K64XEfPjr449aqekhl+QQJhUzpbEwqTQ7VwbiJc
         8zbA==
X-Gm-Message-State: AOAM533JnJPDT9TDVViKLbqCn+mSS1TTSY2qIWmPwyWmHdCOHrA4vW3f
        zaC98PDFcA5vRniGeKJaoAA=
X-Google-Smtp-Source: ABdhPJy72m5E2eieegQbRpUTXdKnkGD4TcBdXW1zoWAtWQ3yqv1JKfgZKFshq97amCbcTD5CBdnGeA==
X-Received: by 2002:aa7:8285:: with SMTP id s5mr1811034pfm.226.1598003530797;
        Fri, 21 Aug 2020 02:52:10 -0700 (PDT)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d5sm1479828pjw.18.2020.08.21.02.52.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 02:52:10 -0700 (PDT)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Billows Wu <billows.wu@unisoc.com>
Subject: [PATCH 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
Date:   Fri, 21 Aug 2020 17:51:48 +0800
Message-Id: <1598003509-27896-2-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598003509-27896-1-git-send-email-wuht06@gmail.com>
References: <1598003509-27896-1-git-send-email-wuht06@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Billows Wu <billows.wu@unisoc.com>

This series adds PCIe bindings for Uisoc SoCs.
This controller is based on DesignWare PCIe IP.

Signed-off-by: Billows Wu <billows.wu@unisoc.com>
---
 .../devicetree/bindings/pci/sprd-pcie.yaml         | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sprd-pcie.yaml b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
new file mode 100644
index 0000000..6eab4b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
@@ -0,0 +1,88 @@
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
+  - $ref: "sprd-pcie.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: sprd,pcie
+      - const: sprd,pcie-ep
+
+  reg:
+    minItems: 2
+    maxItems: 3
+    items:
+      - description: Controller control and status registers.
+      - description: PCIe shadow registers.
+      - description: PCIe configuration registers.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: cfg
+
+  ranges:
+    maxItems: 2
+
+  num-lanes:
+    maxItems: 1
+    description: Number of lanes to use for this port.
+
+  num-ib-windows:
+    maxItems: 1
+    description: Number of inbound windows to use for this port.
+
+  num-ob-windows:
+    maxItems: 1
+    description: Number of outbound windows to use for this port.
+
+  bus-range:
+    description: Range of bus numbers associated with this controller.
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - num-lanes
+  - ranges
+  - bus-range
+  - interrupts
+  - interrupt-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pcie0@2b100000 {
+        compatible = "sprd,pcie", "snps,dw-pcie";
+        reg = <0x0 0x2b100000 0x0 0x2000>,
+              <0x2 0x00000000 0x0 0x2000>;
+        reg-names = "dbi", "config";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        ranges = <0x01000000 0x0 0x00000000 0x2 0x00002000 0x0 0x00010000
+                  0x03000000 0x0 0x10000000 0x2 0x10000000 0x1 0xefffffff>;
+        bus-range = <0  15>;
+        num-lanes = <1>;
+        num-viewport = <8>;
+        interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+    };
--
2.7.4

