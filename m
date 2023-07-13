Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F22751989
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjGMHLE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 03:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjGMHKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 03:10:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0B2691;
        Thu, 13 Jul 2023 00:10:43 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D4oi6S001504;
        Thu, 13 Jul 2023 07:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Bvs+jW+/RxKB8/3YmBJO4p8PBgsIEcxq3wMOfwo8eik=;
 b=Ar99mLwyuVXK7EaD1rHnbAJZv55HoAUyQS3sjV/GaeyMdfc17vi01PvCf1tq6GCR6OB8
 SY/V+xtPBKbKQAW0dIgVJqNgfAvB4fv+fybhW0dMRfvwKA0VK/f9lU4twBPyepV7+GjK
 b4bBbZMnwvY5VwXLOzteeATXFRth/QuH3SG3stEprUQbQ1KOmU98Z+D1RyDcOdRxCDpz
 kW0/j0hU5zHH+41XrhtRmRF+eoU0gUa0IYsajzh4iTu2BqeO1DJf2qfs6XcqzMGY1rP4
 OrzCWaijca63+3wVrtkS5ur548QTKXckwt0bv3pJIuxrZrLUQeJTqZ70lGkBB26Hm38O vg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt89trdy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 07:10:34 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36D7ARW7030237;
        Thu, 13 Jul 2023 07:10:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rq0vkymjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Jul 2023 07:10:31 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36D7AVm5030282;
        Thu, 13 Jul 2023 07:10:31 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36D7AUd5030281;
        Thu, 13 Jul 2023 07:10:31 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 4820347AD; Thu, 13 Jul 2023 12:40:30 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        mhi@lists.linux.dev (open list:MHI BUS)
Subject: [PATCH v4 9/9] bus: mhi: ep: wake up host if the MHI state is in M3
Date:   Thu, 13 Jul 2023 12:40:18 +0530
Message-Id: <1689232218-28265-10-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T15qBKJN9ulkBy-q7XDfJZotAgGCN3OB
X-Proofpoint-GUID: T15qBKJN9ulkBy-q7XDfJZotAgGCN3OB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=966 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130061
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the MHI state is in M3 then the most probably the host kept the
device in D3 hot or D3 cold, due to that endpoint transctions will not
be read by the host, so endpoint wakes up host to bring the host to D0
which eventually bring back the MHI state to M0.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/bus/mhi/ep/main.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 6008818..46a888e 100644
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
@@ -464,6 +484,13 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 	buf_left = skb->len;
 	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
 
+	if (mhi_cntrl->mhi_state == MHI_STATE_M3) {
+		if (mhi_ep_wake_host(mhi_cntrl)) {
+			dev_err(dev, "Failed to wakeup host\n");
+			return -ENODEV;
+		}
+	}
+
 	mutex_lock(&mhi_chan->lock);
 
 	do {
-- 
2.7.4

