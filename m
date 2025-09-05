Return-Path: <linux-pci+bounces-35509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D1B44ED8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 09:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93E51C83056
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 07:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3F2D7386;
	Fri,  5 Sep 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PzjStiCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7925B1FF;
	Fri,  5 Sep 2025 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056512; cv=none; b=BBH18KpJ9UVBrnbgzJaeLDuCZQRB9rfqnbweBxvBSTQOSfxfMOP69NeKvmAxVRc8FN8jSPXIGWc8uMFcCOKpmhZwlWTc/16fPORwSaPyUWP9qbYL0thJ4z7Z7IdjgS9YXtge0gDMCctTeudSZl2cfTDPQzXNMlxAQUUhuR8cnxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056512; c=relaxed/simple;
	bh=hg37dBqxbn9w+hRfP7vuCVYzT7CoKj7hfQ+M+4ZbxWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcMDYgI/X3pEF9LK8pKPgPbZN07x9LXVEhm2YAGU/pn2PTTEuqrMmOvrV4KJKo6PMTW0sKF3K7d494QNYm/e7qZiAJT7AHUyao2znQvZS3S0t1ncseGkt811AjtFDDp3ZwrV91dZ4JNhjtd2C3kzE/k5a11l11sCDjDmifM5RDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PzjStiCr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584I74iB012221;
	Fri, 5 Sep 2025 07:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aPzRXq4WWFq
	ngyqDggP2sYVbTan1SUs9uareu5W8qtc=; b=PzjStiCrfEgaC8eXXtt9IiODlUT
	9ZtkZnPXhPBLLSmuzeF2UdFz3ElOXDpiLkfeUViBnJ/TJ/RxeEN/6FrG1q04jOEj
	df+k7HsZ0iYOWhsySdRF0IuOZp8MYA5d2Hxz2Xbl7eNYdHkEaPXbW3TjH2W+re1S
	3QhYJOMNXk4YmcbPOCgxSP6jNL4/6G4JQ9efuJ0QAwlrNjkojXJUcDjadZFU4//O
	d55T3J6XwAqyhirkpbHZNCtHu9GfNypH4AGDw6YiSwbcAE11RxHHvfZj8aLF6dss
	PbV5Vy/K9JR7H2rN52ve+YRzaTVx+FNPGKkLJia3J94T2aQtoBsTT/qwHcg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj6kcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 07:14:58 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5857Et8A016435;
	Fri, 5 Sep 2025 07:14:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 48utcmrhs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 07:14:55 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5857Etmt016425;
	Fri, 5 Sep 2025 07:14:55 GMT
Received: from ziyuzhan-gv.ap.qualcomm.com (ziyuzhan-gv.qualcomm.com [10.64.66.102])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5857EspZ016421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 07:14:55 +0000
Received: by ziyuzhan-gv.ap.qualcomm.com (Postfix, from userid 4438065)
	id BB1C6528; Fri,  5 Sep 2025 15:14:53 +0800 (CST)
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
Subject: [PATCH v12 3/5] arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
Date: Fri,  5 Sep 2025 15:14:46 +0800
Message-ID: <20250905071448.2034594-4-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905071448.2034594-1-ziyue.zhang@oss.qualcomm.com>
References: <20250905071448.2034594-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX+eJo4m/VT4Ly
 W171NmOKnFvz1dmfGr7YjeXFGNBgq3Ka+G7CgPtpcd3LyWEGr3Na7Buq3Zd4R2Ar/wTtWHP9okv
 F2x8bISsSFyGW4dtnidrb9xwdaeI0F0/eox8ow1olkvOB4HlDQYBbqTofkn+x2+pjxJThT4D0R2
 kvzHRM4InLpAhZx+HduyqkHOZi1a5YHCjAZcHOemSXOYMSoCvEehHfU6+Aoo6ULfPYVISceLpOA
 EDttdQm2veCPEsQt+6WEl7gpVRnkg+jS69fTzl1UAPSeX9ntNsiUhiiuLSM6RWxj8ufTCyKasai
 psqsvnK8gOdzYBEwdB+49pttHv3cKmhKeabQqfKnT5gteImwvq2+ZBjj4rHFwv4xoNDmdL8tLJ9
 td+sccSh
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68ba8df2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3MwsbQfqrhYP0zGv_kcA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HI53pRXiaJk7VCXglpzgN4xe4E0zf0bu
X-Proofpoint-ORIG-GUID: HI53pRXiaJk7VCXglpzgN4xe4E0zf0bu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

Add configurations in devicetree for PCIe0, board related gpios,
PMIC regulators, etc for qcs8300-ride board.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index 8c166ead912c..bd7ec1cb2edc 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -308,6 +308,25 @@ &iris {
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
@@ -348,6 +367,29 @@ ethernet0_mdio: ethernet0-mdio-pins {
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


