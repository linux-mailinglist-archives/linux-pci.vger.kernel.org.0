Return-Path: <linux-pci+bounces-27947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EEAABBA34
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8791893F4F
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF13B278155;
	Mon, 19 May 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cofpnuv/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22162277811
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647830; cv=none; b=NzpBQd0kk3Let1jj1BeWOJ06fAQFTfTzZ4WBvm9nWrXLnpJRnyQIqFqYt7RQ0xveSYjU9Fif+ESzESaJqYdObK0uUk5Yv8yMpNHDFJVpaVL9mMbOaVEIcCjpBskRpygCfwIpFwP0+EYBP3Gt3RzoXEJ4iDO7e/iHdeWw/mxdMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647830; c=relaxed/simple;
	bh=T0NWxEeit0FkTClv+OgVI5h2belfjblWs7pI02lhyuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKiqj53BnuqquDuzjt8rG3Fd4WckBnRpMMSrW1KdgD3y15K1FvdDplQoPm0qEhW8QP8CDPKmng5kMmKFXVK38A29yBfpynBCn/BrpMHeBfMAOyZ7QUAnwM17CWTt0w0FLFiejLxKv6UFg3NNx/J4Pvcm0eLMsW7IQxIxzVz2Ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cofpnuv/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9IR6e025244
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qRVHI8/PRu42Vqh4HuSgclK2SbkQHWxggBlquWyWIxQ=; b=Cofpnuv/SbPbPmum
	mOg/azUhsuV9+yaOnOWWnXp43mis01mYqJ/AuFutf9LrYHERSJD6HZqK+FAIIoc+
	0dsW3IVCzIBrX4xqZEx4iwcFNvOUcUmmlUTwkCaY7KeK3vydbcj9gVFPr7LoLMMm
	8PpTb8iyq5gKfYDwoooQrOfoAcssj6cxlpjQiJlHwjP/A8TxnyJQLzJxm4VWaorP
	fR8m3uLyoh9mctfKKm0vpL+QTCElfnLatCKGL/NNDkCS8yFsEXB1Gxvfh5zghEA2
	aV9MChn3tpJsjz/mAF+Jpaw2uT05ew/JKG8UtKqVGS74hAMZEElrkd1wQZ6ZhDCm
	y4v1UA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjnykw6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742b8c0eaf0so951165b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 02:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647816; x=1748252616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRVHI8/PRu42Vqh4HuSgclK2SbkQHWxggBlquWyWIxQ=;
        b=EL3fENvV+eIM2JLcxt1yX+imdI6DBdC4xIBVaC5/4pUogw+cEtyn0rMk2P+2kR+Mn+
         tP7CQ3d5y7Oc48nxin/ahs0tWgST1JF/Ew8XJBHWs3ddyKh+Mzi1qsMjsBY/l9TfcmOA
         fFZxKTQCynMqL2777qg8toy8WrGwFid5i61TCdeco3x8Q1bum4Ush/hZamD/0ymrswCs
         tstv1otJgdDfrzcQ2vprzETab92YqTMdz1Dpbzzcm0dq8/fiU0t2Ms2wlJkozbubRYA5
         VaZznNoN5u/Dc6M3Spdv08Iw9Y5mING54rfOrLFgURT00b+y05EJviUWDQdC2XVM3v9F
         Yl9A==
X-Gm-Message-State: AOJu0YzN5rOnD6scbIJMUt0l93SEpnR/ttBpsjyZJ4VnKGt1cXJX3D15
	WTZZMOZCqgbNuoTWcp9BWRClyNeGmufTVFwloFiQ92NZFYx1QYpPMvUlu4E4eqVwFLDDOD/Y0GW
	uxQeSch5G8zgW0m4Z8HV69gJ2ftPqchQceN15EKF0tWbL5NOnBrjuuo2HFdBM1N0=
