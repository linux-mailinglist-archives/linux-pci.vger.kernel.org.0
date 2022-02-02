Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEE34A6CD4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 09:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244609AbiBBIWD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 03:22:03 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:2033 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240949AbiBBIWD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 03:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643790124; x=1675326124;
  h=from:to:cc:subject:date:message-id;
  bh=xj1PMTdKP6FJfcRFDIwPOspQGBNZZNI40X619K+1Jks=;
  b=ccLXNwiH+oqD7VvJ+Z5HBwX2s7zvoJdb8ESVyz/zSU906t4inZcUdPzP
   tSFYX3kxyEzKQgNfFpgaX+sPgnaFDIX4wpc7lh0OcbdO9tXK5tc2vbyUY
   pK62eKdjC1/hO9U1rCU3L0W8Iy9FLfjyCFE2sAW4FZnBpKtjqlCUbYqsy
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Feb 2022 00:22:03 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Feb 2022 00:21:46 -0800
X-QCInternal: smtphost
Received: from pmaliset-linux.qualcomm.com ([10.206.64.233])
  by ironmsg01-blr.qualcomm.com with ESMTP; 02 Feb 2022 13:51:28 +0530
Received: by pmaliset-linux.qualcomm.com (Postfix, from userid 3848298)
        id 0C6C721195; Wed,  2 Feb 2022 13:51:26 +0530 (IST)
From:   Prasad Malisetty <quic_pmaliset@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: [PATCH v1] arm64: dts: qcom: sc7280: Fix pcie gpio entries
Date:   Wed,  2 Feb 2022 13:51:22 +0530
Message-Id: <1643790082-18417-1-git-send-email-quic_pmaliset@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current gpio's in IDP file are not mapping properly,
seeing device timedout failures.

Corrected pcie gpio entries in dtsi files.

Fixes: 4e24d227aa77 ("arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board")

Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 35 ++++++++++++++------------------
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 10 ++++++++-
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 78da9ac..84bf9d2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -243,9 +243,6 @@
 	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
 
 	vddpe-3v3-supply = <&nvme_3v3_regulator>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
 };
 
 &pcie1_phy {
@@ -360,6 +357,21 @@
 
 /* PINCTRL - additions to nodes defined in sc7280.dtsi */
 
+&pcie1_reset_n {
+	pins = "gpio2";
+
+	drive-strength = <16>;
+	output-low;
+	bias-disable;
+};
+
+&pcie1_wake_n {
+	pins = "gpio3";
+
+	drive-strength = <2>;
+	bias-pull-up;
+};
+
 &pm7325_gpios {
 	key_vol_up_default: key-vol-up-default {
 		pins = "gpio6";
@@ -436,23 +448,6 @@
 		function = "gpio";
 	};
 
-	pcie1_reset_n: pcie1-reset-n {
-		pins = "gpio2";
-		function = "gpio";
-
-		drive-strength = <16>;
-		output-low;
-		bias-disable;
-	};
-
-	pcie1_wake_n: pcie1-wake-n {
-		pins = "gpio3";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-pull-up;
-	};
-
 	qup_uart7_sleep_cts: qup-uart7-sleep-cts {
 		pins = "gpio28";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index d4009cc..2e14c37 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1640,7 +1640,7 @@
 			phy-names = "pciephy";
 
 			pinctrl-names = "default";
-			pinctrl-0 = <&pcie1_clkreq_n>;
+			pinctrl-0 = <&pcie1_clkreq_n>, <&pcie1_reset_n>, <&pcie1_wake_n>;
 
 			iommus = <&apps_smmu 0x1c80 0x1>;
 
@@ -3272,6 +3272,14 @@
 				bias-pull-up;
 			};
 
+			pcie1_reset_n: pcie1-reset-n {
+				function = "gpio";
+			};
+
+			pcie1_wake_n: pcie1-wake-n {
+				function = "gpio";
+			};
+
 			dp_hot_plug_det: dp-hot-plug-det {
 				pins = "gpio47";
 				function = "dp_hot";
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

