Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697E959C6FC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiHVSsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiHVSrx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:47:53 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B14302FFE3;
        Mon, 22 Aug 2022 11:47:30 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9957EDA4;
        Mon, 22 Aug 2022 21:50:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9957EDA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194239;
        bh=xw4tcsZGlerRHC6sUiGj+e4nI8SaDAiUtYiOl9eCi58=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=c5wx+8ZCd/c5V3+mDT89VdvVmE3/YqbQN2xm0dUQFJJhGtDt3+qOJggyihDmRjPck
         Z0zkxDpzxjayDM956wyPZ6ZEq8c7uXG2mKJ4J57R0mC4vx82Rrr8U18xCVx72YE0ho
         yObPYjKX7iZ4csFMg0lyaP7nASZUkXNT5dHZxzX0=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:25 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 02/20] dt-bindings: visconti-pcie: Fix interrupts array max constraints
Date:   Mon, 22 Aug 2022 21:46:43 +0300
Message-ID: <20220822184701.25246-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
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

---

Changelog v5:
- This is a new patch added on the v5 release of the patchset.
---
 .../devicetree/bindings/pci/toshiba,visconti-pcie.yaml     | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
index 30b6396d83c8..aea0e2bcdd77 100644
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
2.35.1

