Return-Path: <linux-pci+bounces-23613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D5EA5F2CB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 12:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB3D16B35F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BA126869F;
	Thu, 13 Mar 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQI1Eq40"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06D266EF4
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866090; cv=none; b=lz5pZ/d7Um2lL3+fqQ1YGQITRyuyjBjUWJk0YlBcJ0tKl3GPPuGfVIaamWCi6RNpBgT16vLfO3BJXI+LAMkgzLXWlFOWNz/l2RoFbwNj/lbSKJN4GrsUtDkyci7WSlXdVoYi5BAXs2KsE3wDTxF6HWkK93DMS8LUnsBZVQTxwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866090; c=relaxed/simple;
	bh=Rkq9qxZem1xtKkroWEWyT6QgQtmiODnW7a2FMBFIv28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWb1QgDir2WJjL9LBiQAOI6wuip1o85iSG8eRn1Vlywm1IPGgwHYbxsMBMZIu04jlmGu8LdbfohADLsF8t97RZFDrkrdvndBQ6V+Ms3VBFLJXV32X19QACC02n5/xMZr5arExuG+i60fjrlVGDfQaSBahMu2temcnTaYWco0Zmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQI1Eq40; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAh8WV019158
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 11:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7U8id8ArYEi1+ZljKtUgJ8X5ow69hRe1y8N7s/OB7Dg=; b=QQI1Eq40e1U/SSe/
	WfTiX7fUIuNzeDrqFTPFqa5Pr1ypoUCJd9FXvDlixiaYcwZTkPT4FV3xB6RxgHcU
	0hjD6nMb2+TpBi15vSaroyjiglMmbV1R27YpD/neYAyn1Z6raZwXBPzXavS9eIT4
	QUHgCeBEa0xADgSS++4kinfJAAWkOsPVcwAqclPx0m4/XpVqokCkmcPoJVwEibV0
	wd/nd7lDs7TBmZ4S8EFQFj+Bh0HcYke9pBgFVvr7NSSf43rpn2vCluC1Qul17+hp
	47BiIg/0urXFEqjDAqZQs7DZiFDHRT0rw8smoawDRtVhSBcb/Q5WJJKMnikdevrQ
	ZMu2Bw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p5qpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 11:41:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so1664246a91.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 04:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866085; x=1742470885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7U8id8ArYEi1+ZljKtUgJ8X5ow69hRe1y8N7s/OB7Dg=;
        b=lpWVtK9IDOiy+34nGxB1mnFpwqAV94dAZyscaNtgCXMJbprv/0WoW0sSMgNkhrfPM3
         6QXPiv8W4kwObyF9Yl1OrD4HT2Ohj7pV6IN9NXMpcn5OMtWOHkxdrZvvp9jpAjO4bWWC
         xerE97o8wDmVJfdXkS+Ka76dNM1G7RSbYIFAtGmTqkxtOiv8RC3TVbVwsr4m0lNwrsy2
         7mOX60I/msl8bBmJp0N482dXoduUxglBiTYNnFs7s/WYyiU7edU7mAHoL4XqCoMtgxxw
         n75zUB5Sakv971O+kUNseZqgo+NVJVOTFH6YxcIH+Tt7PZ+iLOixAtzpOTvIdkWUL5vi
         FfMQ==
X-Gm-Message-State: AOJu0YzStp2VMlXlLokIsN0CvHEqBn0KzrYbNbsevPuLYc41hgIchpkd
	MmiER9bnOEJyOfrIUzqDeNXNM5uum0FsXcD4aQROT9fD5ujdUw6IpROS8e6CD6jrb/PQFnCY6SM
	kCPnA89/m5s4oTx7UYVK70ixbd6Jh7raJsBYQNS6KdtOATu6TvKLgkbzLO3bw3urajFk=
