Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCBF307D1A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 18:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhA1RyA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 12:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhA1Rxx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 12:53:53 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DDCC061793
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 09:52:36 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id q8so8736561lfm.10
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 09:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXIYIWOunXUjcWL7Qp+RVBAXkAFNksvup6VJ/C+XqQ8=;
        b=RaRlNAgwMhO+EerI7xJzT/PTK/SN8To09PUyTnVIk/FuvmO6E7kSc1wym9J9fEfXq9
         ovbwkqP9d3ZMS5QyA7jpp0FczPXCoTd1VliX7Bl7dMkiGPoabsXVASnd6fPyTpK/Iafc
         fqaozUnv5rcFeSH+RuiT0Kjy4Q0QyEmhhNmVNCTJX5mw13RKwKPzuKMtnqBilCiytRza
         uGPov7+OYFDyBEXG7lZnXChI1hWZUr9r7sMNmZPDUmRGq3bClyf9t521t+MQOMrb7avD
         U9WR3JK3S88mwA2fQj0OLIlfkyljSxS3TjwR2UH021UeswTWa5JyH/JHp3JmJtSqwWrq
         pzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXIYIWOunXUjcWL7Qp+RVBAXkAFNksvup6VJ/C+XqQ8=;
        b=TeKMx8RhuxZ3/vCg62win2XgmeRQrRcI3dy/+TixUOlLL1cfORVxEawV0rbA/RauT5
         DfcPxvpwCxZwzdkXoVVCmOzwFL3t2rimgCUU+V1L3Z6tnTYnATOuWkk+AJe+h6/WlWlT
         PDpERqKcju3Eoro5IP1GoTMGIOtIniQHVmlmpDVSA0PJmvuADsx8BVUGurreSFWqJ2Cn
         OG/i+j6iQGh6EHvD4M5VvIh/uc1ThbuBbSRG6IVxkn+0AbNuEga7k1bVkOyUCtmQYKoG
         jLPWAxP4harwkW0sKoUNJUz+A8/quYeHn8mOI6gkQxyFmdURDy7H2xkFc/AUKtXbyP7P
         b9CQ==
X-Gm-Message-State: AOAM533ekAFgYVWyT+7+s5xJAK0l+sKIYHxF/snMouQrhyt0H92kIMsg
        6ZWxMJ5S4KarU5iIogZxkZz61g==
X-Google-Smtp-Source: ABdhPJwXfS8OZBXi3czr0KbA2ckEoitsUks4pRqmTUMX29nrqkjflfGS8NKscqEDmNMr+PmW0UpYcQ==
X-Received: by 2002:a19:488c:: with SMTP id v134mr101677lfa.229.1611856354679;
        Thu, 28 Jan 2021 09:52:34 -0800 (PST)
Received: from eriador.lan ([94.25.229.83])
        by smtp.gmail.com with ESMTPSA id w10sm2216119ljj.37.2021.01.28.09.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:52:34 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/5] arm64: qcom: dts: qrb5165-rb5: add qca6391 power device
Date:   Thu, 28 Jan 2021 20:52:22 +0300
Message-Id: <20210128175225.3102958-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128175225.3102958-1-dmitry.baryshkov@linaro.org>
References: <20210128175225.3102958-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add qca6391 to device tree as a way to provide power domain to WiFi and
BT parts of the chip.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 61 ++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8aebc3660b11..2b0c1cc9333b 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -151,6 +151,23 @@ vreg_s4a_1p8: vreg-s4a-1p8 {
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
 	};
+
+	qca6391: qca6391 {
+		compatible = "qcom,qca6390";
+		#power-domain-cells = <0>;
+
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddpmu-supply = <&vreg_s2f_0p95>;
+		vddrfa1-supply = <&vreg_s2f_0p95>;
+		vddrfa2-supply = <&vreg_s8c_1p3>;
+		vddrfa3-supply = <&vreg_s5a_1p9>;
+		vddpcie1-supply = <&vreg_s8c_1p3>;
+		vddpcie2-supply = <&vreg_s5a_1p9>;
+		vddio-supply = <&vreg_s4a_1p8>;
+		pinctrl-names = "default", "active";
+		pinctrl-0 = <&wlan_default_state &bt_default_state>;
+		pinctrl-1 = <&wlan_active_state &bt_active_state>;
+	};
 };
 
 &adsp {
@@ -1013,6 +1030,28 @@ &tlmm {
 		"HST_WLAN_UART_TX",
 		"HST_WLAN_UART_RX";
 
+	bt_default_state: bt-default-state {
+		bt-en {
+			pins = "gpio21";
+			function = "gpio";
+
+			drive-strength = <16>;
+			output-low;
+			bias-pull-up;
+		};
+	};
+
+	bt_active_state: bt-active-state {
+		bt-en {
+			pins = "gpio21";
+			function = "gpio";
+
+			drive-strength = <16>;
+			output-high;
+			bias-pull-up;
+		};
+	};
+
 	lt9611_irq_pin: lt9611-irq {
 		pins = "gpio63";
 		function = "gpio";
@@ -1119,6 +1158,28 @@ sdc2_card_det_n: sd-card-det-n {
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	wlan_default_state: wlan-default-state {
+		wlan-en {
+			pins = "gpio20";
+			function = "gpio";
+
+			drive-strength = <16>;
+			output-low;
+			bias-pull-up;
+		};
+	};
+
+	wlan_active_state: wlan-active-state {
+		wlan-en {
+			pins = "gpio20";
+			function = "gpio";
+
+			drive-strength = <16>;
+			output-high;
+			bias-pull-up;
+		};
+	};
 };
 
 &uart12 {
-- 
2.29.2

