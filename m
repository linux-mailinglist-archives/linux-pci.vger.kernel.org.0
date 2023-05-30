Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A146716938
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjE3QZe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjE3QZb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 12:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187BF11D;
        Tue, 30 May 2023 09:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5766560CA4;
        Tue, 30 May 2023 16:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A570C433A7;
        Tue, 30 May 2023 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463907;
        bh=c6AGKWOZbqw3+DTVVifBJKHqZLfhJBeG4c33ZI92WM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aetMphh/jp8E0sT6W7xZw6g52tpK/B5/isECt+TrDMWR04Iq2g0PsJ+jpw9CRJ86/
         n+LfNNkKUr74k5VyLtYuTUWTMH2h4pb+XwMmr/ns+s6qIDuMytgDQXYGZjejEcpxU+
         lsKhwaPEmqQnMivvdZTsXnBRv/titSJ7H4NUSMmUw8zu7UUT5m3iXIPELFQrSil+Cf
         q17+aLGapTXgWNmbKvG3G5BazxDxqaIHf/elDxNWdMoNrk4+757J75rsNt94XoBKq0
         zFQSsPcAwP33412Z3HQlBoZVBNJaa0NHGeFqhKHZjfjRGDBKKyVJt+PRDh+qkXOcSM
         lKSscywRwf6Yg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 01/15] dt-bindings: PCI: qcom: Fix sc8180x clocks and interrupts
Date:   Tue, 30 May 2023 21:54:40 +0530
Message-Id: <20230530162454.51708-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530162454.51708-1-vkoul@kernel.org>
References: <20230530162454.51708-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 45a3ec891370 ("PCI: qcom: Add sc8180x compatible") added sc8180x
compatible and commit 075a9d55932e ("dt-bindings: PCI: qcom: Convert to
YAML") converted the description to yaml

But there are still some errors specific to sc8180x which this change
attempts to fix. The clocks and resets for sc8180 pcie controller are
different so need to be documented separately

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 81971be4e554..40a1f451a3d3 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -476,6 +476,33 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8180x
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ref # REFERENCE clock
+            - const: tbu # PCIe TBU clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
@@ -524,7 +551,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-sc8180x
               - qcom,pcie-sm8150
               - qcom,pcie-sm8250
     then:
@@ -749,6 +775,7 @@ allOf:
           contains:
             enum:
               - qcom,pcie-sa8540p
+              - qcom,pcie-sc8180x
               - qcom,pcie-sc8280xp
     then:
       required:
-- 
2.40.1

