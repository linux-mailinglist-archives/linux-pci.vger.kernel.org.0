Return-Path: <linux-pci+bounces-7917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E108D23FD
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 21:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C781C246AF
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C4D17DE37;
	Tue, 28 May 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B1ikVS7I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAE17B516
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923041; cv=none; b=F98hVxK2zu6TnW+B+5Cc+5XS/yEtoWbIeHvUNF6BKVNS6pUcwtea5zgkhnSrmze+AHHtLmxpOTIeMMxSZHEw6FEUq93/ag2vFVZr7kO16pdmPYvxWw8rO0+49ctIvWE3YiLCdPuMQSDVmoJDFS3BzHxIyMK8A8pPuPEF3JBo1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923041; c=relaxed/simple;
	bh=KXsav3Jcr8SLGaU5WbaTFgydaNa2pSIrTbrR0OSHXYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpNBjaMBIdcvqlAvYT3Q1jENY7thG0LRP0v4Xzqwrmibgc0cfULcDpTSI9qjOWw9QTYAN5fPzDf23DCaQ+90seaP5D1L3gNaegJU0UZThgtXc9Id1hcgxlRb+f6BBhfR/DwcPO6ZFS2PX+YUVb0awR0P4uZ8dUegwqBVH7JJEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B1ikVS7I; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421140314d5so8987605e9.0
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923037; x=1717527837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLa27fvWZ3xHzK1QFpz+dfI8TGigIxfiGyK3xtryc0c=;
        b=B1ikVS7IU4Xg2hL42cx2c5INv54CDVb+gBMYSGVxwzAeTtOnUsfHQLuGyaQnw6br7v
         H4jqxVHCh0JTC8Es5eJoDcWeCb3KLyn8eLbXA0TXN9QS6KaqvmG0uKbAzTUsyKY7+N9X
         cUCOjja6DpsCR6t4SnIxKAYECksKQMQTuFMm+F75n4gVhQ14z3+moPILeJkyTTHE/Y23
         xQ5SYWYrQwkCNlJ1BdH4KAwe9JgCm28G/Vuwvg+zDIsS7I7sHeXtXThqifmNHf8otp0R
         phrFDK1z9CxhN4bJat94w7csztxmJFf1CNU+ljWjR3sqOj/VSXzDIEnd+O/QmNr2GQfB
         v/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923037; x=1717527837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLa27fvWZ3xHzK1QFpz+dfI8TGigIxfiGyK3xtryc0c=;
        b=i0gzKwnVTQGRJ5LIzTNF8NeQtC1M2pvC1ksAzAFkI0WJAzUY8Tzd34G/U9slJ3nW7B
         D3zqJFKoqr1XKIUsErDeTMwlptGRZhRmP8saLi2lcI5AmjnLSjYVWD1Xcx7Q+KocipFH
         Sa9bJt16+atn62Weehu+extvtW9qdX1JfbMT6MaUwT0t/6ov+4fnIjjJ9FCHRXLSq1vd
         LDr5D3xPyGo+KZIUUu3rKyUFLa2WzIAkv5njn08SpXrhum5o/R/HHbJkAN1Px/I8h/aw
         wbCN56YYSffvTUEELkoNErSlYthFInrDq4uh1ROSQENEgjP4EvBaOBsNT0HwqNDs0mK+
         BVNg==
X-Forwarded-Encrypted: i=1; AJvYcCV+rvDgbaFJQuKRf5nKkkLQDzwyZyYbo0GBGM3qyfaYdR1gqStqYmzgB1Jdw+OVF1Gxn4wrL5dn3gw5cvSHmpULjOcJ8/XpzChJ
X-Gm-Message-State: AOJu0Yzcff0gQBNZ3VKo22FvZ9qX/U32SIPl0+t9aImXouXgwlNRXoa5
	iOnURlRlng7omok76VwPliFR4GigrWyWYwdv4941geQC8+6ie1ZDx+7q5HIOv3s=
