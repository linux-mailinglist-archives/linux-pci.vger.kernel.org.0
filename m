Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E997439ED
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjF3Kwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjF3Kwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:52:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4282358A;
        Fri, 30 Jun 2023 03:52:34 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U9XU80014782;
        Fri, 30 Jun 2023 10:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=xzLUzIL/qxaf0TvQEPU7BTfA4oHCOh5h/B0H/DxoR8w=;
 b=gOh0d/bPBhSuc0oPXlgp7ncZHB5bbWz3O+2jdYXCnSb3zTd4jR0Ns1SRo0TXpsUvVdL5
 uADwYzapWUgGutMvTFse0S9VR97Zox1f7EODwFz1Xy0m3OC3ndRx0YN6WDguzPTknQ4x
 o8hO7efmhtXh6GlYwvgj+hGZPBE4pjRT2pps64xGRqk0j6+jnwb55GZdzOkyTWfLPiW5
 TWQ0kTgk3OWIMAyQhPHicMB+ad0Gcw7Ii0CutWVuMeoHcHz3oiKz6+Q/5lOvncCpu0jw
 acrFyS3RK2GSDF8BV3bazho2t/wgSih28KVZPMu4rJH2RnoKt7LImz0BjTmPJG+6UDkZ Ug== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rha8e2f2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 10:52:25 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35UAqH2O004744;
        Fri, 30 Jun 2023 10:52:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rdsjkpf31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Jun 2023 10:52:22 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UAqMUK004786;
        Fri, 30 Jun 2023 10:52:22 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35UAqLYv004781;
        Fri, 30 Jun 2023 10:52:22 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 39CD14ABD; Fri, 30 Jun 2023 16:22:21 +0530 (+0530)
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bo Liu <liubo03@inspur.com>,
        mhi@lists.linux.dev (open list:MHI BUS)
Subject: [PATCH v2 8/8] bus: mhi: ep: wake up host is the MHI state is in M3
Date:   Fri, 30 Jun 2023 16:22:11 +0530
Message-Id: <1688122331-25478-9-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Skcwe1DPfFGYgtTmPP72vdU1oy6Admjq
X-Proofpoint-ORIG-GUID: Skcwe1DPfFGYgtTmPP72vdU1oy6Admjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=868 clxscore=1011 impostorscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300092
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
be read by the host, so endpoint needs to bring the host to D0 which
eventually bring back the MHI state to M0.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/bus/mhi/ep/main.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 6008818..42d3791 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -451,12 +451,14 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
 	struct mhi_ep_chan *mhi_chan = mhi_dev->dl_chan;
 	struct device *dev = &mhi_chan->mhi_dev->dev;
+	u32 buf_left, read_offset, count = 0;
 	struct mhi_ring_element *el;
-	u32 buf_left, read_offset;
 	struct mhi_ep_ring *ring;
 	enum mhi_ev_ccs code;
+	enum mhi_state state;
 	void *read_addr;
 	u64 write_addr;
+	bool mhi_reset;
 	size_t tr_len;
 	u32 tre_len;
 	int ret;
@@ -464,6 +466,18 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 	buf_left = skb->len;
 	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
 
+	if (mhi_cntrl->mhi_state == MHI_STATE_M3) {
+		dev_dbg(dev, "wake up by ch id %x\n", mhi_chan->chan);
+		mhi_cntrl->wakeup_host(mhi_cntrl);
+	}
+
+	/* Wait for Host to set the M0 state */
+	do {
+		msleep(M0_WAIT_DELAY_MS);
+		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
+		count++;
+	} while (state != MHI_STATE_M0 && count < M0_WAIT_COUNT);
+
 	mutex_lock(&mhi_chan->lock);
 
 	do {
-- 
2.7.4