X-Gm-Gg: ASbGncsEZlx5eHn+bakjo/b12o99R69kRVBX/8OJJVFeZSUSq7Mf1CCXllvLsOCV/Do
	XsB1A+DNGNy11aZMk6PdsfwpyxjwKRT8h8pf+uUK2LY8sFTIFpC9v5ELC1zBb81KE9Kjnr2oPSr
	ROdZ9QSvEvHZhD6YIxg8sKv+F5/tJe9b8O5ZTG/zCpvy8PsvOypKDbEOV+cyNjoKapm+t8mEA4B
	VpMwebzqElXczw2fwpfF/qfa/9QtjMyHX6D3CXi1tyPBzGB1TINmLOYsxEK3BiEZRrHGujkae9q
	MJ50NGsZYWRjfpUePORGV6sigmmrm+OZbk30Kor2hGvUlqafym0=
X-Received: by 2002:a05:6a21:3986:b0:1f5:6d6f:28e with SMTP id adf61e73a8af0-1f56d6f0a57mr25199705637.42.1741866085515;
        Thu, 13 Mar 2025 04:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdu71Za2ZIZUx6nw1zhHEdLpi1bIhp4FzCqFkiIftAJo4YOptEIDabzzSpcA9fncM47Xposw==
X-Received: by 2002:a05:6a21:3986:b0:1f5:6d6f:28e with SMTP id adf61e73a8af0-1f56d6f0a57mr25199651637.42.1741866084978;
        Thu, 13 Mar 2025 04:41:24 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:24 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:14 +0530
Subject: [PATCH v2 07/10] bus: mhi: host: Add support for Bandwidth scale
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-7-869ca32170bf@oss.qualcomm.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
In-Reply-To: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
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
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=14880;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Rkq9qxZem1xtKkroWEWyT6QgQtmiODnW7a2FMBFIv28=;
 b=yOPEIt8vuzQ8aa0EY3Y0GsWv9/o7mKsPchWc407vhO5cpSBLpEBXxrBKr2RYr2oMJg8rl32BR
 aEj1dx3KqQeCcW4++BEC5Xo5X+kzIUNdKEpAUrbQ51KjUZuaiFmhnqQ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=HP/DFptv c=1 sm=1 tr=0 ts=67d2c467 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=DYpYOybAal_UZhkPskYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: vvGGdUW9UjVXYnVCUK1zRhcLTQW-P9t_
X-Proofpoint-GUID: vvGGdUW9UjVXYnVCUK1zRhcLTQW-P9t_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

As per MHI spec sec 14, MHI supports bandwidth scaling to reduce power
consumption. MHI bandwidth scaling is advertised in devices that contain
the bandwidth scaling capability registers. If enabled, the device
aggregates bandwidth requirements and sends them to the host in the form
of an event. After the host performs the bandwidth switch, it sends an
acknowledgment by ringing a doorbell.

if the host supports bandwidth scaling events, then it must set
BW_CFG.ENABLED bit, set BW_CFG.DB_CHAN_ID to the channel ID to the
doorbell that will be used by the host to communicate the bandwidth
scaling status and BW_CFG.ER_INDEX to the index for the event ring
to which the device should send bandwidth scaling request in the
bandwidth scaling capability register.

As part of mmio init check if the bw scale capability is present or not,
if present advertise host supports bw scale by setting all the required
fields.

MHI layer will only forward the bw scaling request to the controller
driver, it is responsibility of the controller driver to do actual bw
scaling and then pass status to the MHI. MHI will response back to the
device based up on the status of the bw scale received.

Add a new get_misc_doorbell() to get doorbell for misc capabilities to
use the doorbell with mhi events like MHI BW scale etc.

Use workqueue & mutex for the bw scale events as the pci_set_target_speed()
which will called by the mhi controller driver can sleep.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h        |  16 +++++++
 drivers/bus/mhi/host/init.c     |  64 ++++++++++++++++++++++++-
 drivers/bus/mhi/host/internal.h |   7 ++-
 drivers/bus/mhi/host/main.c     | 101 +++++++++++++++++++++++++++++++++++++++-
 drivers/bus/mhi/host/pm.c       |  10 +++-
 include/linux/mhi.h             |  13 ++++++
 6 files changed, 205 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index eedac801b800..0a02acee709a 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -208,6 +208,22 @@
 #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
 							       MHI_PKT_TYPE_COALESCING))
 
