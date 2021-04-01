Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E291A350EB8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhDAGBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 02:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhDAGBR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 02:01:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54014C061794
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so2502434pjc.2
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 23:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dzHWDiN1Wjk8roHrncU6culKFNwJPo7qFVNBejhbdf4=;
        b=k8eR6VtkN8wT1BSouzItYIwAJdSwTRr7it0UlwPvelXLQvFcYC54FHPNplZN0dDFOG
         0qLm8kfXUFYgf4dXNG6SW+ER4jWu3KcBNOX5Z5rVHepsqGfcOyWAYGwoW/1scNNWMmCX
         rJjthb05E5cEzrU7/e2F4UHqgjiPs0OSjZ/dIE2Gxs+56kbznt45dpOYE4W3K2g2ftnK
         rhmOQs8++mURWC0q9gJkgVtHazLQRJjOMRhJsXk76QMeWHbH1TV0qhpyNi+mHKQYow0s
         AlSrSto1iQK9Och9PepOI3B/xUWkDbPge6A+xg2jwrbXLNerdTrY0gqXIKesLwLjPCgD
         m5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzHWDiN1Wjk8roHrncU6culKFNwJPo7qFVNBejhbdf4=;
        b=CK5ldUaSpJqPpRewqFRIeodTb/bl2zLOSveRXWtPABkhc1ii98iCq4U+IduJs+Wpf+
         msQ0sdDfQlC3XcLos/HIPfPiSMwfAHBSZKbfrjTXssQj0c2dVRWCw/BMvplrqMb/1hUC
         IkJUlPRpY1fQ/0wlqxt7Evv0Um2s+vAuePKA69yERijmElSWvqMbiRFSijp2nJLqxfED
         HSF7m8jcYDg8jm5NC2UxAmAhsEbSMr2yoCbapU3sQM+F/oRPeQmVEQAMY0FDlAGP2qzT
         tfh+ZHJKjAHFMUqmmoedGzIzW+JXWSpGZlbSXmiAjEWFIuLNjvQ4OyYmrzbW0eKWQirZ
         LzFA==
X-Gm-Message-State: AOAM530eK54wR4KTUOdXidpCBXZgGoyO2u+XLcC6e5D3RJFCMru9dAnR
        to8IZwtfSwQ9r7xGVk1lDebS3g==
X-Google-Smtp-Source: ABdhPJwYiv6IgPM0+CkEXm5L8017kKc4FDmNfsfG7B94lYbTSJr4sXxzel32KW9uR7kI3Wh+OC61tQ==
X-Received: by 2002:a17:90a:8c08:: with SMTP id a8mr7312649pjo.136.1617256876819;
        Wed, 31 Mar 2021 23:01:16 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id a6sm4037328pfc.61.2021.03.31.23.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:01:16 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: [PATCH v4 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
Date:   Thu,  1 Apr 2021 14:00:52 +0800
Message-Id: <20210401060054.40788-5-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401060054.40788-1-greentime.hu@sifive.com>
References: <20210401060054.40788-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe host controller DT bindings of SiFive FU740.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 .../bindings/pci/sifive,fu740-pcie.yaml       | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
new file mode 100644
index 000000000000..ccb58e5f06d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sifive,fu740-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive FU740 PCIe host controller
+
+description: |+
+  SiFive FU740 PCIe host controller is based on the Synopsys DesignWare
+  PCI core. It shares common features with the PCIe DesignWare core and
+  inherits common properties defined in
+  Documentation/devicetree/bindings/pci/designware-pcie.txt.
+
+maintainers:
+  - Paul Walmsley <paul.walmsley@sifive.com>
+  - Greentime Hu <greentime.hu@sifive.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: sifive,fu740-pcie
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: mgmt
+
+  num-lanes:
+    const: 8
+
+  msi-parent: true
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: inta
+      - const: intb
+      - const: intc
+      - const: intd
+
+  resets:
+    description: A phandle to the PCIe power up reset line.
+
+  pwren-gpios:
+    description: Should specify the GPIO for controlling the PCI bus device power on.
+    maxItems: 1
+
+required:
+  - dma-coherent
+  - num-lanes
+  - interrupts
+  - interrupt-names
+  - interrupt-parent
+  - interrupt-map-mask
+  - interrupt-map
+  - clock-names
+  - clocks
+  - resets
+  - pwren-gpios
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        #include <dt-bindings/clock/sifive-fu740-prci.h>
+
+        pcie@e00000000 {
+            compatible = "sifive,fu740-pcie";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            reg = <0xe 0x00000000 0x0 0x80000000>,
+                  <0xd 0xf0000000 0x0 0x10000000>,
+                  <0x0 0x100d0000 0x0 0x1000>;
+            reg-names = "dbi", "config", "mgmt";
+            device_type = "pci";
+            dma-coherent;
+            bus-range = <0x0 0xff>;
+            ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000>,      /* I/O */
+                     <0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000>,    /* mem */
+                     <0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000>,    /* mem */
+                     <0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
+            num-lanes = <0x8>;
+            interrupts = <56>, <57>, <58>, <59>, <60>, <61>, <62>, <63>, <64>;
+            interrupt-names = "msi", "inta", "intb", "intc", "intd";
+            interrupt-parent = <&plic0>;
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
+                            <0x0 0x0 0x0 0x2 &plic0 58>,
+                            <0x0 0x0 0x0 0x3 &plic0 59>,
+                            <0x0 0x0 0x0 0x4 &plic0 60>;
+            clock-names = "pcie_aux";
+            clocks = <&prci PRCI_CLK_PCIE_AUX>;
+            resets = <&prci 4>;
+            pwren-gpios = <&gpio 5 0>;
+            reset-gpios = <&gpio 8 0>;
+        };
+    };
-- 
2.30.2

