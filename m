Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A88A6271FB
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 20:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiKMTOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 14:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMTOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 14:14:52 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1410F2AE2;
        Sun, 13 Nov 2022 11:14:46 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9A87AE0EAB;
        Sun, 13 Nov 2022 22:14:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=BOM0V5Is2ED4//ZjRwtHVU+vDn2+frnhrGV5L/Nfxbc=; b=oza/jI73YmMj
        iBmn9GUHcWRUaAliNyaat5vi8uZoV3bN3O4t+9zlaaQ70veJISd3zITApay5MXF6
        8JqZ8q260hgK4/DnWLfxkCRd9zbrf7JaTEyAjo+Zt8s2QbIehmGs/yRJKcKdo1pq
        lhtXmaFGjUM/1ANBULtombKbb0zVoUw=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 8B768E0E6A;
        Sun, 13 Nov 2022 22:14:45 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 13 Nov 2022 22:14:44 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 02/20] dt-bindings: visconti-pcie: Fix interrupts array max constraints
Date:   Sun, 13 Nov 2022 22:12:43 +0300
Message-ID: <20221113191301.5526-3-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In accordance with the way the device DT-node is actually defined in
arch/arm64/boot/dts/toshiba/tmpv7708.dtsi and the way the device is probed
by the DW PCIe driver there are two IRQs it actually has. It's MSI IRQ the
DT-bindings lack. Let's extend the interrupts property constraints then
and fix the schema example so one would be acceptable by the actual device
DT-bindings.

Fixes: 17c1b16340f0 ("dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

---

Changelog v5:
- This is a new patch added on the v5 release of the patchset.
---
 .../devicetree/bindings/pci/toshiba,visconti-pcie.yaml     | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
index 48ed227fc5b9..53da2edd7c9a 100644
--- a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
@@ -36,7 +36,7 @@ properties:
       - const: mpu
 
   interrupts:
-    maxItems: 1
+    maxItems: 2
 
   clocks:
     items:
@@ -94,8 +94,9 @@ examples:
             #interrupt-cells = <1>;
             ranges = <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000>,
                      <0x82000000 0 0x50000000 0 0x50000000 0 0x20000000>;
-            interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "intr";
+            interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "intr";
             interrupt-map-mask = <0 0 0 7>;
             interrupt-map =
                 <0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
-- 
2.38.1


