Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA3E5B3220
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiIIIpW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 04:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiIIIpV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 04:45:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13839B40F6;
        Fri,  9 Sep 2022 01:45:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898ZYsg028862;
        Fri, 9 Sep 2022 08:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=h5AqmaynuKLrTLKn7227K3Xg6788QCt7Btwh+N/PpcM=;
 b=Nt5JCnvYndxJby43+gdspaACzJOBNDItr3RWz9PQORF86sWqFmUTgDliJmR8sFdgTvXM
 2BLXAziIvVKCj582aAg7ZgsZNDNjlz4mlogtBaHO4X0NhCF0rAv5SX6Vhy2oENWUVWCl
 7g79yvjDlkjlWcivIVox3+iCa2AwN6ZEQmH7omZzG6JgcgbIMIBnIrFtvtbdMvxUziWG
 PibTmYW9MpKKz5GGpAoE0E1HxCBqOoNwctlag6Xe2T5fubUcdGnFT3tSESbzoX6UiLen
 zkSN5IeE80reFm8bZ92XvZcgRfdzSOYXoudfFDcq1hyMqnm5Z1NSjeR56xIlL24NHJdq aQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfupq9e90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 08:45:08 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2898j5I3014248;
        Fri, 9 Sep 2022 08:45:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jc00m8vq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 09 Sep 2022 08:45:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2898j42Q014222;
        Fri, 9 Sep 2022 08:45:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2898j4LL014214;
        Fri, 09 Sep 2022 08:45:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 0302544AC; Fri,  9 Sep 2022 14:15:04 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v6 3/5] phy: core: Add support for phy power down & power up
Date:   Fri,  9 Sep 2022 14:14:42 +0530
Message-Id: <1662713084-8106-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: __Wr50mEm9u1Riga9jMsOS-WY3lYLWLn
X-Proofpoint-ORIG-GUID: __Wr50mEm9u1Riga9jMsOS-WY3lYLWLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=841
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090029
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introducing phy power down/up callbacks for allowing to park the
link-state in L1ss without holding any PCIe resources during
system suspend.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/phy/phy-core.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/phy/phy.h | 20 ++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index d93ddf1..1b0b757 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -441,6 +441,36 @@ int phy_set_speed(struct phy *phy, int speed)
 }
 EXPORT_SYMBOL_GPL(phy_set_speed);
 
+int phy_power_down(struct phy *phy)
+{
+	int ret;
+
+	if (!phy || !phy->ops->power_down)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->power_down(phy);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_power_down);
+
+int phy_power_up(struct phy *phy)
+{
+	int ret;
+
+	if (!phy || !phy->ops->power_up)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->power_up(phy);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_power_up);
+
 int phy_reset(struct phy *phy)
 {
 	int ret;
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index b141375..3a45f4d 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -76,6 +76,8 @@ union phy_configure_opts {
  * @set_mode: set the mode of the phy
  * @set_media: set the media type of the phy (optional)
  * @set_speed: set the speed of the phy (optional)
+ * @power_down: parking the phy in power down state
+ * @power_up: pulling back the phy from power down
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
  * @release: ops to be performed while the consumer relinquishes the PHY
@@ -89,6 +91,8 @@ struct phy_ops {
 	int	(*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
 	int	(*set_media)(struct phy *phy, enum phy_media media);
 	int	(*set_speed)(struct phy *phy, int speed);
+	int	(*power_down)(struct phy *phy);
+	int	(*power_up)(struct phy *phy);
 
 	/**
 	 * @configure:
@@ -226,6 +230,8 @@ int phy_init(struct phy *phy);
 int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
+int phy_power_down(struct phy *phy);
+int phy_power_up(struct phy *phy);
 int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode);
 #define phy_set_mode(phy, mode) \
 	phy_set_mode_ext(phy, mode, 0)
@@ -349,6 +355,20 @@ static inline int phy_power_off(struct phy *phy)
 	return -ENOSYS;
 }
 
+static inline int phy_power_down(struct phy *phy)
+{
+	if (!phy)
+		return 0;
+	return -ENOSYS;
+}
+
+static inline int phy_power_up(struct phy *phy)
+{
+	if (!phy)
+		return 0;
+	return -ENOSYS;
+}
+
 static inline int phy_set_mode_ext(struct phy *phy, enum phy_mode mode,
 				   int submode)
 {
-- 
2.7.4

