Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC6687D74
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 13:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBBMjS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 07:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBBMjP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 07:39:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605284974
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 04:39:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so1569267wrv.7
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2023 04:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6VouN0MlWgjUshOJPKbo7az5XyXYLPFJ7JD5CxhfXU=;
        b=IAAI0Mve3sXdspkDMVmAAgMvVKtqC8M8bvqtq841a0lZOcllSyFN4CCXQl+6ZORct4
         gWxwXg54GlTw/t7ujjHhEg7yGvdPmBxIJjADfZC/OgdgVJlM7J63rxUrRPGzDEIG1RTx
         DL7PKAa/gdhtFotKxMCdorico/dFvJ1GB3bHiYQXqmpXGjP7Iezxdosh6RiikSTnkiuX
         TVDtPgO55+sK3RmrSuEfk5oAZmVpYxxu4JgVMtHNBdVu53bVhM3HH2BA/M9nz2Sz6I2B
         ehVLetPKrK78pFOcUPjyP3kbLXISd7Mz0FVJQGdjtGCzoWz8+WLFJa1dnIKXFhs6CLLP
         yooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6VouN0MlWgjUshOJPKbo7az5XyXYLPFJ7JD5CxhfXU=;
        b=X308kJdrEK9VqLk5InYNK5Y39uoLms6f0mkG4Y6Dwu7MeUB2mwvrSk/IoLCAkRg/YP
         ltCXXN6qrd3Ln4IeXhx8m9gTFAhuJ7bupqsLFXagMgco+KVf0BauCuR/YreUlDb4x84H
         /BmAJw0SbMdpDKPfUikGizc0qtYbShF6ICKENQdO21wvaqLRNwyJOsxFiX3/vUOEn3ig
         zgiR2STsRcpuwkYWIkugZJHcNo7EJEPhKsb9fHnDLLCsWpi5Rc96VoXms5Kq9mv3UtZa
         aV9yC0C9bIoIyiFk+IB7DJjRVMlHHV/cOrFWdF0e5ApOQO/5a0JOJqtTMaC4ZFq5WGYv
         WlrQ==
X-Gm-Message-State: AO0yUKVptQ1DFlfqdoXWCv4mjmaS3DjnFrae8BDYa5rUOwp4tmd69E/k
        ogJ3W7jlU2tOj6u6jnmqKB8hXY1TSwHjBv1h
X-Google-Smtp-Source: AK7set8qnBhGskoZh8msy/I6YjkTW9VLwBR0VChSsus1s4lmxEmPBQ+U3BRpClRae5fUqod4pYJXRg==
X-Received: by 2002:adf:ea08:0:b0:2bf:dfa2:977c with SMTP id q8-20020adfea08000000b002bfdfa2977cmr5364351wrm.47.1675341552503;
        Thu, 02 Feb 2023 04:39:12 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002bddd75a83fsm19525644wro.8.2023.02.02.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:39:12 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 01/12] dt-bindings: phy: Add QMP PCIe PHY comptible for SM8550
Date:   Thu,  2 Feb 2023 14:38:51 +0200
Message-Id: <20230202123902.3831491-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202123902.3831491-1-abel.vesa@linaro.org>
References: <20230202123902.3831491-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the QMP PCIe PHY compatible for SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v5 of this patch is:
https://lore.kernel.org/all/20230124124714.3087948-2-abel.vesa@linaro.org/

Changes since v5:
 * added Krzysztof's R-b tag
 * renmaed the no-CSR reset to "phy_nocsr" as discussed off-list with
   Bjorn and Johan

Changes since v4:
 * constrained resets and reset-names to 1 for every other SoC

Changes since v3:
 * increased the allowed number of resets to allow ncsr reset
 * added vdda-qref-supply which is used by pcie1_phy node in MTP dts
 * added both compatibles to the allOf:if:then clause to constrain the
   number of possible clocks to 5

Changes since v2:
 * added back the binding compatible update patch

Changes since v1:
 * split all the offsets into separate patches, like Vinod suggested

 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 8a85318d9c92..ef49efbd0a20 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -20,6 +20,8 @@ properties:
       - qcom,sc8280xp-qmp-gen3x2-pcie-phy
       - qcom,sc8280xp-qmp-gen3x4-pcie-phy
       - qcom,sm8350-qmp-gen3x1-pcie-phy
+      - qcom,sm8550-qmp-gen3x2-pcie-phy
+      - qcom,sm8550-qmp-gen4x2-pcie-phy
 
   reg:
     minItems: 1
@@ -43,16 +45,21 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reset-names:
+    minItems: 1
     items:
       - const: phy
+      - const: phy_nocsr
 
   vdda-phy-supply: true
 
   vdda-pll-supply: true
 
+  vdda-qref-supply: true
+
   qcom,4ln-config-sel:
     description: PCIe 4-lane configuration
     $ref: /schemas/types.yaml#/definitions/phandle-array
@@ -113,6 +120,8 @@ allOf:
           contains:
             enum:
               - qcom,sm8350-qmp-gen3x1-pcie-phy
+              - qcom,sm8550-qmp-gen3x2-pcie-phy
+              - qcom,sm8550-qmp-gen4x2-pcie-phy
     then:
       properties:
         clocks:
@@ -126,6 +135,25 @@ allOf:
         clock-names:
           minItems: 6
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-qmp-gen4x2-pcie-phy
+    then:
+      properties:
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+    else:
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
-- 
2.34.1

