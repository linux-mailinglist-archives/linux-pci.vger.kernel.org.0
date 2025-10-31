Return-Path: <linux-pci+bounces-39920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0EAC24BCD
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F6BE4F4BDD
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E7345CC0;
	Fri, 31 Oct 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X/7YSgXR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HYfafxIW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972383451C9
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909163; cv=none; b=qm4iREOYecAqn0Kr+6mwNHNAEDLlbKpa1OyCh032FhXe+txMpT47AOiBTvrIMLc5wLZ4TqzBWV1IW7QgYzSj0N/MAaAoWA5cOM2FE2YwXtG2vhmhqrpqN+KhesHw2kzbpZlteTEese7Jw6lsC+BdHl+XaFMF4tQlZQdoTZ9kd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909163; c=relaxed/simple;
	bh=Sv6AS5x3K2KhKdvBG7hjL3mkMhlIbMFrdThx5r4suHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drzpjv3d7nyaD8UQrKVWGXZI8wzQZShDwjCse4awYvq/QD3O4A8Ot06gzWqnyWFqHY8y5mf83rF1PWhgi5WDftuKw3DbMr8NdcRSujRL3ihInEac/qFkd8aYYlWDPH2llUXZpU7fYfk5GTPjjEzC1XZFaQR7ZdCFTydGSVM8sMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X/7YSgXR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HYfafxIW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8Ik06832863
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OVxVd9mZ1eZAjQgeyNOAfdUg8XGT565AF3QZkQ1SayU=; b=X/7YSgXRSVjDW/8m
	MCFriMVpb5pJKE8/ONL7rc/TsBUo5mFc6RoDuwWMERfavs52rcyXouCo8zatdqJh
	+7+Sg9vjSYeB9Z3PZVga+QUzpB3Jv7UVSt0VxCpcW5Q1v6WR5ncKsJo50uucbcHM
	cde8bmJLV3gJkjbL4wSBtJ2URBI6Tq1vdICpl7ly1P/5BGj+X3HU2dG7sN+J3Qwn
	ny5/l0d3mnyOeD7bX1StweEDlMc0yvnNQTpq2Bwe6u9E+qc3jEEfuKp+5lbiXtEJ
	dyPD26oS8ltIcuKdp/QOWGpI4sU//mxQCZAgxeaRNvv830Chh5Foa04IOM2NOoAY
	pB9jVQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb20e9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1722775a12.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909160; x=1762513960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVxVd9mZ1eZAjQgeyNOAfdUg8XGT565AF3QZkQ1SayU=;
        b=HYfafxIWXaFfdMwLk/EvD6w3xrrAjAJkpDCpTRfm1xz91O9YZ7Q22RXX7aEXkQdLNW
         g4gWsTYsfb12Tp6jtRMz3XNP6eKtt4ecphDRGzSHDCi0JNXGU+xYk1El3ijazpvS2zB3
         L6QMpMl1IWQvmJWkM8TpxECe9zUhL3jCOlhdDwkMGxiqH3I8JUVXvUUaidH1gn698bt6
         52VuBWS4HQ8HOvJ09oJTwLpq0En0n4mWJYXzH9n2mD1rIPQs2Mr96yV4JkKydWljmp4O
         40No+SGRwTaLzJA/WcPA2MHd29C/1xVEAzIGsnD+ngJD21zmEiLS6Hf7XUHIqeLYErAy
         G4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909160; x=1762513960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVxVd9mZ1eZAjQgeyNOAfdUg8XGT565AF3QZkQ1SayU=;
        b=anIoLgfmF+0RAytO1xcC5Jl6L44cbcHf6C7FCUrOz3lrmfxTQO9+T+4dpLpNmGbDwk
         6JGAivHYEmVamr8oOC2bX/BxT/h+9qXy4bSdpfxSYO/ObL/qrwAwF6RRBcK776exQYiH
         2WFsuPOt6KZK95p/zEZa1oNdW0KP6Nvr9BrMuFaOgczDY79lexIWxiexTYeE+59tPxss
         S0HnrKIXWQZR+HDf0ZEwseubRDB2HXA2WLSL/vGRxLZ3gS/Vz10TVm8Vs3UJMoRneDxU
         5mJYg8vbt10kpA9Puq+xux8EijNENQ+hDoroBlgSf46vXZf/7vzhDO0ytPk4FHco2VKk
         ntYA==
