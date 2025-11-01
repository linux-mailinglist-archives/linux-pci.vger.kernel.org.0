Return-Path: <linux-pci+bounces-39995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11782C27759
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 05:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAE61B23C47
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 04:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762A266576;
	Sat,  1 Nov 2025 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0FLZs4F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cO/KpCnU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22B326FDB2
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969621; cv=none; b=H7S+tDvKIncdPI5yjrYBoTjYiApvB636dgk6vxZ1ZNaIYEaLOEMPAguEurcGfVNCXrM3/jHlR4HOsDzflrta3jwN16dE3zAPn9otOR0a/kFTmR1s53LyifdbB1nleHVTp1w3p6n3Vdmk6PSpUEzy93+Sy1KxfxGRiZFSh8s4H5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969621; c=relaxed/simple;
	bh=Sv6AS5x3K2KhKdvBG7hjL3mkMhlIbMFrdThx5r4suHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3LBHtD5FJH2n3EUocPuCMR9p/tvh5KauYYoBFr7u+EDBDs6nRae2cg8GZAbvA/kMgFIyQSyti/fqN1W1cZWRtwlzUjuRzxY9zfEoT+AJuW2ekBYKH3KmeF9ZV+yMqxcnTDHD22rOptz19Zvnfx/eaVOGnHHBBRC5YDSOnixeWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H0FLZs4F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cO/KpCnU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A129GhK313329
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 04:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OVxVd9mZ1eZAjQgeyNOAfdUg8XGT565AF3QZkQ1SayU=; b=H0FLZs4FXwnUPBnP
	ubz3NPtz1dkywrPLoqlkpdbPpqEmmfOMQyAyQCOErrVjBLrv/bxlLlUIwwWhRqWS
	RK8srHJiZ+xjbMe7AtJ4PYWONMNiKWKJZ76wpBydgfqlFgAmgI3rWwGemLPYwFKQ
	Ya9KRNy+I1wgz+TEaZ6zRYpz20ZtBXvBxd1HIfP1tdBZ8y2vASYXJ/Kngm7ag57k
	MCsXyRdNBVL00OJAL8TdZv6APmN+BxWDGaqOqkzKYtKlFrlK2nc7GSS5NnUM+758
	kBemh2LDpPUKHSJF5fHvFubDBZ5me3RQAkl8lfiE1zr3jrpeWqelSx7TAfHFsyHk
	3HrS3w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a595rr4bk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 04:00:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-277f0ea6ee6so28902585ad.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761969618; x=1762574418; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVxVd9mZ1eZAjQgeyNOAfdUg8XGT565AF3QZkQ1SayU=;
        b=cO/KpCnUhbOLH44AuhWEZuqDWKRkJCNijNjV6k7p5iQO3gpYIFPmHmMkgqheetLsqh
         1BdSntBqcPUfAS8wT86hKs1pp15rFlIVSD2443wRFsTyHKIWrjG1BuSZQTKfq86+MuBf
         wrvL6SVRVeSxlf2NpPwhTTV3XJRfU+5bxJW1qov7YnYCLxDFIZI5sv9LiD9yh2yPMp4W
         ipfNt9gBrbU9t41C8zX92RPkpicPJW8gQ150FqOI1u0HVMiNA0MYc3m4D4KqfEtC4bXf
         KZzMzPGfHSJvHPLRKQ/eclyQ9WYgApiCjrZTgr8ZecCtkIps0PWAbsWlgZgZoK7xm/9h
         TBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969618; x=1762574418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVxVd9mZ1eZAjQgeyNOAfdUg8XGT565AF3QZkQ1SayU=;
        b=S0Xs54U1FfinlFIeO8PlsqwEl6/XuXUppcK45l5iL3+vZfvWrh0YbITqCykuFPmhqO
         KmZj4WbMwQ76xzRsj0rMOxs9unZChKlmPV2q8kLvDQgGZyj2E55DOviPYHIcmiHrLbEc
         ZNQLvXMtvZoFzbXtS9Q71lOXco24RtdCJF8uec0Vz04A/zLwbusHjLtPENwtzy//Nh5N
         YtmFg0Bh7WI41NxzeT18+i0UtrqQ6yLGZAdTtZZXcypOyQrpVbyCxAKKW/KAq4fyI7fA
         B3c8GCbRwO6A4zY7/AgEMJWIbIkpHvGHU0QPTZPt3ejAvATyu7Yb5aJaJGMGIBo45ePT
         cXcA==
