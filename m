Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661A4E9AFF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiC1P0M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbiC1PZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 11:25:56 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97A0622511;
        Mon, 28 Mar 2022 08:24:12 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E8D6439CB7F;
        Thu, 24 Mar 2022 04:37:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru E8D6439CB7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085869;
        bh=m8ge0j6w4fRAgO0H2GK3vu1XJo7cjeYZ3gyjCgKpYsU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=DH/Rx6Dv2DjwVmAzQqG46IqfTWJFJbqbJLmjGn+drbXwkWlxHSkMBKmjLEWxxnrN9
         +kt2hd3Mn9d4anaXG9Eepiw5ctJkwQgParNUXPoPYhh8KxlNiatNhPHVvOWhNkKyQR
         xDamXL1osg6JfoTJSeuMVdoAW93Rh9ryX+rvXaVg=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:37:48 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH 01/16] dt-bindings: PCI: dwc: Define generic and native DT bindings
Date:   Thu, 24 Mar 2022 04:37:19 +0300
Message-ID: <20220324013734.18234-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently both DW PCIe Root Port and End-point DT bindings are too generic
to be used as a descriptive set the device properties. Yes, it's very handy
to have them that way so the DT-schemas could be used to evaluate as many
DW PCIe-related DT-nodes as possible. But at the same time they don't
provide well defined DW PCIe RP/EP DT interface description thus leaving
too much flexibility for the new platforms, no encouraging the developers
to preserve a compatible interface.

Instead of currently implemented approach we suggest to be more
restrictive and yet preserve some level of flexibility in the DW PCIe
DT-bindings description. The device tree DT-schema is split up into
three parts: a common YAML-schema applicable for both DWC Root Port and
End-point controller configs, DWC PCIe Root Port-specific YAML-schema
and DWC PCIe End-point-specific YAML-schema, where
1) pci/snps,dw-pcie-common.yaml - The common DT-schema describes the most
generic constraints of the "reg", "interrupts", "clocks", "resets" and
"phys" properties together with a set of common for both device types
PCIe/AXI bus properties like a maximum number of lanes or a maximum link
speed, number of inbound and outbound iATU windows. In addition to that a
set of schema definitions declared under the "$defs" property with "reg",
"interrupt", "clock" and "reset" names common for DWC PCIe Root Port and
End-point devices. They can be used by the successive DT-schemas in case
they are supposed to be compatible with the generic DWC PCIe controller
DT-bindings.
2) pci/snps,dw-pcie.yaml, pci/snps,dw-pcie-ep.yaml - generic DW PCIe Root
Port and End-point DT-bindings which aside with the device-specific
properties set also contain more restrictive constraints. All new DW PCIe
platforms are supposed to be compatible with one of these bindings by
using "allOf: " property and additionally defining their own constraints
to close up the DT-bindings set.

So to speak in case if a DW PCIe-based device for some reason has too many
specific properties or it's bindings have already been defined in a
non-generic way, it's DT-schema is supposed to include 1) YAML-file and
provide its own constraints. Otherwise the ready-to-use bindings from 2)
should be utilized. There only two DT-schemas compatible with 2) at the
moment are samsung,axynos-pcie.yaml and intel-gw-pcie.yaml. The
rest of the DW PCIe-related DT-schemas are supposed to use more generic
DW PCIe DT-bindings - pci/snps,dw-pcie-common.yaml.

Note the provided here generic properties and their possible values are
derived from the DW PCIe RC/EP hardware manuals and from the interface
implemented in the driver. The DT-bindings schemas are created to be as
full as possible with detailed properties/names description for the
easier interface comprehension and new platforms bindings development.

Also note since there are no generic DT-nodes can be found in the kernel
dts-es which would have a pure "snps,dw-pcie" compatible string, these
DT-bindings have been created to not be selected by default for
evaluation. They are supposed to be used by the new vendor-specific
DT-schemas to at least stop adding new bindings for the same set of DWC
PCIe signals or properties.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Rob, if you comment the "select: false" line out you'll get a lot of "'*'
is not of type 'array'" errors on the dt_bindings_check command execution.
I have spend tons of time trying to figure out what was wrong, but still
failed to find out a solution. For some reason the "$ref"-ed schemas
defined under the "$defs" basic property are considered by the parser as
defining an array. No matter whether I specified the "type: string"
keyword or not, as long as there is "enum" or "oneOf" keyword used in the
"*-names" property definition in "$defs" it's considered as describing an
array thus causing the errors like:

>  DTC     Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dt.yaml
>  CHECK   Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dt.yaml
> /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: reg-names:0: 'oneOf' conditional failed, one must be fixed:
>        'dbi' is not of type 'array'
>        From schema: /.../snps,dw-pcie.yaml
> /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: reg-names:1: 'oneOf' conditional failed, one must be fixed:
>         'config' is not of type 'array'
>         From schema: /.../snps,dw-pcie.yaml
> /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'anyOf' conditional failed, one must be fixed:
>         /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'oneOf' conditional failed, one must be fixed:
>                 'msi' is not of type 'array'
>         /../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'oneOf' conditional failed, one must be fixed:
>                 'msi' is not of type 'array'
>         From schema: /.../snps,dw-pcie.yaml

As soon as I manually moved the same "$defs"-schemas into the places they
are referenced to, the errors disappeared and the DT-schemas validation
worked as expected by the semantics.

As I see it there must be some bug in the parser, otherwise I am out of
ideas how to implement the suggested in this patch design pattern. Rob,
could you take a look at the DT-schemas and help me out with debugging the
problem described above?
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          |   5 +-
 .../bindings/pci/hisilicon,kirin-pcie.yaml    |   4 +-
 .../bindings/pci/sifive,fu740-pcie.yaml       |   4 +-
 .../bindings/pci/snps,dw-pcie-common.yaml     | 298 ++++++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 143 ++++++---
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 189 +++++++----
 .../bindings/pci/toshiba,visconti-pcie.yaml   |   2 +-
 7 files changed, 524 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 643a6333b07b..ccb5cfdf869f 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -12,10 +12,11 @@ maintainers:
 
 description: |+
   This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
+  and thus inherits all the common properties defined in
+  snps,dw-pcie-common.yaml.
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index c9f04999c9cf..879d9ec41cb7 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -14,10 +14,10 @@ description: |
   Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
   It shares common functions with the PCIe DesignWare core driver and
   inherits common properties defined in
-  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
+  Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml.
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
index 392f0ab488c2..437614257935 100644
--- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -10,14 +10,14 @@ description: |+
   SiFive FU740 PCIe host controller is based on the Synopsys DesignWare
   PCI core. It shares common features with the PCIe DesignWare core and
   inherits common properties defined in
