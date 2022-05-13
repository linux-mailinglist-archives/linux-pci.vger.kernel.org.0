Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF37352685F
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383022AbiEMR0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 13:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383008AbiEMR0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 13:26:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D738719C0
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:26:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu29so15763889lfb.0
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqdAfmtIDWHLF/VJbRu/tBP/l22n+nezjJyshDnmIDw=;
        b=quOPmoPLd2qaymHBYrjeDCKDOWC2K/fHideqJhkjMZsw3KcQDkyK3SyArWKpj0MPdR
         xHh81efs8Sic7uBNHfZmXiup2NBtfSgnHSBRxopweJ7wequlaGoi8udhHaa4T3XscCJr
         zamNm/trJwgqfMfQ/XNmKzd+miW756EDSEamBHMU3Lv/lzHEyVfSrC9WLlLsPRaYNX78
         2P7FiLFKSsDdmaKcvVcfASDP20u9PMQ9hidL0wBDdjrjGRW55q/qBRBq5OIEHjl+Mksi
         QI81gkDL9ym9V4rUDAmjq1mPH0WmUTm6neoM+mlkln0qYevV7PNsle6MH+VST1YwsW7B
         ft9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqdAfmtIDWHLF/VJbRu/tBP/l22n+nezjJyshDnmIDw=;
        b=DZj7tpEDlHcx5xU5ZMXGf5FRSrGhg+rQarwoKZRu2Nwz1tQCAIn2HRWum3zp69c6wC
         LFnQCiTTEokhH131FqGrekJu3VdgiSUfhCupGlNTXlRmkmvldcwZXbaSkZIYF/bPKrPN
         wKP2bFcx4pEwBCc7/zxRWUW0fHhzP0FyjptMGl+AWkgL4hubhnWEbYKBET0RbNmqJqKk
         Gwxhklgdb82q06ZB0hEpISvwq0jEEpJ6BYtv8RFoK/264t6ww1uw2cYOsMZIOhbXgFc9
         CYnpLAMhVrejCQQoxl2OOLRht1PH25fV2NBNUChPjEnNQNdhW/kwXrv32JoVpj3OUfKr
         9beQ==
X-Gm-Message-State: AOAM5313j10cIdcpbf7RMeTCva+o8YX2qK07N99N8y5Xas0AYKYt0IbP
        fXgN4dY+F+y8FR+SSfPHfc4m0Q==
X-Google-Smtp-Source: ABdhPJxRphhdD2xEkJn02DzmDn0/V1iJ+P+Nqjok+eL8fbf7qcpmNN04/QVx3ljuuqTSF5hgJk6T0g==
X-Received: by 2002:a05:6512:203b:b0:472:4d8b:b124 with SMTP id s27-20020a056512203b00b004724d8bb124mr4169275lfs.241.1652462791946;
        Fri, 13 May 2022 10:26:31 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e8183000000b0024f3d1daec0sm511157ljg.72.2022.05.13.10.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:26:31 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v10 10/10] arm64: dts: qcom: sm8250: provide additional MSI interrupts
Date:   Fri, 13 May 2022 20:26:22 +0300
Message-Id: <20220513172622.2968887-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
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

