Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3B60705D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 08:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJUGr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 02:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJUGrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 02:47:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384202413F4;
        Thu, 20 Oct 2022 23:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C40F61B39;
        Fri, 21 Oct 2022 06:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE015C433D6;
        Fri, 21 Oct 2022 06:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666334867;
        bh=L2kl6xZZIoArZEtrdl2/F173ECwVvHETksPU21qwgRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9ROaxc/KwLiIIiAAjv30f0ccyVD3IU4x6k9l5AzwnZ6eLV/ylJafIDqZp1SrBZrG
         38yDMWOZNchG8nhG1Eu+moNdFWqX+iCN2FU/p8tHdB9VFGC65ICdsFdAEFizjDEh7n
         Zn8fQG8UFM/QtS3PngMFsGaPteqcc0sFOPBwHi4tDz+86kSbRJUwchP8zQFpxHGL1O
         jWpqhW5n+eve6zCxNYHYdKLYX28yXtB70ym3bFnh+ZKY7PFuK3hh/mC+2TIF/0hFLQ
         6O47P9Te13+XISMhuGziVy6VUimDWAag2trAF+Yijtkd1sJx251xmQitpSANjTEP3R
         un1YWzKHdzlSg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1olloc-0001fU-D5; Fri, 21 Oct 2022 08:47:34 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: PCI: qcom: Add SC8280XP/SA8540P interconnects
Date:   Fri, 21 Oct 2022 08:46:15 +0200
Message-Id: <20221021064616.6380-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021064616.6380-1-johan+linaro@kernel.org>
References: <20221021064616.6380-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

