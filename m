Return-Path: <linux-pci+bounces-20224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC26A18C26
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 07:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E376168F86
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 06:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98611B87F1;
	Wed, 22 Jan 2025 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MdtjbIi+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13D13213E;
	Wed, 22 Jan 2025 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527709; cv=none; b=YwP0hp3bP/0g2iXV9yvURxcIxgazDeQCjYdGspIz6OlEfgMMjcrJtirLlfvI+rQPrdsBa7oG78yos6FmX76c6I1hoHxh8PvyPSPK4vqC0qAnJKVLdDayKxh8xF2fWQjM8Jf80WbVXBkp7lfuyQLElsKvOg8AXEStaffOz41KkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527709; c=relaxed/simple;
	bh=PTtXveJGpKTPAOO5eFIO3l0XibHGUgbcLt8NefvZSyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB7PQD9qfeDskbeFPRAV6NHisYu8p/73y1h0zK4CwdGLtEEiCtTunH3c0FH0zwwX1lmF0txmHfxrhV4kVVq+GjDtJddf0AJjOlU9BrNbE8LhCLyqbmHQfD2I4itziP+rOG9ddfb+B+4S0Wm1AtbJeVekRcfFncgOdBowiq0ApiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MdtjbIi+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M3Rmq1024415;
	Wed, 22 Jan 2025 06:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QXpJ7kICsLJNBbrzS/vhBa+nKtc/mprBYbiUOfy5GP8=; b=MdtjbIi+U0mVZfGw
	sFFVqARuHrWDyg6mIjONB6ygT4H5FcC5mUwMmOR2M/6YlCy+zk0md42YdY/yRp3P
	4ZjtLcoA8DNk5DRyB6B0Lnaw1wu9ZOnSVYRSOXliQV8cA47vMqFx65x6jT2dhhJs
	a77hSVLZZHDHn5D8RtX14Ieho4pDNWoTdiVa8eVd9E8mZpYqkKj6LC9yiYNisqUo
	X3FnnlU0ZiITWrNkmn/SnFusndaQGCJ5ZETWHZL2iJj5CDfdIYcFgyzEc20/fttF
	vA0E1jGEct3eC7LrMsEYCP2HsNSEPmHidR7kCRdl8yxb3EqPr4PUZt1KlnZHshCM
	GKoc6Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44arssgc3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 06:34:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50M6Ys3H008026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 06:34:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 Jan 2025 22:34:48 -0800
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
Subject: [PATCH v7 4/7] arm64: dts: qcom: ipq9574: Reorder reg and reg-names
Date: Wed, 22 Jan 2025 12:04:08 +0530
Message-ID: <20250122063411.3503097-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122063411.3503097-1-quic_varada@quicinc.com>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 17-MdAehVy5uFvkFJ_fjk8sSWzJU5emX
X-Proofpoint-ORIG-GUID: 17-MdAehVy5uFvkFJ_fjk8sSWzJU5emX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_02,2025-01-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=699 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220046

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


