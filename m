Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB16EED3F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 06:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbjDZE4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 00:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239429AbjDZE4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 00:56:21 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF2DA2D7C;
        Tue, 25 Apr 2023 21:56:13 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,227,1677510000"; 
   d="scan'208";a="160778530"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Apr 2023 13:56:07 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0BFB841763FB;
        Wed, 26 Apr 2023 13:56:07 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v14 15/21] dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
Date:   Wed, 26 Apr 2023 13:55:51 +0900
Message-Id: <20230426045557.3613826-16-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update maxItems of reg and reg-names on both host and endpoint
for supporting Renesas R-Car Gen4 PCIe controllers later.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ++--
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index 8fc2151691a4..cb727f60be0b 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -33,11 +33,11 @@ properties:
       normal controller functioning. iATU memory IO region is also required
       if the space is unrolled (IP-core version >= 4.80a).
     minItems: 2
-    maxItems: 5
+    maxItems: 6
 
   reg-names:
     minItems: 2
-    maxItems: 5
+    maxItems: 6
     items:
       oneOf:
         - description:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 1a83f0f65f19..0bfcfd6ccb5f 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -33,11 +33,11 @@ properties:
       are required for the normal controller work. iATU memory IO region is
       also required if the space is unrolled (IP-core version >= 4.80a).
     minItems: 2
-    maxItems: 5
+    maxItems: 6
 
   reg-names:
     minItems: 2
-    maxItems: 5
+    maxItems: 6
     items:
       oneOf:
         - description:
-- 
2.25.1

