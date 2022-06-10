Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4A5460FB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347387AbiFJJGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348415AbiFJJGK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:06:10 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F871E82A0;
        Fri, 10 Jun 2022 02:05:13 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 41B9616AB;
        Fri, 10 Jun 2022 11:58:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 41B9616AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851486;
        bh=LK/KQIK47NI/dK7xufslLw+tGML3X3ct2BzUNZLG4SM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=N+b0GxMthZCkvrl+OSCpXx905lgKt1YBTQNJLY0gdx+uw2ATjULmNRToKwS8yL9Ix
         AiSNj2oSgxRWIex/3ZXEgm1YtdXufHS6Cr7C2qCwFYrwKMaN5/W72R5TA1Tzl9HDrd
         Rxh3+OWpMaIqdf8+d+/mcQi2of2DxtnLzvn3DAQQ=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:12 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 05/17] dt-bindings: PCI: dwc: Stop selecting generic bindings by default
Date:   Fri, 10 Jun 2022 11:56:53 +0300
Message-ID: <20220610085706.15741-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's highly encouraged to have the separate DT schema for each available
particular device, while the generic schema should be left untouched
representing just a set of the common device properties (mainly advertised
by the IP-core reference manual). Seeing there is no currently DW PCIe
RP/EP dts nodes with only generic compatible string and since there isn't
any vendor-specific compatible string added to the generic DT schema,
before it's too late let's mark the snps,dw-pcie.yaml and
snps,dw-pcie-ep.yaml schemas not selected for checking by default and add
the explicit requirement to have the compatible string containing the
generic device name.

Note due to this modification we need to switch some of the DW PCIe-based
DT-bindings to referring to the common DT-schema instead of evaluating
against the generic DW PCIe DT-bindings. They are already defined as
having the vendor-specific compatible string only. So we can't change that
semantic.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
- Fix compatible property schema so one would work as expected: string
  must contain either generic DW PCIe IP-core name or both generic and
  equipped with IP-core version names.
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          |  3 ++-
 .../bindings/pci/hisilicon,kirin-pcie.yaml    |  3 ++-
 .../bindings/pci/sifive,fu740-pcie.yaml       |  3 ++-
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 24 +++++++++++++++----
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 24 +++++++++++++++----
 .../pci/socionext,uniphier-pcie-ep.yaml       |  9 +++----
 .../bindings/pci/toshiba,visconti-pcie.yaml   |  3 ++-
 7 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 252e5b72aee0..6f99baa445a6 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -15,7 +15,8 @@ description: |+
   and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index c9f04999c9cf..f0d5314f340f 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -17,7 +17,8 @@ description: |
   Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
index 195e6afeb169..b0cf8ce99ce3 100644
--- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -17,7 +17,8 @@ maintainers:
   - Greentime Hu <greentime.hu@sifive.com>
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index fc3b5d4ac245..b04ce7ddb796 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -13,6 +13,12 @@ maintainers:
 description: |
   Synopsys DesignWare PCIe host controller endpoint
 
+# Please create a separate DT-schema for the particular DWC PCIe Endpoint
+# controller and make sure it's assigned with the vendor-specific
+# compatible string together with the generic Synopsys DWC PCIe strings so
+# the bindings would be evaluated against that schema.
+select: false
+
 allOf:
   - $ref: /schemas/pci/pci-ep.yaml#
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
@@ -20,8 +26,18 @@ allOf:
 properties:
   compatible:
     anyOf:
-      - {}
-      - const: snps,dw-pcie-ep
+      - description:
+          DWC PCIe Endpoint controller (IP-core version is explicitly
+          specified in the additional compatible string)
+        contains:
+          allOf:
+            - pattern: '^snps,dw-pcie-ep-[0-9]+\.[0-9]+a?$'
+            - const: snps,dw-pcie-ep
+      - description:
+          DWC PCIe Endpoint controller (IP-core version is either unknown
+          or can be read from the PCIe version register of the PL reg-space)
+        contains:
+          const: snps,dw-pcie-ep
 
   reg:
     description: |
@@ -38,16 +54,16 @@ properties:
       enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
 
 required:
+  - compatible
   - reg
   - reg-names
-  - compatible
 
 additionalProperties: true
 
 examples:
   - |
     pcie-ep@dfd00000 {
-      compatible = "snps,dw-pcie-ep";
+      compatible = "vendor,soc-pcie", "snps,dw-pcie-ep";
       reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
             <0xdfc01000 0x0001000>, /* IP registers 2 */
             <0xd0000000 0x2000000>; /* Configuration space */
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 01cedf51e0f8..8b2e3210e3e2 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -13,6 +13,12 @@ maintainers:
 description: |
   Synopsys DesignWare PCIe host controller
 
+# Please create a separate DT-schema for the particular DWC PCIe Root Port
+# controller and make sure it's assigned with the vendor-specific
+# compatible string together with the generic Synopsys DWC PCIe strings so
+# the bindings would be evaluated against that schema.
+select: false
+
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
@@ -20,8 +26,18 @@ allOf:
 properties:
   compatible:
     anyOf:
-      - {}
-      - const: snps,dw-pcie
+      - description:
+          DWC PCIe Root Port controller (IP-core version is explicitly
+          specified in the additional compatible string)
+        contains:
+          allOf:
+            - pattern: '^snps,dw-pcie-[0-9]+\.[0-9]+a?$'
+            - const: snps,dw-pcie
+      - description:
+          DWC PCIe Root Port controller (IP-core version is either unknown
+          or can be read from the PCIe version register of the PL reg-space)
+        contains:
+          const: snps,dw-pcie
 
   reg:
     description: |
@@ -47,14 +63,14 @@ properties:
 additionalProperties: true
 
 required:
+  - compatible
   - reg
   - reg-names
-  - compatible
 
 examples:
   - |
     pcie@dfc00000 {
-      compatible = "snps,dw-pcie";
+      compatible = "vendor,soc-pcie", "snps,dw-pcie";
       device_type = "pci";
       reg = <0xdfc00000 0x0001000>, /* IP registers */
             <0xd0000000 0x0002000>; /* Configuration space */
diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index 437e61618d06..1719a36952c0 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -20,9 +20,10 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - socionext,uniphier-pro5-pcie-ep
-      - socionext,uniphier-nx1-pcie-ep
+    contains:
+      enum:
+        - socionext,uniphier-pro5-pcie-ep
+        - socionext,uniphier-nx1-pcie-ep
 
   reg:
     minItems: 4
@@ -92,7 +93,7 @@ unevaluatedProperties: false
 examples:
   - |
     pcie_ep: pcie-ep@66000000 {
-        compatible = "socionext,uniphier-pro5-pcie-ep";
+        compatible = "socionext,uniphier-pro5-pcie-ep", "snps,dw-pcie-ep";
         reg-names = "dbi", "dbi2", "link", "addr_space";
         reg = <0x66000000 0x1000>, <0x66001000 0x1000>,
               <0x66010000 0x10000>, <0x67000000 0x400000>;
diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
index 30b6396d83c8..a08002ce9119 100644
--- a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
@@ -13,7 +13,8 @@ description:
   Toshiba Visconti5 SoC PCIe host controller is based on the Synopsys DesignWare PCIe IP.
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
-- 
2.35.1

