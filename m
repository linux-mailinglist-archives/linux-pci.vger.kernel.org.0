Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7E784521
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjHVPMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjHVPMn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 11:12:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0E11AD;
        Tue, 22 Aug 2023 08:12:40 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MDdqSv029573;
        Tue, 22 Aug 2023 15:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=dZHSkX/6fvtGnwlb+ZmmWJYhYROGXRBi2FALpqYADiE=;
 b=MtDaGCDy9e/eydqwdqq4HceMrgVFgQMHWK3ANbAPDI9NkNIndtZUFvqmg/3SVdUQlIQR
 ZxC/hwFz9ObARGUk9E7Tu9qpJ/wmtJlt7mTzv4PeF4P9WDGQNti5nmsdOd89Uhuua/KB
 0nN8Ikmenc0NS1oyaClWMV+RRWiuijGI0vGd96XFn7CueI4JMU7pb7rgd2umyWdG4t9M
 QnkRpcuCzpdUNkO9fxrFskjJJNTpO6NyV5tHRquzZ6gPAbQ4NFMte5/wLeIi4UxekFOO
 XQwW7HGxwVt0SpYk9ZLgCyuSxuTQKPlLCiFwsJsyrT05gYK+zQGf9ojuoAO/g1zHASCm 1w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smx3009hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 15:12:27 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37MFCOG5032377;
        Tue, 22 Aug 2023 15:12:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sjptkwbvy-1;
        Tue, 22 Aug 2023 15:12:24 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37MFCOZG032369;
        Tue, 22 Aug 2023 15:12:24 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37MFCNTp032355;
        Tue, 22 Aug 2023 15:12:24 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 57BE94B98; Tue, 22 Aug 2023 20:42:23 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org (open list:OPERATING PERFORMANCE POINTS (OPP))
Subject: [PATCH v4 3/4] OPP: Add api to retrieve opps which is at most the provided level
Date:   Tue, 22 Aug 2023 20:42:20 +0530
Message-Id: <1692717141-32743-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
References: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ic0KUM2-GCoD2akHeDRwbBQ0rmyBIoVJ
X-Proofpoint-GUID: ic0KUM2-GCoD2akHeDRwbBQ0rmyBIoVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 mlxlogscore=832 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220116
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dev_pm_opp_find_level_floor() for searching a lesser match or
operating on OPP in the order of decreasing level.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/opp/core.c     | 26 ++++++++++++++++++++++++++
 include/linux/pm_opp.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 954c948..e668cf2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -727,6 +727,32 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
 
+
+/**
+ * dev_pm_opp_find_level_floor() - Search for a rounded floor freq
+ * @dev:	device for which we do this operation
+ * @freq:	Start level
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
+					      unsigned long *level)
+{
+	return _find_key_floor(dev, level, 0, true, _read_level, NULL);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_floor);
+
 /**
  * dev_pm_opp_find_bw_ceil() - Search for a rounded ceil bandwidth
  * @dev:	device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dc1fb58..a3bc386 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -128,6 +128,8 @@ struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level);
 struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 					      unsigned int *level);
+struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
+					      unsigned long *level);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
@@ -285,6 +287,8 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 
 static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 					unsigned int *bw, int index)
+static inline struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
+					unsigned long *level)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.7.4

