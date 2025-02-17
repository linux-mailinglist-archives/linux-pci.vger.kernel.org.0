Return-Path: <linux-pci+bounces-21585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD26A37B9A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 07:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C313AFD00
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 06:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E91ACEC8;
	Mon, 17 Feb 2025 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X6lW/RTl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA321ABEC1
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774106; cv=none; b=rgNRmRx4RTlyepn2pEszgMnsf3ysi0uO0GqBZJ99vSG/QrwsTinV4W44MnEBiOIIq7Re7BddIG8mJwafpFYOrv24Nb53DiJ1126rHkIZUTAq3csaXL2CcM9YwJdMPhn470uo75jD2e+T87jpRWFXcuSheytQguVtq/OZX8Czq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774106; c=relaxed/simple;
	bh=RBJ8SVlEdgIi33jmgw1hem9IHbgCNgZQ5wzw7AEiy5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XhAJCHZa51SugIHvK0fb3wyFLOgW15uNHLGjrWlCp61IQ2LV1mTNOdoWWCzWzd4a7GxBew5K0hmWs391prDI4kkppdcbCSm4NhynVjmfckAUpwy4eGimkui3Ug7dDOOp5tlI4jdW6pI8LzpSov2fzrTfgjMm8PdROVQzgb/TMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X6lW/RTl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H03EaW032090
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7UDfNKFG393gXzpXTFQgYOudK9v3C70LFzGo8/QFzEw=; b=X6lW/RTlx2B4mUbJ
	uyievDNAqxoSk16rOKKN3tfTS1jtAA1M86yfRcxjS+cKlCs5dL38lO7em5vnOxMK
	H0Mwkk15WZUQupLdfsM9wDvYh7KVUZ6JpDMpEbaf92GHRwtnpHFQ9a8+EkrT2dwu
	HVH7G1R93EzIj48YhL/RTrtFyJBGR9pZ8n/JdfoZ0L8g1xhZPi2QSPqmQ3c2HxmP
	wTgM3ruL2HVT4zLS2EN5+c0Ts0kj/xkezaWIvYLckN4so39dVtAjoAXghjdLvSUw
	+JvH84+iIKhyTaSLTtZYCeVWyexJ6hl5ErLIJe25g9VlHe61AijS1sdrsSJg2Wzx
	P/urvw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7wrq1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:35:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso13410105a91.1
        for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 22:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739774102; x=1740378902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UDfNKFG393gXzpXTFQgYOudK9v3C70LFzGo8/QFzEw=;
        b=lHDDgRDBYwcgP+a7e9J6HltaqmHYmaZx3wxfmqFTjqDJOR8tEGwVpIF991+PnqMv67
         aYQnkLV2LO7lanbKxLw828mpnQcfBrHBH0H8gylSoSRkXrTPLGHR1xFPRzfmuD67KpKN
         q7Yy2RrDmeF8KG1z4PwQ935zFKegd8bW8yX+d1pwZtWHBJnTx7KFoGJR/gLfY3dylDOO
         HF4QUh/TDmLYMaBBA6ktDxwHkSOe3HWiCGjjl9O0+L53ERLxdDx0rmpDJxTo5o8Me7xu
         4HAHCy/417DOI/HzLRilmbJkVqHcQgjAcOvHBCmMv0KmGPxAXDnwhaCOeMjF6u/12fKK
         GBrg==
X-Gm-Message-State: AOJu0YzZ7f9Gn1f4juXfwp2z7I8fjJKlzDITcv7uPPOABQ5BU61lHIiu
	Uu+Unl/Ow1lU9FxqPayDe2bT5TF8pcKryq0hKK+YVtIlf7rkyht0hxMVTcLfvyogPQUfq968NmQ
	2PzTX3PQMiRuvl7H2gik10T736SpubShK4Tbqekdxo1RZK1i4SA2LsV+yhCs=
X-Gm-Gg: ASbGnctLKyHTVsQ28bLrceN8IHWVsoDHDlATGinKra/O/Epf1FToTjyzWexd5kSJXDf
	WjbsoGTcaSbNv9BKIRT/qMO4GJ29jgYEh/R64GMzDhfYsKIQT35kMaiG/Pb96g6OW68tYamOEsQ
	lZWWX74VvrzYPFXZVY50HtLPZ7UQFEa27AOO93XSakMLtcraQuhkfVAlwbs6ny5GGz8xRc+4UXP
	4pA6mxoA1Fbrxz6MNBLrAOVmjOHcxe5JJLkdoOyNzNCPfQEBJGzkMig7yoc7Ua+YJKeb6PquDso
	FBYwZinccuSEOheaXCvfqUaS/IDkIHJD3yeV40rQ
