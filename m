Return-Path: <linux-pci+bounces-7919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA44A8D240E
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 21:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3DA1F26FB4
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC356180A79;
	Tue, 28 May 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WZr9jf/P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900517DE2C
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923045; cv=none; b=LfiFPBc8phTtrjDC4BBDyEi99E+ZgVdbFrrMo3kBCQmMz5ZEA67CnW/uXTzpCrLNoF/kZlcFaEpjImbF6c7k62Qjw74grkH4nltldfzIvBhaowkJItfC2r+oPFPy/2kZn7/0Zn2lK45VQA2JhJAxnS9jxminw+6+FlgNyIrV3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923045; c=relaxed/simple;
	bh=v6bmxVza0xjPTI+/FgQNjpyh/NQXAsf+yGHXNfo1hss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pa4pGy1fJRvX3OROvje84GKy/aiJ8UZRTVt7GO/gQ6cheMuAeN4c/Qb460u94d0PZ6VLd020tNULy2i1vIV7HVwrD3FCWjP9eOZykJoYDw7qPEGDddRZW+kKICdEmHLOgTsA0iqMX2hVaplGDC3xSop5nyidD4YXtCtsW4d+Ubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WZr9jf/P; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-357d533b744so1204177f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923040; x=1717527840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuYPl47KIQ9VqY872Xqe+kTgcrB2o5A+grbMagkLOSo=;
        b=WZr9jf/P36AIX/6Y5uym++jmaReavmef/2ruSxLYZJMN02jB2hp6WTDmHCAVyYPhQ9
         2O1QTqB9XuRPEPkAKIc5RX2CGIzmtsprMtNrClsvTn4fj4Leij1LDwVLHTH2M9/E+7XT
         hBkiEiDbh7MYZm33qmuaDKwh+e7Eolv2Kw2GvsRhfnXY1ZcUTKIB/7BN1E53XlgiLh/V
         ESm7htNC0DSAoSguf5m0aGOJJmH7Qk/1MPj6mQTxe29uyT4LZQZdd/VworDyHvxhmpWU
         VUUY/8uRhQvBpxAf92dWEprwqNbHS+W4EwYm9x1H6Jv+OUgyGi81CWfV/LAV/G/dl4YW
         Q+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923040; x=1717527840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuYPl47KIQ9VqY872Xqe+kTgcrB2o5A+grbMagkLOSo=;
        b=TVcEwzG3IGC9ChlMhGjCoZKQbjpNUNeHB6q9Z8cJOEEYU6LSZ2dbMnemqORly8RfSk
         Hf2rAJJ0697G5g5m9uPLnfTZFoeTnOGTHNaKaqixUyBW0hY57fhBcKRtyV6fZmqxBFO4
         ToB1O7c8+rJCiw61kvA3ugPqX+c0SnwgXBmkFu4s51BfNcd4VK/73OXli+Jdrubg0Tng
         O0XAVWlhMaqUsGabQzas3WGchlSs/RALZBo+nrvyMlPp8iJr5q6mlERU+1vRFZjq8XQX
         o9pnsD0otLJGViZLYu2XkbgV2LceHY9zcE53E6iXh6kwOwV8RRf2SrcngkppgvAqF5Rn
         kJDg==
X-Forwarded-Encrypted: i=1; AJvYcCXh8XL4DdMEqHbcZ9/DqDyusvatWhnZY6x+XriK/PmXQK32uZCf9M9GmmV+Th+bNCWhc60lw6i4kwpldRFy0hmhvUSfGuMxb1/j
X-Gm-Message-State: AOJu0YyLzlX88WvPFZfPzrJPgj4J3l9ngSG3AmAS8O3EKLb453ABRsPy
	jmGTErZUeFWt8+lvT6JUN+AgquBCXjUdq9h2Y50A8HlNB+dyu1Wv3dLBWJIxDko=
X-Google-Smtp-Source: AGHT+IHuM/tFylSDmfQEbP2mgVrrRlps+nMqHvCZC6tgXDtzYJQLq8BaRAZ5E2wY5ZobApECS56FsA==
X-Received: by 2002:adf:f183:0:b0:354:f5f2:198b with SMTP id ffacd0b85a97d-3552fdc828bmr9373160f8f.46.1716923039935;
        Tue, 28 May 2024 12:03:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:03:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:17 +0200
