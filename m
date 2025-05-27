Return-Path: <linux-pci+bounces-28442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5DAC4947
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 09:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477D017A7FC
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 07:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E52225412;
	Tue, 27 May 2025 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sg/zIrXU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA310225401;
	Tue, 27 May 2025 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330464; cv=none; b=mNCYSDWza9qJ3ywAUElOm2G1LNYmRhbwZ3D7qwaREoFQn7qK1Yl73vedIbDyLY9aCyX4VcG0DBo8Bond2/Afv7oovD88WCt29cxiKjZh3PI6En/cm9vKn9SdGP0sLrlRY0q4fscsSc6yopKqJLLY9TeUnKjZlM8pQu7SrZcQW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330464; c=relaxed/simple;
	bh=GEBxARZbcQgdp5vTeehWsIfkmlimL2tx86J4XBhg4ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsdYn84abU4IIW1Lahr0t49AbGaXx4ymLUikq6lMGAdKgdsVpfRG5fjyBrm3wKlM7x9OZi8QT9uAADzd+6mNzBU+4Li3s0+yB5SHidUTCOAxSldnpfkkdVfA8h38NoqizqKoARMnjbHbNjACT4JxWXjQiY6WqNseCfevn7vJQtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sg/zIrXU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R3m3Xi022931;
	Tue, 27 May 2025 07:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DOXfUaLGj/g
	S+Zr8UFXyHwLt/ZH1hnsvAGyeGBCsfj0=; b=Sg/zIrXUO/LZyOPeyyaOtlQe/TS
	iOtPqsfjXxIGSFLsWvgAPvPUZOM933p5fxcvAxvkx2toU8LM0kqvRg7LQBhJC8dx
	BFj5QKYOVAJtVj1qIDm0fBT6WFxx94vdY0KoH8O8tZsxzuUQvdqm8bOhTrKLqha1
	rO12ZN7dvaAuOwJQ7fY8sqG5yxjOdDVMRNO+2+N/LBPX68Brgx2v9NQvzhU6mAD5
	rTD56q6+W5cV7IXvzdeyeshnHkhjHjkpe4/n1fmlh9nJG4uzkYsIjq6HTn8IiwzL
	4SJJ2XM4IJntq41n/Inuv4RsXjpFCtpsBguZllWUYDDdcM6mynV9lzJF/Eg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u3fq65x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:44 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R7HYCj006548;
	Tue, 27 May 2025 07:20:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46u76kypej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:41 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54R7KfF4009573;
	Tue, 27 May 2025 07:20:41 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 54R7KeYA009564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:41 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 7DBC53504; Tue, 27 May 2025 15:20:39 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
        krzk+dt@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v5 4/4] arm64: dts: qcom: qcs615-ride: Enable PCIe interface
Date: Tue, 27 May 2025 15:20:36 +0800
Message-Id: <20250527072036.3599076-5-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-GUID: OVnjQVHlcmkPB_CervXwcnv5B6Zq7etl
X-Proofpoint-ORIG-GUID: OVnjQVHlcmkPB_CervXwcnv5B6Zq7etl
X-Authority-Analysis: v=2.4 cv=X8FSKHTe c=1 sm=1 tr=0 ts=683567cd cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3zbVK_edIv7hY8gRkFcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1OCBTYWx0ZWRfX/q7qZyXk1KM8
 169iDeVgVQL3qIuEA0v5xi+ty9cBA4DGzSD84m7aYm4oYgniaxbn8JZ7cERgx1X5PzIMf/wdHKe
 ANLZtOHne9SP31mhMcuPbv9qIO2vkLD4f4ktEVWZ5BNOC6OrjNqKuZBXXoZqYAV+3WvJslneTI4
 8rC82T5gKNa1augjU5+ExUG5EWO43ltUdEWgwTxOp/gPtPtk2ZVG5xZLbRu5XBJu8AdSENGMlvS
 stAcQnZSgGI8mzGA2K4jGdkkFsp5KJ3Zr/aic9voaCB+P7CXxYmcH1BDAfUY+cE8s0Kml/L30iM
 WrhK3f3bgDI4iGfm85b8a5mvtaJdYEHuvHVv+QL8iReVq4ofoZRT4BzDZ+yeQZ1bLPlzYUidhYl
 K3r6I7ZYNOIn13swJhHIbIK2JT3Ngp3keJo4AiU+hEenykEcbMIzdBY+S0Y+VeOdKUnNT9K6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270058

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Add platform configurations in devicetree for PCIe, board related
gpios, PMIC regulators, etc.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 2b5aa3c66867..c59647e5f2d6 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -217,6 +217,23 @@ &gcc {
 		 <&sleep_clk>;
 };
 
+&pcie {
+	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l12a>;
+
+	status = "okay";
+};
+
 &pm8150_gpios {
 	usb2_en: usb2-en-state {
 		pins = "gpio10";
@@ -244,6 +261,31 @@ &rpmhcc {
 	clocks = <&xo_board_clk>;
 };
 
+&tlmm {
+	pcie_default_state: pcie-default-state {
+		clkreq-pins {
+			pins = "gpio90";
+			function = "pcie_clk_req";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio101";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+			pins = "gpio100";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc1_state_on>;
 	pinctrl-1 = <&sdc1_state_off>;
-- 
2.34.1


