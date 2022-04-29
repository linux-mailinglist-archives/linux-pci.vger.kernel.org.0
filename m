Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFF451571F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 23:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiD2VqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbiD2VqS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 17:46:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F257B107
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h29so8972189lfj.2
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ga1FXFUoff60uV1gZjfSxxZrosbrRhkS2aF6jySEeu8=;
        b=oNLo/b51zfyFKstJMQDnjvpf9VeALmD680kH2A0067LiI5MNT51qmjn6MJaYuS1q/R
         Uoe/MbXnUHF0H1PPc8ztQXUehiV9ADXYpyXwrAwNSegD/jRo7sNGO6aCdiVf2soPXaDk
         keAgo8QDh0FMEJp/QeAUtHholrREcdj5IsHW9Z6dZp+Ldb7jNM7aaaa2mHXSGa+Y5k5e
         rG06Fqdn4CRotrYldskG6W8u8bCHFknkSm8Lx6XUx38p8ODCG4Ejz5jrverngZObQ3fM
         q6MbxTAi701l9WJkXbsIh2gyNjfzUErt6ux2beoU8nHHqe1HgWjc/u/NYOnaaWUkz4y9
         0ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ga1FXFUoff60uV1gZjfSxxZrosbrRhkS2aF6jySEeu8=;
        b=qXzVcw4XUJj3fFSn0efoYpL/nlYvPGCJdXlTAqdqmzsv21LpQLfyn+LDKhK5WwPlQl
         jraKB1o29adOczByzteJAlI6I+9/3xUeqt4AAOVqEdr4qedxwwnlGfn0ZIp3+7xLQN67
         K/fHR1YT8EZPM5SHM9ztIh+H2nVa6RKu54GGaAQOOHQ62MsS2iY4MyPkWsUoIImfpts1
         +sVPPsRCzQyxDrHdzdNtx5FGy/DAaUyl7Ls6OnAVjOFunpQ3+7UPHRYIQmJgr2b9ZxBO
         E+gxjhPWQ29MPckQpAoOM4mHuh9LLIq/UehSBB+zUq3sZzID00w4mRFSm9Nf5wYgWrZ+
         NAtQ==
X-Gm-Message-State: AOAM532E6NIbv/VS6WxvG3yKQYC5Qjr6mbQnAL49VeFUzI6vRm20Xl/C
        gimW62ogEutWw7dclx5IuK8Rnw==
X-Google-Smtp-Source: ABdhPJxzORLbmlqEy7JgXTX/YqDUJtTE3Q7VB19TW6sgdWivoP2IIKBBtEOE7Gu51kNxh34lW4G4cQ==
X-Received: by 2002:a05:6512:2216:b0:472:3e84:7c40 with SMTP id h22-20020a056512221600b004723e847c40mr869034lfu.533.1651268576680;
        Fri, 29 Apr 2022 14:42:56 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b0047255d211f6sm30520lfc.293.2022.04.29.14.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:42:56 -0700 (PDT)
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
Subject: [PATCH v5 7/7] arm64: dts: qcom: sm8250: provide additional MSI interrupts
Date:   Sat, 30 Apr 2022 00:42:50 +0300
Message-Id: <20220429214250.3728510-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429214250.3728510-1-dmitry.baryshkov@linaro.org>
References: <20220429214250.3728510-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

