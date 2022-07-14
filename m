Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45705745AA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiGNHOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiGNHOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:14:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D07DF5C;
        Thu, 14 Jul 2022 00:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41CABB8226F;
        Thu, 14 Jul 2022 07:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6928C341C8;
        Thu, 14 Jul 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657782841;
        bh=dJs3ZHwES7dbmXTCPXTZO+fPyDl9njp4tIxHLvkFzr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKF7gJx0O3cMODWgLOzpV0/Ahxz6p9HmUaPS+xogeGvvBJj1eHiXx5FJgonej3xx2
         RgMjihr6W8qiJFgFaG+VQelWjKs+ZOsnG1W/U1txp6h4qQFAu76WHOlEPZK1631QV9
         RICFNJ0dCHytpiWQ92aWfJUU9BKaboisNVn9kgY/udqHebF5PsqEi5i0QMU3opUvwW
         5kmmfMBWzfhgLkX8CNfqcyqdObRgVIrZv3d8FunXd7h54xsc/fEPYtrkbqhZlu91nr
         nJVrkQkROQsIvxb7jStk1Wjae+NbIqBRX47R6FciaRcuPy8QoXtNYGA4m0VwCQeXLj
         m9wwOTDumsafA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBt30-0001m7-2L; Thu, 14 Jul 2022 09:14:06 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 1/8] dt-bindings: PCI: qcom: Enumerate platforms with single msi interrupt
Date:   Thu, 14 Jul 2022 09:13:41 +0200
Message-Id: <20220714071348.6792-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714071348.6792-1-johan+linaro@kernel.org>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Explicitly enumerate the older platforms that have a single msi host
interrupt. This allows for adding further platforms with, for example,
four msi interrupts without resorting to nested conditionals.

Drop the redundant comment about older chipsets instead of moving it.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml      | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 70984037df73..8142c891f18b 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -625,7 +625,6 @@ allOf:
         - reset-names
 
     # On newer chipsets support either 1 or 8 msi interrupts
-    # On older chipsets it's always 1 msi interrupt
   - if:
       properties:
         compatible:
@@ -660,7 +659,21 @@ allOf:
                 - const: msi5
                 - const: msi6
                 - const: msi7
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8064
+              - qcom,pcie-apq8084
+              - qcom,pcie-ipq4019
+              - qcom,pcie-ipq6018
+              - qcom,pcie-ipq8064
+              - qcom,pcie-ipq8064-v2
+              - qcom,pcie-ipq8074
+              - qcom,pcie-qcs404
+    then:
       properties:
         interrupts:
           maxItems: 1
-- 
2.35.1

