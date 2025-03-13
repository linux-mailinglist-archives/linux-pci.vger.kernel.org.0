Return-Path: <linux-pci+bounces-23585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 169DEA5ED91
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 09:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AAA17B071
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 08:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10D25F992;
	Thu, 13 Mar 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eOoPOVV3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059D41C6A;
	Thu, 13 Mar 2025 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853198; cv=none; b=u+5BxDLzlmKrQZNJ7/5u7rYxE+vgbuC4ckVBHtD/6wg/5ka/LF0PvrgOVNVHRmBZ6EiyArtIJmbqSutI3n7+Muxr9cunAFDiRES5Lkhn+RGSLYbF0wFeXxFv97Qe0eWJ44oA9gH1ID+r/RLo5Obxqbdh2ZFe+AB/0gXbxRbOjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853198; c=relaxed/simple;
	bh=IicT4PqA8XtmCqhPm4WNB3iP13gHpJYRpeIJ+fmInhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nouN+yiYwu3cUzgIk7NtG/xFsBbMen7UrEZM6AnwTWrYyYLq8N/qMfR5JkctX+CHsPeXrl4ht6/APRtUiGriP9G+sFYaE+JMLgrR/VU+6bK16NqfjYIstU0iHjPC4dMDE6r4BL0pc/36KJ63acENSzFOe4SAMOBcWTf70UnVTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eOoPOVV3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D7C4T1019128;
	Thu, 13 Mar 2025 08:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CkxhfVO17pRZIBiRQha/KvW0QZ/J3GM1D7i5oqTpFYA=; b=eOoPOVV3nyjlL6Mo
	9t13VuJYL1qIbfea7gCRogMps4LqNotjUwRnZWF5P7y8zV61iS+ngKdSG2T7/y9v
	90fqoUSfGuZm3ScDIgHb6wAqJeLa3kklxpxkDojuRverFNAtfwgZNACaq2b6oYH2
	wNoWjX6ixhiLuJ7kJlYeu8idjJS9pwgdKOe3iDE6pncgSC8ESMpigBa7g9iqhzYG
	7aJ1y2QDqVVfaFWEBtbsRbiZIkPc/79OnX/v3ZP/l/uoHOTH1wVfet111vSmp2MZ
	Mzr+hIw+i6AjvjByw1ZWHEIoXIUzAFrqcFwbwQUWOfBo4KXnbWPFH78ToJYUJieZ
	2DwWTw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bts0g4ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 08:06:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D86PxF012226
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 08:06:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 01:06:21 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v13 2/4] arm64: dts: qcom: ipq9574: Add MHI to pcie nodes
Date: Thu, 13 Mar 2025 13:35:58 +0530
Message-ID: <20250313080600.1719505-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313080600.1719505-1-quic_varada@quicinc.com>
References: <20250313080600.1719505-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ISqf9wJCxxEapVLhhjHIsN5sj_hFkkBE
X-Authority-Analysis: v=2.4 cv=DNSP4zNb c=1 sm=1 tr=0 ts=67d29202 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=ryuqPLVmPGJY7REw-AEA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ISqf9wJCxxEapVLhhjHIsN5sj_hFkkBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=765
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130063

Append the MHI range to the pcie nodes. Append the MHI register range to
IPQ9574. This is an optional range used by the dwc controller driver to
print debug stats via the debugfs file 'link_transition_count'.

Convert reg-names to vertical list.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v13: Update commit msg
     Remove 'fixes'

v12: New patch introduced in this patchset. MHI range was missed in the
     initial post
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 40 +++++++++++++++++++++------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index cac58352182e..c27b3a90bd96 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -880,8 +880,14 @@ pcie1: pcie@10000000 {
 			      <0x10000f20 0xa8>,
 			      <0x10001000 0x1000>,
 			      <0x000f8000 0x4000>,
-			      <0x10100000 0x1000>;
-			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			      <0x10100000 0x1000>,
+			      <0x000fe000 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config",
+				    "mhi";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;
@@ -960,8 +966,14 @@ pcie3: pcie@18000000 {
 			      <0x18000f20 0xa8>,
 			      <0x18001000 0x1000>,
 			      <0x000f0000 0x4000>,
-			      <0x18100000 0x1000>;
-			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			      <0x18100000 0x1000>,
+			      <0x000f6000 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config",
+				    "mhi";
 			device_type = "pci";
 			linux,pci-domain = <3>;
 			bus-range = <0x00 0xff>;
@@ -1040,8 +1052,14 @@ pcie2: pcie@20000000 {
 			      <0x20000f20 0xa8>,
 			      <0x20001000 0x1000>,
 			      <0x00088000 0x4000>,
-			      <0x20100000 0x1000>;
-			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			      <0x20100000 0x1000>,
+			      <0x0008e000 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config",
+				    "mhi";
 			device_type = "pci";
 			linux,pci-domain = <2>;
 			bus-range = <0x00 0xff>;
@@ -1120,8 +1138,14 @@ pcie0: pci@28000000 {
 			      <0x28000f20 0xa8>,
 			      <0x28001000 0x1000>,
 			      <0x00080000 0x4000>,
-			      <0x28100000 0x1000>;
-			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			      <0x28100000 0x1000>,
+			      <0x00086000 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
+				    "config",
+				    "mhi";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
-- 
2.34.1