+/* MHI Bandwidth scaling offsets */
+#define MHI_BW_SCALE_CFG_OFFSET		0x4
+#define MHI_BW_SCALE_CAP_ID		(3)
+
+#define MHI_BW_SCALE_ENABLE(bw_scale_db, er_index)	cpu_to_le32(FIELD_PREP(GENMASK(31, 25), \
+							bw_scale_db) |				\
+							FIELD_PREP(GENMASK(23, 19), er_index) |	\
+							BIT(24))
+
+#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)	FIELD_GET(GENMASK(15, 8), (MHI_TRE_GET_DWORD(tre, 0)))
+#define MHI_BW_SCALE_DB_ID(er_index)	FIELD_PREP(GENMASK(31, 25), er_index)
+
+#define MHI_BW_SCALE_RESULT(status, seq)	cpu_to_le32(FIELD_PREP(GENMASK(11, 8), status) | \
+						FIELD_PREP(GENMASK(7, 0), seq))
+#define MHI_BW_SCALE_NACK			0xF
+
 enum mhi_pkt_type {
 	MHI_PKT_TYPE_INVALID = 0x0,
 	MHI_PKT_TYPE_NOOP_CMD = 0x1,
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 0b14b665ed15..71abe02f5726 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -496,10 +496,56 @@ static int mhi_get_capability_offset(struct mhi_controller *mhi_cntrl, u32 capab
 	return -ENXIO;
 }
 
+/* to be used only if a single event ring with the type is present */
+static int mhi_get_er_index(struct mhi_controller *mhi_cntrl,
+			    enum mhi_er_data_type type)
+{
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+	int i;
+
+	/* find event ring for requested type */
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->data_type == type)
+			return mhi_event->er_index;
+	}
+
+	return -ENOENT;
+}
+
+static int mhi_init_bw_scale(struct mhi_controller *mhi_cntrl,
+			     int bw_scale_db)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 bw_cfg_offset, val = 0;
+	int ret, er_index;
+
+	ret = mhi_get_capability_offset(mhi_cntrl, MHI_BW_SCALE_CAP_ID,
+					&bw_cfg_offset);
+	if (ret)
+		return ret;
+
+	/* No ER configured to support BW scale */
+	er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
+	if (er_index < 0)
+		return er_index;
+
+	bw_cfg_offset += MHI_BW_SCALE_CFG_OFFSET;
+
+	/* advertise host support */
+	val = MHI_BW_SCALE_ENABLE(bw_scale_db, er_index);
+
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
+
+	dev_dbg(dev, "Bandwidth scaling setup complete. Event ring:%d\n",
+		er_index);
+
+	return 0;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;
-	int i, ret;
+	int i, ret, doorbell = 0;
 	struct mhi_chan *mhi_chan;
 	struct mhi_event *mhi_event;
 	void __iomem *base = mhi_cntrl->regs;
@@ -633,6 +679,16 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return ret;
 	}
 
+	if (mhi_cntrl->get_misc_doorbell)
+		doorbell = mhi_cntrl->get_misc_doorbell(mhi_cntrl, MHI_ER_BW_SCALE);
+
+	if (doorbell > 0) {
+		ret = mhi_init_bw_scale(mhi_cntrl, doorbell);
+		if (!ret)
+			mhi_cntrl->bw_scale_db = base + val + (8 * doorbell);
+		else
+			dev_warn(dev, "BW scale setup failure\n");
+	}
 	return 0;
 }
 
@@ -778,6 +834,9 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 		case MHI_ER_CTRL:
 			mhi_event->process_event = mhi_process_ctrl_ev_ring;
 			break;
+		case MHI_ER_BW_SCALE:
+			mhi_event->process_event = mhi_process_bw_scale_ev_ring;
+			break;
 		default:
 			dev_err(dev, "Event Ring type not supported\n");
 			goto error_ev_cfg;
@@ -1012,9 +1071,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 
 		mhi_event->mhi_cntrl = mhi_cntrl;
 		spin_lock_init(&mhi_event->lock);
+		mutex_init(&mhi_event->mutex);
 		if (mhi_event->data_type == MHI_ER_CTRL)
 			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
 				     (ulong)mhi_event);
