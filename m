Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72236622A99
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 12:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKILcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 06:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiKILcI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 06:32:08 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DAE2CE3F
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 03:32:07 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z24so25304136ljn.4
        for <linux-pci@vger.kernel.org>; Wed, 09 Nov 2022 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnhQoXgqWChOSupWd26PNEi+MyU1K/k2bXa+DH33Fio=;
        b=nwmgpQIBECrs1Zud8ZuqCP2m7gh4JsnS3m1E63oPFYzBvQbBK5MfOPLuxteDa/Pctb
         BLLwkdZnNsBOtK4zoq3vP3GNBWtmWTXTlrDiaGEPiWRuNOrPIFZmyna6xKQsU5HqB6cJ
         4euLCRdAkFfGaXuOZfSgzGLDZ4DGVHcPAu7UliLXaSh/qOXdkZ7KZ9/9we5kE3fGVwu+
         KYTYiM1Ha6zv7wBTjYulP9to3OmB5FDfoEgFVY+wU1DJynVtb7T2Ef7vEV90fZRBvGtN
         aihcl2aOiN7q9xpN4YBMuzwOFMQjyELYsninXYZs678mNNQMoiI0OEmNYH9RgcFIIgcV
         oaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnhQoXgqWChOSupWd26PNEi+MyU1K/k2bXa+DH33Fio=;
        b=KYVFDJo4Qox4Um/Ca6y/o2sjtFoQZpFnW4nOQqS9NYmkfgDGIUYiP4Bj1KIse93pv2
         d7HWumiKuwBKgdOjSOxv/KgWPMokFpRHgot5pc46cAogPN++1kzEE9Ov5RimAW/Ob3y4
         EEUIB98qApqhH3naE3UpX5flcDHLuHbMLOl5r8YGQ6Czt5ugeqcqF18hdGpjKskidC3u
         4BLtpzxMKulfjCvvJklfv6aEU9KWXj99BV81X+kLg9Rl5lo4uAe9DYlhI4+guJ/1PDxP
         AW8UKjRfcW2XV0qe6l4mmEJMqlxJZwj8lsBZgnyIE6yBDLu+Or0ezq4RBzJ+b9gnEWWT
         Tdag==
X-Gm-Message-State: ACrzQf3RrqG/Yh/R5kOG/EXVWaLq/6z6IqxmeyK88B3mwSOyFbRKdo5L
        uyPREx1X/InUjhJqisLs+YfUQA==
X-Google-Smtp-Source: AMsMyM7ztAYNYFaTZJ2mjxlJnGhwhsar3MutJudYZpota/mxEUgHCr2VhBag/TTUpQXavnP7v5G2ug==
X-Received: by 2002:a2e:80d8:0:b0:277:309:73cb with SMTP id r24-20020a2e80d8000000b00277030973cbmr8144318ljg.371.1667993525673;
        Wed, 09 Nov 2022 03:32:05 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id m4-20020a2e97c4000000b0026dcac60624sm2038146ljj.108.2022.11.09.03.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:32:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2] dt-bindings: PCI: qcom,pcie-ep: correct qcom,perst-regs
Date:   Wed,  9 Nov 2022 12:32:02 +0100
Message-Id: <20221109113202.74406-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

qcom,perst-regs is an phandle array of one item with a phandle and its
arguments.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---

Changes since v1:
1. Correct lang typo.
2. Add tags.
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 977c976ea799..8005ccd287c0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -47,8 +47,10 @@ properties:
                  enable registers
     $ref: "/schemas/types.yaml#/definitions/phandle-array"
     items:
-      minItems: 3
-      maxItems: 3
+      - items:
+          - description: Syscon to TCSR system registers
+          - description: Perst enable offset
+          - description: Perst separation enable offset
 
   interrupts:
     items:
-- 
2.34.1

