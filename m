Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B3950CABC
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiDWNnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 09:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiDWNmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 09:42:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6AD1759F0
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m23so1888691ljc.0
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6WBUYEt3xorbdlyz+i4pBQ2N1Cgz5kH2giSC34i0K0=;
        b=GD3RuJRFAyipHDGx8MCln2dfVYp5XATckWhUNcOO1I6qc7HTcYDRkOPShQG/TgvkRP
         q/QokGDOwmTJzJw4tNFBQnsr16thEiHi8GQlyabk50Iq7CASxadEl6rLpdXtNzPTI641
         viZ9sHfLux2VZ1sBTQlgmOfF37+5fbR+944WODwW0pDULbInAE8651Ig48t6XSnQ3vj3
         6OvB6CZNtgG7IVn+cUVDFTMCIrhe/qaBU8gV6iJa9FjbT7IZgdReyXlLOJB8qo/ozd+t
         tYP0srh3bj+Z0RXEpGOu8I5TPNkuCcOnc9i44zs3sQAzIDvpCyeE6yz0GBUJ4WVxGo56
         4rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6WBUYEt3xorbdlyz+i4pBQ2N1Cgz5kH2giSC34i0K0=;
        b=gB/6svP6XxLMsvUVJlYdSJ6eucVFx03OGmfQUaoobwsXl3w9rO1gZ6enN3Lpy1D6g6
         2fxg8cpEH+e/2xyNiNjmBDK7azW6pBCOFmN7BjZUDD2HFy9tA2UNCAM90DsJ6wlJJA/9
         HCuM2WhKldxwe5FMxtDzQ4/VY1nHfKAzb8MYEs4Q7wwOeYa76b4GJ9L3DUu03CvNQkSi
         zE8/r9d08LaFobOUtvLlXr4G1PBcDorVoZ9sraW+20hoZyoMEX4oAT9EIIXtbKVuqQ51
         q4dHaB5ihVk0LONocEaIZBE/SFX4MnfXbpIJRQxpUCmZwktosnXJgIThCHDvklJjLSnK
         Cw7g==
X-Gm-Message-State: AOAM531Vv7vHzT6X0ABUnKnVQNnix5Bp6d6Pbk+jh7nyYK9GFYS23I1a
        zYPqviGUitCmDSOjVWq8i2jkdg==
X-Google-Smtp-Source: ABdhPJyfZE0L1IBdWglmpGHK1PZNMYwsLWTSMikeg9MrlIACpOflG+7binSEuM55Z81mYI3WNhi9LA==
X-Received: by 2002:a2e:bf1b:0:b0:247:d88b:2b05 with SMTP id c27-20020a2ebf1b000000b00247d88b2b05mr5625928ljr.515.1650721187213;
        Sat, 23 Apr 2022 06:39:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([94.25.228.223])
        by smtp.gmail.com with ESMTPSA id c21-20020a2ea795000000b0024ee0f8ef92sm544535ljf.36.2022.04.23.06.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:39:46 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/5] dt-bindings: pci/qcom,pcie: support additional MSI interrupts
Date:   Sat, 23 Apr 2022 16:39:38 +0300
Message-Id: <20220423133939.2123449-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423133939.2123449-1-dmitry.baryshkov@linaro.org>
References: <20220423133939.2123449-1-dmitry.baryshkov@linaro.org>
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

On Qualcomm platforms each group of 32 MSI vectors is routed to the
separate GIC interrupt. Document mapping of additional interrupts.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 04fda2a4bb60..71b3be5570dd 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -49,11 +49,21 @@ properties:
         - atu # ATU address space (optional)
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 8
 
   interrupt-names:
+    minItems: 1
+    maxItems: 8
     items:
-      - const: "msi"
+      - const: msi
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+      - const: msi8
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
-- 
2.35.1

