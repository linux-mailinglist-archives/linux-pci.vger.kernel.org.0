Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C76778FE30
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349714AbjIANRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Sep 2023 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349710AbjIANRb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2023 09:17:31 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF9C010E0;
        Fri,  1 Sep 2023 06:17:27 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,219,1688396400"; 
   d="scan'208";a="178442171"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2023 22:17:26 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EC03741D31CC;
        Fri,  1 Sep 2023 22:17:25 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/3] dt-bindings: PCI: dwc: Update maxItems of reg and reg-names take 2
Date:   Fri,  1 Sep 2023 22:17:09 +0900
Message-Id: <20230901131711.2861283-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update maxItems of reg and reg-names on both host and endpoint
for supporting Renesas R-Car Gen4 PCIe controllers later.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---

This patch will be squashed into the following commit on the pci.git
/ controller/rcar branch so that the subject / description are almost
the same:

dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/rcar&id=5ca157f7d36cddc305bee7b89942c86f5af0a534
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml          | 4 ++--
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml    | 4 ++--
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index d87e13496834..dc05761c5cf9 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -33,11 +33,11 @@ properties:
       specific for each activated function, while the rest of the sub-spaces
       are common for all of them (if there are more than one).
     minItems: 2
-    maxItems: 6
+    maxItems: 7
 
   reg-names:
     minItems: 2
-    maxItems: 6
+    maxItems: 7
 
   interrupts:
     description:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index cb727f60be0b..bbdb01d22848 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -33,11 +33,11 @@ properties:
       normal controller functioning. iATU memory IO region is also required
       if the space is unrolled (IP-core version >= 4.80a).
     minItems: 2
-    maxItems: 6
+    maxItems: 7
 
   reg-names:
     minItems: 2
-    maxItems: 6
+    maxItems: 7
     items:
       oneOf:
         - description:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 0bfcfd6ccb5f..a4cab63fe838 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -33,11 +33,11 @@ properties:
       are required for the normal controller work. iATU memory IO region is
       also required if the space is unrolled (IP-core version >= 4.80a).
     minItems: 2
-    maxItems: 6
+    maxItems: 7
 
   reg-names:
     minItems: 2
-    maxItems: 6
+    maxItems: 7
     items:
       oneOf:
         - description:
-- 
2.25.1