X-Gm-Gg: ASbGncuCK3gD8pDQDOrTVMjoTxocfo7FmJCP/h+i0739aHm7LHIKTdZ0FGrEKjzJyGJ
	vwYaMT3n7ibRMSw8QJBpg9jgkbS92FL0UUlrWIo5JMako/AtTUqgPSNDNwzfBis3lS5pAqAoQJ4
	/t1RrWU3pBSNrCi7fdQUBvRY5nCI7PgVuzv1WYFxy1TkyYXjV5MKEg2+s7RsAw0tvCNboxwqTMR
	i1DIHttoWkMULTdt0VpVCM21gtD7tq8ZhwLrP/J1snO+cJfC30/cNvGuXjxRJA5gOirj/4jvu3N
	jdvVZzcQauKBUJMbvFFfQa7DA6xaSjxgDpJWU+jfMvR3AAc=
X-Received: by 2002:a05:6a20:258e:b0:1f5:7fcb:397d with SMTP id adf61e73a8af0-2162189eedemr17085541637.16.1747647815826;
        Mon, 19 May 2025 02:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBn3YQuItzmOTeDJuwyBkkScPtNvgmsDQnEm68ODCFtCJxD6yFeqm20eMNewUKrXrunStz3Q==
X-Received: by 2002:a05:6a20:258e:b0:1f5:7fcb:397d with SMTP id adf61e73a8af0-2162189eedemr17085507637.16.1747647815410;
        Mon, 19 May 2025 02:43:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:43:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:24 +0530
Subject: [PATCH v3 11/11] wifi: ath11k: Add support for MHI bandwidth
 scaling
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-11-3acd4a17bbb5@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
In-Reply-To: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=3170;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=iRU0Yv6S7aDJfgJ0sXHZ6i8h1thDD71OEAeHK48lWWg=;
 b=pXC6t6KaeeBZiubaUAqowVVgtQcd663spifrqVy/Jik6wxRwizcXUr66OHogqm7b7P17DWCKX
 VrPMhEfEqf+B12YjfPKGzQBoQhF857+WH09MfRydBuondK7ulCXpE33
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MiBTYWx0ZWRfXyBtAh49NrD7e
 AWEJ2OJuXL7DI/6qnhV+pJDcGxnD4T1XluI9UPA/cWX2zGawunDxU9RvcbKGEznlOtWj7iu1IkT
 n19LQL2xSr+WhAFafO/J1FAsyTWzgQWEygc4dZxjc+7qi9ydwGjxshOs+WW7nKKrU3cZRMfmoif
 F8+HhSSv0BupqEw2WCqYHDe/+l2+CLJdGeDOBsHjBGHO2sHp35d7ycPmemdYkEIUzRPFNpEziha
 o6EZwE8f0pliicdVLNrSWUjMs0z0SyI6nTwHvWLxSbTaJlVbuxciGVpewDuTGrWpKDa3F7y40He
 nVbhB3balyuJ2W3zOeiTFqm/lF5/jK47dICtxwaxghCO9YgWSdoboygAem6v9qtc/qLRbAT1hM4
 mTEfnnQIyW7r17WILqAhVVQehg6rdxECVDcd0gLGS5MAzafNP2iCTw5c3Nl15blWYW4QmF0X
X-Authority-Analysis: v=2.4 cv=Z9XsHGRA c=1 sm=1 tr=0 ts=682afd53 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=262QNBeyodYRG1lUGOYA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mOpH3r7uFeS6ZRVR3p7p-YZREaoNFtWK
X-Proofpoint-ORIG-GUID: mOpH3r7uFeS6ZRVR3p7p-YZREaoNFtWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190092

From: Miaoqing Pan <quic_miaoqing@quicinc.com>

Add support for MHI bandwidth scaling, which will reduce power consumption
if WLAN operates with lower bandwidth. This feature is only enabled for
QCA6390.

Bandwidth scaling is initiated by the endpoint firmware based upon the
bandwidth requirements, if there is high bandwidth data endpoint requests
for higher data rates or if there is less bandwidth they request for lower
data rates to reduce power. Endpoint initiates this through MHI protocol.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index fc77eac83e953148b96cad096d26b32222157b24..8057031d654d794f9e882a975f99083c193e492c 100644
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
+	enum pci_bus_speed speed = pci_lnkctl2_bus_speed(link_info->target_link_speed);
+	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
+	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
+	struct pci_dev *pdev;
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


