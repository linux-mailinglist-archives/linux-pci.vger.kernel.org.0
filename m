Return-Path: <linux-pci+bounces-5092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BE688A72D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD991F63E8D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D59144D1B;
	Mon, 25 Mar 2024 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AQFwJJ3T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980E144D15
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372631; cv=none; b=YJaQd1614U311+NMWkiqmcBS1Q5HApR6gH6VqQFP2l7yDZNIP7CgFR/QXF+DshA6IMJKa0i6aLwhg0p8kDOs08ynRR1nPiMlJBplKGwjRqOfzCGuIaWxTM903341zHbDFFoQ9FcbxsSktF5DOEOkFPp4yroKiXivCKIMc0i1q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372631; c=relaxed/simple;
	bh=e+Uw5ev6GdczC1r6ejIbFGvXcTwjLsZrZJkSQw55rhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjcaS9l3Teex0kE5CceTNrAOxsxrFGBx9V1n2HMfusdAnOZimboK1KRnfMaR1tyv9Qs2fIUcQBM5vkjahBlGFSPJ39VQKoGJFmh/EhqCFDOCasML8i+Y/t1pgLSIeKPRakjekqMbFT0Ao/wgYHHWf7Y60fRe+FrwDcJ8WwYGJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AQFwJJ3T; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34100f4f9a2so2573804f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372626; x=1711977426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXqgV10wLdemUky+/tQqia1VOjmcBtD6/Htq33oA/Pg=;
        b=AQFwJJ3TLaOEDfP8sz4cnDFXMJQ/xgRpSWI5Q/cJV31/a5ckBce31dvuqGyEsEJRrh
         CtZXlkqgT9BgyE2Nh6pkQjiPuOkGDxIAJvgGUPhQ3m3GHYmxv2b0dwfS0ihrO7ZY6gPq
         031NjZqij6K4mzDbS5w+AeYfvBFX1LvMMbMIRp7HXeZMU/nvA7+DXXoMqEa8k160r7xf
         KaJi0rZWKQIMvki9tbIr65F5QvGWXFreQ99YEdOYuVgtHxmcT6/wOzYDM6mjb+ENkjSN
         7A/YNuI/BNT3nsvpFf31ZLafSVijAZn8kWciptFj9E0ZujMKtin0P9APjEXbR2fWaZ+z
         x4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372626; x=1711977426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXqgV10wLdemUky+/tQqia1VOjmcBtD6/Htq33oA/Pg=;
        b=HptyYvF+2BHHZxsGncvce8f/9C9akdzO6CV5Yd1l1490nFhZ50AMhjNNgkaDFZiUkk
         /WAiEClSHudlviqADyE3NxYvFcTatrV2VTDkSm1BUA4Ay764WzyAteTOYeKhwoyKitOn
         BGo41elKBdFpuD5yjb319W+LSg6vYkW3DZsD95Zm+J/FmCeuFM53CWj/uhIldi/XToGj
         Pheh+ZiNnB5zZWsS/NEuIUyE9iyTxaeOapcf4TdAL6x4CMqMcWveVbcY1cu5JkV8KPB9
         CyvUOxbG0u47mQ1NOs3WQOkabFbwf8gf9EMCWs/K7opmu5xyVljBfW662iPt9+Vxmskh
         szmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk40dd0ArDi4vGbhdmTNW3bPgEqzrMBZXoxrDJTY2wDODmp2Is08MmrjIyq8iWZtiq2hlmsTr76WzZNjBH8fwPV1TkFaDajyp5
X-Gm-Message-State: AOJu0YwoMiEYCfK5otqvMvDs50M6uSCmNYXj4kD4R5guDvwOGZaT83rh
	/oIgM/Xm18NFVKfAeMwbAvB+CGHRBpoSwf9Ygmarb7cDRZcGKAI0u6dmdFu195s=
X-Google-Smtp-Source: AGHT+IECJR0p9ogrxbKaWU9ZWLY0JwskHADG4SMdCz6HUsIQZgEY4wnn3jcLrif9vDvI9kW56RU61g==
X-Received: by 2002:a5d:628f:0:b0:33e:4d34:f40f with SMTP id k15-20020a5d628f000000b0033e4d34f40fmr5202727wru.46.1711372626382;
        Mon, 25 Mar 2024 06:17:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:17:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 06/16] arm64: dts: qcom: sm8550-qrd: add the Wifi node
Date: Mon, 25 Mar 2024 14:16:14 +0100
Message-Id: <20240325131624.26023-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325131624.26023-1-brgl@bgdev.pl>
References: <20240325131624.26023-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the ath12k WLAN on-board the WCN7850 module present on the
board.

[Neil: authored the initial version of the change]
Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 97 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 10 +++
 2 files changed, 107 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 92f015017418..caac40a799a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -214,6 +214,68 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	wcn7850-pmu {
+		compatible = "qcom,wcn7850-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en>, <&pmk8550_sleep_clk>;
+
+		wlan-enable-gpios = <&tlmm 80 GPIO_ACTIVE_HIGH>;
+		/*
+		 * TODO Add bt-enable-gpios once the Bluetooth driver is
+		 * converted to using the power sequencer.
+		 */
+
+		vdd-supply = <&vreg_s5g_0p85>;
+		vddio-supply = <&vreg_l15b_1p8>;
+		vddaon-supply = <&vreg_s2g_0p85>;
+		vdddig-supply = <&vreg_s4e_0p95>;
+		vddrfa1p2-supply = <&vreg_s4g_1p25>;
+		vddrfa1p8-supply = <&vreg_s6g_1p86>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -824,6 +886,23 @@ &pcie0 {
 	status = "okay";
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+	};
+};
+
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l1e_0p88>;
 	vdda-pll-supply = <&vreg_l3e_1p2>;
@@ -911,6 +990,17 @@ &pcie_1_phy_aux_clk {
 	clock-frequency = <1000>;
 };
 
+&pmk8550_gpios {
+	pmk8550_sleep_clk: sleep-clk-state {
+		pins = "gpio3";
+		function = "func1";
+		input-disable;
+		output-enable;
+		bias-disable;
+		power-source = <0>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -1084,6 +1174,13 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio80";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
 };
 
 &uart7 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 5cae8d773cec..f09406fd0ca6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1770,6 +1770,16 @@ pcie0: pcie@1c00000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcieport0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				bus-range = <0x01 0xff>;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
-- 
2.40.1


