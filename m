Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D05C57459F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiGNHOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiGNHOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8948DF5C;
        Thu, 14 Jul 2022 00:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EEF761B9D;
        Thu, 14 Jul 2022 07:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B872EC385A5;
        Thu, 14 Jul 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657782841;
        bh=l/IiNEET7CTOwgkkFphEZwnof+cr+/TdjVrGxeor7ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+N5HN53n1skZMonmVHvKhU5D8dlF5ibzbWygITivhym6vU9Ztq/Qo9X76l48xCzX
         FrawY6+7iig/RZ4yKzYMh2D4nJAZPl9ragz9vjtZdvJqn1kUDsGcKQxEO3j/UQgQSi
         RsOsqahCzHrz9g4fNlzeghHwPgtvRyhjoY6ep+BQx2fLkyn1EUX4nn+BOYYI0RMQFs
         1XO6mn5cI6zyqHVm0QSOTC6+fY2ikINrIIqWRjHrEfHx/tU1h/XRXxfx5Rx/rHks7O
         mxfBIKYAOci8sEPQ3Fn+64e9y14R5VSPNJDIuyZYpvqFjbN/eCD9Yy3ujlc6WZCxFX
         I5RpDIqWTMAvA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oBt30-0001mB-8G; Thu, 14 Jul 2022 09:14:06 +0200
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
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/8] dt-bindings: PCI: qcom: Add SA8540P to binding
Date:   Thu, 14 Jul 2022 09:13:43 +0200
Message-Id: <20220714071348.6792-4-johan+linaro@kernel.org>
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

SA8540P is a new platform related to SC8280XP but which uses a single
host interrupt for MSI routing.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 577d166a7476..22a2aac4c23f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -25,6 +25,7 @@ properties:
       - qcom,pcie-ipq4019
       - qcom,pcie-ipq8074
       - qcom,pcie-qcs404
+      - qcom,pcie-sa8540p
       - qcom,pcie-sc7280
       - qcom,pcie-sc8180x
       - qcom,pcie-sc8280xp
@@ -603,6 +604,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-sa8540p
               - qcom,pcie-sc8280xp
     then:
       properties:
@@ -721,6 +723,7 @@ allOf:
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-ipq8074
               - qcom,pcie-qcs404
+              - qcom,pcie-sa8540p
     then:
       properties:
         interrupts:
-- 
2.35.1

