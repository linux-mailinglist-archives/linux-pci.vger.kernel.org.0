Return-Path: <linux-pci+bounces-9301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CB918109
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 14:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941CB1C21723
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A031836C7;
	Wed, 26 Jun 2024 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J16yziNq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF41822CB;
	Wed, 26 Jun 2024 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405497; cv=none; b=jDOKhPPmcfyeHgcE2AoPIiDXhSgsAL4TxtK8ceENmlOc+4RHninVmxnwae7cRuQFy9K5GJo77i3Yuj/w3TbViJcgI1iKpYWQQIbiZh57L8J2TmhJI3TDcBuD69Py+EZ3cjmGOVJahMCj166SrSzHMyqwEMRDi346I/66dtA9jeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405497; c=relaxed/simple;
	bh=fCGQL2xdobFoV3TOvDGNRKzN4TKnBTgn6hF+FGAUroQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mcsEo/6FaW0JoREb0sTP+Jy76MpbBgrMd+u9r7JCsRzPQuDKdm++yGPpUJOMHOemdw8l+Mqhcs/Lg5/oFAMBMHWmqo2HobD7NsF7yoP7DRiT9Tu/1WO2PyD8tnKVSCR09hXILnO2k4e1bB37NxlR+GJnF76hr04bXd4HHCo7rqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J16yziNq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfPVV023196;
	Wed, 26 Jun 2024 12:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xKeJPkqNSwDqC/r381Pv4XIoTG98Zex4SZej+f5sip4=; b=J16yziNqAiayF4FQ
	KrGgFP0yOwOKHM3ud+Kwg/1PYI+a5NBrFpbAbNDxb8ESPXTutKPNpiZrssg+DpYJ
	XZF6ea7lm8MMZpBj/mcfXCBTudiQdvh2UhqTcxhjPu32Pacd053hyP1NvuYHy3o8
	fsgGKgzbF9eJRZXy5SPZDzuTnrI2atzTtDoU8ujfdNztB2Dh1ysI+Ahyw4yTnMdk
	aLVvo7NDYKHq+9FSTq7sikJHP03Trdpi8IRBvpgGSoyl7n5HdE+v8AEFUH2YtNIc
	ffFtfmOKWoxKLfPFdl0NqCFdjc/WQtG4wFHG3qmTcK/UnSHD0/9TB5/Gh3A/PXjb
	vXS9mA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywpu194m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QCc7Ku001560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:07 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 05:38:01 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 26 Jun 2024 18:07:50 +0530
Subject: [PATCH RFC 2/7] arm64: dts: qcom: qcs6490-rb3gen2: Add qps615 node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-qps615-v1-2-2ade7bd91e02@quicinc.com>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
In-Reply-To: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719405471; l=2284;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=fCGQL2xdobFoV3TOvDGNRKzN4TKnBTgn6hF+FGAUroQ=;
 b=iPb1zkL3JhQOr0EuK2Hs0IBtLEUHOCintbcdEjclceLnh/TI3R0Igd35M10YpeSqu0JXdI/Jd
 oXj2HbY7m+FDxmPNPsAqgabNRB0sbvB9ZzgJ8hbhLRL/yA+nFc98RG1
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WLdN2Rdh0IBG9-9jf96eKCkJRtAOZ2nE
X-Proofpoint-ORIG-GUID: WLdN2Rdh0IBG9-9jf96eKCkJRtAOZ2nE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=978 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260094

QPS615 switch power is controlled by GPIO's. Once the GPIO's are
enabled, switch power will be on.

Make all GPIO's as fixed regulators and inter link them so that
enabling the regulator will enable power to the switch by enabling
GPIO's.

Enable i2c0 which is required to configure the switch.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 55 ++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index a085ff5b5fb2..5b453896a6c9 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -511,6 +511,61 @@ vreg_bob_3p296: bob {
 			regulator-max-microvolt = <3960000>;
 		};
 	};
+
+	qps615_0p9_vreg: qps615-0p9-vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "qps615_0p9_vreg";
+		gpio = <&pm8350c_gpios 2 0>;
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		enable-active-high;
+		regulator-enable-ramp-delay = <4300>;
+	};
+
+	qps615_1p8_vreg: qps615-1p8-vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "qps615_1p8_vreg";
+		gpio = <&pm8350c_gpios 3 0>;
+		vin-supply = <&qps615_0p9_vreg>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		regulator-enable-ramp-delay = <10000>;
+	};
+
+	qps615_rsex_vreg: qps615-rsex-vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "qps615_rsex_vreg";
+		gpio = <&pm8350c_gpios 1 0>;
+		vin-supply = <&qps615_1p8_vreg>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		regulator-enable-ramp-delay = <10000>;
+	};
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&pcie1 {
+	pcie@0 {
+		device_type = "pci";
+		reg = <0x0 0x0 0x0 0x0 0x0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		bus-range = <0x01 0xff>;
+
+		qps615@0 {
+			compatible = "pci1179,0623";
+			reg = <0x1000 0x0 0x0 0x0 0x0>;
+			vdda-supply = <&qps615_rsex_vreg>;
+			switch-i2c-cntrl = <&i2c0>;
+		};
+	};
 };
 
 &gcc {

-- 
2.42.0


