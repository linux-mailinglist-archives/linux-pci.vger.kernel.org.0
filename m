Return-Path: <linux-pci+bounces-28531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29319AC76C0
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 05:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088EB9E3382
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 03:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FBE2512F3;
	Thu, 29 May 2025 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cEEFcsIP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76538248889;
	Thu, 29 May 2025 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490875; cv=none; b=Ra3/c3aQdDoSyCbIexTKsoiJRzafIW4S0Au2i5S+JO7ewKm2ZCxGOjA9sg4cEjPT3RhgTwXRse67oFLDaIywuYJFYbpoq+cSm4YMTtlCFE3yAJaqgv4tQLgBm0ugx8NCftPchCDAI98+JeE8QuYzS1DjxUPZqCUAvJjZKFozgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490875; c=relaxed/simple;
	bh=kRU/0vMCzkPyZlSIiK5h24CLotjwfAQHj5a3dvpIn2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bswH74fbedWv15s7S64yS4Is7xw3aNfTX4aJyPjDWQtJXyzC/9FPq7OtTJYoXTL/RKO0EY1c5+12H6NpIidJAn4HSCCBGezRgorh0eWn2qc1asCnes6SIDEa1eHRa8ZWav/9ZkbVtRwi9HNcct47qVle/sQJBcOsY4ufhce8zps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cEEFcsIP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SHTlv0022432;
	Thu, 29 May 2025 03:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XySX9SNrCWx
	K8lNo6ML9EAJtagQJkKEPqFYL1BJxTWg=; b=cEEFcsIPtC/9QobD4Nc47b3Zx7k
	/C287gpjwRum5MDxiGrMKN6eTclfvOuV4vZ10NZebYWdfz57PppJvgV7UOeBwHv7
	V42DaG/c0/+ZLu7L8Ocaq1vDHa0lhEOZZqlIL/FPv5WeuR+6L59CmY+u7NZp9kvD
	9jgJ03iqMKDhGCK32LchiCjI4TAHPBSS+qkXp2hJPqU6KTsz0GSla4MnTDq1J/+R
	nZTejeT9TbZ64/bMwDPh+WOc7HaWS+W+hA/ZT6JEle+sh5vlrTPWUDPl4/o9kZMI
	72YxSm5q+BPi1fz8eEdLPNyQmbQ0Z9TjO2x/T6V/2XAzNm4qToTkk/VssCQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x6xc9aa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:54:23 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3sKph030088;
	Thu, 29 May 2025 03:54:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 46u76mdnms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:54:20 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54T3sK3L030075;
	Thu, 29 May 2025 03:54:20 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 54T3sJEl030071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:54:20 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 70F60315F; Thu, 29 May 2025 11:54:18 +0800 (CST)
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
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v1 4/4] arm64: dts: qcom: sa8775p: add link_down reset for pcie
Date: Thu, 29 May 2025 11:54:16 +0800
Message-Id: <20250529035416.4159963-5-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
References: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDAzMyBTYWx0ZWRfX/DlRSjHJvOD8
 5+2U48b8xNRlVMABTo86fpuyIoqR9FS/I0A7NBmf9jq7GfFxezDm99Ub+JdPOhM0VnfPH6Z3Deu
 juOnciil2xpeLAg5Tp1zgMCJCn5XFvIfL+C+/XF+fP2OZMv2Ak9KC9RN3Bs0h/QNFUjriYTDpWM
 q/oblN6sBLt5sXZFCtLA2tLjW6vMLp6CiXpPhhRQPQbTDXdzdqdcFL6Uc7oTWKvcDaA3g4/Tw9s
 +8uNmSxKbdNn5mutFQ1UPgrgjnVTOQcxRyyCM+MTx+fkpU4DcWs3i4Plvz6uVYaqhOuUJNHAJ2Q
 tNt4nP/ApqXItR/TMMifvluJQspAHu/Sg5H1oGrOoYlj93zwnFkUsvNbkbJvtTVR1IBP1HvgBpn
 gTfTce2klPRZ8KGAlyVohcV4MfcfmOO2v17qE7wQTrMs/SG9e2003VL57dCB6XRlxn9D+7H/
X-Proofpoint-GUID: Z6zgpv9yHtpmZln3URObZZ4kVQlwnlLl
X-Proofpoint-ORIG-GUID: Z6zgpv9yHtpmZln3URObZZ4kVQlwnlLl
X-Authority-Analysis: v=2.4 cv=bupMBFai c=1 sm=1 tr=0 ts=6837da6f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=UMluCPnEzjiUAf4N7sYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_01,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505290033

SA8775p supports 'link_down' reset on hardware, so add it for both pcie0
and pcie1, which can provide a better user experience.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index d7248014368b..c8ce3d42c894 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7152,8 +7152,11 @@ pcie0: pcie@1c00000 {
 		iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
 			    <0x100 &pcie_smmu 0x0001 0x1>;
 
-		resets = <&gcc GCC_PCIE_0_BCR>;
-		reset-names = "pci";
+		resets = <&gcc GCC_PCIE_0_BCR>,
+			 <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
+		reset-names = "pci",
+			      "link_down";
+
 		power-domains = <&gcc PCIE_0_GDSC>;
 
 		phys = <&pcie0_phy>;
@@ -7312,8 +7315,11 @@ pcie1: pcie@1c10000 {
 		iommu-map = <0x0 &pcie_smmu 0x0080 0x1>,
 			    <0x100 &pcie_smmu 0x0081 0x1>;
 
-		resets = <&gcc GCC_PCIE_1_BCR>;
-		reset-names = "pci";
+		resets = <&gcc GCC_PCIE_1_BCR>,
+			 <&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
+		reset-names = "pci",
+			      "link_down";
+
 		power-domains = <&gcc PCIE_1_GDSC>;
 
 		phys = <&pcie1_phy>;
-- 
2.34.1


