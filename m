Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F95868C898
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 22:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBFV02 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 16:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjBFV01 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 16:26:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBBF1117D
        for <linux-pci@vger.kernel.org>; Mon,  6 Feb 2023 13:26:26 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m14so11709969wrg.13
        for <linux-pci@vger.kernel.org>; Mon, 06 Feb 2023 13:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7PS6b5vkJPFlGz4zOi2GTk2RyAin7yCEnLhrjw1nNk=;
        b=LXT3KxxoYDTVakG2EVnFyJX0Ecoe0375mD4EVdWYvoZ0/77UtL8TqV8Rr4ebhuEDMW
         +mO4/eJK6PdpclKyD5rGI6WbkDVILkqZrbDfmMm1/FnDlnQHucF6ReBa0s/ru5V4nUOU
         9UnWsRtNaDOH6VR3QbMxTWC2f50gC8kffNZHAXZhAbWqkn4fPuSHbZQqJdPsuCAvqjoD
         N4Frmd1qX4IRz32ciC5lMaxoJtcq57Vl2SgZtJVHI6TSI7V38c3MsRJ5cSXhtOWPjlIF
         xrHbEkbQ3V90FwhhLVCyaWyjiZyK5x1bXZLXmeZx6ICWyOLjeTdzB+h8aU3+9E8gLxoW
         VoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7PS6b5vkJPFlGz4zOi2GTk2RyAin7yCEnLhrjw1nNk=;
        b=DfOvIt9am+Bk0NGhy3KkFLEgXHBQQhL8rtGCBcGSU71VtabcJZZ7thPpt3lwfhUpTB
         8aYB3t/eX7yewuDqkyXIeP2YAxnC+Rbe13y4lFDfHhb2ffWrgeEvyLpDlkS9tdmOsfTA
         RsX+HbR/c7DI4SNsKvM1NgIC95GoWrnTB1fbw9sU31f1DfhlPCyFeLlC5R4reb7073xi
         GnCiEhE+VLCZEMUhLCdloLnCoERZMufO053VgCnHnbpXlny2KJJUQ2p/vc8lHRpkjNUw
         +wbJhh3paiudFu8FAMTvqDLGrfgQAFItbyMTTpONuDVfYIc7+GeQVy14T5o2EUUKOzdx
         U1yA==
X-Gm-Message-State: AO0yUKVK3ThYTn1/iw3xRE8vvj9jKhA7pZHmwqbi9iu6d/gJ6Uvz8T9e
        SaRGIoF/VvYYIwVj0JjWJbcurA==
X-Google-Smtp-Source: AK7set/N0Z515Us6ba2AQzmcs4+lftZy9SCGxw2jiSRJD5nCFbPEB/efF7Y2ek9XQbT3R4s+Q25TKg==
X-Received: by 2002:a5d:6941:0:b0:2bf:cfbd:44be with SMTP id r1-20020a5d6941000000b002bfcfbd44bemr227090wrw.69.1675718784988;
        Mon, 06 Feb 2023 13:26:24 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b002b57bae7174sm9783341wrt.5.2023.02.06.13.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:26:24 -0800 (PST)
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
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 01/11] dt-bindings: phy: Add QMP PCIe PHY comptible for SM8550
Date:   Mon,  6 Feb 2023 23:26:09 +0200
Message-Id: <20230206212619.3218741-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206212619.3218741-1-abel.vesa@linaro.org>
References: <20230206212619.3218741-1-abel.vesa@linaro.org>
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
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---

The v7 of this patch is:
https://lore.kernel.org/all/20230203081807.2248625-2-abel.vesa@linaro.org/

Changes since v7:
 * Added Johan's R-b tag

Changes since v6:
 * none

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

