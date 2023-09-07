Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6750F79795A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbjIGRLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbjIGRLy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 13:11:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15322170F;
        Thu,  7 Sep 2023 10:11:24 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3874sWkD022496;
        Thu, 7 Sep 2023 06:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=EQ967FvbvMW5P+5s9a4ppmwhjKQVwaeIdatx+3zV210=;
 b=nYmD7sip4H7UesbQ11WaSzcyz8YRgQKm+bAuqFhVOdv5Kz20YtPkK0v8L9WunGgpDE9U
 Hp6uam5hkfLqPEshcS7wMTZd46n25BOIb2KwjjmjiaFJgPflIu53cbqM50b8vkeo/JoM
 Wqd63WMXd1NRS8ukN0WisnFQBVEL9jFbPqgGECSkF5aU3BoQrZaYRVBy2tVrtAUj26WI
 pTuNfnK7UjYba9X93+PeHD2EtZ7YMiakq8g7CttNRC+0Cgimrs7pT1f631fWUmeCrEtP
 gl/wQza8g4Y9RviGy7Zx7Cx5xBH3S1pCYqdstK289zuQJpQo72MpYRLUG5iGIXKwj6j1 7g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxwes18gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:01:04 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38760tdo011300;
        Thu, 7 Sep 2023 06:00:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kjqv2-1;
        Thu, 07 Sep 2023 06:00:59 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38760xFA011336;
        Thu, 7 Sep 2023 06:00:59 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 38760xDN011335;
        Thu, 07 Sep 2023 06:00:59 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 8E80113A9; Thu,  7 Sep 2023 11:30:58 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 3/5] opp: Add dev_pm_opp_find_level_floor()
Date:   Thu,  7 Sep 2023 11:30:31 +0530
Message-Id: <1694066433-8677-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IqBMGPf0peDjwyzxwt33ZtzNL5Q4Gazq
X-Proofpoint-GUID: IqBMGPf0peDjwyzxwt33ZtzNL5Q4Gazq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070052
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During initialization of some drivers, need to vote for max level.

Adding dev_pm_opp_find_level_floor() for searching a lesser match or
operating on OPP in the order of decreasing level.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/opp/core.c     | 25 +++++++++++++++++++++++++
 include/linux/pm_opp.h |  9 +++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 919cc53..6d4d226 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -814,6 +814,31 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
 
 /**
+ * dev_pm_opp_find_level_floor() - Search for a rounded floor freq
+ * @dev:	device for which we do this operation
+ * @level:	Start level
+ *
+ * Search for the matching floor *available* OPP from a starting level
+ * for a device.
+ *
+ * Return: matching *opp and refreshes *level accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
+					       unsigned long *level)
+{
+	return _find_key_floor(dev, level, 0, true, _read_level, NULL);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_floor);
+
+/**
  * dev_pm_opp_find_bw_ceil() - Search for a rounded ceil bandwidth
  * @dev:	device for which we do this operation
  * @bw:	start bandwidth
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 91f87d7..baea92f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -144,6 +144,9 @@ struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 					      unsigned int *level);
 
+struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
+					       unsigned long *level);
+
 struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 					   unsigned int *bw, int index);
 
@@ -314,6 +317,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
+							     unsigned long *level)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 					unsigned int *bw, int index)
 {
-- 
2.7.4

