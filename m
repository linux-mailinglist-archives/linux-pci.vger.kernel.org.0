Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB15460C9
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348302AbiFJJE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348143AbiFJJE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:04:56 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B67D939C0;
        Fri, 10 Jun 2022 02:04:50 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id A2F9316AA;
        Fri, 10 Jun 2022 11:58:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com A2F9316AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851483;
        bh=SxesLaHSxvB/8SPfCp3xsyvE7UyGSjtfp9V56Ruxkas=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mJYMAczgSO3UUB9tlbR34bflCjwINrd87gJgx1jI3RaTxtmg9iOOrWGAvnk4ELgqF
         55GXPJiJGcTNw7KFHssPpi2gYNhjlConDkOi0n7TihbyUzlqthRFfV6TvaoMJTZQP1
         LPKiEvHfY/kCIHrrfx0G0iaoK2OqU08oU3GAjiVg=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:10 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/17] dt-bindings: PCI: dwc: Add max-link-speed common property
Date:   Fri, 10 Jun 2022 11:56:52 +0300
Message-ID: <20220610085706.15741-5-Sergey.Semin@baikalelectronics.ru>
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

In accordance with [1] DW PCIe controllers support up to Gen5 link speed.
Let's add the max-link-speed property upper bound to 5 then. The DT
bindings of the particular devices are expected to setup more strict
constraint on that parameter.

[1] Synopsys DesignWare Cores PCI Express Controller Databook, Version
5.40a, March 2019, p. 27

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml | 3 +++
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml     | 2 ++
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 627a5d6625ba..b2fbe886981b 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -45,6 +45,9 @@ properties:
       the peripheral devices available on the PCIe bus.
     maxItems: 1
 
+  max-link-speed:
+    maximum: 5
+
   num-lanes:
     description:
       Number of PCIe link lanes to use. Can be omitted should the already
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index dcd521aed213..fc3b5d4ac245 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -55,4 +55,6 @@ examples:
 
       phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
       phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
+
+      max-link-speed = <3>;
     };
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 4a5c8b933b52..01cedf51e0f8 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -74,4 +74,5 @@ examples:
       phy-names = "pcie";
 
       num-lanes = <1>;
+      max-link-speed = <3>;
     };
-- 
2.35.1

