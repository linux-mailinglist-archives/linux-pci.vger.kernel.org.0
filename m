Return-Path: <linux-pci+bounces-7918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBCE8D2405
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 21:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49A7B24523
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9317F39C;
	Tue, 28 May 2024 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="18vF/H1N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84917BB1A
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923043; cv=none; b=eiGqllk02pvnuK8YKytSDyDNV9ZTW6gYedvt6oPFswXXt8VL9Z19hIsE9Hl+XOTKlEyetD8U/BfGt+CQBmfo4BBXCTrQmPODA1vcRSaVFtdns9maPl0vr8mUQRCOVDWC5UJL9Obm4JWgjRkgBD4NalEEFhdgGD8GIuAI6DX38j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923043; c=relaxed/simple;
	bh=jrWvLmZO2MtdJqQKczs4xaZxwtXkNl3nBncTzCBRW7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCz3jwYbQSt2cbCoQ0/7iyZjPCMDXIdi75KUCfCaO64IbO6HpXhIFqL5OSV7pZkV6ska/ohUXqBgFIhno3GTreezlLPVKrsLAUl+5AEVLxcAeMHxnlmoBY2ecXhnOZu+4212zR5KbTueClK7cBhjSxg1Rg04IeOXJKDGxnuDAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=18vF/H1N; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354dfe54738so786238f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923038; x=1717527838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VDWyB/Vt2yrqLkBETRDxRFnPzrcfXm1ptbgVUZY5Cc=;
        b=18vF/H1NaZmw4aWRa+TIaVI3tccavDpUpUo+IlfuedW6kPJ7wKIAzlaxX6g1pmB88u
         nb+OUPfdz9KlPLjXMv+jlYJLKl+Js+ryIFL8/Hem8peC5m3/NSlEi7lvjdrEyEw3KJ4l
         2JoJVNri2Plryw1gjYUaFynPf+2zJ/v7LEnFEkwkuJOpulmuqR3ZlI7Wa+dAe+z48Bjk
         5fH62JHgdNAU+HT7AmqW1O+mfTr3W14AKTbdwi6WrsHToSEKF9+pkE3drtltrLX7N2CY
         jh0fV9m/OqAanC1u0JHuaj8GU6Ld0+ZxLlKPuL/e3blGEFOED1YXNlqV6fOXLLydzCSP
         5ebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923038; x=1717527838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VDWyB/Vt2yrqLkBETRDxRFnPzrcfXm1ptbgVUZY5Cc=;
        b=fbh+DszCgyuEIxjxGPtyc/hq3XqhGBj+X8xlzxj6ozUIr6vkULDjanuM9Zj0hjelfy
         yR4W8CzAFfsnrV0gu2Fav+iqz7b/awjh14yQVnXG0pDmQOzn0u/bK2PY/upmxAnnnEuW
         b9Jy38TsL83zShFqfddPiVBz4r/673oTaNAlvO/QDE1f/oKyY8ejjmvR33GgOAqcD8Ca
         okjKenphh/VVims6jSR56JksluG+n+4mAWCFDYMaZBPMXfOjHvPwFB8dSnR5oX0Ww7KY
         ID+UicKzTI8DcEVP7woRW5P/pmfi0CT6vCSlOrN59F8iA1T4Tjig9srCnH7s70x47pOT
         XHNw==
X-Forwarded-Encrypted: i=1; AJvYcCUAzKmFcHENE9792ExauLp0JfxR2QKcwhXNTlVBsvGhyiq7GlDUbOAd3nshXQXgREAjEHUjKHw2S051mnjaCDYn96BTIRO787qc
X-Gm-Message-State: AOJu0YyEKFBRPE70N9Tbdo0IbdQyQA804DMovtJlv5aPcs75Jo5vmnlN
	XBaOC9tT769M5Fo8kvGXnG4yrXO90idHEZV8rmjBW0vQeYz+VvE5PNQeOpoTvsY=
X-Google-Smtp-Source: AGHT+IG9twxX4gmVpSWSmG7lOy0d9ZrPVsGdDc+r3+3Lc27UTT9Q1CmlcQrzBygReRw0K065n4Yd5w==
X-Received: by 2002:a5d:4b02:0:b0:354:fafc:b8a0 with SMTP id ffacd0b85a97d-3552f4fc7a9mr8612295f8f.59.1716923038550;
        Tue, 28 May 2024 12:03:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:03:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:16 +0200
Subject: [PATCH v8 08/17] arm64: dts: qcom: sm8650-hdk: add the Wifi node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-8-d354d52b763c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3087;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=GaOLcgqKs3ODvq3/O85YU+fUTNT/9BH1gk6I0XDm4C4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqOxHFm5d147/MDXDrwmptWoxDAkiT5npxCb
 gY47vDCaTyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqjgAKCRARpy6gFHHX
 cvP1D/wIgiQjjyJuS6U9yFSU+MJwzhaoKoc0oAiOUbxzKiS420zoqAtf73o/YAgjY8Yl2L8tkqT
 si1ZXxwSu3SMF4QkuIvgnl8TqhdpZQLDDefO+eTZPc30SrWAmneqprcoxSniaSqH88Gy+fmVdYD
 /tJOLoUlRCqhrO01qpEh5En7YlFZw5hIE69gBYYBUfymd1fL6M/qww9KTWl2+4VmA9T4BEojAMc
 OBUY7pkTCZh4pO5qnF344tnURP1fjnXYWCu/sqfNbcweD9qkKh7m4XGTRRIu3COhA1pftKIw17J
 4r8e5cV/2krtZvM7+lk804+AQdJEt3eBHHSohpvztL4I8XYh+7Zen6VVvTQ4MCnjMgCJgtEIBbG
 z6jE1c3DkF6GoukSmD36VxeO8snL77G2P8Pp3EzHBhTYA2uo+TGaNYX+geEcpYaVPSTz9/F3VDw
 a0U0/PnXejrCtMSuNKGiP56dSU0w6iExXHuWYpbAJPCxnMfjH05oV0UOFTt+o4wVdIGYsaPyaIi
 NTqH4Bk8ZOnxZMtNZs7+UZ8ygv+ObJ/jaDsQnGMcLjlvX/qZa9eR0pIf6NReqsq4qaau6yKuQs9
 o9IkFdLwaEL9FW9hukAAXye3EWxSePyl05MMCTkTxbpuOBIVZFsWkTm2LFhtAiajJmX8bghkpZ0
 qLBJ0EahJamjp5A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Neil Armstrong <neil.armstrong@linaro.org>

Describe the ath12k WLAN on-board the WCN7850 module present on the
board.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 89 +++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index 7f2dbada63b5..b824b805ace2 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -266,6 +266,71 @@ wcd939x: audio-codec {
 
 		#sound-dai-cells = <1>;
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
@@ -894,6 +959,23 @@ &pcie0 {
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
@@ -1154,6 +1236,13 @@ wcd_default: wcd-reset-n-active-state {
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

-- 
2.43.0


