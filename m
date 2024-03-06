Return-Path: <linux-pci+bounces-4577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50486873770
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 14:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AFF1F26830
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6E3131E3C;
	Wed,  6 Mar 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oFPhXD72"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8113174A;
	Wed,  6 Mar 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730693; cv=none; b=uPcdJFrcS88sa1/Z75cdU0GRaiSMoTlkihbu/v/c9y8oIjgG/B5XsN1aLizwvCLm+g/56b8gKLCl6QRrPK2CEi05DdcOKQHE2FZXI5dLOFN01SdBwwTE+iWJSYCd3xdaMeNk4gW+zxzRMrSc/4zQL/gocdr4qFnLdabzuqJLVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730693; c=relaxed/simple;
	bh=fSqn3Zbgadl02jfzTwI8nibflBV6IWMiictSJSckEj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Mi/HF8uOvHq92zyXwKaPGyRz42smWMmuwPKZR4SJclqRuANbk/40S1+NePSkuT/4WBy4lnybEBYo3s4AZ/Q6fFiY4LkgZ3aVn28nucgg7BY09g/ijRZXsDnUA2ILbVxdNMMNiz4OUd49mqOwBHlkX3r9sudqaBUMzRJYoc6MIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oFPhXD72; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426CDPr1011302;
	Wed, 6 Mar 2024 13:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=qEYDXRFpLK5+POddrnkz67UY0S8hVFcQkA/yuqMVZxI=; b=oF
	PhXD72eGeEFflD7bRFzdDt1PYHtx3nMONs7WpmAyY5KI71QxtCtwUt5E0ncWgEBq
	UxCW+BFn2XY2UwOBRgWwHZhBl71RgT2XoGUAA3e4Jgu7IBGmawime1FVe4RG+ZtK
	4EMZaib6EFnDLueNOpqEDejonBrC9umRxJ5SyupTnIpLYaHuua/5Vs32Xln4dn9R
	KNwBxaPs4zayKqPKdAe1YGCHUCmAvBY9y3eyDDysJU0j0LKJOQwAYkRi0sK3IXPQ
	yIBiBEHuVQpB8IS004UoyFbsc3S2cDRVD8hspH5ASyLVQFBA8wwI61yrAjo7L8/7
	rzSsEjaxvGt5qJSEzoSQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpbav1pvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 13:11:24 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 426DBIrt019094;
	Wed, 6 Mar 2024 13:11:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wp0608qm3-1;
	Wed, 06 Mar 2024 13:11:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426DBLQE019123;
	Wed, 6 Mar 2024 13:11:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 426DBLi8019116;
	Wed, 06 Mar 2024 13:11:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 0F9583A6E; Wed,  6 Mar 2024 18:41:20 +0530 (+0530)
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
Subject: [PATCH v6 3/3] arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent
Date: Wed,  6 Mar 2024 18:41:12 +0530
Message-Id: <1709730673-6699-4-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
References: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fCMkkEUdJvlisMZJIKbAVBiNsaTMEuPq
X-Proofpoint-ORIG-GUID: fCMkkEUdJvlisMZJIKbAVBiNsaTMEuPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060105
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The PCIe EP controller on SA8775P supports cache coherency, hence add
the "dma-coherent" property to mark it as such.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


