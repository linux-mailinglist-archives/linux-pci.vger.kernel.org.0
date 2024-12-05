Return-Path: <linux-pci+bounces-17725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C79E4DCE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 07:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D833F281D97
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 06:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA3517C208;
	Thu,  5 Dec 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XgM5YRE0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD61AB500;
	Thu,  5 Dec 2024 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381690; cv=none; b=bo5CF9odtqLXbL0xoW5lBi6y6CgRAF2VDPLsdWhyrFvn4l53ScXkDSZ5YwgnqQDn860hZ/KRFVIGH1aYlqaTdJ/rT1JcVWQchzfsHPagKAoVXfBUMw4LhJeLu0/e7wbEht01J2trXPpDNnmwIH699W+qE0npwyVHIEe8CFvh1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381690; c=relaxed/simple;
	bh=4wghd9YoJ/xb0LRyAJKdCqAvpZ68Z0R/tn3iNAzvx9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RvvQjn+/THD46LfRksjyG9PxR3p8ZXhZGghTP33Klvw8tMCBRiRldObCqD7nJXW5eiOiiCpBqbd7JBXs32jzU/O4C7E4lZpZY66mmHGLqkOw49LqNhR+rBzzza/WdEpuJXg7skbTsub4EF17Wzgt/f2SS9VK6GFqFnL+Jm4tjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XgM5YRE0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4FwgMN010257;
	Thu, 5 Dec 2024 06:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lGN12M0zOab
	LVuNj7xrhZ4zwG8ycu9JuZ6lFtNbqFdk=; b=XgM5YRE0y+oHDHVZRJP59LcUVJK
	MJrqopZMJvjlzmGO1FC2URLMZyyaCSh2BeVkE39slrzxFd+taxMwxshJcWv08hc1
	k1LGcsZeRAoeu/eDcekm39xzc78Wd9c7dR7fTlWBqC4lxdns9iIi27SnrcTblTnD
	hU3+MfpwQHQbXBXk4/Jv4GTDI+JcxAsfjF6u4miO20PYGS7PgefLLsmyjuzSyOXR
	COZ43S+eLZ0HcRedVBgRvKWFXlPngwlfuC44z5CFdTIbsTrg33ibjRaMsAfAcikX
	ODvaoEP/uymzDca5m63a+naq5HiGInIWpFlpgNWiPAy9akaE0WyecQHMzbQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439v7yxrqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:54:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B56sVR1023226;
	Thu, 5 Dec 2024 06:54:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 437usmedse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:54:31 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B56sUjP023186;
	Thu, 5 Dec 2024 06:54:30 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.249])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4B56sUiD022956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:54:30 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3891782)
	id A4D81213F4; Thu,  5 Dec 2024 12:24:28 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Slark Xiao <slark_xiao@163.com>,
        Qiang Yu <quic_qianyu@quicinc.com>, Mank Wang <mank.wang@netprisma.us>,
        Fabio Porcedda <fabio.porcedda@gmail.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v1 1/2] bus: mhi: host: pci_generic: Add supoprt for SA8775P target
Date: Thu,  5 Dec 2024 12:24:19 +0530
Message-Id: <20241205065422.2515086-2-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205065422.2515086-1-quic_msarkar@quicinc.com>
References: <20241205065422.2515086-1-quic_msarkar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8nz-9oPsdrBhFU7lNLEORKNSdeMurHFj
X-Proofpoint-GUID: 8nz-9oPsdrBhFU7lNLEORKNSdeMurHFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050051

Add generic info for SA8775P target. SA8775P supports IP_SW
usecase only. Hence use separate configuration to enable IP_SW
channel.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/bus/mhi/host/pci_generic.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 56ba4192c89c..b62a05e854e9 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -245,6 +245,19 @@ struct mhi_pci_dev_info {
 		.channel = ch_num,		\
 	}
 
+static const struct mhi_channel_config modem_qcom_v2_mhi_channels[] = {
+	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 2048, 1),
+	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 2048, 2),
+};
+
+static struct mhi_event_config modem_qcom_v2_mhi_events[] = {
+	/* first ring is control+data ring */
+	MHI_EVENT_CONFIG_CTRL(0, 64),
+	/* Software channels dedicated event ring */
+	MHI_EVENT_CONFIG_SW_DATA(1, 64),
+	MHI_EVENT_CONFIG_SW_DATA(2, 64),
+};
+
 static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
 	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
 	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
@@ -275,6 +288,15 @@ static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
 	MHI_EVENT_CONFIG_HW_DATA(5, 2048, 101)
 };
 
+static const struct mhi_controller_config modem_qcom_v3_mhiv_config = {
+	.max_channels = 128,
+	.timeout_ms = 8000,
+	.num_channels = ARRAY_SIZE(modem_qcom_v2_mhi_channels),
+	.ch_cfg = modem_qcom_v2_mhi_channels,
+	.num_events = ARRAY_SIZE(modem_qcom_v2_mhi_events),
+	.event_cfg = modem_qcom_v2_mhi_events,
+};
+
 static const struct mhi_controller_config modem_qcom_v2_mhiv_config = {
 	.max_channels = 128,
 	.timeout_ms = 8000,
@@ -294,6 +316,16 @@ static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
 	.event_cfg = modem_qcom_v1_mhi_events,
 };
 
+static const struct mhi_pci_dev_info mhi_qcom_sa8775p_info = {
+	.name = "qcom-sa8775p",
+	.edl_trigger = false,
+	.config = &modem_qcom_v3_mhiv_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
 static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
 	.name = "qcom-sdx75m",
 	.fw = "qcom/sdx75m/xbl.elf",
@@ -720,6 +752,8 @@ static const struct mhi_pci_dev_info mhi_netprisma_fcun69_info = {
 
 /* Keep the list sorted based on the PID. New VID should be added as the last entry */
 static const struct pci_device_id mhi_pci_id_table[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0116),
+		.driver_data = (kernel_ulong_t) &mhi_qcom_sa8775p_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_QCOM, 0x010c),
-- 
2.25.1


