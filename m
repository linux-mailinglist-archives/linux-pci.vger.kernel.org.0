Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB909615F07
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKBJJe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 05:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiKBJI5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 05:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6AA27FC3;
        Wed,  2 Nov 2022 02:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A6CD6183D;
        Wed,  2 Nov 2022 09:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99FFC433B5;
        Wed,  2 Nov 2022 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667380135;
        bh=AEgELwaNJx395j6AqBXn/DXGuQtCBIRhzRJDLXh90q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APPItOiPtS1jAZP74HeajPFv6XeCNIDkS9bYDcyA4E34vHMh2FLhkpdax7i6ia3QP
         4X056X2MTzzHiBKGjaJ8rk6a4NPvce60uVBBzeoxnUAyjBusei5ORgFCdYfe1hM94M
         unI5YeSAd8Cl28IT9Kx+i5HPZItgBtKdpTl0/prvSAihfvJP1rE01UCaxZ9qmuRYgm
         9ZSCNZ6jqw8Cq9bWBHM6gwhxbg9U76yfNuw0qBl74F5USfxRPlhsEb3K+X9B5XOQ3Y
         imBHX3leRod80vJAzGg1dbYDTpvOsYKXAdA6fSbDOLSEOgoL0dp4jnWKus46+4/bES
         Ohzr92PeI3K5A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oq9jj-0006B5-Lj; Wed, 02 Nov 2022 10:08:39 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        stanimir.k.varbanov@gmail.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Brian Masney <bmasney@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: PCI: qcom: Add SC8280XP/SA8540P interconnects
Date:   Wed,  2 Nov 2022 10:07:04 +0100
Message-Id: <20221102090705.23634-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221102090705.23634-1-johan+linaro@kernel.org>
References: <20221102090705.23634-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the missing SC8280XP/SA8540P "pcie-mem" and "cpu-pcie" interconnect
paths to the bindings.

Fixes: 76d777ae045e ("dt-bindings: PCI: qcom: Add SC8280XP to binding")
Fixes: 76c4207f4085 ("dt-bindings: PCI: qcom: Add SA8540P to binding")
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 54f07852d279..2f851c804bb0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -62,6 +62,14 @@ properties:
     minItems: 3
     maxItems: 13
 
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: pcie-mem
+      - const: cpu-pcie
+
   resets:
     minItems: 1
     maxItems: 12
@@ -631,6 +639,18 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sa8540p
+              - qcom,pcie-sc8280xp
+    then:
+      required:
+        - interconnects
+        - interconnect-names
+
   - if:
       not:
         properties:
-- 
2.37.3

