Return-Path: <linux-pci+bounces-10070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9C492D073
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6294928A5BA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486E190460;
	Wed, 10 Jul 2024 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OKQfewbT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B271922C6;
	Wed, 10 Jul 2024 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610213; cv=none; b=N4b/1lojZ3ePw3hcvpDC1yYtnVCzEBQ3MbtMJSOgRe6oNYwMPfn9ZA7ga17ZGnK0tAsbMZwGkyn0HCwNPQ4n/aDzlwQ6ubJS5r4Gf948y9pkNEw6+Dq7XMSP4YGpwo5EzFT75+Eenx5Rdjepm6v51zuwvC6h0ZJAOSnKnHJ/lvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610213; c=relaxed/simple;
	bh=V3qNvuQS2LeXL1m3qYfqkOp0sRscvt8GfvIxIVH7D/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W3FVxqJOE+ROjQwS8ea2FImXClAkDtU23Hx+pAcpJftjQOfiA9Xh5XQHAvhzR/qTKMZWKTf1yPGFdcdw8+i+RADEDHdbaUpFrVUENH0mse9zuS+t2CrRahzP8rPaW7anD1w31qyVOaSBmGZefHHhYmI7ogRRE1x/5y96gqi7HSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OKQfewbT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A28eVa012241;
	Wed, 10 Jul 2024 11:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kzaleWMgjou34UnRNlDOG3xn0bd/WtvDvliEKZxb5l0=; b=OKQfewbTyVW5stX6
	3pxOxfFr3aIjyhGhENCVsjZ8GhPMGL3ZGJDHqU41ONuUhbpwRbtiRVpRx+bLP0Nx
	oadaKLKfS7MPyYfU2wdY7e9k8yda4BZsjKOVL14eLSCSP8b9crRCly0tjMUZInhv
	je6ottVdlyT26eBwpQ3qWflmIjYqQHrlQakgiTkQL1BWhZQz5A6KUMnJCCYNvLY6
	F+/gYOFr+BZ7cMlCSxKDSdgwwrZBAnbMfspuoJ+VexUZKmCZCAExbyumnuJUj9qF
	q2SwLUbG+hxiNOtpO1Y8N+4zD1DYFK5GRIsIhRiOTHJJW6tQadorhl2yfDoWlmHj
	ue/0tA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmsa2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ABGiD0005026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:44 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:16:38 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 10 Jul 2024 16:46:12 +0530
Subject: [PATCH v6 5/5] bus: mhi: ep: wake up host if the MHI state is in
 M3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-wakeup_host-v6-5-ef00f31ea38d@quicinc.com>
References: <20240710-wakeup_host-v6-0-ef00f31ea38d@quicinc.com>
In-Reply-To: <20240710-wakeup_host-v6-0-ef00f31ea38d@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720610170; l=1937;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=V3qNvuQS2LeXL1m3qYfqkOp0sRscvt8GfvIxIVH7D/I=;
 b=D2TIwHwusj16VY5el2ak7Xh6HN7eS3JtKcD06F42WquNPbBc29Qm0MvcwQM+kHRIH9TGzJdpT
 GfSazy0HcSlDm3v/WK+IZsTw78GC3QH7PFmXA+UAqDbH5Iee0jZWnIf
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TdcnI4A4KDzACUjGHrbvEvrKaxWjJVmC
X-Proofpoint-ORIG-GUID: TdcnI4A4KDzACUjGHrbvEvrKaxWjJVmC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100077

If the MHI state is in M3 then most probably the host kept the
device in D3 hot or D3 cold, due to that endpoint transactions will not
reach the host, endpoint needs to wakes up the host to bring the host
to D0 which eventually bring back the MHI state to M0.

while queueing packets if the MHI state is in M3 wakeup host to bring
back link to M0.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/bus/mhi/ep/main.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b3eafcf2a2c5..b8713e5c1e1a 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -25,6 +25,26 @@ static DEFINE_IDA(mhi_ep_cntrl_ida);
 static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
 static int mhi_ep_destroy_device(struct device *dev, void *data);
 
+static int mhi_ep_wake_host(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	enum mhi_state state;
+	bool mhi_reset;
+	u32 count = 0;
+
+	mhi_cntrl->wakeup_host(mhi_cntrl);
+
+	/* Wait for Host to set the M0 state */
+	while (count++ < M0_WAIT_COUNT) {
+		msleep(M0_WAIT_DELAY_MS);
+
+		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
+		if (state == MHI_STATE_M0)
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
 			     struct mhi_ring_element *el, bool bei)
 {
@@ -564,6 +584,14 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 
 	mutex_lock(&mhi_chan->lock);
 
+	if (mhi_cntrl->mhi_state == MHI_STATE_M3) {
+		ret = mhi_ep_wake_host(mhi_cntrl);
+		if (ret) {
+			dev_err(dev, "Failed to wakeup host\n");
+			goto err_exit;
+		}
+	}
+
 	do {
 		/* Don't process the transfer ring if the channel is not in RUNNING state */
 		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {

-- 
2.42.0


