Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC086778A75
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjHKJ6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHKJ55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 05:57:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAE319E;
        Fri, 11 Aug 2023 02:57:57 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B98SAP028443;
        Fri, 11 Aug 2023 09:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Clns84L0nF1KIwe8/JcfpazhdfXCbcoCDajSYtA5KWU=;
 b=TtzDO1V9eIk0m/XS0BZdQOftKo5DW8+/6w4juF/pS/OfNGR2B0QzZKwpu38HpS6Oaw8i
 8JI96YCd6IfGES2QWKeK0m/PIr+Y6AS5IUmautGP0SAkUi0HW84WOU80kOLjFVZD9Vtk
 d7BiTT1NyC6sng3X8Ov46jDzNSJKraDmELvTdN49gppoWWZWIfaL90iYWxMg9sz7I0VY
 kf5DOMwBMWAy+e5evneOfYmE0TFDG7TC3jTkxQDiVJ8P7D9HmSum0EWK6wTinR8Pv4Wh
 N9dPRTPHtl44tTHxuGhWLwzFyB3+MqSOpLPcOlsjTD1u+zlfgPVkQHUqpDd9jv+lSIp2 DQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8ya1a1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 09:57:38 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37B9vbNH012556;
        Fri, 11 Aug 2023 09:57:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 3sdf0ssfhf-1;
        Fri, 11 Aug 2023 09:57:37 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37B9saTm009087;
        Fri, 11 Aug 2023 09:57:37 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-skananth-lv.qualcomm.com [10.47.234.42])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 37B9vb1W012549;
        Fri, 11 Aug 2023 09:57:37 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 432606)
        id ED68720FA6; Fri, 11 Aug 2023 02:57:36 -0700 (PDT)
From:   Subramanian Ananthanarayanan <quic_skananth@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        mhi@lists.linux.dev (open list:MHI BUS)
Subject: [PATCH v1] bus: mhi: ep: Clear channel interrupts that are unmasked
Date:   Fri, 11 Aug 2023 02:57:08 -0700
Message-Id: <1691747849-15385-1-git-send-email-quic_skananth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HCRV8ahvfI5higskXPmV-Kd7b43ZtO7g
X-Proofpoint-GUID: HCRV8ahvfI5higskXPmV-Kd7b43ZtO7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=478 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110090
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change is to avoid clearing of interrupts that could have been masked.

Signed-off-by: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>
---
 drivers/bus/mhi/ep/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 6008818..a818781 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -867,7 +867,7 @@ static void mhi_ep_check_channel_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
 		if (ch_int) {
 			mhi_ep_queue_channel_db(mhi_cntrl, ch_int, ch_idx);
 			mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_CLEAR_n(i),
-							mhi_cntrl->chdb[i].status);
+							ch_int);
 		}
 	}
 }
-- 
2.7.4