Subject: [PATCH v8 09/17] arm64: dts: qcom: qrb5165-rb5: add the Wifi node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-9-d354d52b763c@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4464;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Me7N8ZNN6u3p7zKAmRYczNLdqj65cIP/XYHdl6dlOEY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqONa8eypowxbocTV6FbyeJdEqgaJRdAxEqd
 W+QhVf9AkSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqjgAKCRARpy6gFHHX
 cnnMD/wIdbFG831RyQxn2MifvFsy5fsypWV+YCMg0dxSNEECFXIWNWqtL82VEKzs1UpAsVYr/ha
 fiuiQnIY6Q7JUbVDU7w5prFt03hniOssQ521Hu8u/5WROSZsVy2QG50ZakRngiMGLw+hkrxyM6N
 hnRnKyALjhbO2YobuRV+JDvR5HnT0W0FOTxaJvz4eRrowOR24V4D+DdQB6hb+dLe6+/dlavYlRS
 Mya8jDaHw+skBNwf6T7Ed5/tdz6YqbvdWleCBuqszBfH7Pim1X7w0p2rBAJFiRP7u2sUGrac2p+
 PgwyDrRv7s/ANaWcAASoK/HGfvu/ZxLk2iXLEh6zc5ztxFSP/ugJ42olasCcDfHgoa+CGxHScyM
 adRDD1Exag5buGhHH5oK/bzMUoXnc7DB8JahKqxwHYJc7b2DsOhD1wYqHVto4cJOmGtq60EErZi
 NVSPO9riuyczhwJv2OAyTaCjf+x724DkWVQZy9KIwxaZIxdwu8n+wWODhIwaI9mw2Bc4G1oZBfJ
 621lslpJtPtw9wn7OGjJPpQEW0v0NNw9PP94urvxPiKASe9yfrs5+vcKUpM9Snv3edhGdL+Dgmr
 nNmU37j0doofN+vk5tKc7fHVQGkMyvnhyhsbVPOgC/UV8/PDf+Ivz0HnMXNWlroanQoH6pbtTIz
 xcYFSHOGTn5ZeeA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the PMU module of the QCA6391 present on the RB5 board.
Assign its LDO power outputs to the existing Bluetooth module. Add a
node for the PCIe port to sm8250.dtsi and define the WLAN node on it in
the board's .dts and also make it consume the power outputs of the PMU.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 103 +++++++++++++++++++++++++++----
 arch/arm64/boot/dts/qcom/sm8250.dtsi     |   2 +-
 2 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 70036a95cace..135bb00fe9c8 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -108,6 +108,67 @@ lt9611_3v3: lt9611-3v3 {
 		regulator-always-on;
 	};
 
+	qca6390-pmu {
+		compatible = "qcom,qca6390-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddpmu-supply = <&vreg_s2f_0p95>;
+		vddrfa0p95-supply = <&vreg_s2f_0p95>;
+		vddrfa1p3-supply = <&vreg_s8c_1p3>;
+		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+		vddpcie1p3-supply = <&vreg_s8c_1p3>;
+		vddpcie1p9-supply = <&vreg_s5a_1p9>;
+		vddio-supply = <&vreg_s4a_1p8>;
+
+		wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
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
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p7";
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
+
 	thermal-zones {
 		conn-thermal {
 			polling-delay-passive = <0>;
@@ -734,6 +795,23 @@ &pcie0_phy {
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
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+	};
+};
+
 &pcie1 {
 	status = "okay";
 };
@@ -1303,6 +1381,14 @@ sdc2_card_det_n: sd-card-det-n-state {
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
@@ -1311,17 +1397,12 @@ &uart6 {
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
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 759e0822b3ac..b32bd849df44 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2204,7 +2204,7 @@ pcie0: pcie@1c00000 {
 
 			status = "disabled";
 
-			pcie@0 {
+			pcieport0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.43.0


