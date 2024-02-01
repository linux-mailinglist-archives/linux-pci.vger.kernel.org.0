Return-Path: <linux-pci+bounces-2931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91072845C37
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E5C1C28173
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F20779FA;
	Thu,  1 Feb 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WEHm7RkL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E2626C3
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802946; cv=none; b=qUFeUUY8HUdciAjh3NyRT5gDZdT7vggDt7w7UwP73vJJ/Zan9oX0togiJcFexVRt3HVy734CRwCAFtFLZPsRbI5pBmDpWcZahBMmnUt77OpjhljycV/OnIDrNqgK7h8ad/CI0gf9lkIH7ZIfijk62EW2J8r7PuIMytPXQanRMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802946; c=relaxed/simple;
	bh=Ro8nI4ZmUAzUJhKghzcODaHoy8Q1RxeHSiWbHdIN/6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dUkESomByjZYDqSl3dmQ8XiFp/8hqNG5Ijx/fh4ktjWdsUggWfwfwKzMhf/vVrHBVIxshQvpOkKVM4JA8/QxOkMhy5Z9Axp27EHlPn6dVcatbhw2chy6a9vvxfSJ+wUMYKxNHrurBxWun8MtU/oUCMwe3bRVPBoBOi76lrCTLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WEHm7RkL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso9545675e9.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 07:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706802943; x=1707407743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUw+GenqDOh2jBB/QxFszgqTVYvr4Vcb6WAFihxVJg4=;
        b=WEHm7RkLZCO/GkDPpN2A6iRDyHsLV6rGXQCVxM8ajIQtmtg/cABxPndQxnxzvPRpUo
         G1upUUpsJWzEH+gdU3In4vNW6QapQlCLzliaiX/zDRA2sjswC+JRsDxPSs8wMWSL65Jn
         ha7Zpuk6Z/gUQWCTSnHTS0+tQlZhRPA5zh3i3eaTbBM9YChjUNsPMUqLyPAeXWrNVbOr
         Ttt+5cRLyEU/l93se0yLYzQ3Jgrs+/jHcvKgsKjiyK8Qz0yZbgGfQFkZGTiGiS+PtDB9
         anK7JYf/2YeZRgbJ3D9CblsK+Cah6S6PO8mmAgWGgI+CBLL/ae/E5ihHw0XJilACS+32
         FArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802943; x=1707407743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUw+GenqDOh2jBB/QxFszgqTVYvr4Vcb6WAFihxVJg4=;
        b=KNkDszb9tyJNWtQT+1PR3ZbZVNmN/OnRCfuEZveSyow6Uh981hXUairsbPnag/iQKw
         j5D9fTxDFVdTmCB4YWmf/q5q0XGxXCUlETAkI+mAUpFI50qpUjk2T7BjYAinZPG+tzM2
         4ed0zK435t+Xsjk6BQoz+7GveXJdPl69VzfieMVkVOTDs6+HLhj8NCUNuT0Z+Yh0f/y7
         cexDfspo1aNJ8Xl3Pl/UC+R5ttu9L2ZiOl2wn4LZww2y8O5DhVuj9EsM5cRZyy0pPJqp
         LATbN+61FmVnpj+Fn+xgBRoCTrIMrgWAboc6ZvC5t7/XawiHPLZJy9urNBYDftiUs69e
         rVDg==
X-Gm-Message-State: AOJu0Yxk33Ouj6DtLrtM5mqFEefjphoUU6WKQSNVQxX6dLYblL8BOmV6
	tZgAEs+ZihtvRVScBZ+qkzCoUU3M3PwTTRJWAvPV1wIJ+FdxehXaEDi+eH5OV2w=
