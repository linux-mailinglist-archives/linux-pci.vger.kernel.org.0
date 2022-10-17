Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D89600DB2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 13:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJQL1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJQL1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 07:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355885FAEA;
        Mon, 17 Oct 2022 04:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBEC76106F;
        Mon, 17 Oct 2022 11:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DD1C433B5;
        Mon, 17 Oct 2022 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666006028;
        bh=PbGvkepS2v+eRVnenWnJzkdlAGCiypF77ExFQpOAOcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMpi8BqRL/b+mQFsd8bKNfC2/bIA1tcN+0gzUvft555sCCfSbSyBkVUPoWAhQH0Ul
         0FJY8/7cAjg0lHzln7z47hQLJWanO+yNyMOSJ2YhlwusHzOMf6q1Bb+2h9R7E9D2TV
         tdPw5VHXX5yna0vP1smbGoQ1RD1RF4gRjBLunXFVrV8eLyuvgIAOgVaSIKf0WptxvN
         7qG+Xb3oruchfsnzSV+soKelI9Lr/WVWeDe4ix8Z4mZAxiFdqHiM6/Sxzw2xVDnYfK
         Ttwg3cMRXUlG/Hso9WrMCpSPMtR8zJIvp8uXca12rz6scfCbE0Sc7Zry3m81aRlOvh
         eFLeILUtHKbhQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okOGn-0000aZ-LY; Mon, 17 Oct 2022 13:26:57 +0200
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
        quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] dt-bindings: PCI: qcom: Add SC8280XP/SA8540P interconnects
Date:   Mon, 17 Oct 2022 13:24:48 +0200
Message-Id: <20221017112449.2146-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017112449.2146-1-johan+linaro@kernel.org>
References: <20221017112449.2146-1-johan+linaro@kernel.org>
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
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 22a2aac4c23f..a55434f95edd 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -62,6 +62,12 @@ properties:
     minItems: 3
     maxItems: 12
 
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    maxItems: 2
+
   resets:
     minItems: 1
     maxItems: 12
@@ -629,6 +635,25 @@ allOf:
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
+      properties:
+        interconnects:
+          maxItems: 2
+        interconnect-names:
+          items:
+            - const: pcie-mem
+            - const: cpu-pcie
+      required:
+        - interconnects
+        - interconnect-names
+
   - if:
       not:
         properties:
-- 
2.37.3

