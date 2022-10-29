Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0D612572
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 23:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJ2VNU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 17:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJ2VNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 17:13:19 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4403CBFB
        for <linux-pci@vger.kernel.org>; Sat, 29 Oct 2022 14:13:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b8so12472127ljf.0
        for <linux-pci@vger.kernel.org>; Sat, 29 Oct 2022 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AABN3JU0WwLg/3X+1uTYK5YdfpTdRR6rzCtqixbVbNE=;
        b=nHmfc3I2SdQ1sDn9NaJcEerxAVJzu+fRcCtGEhI6yFZe3W9cBkKx50xahAp5qUasc5
         /kPzL6hLxSXx68Dm/VQUZ8Wr88UQUMQU4KFEwxmiqY+lt4b3lQAD4zVb30kAWOnJGO9P
         ysMT5YaOa9bjVhsIe5P9wCybAyhJjw389vCyJ8e4FXNGbxbfo4A5FovWK+IzSlnoCSJK
         5JgzV1coPIdbQMohrjBpcrL47z279sow9j7P/LKwbVIMpKCPTv1MgDO8l94NLoKSe1q9
         gOl8obvSX1zoOKcII0BQ4gfQ31ekcaFEsiw8//vHhY9ww6Vp7uUtS4SnqyQX2hlKq33J
         F4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AABN3JU0WwLg/3X+1uTYK5YdfpTdRR6rzCtqixbVbNE=;
        b=sTP86+z4FWbdE4lguU+X3JNoOcvEAiprQUWORU8FFsPcrv2DLq115ubZMD/yXyKq5B
         JCEo3U4nsUtLNhukUwK7s06rCjUQWlFiTBIwwPU4rVN0p+sozG815esiRxgiFRX+8zc8
         cyj4G99Z967E+HqZ0z7slw/CaY2cMq9HvukDNbTzk/MBAkih9MS7D/6UI48DoLVJoAqn
         hGF3blO+PFhAV6IjzkvgbTLsi/bkm9KV4v2/BgR/P2+DSMho/N3RW007aTmPJfPFrvdp
         mjj+HO8QaMsp3Dl3D44macH1m64wo8xUxHsGlPi8pmbuxgM1nonzKDkIojkopi9uzjnv
         /Z1A==
X-Gm-Message-State: ACrzQf30QAE+E1RAVLeojbV+tREnf3JyICith6+HkZQOU8rk1JqZWBd6
        8ZZ34uTkm0Lj/xbJphGn35W+NA==
X-Google-Smtp-Source: AMsMyM66ZucE/gOMLnkKWQcgNIxxoGr6ZWjovNOs+cuhSzoxE3bP7Cl3BIzUGh9alPX9a9Qad+YqUg==
X-Received: by 2002:a05:651c:511:b0:26f:ecc3:964f with SMTP id o17-20020a05651c051100b0026fecc3964fmr2158754ljp.28.1667077996490;
        Sat, 29 Oct 2022 14:13:16 -0700 (PDT)
Received: from localhost.localdomain ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id j14-20020a05651231ce00b004a480c8f770sm433508lfe.210.2022.10.29.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 14:13:16 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 2/7] dt-bindings: phy: qcom,qmp-pcie: add sm8350 bindings
Date:   Sun, 30 Oct 2022 00:13:07 +0300
Message-Id: <20221029211312.929862-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
References: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
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

Add bindings for the PCIe QMP PHYs found on SM8350.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 80aa8d2507fb..8a85318d9c92 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -19,15 +19,18 @@ properties:
       - qcom,sc8280xp-qmp-gen3x1-pcie-phy
       - qcom,sc8280xp-qmp-gen3x2-pcie-phy
       - qcom,sc8280xp-qmp-gen3x4-pcie-phy
+      - qcom,sm8350-qmp-gen3x1-pcie-phy
 
   reg:
     minItems: 1
     maxItems: 2
 
   clocks:
+    minItems: 5
     maxItems: 6
 
   clock-names:
+    minItems: 5
     items:
       - const: aux
       - const: cfg_ahb
@@ -104,6 +107,25 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8350-qmp-gen3x1-pcie-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          maxItems: 5
+    else:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          minItems: 6
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
-- 
2.35.1

