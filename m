Return-Path: <linux-pci+bounces-23484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7528A5D87C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 09:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7E03B4A33
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791623814D;
	Wed, 12 Mar 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ghrQbzsm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCF237705;
	Wed, 12 Mar 2025 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769056; cv=none; b=Uo7RybZ6sD/4Xc3XglpMBrQBcx0YChddfutZBgCIZHXQsA8WoEpqE//TJh9PXhrZzJgmipRXW+uGn7cfz8JZrkTvjmqwSESqHZSru9qtOiUmv6hypKE8z/2rvuY6w15AWNc1htcnOFWiE0xas2JMdTBARXOonhG9ftarzDCij5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769056; c=relaxed/simple;
	bh=pokr2ga+xAN9vqh02gAMtIotrsuEA2w49+E2/xDPxLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WI72vyns6dgGkkGaRaP08ICZWbE62hHJP9jeyguIsAPxTHG4utGJGUL4Wspru9xpqLjzUSRJTyM/mwfP0/P/LCWftbvEn5RL2yHfbZqgcxLA6m15mBysrBj7DL8QR7Bsg6AtK+fS0bHCSOMA7l6bI7qS9iB1XnMNJkDO+Fip9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ghrQbzsm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMH9qW023245;
	Wed, 12 Mar 2025 08:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EDuMQ7LYnkP271F4aNUECeQ+q+CTHt2uK1MmUiieRtQ=; b=ghrQbzsmksxmqfCg
	jjDfHwvmcQcKYhKLkUx5OpSFpdeKfEKOhwMX7vK/sKTJuxZkP6SsB+Kfh24fb73Z
	P0kqCJ2F5o342p72DeXOmsHoIWLkZySrTXizOFjKxNzl6vbuRLKADuzoXTnEY8lK
	BH/zj8zPwFH+GK9H9yO06VOVMc+1hSIr8hvhK0bm7JD8aKOUuX6f5rQElPjNN3qu
	Awjj7tOzgFwu70QdSp6ma8c/0IIpbSOJ5fUVNpUn8kBcq8OGWG9LOPrC7VMaDbhf
	U80HAFSyYOsG7EcicPJw+nBQYC6hUMwBruXYrKszkysMnZVs9lWmvpk1nrfOPbnI
	Qrhf0w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2mhq0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 08:43:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C8hxiw012386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 08:43:59 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 01:43:54 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <quic_srichara@quicinc.com>,
        <quic_devipriy@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v12 2/4] arm64: dts: qcom: ipq9574: Add MHI to pcie nodes
Date: Wed, 12 Mar 2025 14:13:28 +0530
Message-ID: <20250312084330.873994-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312084330.873994-1-quic_varada@quicinc.com>
References: <20250312084330.873994-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: EMRHXXQskSJ9Xq_IHDMJHaIhGzCMkIja
X-Authority-Analysis: v=2.4 cv=aKnwqa9m c=1 sm=1 tr=0 ts=67d1494f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=PA9gvwGdt4CPNWq3bz8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EMRHXXQskSJ9Xq_IHDMJHaIhGzCMkIja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=730 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120058

Append the MHI range to the pcie nodes. Convert reg-names to vertical
list.

Fixes: d80c7fbfa908 ("arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes")
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
New patch introduced in this patchset. MHI range was missed in the
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


