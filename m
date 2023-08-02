Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2976C475
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 07:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHBFB2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 01:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjHBFB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 01:01:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B922D69;
        Tue,  1 Aug 2023 22:00:51 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724Ocq7011834;
        Wed, 2 Aug 2023 05:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=oq08dOdJIMrBEaDeXRX53aYvb1ypUTiaIeDjdb1iInM=;
 b=lg6QdVtlmU5VVOUIs9Q75nPDAOOOroocwsAwudMgNfPLuQXunUX3x95EGHeSAnYTbDJp
 sMglg2iBf3M5x2q0sSd6+dGBvXrOai19lu9Ff5x+Z2rD6oTA6b7GZzTxCdtPu5leeDkO
 Nl3vP8pRt/DfJl3a5ry/RZaRWAKZtQ1f1AN3j64QzXKrEgrQP4oz6xZAdpql07yLhPyI
 rj+8SMmgnhyK36l1WqWCxNwgYPM/ZSwCUvHrqAkp+jL0r5OACmLtTD4zViOvjGb6aptW
 IDdwNGJ2xUniyA17pPNRuw+J/UkeHyXLGNbe8jNwh58PltBU5rlwIlSo/EC0E7wJ6ON9 4w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7fre037m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 05:00:16 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37250DJQ023276;
        Wed, 2 Aug 2023 05:00:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s4uukd960-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 02 Aug 2023 05:00:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37250Crg023266;
        Wed, 2 Aug 2023 05:00:12 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37250CbJ023265;
        Wed, 02 Aug 2023 05:00:12 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id CFA8B4B59; Wed,  2 Aug 2023 10:30:11 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mhi@lists.linux.dev (open list:MHI BUS)
Subject: [PATCH v5 5/5] bus: mhi: ep: wake up host if the MHI state is in M3
Date:   Wed,  2 Aug 2023 10:29:19 +0530
Message-Id: <1690952359-8625-6-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690952359-8625-1-git-send-email-quic_krichai@quicinc.com>
References: <1690952359-8625-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DClo9cbYKnJB2DOf7VdGkt6EuVUak_7J
X-Proofpoint-ORIG-GUID: DClo9cbYKnJB2DOf7VdGkt6EuVUak_7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_02,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=937 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020044
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the MHI state is in M3 then most probably the host kept the
device in D3 hot or D3 cold, due to that endpoint transactions will not
be read by the host, endpoint needs to wakes up the host to bring the
host to D0 which eventually bring back the MHI state to M0.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/bus/mhi/ep/main.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 6008818..9035e02 100644
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
@@ -466,6 +486,14 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 
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
2.7.4

