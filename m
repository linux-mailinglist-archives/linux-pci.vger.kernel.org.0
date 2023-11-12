Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B197E9219
	for <lists+linux-pci@lfdr.de>; Sun, 12 Nov 2023 19:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjKLSqL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Nov 2023 13:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjKLSqL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Nov 2023 13:46:11 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26842D46
        for <linux-pci@vger.kernel.org>; Sun, 12 Nov 2023 10:46:07 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da37522a363so3769520276.0
        for <linux-pci@vger.kernel.org>; Sun, 12 Nov 2023 10:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699814767; x=1700419567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0UezdLYD5scNL5kYSvTIK/LGcnTqVfERy2ExLqUR88=;
        b=VCKr8s05r+s7F1MKoBjoD9X5Yju/zxitaUofUYbxEcZRUVgOW5BfpPbmegldxh6aUv
         U0HdQ4gEfBsJ4rb7HgTCfT+Kp948hd+DZIun+JuZ4CBlFJXP0iDV19GWcH+juCKOX1z4
         wnuXMsKM+Du/f4T7Qwti/Jk4C2EDFBYgW6ZioMx0fuskJBDIqHYcVA2ceilM7WTYRSnG
         l/S+5GoC0Rkj+5NzXUltr1HzbsC0lVlkehEODlkdnOomVpQCF0mH0D9WMZ0+7QqsfJ8Z
         2kOdHBp2KVc/vCQ5JflzJ48q3QkyUwVJQKP9w9uN8ddnoIilwW64BmOCVnSQgAtH/IMA
         ISTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814767; x=1700419567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0UezdLYD5scNL5kYSvTIK/LGcnTqVfERy2ExLqUR88=;
        b=iMRZlLqvbveSW+oFojnBVihOnOfcoiXU0EDMgB2V9KYze0hFfdXhe71QJqVDGaJSuV
         c+hSrTu8uPSp1m5nb2FEGF4swC2fv17FK1kue/UIlax3PDir5+VOF8xQt+6hTmZ7GTjx
         x/nyZkfyi9UxUYa2VYfWYWnq4Hl5bxrA+Yv0lc25BIVKpzaHHLkfR8LiVBUBqoxcEuyY
         SuxHf4KJiE1IJ5dLyWojar2UnFcT0JzuuWG5MfbyxMPVEMj+zM1fEubRj8+AabFJaYRy
         LLrIytjHrDGY5+zdxqZf0xF2AY4xhIBDv07Isie5bV+w74lWf8YvdMqBWtrZCmVk3pV+
         cekQ==
X-Gm-Message-State: AOJu0YxjZU30ykkBwqG5BAaSrZPEVkx4THx57ooxwZPO889tVs3RmqG+
        GX3LJ4UdW1kCC3LPRhkx5gelYg==
X-Google-Smtp-Source: AGHT+IGzMDV42Dc+z6kVlgJlDpbc3rB95mpnZwob8pQsfQOsfIb2nXUi2vL3ixJhYc5tnfaiJtoJ4A==
X-Received: by 2002:a25:33c6:0:b0:daf:6259:43d8 with SMTP id z189-20020a2533c6000000b00daf625943d8mr2987278ybz.36.1699814766920;
        Sun, 12 Nov 2023 10:46:06 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.170])
        by smtp.gmail.com with ESMTPSA id o17-20020a258d91000000b00d995a8b956csm1104185ybl.51.2023.11.12.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:46:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: PCI: qcom: adjust iommu-map for different SoC
Date:   Sun, 12 Nov 2023 19:45:56 +0100
Message-Id: <20231112184557.3801-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe controller on SDX55 has five entries in its iommu-map, MSM8998
has one and SDM845 has sixteen, so allow wider number of items to fix
dtbs_check warnings like:

  qcom-sdx55-mtp.dtb: pcie@1c00000: iommu-map: [[0, 21, 512, 1], [256, 21, 513, 1],
    [512, 21, 514, 1], [768, 21, 515, 1], [1024, 21, 516, 1]] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8bfae8eb79a3..14d25e8a18e4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -62,7 +62,8 @@ properties:
     maxItems: 8
 
   iommu-map:
-    maxItems: 2
+    minItems: 1
+    maxItems: 16
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
-- 
2.34.1