-  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
+  Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml.
 
 maintainers:
   - Paul Walmsley <paul.walmsley@sifive.com>
   - Greentime Hu <greentime.hu@sifive.com>
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
new file mode 100644
index 000000000000..27fe1f5c450f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -0,0 +1,298 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/snps,dw-pcie-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DWC PCIe RP/EP controller
+
+maintainers:
+  - Jingoo Han <jingoohan1@gmail.com>
+  - Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+
+properties:
+  reg:
+    description:
+      DWC PCIe CSR space is normally accessed over the dedicated Data Bus
+      Interface - DBI. In accordance with the reference manual the register
+      configuration space belongs to the Configuration-Dependent Module (CDM)
+      and is split up into several sub-parts Standard PCIe configuration
+      space, Port Logic Registers (PL), Shadow Config-space Registers,
+      iATU/eDMA registers. The particular sub-space is selected by the
+      CDM/ELBI (dbi_cs) and CS2 (dbi_cs2) signals (selector bits). Such
+      configuration provides a flexible interface for the system engineers to
+      either map the particular space at a desired MMIO address or just leave
+      them in a contiguous memory space if pure Native or AXI Bridge DBI access
+      is selected. Note the PCIe CFG-space, PL and Shadow registers are
+      specific to each activated function, while the rest of the sub-spaces
+      are common for all of them (if there are more than one).
+    minItems: 2
+    maxItems: 6
+
+  interrupts:
+    description:
+      There are two main sub-blocks which are normally capable of
+      generating interrupts. It's System Information Interface and MSI
+      interface. While the former one has some common for the Host and
+      End-point controllers IRQ-signals, the later interface is obviously
+      Root Complex specific since it's responsible for the incoming MSI
+      messages signalling. The System Information IRQ signals are mainly
+      responsible for reporting the generic PCIe hierarchy and Root
+      Complex events like VPD IO request, general AER, PME, Hot-plug, link
+      bandwidth change, link equalization request, INTx asserted/deasserted
+      Message detection, embedded DMA Tx/Rx/Error.
+    minItems: 1
+    maxItems: 26
+
+  clocks:
+    description:
+      DWC PCIe reference manual explicitly defines a set of the clocks required
+      to get the controller working correctly. In general all of them can
+      be divided into two groups':' application and core clocks. Note the
+      platforms may have some of the clock sources unspecified in case if the
+      corresponding domains are fed up from a common clock source.
+    minItems: 1
+    maxItems: 7
+
+  resets:
+    description:
+      DWC PCIe reference manual explicitly defines a set of the reset
+      signals required to be de-asserted to properly activate the controller
+      sub-parts. All of these signals can be divided into two sub-groups':'
+      application and core resets with respect to the main sub-domains they
+      are supposed to reset. Note the platforms may have some of these signals
+      unspecified in case if they are automatically handled or aggregated into
+      a comprehensive control module.
+    minItems: 1
+    maxItems: 10
+
+  reset-gpio:
+    deprecated: true
+    description:
+      Reference to the GPIO-controlled PERST# signal. It is used to reset all
+      the peripheral devices available on the PCIe bus.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Reference to the GPIO-controlled PERST# signal. It is used to reset all
+      the peripheral devices available on the PCIe bus.
+    maxItems: 1
+
+  phys:
+    description:
+      There can be up to number of possible lanes PHYs specified.
+      Obviously each specified PHY is supposed to be able to work in the
+      PCIe mode with a speed implied by the DWC PCIe controller it is
+      attached to.
+    minItems: 1
+    maxItems: 16
+
+  phy-names:
+    minItems: 1
+    maxItems: 16
+    items:
+      pattern: '^pcie([0-9]+|-?phy)?$'
+
+  num-lanes:
+    maximum: 16
+
+  max-link-speed:
+    maximum: 4
+
+  num-ob-windows:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Number of outbound address translation windows. This parameter can be
+      auto-detected based on the iATU memory writability. So there is no
+      point in having a dedicated DT-property for it.
+    maximum: 256
+
+  num-ib-windows:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Number of inbound address translation windows. In the same way as
+      for the outbound AT windows, this parameter can be auto-detected based
+      on the iATU memory writability. There is no point having a dedicated
+      DT-property for it either.
+    maximum: 256
+
+  num-viewport:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Number of outbound view ports configured in hardware. It's the same as
+      the number of outbound AT windows.
+    maximum: 256
+
+  snps,enable-cdm-check:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable automatic checking of CDM (Configuration Dependent Module)
+      registers for data corruption. CDM registers include standard PCIe
+      configuration space registers, Port Logic registers, DMA and iATU
+      registers. This feature has been available since DWC PCIe v4.80a.
+
+additionalProperties: true
+
+$defs:
+  reg-names:
+    description:
+      CSR space names common for the DWC PCIe Root Port and End-point
+      controllers.
+    oneOf:
+      - description:
+          Basic DWC PCIe controller configuration-space accessible over
+          the DBI interface. This memory space is either activated with
+          the CDM/ELBI = 0 and CS2 = 0 or is a contiguous memory region
+          with all spaces. Note iATU/eDMA CSRs are indirectly accessible
+          via the PL viewports on the DWC PCIe controllers older than
+          v4.80a.
+        const: dbi
+      - description:
+          Shadow DWC PCIe config-space registers. This space is selected
+          by setting CDM/ELBI = 0 and CS2 = 1. This is an intermix of
+          the PCI-SIG PCIe CFG-space with the shadow registers for some
+          PCI Header space, PCI Standard and Extended Structures. It's
+          mainly relevant for the end-point controller configuration,
+          but still there are some shadow registers available for the
+          Root Port mode too.
+        const: dbi2
+      - description:
+          External Local Bus registers. It's an application-dependent
+          registers normally defined by the platform engineers, which
+          are selected by setting CDM/ELBI = 1 and CS2 = 0.
+        enum: [ elbi, appl, app ]
+      - description:
+          iATU/eDMA registers common for all device functions. It's an
+          unrolled memory space with the internal Address Translation
+          Unit and Enhanced DMA, which is selected by setting CDM/ELBI = 1
+          and CS2 = 1. For IP-core releases prior v4.80a, these registers
+          have been programmed via an indirect addressing scheme using a
+          set of viewport CSRs mapped into the PL space. Note iATU is
+          normally mapped to the 0x0 address of this region, while eDMA
+          is available at 0x80000 base address.
+        enum: [ atu, atu_dma ]
+      - description:
+          Outbound iATU-available memory-region which usage scenario
+          depends on the DWC PCIe controller being either Root Port or
+          End-point. If it's Root Port then the register space shall
+          have the "config" name and it will be used to access the
+          peripheral PCIe devices configuration space. If it's PCIe
+          end-point controller, then the region shall be named as
+          "addr_space" and it will be used to generate various traffic
+          on the PCIe bus hierarchy. It's usage scenario depends on the
+          end-point functionality, for instance it can be used to create
+          MSI(X) messages.
+        enum: [ config, addr_space ]
+      - description:
+          PHY/PCS configuration registers. Some platforms can have the
+          PCS and PHY CSRs accessible over a dedicated memory mapped
+          region, but mainly these registers are indirectly accessible
+          either by means of the embedded PHY viewport schema or by some
+          platform-specific method.
+        enum: [ link, phy ]
+
+  interrupt-names:
+    description:
+      IRQ signal names common for the DWC PCIe Root Port and End-point
+      controllers.
+    oneOf:
+      - description:
+          Controller request to read or write virtual product data
+          from/to the VPD capability registers.
+        const: vpd
+      - description:
+          Link Equalization Request flag is set in the Link Status 2
+          register (applicable if the corresponding IRQ is enabled in
+          the Link Control 3 register).
+        const: l_eq
+      - description:
+          Indicates that the eDMA Tx/Rx transfer is complete or that an
+          error has occurred on the corresponding channel. eDMA can have
+          eight Tx (Write) and Rx (Read) eDMA channels thus supporting up
+          to 16 IRQ signals all together. Write eDMA channels shall go
+          first in the ordered row as per default edma_int[*] bus setup.
+        pattern: '^dma([0-9]|1[0-5])?$'
+      - description:
+          PCIe protocol correctable error or a Data Path protection
+          correctable error is detected by the automotive/safety
+          feature.
+        const: sft_ce
+      - description:
+          Indicates that the internal safety mechanism detected and
+          uncorrectable error.
+        const: sft_ue
+
+  clock-names:
+    description:
+      Reference clock names common for the DWC PCIe Root Port and End-point
+      controllers.
+    anyOf:
+      - description:
+          Data Bus Interface (DBI) clock. Clock signal for the AXI-bus
+          interface of the Configuration-Dependent Module, which is
+          basically the set of the controller CSRs.
+        enum: [ dbi, pcie ]
+      - description:
+          Application AXI-bus Master interface clock. Basically this is
+          a clock for the controller DMA interface (PCI-to-CPU).
+        enum: [ mstr, pcie_bus ]
+      - description:
+          Application AXI-bus Slave interface clock. This is a clock for
+          the CPU-to-PCI memory IO interface.
+        enum: [ slv, pcie_bus ]
+      - description:
+          Controller Core-PCS PIPE interface clock. It's normally
+          supplied by an external PCS-PHY.
+        const: pipe
+      - description:
+          Controller Primary clock. It's assumed that all controller input
+          signals (except resets) are synchronous to this clock.
+        const: core
+      - description:
+          Auxiliary clock for the controller PMC domain. The controller
+          partitioning implies having some parts to operate with this
+          clock in some power management states.
+        const: aux
+      - description:
+          Generic reference clock. In case if there are several
+          interfaces fed up with a common clock source it's advisable to
+          define it with this name (for instance pipe, core and aux can
+          be connected to a single source of the periodic signal).
+        const: ref
+      - description:
+          Clock for the PHY registers interface. Originally this is
+          a PHY-viewport-based interface, but some platform may have
+          specifically designed one.
+        const: phy_reg
+
+  reset-names:
+    description:
+      Reset signal names common for the DWC PCIe Root Port and End-point
+      controllers.
+    anyOf:
+      - description: Data Bus Interface (DBI) domain reset
+        const: dbi
+      - description: AXI-bus Master interface reset
+        const: mstr
+      - description: AXI-bus Slave interface reset
+        const: slv
+      - description: Controller Non-sticky CSR flags reset
+        const: non-sticky
+      - description: Controller sticky CSR flags reset
+        const: sticky
+      - description: PIPE-interface (Core-PCS) logic reset
+        const: pipe
+      - description:
+          Controller primary reset (resets everything except PMC module)
+        const: core
+      - description: PCS/PHY block reset
+        const: phy
+      - description: PMC hot reset signal
+        const: hot
+      - description: Cold reset signal
+        const: pwr
+...
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index e59059ab5be0..c3bbe90264dc 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -13,74 +13,115 @@ maintainers:
 description: |
   Synopsys DesignWare PCIe host controller endpoint
 
