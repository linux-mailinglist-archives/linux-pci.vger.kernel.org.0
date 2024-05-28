Return-Path: <linux-pci+bounces-7916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1998D23F5
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 21:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300311C2439A
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E96117BB3C;
	Tue, 28 May 2024 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B6Bj5vbo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922E17B435
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923040; cv=none; b=L5mrGt4OevmV+2yp1zPAuzC/swWwNqIy48xQi0MVCwqvRnJ/eKgqPIaK9bfYZ5phWZjSNhVxwddQWPRKo5UCNyRVVIK0r9lg+nDALSIhnLt4pMUiUNdmSiIi0KJ0B7Vd7dQrGuApPNUC24DRiF4xlCNUbbc8g+l8SjkvuWYmlZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923040; c=relaxed/simple;
	bh=5Fe5SYXOO87JJtta5YB6xWqH7PR/dYBn/XiP+m5B1Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1NQZoHReYgtLS9I6R7wv34b7bxYnIUf9O6kEIYbZCd67pVHDZxVE7FsnL9RzkgsZ0jsGOm46K++JRm4F5+SyCyEAys+80KxP9K/mjClchEd8eepOVZ6qLtdOKWDkpq0cpVUyh4wCBL7cyqUHSQZiZ9UIZyDu9v+kgyOBajvI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B6Bj5vbo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42120fc8cbfso6485945e9.2
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923036; x=1717527836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YkFDmmZFyAgzI1e2AnNWX/ZiPMttO3P6jgjRXIFfNE=;
        b=B6Bj5vbozqiiQ0XkPBhG07mGEVSQ/HUuaFY4PDPnxNARq/xxn9a9+Kk/+zWOk5NpF7
         DVik4zZLFiXR40dNmQY1h9ytbdrzHncFt7ccZfX7AXn8uwPsgkFe6W2EBY+o4uHPIZ5t
         rmehoQO95uf730dWl44MP0gnYLK1lcRKF8U9tMf590A/NNM4BEgvB/uUFvkc9Fr1cIob
         s13dV+ya0F5SWRs895QJgx6XnG5P2jgK8fZnS4LE3q1VzDJojtdUVdvZfAAKUXcckgT/
         QsfPpJOeS0GKXCSjNyxX/zZKLKE94jS7NdLfkJ8qQpyLE/VJpZCKiwFLXk5g1igHRWpv
         WBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923036; x=1717527836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YkFDmmZFyAgzI1e2AnNWX/ZiPMttO3P6jgjRXIFfNE=;
        b=UPI1pKGE9LFtfZ5bwJNDjJmmIDOR2V4n+FIeVdyOUnj7uB3pBdIz+Q165HcWOhJj+b
         GP9epmuCZFM5//Vm29XtEbnJnZJCFQH3dnbG+bIAOykAYW8qKgStYCUF8lvP8FDGfiD1
         l7qeMu2OK+ERXMol0JTG5gcoXR+MYOb4nS12q+0rWWzaBLTNXWPa3b1Oo1DBbDPdCgoU
         EU3Mmqkh8qcpLCcEfsJRt3EgwDfkY2y8Jwqg4GKrwtz7DOHOGPDFiTf2T+JLetC2MIpS
         Hn/P2r2aV1uS3IZaU9AnsvYlurdh1NCaisDQLf9iyuygOzW5MHXR1rOfddjEwqnAyW/g
         V3vw==
X-Forwarded-Encrypted: i=1; AJvYcCUZgTpvjsOE0/s9qvD6nvG2UkznR5JggymLDE2b1nXu9pEgd/L6lSD9L5GoyB18s2VlcvKb46//QCiwlGOafgX8pKAa6gxpddON
X-Gm-Message-State: AOJu0Yz5UeK5LLXpzCKQl6jpvM4hff7fuHebZg/wHyTTVNQNDqoHvgvo
	jA2p4YHAqbd+ZTAccFd3R3LNJhPq5Aa+Yd0h3D4NwGKZm01+Ex8JprgNKXfsRHU=
X-Google-Smtp-Source: AGHT+IHiFcCXeBCWye7HqHDEPXy2vRCFdGYo+qXpUYAyoq0cD6fodu7LepbXxFCrXVon5PHy9V72KA==
X-Received: by 2002:a05:600c:35c5:b0:420:1db0:53c1 with SMTP id 5b1f17b1804b1-42108a17b9fmr78776475e9.41.1716923035859;
        Tue, 28 May 2024 12:03:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:03:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:14 +0200
Subject: [PATCH v8 06/17] arm64: dts: qcom: sm8550-qrd: add the Wifi node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-6-d354d52b763c@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Amit Pundir <amit.pundir@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4013;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=MmkJYbJGVUsH+PVehDQLkZpfFd/l8oJpkblGyVKms+I=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqNvHaXUcCuPBZN76qTJAEDhJ0YM8Uc6FBrw
 0o2RNV7NJGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqjQAKCRARpy6gFHHX
 cgP6D/9Np8E6f/AwDBlZn6ZSdiW3IRE20Ehx0FCHShQNoMlKmNimbENh9h5RCs6Sim3W/gikONW
 teYNFzN09tLCmnbkq1T9ksdK1AWrdAqY2cqD3EN8H+5nJ1gsKJrnX5SnPNXmTezzjPJ3kLXszOb
 mXhUJcDH0W9rNSUVnvcl2s3gH9MHHRphihyTX+AWGNGNrfABJxcKMMKHnOF4zD56TCGU4YuLyfD
 IKy6J9zI3xdusq3wZkwZWWXlRwMJf5wi6RPOBD8XE+OWTjp1gM3xvuUHL6Auq74cTAgAvvy2w+U
 TV+TtZpO3vzg7nhVWt6kBTg+lkE2+90rFizuutvqRhdOvRfS/ojp5z5C8l5VTXz80s7+6Tagu4F
 T6jJCofYldb4Gc4EgXeU6R3qm/UBarDYmH6NjLq8sF02jc+oQBekL89x6JCVWWXkBse5Wb73GPB
 /DUkpuiQ1FPWg3RQDan/TiPDVi0/1tIIibhKCKwuF6SIy5xbarjEdaU+GxXM5ceq64LheesBqb1
 HeiDdLHQyGjfBfjhhX0AVGWMZ1guuvdQs/+eS6xzETAIVybdyHrqU7B3r2zKjCe8G50xc782s6p
 +jeNryIxrbZKro8hnq8m6rtzPhrr15/V6Q6S0KTWUtiVM9vmpx+LorzO4P4s5fbswXwN2wJe2yI
 sIOEAHVwAkCvtUw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the ath12k WLAN on-board the WCN7850 module present on the
board.

[Neil: authored the initial version of the change]
Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 97 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    |  2 +-
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 2ed1715000c9..7a15d472bd95 100644
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
@@ -808,6 +870,23 @@ &pcie0 {
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
@@ -891,6 +970,17 @@ &pon_resin {
 	status = "okay";
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
@@ -1064,6 +1154,13 @@ wcd_default: wcd-reset-n-active-state {
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
index 79311a6bd1ad..0e616fdee798 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1769,7 +1769,7 @@ pcie0: pcie@1c00000 {
 
 			status = "disabled";
 
-			pcie@0 {
+			pcieport0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.43.0


