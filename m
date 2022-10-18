Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2A60285E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 11:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJRJbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJRJbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 05:31:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E700AD9B2;
        Tue, 18 Oct 2022 02:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36818B81E0F;
        Tue, 18 Oct 2022 09:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE9DC433D6;
        Tue, 18 Oct 2022 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666085497;
        bh=VSqtKXH7fWy/Zr00J19onaibCcqs1TqNaT6Qxu7nmzo=;
        h=From:To:Cc:Subject:Date:From;
        b=kEniEo3sa8FCC9tnMTmiasSRxtMiOY27eGwOy9H8YsM2RI7v+Yzsr4OuP8jsi0DTi
         gU4ysOZauWktUG1oflw06OnduIk9z9SH8Q6LVmbO66FIfWFansom7fSBFDyv8dn9xG
         t2hVzAuiFYJxHbAu483YrsKUCggPEHK/erkZPmPtOLQZl1Q+gzQntN6qImJdJwXX0n
         SuwjcLEC2MREqFYcOSfY255diwlEXftktl+u3Sh4LtiWwIK2I35rLqvCIVk0TLLH20
         XWOvxdUA3WvsTSA0PPr755no+bLygzFjvTPIsTsKPYmvYr7yqmnXgAVrUHZNleYzjy
         J1uCAXVo5GuIg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okiwW-0001xk-Q4; Tue, 18 Oct 2022 11:31:24 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: PCI: qcom-ep: Fix PERST register description
Date:   Tue, 18 Oct 2022 11:31:15 +0200
Message-Id: <20221018093115.7537-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
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

The 'qcom,perst-regs' property holds a single phandle array with the
phandle of the TCSR syscon and offsets of the two PERST registers, but
the current schema does not capture this.

Update the binding to describe the single phandle array and its three
elements.

Fixes: 31c9ef002580 ("dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 977c976ea799..7574291646ad 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -42,13 +42,13 @@ properties:
     maxItems: 8
 
   qcom,perst-regs:
-    description: Reference to a syscon representing TCSR followed by the two
-                 offsets within syscon for Perst enable and Perst separation
-                 enable registers
+    description: PERST TCSR registers
     $ref: "/schemas/types.yaml#/definitions/phandle-array"
     items:
-      minItems: 3
-      maxItems: 3
+      - items:
+          - description: phandle of TCSR syscon
+          - description: offset of PERST Enable register
+          - description: offset of PERST Separation Enable register
 
   interrupts:
     items:
-- 
2.37.3