+# Please create a separate DT-schema for the particular DWC PCIe End-point
+# controller and make sure it's assigned with the vendor-specific
+# compatible string together with the generic Synopsys DWC PCIe strings so
+# the bindings would be successfully evaluated against this schema.
+select: false
+
 allOf:
   - $ref: /schemas/pci/pci-ep.yaml#
+  - $ref: snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
-    anyOf:
-      - {}
-      - const: snps,dw-pcie-ep
+    contains:
+      oneOf:
+        - description:
+            DWC PCIe End-point controller (IP-core version is explicitly
+            specified in the additional compatible string)
+          items:
+            - pattern: '^snps,dw-pcie-ep-[0-9]+\.[0-9]+a?$'
+            - const: snps,dw-pcie-ep
+        - description:
+            DWC PCIe End-point controller (IP-core version is either unknown
+            or can be read from the PCIe version register of the PL reg-space)
+          const: snps,dw-pcie-ep
 
   reg:
-    description: |
-      It should contain Data Bus Interface (dbi) and config registers for all
-      versions.
-      For designware core version >= 4.80, it may contain ATU address space.
-    minItems: 2
-    maxItems: 4
+    description:
+      DBI, DBI2 reg-spaces and outbound memory window are required for the
+      normal controller functioning. iATU memory IO region is also required
+      if the space is unrolled (IP-core version >= 4.80a).
+    minItems: 3
+    maxItems: 5
 
   reg-names:
-    minItems: 2
-    maxItems: 4
+    minItems: 3
+    maxItems: 5
     items:
-      enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
-
-  reset-gpio:
-    description: GPIO pin number of PERST# signal
-    maxItems: 1
-    deprecated: true
-
-  reset-gpios:
-    description: GPIO controlled connection to PERST# signal
-    maxItems: 1
-
-  snps,enable-cdm-check:
-    type: boolean
-    description: |
-      This is a boolean property and if present enables
-      automatic checking of CDM (Configuration Dependent Module) registers
-      for data corruption. CDM registers include standard PCIe configuration
-      space registers, Port Logic registers, DMA and iATU (internal Address
-      Translation Unit) registers.
-
-  num-ib-windows:
-    description: number of inbound address translation windows
-    maxItems: 1
-    deprecated: true
-
-  num-ob-windows:
-    description: number of outbound address translation windows
-    maxItems: 1
-    deprecated: true
+      $ref: snps,dw-pcie-common.yaml#/$defs/reg-names
+    allOf:
+      - contains:
+          const: dbi
+      - contains:
+          const: dbi2
+      - contains:
+          const: addr_space
+
+  interrupts:
+    description:
+      There is no mandatory IRQ signals for the normal controller functioning,
+      but in addition to the native set the platforms may have a link- or
+      PM-related IRQs specified.
+    minItems: 1
+    maxItems: 20
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 20
+    items:
+      $ref: snps,dw-pcie-common.yaml#/$defs/interrupt-names
+
+  clocks:
+    minItems: 1
+    maxItems: 7
+
+  clock-names:
+    minItems: 1
+    maxItems: 7
+    items:
+      $ref: snps,dw-pcie-common.yaml#/$defs/clock-names
+
+  resets:
+    minItems: 1
+    maxItems: 10
+
+  reset-names:
+    minItems: 1
+    maxItems: 10
+    items:
+      $ref: snps,dw-pcie-common.yaml#/$defs/reset-names
+
+  max-functions:
+    maximum: 32
 
 required:
+  - compatible
   - reg
   - reg-names
-  - compatible
 
 additionalProperties: true
 
 examples:
   - |
-    bus {
-      #address-cells = <1>;
-      #size-cells = <1>;
-      pcie-ep@dfd00000 {
-        compatible = "snps,dw-pcie-ep";
-        reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
-              <0xdfc01000 0x0001000>, /* IP registers 2 */
-              <0xd0000000 0x2000000>; /* Configuration space */
-        reg-names = "dbi", "dbi2", "addr_space";
-      };
+    pcie-ep@1f052000 {
+      compatible = "vendor,soc-pcie", "snps,dw-pcie-ep-4.60a", "snps,dw-pcie-ep";
+      reg = <0x66000000 0x1000>, <0x66010000 0x10000>, <0x67000000 0x400000>;
+      reg-names = "dbi", "dbi2", "addr_space";
+
+      clocks = <&sys_clk 12>, <&sys_clk 24>;
+      clock-names = "dbi", "ref";
+
+      resets = <&sys_rst 12>, <&sys_rst 24>;
+      reset-names = "dbi", "phy";
+
+      phys = <&pcie_phy>;
+      phy-names = "pcie-phy";
+
+      num-lanes = <4>;
+      max-link-speed = <4>;
+      num-ib-windows = <16>;
+      num-ob-windows = <16>;
     };
+...
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index a5345c494744..6c397ae3c71a 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -13,20 +13,36 @@ maintainers:
 description: |
   Synopsys DesignWare PCIe host controller
 
+# Please create a separate DT-schema for the particular DWC PCIe Root Port
+# controller and make sure it's assigned with the vendor-specific
+# compatible string together with the generic Synopsys DWC PCIe strings so
+# the bindings would be successfully evaluated against this schema.
+select: false
+
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
-    anyOf:
-      - {}
-      - const: snps,dw-pcie
+    contains:
+      oneOf:
+        - description:
+            DWC PCIe Root Port controller (IP-core version is explicitly
+            specified in the additional compatible string)
+          items:
+            - pattern: '^snps,dw-pcie-[0-9]+\.[0-9]+a?$'
+            - const: snps,dw-pcie
+        - description:
+            DWC PCIe Root Port controller (IP-core version is either unknown
+            or can be read from the PCIe version register of the PL reg-space)
+          const: snps,dw-pcie
 
   reg:
-    description: |
-      It should contain Data Bus Interface (dbi) and config registers for all
-      versions.
-      For designware core version >= 4.80, it may contain ATU address space.
+    description:
+      At least DBI reg-space and peripheral devices CFG-space outbound window
+      are required for the normal controller work. iATU memory IO region is
+      also required if the space is unrolled (IP-core version >= 4.80a).
     minItems: 2
     maxItems: 5
 
@@ -34,69 +50,116 @@ properties:
     minItems: 2
     maxItems: 5
     items:
-      enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
-              ulreg, smu, mpu, apb, phy ]
-
-  num-lanes:
-    description: |
-      number of lanes to use (this property should be specified unless
-      the link is brought already up in firmware)
-    maximum: 16
-
-  reset-gpio:
-    description: GPIO pin number of PERST# signal
-    maxItems: 1
-    deprecated: true
-
-  reset-gpios:
-    description: GPIO controlled connection to PERST# signal
-    maxItems: 1
-
-  interrupts: true
-
-  interrupt-names: true
-
-  clocks: true
-
-  snps,enable-cdm-check:
-    type: boolean
-    description: |
-      This is a boolean property and if present enables
-      automatic checking of CDM (Configuration Dependent Module) registers
-      for data corruption. CDM registers include standard PCIe configuration
-      space registers, Port Logic registers, DMA and iATU (internal Address
-      Translation Unit) registers.
+      $ref: snps,dw-pcie-common.yaml#/$defs/reg-names
+    allOf:
+      - contains:
+          const: dbi
+      - contains:
+          const: config
+
+  interrupts:
+    description:
+      At least MSI interrupt signal is supposed to be specified for
+      the DWC PCIe host controller.
+    minItems: 1
+    maxItems: 26
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 26
+    items:
+      anyOf:
+        - $ref: snps,dw-pcie-common.yaml#/$defs/interrupt-names
+        - $ref: '#/$defs/interrupt-names'
+    allOf:
+      - contains:
+          const: msi
+
+  clocks:
+    minItems: 1
+    maxItems: 7
+
+  clock-names:
+    minItems: 1
+    maxItems: 7
+    items:
+      $ref: snps,dw-pcie-common.yaml#/$defs/clock-names
 
