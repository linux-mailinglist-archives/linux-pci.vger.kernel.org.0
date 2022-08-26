Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CC45A2E40
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbiHZSUp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345056AbiHZSUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:20:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56842F39B
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x23so2244205pll.7
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Krx7JS6HwCP+zNli7OEh20VEO/QUt492JvsU0Sxvwqo=;
        b=kNSZk/RyIOkFKIACHWpOIlF4r7XZ5tv+2sXm0rqBIII7YPa7b42JC52FvapjGNG3t+
         BCtEIQ2VFjDUrwM/z4h/Gr1MbwmVoWQVFJZHbJZX9gLeIvhGhFHHjhTMW7uGC1GdmNDl
         xch/yf7sZ1XheqgDTJ4Gvx+zxdFkZoElpJrrwqZCeYJ0RTdKUgJD64bnZr7bLpgj8aoE
         B1b3MuaC2L/4877BW0tlXX4R6hoqCdrpRdBV57UScxdlDLoYXNJtJ1W9P3vvDk28jas+
         vnx6wtcl8YXhc8eDhOdotLBdddrUfUMdArDEfbcVi1dKlEn52NyBYTXGLdfsr1TNFlu7
         Lh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Krx7JS6HwCP+zNli7OEh20VEO/QUt492JvsU0Sxvwqo=;
        b=Iw59eFxw084XKhijrcdj7cY9U7uEUBvwWEcNDtn9pT8RiktkP4udwN6HFcxZrcUnm1
         27qZYFVgUyqzcNBj3n3IX/mpR7w7nd8wylS6ri/hwQa1Izu0fzGFl5oBsxN8Lmxm4jiB
         VuX3DRmmwO80KZSzHgHkL6U2Fm+aUfD/hsTor+56UU+b8y1v9H8OH31gSvUWMCDsPhBn
         TpFHEJ3PA9X50L39VkXcJEdmHsVbfp/M0g5qgwSxzCoKxnCSo53OtNyrWWkyxjyjhaOx
         Qx+oei5gKg2sfHTcoXezBuj45IXbCc9YdqpW13g4V45R0MUsJ++nilnOz7HdQG4WhxSn
         GjVQ==
X-Gm-Message-State: ACgBeo35CI41WdTyKAVTfnLNBJ8MXiNc+i1G1T1aHVlRfe3GrwjS2R2R
        /VxP59FvZx0Lywc8HYJKcnmD
X-Google-Smtp-Source: AA6agR542wlwOs3ZHlG0KqBi9TI2x/74EkXIZ279ITtRyiVkVGimk1XUNGk1h4IczlqAvvgpRmbBJQ==
X-Received: by 2002:a17:903:40c3:b0:172:ef5b:2cd8 with SMTP id t3-20020a17090340c300b00172ef5b2cd8mr4755455pld.124.1661538011155;
        Fri, 26 Aug 2022 11:20:11 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:20:10 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/11] dt-bindings: PCI: qcom-ep: Make PERST separation optional
Date:   Fri, 26 Aug 2022 23:49:19 +0530
Message-Id: <20220826181923.251564-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PERST separation is an optional debug feature used to collect the crash
dump from the PCIe endpoint devices by the PCIe host when the endpoint
crashes. This feature keeps the PCIe link up by separating the PCIe IP
block from the SoC reset logic.

So remove the corresponding property "qcom,perst-regs" from the required
properties list.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 3d23599e5e91..b728ede3f09f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -105,7 +105,6 @@ required:
   - reg-names
   - clocks
   - clock-names
-  - qcom,perst-regs
   - interrupts
   - interrupt-names
   - reset-gpios
-- 
2.25.1

