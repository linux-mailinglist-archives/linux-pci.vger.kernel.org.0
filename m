Return-Path: <linux-pci+bounces-32050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A46B038E5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 10:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406293BBC05
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248A23BD00;
	Mon, 14 Jul 2025 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dZ0IsSah"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AB23ABA7;
	Mon, 14 Jul 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480949; cv=none; b=H1dwe/73Vyskct6SSO2/RwWrGl6Lln9KrMIy/PWgSZPPsNrq/rFtBJ90j+mWxSkey5BjwzEYqJAtoNHmC5G+3/9Wq6Ex1+oHAgSy2QCUkyiYDPQWq+nkuFGnLv8KWbz3A2DCIqKaf67IJJR5+Mg9nGul5AeEWMFnmZKqHl1VJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480949; c=relaxed/simple;
	bh=Jt52jlXXpIVJ6+Yz9ofTNzUcd+JZGnAKZtf9SsstxxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h28fkkiK6KNI9wWjaKj6ZFANTm5kRg1WAk7bGrVMC9rBu7N9h5G4hGbzohI4iu0jimprMr9psp4JtRbX4rVDqUt3Wj4/wcMb6jS5LNIVpVKAiw6f2MqyMnH+hSWLCJhPK2Y3hgl35Yw9WuMGhOAIm+bUcIHWDws1YexEfS/h5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dZ0IsSah; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E668Cu032491;
	Mon, 14 Jul 2025 08:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pWwJ/w43nyQ
	rHKaFUu+VmINEuRCr6YLGbr2YyG2KKFQ=; b=dZ0IsSah92qZlY3LmrKqwJQmxn+
	TWnMCzvDEGYnYgjI5FwCk0lAG1gbTo90fvkErbcfcLfvw/dqi8Quu9AUyVEx51Qa
	eHvpzuVQVRCP7I+XK4mmERsFK3oK6Z1HSpVE9ZfGwtiXCAaqmv1OpMuJJk7pKo+A
	m8ddH4S1Da4uddN9ONTjNutIP6L9o2bvwvRyGWMJij7wXBegyX1A9Jki2O+Nb+tm
	O3Ifxw0FxVmDwm0+/4SeCfoUBM0D+EDe5gnHthg5aJT6sExf8s0JlG6kNa9+Csdn
	ie2y/6O5m0jpcErzfWhlEQmfzUW/mkfkgrq0EAe54gsALqWfpU0cET2y8TQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vvay0cev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:15:35 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56E8FXo8026676;
	Mon, 14 Jul 2025 08:15:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47ugsm629e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:15:33 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56E8FWBN026657;
	Mon, 14 Jul 2025 08:15:32 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56E8FWvO026651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:15:32 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 13DA220F45; Mon, 14 Jul 2025 16:15:31 +0800 (CST)
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
Subject: [PATCH v8 3/5] arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
Date: Mon, 14 Jul 2025 16:15:27 +0800
Message-Id: <20250714081529.3847385-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com>
References: <20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: yIQQTaAkAeT-0gUPvVmu1pxHrqFJNyki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA0OCBTYWx0ZWRfX/TTxjsvPy6Wd
 rzQ8lyJuIHtnei3YcLLYxezjGAeT7x1QU79wixrLaRLmVPVJOwUiZOQz31074y0APbjf2N9yhu8
 0BnePGCDNJ34Fg4NI/sJGMd1wYkL2ba8/Fa7P4Srwwn7fR4YzXJON+O4lN/dVZCSHhYbdgq05It
 pytuXXMbw/jc57br+m3Cu1mKiM9MWCrxu/wqMTvwo/Ih092AxGnGupvJfPPX+Ozuq7F0u5D3fC7
 JEGk49XVnhhGEaZyR99yL/AcNN5V+WK4+8zR65lkN+8bXqd2p/RTFPl1AV59G0GVUZqRXzlr6Od
 dnmVxO1dyX1Ilx57gjKnMGO50ShjGNmbcsmPzYisa9nWrlf3SLXs8DowW2qX/Ufxc7K56MxAK3B
 RbmxR9ssbGegnXdcifD6wptGV77crwEOFMTB818zqQI6r6MRiKNeUVZXUDqBK2tccKI8CwFE
X-Authority-Analysis: v=2.4 cv=GNIIEvNK c=1 sm=1 tr=0 ts=6874bca7 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OcCb8rqeGctm4X3z9-cA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yIQQTaAkAeT-0gUPvVmu1pxHrqFJNyki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140048

Add configurations in devicetree for PCIe0, board related gpios,
PMIC regulators, etc for qcs8300-ride board.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index 8c166ead912c..e8e382db2b99 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -308,6 +308,23 @@ &iris {
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
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
@@ -348,6 +365,29 @@ ethernet0_mdio: ethernet0-mdio-pins {
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
2.34.1


