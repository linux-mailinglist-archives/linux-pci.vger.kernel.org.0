Return-Path: <linux-pci+bounces-35643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E92B485C8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 09:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3A1340631
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 07:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9DB2ECD3F;
	Mon,  8 Sep 2025 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4DhiRyK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AF2EBDCF;
	Mon,  8 Sep 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317148; cv=none; b=lgqKRnXG4J43j3i/XTZlJmNbxG9A0DaNORiqkamCZut1rzfoQnIdRirUrwrfVIEi6/C5WJrtjposmbtBK7VuRi4w+zMGG/+UDJ53FjBM8gSxQyhQK7Iy2mHmCJVS7LPMrZ6S6jpazSKgdSbWO6uL1SIG1n/GcYpUIJj3kH7zrSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317148; c=relaxed/simple;
	bh=r/9U3pY84yYcMwXx0SLcNkj2DatVVQ1pfMKXzczD1to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sjn59hWvKgNqi2pv1YawGGavbL4bj1fJcw8SkhjzZeYNsY8HVbUkNsDAz6DzcxMpmZKhty25u1st7UhdLJuRZN+Ibu1F71b9CLkgHvmL0z4WJcKhNwyGUPbyNDE8sxy6fWXnCeRzrVdEj7ltidrThsRjIL0s2MCFPkKd+sKXYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4DhiRyK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5886g1DG005771;
	Mon, 8 Sep 2025 07:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6bH6C7j04tm
	asdMjlt7OBSo7qa3kReQdwfYrBELSdvw=; b=b4DhiRyKDJoXPZtTrvtALGqPtHj
	BztjNndfQVLLV49M1wfnvGHbcv0CvmpRNA6jAfMiVtq9Umb738P/K3OuVcx0QjOR
	+g/ZDbGOGUSQwx6Ff7nvKgotMo/jqPkjcn3vkC6kCADWG1M9W/Yl0T7NQrXnBd2L
	3op31hk7AVVxRU3NszyPXEdSKtzN+N0IT6dEUTQwuxll6dawuxYuhIhcb5RJ4eo1
	BQ1yVjZuuEIohNnc7UqdZhfSl1kOEh9IKtuvK0gzn2BQOKAOCBx9ciO5r3Cu4iGk
	lXWsh1yfKtdxcn3vtnLanJMOu70IHaNHoAHXlOgT5J2oPyVJY6+KqM7fzDA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37r5f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 07:38:54 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5887cqLL020689;
	Mon, 8 Sep 2025 07:38:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 490e1kr3mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 07:38:52 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5887cqMJ020676;
	Mon, 8 Sep 2025 07:38:52 GMT
Received: from ziyuzhan-gv.ap.qualcomm.com (ziyuzhan-gv.qualcomm.com [10.64.66.102])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5887cpic020669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 07:38:52 +0000
Received: by ziyuzhan-gv.ap.qualcomm.com (Postfix, from userid 4438065)
	id 59D11526; Mon,  8 Sep 2025 15:38:50 +0800 (CST)
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
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v13 3/5] arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
Date: Mon,  8 Sep 2025 15:38:45 +0800
Message-ID: <20250908073848.3045957-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908073848.3045957-1-ziyue.zhang@oss.qualcomm.com>
References: <20250908073848.3045957-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Os06pDSNA-05v-tAiq7DVrm5YnPk_Kmw
X-Proofpoint-GUID: Os06pDSNA-05v-tAiq7DVrm5YnPk_Kmw
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68be880e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=w85BKG6iza2igC2YtlQA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfXyB9qVr1+Tb46
 A8J1NfGtoBpvIm+Fj8DVVwggTufpz+mwKbF6G7CyvJJpGUlt6O9E5rosODsaB6JvD6f9D4Wf2Ai
 xd+dzoP8cvRlxbtM2EjCzj/iikxzFQIDQLgoXeNlIsbyiaRlEGVKZksKQ7b73q/oqOov7ru/fus
 ijgsE4kF1vGKdlRcrTE0+obFpa2fTpbitqgm/ir2kSlxNRSzFA7Y1jYzObaBsC7Ba/quZUKgzqn
 UNNHk/CUIk2NZXpOLwXhvg5WTe9tvCv+H4k/5r1baw/PjXyrnRI3HamCcOG7B3U1gIgXbWMHLYe
 4J4HmLPxWZTGaMAjjJkM86lwhCPNs8GZXyhS+sVDM8B0WVvn6JcP0QIFMyH5lE/eg7wH20wkotO
 YBSyaMDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Add configurations in devicetree for PCIe0, board related gpios,
PMIC regulators, etc for qcs8300-ride board.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index 9c37a0f5ba25..9d2653007866 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -309,6 +309,25 @@ &iris {
 	status = "okay";
 };
 
+&pcie0 {
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcieport0 {
+	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l6a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -369,6 +388,29 @@ ethernet0_mdio: ethernet0-mdio-pins {
 			bias-pull-up;
 		};
 	};
+
+	pcie0_default_state: pcie0-default-state {
+		wake-pins {
+			pins = "gpio0";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		clkreq-pins {
+			pins = "gpio1";
+			function = "pcie0_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio2";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
 };
 
 &uart7 {
-- 
2.43.0


