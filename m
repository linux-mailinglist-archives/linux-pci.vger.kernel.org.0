Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B34710BE
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 03:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhLKCVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 21:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241121AbhLKCVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 21:21:46 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D9C0617A1
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:18:10 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id cf39so9084535lfb.8
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wy6PRuTmEIMuhgtUQE9Eh1epb/l1hlZtagcw8/LrEbU=;
        b=OfwlpSgVRWdrSRtKJ9LkXRsLDJDbVctMLNM57ZoNt/KNoiJbTtLYNABkItj9ftMrse
         XaNGT3JNbz8RLdRBRPUxaeoXDCdBB5iaoK8Od8rMSL3N6VhNftJXsgSRxCcxd89k3YNZ
         3SwASbtUv68yGvHkk6ylcdYA2EA4M1ZSPd4vypyCo180OhHVpKUe4Fij2m4e1ptQpOZk
         KGgPnenz8OQimip7MDJ2wVRgQFx0SEKfkC3BL1UTRa12o5kuhsA/dkleCrZBNca6c6dI
         XBjHIfVItPTuYR/vUyndx8MRk/cPOvxtqXGa+wPKS6nvR4bLKQihJrjMXdv7CMH1YJm2
         SoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wy6PRuTmEIMuhgtUQE9Eh1epb/l1hlZtagcw8/LrEbU=;
        b=gq+UK4Ib892+wQGcKMy5Myq8jswCmzLB2M4kn5z6JV4wA42zW6ppXh78gNpeCbRC7o
         dkSH7LTCd1wgo8S2QDVfu0+euz9NPOrmHRtY37XgEoD8Fiw/MzcAQlMBpQoFryLJlzYL
         eSebmzZbU/KQIZwE0tAEhrFjONsdqtg8wf0VMrYDFkUVSHzr5qJmY0peesO41k4FT25u
         +IodytdfWdZi7azQi3Pk/vcwtAZmLjwxV3sKMGtjKDU49vmXcdpIJ9lEKTL480Vz59pH
         M9T5wdgFeEuOohT6Rf4WDkeN1aXHXOImBWg/9eTz29X0WM31dCkmcRpltqA3wP8C5UCy
         j4dQ==
X-Gm-Message-State: AOAM531vO3pACQNRdbota7moDSQFbMDq3LJUwIqV+kponFnOz9CNi6u8
        cY7ViPGbv0N3fkHEsbmBz3YQ1w==
X-Google-Smtp-Source: ABdhPJzmXShy36/phvBmUI9smRRo4joSftJpGMCLSDaUtDXtqRpWk3cZzrpEFD4H18oMDTuBUhZoNQ==
X-Received: by 2002:a19:6717:: with SMTP id b23mr15861453lfc.659.1639189088517;
        Fri, 10 Dec 2021 18:18:08 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y7sm504663lfj.90.2021.12.10.18.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:18:07 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v3 07/10] arm64: dts: qcom: sm8450: add PCIe0 PHY node
Date:   Sat, 11 Dec 2021 05:17:55 +0300
Message-Id: <20211211021758.1712299-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211211021758.1712299-1-dmitry.baryshkov@linaro.org>
References: <20211211021758.1712299-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree node for the first PCIe PHY device found on the Qualcomm
SM8450 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 42 ++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 16a789cacb65..a047d8a22897 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -558,8 +558,12 @@ gcc: clock-controller@100000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			clock-names = "bi_tcxo", "sleep_clk";
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&pcie0_lane>,
+				 <&sleep_clk>;
+			clock-names = "bi_tcxo",
+				      "pcie_0_pipe_clk",
+				      "sleep_clk";
 		};
 
 		qupv3_id_0: geniqup@9c0000 {
@@ -625,6 +629,40 @@ i2c14: i2c@a98000 {
 			};
 		};
 
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sm8450-qmp-gen3x1-pcie-phy";
+			reg = <0 0x01c06000 0 0x200>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_EN>,
+				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			status = "disabled";
+
+			pcie0_lane: lanes@1c06200 {
+				reg = <0 0x1c06e00 0 0x200>, /* tx */
+				      <0 0x1c07000 0 0x200>, /* rx */
+				      <0 0x1c06200 0 0x200>, /* pcs */
+				      <0 0x1c06600 0 0x200>; /* pcs_pcie */
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				clock-output-names = "pcie_0_pipe_clk";
+			};
+		};
+
 		config_noc: interconnect@1500000 {
 			compatible = "qcom,sm8450-config-noc";
 			reg = <0 0x01500000 0 0x1c000>;
-- 
2.33.0

