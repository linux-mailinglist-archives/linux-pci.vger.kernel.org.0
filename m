Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3555574AF72
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjGGLFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 07:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGGLFP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 07:05:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47C2682;
        Fri,  7 Jul 2023 04:04:46 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36781iJY021693;
        Fri, 7 Jul 2023 11:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=65CovnBWbNUvoSm0fQgVTIwLHVM4Q2BHmiAQqTz3EYI=;
 b=M0DJlzkcTDVG7ixcv52Dyzypt+UAyV4Kma2rD9dcWhFpUea8La6kU6MKT1zpHcFYfgMt
 J1F2tLf6qCaHE8/zaoo4wGzsoG7j7jhlEFH9zIT6e7qWdpadoSLuvU/99NCEE2wPb+Ue
 SjfsuhxZmS08oP/cQYuaYXrjxrUzsqs65NxtXMyf/g+H2lUzojPO90FJCbi4QOnWtXzY
 fOK1xHigGfNmnshGzcUkfpQCyKERc6beSJv8XAsV8bm/3sB0tOpTIO7hFu8f0bu21PEo
 dXFxylbN83R7BbL/MajVTym2L5D1EuJGGPycbr5AGSubGmz7N/kUqLY2KuSRVXeJ4etk ww== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnx4x2mbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:04:33 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 367B40F2022731;
        Fri, 7 Jul 2023 11:04:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7kq5ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 07 Jul 2023 11:04:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367B3xqC022722;
        Fri, 7 Jul 2023 11:04:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 367B4Ir8022899;
        Fri, 07 Jul 2023 11:04:18 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 6BE8446E0; Fri,  7 Jul 2023 16:34:17 +0530 (+0530)
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
        Bo Liu <liubo03@inspur.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        mhi@lists.linux.dev (open list:MHI BUS)
Subject: [PATCH v3 9/9] bus: mhi: ep: wake up host is the MHI state is in M3
Date:   Fri,  7 Jul 2023 16:33:56 +0530
Message-Id: <1688727836-11141-10-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
References: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j7lnuVVTRFr90927m03mBTypOa34UxSx
X-Proofpoint-GUID: j7lnuVVTRFr90927m03mBTypOa34UxSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 spamscore=0 mlxlogscore=985 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070103
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/bus/mhi/ep/main.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 6008818..46a8a3c 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -25,6 +25,27 @@ static DEFINE_IDA(mhi_ep_cntrl_ida);
 static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
 static int mhi_ep_destroy_device(struct device *dev, void *data);
 
+static bool mhi_ep_wake_host(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	enum mhi_state state;
+	bool mhi_reset;
+	u32 count = 0;
+
+	mhi_cntrl->wakeup_host(mhi_cntrl);
+
+	/* Wait for Host to set the M0 state */
+	do {
+		msleep(M0_WAIT_DELAY_MS);
+		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
+		count++;
+	} while (state != MHI_STATE_M0 && count < M0_WAIT_COUNT);
+
+	if (state != MHI_STATE_M0)
+		return false;
+
+	return true;
+}
+
 static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
 			     struct mhi_ring_element *el, bool bei)
 {
@@ -464,6 +485,13 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
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

