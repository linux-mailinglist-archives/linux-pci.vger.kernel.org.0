Return-Path: <linux-pci+bounces-23914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F74A648A5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6CD3AEDFC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B818E2356B7;
	Mon, 17 Mar 2025 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X3N80IXd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A35234988;
	Mon, 17 Mar 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205691; cv=none; b=hLNFMnFNf4ftvnUPNWuGqw3JR1Ary9VzzmDzlSN2RIHB0sNiMIkYlQcq7ka/drUoA1cbdRCG1ehdgybgbaXLGdTAumHm+RmiA6loU9smjVp3jRqp6hJAg1f0q/xgANCEXROvrg0NqbVcADJmMnSMW/BP2x1EoS+ytUmejJeTpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205691; c=relaxed/simple;
	bh=IicT4PqA8XtmCqhPm4WNB3iP13gHpJYRpeIJ+fmInhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bfse36Rou9xleOOL/BwkkfyJolpcsa8r+YspboEHWmkXfhGex6PPqfblivAeznXrvIyWj1cOuVRN73kZJFKdWjswWdl59IEpLBtj27rMVFunvtlNW73vAIvqz1JUBUkrJV7WeYwrENmpjJIyulAkQSNaA/ZGdkRptYEnSFusIl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X3N80IXd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9mbBK000584;
	Mon, 17 Mar 2025 10:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CkxhfVO17pRZIBiRQha/KvW0QZ/J3GM1D7i5oqTpFYA=; b=X3N80IXdKFosBC1h
	X8olXZ+ZQMaxCoQIUYkXfKCQ1DmJzTlvcslmVXqsAKtW1veJ8O4tbgXIdkaKjsZk
	9Zx+0zaRLGmY6mQ03VNt0NTkv90ObZryzzUwKvh5WHXTJv6FSp2NVvtbUH1xoB/f
	Ilg9iO/PAV9n67pkzRWDXFBAn19OUl7uRBaY7Y9b5XpImXhkMRch+OzlolUyaZBQ
	5IQxu5nFaUDfmvZezDU0Z8PU8eDDQYcxlsN7jGSlPNIyIq603OIW+MbIBcvOOclA
	OwMigjQQMYBIjEMVhz35saON/w0Hh7tR9ylsSYr48aEEc6W2pH8BxI1Q/bRts7bd
	BsaWfw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2u9v68c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 10:01:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52HA1JD4007532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 10:01:19 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Mar 2025 03:01:15 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v14 2/4] arm64: dts: qcom: ipq9574: Add MHI to pcie nodes
Date: Mon, 17 Mar 2025 15:30:27 +0530
Message-ID: <20250317100029.881286-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317100029.881286-1-quic_varada@quicinc.com>
References: <20250317100029.881286-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=JsfxrN4C c=1 sm=1 tr=0 ts=67d7f2f0 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=ryuqPLVmPGJY7REw-AEA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: glhMwE0VG-2DCd4ELQISCIOukgZyT-nh
X-Proofpoint-ORIG-GUID: glhMwE0VG-2DCd4ELQISCIOukgZyT-nh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=765 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170072

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


