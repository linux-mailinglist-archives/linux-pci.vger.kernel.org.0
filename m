Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B52D673B47
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 15:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjASOGv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 09:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjASOGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 09:06:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB6680178
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k16so1628194wms.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyPmIKhrj5llOSZUdUq5Kr/KaLcp/C/7nBe8Tyy5vk4=;
        b=Ro0EqqAi9yh4lpsziLAifpMMIiVgu35zQr/kylSTf6VsCoedWvgRvRk+1jDdX0XIYi
         dLMOCFDVto+0Kg78ScF0l2ebFvoRj1Fq09X7dT2NMIBhnhnUUbSOO8iMSQKKE0m/Rd95
         6v30MpHu2PuwT04eAsBLxoauENCr9MMqdxoRqzVWREkv48G7fx2K8Gk28aZi8dGlOZJX
         Rcfx3+F72UebuTmN1B/iHf/H2Kk0V5B2BosmozETT+F3XdDCRRfEmvt2gAxkGNHhclCR
         5DXbqljI/MNaaKxdDxGspyYOdiLr4jmb/fjq76EF6kvi0q1TG6XfKwKZqrp1y/jFwdEC
         bdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyPmIKhrj5llOSZUdUq5Kr/KaLcp/C/7nBe8Tyy5vk4=;
        b=3UKSVoe+C8Flk0WxP2g5h45v8hDLRP68eCtAcsQWlgwubOknoWKUqxiLVQVvrZv890
         i4qhShieOooUC/TsBy35qWCGpceuOGOIejXlRAnYiQ2FCaASkItHUDzWlLr93LW13aRI
         l9BdjWhXlpcyfSfnEq52Z3MeE/TDUheTPbCw6tdwINEWSG2DmN1XzGq3x8QcLftUaP33
         iSkvuFPtAbZVLdse/ULiINiUgYXfbiWGLaqnvQdevhn0u40XC9jFfVKG3qEbix+v2CDb
         6OhY52iiVmTyTZLJTWCQcPhJjPvj9dk5nMomA92mHG1nhsiCsnqvOVRlRoPMtB0mmv29
         YqgA==
X-Gm-Message-State: AFqh2koNuIlaPvT7I/J2e8XffDaSySfjVPTcXvfoSU12c4fHBw6zVk2d
        ZqYlEW24o45rF9oceWErhX9eTg==
X-Google-Smtp-Source: AMrXdXtz9rqfygqM2faXYVw6dTuktiFobisglXW40wIIAv8MVziyyjsOF8Jgn/ATvMoD1cN4YsQYHg==
X-Received: by 2002:a05:600c:3d19:b0:3db:1810:8c9e with SMTP id bh25-20020a05600c3d1900b003db18108c9emr5298390wmb.38.1674137126642;
        Thu, 19 Jan 2023 06:05:26 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b003d96efd09b7sm5263883wmq.19.2023.01.19.06.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:05:26 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 12/12] arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
Date:   Thu, 19 Jan 2023 16:04:53 +0200
Message-Id: <20230119140453.3942340-13-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119140453.3942340-1-abel.vesa@linaro.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
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

Latest version was here (v2):
https://lore.kernel.org/all/20230118230526.1499328-3-abel.vesa@linaro.org/

Changes since latest version (v2):
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



 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 81fcbdc6bdc4..b69ded9c4b57 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -359,6 +359,35 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&pcie_1_phy_aux_clk {
+	clock-frequency = <1000>;
+};
+
+&pcie0 {
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
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