X-Gm-Message-State: AOJu0Yze//eD4O4+f9Z5C0/0s288V0u0dUs0nHkO7SumrR5G+Gb/sL6I
	ZH/H31iuMQgHLG0YD28y77rQTlqGFGNLGVuAR69VKSyBfWf1iPz9BstKniOZOAih3nbKSozZL/b
	dH7hN+TR0hryDSuZOsUicRJQOyxrGKHvt5pKyXcLF5dDvBmzEtiRmmiummpAgjZ0=
X-Gm-Gg: ASbGnctNb/lirdWiRg3/lxJyP5WBC2q9EThakosda+1yrNuG3clyQWRoXLMJ0ysuSVa
	P0s49qvpoIdwfBKDnAA5v5i4wfjvzIldMoRK4tghp6vXhm+pAeYUgO7sBCnu3gh64JU5UppyZbO
	W6FPV1JKcrIQES/ZMYRTbK8jLtKL0Fw1zJz/nuboCReF2lPTeezjCatLzRRQsHKF5v8wPLsNvMm
	PA00zBT1ggZr/BgzbbpGeQCXXbe94taUo+2W5Qin8BqicDs4JC6prFoxnVdgcf4j7ELsu4ykVPZ
	g3ZmOavhMfmMeebxmxbOJmbGwKm12Cc4ayyfnbyeMkgXfSENfZ44A7RjjtKBGZv73rr3Ecvuc69
	xigHaUihHwYmmJTnrQ93K32kvFPUTRZG6TA==
X-Received: by 2002:a17:903:228a:b0:295:557e:7467 with SMTP id d9443c01a7336-295557e7b0emr18852865ad.17.1761969617938;
        Fri, 31 Oct 2025 21:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV/YE/IZxbEQWBfscMXqHdSN/fXQ8HkGeboGhi9RTUNzK1qMXttkj1i2AMDNt4xiHGg1Mg0Q==
X-Received: by 2002:a17:903:228a:b0:295:557e:7467 with SMTP id d9443c01a7336-295557e7b0emr18852405ad.17.1761969617427;
        Fri, 31 Oct 2025 21:00:17 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm41490725ad.2.2025.10.31.21.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 21:00:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:29:38 +0530
Subject: [PATCH v9 7/7] arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe
 switch node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-tc9563-v9-7-de3429f7787a@oss.qualcomm.com>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
In-Reply-To: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761969577; l=4926;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Sv6AS5x3K2KhKdvBG7hjL3mkMhlIbMFrdThx5r4suHY=;
 b=rDOAemcF0w8IU32RA59R4X1zFkonTPWsF1dEHqr8SkRW6PooUOIcH4PIOIK8gEPdqPquu5SqC
 mNyldpQEqyICkELP/2zxSxA3OMeAVsvL/9A2jO3N7oUL+wEtj/GzjcY
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: Y4Z1KceJ7Dzs77pwMOjUmhipcP4m2Y1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzMCBTYWx0ZWRfX4j30xAIxSNwD
 EwUw1nCT6PY8LBWelNgpvpAljqfcI8osamij9zVhl82CoV6TcfQnRicsytQzTzfLsDjplQwpo4x
 UIfsaYgI4P1yGmtKrL3H74y8t+LWBadaBNUOwFmVKN9keY2SEuH81Q8qgzonXKqDXC/oYC7OieZ
 Fat3xWMYTM8nDbSk9nMXRc73fUFbOMQVfX6tm4vYqZUU7JvZ5gyWmXknLt97FZ3Su2r76r3PHRT
 0g2sDaiTAWWA22G6mG5WtS7aQIg4JlsUFb+e/J1voiggdHGyAY8FHgw1UaMsNY+qaIgP7o69k6B
 2y7fgANQ24XGAVYOiFg9SY1WSNwgyE++5RtRKMAbzKRiOmpihItfZozRAszVpyMTgcTZ3d+E5Sd
 bpmQXbn4VZgKxW28nYtqTptxodgUBA==
X-Proofpoint-ORIG-GUID: Y4Z1KceJ7Dzs77pwMOjUmhipcP4m2Y1f
X-Authority-Analysis: v=2.4 cv=XYeEDY55 c=1 sm=1 tr=0 ts=690585d2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=xTuWgevKKEmUOcCBws0A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010030

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


