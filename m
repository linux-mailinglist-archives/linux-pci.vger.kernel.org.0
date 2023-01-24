Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AAB679883
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 13:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjAXMtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 07:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjAXMsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 07:48:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E106182
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso12736352wmc.4
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmxwKRwgMkvDoX/KnOxwn8Oad6lb6c+WQifHQxcxOEc=;
        b=FYiBwKa35DWkzQ7j81Fy1fx9TUTExvKgXy2CCwctwSdzBVeheK+IttrEAC/ETe1EeK
         W6pTqY6vdQIu5OeMoBi5ykV0bNXQEQcNlYLhEYl/c/hrjXANIeZJBSVq53+wCX20yCoX
         yyBHuad2Xj6DD7X6AVd0P370eE5eOtgxau8Q+6ib8pXb8Ky3+mPDj63Ek5P6dieIhWy2
         +rQ65PjSPosaZRvZRLx8jp6HXLm6WdvchQifiY0vM22iny8Ak4zyhJw3y8OsiJ9xXJ2+
         PeFG3pWzrbd3Blz/YIqBS1GCtPU/bpGc6SYAS/5ZXC1L9Fhnzv89cxz59co5dW1obqnN
         PiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmxwKRwgMkvDoX/KnOxwn8Oad6lb6c+WQifHQxcxOEc=;
        b=7HOAxd01lZ+M4gmB+xt5+81nJ+DSBIDtgeLIyxjU4s7LtKTgqWsw3LpmOouaFlunlS
         udU/V/qxRUNDCNUbkL4WeubKt0dgZ7eqaqChSu5zcQeB3Z9G72UNhUWLbDkwtsovOoiw
         82+ilYQmw8VSxCIgKjM74U4VD/doZJ3yR8pyrDxj9byrKtOIzYBfwslg3I5odpeunNNx
         35EOns4Qsb3c3/WT02KFcdq4OpRK4EK1fLeWjMd08HYdHxPu+RVoULF51NuaBOzd3BBg
         Z3vGPSSHbQnOcqLUEE/1VTKou2i7MTeYCTM7SEszof8Elh7pCFXruiVeAQHx2rrc/Oh1
         xNXQ==
X-Gm-Message-State: AFqh2krFXVpABYIQ87DLc2CXQ9sS2/DzUzt8lTuFmgVaFT378SsCMwYS
        eWEcrX4dmUAdDEq8Ke6qpZH3hw==
X-Google-Smtp-Source: AMrXdXvAgpKt63Oz3NCXx6cY0Sb1j3ZgYXfQIwSjkUsBwo/uBUEf/kEPiUkYZk/vC91kl4DwXQ+Dog==
X-Received: by 2002:a05:600c:6001:b0:3da:f80a:5e85 with SMTP id az1-20020a05600c600100b003daf80a5e85mr27274855wmb.26.1674564460550;
        Tue, 24 Jan 2023 04:47:40 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d5705000000b002bdbde1d3absm1766840wrv.78.2023.01.24.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 04:47:39 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 12/12] arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
Date:   Tue, 24 Jan 2023 14:47:14 +0200
Message-Id: <20230124124714.3087948-13-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124124714.3087948-1-abel.vesa@linaro.org>
References: <20230124124714.3087948-1-abel.vesa@linaro.org>
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

Enable PCIe controllers and PHYs nodes on SM8550 MTP board.

Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This patch does not have a v3, but since it is now part of the same
patchset with the controller and the phy drivers patches, I had to
bump the version to 4.

The v4 was here:
https://lore.kernel.org/all/20230118230526.1499328-3-abel.vesa@linaro.org/

Changes since v4:
 * moved here the pinctrl properties and out of dtsi file

Changes since v2:
 * none

Changes since v1:
 * ordered pcie related nodes alphabetically in MTP dts
 * dropped the pipe_mux, phy_pipe and ref clocks from the pcie nodes
 * dropped the child node from the phy nodes, like Johan suggested,
   and updated to use the sc8280xp binding scheme
 * changed "pcie_1_nocsr_com_phy_reset" 2nd reset name of pcie1_phy
   to "nocsr"
 * reordered all pcie nodes properties to look similar to the ones
   from sc8280xp


 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 81fcbdc6bdc4..31e039f10a1b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -359,6 +359,43 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&pcie_1_phy_aux_clk {
+	clock-frequency = <1000>;
+};
+
+&pcie0 {
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l1e_0p88>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+	status = "okay";
+};
+
+&pcie1 {
+	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_state>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l3c_0p91>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+	vdda-qref-supply = <&vreg_l1e_0p88>;
+	status = "okay";
+};
+
 &pm8550_gpios {
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio12";
-- 
2.34.1

