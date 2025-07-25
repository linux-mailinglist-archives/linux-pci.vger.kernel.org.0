Return-Path: <linux-pci+bounces-32940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C5CB11CB8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FE73A5591
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA7C2E7177;
	Fri, 25 Jul 2025 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFOoDgau"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8A2E5B2B;
	Fri, 25 Jul 2025 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440059; cv=none; b=hjxbOE6LL2rN1aa+ALSGgkiUAI+ndtW6SQ4Se9nNJRnGq2AXhdgqrYoO+OM9ZlIdIXJ/296B+XjxLb3XBSiRi+qt6Gl6YTiP6/Qp4BlAylLUGgMeB2OeOHgT00N5fqSGurAMtmtEF9/Y3+40wgwSvUQormdfGKYr02DzE83/O/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440059; c=relaxed/simple;
	bh=Q8gV1Zi2ifbHbcA/5WD3lb3kk+S6uTYkwDneZydDWok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFVjeCAiKvL+urnmMQEu11vdliEinOG/BFNCdqavv8DCedydUBa8LJdNVAY9GsY69FszcT7YKUbYZGj1Vr9e7Z1h3fb5Anz3NhJ6hOfmMnztr/8cn7WQyl+ClcTy6ObdKA1r/UTWArnsyyx2SkS66YEm4jaNHTr9vZ8uJj8LsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFOoDgau; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P88nX9008715;
	Fri, 25 Jul 2025 10:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TTUDTxyQV+O
	ftN9SN4jSVdTMKwIVqPobiArGHZdB6yI=; b=SFOoDgauD/RENsu1b5MfTA6k9wA
	jG5t5DgwtXitMfDRUZik670NkVKGNlH38sv3RxmKcsmMyhtfyEtFWC1BIgBHzop1
	zECIpMGEj3j22AH80eLB0CbSKnDou0mTvhIYtbbmzyOFf5YYofoNPMJMHK9SUMtp
	Ucvukx1Qt0F1751GAQbzxno3oSuiOtUm46e+Z2Su9PF51AQJmhcpI6xUqfDlRsFX
	bKK3L3JOZBfG7QQXOblhaUBO8XAfxcRe5R8Ssv104ZXa/JMaeJp25CbOxBRS3P7I
	1n34EckVCNoCjdj85s/IwJDyhI+dP9P/VumnpjmJy5WDb0sjMOKZ7FZ+Spg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4846590dsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:40:46 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAeiWI017187;
	Fri, 25 Jul 2025 10:40:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4804emtguc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:40:44 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56PAei33017179;
	Fri, 25 Jul 2025 10:40:44 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56PAehDc017173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:40:44 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 4E7532184A; Fri, 25 Jul 2025 18:40:41 +0800 (CST)
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v9 5/5] arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
Date: Fri, 25 Jul 2025 18:40:37 +0800
Message-Id: <20250725104037.4054070-6-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com>
References: <20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ZLxuZk5cYPTkCihpyRkwyObL2USA87RG
X-Proofpoint-GUID: ZLxuZk5cYPTkCihpyRkwyObL2USA87RG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA5MCBTYWx0ZWRfX8ruY9P3Lgt++
 G2NQNmh+S2qehgJTXRz2EdDUrP0ORyzLZqOxH4NsG0E+Y96N333+SkuNTvd+c5SOEtP1pXrcTm0
 fMmJz3Q9gKdKQ/QFF2rlz8iXUoO54gTrgKd2lGE+sj6A+FT4IvQIIXh7pKK5VU7gWA0PeNWWSdv
 ncKVfW/PzbowzyGC7mP+9uXAQj8MhRqENmib41PgUYDe/IbKIgK5g+61xqLkXlWCjhjhl1cpMa4
 ydqspC2YU5IbpRQXs6A0MeA5yD0XONdR2GqV+RUg6QVj+HBl0b/24W0Q+qynhjASw0ncVMgHCoi
 3CVvJgXz7br0Ff9X3HP/rO1fcWQqJICKn9PD7Fm0mXc4W1OY++vEq3Zs6IeBvYWrbjoiZOEvlKR
 vkKEOKJRmRQYzKe+QxPxDX3mDh4zUUKK3kE3AudWS8pICZYrjcBklSdkBjoEb4I9QW5cHD3S
X-Authority-Analysis: v=2.4 cv=Vo8jA/2n c=1 sm=1 tr=0 ts=68835f2e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=0LYZJ8Fh9g_wO_RM1qMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250090

Add configurations in devicetree for PCIe1, board related gpios,
PMIC regulators, etc for qcs8300-ride platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index e8e382db2b99..bec2905c5d8f 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -325,6 +325,23 @@ &pcie0_phy {
 	status = "okay";
 };
 
+&pcie1 {
+	perst-gpios = <&tlmm 23 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l6a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -388,6 +405,29 @@ perst-pins {
 			bias-pull-down;
 		};
 	};
+
+   pcie1_default_state: pcie1-default-state {
+		wake-pins {
+			pins = "gpio21";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		clkreq-pins {
+			pins = "gpio22";
+			function = "pcie1_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio23";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
 };
 
 &uart7 {
-- 
2.34.1


