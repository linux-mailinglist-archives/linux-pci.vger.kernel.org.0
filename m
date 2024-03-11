Return-Path: <linux-pci+bounces-4724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E887815D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 15:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9921C2152F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8163FE3D;
	Mon, 11 Mar 2024 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c2tBhDa2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C13FB8A;
	Mon, 11 Mar 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166320; cv=none; b=D022+Kc66uHs/ShRtFrtL+mE0pxe7dZUzWUzJebpXIQVkzvOIzeatugr14kgFUW6Y5aW21kP/q0iLhwEdYvGKFTm/KA1Eo4GE1GfLUmWBre3lBvfwO9SjEF/Z5iw6AJQgZSuC1eFCcNNiv5qsne770c2IcLLxGUSYV2v++Ax7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166320; c=relaxed/simple;
	bh=mATANnERqHl0xxPKG/pi5i3RkGtcnlov/hfS9jJME1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ju8ThMJRam21NVEvRirh8kx6bz5NYgBN/lZbs9WgaIwQqn9p6317/gtaz8Q/tFDtrwbmJ/JSMp4LGWwkThSudL39zKqEUek3PasqPlKz4y85mkN7yZgNYa23dye9om+jM/tKxgySWUHY9amxbfQAzZMTCLPx9U7+7NqZPQst25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c2tBhDa2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B8KZnL017161;
	Mon, 11 Mar 2024 14:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=Lgjyjuyxaz0nE//QtnXUM9Z5+GFKEPP4syXHT7IjMu8=; b=c2
	tBhDa2LqdGI5/ymHsEgctaMB4BcU6uTP9RcF+Ks3xMeWhCpzVFHsTBk07vfOXIoH
	efOgiMM64U/RhgkQxeQoB5mlgAK+CiLKlEoAgzqjzupFjMs5ThrUA1OrCoK8uglP
	qNNQXA1J3lkXg1k5uj2AWi/xR0ZkmOwB5u6dcVEwqiH2U53J/Kk4GGS14/ZbjoGn
	1kJryrp6pe6/9tSJA60Q3+r+y00+GhXpb4o6c5e+qii1lNw6SRunB5I3CfODS4G3
	tLZCndmJkxB7BU/iKzY+l2YIUY7AJDYNpKkQ1pAaIL8CcBonDMQv0NrzBZb1xLe7
	PXWgsytOckEGD0HNfGDA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsxbvgy5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 14:11:50 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42BEBlp0009690;
	Mon, 11 Mar 2024 14:11:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wrguks1wd-1;
	Mon, 11 Mar 2024 14:11:47 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BEBlsw009684;
	Mon, 11 Mar 2024 14:11:47 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 42BEBkYT009683;
	Mon, 11 Mar 2024 14:11:47 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 93D5B3A4E; Mon, 11 Mar 2024 19:41:45 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 3/3] arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent
Date: Mon, 11 Mar 2024 19:41:37 +0530
Message-Id: <1710166298-27144-4-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710166298-27144-1-git-send-email-quic_msarkar@quicinc.com>
References: <1710166298-27144-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IfBSMDYy-3LcUer61qGiJ0atTe8XqQbX
X-Proofpoint-GUID: IfBSMDYy-3LcUer61qGiJ0atTe8XqQbX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110106
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The PCIe EP controller on SA8775P supports cache coherency, hence add
the "dma-coherent" property to mark it as such.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index d9802027..53c31c7 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -3713,6 +3713,7 @@
 				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
 		interconnect-names = "pcie-mem", "cpu-pcie";
 
+		dma-coherent;
 		iommus = <&pcie_smmu 0x0000 0x7f>;
 		resets = <&gcc GCC_PCIE_0_BCR>;
 		reset-names = "core";
-- 
2.7.4


