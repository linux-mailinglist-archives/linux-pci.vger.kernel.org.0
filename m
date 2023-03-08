Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56096B011D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCHIZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCHIZA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:25:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126E18170
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 00:24:50 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso1230768pju.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 00:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678263890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMlNAANegEf4xx1NXIuCik/6RdcS3sC+7JZ54OhQzec=;
        b=eBibBaaC8WjGYl5ji9LuEtbfgqV8KIqyx/OB3HDqFwG7s8TlYGGwzWdaI+QbXuTTar
         2KQ/Pmc3gWpIj44n29MKHsmZH4FlPMfLHiMM41Qou1AC9/Q0B+aetKpEYskgzH+wI5UL
         5q2E6TiRCv1hBimV/xy8MIu/ZSrFqQ5LdfSbfeXqkmxyx00UbrkG9YzF8EXnJk1rwo03
         p24664/E1wnl9qAVIhH/BWkcvi7amecMYJL/0Tk0HjrYrRShMSLHrUGkwmxh2nZrUYZO
         /QWrtj+5Ql0sZMb6BJ2M1RY6bD6P6adr1HNiJTROIu7a+A1iMbB7SAKTud1HcYAy13XY
         hYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMlNAANegEf4xx1NXIuCik/6RdcS3sC+7JZ54OhQzec=;
        b=urcwR8KCcRzaDMALdkrzEV6pgdO01Zmi65NXBridpqwg0dnkdXThH1fHzb+J3lPbkA
         TjYhHLo8Fyxukox0vPloZCh5ZgN1YMCBeZ0SLFNhnZD+JlIKqvq1BGPBhIKjQqG0h7pq
         YhCJt3108uDt3WWUsagPSEF5vPcsWMOE1v4gWV3MIf6uVSqtci0NLlSb5vOpwi4a0+33
         DQeAKsEhkURh4Hr2KRgrV9xAbv5/CU0sOOK/5krIojsuFlqsO7waUMv2s043J4YIF4gn
         ppAAqRRPbzoBwGMbwi3/yQue39lzuL77swUNZIQ9Acsz1BAceQP5fFW0pgHWg6wq/nE9
         mDPg==
X-Gm-Message-State: AO0yUKWJ+mRJsIpCasKw3P+sPNvNZ8gdvVj9jk6l1VR7G3SsvN2fun1w
        esGZgMk11wx+AGKAiw3IHWrh
X-Google-Smtp-Source: AK7set/4JPpqY/DEaCsjMr/Q40idU76TpT65q6X/mbVl72aZv/GG+oCgBUuvTqz10mgmE96actYxpA==
X-Received: by 2002:a17:902:9b8a:b0:19e:7182:b54f with SMTP id y10-20020a1709029b8a00b0019e7182b54fmr14919592plp.36.1678263889918;
        Wed, 08 Mar 2023 00:24:49 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0019aaab3f9d7sm9448086plg.113.2023.03.08.00.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:24:49 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 04/13] dt-bindings: PCI: qcom-ep: Fix the unit address used in example
Date:   Wed,  8 Mar 2023 13:54:15 +0530
Message-Id: <20230308082424.140224-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unit address of PCIe EP node should be 0x1c00000 as it has to match the
first address specified in the reg property.

Fixes: 31c9ef002580 ("dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 89cfdee4b89f..b7f6fbaa0ba0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -166,7 +166,7 @@ examples:
     #include <dt-bindings/clock/qcom,gcc-sdx55.h>
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    pcie_ep: pcie-ep@40000000 {
+    pcie_ep: pcie-ep@1c00000 {
         compatible = "qcom,sdx55-pcie-ep";
         reg = <0x01c00000 0x3000>,
               <0x40000000 0xf1d>,
-- 
2.25.1

