Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5558832B1C7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbhCCB4m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbhCBLDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Mar 2021 06:03:43 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1DC061225
        for <linux-pci@vger.kernel.org>; Tue,  2 Mar 2021 02:59:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id ba1so11834334plb.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Mar 2021 02:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z/dfY5xm4k/Ul+cKsSCbJO/Eur+ApLPQXMui9RQwcuI=;
        b=GZ9t4ppqMF94bhg6elVg2uI0iomTwMiSRcHzvkR9zSMm+wTZsLhmeyirh4naLkS6vT
         9Ra7yLccS11NjADG/wAJAPuLyUPdkNSJc/9PzsDHO1rN6ex4G6PpakY2bnUu93OoXbdr
         g37yzmr9uGwpfEWGlfe6EMNL6UgUZQzmqUnNJ6E0Lzmksr0ZL2Udu8qnq4F2XwWnEXJ1
         lpHmclksU91BQ/OFtMqGqZlktpq/+XzFxA2h4v2Z1lh9EeRkH4WwewGrRIUN5uzso7sO
         plDypcr0SIJNWCzk/hjdQ3MGCwzE4RRHK35CCPst+2GBg35XylaqHX2cWNNMoVXTsJjz
         2vKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/dfY5xm4k/Ul+cKsSCbJO/Eur+ApLPQXMui9RQwcuI=;
        b=I0UFZJvJIulvodQhKYvCeWvP9Ax6lAbxF7ilctKQTtkvWc72+KLbgHODtKW9oTBg61
         p0TTfc3HuOCC45DdyGT/q7JCzya1Vto1SDNvIGwgSy9mqDRnKKxt/lZJdSn8MR9t5+f6
         8BJIEJdkvsmV4/rh/NLR0Donb3JnzdpQvTJGMOH4tabLSkeB7AXm+4SHLnOEgZrD+ZlA
         cung5gQiDPd2N27fz4f8HQCSYCCVmNqGMzFIl2ojP31x48LrspVCkXGHNth3r7T/JJMM
         fIVBiYybC1NFcPDVXMpx6HqVLBi2zLW+OCSCtnq0brRSmROERaU4ZKjnsZdG94rbvrri
         fPRQ==
X-Gm-Message-State: AOAM5300o9e8EVhPVUabCbeb1FpewC8I0dINiOyB1m/QRbk83QcTuCpB
        RHe7+W/4xQHyX90hDJUkbxeCB7vyvEKfH4K1
X-Google-Smtp-Source: ABdhPJwuKmQiaA5v9dnOg9LHFYrm5ScBlxWQ0x/TG427VEY8lO0BNwTeKjkzgLULJAucs458UBppKQ==
X-Received: by 2002:a17:903:1cd:b029:e5:b98e:a29 with SMTP id e13-20020a17090301cdb02900e5b98e0a29mr1293206plh.22.1614682783498;
        Tue, 02 Mar 2021 02:59:43 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id t26sm19500451pfq.208.2021.03.02.02.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:59:43 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
Date:   Tue,  2 Mar 2021 18:59:15 +0800
Message-Id: <4e63c5515f9755d0cf4cd65ab70048554d917d89.1614681831.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614681831.git.greentime.hu@sifive.com>
References: <cover.1614681831.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe host controller DT bindings of SiFive FU740.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 .../bindings/pci/sifive,fu740-pcie.yaml       | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
new file mode 100644
index 000000000000..879ab4f80456
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sifive,fu740-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive fu740 PCIe host controller
+
+description: |
+  SiFive fu740 PCIe host controller is based on the Synopsys DesignWare
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
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: mgmt
+
+  device_type:
+    const: pci
+
+  dma-coherent:
+    description: Indicates that the PCIe IP block can ensure the coherency
+
+  bus-range:
+    description: Range of bus numbers associated with this controller.
+
+  num-lanes: true
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
+    description: A phandle to the PCIe power up reset line
+
+  pwren-gpios:
+    description: Should specify the GPIO for controlling the PCI bus device power on
+
+  perstn-gpios:
+    description: Should specify the GPIO for controlling the PCI bus device reset
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - device_type
+  - dma-coherent
+  - bus-range
+  - ranges
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
+  - perstn-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie@e00000000 {
+        #address-cells = <3>;
+        #interrupt-cells = <1>;
+        #size-cells = <2>;
+        compatible = "sifive,fu740-pcie";
+        reg = <0xe 0x00000000 0x1 0x0
+               0xd 0xf0000000 0x0 0x10000000
+               0x0 0x100d0000 0x0 0x1000>;
+        reg-names = "dbi", "config", "mgmt";
+        device_type = "pci";
+        dma-coherent;
+        bus-range = <0x0 0xff>;
+        ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000        /* I/O */
+                  0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000      /* mem */
+                  0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000      /* mem */
+                  0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
+        num-lanes = <0x8>;
+        interrupts = <56 57 58 59 60 61 62 63 64>;
+        interrupt-names = "msi", "inta", "intb", "intc", "intd";
+        interrupt-parent = <&plic0>;
+        interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+        interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
+                        <0x0 0x0 0x0 0x2 &plic0 58>,
+                        <0x0 0x0 0x0 0x3 &plic0 59>,
+                        <0x0 0x0 0x0 0x4 &plic0 60>;
+	clock-names = "pcie_aux";
+        clocks = <&prci PRCI_CLK_PCIE_AUX>;
+        resets = <&prci 4>;
+        pwren-gpios = <&gpio 5 0>;
+        perstn-gpios = <&gpio 8 0>;
+    };
-- 
2.30.0

