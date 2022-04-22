Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1945950C2F7
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiDVWTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 18:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiDVWS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 18:18:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBA632A9F7
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so16365365lfg.7
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pT3QSphyjcEjIBDXmdm47Fl+CJnoqpZj5H3WA4x3C+M=;
        b=ZPG6/YA+o69n+2JAaKBAAE9r3icEEwh79TovZA1iQ/ThR5LcjplCj3aUI0k541Pcpf
         bWerxKj/7D56j4QvMheUXj8VhYXOXftEaiR1+3LvR+qLs0///ax/+HDCdzIDCvm6lTpy
         9myZ/I2N5DJcwfhJwftSqjECv5kXIOUAY0JGNJg9gQSOoWZZAYVVZfIT/CJReVsmA85Q
         qGXRWeWlqg4jVjZL0smZm5HomerBboMCTD4Z3HBPjx2e3kEYwwlzJOp3R83aw21CgWXF
         bMs71YW1riJv5LhrT9bJLaCn+foebPhnxarYM7w4MQGT9NyZjRrG0fGjzURiNVdwXnVf
         jDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pT3QSphyjcEjIBDXmdm47Fl+CJnoqpZj5H3WA4x3C+M=;
        b=63Q7NQtQUMnV2HKl6hAADzW6wgrKVXBUONrcXA9ehDRCn7XYiT6hHiVcwR/Aa+fGsM
         Zx57sk3sEltan5lnOv/MpaJ24CysYF9TPc6Sdg8ehTro2Li6TFFCpdYEZBEPcUKKrRD+
         1bSkrmCJhF+gHiRP/EOwIVWlbfto+JJ8AIomxdQlilaPLiO6J0s8xtNEAM4vL4X84+eJ
         wW42Ky1Y+0Z8ZpRm+kkzIB+/wXV/ySuu5e0joxqCWF+tCFHQtpy1bbrPsoLrx1lVdFkj
         0XU1exg7dlhMM2KYkAzDHeeunwGPW2RWf0AKyYct7S71w4J67TXARqDL97UgNGORCCSC
         oPsg==
X-Gm-Message-State: AOAM533i0baPmAu7GK9Kcc5gsEB3+sBL4pQ1Rz1lV4+ieqddm9bANTHJ
        kial3x1iS1mi6Kvv6zmcDFPSGQ==
X-Google-Smtp-Source: ABdhPJwrHtW5M4LwzBnmMgCL/Az8RUR6v1kFDjkbTmUzXF5l7bk4++bitKDyFCau7GHZHSZWsGcz1Q==
X-Received: by 2002:a05:6512:b11:b0:44a:2ead:daf2 with SMTP id w17-20020a0565120b1100b0044a2eaddaf2mr4309334lfu.642.1650661806120;
        Fri, 22 Apr 2022 14:10:06 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24d46000000b0046bb728b873sm351240lfp.252.2022.04.22.14.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:05 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: pci/qcom,pcie: resets are not defined for msm8996
Date:   Sat, 23 Apr 2022 00:09:57 +0300
Message-Id: <20220422211002.2012070-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
References: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
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

On MSM8996/APQ8096 platforms the PCIe controller doesn't have any
resets. So move the requirement stance under the corresponding if
condition.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 071d7ef0e939..4b3c5f98c839 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -113,8 +113,6 @@ required:
   - interrupt-map
   - clocks
   - clock-names
-  - resets
-  - reset-names
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
@@ -502,6 +500,18 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      not:
+        properties:
+          compatibles:
+            contains:
+              enum:
+                - qcom,pcie-msm8996
+    then:
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

