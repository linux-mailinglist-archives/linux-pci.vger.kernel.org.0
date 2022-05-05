Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68851BB9E
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 11:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352008AbiEEJQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351951AbiEEJQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 05:16:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3A54C78A
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 02:12:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x17so6422296lfa.10
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ga1FXFUoff60uV1gZjfSxxZrosbrRhkS2aF6jySEeu8=;
        b=W3tyAprDWp6UyDWYOdLrEzdJRss3YRRpqzy/uk0dYDH8QNfXcnaSp0CqWZ+wvwsLyL
         oAsAwF4GR9NRKLP7bSNYHld3TK6NV1t2Pmdu1ZYmvLEyOf/CprNYm9D5nXMhfjOmhiOM
         RWSy6eMW8s8wVq+5xJtCMjB9au4uTac8PUJpjgsIrsPvQYgJs70LuVXhTnXYGko96ev8
         1POUYPIZ+cq6p1NEJ+CYQRxR+p6OhAuiajCBJoJvKLPy1YfbYoiKt2K2j3lfotrnfvH1
         pc9FBAm14Yq+Wa5ZPOaXLM0fS1kx2VfOXzCYjNRwlcWqSgyS1N7VINWFJSyfxASNbSh4
         Wm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ga1FXFUoff60uV1gZjfSxxZrosbrRhkS2aF6jySEeu8=;
        b=wWuduWMxLWVhFu8wCvNGZsxBZVoCl0aIWek3x7X7NBYLbN8I2KJUSAM2qEQ2e03/qG
         9jpm4ivS5mkjlNJUWlBA1jWQr80PPlBoEF7SUc1yojwlXOM/29Ll5owxjQaLORPn8bv4
         hrp+wQ1VmvXjPK18Tk0NmyGbZ8eQMqhKJpaj+KzNqbC4qvgVeds3eq4vLLhATy5NEj/v
         3UJCaatkzkP4Q3EGkoZnol91On7dltCF5Yblu5Tu0+ZHEFUNU6rJ6r2XShO6u46dM3ov
         nu++ztujf+jZKlKKx5DxOTCGyi3Z5dwuQLEsj3QHiC6c1IVE8naDvfK6QLfapbddVhF8
         NKCg==
X-Gm-Message-State: AOAM531HXnq8/lz1lY24vPIfCQh0m3YQnacrIc1lSAndQFgGGaf20x+W
        comaNNRJwbbnyYl29hsXfYsFrA==
X-Google-Smtp-Source: ABdhPJzZlSdGDF1bKE1X4lKCce+HRMOaUZjOQni3fefl0hld3wq50mbnLmt9CR8cvex4VIClMGVu/A==
X-Received: by 2002:a05:6512:1513:b0:448:39c0:def0 with SMTP id bq19-20020a056512151300b0044839c0def0mr17057736lfb.469.1651741957121;
        Thu, 05 May 2022 02:12:37 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2593a000000b0047255d211e8sm133564lfi.279.2022.05.05.02.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:12:36 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 7/7] arm64: dts: qcom: sm8250: provide additional MSI interrupts
Date:   Thu,  5 May 2022 12:12:31 +0300
Message-Id: <20220505091231.1308963-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
References: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8250 each group of MSI interrupts is mapped to the separate host
interrupt. Describe each of interrupts in the device tree for PCIe0
host.

Tested on Qualcomm RB5 platform with first group of MSI interrupts being
used by the PME and attached ath11k WiFi chip using second group of MSI
interrupts.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 410272a1e19b..0659ac45c651 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1807,8 +1807,15 @@ pcie0: pci@1c00000 {
 			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
 
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "msi2", "msi3", "msi4", "msi5", "msi6", "msi7", "msi8";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-- 
2.35.1

