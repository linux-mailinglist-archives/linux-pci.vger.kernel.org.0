Return-Path: <linux-pci+bounces-36626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1329B8F5B0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F82217E248
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BD12F83DB;
	Mon, 22 Sep 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XGSFlW3W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD062F659C;
	Mon, 22 Sep 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527732; cv=none; b=JDnHJra8edgpDZxicqREJSlFJnSt0Gqvtu2nSXMh5YLwaMJMsX9gM0pIJ+aFf2GhuWK+/cxJmQBrFmaPumDIDPwvRGWqEAgNyj8CNHoEVCG0CJUSW/50aUFKNUdiOOxR5xL1ZITEsmpMxc7qPs22BOTnt9hZKYGRG725S/saFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527732; c=relaxed/simple;
	bh=1ZM8ZSOgTVANWla103FuePqAq5Tgvm5AG0DsXu+dqkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QasoF6vGwPDPLl4SoRnOge6FFFY1BDrVNJS6oot6Se7yT0SX2GYowQK4kPQWVfFTgO4/KancZhbMTRMN/7vSs93KHC07h+t9KKYP1H6d43rqZ9Mg6bqWuLaXh6Ni4a7hsPpkmiGbKefIXP05YXHjCa1y98SMbJf83doACQQ4IxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XGSFlW3W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LKj4Up022012;
	Mon, 22 Sep 2025 07:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5sCZH0rItkT
	0O/UxY54cPLKGJrfMJ9LJ+/8hSDXb78I=; b=XGSFlW3W8+0K7v8wIlNGpoyQ0CO
	SRH3xsXVkbqvUMPsrG34mBMyLcUKHoqKIcIG6aAr0Ms/c8JbyaYPrbfS7z8jAG02
	p6va0v7wRGgdMXXTeW6sdKChYlirMJE3IFEtQ6t6/sHUVkDg+XTGJUiEe1jYkL4B
	DtTAN4qT0r9lB0/gkm30HEaoGi3n8R2AVn4CTT1mr5Gb4CuNvpKnSzdUHnE/WnSs
	voW3VwPD6jXO9YyhI5tEbVw4JQYbXUo38sXpwICJ/JGTTr7v6AycSfxhtidQ0wof
	DIjtAjSfpV/PgRJ5wg47RqUTeT/81d3R1z54BFzybuU2i48aRaoTLe2PQIA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fbsad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:18 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7tGKv022236;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 499nbm0544-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58M7tGWr022219;
	Mon, 22 Sep 2025 07:55:16 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 58M7tFNA022211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 07:55:16 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 94A51B75; Mon, 22 Sep 2025 15:55:14 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v1 4/4] arm64: dts: qcom: Add PCIe 3 regulators for HAMOA-IOT-EVK board
Date: Mon, 22 Sep 2025 15:55:09 +0800
Message-Id: <20250922075509.3288419-5-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com>
References: <20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aBUZXnnV_fE_VZYTCwY3WSSvAYgy6VeK
X-Proofpoint-GUID: aBUZXnnV_fE_VZYTCwY3WSSvAYgy6VeK
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d100e6 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=XGVIsFbTfmVoesHaU64A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX8E4vrbO/8oDx
 FNvruL/3cP+CPAtbd0ywJLsjSn8afhCbeK7UvKaWe7/P4T9kgtrPmxAEDzkWNlzA762KeUtwH9Q
 WbLdknkYrNgyULr5YrTZFr+KSvgycVJkClynLGhv+KnuzJm8yziTUNQZ+PE29lYDm2vWu+H4ah9
 1QgIS6lE5TjqwCu8RedFog9gOQBzjUc7ZP468QbM+8NrjLw12VLT03VTNo0RA3tiWj+pMh2WM/4
 95s+MhWamuhuo8szwNo2GnQeE2i9qxCUJYMmq5oNajo0f302OkUSbvuEtP+SYIcUwwV61oFWwHx
 LrYQ1HRL20LIuB3TACYfZUlKiATiICv15wfw2YK+/qkrTS/QUq4rLIV5oXTole19aFst641Vlvz
 EkVKgsK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

Specify the vddpe-3v3-supply regulator for PCIe3 using &vreg_wwan to
ensure proper power configuration.Describe the voltage rails of
the x8 PCI slots for PCIe3 port.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index f0e4abbcc1ac..0eb85d6cf4e9 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -414,6 +414,48 @@ vreg_wwan: regulator-wwan {
 		regulator-boot-on;
 	};
 
+	vreg_pcie_12v: regulator-pcie-12v {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_PCIE_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+
+		gpio = <&pm8550ve_8_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&pcie_x8_12v>;
+		pinctrl-names = "default";
+	};
+
+	vreg_pcie_3v3_aux: regulator-pcie-3v3-aux {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_PCIE_3P3_AUX";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmc8380_3_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&pm_sde7_aux_3p3_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_pcie_3v3: regulator-pcie-3v3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_PCIE_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmc8380_3_gpios 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&pm_sde7_main_3p3_en>;
+		pinctrl-names = "default";
+};
+
 	sound {
 		compatible = "qcom,x1e80100-sndcard";
 		model = "X1E80100-EVK";
@@ -832,6 +874,12 @@ &mdss_dp3_phy {
 	status = "okay";
 };
 
+&pcie3_port {
+	vpcie12v-supply = <&vreg_pcie_12v>;
+	vpcie3v3-supply = <&vreg_pcie_3v3>;
+	vpcie3v3aux-supply = <&vreg_pcie_3v3_aux>;
+};
+
 &pcie5 {
 	vddpe-3v3-supply = <&vreg_wwan>;
 };
-- 
2.34.1


