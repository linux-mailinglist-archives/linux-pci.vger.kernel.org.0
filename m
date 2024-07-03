Return-Path: <linux-pci+bounces-9646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EF892500D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 05:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD32FB2244D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 03:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ABA1863F;
	Wed,  3 Jul 2024 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PAPFf3dc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631917BCA;
	Wed,  3 Jul 2024 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978874; cv=none; b=u4cPQKpPr/dSrWAUyxRGK6JrWN5b+QVfalll75mDIkYrLfPHuioPEUD5pshc1OuNu1LmWflg55BdB8VTQA8nJHYzHvsQnpYUYbXLqsR5Cc1yEuzYDX8nh0rZ9cQoRbn5ufhP2QF691iZb7wnr48epQeptM65Kd/ZEJVxRv0n8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978874; c=relaxed/simple;
	bh=MbMfcv/Kme+Uy+MUOIzJU1RMEUag/E9vrAnvKtlsSoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgec8JVp8eN3heiREPMAvlqA14QvaQWDhLLn24j1cX817Vs79FWZ4ubGKv99zXRXUI8lPSfUWQZictKq6utP/M4T7RAJiCzbKjHBVNsbCfjIGx9OTyCPDkO/PUHVY/1OVop6q8LRc6K+x2P/b7Iu8ACKLGAs0Mwg/C3GA4zRk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PAPFf3dc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HE8xl013622;
	Wed, 3 Jul 2024 03:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYAfpUlFjbaa4SA/HYukb2Go5nF9etYjbNG9JEuBfxc=; b=PAPFf3dche9B457+
	h/mwFiCOKH+Z2LIN8Zrs39qSbk/TvDRcL1hYcgHTzY66AZx3r7FmTlVbahLt/YcF
	lRx3/Xjj7LHQiewcolyiXxC3c8E/6LklGGLBZdSh4lK1f0mN5P02cAXp0ks0+S6R
	0SBegO51uCeJMbB++ucKnzPgtu7fpiT543A7YeyoNrsqt+qvBp0R1goGF72JQowq
	2P+0TjLUsGXTOUMmcsnM4gxr9uZMXtUv39xzs0mZhcYtK9gsZYfQWHvEHA3OyNDe
	YIauPwrIGMzYUHMdHtVJGx7bNK3+Fmx5a0jKJ5TyDwUnVhCR73BL3FRMAzOgLdSi
	+RPXKA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402996qmu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 03:53:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4633rr72000404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 03:53:53 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 20:53:31 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <djakov@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <manivannan.sadhasivam@linaro.org>,
        <will@kernel.org>, <joro@8bytes.org>, <conor@kernel.org>,
        <tglx@linutronix.de>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <linus.walleij@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <vkoul@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>
CC: <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <bartosz.golaszewski@linaro.org>, <kishon@kernel.org>,
        <quic_wcheng@quicinc.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>, <agross@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_tdas@quicinc.com>,
        <robin.murphy@arm.com>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
        <quic_rjendra@quicinc.com>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <otto.pflueger@abscue.de>,
        <quic_rohiagar@quicinc.com>, <luca@z3ntu.xyz>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <bhupesh.sharma@linaro.org>, <alexandre.torgue@foss.st.com>,
        <peppe.cavallaro@st.com>, <joabreu@synopsys.com>,
        <netdev@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <ahalaney@redhat.com>,
        <krzysztof.kozlowski@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <dmitry.baryshkov@linaro.org>, <quic_cang@quicinc.com>,
        <danila@jiaxyga.com>, <quic_nitirawa@quicinc.com>,
        <mantas@8devices.com>, <athierry@redhat.com>,
        <quic_kbajaj@quicinc.com>, <quic_bjorande@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_tsoni@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-riscv@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 33/47] interconnect: qcom: add driver support for qcs9100
Date: Wed, 3 Jul 2024 11:51:40 +0800
Message-ID: <20240703035154.2182083-4-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703035154.2182083-1-quic_tengfan@quicinc.com>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703035154.2182083-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b9eapyte5SoA35dHcRtq_aF1w8ar7-vJ
X-Proofpoint-ORIG-GUID: b9eapyte5SoA35dHcRtq_aF1w8ar7-vJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_18,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030027

Introduce QCS9100-specific interconnect driver support.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 drivers/interconnect/qcom/sa8775p.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index a729775c2aa4..72eb94a8873d 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -2499,6 +2499,20 @@ static const struct qcom_icc_desc sa8775p_system_noc = {
 };
 
 static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,qcs9100-aggre1-noc", .data = &sa8775p_aggre1_noc, },
+	{ .compatible = "qcom,qcs9100-aggre2-noc", .data = &sa8775p_aggre2_noc, },
+	{ .compatible = "qcom,qcs9100-clk-virt", .data = &sa8775p_clk_virt, },
+	{ .compatible = "qcom,qcs9100-config-noc", .data = &sa8775p_config_noc, },
+	{ .compatible = "qcom,qcs9100-dc-noc", .data = &sa8775p_dc_noc, },
+	{ .compatible = "qcom,qcs9100-gem-noc", .data = &sa8775p_gem_noc, },
+	{ .compatible = "qcom,qcs9100-gpdsp-anoc", .data = &sa8775p_gpdsp_anoc, },
+	{ .compatible = "qcom,qcs9100-lpass-ag-noc", .data = &sa8775p_lpass_ag_noc, },
+	{ .compatible = "qcom,qcs9100-mc-virt", .data = &sa8775p_mc_virt, },
+	{ .compatible = "qcom,qcs9100-mmss-noc", .data = &sa8775p_mmss_noc, },
+	{ .compatible = "qcom,qcs9100-nspa-noc", .data = &sa8775p_nspa_noc, },
+	{ .compatible = "qcom,qcs9100-nspb-noc", .data = &sa8775p_nspb_noc, },
+	{ .compatible = "qcom,qcs9100-pcie-anoc", .data = &sa8775p_pcie_anoc, },
+	{ .compatible = "qcom,qcs9100-system-noc", .data = &sa8775p_system_noc, },
 	{ .compatible = "qcom,sa8775p-aggre1-noc", .data = &sa8775p_aggre1_noc, },
 	{ .compatible = "qcom,sa8775p-aggre2-noc", .data = &sa8775p_aggre2_noc, },
 	{ .compatible = "qcom,sa8775p-clk-virt", .data = &sa8775p_clk_virt, },
-- 
2.25.1