X-Gm-Message-State: AOJu0YzprWyrva4smvE8WyG7EYl6pEBD5mKZEVqXaB6Q/3a+ZITKv2fR
	eIoemYSLhoCXGCNNV7MaftVhEmxU95TQTbq1+Djfu9tNuP6Ri1x7zKU/vcEXbTD6GeQYQslvd2O
	kuP4wWaw3Ldoq64XdINM8+HJlpeY1O/Mjk05IT7oCDbJiIU/nxpkBKnGc+mfIa50=
X-Gm-Gg: ASbGnct0AE9R3OJ/dSBvtJ5NFt+FzJUn2Vc9eZ/x6YRhyybKY7+eswhW0QxR0G64UqO
	paNw5IrpbVB+5uT6YtTehx+SZODy6dqBeTqx3prZvN5u31zi5P9NhFiCjOVSembtaiA4/+FoXf7
	n7DKWoUHUiCJMr+/9ebfT/la5HrLNEk/Emnl75TcDpbb3R3kDJW/KcN3QByO5ig53ZtPE6vUPOJ
	ZFVxALX3jDS1nKlbWwQ1uuUTi55W2VSDF667ID5h3Ih84Xwg0YEEK7AlqMdT/9ds/uOiIKG5eBV
	3ysVWiQzDmY7q02ZIw0Tt4oDB9kLxmifsPMxypRxfngAqjznlA69ooykGgOlMcUso/FT0z6wVsq
	IQ875PomtI+gcLerjO+hHqy6Mj5CJAYe0NQ==
X-Received: by 2002:a05:6a20:3ca3:b0:334:847c:dd49 with SMTP id adf61e73a8af0-348ccf0cd24mr3904070637.57.1761909160100;
        Fri, 31 Oct 2025 04:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElL+QBO1BGRs60oxcQsVddvjolh9bPeOp/U+mxhg2pATfKeyXVINK7LtGDpB4W1FXkutlOLw==
X-Received: by 2002:a05:6a20:3ca3:b0:334:847c:dd49 with SMTP id adf61e73a8af0-348ccf0cd24mr3904031637.57.1761909159530;
        Fri, 31 Oct 2025 04:12:39 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d7793fsm1887363b3a.25.2025.10.31.04.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:12:39 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:42:04 +0530
Subject: [PATCH v8 7/7] arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe
 switch node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-tc9563-v8-7-3eba55300061@oss.qualcomm.com>
References: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
In-Reply-To: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761909120; l=4926;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Sv6AS5x3K2KhKdvBG7hjL3mkMhlIbMFrdThx5r4suHY=;
 b=VX+YhjKJtJD40qFOq1GND/xG5L/kqX+OJkjs7zINkHHUOv1lZZX4pk4lZbz6WMcKoM342Sm2c
 MhmpWscQUUqCWQTnYRBMk5sgCFgyZkTcc8AV2FnFRrt1eom1j68PVCP
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: dymI1PKlkd5LCrz-kFJErw_kIaqv67jY
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=690499a8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=xTuWgevKKEmUOcCBws0A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dymI1PKlkd5LCrz-kFJErw_kIaqv67jY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfX+8RFMGpdSfgk
 JoATf1mQw2Yfz7F2iZTrRNQl7SeINziEf26OZHXNMAcLX02zBXzPi93nc9MCOdwzmhj6wenV3MT
 IDFooor6vN46AvrNzx0VgsVmH8CBM93rskctAwFRdP0I6W+oHP3UM04jF6A83f8msPhY23xo813
 wFhE2cPVmyXDWVa7nLRmH3WjSmHxbFFUnonG8yQNZgLiPsVU6PSTxBzWVsuFHdRukGPUY2UKHId
 K8d5+cGdfZBpshp+03ZNY0Vfq1+F6azndoySgme3UaLJrcc6XF6C1a4RvtJ1nbDmagQbrlNaSRS
 GtvOuTMF+I3NWi1shT7M1gfHesL/sl8r8TgshcJNLB+gRDGmhV+kjw/n79rp78+VDR//z9cq45h
 5kF3L1Pn3U4GY91vzwKi+91FMtiB8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310101

