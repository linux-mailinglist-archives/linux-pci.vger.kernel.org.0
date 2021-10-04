Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8909A4217BF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbhJDToA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 15:44:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15205 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhJDTnt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 15:43:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633376520; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=N/vQ/BxYZcVllbMyjZ7QdfrkLe1MDqfdnqpN1O96bS8=; b=SlOy/2c4DbdwAJ/5NUdra9BVFqjIWuFqoYMnnVxnT11r//WpvEqafjnVr3kSYVVrE8oiQRvm
 VvEXrBnPdd7W5p7AL5QltpPHOa9VdtYsOEI2I15nsvO5SEWAb0RWKEG0sog8a8PXUjPRTIpN
 T8ayERVDnzV1zfolex9BXPeo+iQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 615b59088578ef11edc7fc07 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 04 Oct 2021 19:42:00
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85D67C4361A; Mon,  4 Oct 2021 19:41:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pmaliset-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 003DEC43618;
        Mon,  4 Oct 2021 19:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 003DEC43618
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>
Subject: [PATCH v10 3/5] arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
Date:   Tue,  5 Oct 2021 01:11:26 +0530
Message-Id: <1633376488-545-4-git-send-email-pmaliset@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633376488-545-1-git-send-email-pmaliset@codeaurora.org>
References: <1633376488-545-1-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe controller and PHY for sc7280 IDP board.
Add specific NVMe GPIO entries for SKU1 and SKU2 support.

Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dts  |  8 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 51 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts |  8 +++++
 3 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 64fc22a..5b1c96b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -61,6 +61,14 @@
 	modem-init;
 };
 
+&nvme_pwren_pin {
+	pins = "gpio19";
+};
+
+&nvme_3v3_regulator {
+	gpio = <&tlmm 19 GPIO_ACTIVE_HIGH>;
+};
+
 &pmk8350_vadc {
 	pmr735a_die_temp {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 272d5ca..b416f3d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -31,6 +31,18 @@
 			linux,can-disable;
 		};
 	};
+
+	nvme_3v3_regulator: nvme-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VLDO_3V3";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&nvme_pwren_pin>;
+	};
 };
 
 /*
@@ -272,6 +284,23 @@
 	modem-init;
 };
 
+&pcie1 {
+	status = "okay";
+	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&nvme_3v3_regulator>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_state>, <&pcie1_reset_n>, <&pcie1_wake_n>;
+};
+
+&pcie1_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l10c_0p8>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+};
+
 &pmk8350_vadc {
 	pmk8350_die_temp {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
@@ -462,6 +491,28 @@
 };
 
 &tlmm {
+	nvme_pwren_pin: nvme-pwren-pin {
+		function = "gpio";
+		bias-pull-up;
+	};
+
+	pcie1_reset_n: pcie1-reset-n {
+		pins = "gpio2";
+		function = "gpio";
+
+		drive-strength = <16>;
+		output-low;
+		bias-disable;
+	};
+
+	pcie1_wake_n: pcie1-wake-n {
+		pins = "gpio3";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	qup_uart7_sleep_cts: qup-uart7-sleep-cts {
 		pins = "gpio28";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
index 1fc2add..f2722c0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
@@ -21,3 +21,11 @@
 		stdout-path = "serial0:115200n8";
 	};
 };
+
+&nvme_pwren_pin {
+	pins = "gpio51";
+};
+
+&nvme_3v3_regulator {
+	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

