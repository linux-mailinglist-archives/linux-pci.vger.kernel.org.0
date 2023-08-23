Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928C978547E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjHWJq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 05:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbjHWJnB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 05:43:01 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 749155FC0;
        Wed, 23 Aug 2023 02:12:35 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="173694739"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Aug 2023 18:12:04 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id EF58F400294A;
        Wed, 23 Aug 2023 18:12:03 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v19 13/19] dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
Date:   Wed, 23 Aug 2023 18:11:47 +0900
Message-Id: <20230823091153.2578417-14-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
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

