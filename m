Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30741531B0D
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbiEWSjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 14:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbiEWSjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 14:39:05 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A0DD4
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:19:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id br17so14693845lfb.2
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NdSvHfXJPo04rlWXmRuhXyu21lDLotG2rBlKXKJ11GQ=;
        b=qeCNovYih/VVGim+q5i5d+UjqPof3iI+nAxjnH1cMtF+Lo8+i80KZ5p7qHr+El7X79
         V2LCW+/tJ4YDis3I0zfGdvN6sduaWnfauspfNSS1lFacl7ucZsCVIDHqEeYEv2U8qKGw
         LyttkLtO/BMxjmdsAeoi9CPrpLvJ8Hw3PG476i4CukYrgDp+8UNYx/EgFNExiPBWVEaY
         pyA7u+Tkpaw2CLxXUF3oshpAkRN6tysKYqiqKqrmNZFIMnXtNaPIvvhq3dR5Nra00ZSC
         Glg2zzWI+9qE6TYB4cTtMrZJExIalm4WiI5D1EeyBwsD3HXxqGPzwMi6OqnVee1zWLe7
         VJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NdSvHfXJPo04rlWXmRuhXyu21lDLotG2rBlKXKJ11GQ=;
        b=e2tq8cTNac+lVIftfpKMGoC54MlYaWe3JI67k3WsWR32cVb7qAZEVtX/SLJvB0RaFX
         JFPls3zhKjiWJmJA/jQraXmrkWLwQO2+Rr1zg3Zf2gL1jjcwE+gr6//vuDDoQtMiGL9i
         XmQDfTutrSBxI8acgavaSHrkIqjbLJZhVTaNh173w9j1/3h9tjRs2HcPL0aefzc0TuIB
         Vh2Jf8KEjS/9KL0Nijv0tz7/DyVrxTPT/aPHkSEwuJpma9ISuEHGqeFoClaX9IC0bblC
         xucx0QfXrUhYUtCQRKPfEh0BqlIphzQ8cEgxS47ZAzyKRSosZ3KnbNZRx8h8YTvS0sKV
         9SFQ==
X-Gm-Message-State: AOAM5334PHNsJxHmW3DU8oG8uKYPodczddaR41/k0wS/s4CrfVor+JGX
        W7pYE+1CS9P25EvttQuJ3RGD8Q==
X-Google-Smtp-Source: ABdhPJw8h8KsXgdxZynDVUcVob5YF/tetdJ+i5ncpqQIL4YJJdNGJJAIQHWZdmwVpSCXOjsPzpz9Og==
X-Received: by 2002:a05:6512:38a1:b0:475:9fee:b42d with SMTP id o1-20020a05651238a100b004759feeb42dmr16487396lft.237.1653329925860;
        Mon, 23 May 2022 11:18:45 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e6e14000000b0024f3d1daedesm1904127ljc.102.2022.05.23.11.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:18:45 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v12 8/8] arm64: dts: qcom: sm8250: provide additional MSI interrupts
Date:   Mon, 23 May 2022 21:18:36 +0300
Message-Id: <20220523181836.2019180-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
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
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 410272a1e19b..523a035ffc5f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1807,8 +1807,16 @@ pcie0: pci@1c00000 {
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

