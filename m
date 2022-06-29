Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1022B560244
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiF2OMo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiF2OMa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C222E9FC;
        Wed, 29 Jun 2022 07:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A6660F6A;
        Wed, 29 Jun 2022 14:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A07C385A2;
        Wed, 29 Jun 2022 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511949;
        bh=6LChm1cY49hcWreDbWyQGCmRXOsMW3NMD3tsuxoELSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqbLA21Vyp+7vCSot6CkMVTBHkbVSQ/0TjsbVi/R4T2Nd2MeQyhWCfvOhxuaZgis7
         fl07vvkXg+biAvTBoYnnlid+FOPuQ9q+EEW6wH61UMCNsNHuV1GvYzTRUcm+DEOyla
         Uxxc0Mv/B5bKP8aemW5fhW5cwHhQqKRXi+asozZRUukljhqeJZqlSRwx8EuyTOWWCB
         fj8N8Bds4j6+6b9ikTYgigUnETrRdX0AjH8TRFXGXD6oEWdkHnw+BY6YfZCDczgpQL
         Ho3Ak1lCdNjY8Pqk/eKlTJEYjImjFdsu+8sNxBMhpmCoVTkLnsyYcj2wd9eETHZ0H8
         5TtyRBw4S4DpA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6YQe-0004lC-HM; Wed, 29 Jun 2022 16:12:28 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 03/10] dt-bindings: PCI: qcom: Enumerate platforms with single msi interrupt
Date:   Wed, 29 Jun 2022 16:09:53 +0200
Message-Id: <20220629141000.18111-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629141000.18111-1-johan+linaro@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Explicitly enumerate the older platforms that have a single msi host
interrupt. This allows for adding further platforms without resorting
to nested conditionals.

Drop the redundant comment about older chipsets instead of moving it.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml      | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a1b4fc70e162..8560c65e6f0b 100644
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