+		else if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			INIT_WORK(&mhi_event->work, mhi_process_ev_work);
 		else
 			tasklet_init(&mhi_event->task, mhi_ev_task,
 				     (ulong)mhi_event);
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 3134f111be35..bf7c6a7c9383 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -241,6 +241,8 @@ struct mhi_event {
 	struct mhi_ring ring;
 	struct db_cfg db_cfg;
 	struct tasklet_struct task;
+	struct work_struct work;
+	struct mutex mutex;
 	spinlock_t lock;
 	int (*process_event)(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event,
@@ -403,7 +405,8 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 				struct mhi_event *mhi_event, u32 event_quota);
 int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event, u32 event_quota);
-
+int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
+				 struct mhi_event *mhi_event, u32 event_quota);
 /* ISR handlers */
 irqreturn_t mhi_irq_handler(int irq_number, void *dev);
 irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
@@ -419,5 +422,5 @@ void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
 			    struct mhi_buf_info *buf_info);
 void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
 			     struct mhi_buf_info *buf_info);
-
+void mhi_process_ev_work(struct work_struct *work);
 #endif /* _MHI_INT_H */
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 4de75674f193..967563d86aec 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -472,7 +472,10 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
 		if (mhi_dev)
 			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
 	} else {
-		tasklet_schedule(&mhi_event->task);
+		if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			queue_work(mhi_cntrl->hiprio_wq, &mhi_event->work);
+		else
+			tasklet_schedule(&mhi_event->task);
 	}
 
 	return IRQ_HANDLED;
@@ -1049,6 +1052,102 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 	return count;
 }
 
+/* dedicated bw scale event ring processing */
+int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
+				 struct mhi_event *mhi_event, u32 event_quota)
+{
+	struct mhi_event_ctxt *er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
+	u32 response = MHI_BW_SCALE_NACK;
+	struct mhi_ring_element *dev_rp;
+	struct mhi_link_info link_info;
+	int ret = -EINVAL;
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state))) {
+		ret =  -EIO;
+		goto exit_bw_scale_process;
+	}
+
+	if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee))
+		goto exit_bw_scale_process;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(dev,
+			"Event ring rp points outside of the event ring\n");
+		ret =  -EIO;
+		goto exit_bw_scale_process;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
+
+	/* if rp points to base, we need to wrap it around */
+	if (dev_rp == ev_ring->base)
+		dev_rp = ev_ring->base + ev_ring->len;
+	dev_rp--;
+
+	/* fast forward to currently processed element and recycle er */
+	ev_ring->rp = dev_rp;
+	ev_ring->wp = dev_rp - 1;
+	if (ev_ring->wp < ev_ring->base)
+		ev_ring->wp = ev_ring->base + ev_ring->len - ev_ring->el_size;
+	mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+
+	if (WARN_ON(MHI_TRE_GET_EV_TYPE(dev_rp) != MHI_PKT_TYPE_BW_REQ_EVENT)) {
+		dev_err(dev, "!BW SCALE REQ event\n");
+		goto exit_bw_scale_process;
+	}
+
+	link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
+	link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
+	link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
+
+	dev_info(dev, "Received BW_REQ with seq:%d link speed:0x%x width:0x%x\n",
+		 link_info.sequence_num,
+		 link_info.target_link_speed,
+		 link_info.target_link_width);
+
+	/* bring host and device out of suspended states */
+	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
+	if (ret)
+		goto exit_bw_scale_process;
+
+	mhi_cntrl->runtime_get(mhi_cntrl);
+
+	ret = mhi_cntrl->bw_scale(mhi_cntrl, &link_info);
+	if (!ret)
+		response = 0;
+
+	response = MHI_BW_SCALE_RESULT(response, link_info.sequence_num);
+
+	write_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->bw_scale_db, 0, response);
+	write_unlock_bh(&mhi_cntrl->pm_lock);
+
+	mhi_cntrl->runtime_put(mhi_cntrl);
+	mhi_device_put(mhi_cntrl->mhi_dev);
+
+exit_bw_scale_process:
+	dev_dbg(dev, "exit er_index:%u ret:%d\n", mhi_event->er_index, ret);
+
+	return ret;
+}
+
+void mhi_process_ev_work(struct work_struct *work)
+{
+	struct mhi_event *mhi_event = container_of(work, struct mhi_event,
+						   work);
+
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return;
+
+	guard(mutex)(&mhi_event->mutex);
+	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
+}
+
 void mhi_ev_task(unsigned long data)
 {
 	struct mhi_event *mhi_event = (struct mhi_event *)data;
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 11c0e751f223..9c848ca582f0 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -523,7 +523,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 		if (mhi_event->offload_ev)
 			continue;
 		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
-		tasklet_kill(&mhi_event->task);
+		if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			cancel_work_sync(&mhi_event->work);
+		else
+			tasklet_kill(&mhi_event->task);
 	}
 
 	/* Release lock and wait for all pending threads to complete */
