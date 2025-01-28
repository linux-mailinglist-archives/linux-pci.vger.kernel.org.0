Return-Path: <linux-pci+bounces-20432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D61A2045D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 07:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE831626A8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 06:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2018DF86;
	Tue, 28 Jan 2025 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kCJVQxsO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C61DF26E;
	Tue, 28 Jan 2025 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738045681; cv=none; b=ghpOL5gvFCysdFug6HcxL7gBzrmI4LcdMpCp/rrJbkTehdTbwxrC09D4cdv8U0E8X/MYcs5AO02YyuVpPX1G5NXygvJgePcmdVNK/jPew231QFTJq7seklXKPxVqjlrCXrMvYY3Cq8MNRIcd9fXP0VEUVPASZnJUjgrHRgd3xM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738045681; c=relaxed/simple;
	bh=PTtXveJGpKTPAOO5eFIO3l0XibHGUgbcLt8NefvZSyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUhb2TCcrkVxXbNUYXa7Jg6Q1XaiGPRP5g6CHME1hqcFhFpgWXKKTGzejYX8cwcedEUaipRb42ht2dAj6n0xuOFjRqDavDyu/EoD2DhDkuNQgqW0t+wsHq/zWAYMsJYdBthry1SJvVBRiNHPUeoKLNRtivKz/Upv8KiuzFy7Xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kCJVQxsO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S2Cend009658;
	Tue, 28 Jan 2025 06:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QXpJ7kICsLJNBbrzS/vhBa+nKtc/mprBYbiUOfy5GP8=; b=kCJVQxsOfDr7okzN
	VMG5ODtgweXWbVcpxqcoGBLioYBdLserO+Z/tz8tutnNMclbeWM4KFAQiyzYxoMH
	3kBru2uo1YSNgwJzy/GV7reUC+L5dcO7mYGe8x/Xpzi/Otpj/NYtPbtPfUkg9Qzz
	b/CMmBu1ELngpP6y686Wpe3rp0CSGZuXPUd9A7U/wNzj1Sl8yNPfwvR9+jVvRhTz
	k8Fwk6geeOR6pes3xWWOo72eEV9SCXHEADE4xmIugbCEM9KeQD2l7cBZd/RxPAHr
	NEGepOhUrtenIEFggyFcJgG/d4uM4f+OAY1voDi9ADUHGV3rOSBZsovOMitNz4E/
	EnDApw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44envv8dyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 06:27:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S6RovR003105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 06:27:50 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 22:27:44 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v9 4/7] arm64: dts: qcom: ipq9574: Reorder reg and reg-names
Date: Tue, 28 Jan 2025 11:57:05 +0530
Message-ID: <20250128062708.573662-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128062708.573662-1-quic_varada@quicinc.com>
References: <20250128062708.573662-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: -vHd8l_9CrHaBbPSxY5uWUsVeb12QSFh
X-Proofpoint-ORIG-GUID: -vHd8l_9CrHaBbPSxY5uWUsVeb12QSFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015
 mlxlogscore=700 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280048

The 'reg' & 'reg-names' constraints used in the bindings and dtsi
are different resulting in dt_bindings_check errors. Re-order
them to address following errors.

	arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pcie@20000000: reg-names:0: 'parf' was expected

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 52 +++++++++++++++++----------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 942290028972..d27c55c7f6e4 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -876,12 +876,16 @@ frame@b128000 {
 
 		pcie1: pcie@10000000 {
 			compatible = "qcom,pcie-ipq9574";
-			reg =  <0x10000000 0xf1d>,
-			       <0x10000f20 0xa8>,
-			       <0x10001000 0x1000>,
-			       <0x000f8000 0x4000>,
-			       <0x10100000 0x1000>;
-			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			reg = <0x000f8000 0x4000>,
+			      <0x10000000 0xf1d>,
+			      <0x10000f20 0xa8>,
+			      <0x10001000 0x1000>,
+			      <0x10100000 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;
@@ -956,12 +960,16 @@ pcie1: pcie@10000000 {
 
 		pcie3: pcie@18000000 {
 			compatible = "qcom,pcie-ipq9574";
-			reg =  <0x18000000 0xf1d>,
-			       <0x18000f20 0xa8>,
-			       <0x18001000 0x1000>,
-			       <0x000f0000 0x4000>,
-			       <0x18100000 0x1000>;
-			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			reg = <0x000f0000 0x4000>,
+			      <0x18000000 0xf1d>,
+			      <0x18000f20 0xa8>,
+			      <0x18001000 0x1000>,
+			      <0x18100000 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config";
 			device_type = "pci";
 			linux,pci-domain = <3>;
 			bus-range = <0x00 0xff>;
@@ -1036,12 +1044,16 @@ pcie3: pcie@18000000 {
 
 		pcie2: pcie@20000000 {
 			compatible = "qcom,pcie-ipq9574";
-			reg =  <0x20000000 0xf1d>,
+			reg =  <0x00088000 0x4000>,
+			       <0x20000000 0xf1d>,
 			       <0x20000f20 0xa8>,
 			       <0x20001000 0x1000>,
-			       <0x00088000 0x4000>,
 			       <0x20100000 0x1000>;
-			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config";
 			device_type = "pci";
 			linux,pci-domain = <2>;
 			bus-range = <0x00 0xff>;
@@ -1116,12 +1128,16 @@ pcie2: pcie@20000000 {
 
 		pcie0: pci@28000000 {
 			compatible = "qcom,pcie-ipq9574";
-			reg =  <0x28000000 0xf1d>,
+			reg =  <0x00080000 0x4000>,
+			       <0x28000000 0xf1d>,
 			       <0x28000f20 0xa8>,
 			       <0x28001000 0x1000>,
-			       <0x00080000 0x4000>,
 			       <0x28100000 0x1000>;
-			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
-- 
2.34.1


