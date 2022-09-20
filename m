Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8F5BE30E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 12:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiITKXB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 06:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiITKW4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 06:22:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4AE6AA0B;
        Tue, 20 Sep 2022 03:22:54 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xs7Y009306;
        Tue, 20 Sep 2022 10:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=9L8/3hza+gG/c24PjetIgp7Z0fytSeM8c90I6dU3fx0=;
 b=WAa110Vde0vp7VN+xTols9xp2EXEPqCZiKgKBNM4zVECylEcYzlaCIllbqG5tgxltlLB
 kvpEztI2DwKTod+jKJ0V1QidlRiRsk0iyPjaHbh3OAhNJu/FtSDO79poAfFlOTajvI+1
 3VmLsM8wYidrj8qlFn/Zz+ikmcAjlm0Qp9b+DL1YGCtU3nzvaLnYsiYK5+LdaiegXHXI
 VfzA7tV0n9mKGOXZLvkvQct/5EXcmpwvaRvzVf94ldkjZvwYKS7BVUCHCCvG1rDbsq5G
 m5O0mAGi4WAfSbp2YqwUCAVYsQik+CW31bcZrnklayJR3r/QFGIXdwa+V/4hnl5JYx1Y Kw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jptw33445-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:22:34 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28KAMU4g016194;
        Tue, 20 Sep 2022 10:22:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jnqrbnbqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 10:22:30 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KAMUYx016171;
        Tue, 20 Sep 2022 10:22:30 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 28KAMUNg016162;
        Tue, 20 Sep 2022 10:22:30 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 9CFAA19FB; Tue, 20 Sep 2022 15:52:29 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        svarbanov@mm-sol.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-phy@lists.infradead.org, vkoul@kernel.org, kishon@ti.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v7 3/5] phy: core: Add support for phy suspend & resume
Date:   Tue, 20 Sep 2022 15:52:25 +0530
Message-Id: <1663669347-29308-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
References: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iG49z6pzG43hKAh5IJjwaeck3CKweXNZ
X-Proofpoint-GUID: iG49z6pzG43hKAh5IJjwaeck3CKweXNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=779 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200062
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introducing phy power suspend and resume callbacks for allowing to
park the link-state in L1ss without holding any PCIe resources during
system suspend.

If we use  phy_suspend & phy_resume API's we are getting compilation
issue as same function is present in drivers/net/phy/phy_device.c.

So creating phy_pm_suspend & phy_pm_resume API's.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
changes since v6:
	- change names from power_down, power_up to suspend & resume
	  respectively.
---
 drivers/phy/phy-core.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/phy/phy.h | 20 ++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index d93ddf1..ca3e423 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -441,6 +441,36 @@ int phy_set_speed(struct phy *phy, int speed)
 }
 EXPORT_SYMBOL_GPL(phy_set_speed);
 
+int phy_pm_suspend(struct phy *phy)
+{
+	int ret;
+
+	if (!phy || !phy->ops->suspend)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->suspend(phy);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_pm_suspend);
+
+int phy_pm_resume(struct phy *phy)
+{
+	int ret;
+
+	if (!phy || !phy->ops->resume)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->resume(phy);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_pm_resume);
+
 int phy_reset(struct phy *phy)
 {
 	int ret;
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index b141375..e312028 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -76,6 +76,8 @@ union phy_configure_opts {
  * @set_mode: set the mode of the phy
  * @set_media: set the media type of the phy (optional)
  * @set_speed: set the speed of the phy (optional)
+ * @suspend: suspending the phy
+ * @resume: resuming the phy
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
  * @release: ops to be performed while the consumer relinquishes the PHY
@@ -89,6 +91,8 @@ struct phy_ops {
 	int	(*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
 	int	(*set_media)(struct phy *phy, enum phy_media media);
 	int	(*set_speed)(struct phy *phy, int speed);
+	int	(*suspend)(struct phy *phy);
+	int	(*resume)(struct phy *phy);
 
 	/**
 	 * @configure:
@@ -226,6 +230,8 @@ int phy_init(struct phy *phy);
 int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
+int phy_pm_suspend(struct phy *phy);
+int phy_pm_resume(struct phy *phy);
 int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode);
 #define phy_set_mode(phy, mode) \
 	phy_set_mode_ext(phy, mode, 0)
@@ -349,6 +355,20 @@ static inline int phy_power_off(struct phy *phy)
 	return -ENOSYS;
 }
 
+static inline int phy_pm_suspend(struct phy *phy)
+{
+	if (!phy)
+		return 0;
+	return -ENOSYS;
+}
+
+static inline int phy_pm_resume(struct phy *phy)
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

