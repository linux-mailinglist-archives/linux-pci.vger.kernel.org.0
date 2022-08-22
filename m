Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB6C59C709
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiHVSso (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiHVSsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:48:03 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A3404A80C;
        Mon, 22 Aug 2022 11:47:42 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id E085EDAA;
        Mon, 22 Aug 2022 21:50:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com E085EDAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194245;
        bh=IQutk4ZnzKS01ReJKXg3a8Yo46n3C98VZAFb5jsbuls=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=NGS5M98rqzVl/Jc1wrO+7t0ubFDJ/7hE3rw5GN78gijmcA4WKMY9VASvyulQyGCTk
         xSl2xAB+MTJ4cJ6CKoHQAxTgnnm3GXDIQvaB8rPv8a1tuuycdmk9imjOYuZiZoe+AL
         tDOdfQAUcY2SvFkjzal4pHQ40X3edZGBETI7gsw8=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 08/20] dt-bindings: PCI: dwc: Add max-functions EP property
Date:   Mon, 22 Aug 2022 21:46:49 +0300
Message-ID: <20220822184701.25246-9-Sergey.Semin@baikalelectronics.ru>
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

In accordance with [1] the CX_NFUNC IP-core synthesize parameter is
responsible for the number of physical functions to support in the EP
mode. Its upper limit is 32. Let's use it to constrain the number of
PCIe functions the DW PCIe EP DT-nodes can advertise.

[1] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
Endpoint, Version 5.40a, March 2019, p. 887.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index d04001248b53..71dd19ae1060 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -41,6 +41,9 @@ properties:
     items:
       enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
 
+  max-functions:
+    maximum: 32
+
 required:
   - compatible
   - reg
@@ -61,4 +64,5 @@ examples:
       phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
 
       max-link-speed = <3>;
+      max-functions = /bits/ 8 <4>;
     };
-- 
2.35.1