Add a node for the TC9563 PCIe switch, which has three downstream ports.
Two embedded Ethernet devices are present on one of the downstream ports.
As all these ports are present in the node represent the downstream
ports and embedded endpoints.

Power to the TC9563 is supplied through two LDO regulators, controlled by
two GPIOs, which are added as fixed regulators. Configure the TC9563
through I2C.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 128 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
 2 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 18cea8812001421456dc85547c3c711e2c42182a..6aa49519508a2f88afa23f8f8015f986c0a5b84e 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -262,6 +262,30 @@ vph_pwr: vph-pwr-regulator {
 		regulator-max-microvolt = <3700000>;
 	};
 
+	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_NTN_0P9";
+		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <899400>;
+		regulator-max-microvolt = <899400>;
+		enable-active-high;
+		pinctrl-0 = <&ntn_0p9_en>;
+		pinctrl-names = "default";
+		regulator-enable-ramp-delay = <4300>;
+	};
+
+	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_NTN_1P8";
+		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		pinctrl-0 = <&ntn_1p8_en>;
+		pinctrl-names = "default";
+		regulator-enable-ramp-delay = <10000>;
+	};
+
 	wcn6750-pmu {
 		compatible = "qcom,wcn6750-pmu";
 		pinctrl-0 = <&bt_en>;
@@ -843,6 +867,78 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&pcie1_port0 {
+	pcie@0,0 {
+		compatible = "pci1179,0623";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		device_type = "pci";
+		ranges;
+		bus-range = <0x2 0xff>;
+
+		vddc-supply = <&vdd_ntn_0p9>;
+		vdd18-supply = <&vdd_ntn_1p8>;
+		vdd09-supply = <&vdd_ntn_0p9>;
+		vddio1-supply = <&vdd_ntn_1p8>;
+		vddio2-supply = <&vdd_ntn_1p8>;
+		vddio18-supply = <&vdd_ntn_1p8>;
+
+		i2c-parent = <&i2c0 0x77>;
+
+		resx-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&tc9563_rsex_n>;
+		pinctrl-names = "default";
+
+		pcie@1,0 {
+			reg = <0x20800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x3 0xff>;
+		};
+
+		pcie@2,0 {
+			reg = <0x21000 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x4 0xff>;
+		};
+
+		pcie@3,0 {
+			reg = <0x21800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges;
+			bus-range = <0x5 0xff>;
+
+			pci@0,0 {
+				reg = <0x50000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+
+			pci@0,1 {
+				reg = <0x50100 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+		};
+	};
+};
+
 &pm7325_gpios {
 	kypd_vol_up_n: kypd-vol-up-n-state {
 		pins = "gpio6";
@@ -1119,6 +1215,38 @@ right_spkr: speaker@0,2 {
 	};
 };
 
+&pm8350c_gpios {
+	ntn_0p9_en: ntn-0p9-en-state {
+		pins = "gpio2";
+		function = "normal";
+
+		bias-disable;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+
+	ntn_1p8_en: ntn-1p8-en-state {
+		pins = "gpio3";
+		function = "normal";
+
+		bias-disable;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+
+	tc9563_rsex_n: tc9563-resx-state {
+		pins = "gpio1";
+		function = "normal";
+
+		bias-disable;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 4b04dea57ec8cc652e37f1d93c410404adaadd5d..23cf2c8c72b0bab67467e4b60cd57a3e658efa68 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2424,7 +2424,7 @@ pcie1: pcie@1c08000 {
 
 			status = "disabled";
 
-			pcie@0 {
+			pcie1_port0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1


