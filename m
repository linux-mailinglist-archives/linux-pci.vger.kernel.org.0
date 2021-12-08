Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90D546D970
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhLHRSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 12:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhLHRSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 12:18:39 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8F0C0617A2
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 09:15:06 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z8so4893643ljz.9
        for <linux-pci@vger.kernel.org>; Wed, 08 Dec 2021 09:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wy6PRuTmEIMuhgtUQE9Eh1epb/l1hlZtagcw8/LrEbU=;
        b=kvTv6C4DVypWGEwARfUKPOmofEd1AiPIkwobEqg4MZlDhOF4WnIH4Yc3JT3QIhWNdQ
         nnZDDPRhH9Qyow80n+YW0gw5pATWqYmYKcg0Xqte8qvcO4LOWzMpYM+lc1iV3H+y9muY
         CF+HraWcBKwBpbCrdyTufnd0qWrNmuclZ5EDJuw+wZrfjT77S9dx4jfz9cX3TXR+ER8A
         jcu/X/7E7Tqdw/rPFE+eWM1vGm3XTHBSYoMdMS7mxOZlApLeEWMIuxH0ZNUmVnTgp0UU
         5pC/RXqbhetm5rVWCtxqh7Y4ilRfmSF4QXNWD0K3LGG9aIDHstzV8IrBdXwXqj0vWygE
         IuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wy6PRuTmEIMuhgtUQE9Eh1epb/l1hlZtagcw8/LrEbU=;
        b=39K+MROudG0VNwrK+r0NBsaDip3brgiKa9d8gq2b8MoEJvld5vcaeeAbWoYRUa2tOg
         VaiWWPc07yhtiQ4ik8x+Lhn4DRcu84klWo+dp5eLjxJ9mNOKCXz2rZaHKLgthgWI0SCq
         DyrbzmvQpXvOmqLN4MhV+mvvZOqS638MGoDijnwxH1Unglcj8kAU/vVBauzBUH29/c0+
         V/BOzwwJUulaNt/JmHcTLKsHwUaNSucJxE0J4hKmbodzG98p2Qzvqzq7sZ7ahqHtnQhx
         VTl3XRwnukvD4kjCmIXxrBDVa99ByUQ7frs9BWAkmnr+ukSDOTwiNuz50Gb8W6xVFGg+
         1tSA==
X-Gm-Message-State: AOAM532ADAWEvK1P7nbuMrhv9DD/GNTTh8I8gXSGRBVBjqeF7eGew+XQ
        nf/py13tShjonxDZ+mLWTXd1Fg==
X-Google-Smtp-Source: ABdhPJzWt+rW3M5J9Q9k2uKuS7PJ5quzNSxtn7Zouh8GMb+UI2nU8BN3fSgMDl7upQs9oJGaG6smuQ==
X-Received: by 2002:a2e:9dcf:: with SMTP id x15mr780862ljj.432.1638983704839;
        Wed, 08 Dec 2021 09:15:04 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t9sm307213lfe.88.2021.12.08.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:15:04 -0800 (PST)
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
Subject: [PATCH v2 07/10] arm64: dts: qcom: sm8450: add PCIe0 PHY node
Date:   Wed,  8 Dec 2021 20:14:39 +0300
Message-Id: <20211208171442.1327689-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
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