-  num-viewport:
-    description: |
-      number of view ports configured in hardware. If a platform
-      does not specify it, the driver autodetects it.
-    deprecated: true
+  resets:
+    minItems: 1
+    maxItems: 10
 
-additionalProperties: true
+  reset-names:
+    minItems: 1
+    maxItems: 10
+    items:
+      $ref: snps,dw-pcie-common.yaml#/$defs/reset-names
 
 required:
+  - compatible
   - reg
   - reg-names
-  - compatible
+  - interrupts
+  - interrupt-names
+
+additionalProperties: true
+
+$defs:
+  interrupt-names:
+    description:
+      DWC PCIe Root Port/Complex specific IRQ signal names.
+    oneOf:
+      - description:
+          DSP AXI MSI Interrupt detected. It gets de-asserted when there is
+          no more MSI interrupt pending. The interrupt is relevant to the
+          iMSI-RX - Integrated MSI Receiver (AXI bridge).
+        const: msi
+      - description:
+          Error condition detected and a bit is set in the Root Error Status
+          register of the AER capability. It's asserted when the RC
+          internally generated an error or an error message is received by
+          the RC.
+        const: aer
+      - description:
+          PME message is received by the port. That means having the PME
+          status bit set in the Root Status register (the event is
+          supposed to be unmasked in the Root Control register).
+        const: pme
+      - description:
+          Hot-plug event is detected. That is a bit has been set in the
+          Slot Status register and the corresponding event is enabled in
+          the Slot Control register.
+        const: hp
+      - description:
+          Link Autonomous Bandwidth Status flag has been set in the Link
+          Status register (the event is supposed to be unmasked in the
+          Link Control register).
+        const: bw_au
+      - description:
+          Bandwidth Management Status flag has been set in the Link
+          Status register (the event is supposed to be unmasked in the
+          Link Control register).
+        const: bw_mg
 
 examples:
   - |
-    bus {
-      #address-cells = <1>;
-      #size-cells = <1>;
-      pcie@dfc00000 {
-        device_type = "pci";
-        compatible = "snps,dw-pcie";
-        reg = <0xdfc00000 0x0001000>, /* IP registers */
-              <0xd0000000 0x0002000>; /* Configuration space */
-        reg-names = "dbi", "config";
-        #address-cells = <3>;
-        #size-cells = <2>;
-        ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
-                 <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
-        interrupts = <25>, <24>;
-        #interrupt-cells = <1>;
-        num-lanes = <1>;
-      };
+    pcie@1f052000 {
+      compatible = "vendor,soc-pcie", "snps,dw-pcie-4.60a", "snps,dw-pcie";
+      device_type = "pci";
+      reg = <0x1f052000 0x1000>, <0x1bdbf000 0x1000>;
+      reg-names = "dbi", "config";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0x00000000 0x1bdb0000 0 0x00008000>,
+               <0x82000000 0 0x20000000 0x08000000 0 0x13db0000>;
+      bus-range = <0x0 0xff>;
+
+      interrupts = <0 80 4>;
+      interrupt-names = "msi";
+
+      reset-gpios = <&port0 0 1>;
+
+      num-lanes = <4>;
+      max-link-speed = <3>;
     };
+...
diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
index 30b6396d83c8..f0a3c436c6d1 100644
--- a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
@@ -13,7 +13,7 @@ description:
   Toshiba Visconti5 SoC PCIe host controller is based on the Synopsys DesignWare PCIe IP.
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
-- 
2.35.1

