Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85FC56A40E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiGGNru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiGGNrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:47:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB720BC5
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 06:47:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn33so915629ljb.13
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raEV4ASZ4LqZudeLorCYb5x3cLBRe57m8c3xXGSLQHU=;
        b=gaNRdNrkqGx7xJ+ecQ3qTuCBVtHgUxQrXLXxycNrizdMr2KqfBVPjvXLDKNUHfmf+D
         D9NsPWSwfCjCGnLF/v838uEvjRWLzlzqL3ajubXygiuCmCwuu19PUc8f9JNjMxhQCRqd
         bvlaFnnB1FdchOwRNtM46S8cXDfBiMjYrV3gg5K3sQJXU9QJ3kOOQo7SfnPW1xHFYe5E
         X7DWM432+thYZ+BuY+5sMo6sNN8X96TGWVj/crdJamU5O0Q3Km5BqmwSfbWnf0mZHWwQ
         9UGHX7GGLz8t9HEpsA63/+uOZPazVafF2nqQvpQSU4CmhX0D67AFzpI4P7GmqrsPRSXt
         YuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raEV4ASZ4LqZudeLorCYb5x3cLBRe57m8c3xXGSLQHU=;
        b=lpGGVatMJobL2M0SkQ4alGm0Q8lSkSExgYWzLadF1sIGphcNG8Z8kPETOdKI3qZIKS
         0OGa2aDO6X5AY6r1hP30aGrrF+K/qJjNZt3kd1EX6xMgYf81g9kXeAxPJBtd1TTwhDk1
         3RDhwyKn5sGe5JJcmj1KnRu0/w6dsuPEn27DrqeQXgl1U2QXSg+4aWVw0zmObtwj+3Sf
         O7v8//nf+QBkzMWuoi9VR0I1FIF7juyFAbJT3lXmtflSiZtbKdTYLA+1RC1QXbHBYFIc
         MnpCiYJRSZ+rzua9v+LzY4xEU7OFDdqzUupx9sQcqfmSGanBFKFO1yx1W1xfSEN1fIxc
         lnQg==
X-Gm-Message-State: AJIora92il1apayEh0e+pIDbm+KrqnXMDA2bECMZhQJn6qMZGqIm1EQ5
        cabhTkFWp5+KGbnuPiVV2oJ9bQ==
X-Google-Smtp-Source: AGRyM1tUvxXn167WjtyiP2Sxppw5pYMdK13Uw6RjG/EjA9IrwD6h3A+29DYUJvU2rhMzcg9twp8PMg==
X-Received: by 2002:a2e:9c02:0:b0:25b:6355:f1ac with SMTP id s2-20020a2e9c02000000b0025b6355f1acmr26531198lji.376.1657201660391;
        Thu, 07 Jul 2022 06:47:40 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a197916000000b0047fa941067fsm6856966lfc.29.2022.07.07.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:47:39 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v17 6/6] arm64: dts: qcom: sm8250: provide additional MSI interrupts
Date:   Thu,  7 Jul 2022 16:47:33 +0300
Message-Id: <20220707134733.2436629-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
References: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 43c2d04b226f..3d7bfcb80ea0 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1810,8 +1810,16 @@ pcie0: pci@1c00000 {
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
+			interrupt-names = "msi0", "msi1", "msi2", "msi3",
+					  "msi4", "msi5", "msi6", "msi7";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-- 
2.35.1