X-Google-Smtp-Source: AGHT+IGoCzWaS7M9ghnvAci7Ksdr02C5X0xku+g9bCWhaRV3dAa+VUwjLce7VBhVr4MskeyIPIu73Q==
X-Received: by 2002:a7b:ce8c:0:b0:41b:cb18:e24b with SMTP id 5b1f17b1804b1-421089d2d7amr87487655e9.9.1716923037195;
        Tue, 28 May 2024 12:03:57 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:03:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:15 +0200
Subject: [PATCH v8 07/17] arm64: dts: qcom: sm8650-qrd: add the Wifi node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-7-d354d52b763c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3708;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=CTlF2PNNDKg3EHqzuBhLG4C20XnWl+M+qvvHDXFzICc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqOCasMtV+U3OiBytvnFUjf7QPlMy0DZWpFp
 bK6na7SRHOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqjgAKCRARpy6gFHHX
 cuQ/EADjIhEEPA5J8QYcTFkc56bRpWrArA5URK9C7G54AR8GRnMkHClAQ8SuJeONZlIaADyfMxR
 e3YrgCacVGd3yFqxz8ddZJl3zs7mkR4NugIWGYZrkXbTqPyyEihWhGdPAoDvqt3+F/rA5AyLADA
 LsOWSAKwsJGdlhoipb8qKL8wJ9nqtoWX02nnRiiDyanFTfAJodDu11n2tU6SsnJhpraa6dwzgSW
 YZC9uDnyQpX1iWp1ulEWP2NeRg8YgAC9g0tpI+MxZanJWn4s/TpWl/181+pvvsMEBXc5/APMRxB
 gkAhUlSGiaxArWJjB7HMTaug3INxGN8Ik4RnGPip2aiV3bOI+xLhU/5Wag0NhfO9CmHSm9M3GMa
 JeaTzNbdscOt2TBmHmoYy9WJJOyRlq7ZGn6H6rb3lag841ueXexgO6Iw8+HYqdVzFTQtmrpbcZq
 Sd7xwcyDoSjAoT3IhRSBblLX0UxnL2EPUe4vPDb/9VgKRJhLhTDqVsBgA5A/fgbfQxh4Z77yw5Z
 GgAKpa8Fesz5arVgs0SXPC3JWcEkwNa4cW84vnptOvCIk9GnS1TPK2k6Z3w+I9S8aZDy7073tTU
 TiLAs66lNa3OqJxblLX93+GuxbfT31v79HjTGtEs4qdPv8lbNJJV/EXkuwJ8QMOBbSrBB9cMNsF
 66h12Wl2a7d1bCw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the ath12k WLAN on-board the WCN7850 module present on the
board.

[Neil: authored the initial version of the change]
Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 89 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi    |  2 +-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 98f6a272ce5a..6e3c4d8dcc19 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -203,6 +203,71 @@ wcd_codec_headset_in: endpoint {
 			};
 		};
 	};
+
+	wcn7850-pmu {
+		compatible = "qcom,wcn7850-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en>;
+
+		wlan-enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+		/*
+		 * TODO Add bt-enable-gpios once the Bluetooth driver is
+		 * converted to using the power sequencer.
+		 */
+
+		vdd-supply = <&vreg_s4i_0p85>;
+		vddio-supply = <&vreg_l15b_1p8>;
+		vddio1p2-supply = <&vreg_l3c_1p2>;
+		vddaon-supply = <&vreg_s2c_0p8>;
+		vdddig-supply = <&vreg_s3c_0p9>;
+		vddrfa1p2-supply = <&vreg_s1c_1p2>;
+		vddrfa1p8-supply = <&vreg_s6c_1p8>;
+
+		clocks = <&rpmhcc RPMH_RF_CLK1>;
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
@@ -844,6 +909,23 @@ &pcie0 {
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
 	vdda-phy-supply = <&vreg_l1i_0p88>;
 	vdda-pll-supply = <&vreg_l3i_1p2>;
@@ -1138,6 +1220,13 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio16";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
 };
 
 &uart14 {
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index d7c432552233..0fb971169f38 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2289,7 +2289,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 
 			status = "disabled";
 
-			pcie@0 {
+			pcieport0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.43.0


