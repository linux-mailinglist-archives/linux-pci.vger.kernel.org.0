Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5EF46651E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 15:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358525AbhLBOVj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 09:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358520AbhLBOV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 09:21:26 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DBBC061785
        for <linux-pci@vger.kernel.org>; Thu,  2 Dec 2021 06:17:40 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f18so71865538lfv.6
        for <linux-pci@vger.kernel.org>; Thu, 02 Dec 2021 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6/zIL8YkV/d4nljUzUQ3EO3Yb/Px31H+9eOQZUkZows=;
        b=yFe3VIuDiF2HeloldqKDVzEA4IYkyMvccBtnEUiRlVCBG+YvE05TW4M2c20kJbDm+s
         8Sj18A/VD1MiiETWVrxjxSyxttfnozdB6IGJnds1W5Cn/O9WXv8rxwfriZbwimetLoDr
         yZwiO2W4P6C2pHGJP1gdhk4Hfg8OTMwDvgKC6sxee3s0T3L6aXxZG/2kgrFLWxK6UvWi
         PCrby6iTedngcnfU4RpLf1A+eyx2eXeGFOzmPBA3PCR4qnoZ9yLP07LorD5gVz1B3L04
         NvqHvQNn5dto5rbxz3Hrb9sepTZxbNBA6Myik8umQV9ubPqKrCuiHGTdATBBwUWRP/Ps
         clug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6/zIL8YkV/d4nljUzUQ3EO3Yb/Px31H+9eOQZUkZows=;
        b=ZN4zMJmYaHVqKC6OQRC5pmVskW37dF7FseGioW2jFZN90rVgdF1FWnJANYk01sHrAW
         VX087UywfQyKP2UQbb9OxwUds0RbJnTfe/WmpOBVH5moOjKY1seELLaKGs9aXBuHcPHg
         /mSD2MujzbbdQt2L/fmulPu5j36JE4gAe3vjpkAk/EiMr35wWxnVz3vjySMfmdtuNAwq
         +sd/ymgdRmMwwYpTWH32eDo1l2NaU4v/yAh8Bsmg/xDEuc6OSDoMDA1MIgKcprUkThpi
         oHdeDCPcHmmwdUXJsqmsOQ6gCH9YWdUGQUMxhwRWu3gUBxuAL+8zeQHThqPYloosULIF
         UbDg==
X-Gm-Message-State: AOAM532tnwixioBc1f6XArXa7nV3217EuPD5fF7F5npOEwZG6yg2KPg+
        /Nfy4VN5X78UqF/xCfXskUZi6g==
X-Google-Smtp-Source: ABdhPJzvu6wYr/1+YToSts0ncZnkplVB8E/G7vfYGcl3krUyERz6LIyDpd3Ry/OriVXwMgIMXaa6Rg==
X-Received: by 2002:a05:6512:a95:: with SMTP id m21mr12552889lfu.574.1638454658759;
        Thu, 02 Dec 2021 06:17:38 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m15sm362487lfg.165.2021.12.02.06.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:17:38 -0800 (PST)
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
Subject: [PATCH v1 07/10] arm64: dts: qcom: sm8450: add PCIe0 PHY node
Date:   Thu,  2 Dec 2021 17:17:23 +0300
Message-Id: <20211202141726.1796793-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211202141726.1796793-1-dmitry.baryshkov@linaro.org>
References: <20211202141726.1796793-1-dmitry.baryshkov@linaro.org>
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
index 3e1279f5114e..4e825291839a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -550,8 +550,12 @@ gcc: clock-controller@100000 {
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
@@ -579,6 +583,40 @@ uart7: serial@99c000 {
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

