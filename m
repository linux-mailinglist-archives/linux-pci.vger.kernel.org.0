Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91D56891E5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 09:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjBCITp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 03:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjBCITN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 03:19:13 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1FC6DB38
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 00:18:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so5198658wmq.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Feb 2023 00:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVGVV9qGjZMfe1gxAo5nZfKax+1XIxmkt82fjMeK7iM=;
        b=P5XaQfQBAwl14ujPzil4GdTDK6ey401OHEEOGYffQJraDbJKABSVD7g1VFeQvCAqVe
         MkQAbn9azYKRwkO6mJLuz2hKI7fooL2j08rjSdn+/BQByFiDR+ZUeoCHj4mqnYTHlp2g
         n9TAF3xrUPgeFehRYnQiSCMI+hjvMxi/Q2/SJV5ye6X7rusrC2oUlHcKRBpPI0ayWov+
         xgbiShkaGXrc2EMhTWSmLBaodDSsiKkrIDqic/DRrzVwTB/dE1ao3Kz/LeZ6k9PKsjwb
         NlQfZtqhHibupfyDILF7Wt+KpfziP7amnUdQW/nTea66Pyq6AtQbEvPO0AfyRpklg1hl
         wOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVGVV9qGjZMfe1gxAo5nZfKax+1XIxmkt82fjMeK7iM=;
        b=3z/0/iMHpAgXhSX/vH87OqOZCIgQZ/hI8peo9PvonF1eWqnZAa8qVZLoqc0/EDGd0E
         6yxYJ/7LaTrG9B8FAm1YTxa9yC83IlO/Rc7bWAYkdP1RaI/LHggfgbRm4yD8nVAZ4roo
         mzB5hYht2lMRbZ04VibCylmAFo05SpxeVIu6Vm6HJBKVbf7wgAzzxO182niDLR0K2tcS
         ZjDnyn9lwIqq2DO1VYRrMGs+r4EVURRhQ25sn9hA/9HiVFUpj0CjUdEFqGB97EkkNVWp
         uqcTD3nDtc9dpLmGelFXnaWQTxX54C03dntNoGyFvnBFPGR0RqYjHp/rhVxJEFFxAWar
         p0RA==
X-Gm-Message-State: AO0yUKUm7sBMGXUd8yn9KIh9if6xnvO7frBjLwgZqe6Cihe+j22+v6Wc
        97O3T6rXqzGqZEKXEfWziwQ6zQ==
X-Google-Smtp-Source: AK7set8R0udVddjd/ojCWJvkTZuTIqZHPA5y5Ms5shuNv31qjwhpw/qkjuC7DWzERcBGeXX2k/OHWA==
X-Received: by 2002:a05:600c:3553:b0:3df:578c:50d4 with SMTP id i19-20020a05600c355300b003df578c50d4mr6945705wmq.21.1675412310660;
        Fri, 03 Feb 2023 00:18:30 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id az24-20020a05600c601800b003dc4baaedd3sm7316591wmb.37.2023.02.03.00.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:18:30 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v7 12/12] arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
Date:   Fri,  3 Feb 2023 10:18:07 +0200
Message-Id: <20230203081807.2248625-13-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203081807.2248625-1-abel.vesa@linaro.org>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
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

The v6 was here:
https://lore.kernel.org/all/20230202123902.3831491-13-abel.vesa@linaro.org/

Changes since v6:
 * none

Changes since v5:
 * none

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

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index e756f83a941c..265862d0e44f 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -407,6 +407,44 @@ &mdss_mdp {
 	status = "okay";
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
+
+	status = "okay";
+};
+
 &pm8550_gpios {
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio12";
-- 
2.34.1