@@ -670,7 +673,10 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
 		if (mhi_event->offload_ev)
 			continue;
-		tasklet_kill(&mhi_event->task);
+		if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			cancel_work_sync(&mhi_event->work);
+		else
+			tasklet_kill(&mhi_event->task);
 	}
 
 	/* Release lock and wait for all pending threads to complete */
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 059dc94d20bb..d9bf88c35d14 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -102,10 +102,12 @@ struct image_info {
  * struct mhi_link_info - BW requirement
  * target_link_speed - Link speed as defined by TLS bits in LinkControl reg
  * target_link_width - Link width as defined by NLW bits in LinkStatus reg
+ * sequence_num - used by device to track bw requests sent to host
  */
 struct mhi_link_info {
 	unsigned int target_link_speed;
 	unsigned int target_link_width;
+	int sequence_num;
 };
 
 /**
@@ -183,10 +185,12 @@ enum mhi_ch_ee_mask {
  * enum mhi_er_data_type - Event ring data types
  * @MHI_ER_DATA: Only client data over this ring
  * @MHI_ER_CTRL: MHI control data and client data
+ * @MHI_ER_BW_SCALE: MHI controller bandwidth scale functionality
  */
 enum mhi_er_data_type {
 	MHI_ER_DATA,
 	MHI_ER_CTRL,
+	MHI_ER_BW_SCALE,
 };
 
 /**
@@ -299,6 +303,7 @@ struct mhi_controller_config {
  * @bhi: Points to base of MHI BHI register space
  * @bhie: Points to base of MHI BHIe register space
  * @wake_db: MHI WAKE doorbell register address
+ * @wake_db: MHI BW_SCALE doorbell register address
  * @iova_start: IOMMU starting address for data (required)
  * @iova_stop: IOMMU stop address for data (required)
  * @fw_image: Firmware image name for normal booting (optional)
@@ -355,6 +360,8 @@ struct mhi_controller_config {
  * @write_reg: Write a MHI register via the physical link (required)
  * @reset: Controller specific reset function (optional)
  * @edl_trigger: CB function to trigger EDL mode (optional)
+ * @get_misc_doobell: function to get doorbell used for MISC feature like BW scale etc (optional)
+ * @bw_scale: CB function for passing BW scale info (optional)
  * @buffer_len: Bounce buffer length
  * @index: Index of the MHI controller instance
  * @bounce_buf: Use of bounce buffer
@@ -376,6 +383,7 @@ struct mhi_controller {
 	void __iomem *bhi;
 	void __iomem *bhie;
 	void __iomem *wake_db;
+	void __iomem *bw_scale_db;
 
 	dma_addr_t iova_start;
 	dma_addr_t iova_stop;
@@ -440,6 +448,11 @@ struct mhi_controller {
 	void (*reset)(struct mhi_controller *mhi_cntrl);
 	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
 
+	int (*get_misc_doorbell)(struct mhi_controller *mhi_cntrl,
+				 enum mhi_er_data_type type);
+	int (*bw_scale)(struct mhi_controller *mhi_cntrl,
+			struct mhi_link_info *link_info);
+
 	size_t buffer_len;
 	int index;
 	bool bounce_buf;

-- 
2.34.1