X-Received: by 2002:a05:6a00:4b16:b0:732:1eb2:7bf3 with SMTP id d2e1a72fcca58-7326190da79mr13548555b3a.21.1739774101991;
        Sun, 16 Feb 2025 22:35:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELGz3GfyEeU6Trxoq5KbbF54Mp2aAMym3Xjbg6o2A/BhSQ+4SDY7/QVTEr7x4pCB17FhXW0A==
X-Received: by 2002:a05:6a00:4b16:b0:732:1eb2:7bf3 with SMTP id d2e1a72fcca58-7326190da79mr13548522b3a.21.1739774101600;
        Sun, 16 Feb 2025 22:35:01 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73263b79287sm3771800b3a.29.2025.02.16.22.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:35:01 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 17 Feb 2025 12:04:15 +0530
Subject: [PATCH 8/8] wifi: ath11k: add support for MHI bandwidth scaling
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mhi_bw_up-v1-8-9bad1e42bdb1@oss.qualcomm.com>
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
In-Reply-To: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739774050; l=2713;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=b+t07/zpN1OKXOmnB0/fJYpVmV3Y/hIRHKddZUlsHzc=;
 b=VEDY9epxk1pHB6IUS9ig0ZBJnc9Og8yA0SyFxac0uwlu+rLcCA8hWDA3dBuU+0yAWzPuxnCwM
 jPTL5VNdQzuAtFkqpfGWxw/zT4ul1ZBck4W3SG6iKqrfNgd56e/GdnW
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: KwNG9z0fgcANlx8Nmohsbbaho_1JQrCe
X-Proofpoint-ORIG-GUID: KwNG9z0fgcANlx8Nmohsbbaho_1JQrCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170056

From: Miaoqing Pan <quic_miaoqing@quicinc.com>

Add support for MHI bandwidth scaling, which will reduce power consumption
if WLAN operates with lower bandwidth. This feature is only enabled for
QCA6390.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 6e45f464a429..03cdbe93949a 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -20,6 +20,7 @@
 #define MHI_TIMEOUT_DEFAULT_MS	20000
 #define RDDM_DUMP_SIZE	0x420000
 #define MHI_CB_INVALID	0xff
+#define MHI_BW_SCALE_CHAN_DB 126
 
 static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
 	{
@@ -73,6 +74,17 @@ static struct mhi_event_config ath11k_mhi_events_qca6390[] = {
 		.client_managed = false,
 		.offload_channel = false,
 	},
+	{
+		.num_elements = 8,
+		.irq_moderation_ms = 0,
+		.irq = 1,
+		.mode = MHI_DB_BRST_DISABLE,
+		.data_type = MHI_ER_BW_SCALE,
+		.priority = 2,
+		.hardware_event = false,
+		.client_managed = false,
+		.offload_channel = false,
+	},
 };
 
 static const struct mhi_controller_config ath11k_mhi_config_qca6390 = {
@@ -313,6 +325,33 @@ static void ath11k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
 	writel(val, addr);
 }
 
+static int ath11k_mhi_op_get_misc_doorbell(struct mhi_controller *mhi_cntrl,
+					   enum mhi_er_data_type type)
+{
+	if (type == MHI_ER_BW_SCALE)
+		return MHI_BW_SCALE_CHAN_DB;
+
+	return -EINVAL;
+}
+
+static int ath11k_mhi_op_bw_scale(struct mhi_controller *mhi_cntrl,
+				  struct mhi_link_info *link_info)
+{
+	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
+	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
+	struct pci_dev *pdev;
+	u8 speed = pcie_link_speed[link_info->target_link_speed];
+
+	if (!pci_dev)
+		return -EINVAL;
+
+	pdev = pci_upstream_bridge(pci_dev);
+	if (!pdev)
+		return -ENODEV;
+
+	return pcie_set_target_speed(pdev, speed, true);
+}
+
 static int ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)
 {
 	struct device_node *np;
@@ -389,6 +428,8 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
+	mhi_ctrl->bw_scale = ath11k_mhi_op_bw_scale;
+	mhi_ctrl->get_misc_doorbell = ath11k_mhi_op_get_misc_doorbell;
 
 	switch (ab->hw_rev) {
 	case ATH11K_HW_QCN9074_HW10:

-- 
2.34.1


