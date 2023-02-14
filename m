Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCF4696611
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjBNOK6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjBNOKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:10:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293C22A145;
        Tue, 14 Feb 2023 06:10:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lf10so8514247ejc.5;
        Tue, 14 Feb 2023 06:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyRxgGKgBmZ7vlz9B0DPHOS/vRaGIdO6oxSW3aBTwD0=;
        b=DHncKPYs87waR3yJGxtEcKoh3OyMcA7zdF3rOXm3j38m6CDX/iQqffz0+04g2A3+bf
         GffdS4BULOVh9kWWLEh+LXl/+mJ+a7Yf3ZD9CBZjCpZhYzlggO3VwSBmaLjwzja2RdM+
         gxwVHpFgOFkY3b53Xeh42awaCb4Drw0n2jtMHW+uflM4ToEFt25BrIOlPHfXCCtiZJ3K
         fJg5HIcSYpEXucDMsRiqCNeT22ekeN8gi94IbFbiN1VwItRwUoutXOn3UbniynDjb/1q
         S7ct7A0a0AnO2Lbl0LnFqsAO3+LBOkQQTuO6L3AoWQBKrlynHKDcIk/cW/BdVu/Qk9bW
         g7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyRxgGKgBmZ7vlz9B0DPHOS/vRaGIdO6oxSW3aBTwD0=;
        b=AKPdcURQ2jR53KnPTtvnYHMPSxEPFsJKihoKtyDB2wLAavmkaxfOpb2xDbfcAhQZX9
         yJFOdBc7HpBF2wtsKGIciBCIpR2BuZBt1ysd0PPwg868B+HxVsUw06MiZ6ZDIj65DkrS
         MRNFTmX0VZJikQNV6o0TEfPoDb2f/Q4CuiWeSuWGHb+d3pJQqdGzhVBlH2RHAzyfidOn
         uc75VMJ9U74eEhblFKTK/9nJInYeobTSTs2/CciVRYFraIIAfys/uVJZ3AlDuN+ifDJj
         V++yUq1tVIyS1rPnRHIKTv4qr8NfPZAKdAwcSEM1WZh/2wdYIhuUqDX0mmZc0MH777pC
         BYug==
X-Gm-Message-State: AO0yUKWx5xadOplZ0YzjWvJ8ypiyIOZ2mnYKhLkr9NBvlSLA57DL/LdQ
        N3WI2pINAegLMNdDAj6nOGY=
X-Google-Smtp-Source: AK7set8457lF/1ct6QNmD+ni295zwiDN6/EivlGIF+JpLzVOpzazEgBBkLErUzQwRm93A7rAOTYAOg==
X-Received: by 2002:a17:906:2f06:b0:878:714b:5e16 with SMTP id v6-20020a1709062f0600b00878714b5e16mr3011287eji.28.1676383806487;
        Tue, 14 Feb 2023 06:10:06 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id n11-20020a1709065e0b00b008b13814f804sm332241eju.186.2023.02.14.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:10:06 -0800 (PST)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 5/9] arm64: dts: rockchip: Add dtsi entry for RK3399 PCIe endpoint core
Date:   Tue, 14 Feb 2023 15:08:53 +0100
Message-Id: <20230214140858.1133292-6-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dtsi entry for RK3399 PCIe endpoint core in the device tree.
The status is "disabled" by default, so it will not be loaded unless
explicitly chosen to. The RK3399 PCIe endpoit core should be enabled
with the RK3399 PCIe root complex disabled because the RK3399 PCIe
controller can only work one mode at the time, either in "root complex"
mode or in "endpoint" mode.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 9d5b0e8c9..8cc5a1ee2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -265,6 +265,29 @@ pcie0_intc: interrupt-controller {
 		};
 	};
 
+	pcie0_ep: pcie-ep@f8000000 {
+		compatible = "rockchip,rk3399-pcie-ep";
+		rockchip,max-outbound-regions = <32>;
+		clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
+			<&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
+		clock-names = "aclk", "aclk-perf",
+				"hclk", "pm";
+		max-functions = /bits/ 8 <8>;
+		num-lanes = <4>;
+		reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x0 0x2000000>;
+		reg-names = "apb-base", "mem-base";
+		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
+			<&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
+			<&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
+		reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
+				"pm", "pclk", "aclk";
+		phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
+		phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_clkreqnb_cpm>;
+		status = "disabled";
+	};
+
 	gmac: ethernet@fe300000 {
 		compatible = "rockchip,rk3399-gmac";
 		reg = <0x0 0xfe300000 0x0 0x10000>;
-- 
2.25.1