X-Google-Smtp-Source: AGHT+IHa3JI7Kn1fppWjgn4s8PYx2pbtlf6QNfVlDlyrofYCrM0i7Ve6CWU5dXs0Rup7/QjT4QbhPA==
X-Received: by 2002:adf:a4d7:0:b0:33b:1577:a2d1 with SMTP id h23-20020adfa4d7000000b0033b1577a2d1mr1213302wrb.1.1706802942929;
        Thu, 01 Feb 2024 07:55:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVWLdfxrdnBMQ89PfJKFlJl9TVw0/HCWHo1BKjwttV4CBGdrx8a0dlvxkSKLZ6CvnLryF9fHb2Sqt/4xqObzBjtmb5el7vkgXqwTv86FcETWZrmn7rnHUECfgm8ibZgOT0tI86Pp0GHgrvVSs72hA4oHQ7LOEB/tle66B6jBDov4d/sxVMFiyMQEm0t9C7Zlnp5pdGrSzIfdYSNKInTYT9PR2E257BzgLCbf/N1jthwMKeZpNRGWLSxEcyq6Y2CUNh5XRCl18eggopm4ROoxzP1bNGPDyl9huo4ww8vW+lgkZwcEEo92uvePI43rS6w9gy0w3gfsD+NA+ctUtUiIwNsvW6jauhGUK7dveiz7xP7PVgqsd2WhiWT/2YIiiQ6/504gkvZ1gRjPqBtKAXYWdsRg3IMauTbhh8lITEL/nKsw+8e9BnRtxnnsQaBVfB2whUGu9+GvliY7+1kzE1l3CxMGkoIj566QAKl8oJ9cti1eSbXjcQuZGRomNzG6xJhnUVl1j+UfeYdXeybIT+znX/Uf+SmM6Yd5FE+dj2gtcnjCTqLtbcmP6WvtfryZ8uZSjA89yC74+UKgdJ6dB4jCOFqfXiIcuDueq8oBvRXQ5JdZyZD3i52fhlb/Y/hhv5LgC4Vho0DIhGJFcmadTZhTfnMHgQQDGAppH8//4QdQd+ma3+HjCdmP05IznFDSj6alagzIbDJXx4
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:dd01:5dec:43e3:b607])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm9650318wrb.109.2024.02.01.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:55:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 2/9] arm64: dts: qcom: qrb5165-rb5: model the PMU of the QCA6391
Date: Thu,  1 Feb 2024 16:55:25 +0100
Message-Id: <20240201155532.49707-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the PMU module of the QCA6391 present on the RB5 board.
Assign its LDO power outputs to the existing Bluetooth module. Add a
node for the PCIe port to sm8250.dtsi and define the WLAN node on it in
the board's .dts and also make it consume the power outputs of the PMU.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 128 +++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi     |  10 ++
 2 files changed, 127 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index cd0db4f31d4a..fab5bebafbad 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -108,6 +108,87 @@ lt9611_3v3: lt9611-3v3 {
 		regulator-always-on;
 	};
 
+	qca6390_pmu: pmu@0 {
+		compatible = "qcom,qca6390-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddpmu-supply = <&vreg_s2f_0p95>;
+		vddrfa1-supply = <&vreg_s2f_0p95>;
+		vddrfa2-supply = <&vreg_s8c_1p3>;
+		vddrfa3-supply = <&vreg_s5a_1p9>;
+		vddpcie1-supply = <&vreg_s8c_1p3>;
+		vddpcie2-supply = <&vreg_s5a_1p9>;
+		vddio-supply = <&vreg_s4a_1p8>;
+
+		wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+				regulator-min-microvolt = <760000>;
+				regulator-max-microvolt = <840000>;
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+				regulator-min-microvolt = <540000>;
+				regulator-max-microvolt = <840000>;
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator_name = "vreg_pmu_wlcx_0p8";
+				regulator-min-microvolt = <760000>;
+				regulator-max-microvolt = <840000>;
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <890000>;
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <890000>;
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+				regulator-min-microvolt = <760000>;
+				regulator-max-microvolt = <840000>;
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+				regulator-min-microvolt = <1187000>;
+				regulator-max-microvolt = <1313000>;
+			};
+
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator_name = "vreg_pmu_rfa_1p7";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator_name = "vreg_pmu_pcie_0p9";
+				regulator-min-microvolt = <870000>;
+				regulator-max-microvolt = <970000>;
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator_name = "vreg_pmu_pcie_1p8";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+			};
+		};
+	};
+
 	thermal-zones {
 		conn-thermal {
 			polling-delay-passive = <0>;
@@ -734,6 +815,24 @@ &pcie0_phy {
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1101";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa2-supply = <&vreg_pmu_rfa_1p7>;
+		vddpcie0-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1-supply = <&vreg_pmu_pcie_1p8>;
+	};
+};
+
 &pcie1 {
 	status = "okay";
 };
@@ -1303,6 +1402,14 @@ sdc2_card_det_n: sd-card-det-n-state {
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	wlan_en_state: wlan-default-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-pull-up;
+	};
 };
 
 &uart6 {
@@ -1311,17 +1418,16 @@ &uart6 {
 	bluetooth {
 		compatible = "qcom,qca6390-bt";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_en_state>;
-
-		enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
-
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddpmu-supply = <&vreg_s2f_0p95>;
-		vddaon-supply = <&vreg_s6a_0p95>;
-		vddrfa0p9-supply = <&vreg_s2f_0p95>;
-		vddrfa1p3-supply = <&vreg_s8c_1p3>;
-		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa2-supply = <&vreg_pmu_rfa_1p7>;
+		vddpcie0-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1-supply = <&vreg_pmu_pcie_1p8>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 4d849e98bf9b..7cd21d4e7278 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2203,6 +2203,16 @@ pcie0: pcie@1c00000 {
 			dma-coherent;
 
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


