Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A381E5460F1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348454AbiFJJFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348419AbiFJJFW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:05:22 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CFA629C8F;
        Fri, 10 Jun 2022 02:04:55 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 1989816AD;
        Fri, 10 Jun 2022 11:58:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 1989816AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851486;
        bh=/+Ql9S8Lce7AJFIReyXSZGMayLYvafFWb23OhLb0lTE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=eFT929A+5CICKi+DkhZGGjxOKL8BO6nIcmernwVF7vawHVAE6OmnWEOW3DZu/bhsh
         Z76f686WYb86gnan0mBCULr1VsCyTbCn1M/qk6qsQjIhgTI7mcPaH7z7FARj8THIhX
         f2tI+OTvlVgQjxzMqJ7lO22XJr+MaGMhH4e7xHBQ=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:13 +0300
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
Subject: [PATCH v3 06/17] dt-bindings: PCI: dwc: Add max-functions EP property
Date:   Fri, 10 Jun 2022 11:56:54 +0300
Message-ID: <20220610085706.15741-7-Sergey.Semin@baikalelectronics.ru>
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

In accordance with [1] the CX_NFUNC IP-core synthesize parameter is
responsible for the number of physical functions to support in the EP
mode. Its upper limit is 32. Let's use it to constrain the number of
PCIe functions the DW PCIe EP DT-nodes can advertise.

[1] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
Endpoint, Version 5.40a, March 2019, p. 887.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index b04ce7ddb796..9411366d6ca7 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -53,6 +53,9 @@ properties:
     items:
       enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
 
+  max-functions:
+    maximum: 32
+
 required:
   - compatible
   - reg
@@ -73,4 +76,5 @@ examples:
       phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
 
       max-link-speed = <3>;
+      max-functions = /bits/ 8 <4>;
     };
-- 
2.35.1

