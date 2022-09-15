Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E55B93AD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 06:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIOEcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 00:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOEcn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 00:32:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF458E4E4;
        Wed, 14 Sep 2022 21:32:42 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F46hSA018202;
        Thu, 15 Sep 2022 04:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=iOyl1ZRSLD3l7RdXgKTCXz7qYTdfN8+bAFd8DLwJ2ws=;
 b=ijXPEVBqSBNagt4dqsDDW+MMepB36KZyXbSSewJ3bFRRjHW1RJlCN/ShQUFoD54tqr7C
 XhnI1wJqYwPHdgsnkaHHIbB8UloY7HMhFXK9z7qifd9vdXEN8/moFP0Uy0ZoNhmMDOwO
 /oXFARsgODGaW3v/pHgfq7EnB2n/BwQbdw8O19KsTyR/yy/AIDqGqsF+npcJVfkYfBPG
 Pa5r5rYc4ZIxRzyeMG60eRic7kzFBcy9tux4RZzZ083Lq+NjSrlf7GnTR7PxH26Koy81
 TzlN8wQPx2zi8V0pvDmCxH3PBLktQgGTYc7wHkU7xCGX08qWCpQ9SBtBhkTDccZnFmAN kg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkvr302fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 04:32:34 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28F4WTbd017055;
        Thu, 15 Sep 2022 04:32:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jh4506nwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Sep 2022 04:32:29 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28F4WSXC017050;
        Thu, 15 Sep 2022 04:32:29 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 28F4WSpS017048;
        Thu, 15 Sep 2022 04:32:28 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 994E044C6; Thu, 15 Sep 2022 10:02:27 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [RESEND PATCH v6] PCI/ASPM: Update LTR threshold based upon reported max latencies
Date:   Thu, 15 Sep 2022 10:02:06 +0530
Message-Id: <1663216335-9311-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5LhTohYuskcrg8pzDVA8OK3mzoQ2ScXT
X-Proofpoint-GUID: 5LhTohYuskcrg8pzDVA8OK3mzoQ2ScXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_02,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150022
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In ASPM driver, LTR threshold scale and value are updated based on
tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
LTR threshold scale and value are greater values than max snoop/non-snoop
value.

Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
reported snoop/no-snoop values is greather than or equal to
LTR_L1.2_THRESHOLD value.

Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

I am taking this patch forward as prasad is no more working with our org.
changes since v5:
	- no changes, just reposting as standalone patch instead of reply to
	  previous patch.
Changes since v4:
	- Replaced conditional statements with min and max.
changes since v3:
	- Changed the logic to include this condition "snoop/nosnoop
	  latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
Changes since v2:
	- Replaced LTRME logic with max snoop/no-snoop latencies check.
Changes since v1:
	- Added missing variable declaration in v1 patch
---
 drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a96b742..676c03e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -461,14 +461,36 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 val1, val2, scale1, scale2;
+	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
 	u32 pctl1, pctl2, cctl1, cctl2;
 	u32 pl1_2_enables, cl1_2_enables;
+	u16 ltr;
+	u16 max_snoop_lat, max_nosnoop_lat;
 
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
 
+	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return;
+
+	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
+	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
+
+	max_snp_scale = (max_snoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
+	max_snp_val = max_snoop_lat & PCI_LTR_VALUE_MASK;
+
+	max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
+	max_nsnp_val = max_nosnoop_lat & PCI_LTR_VALUE_MASK;
+
+	/* choose the greater max scale value between snoop and no snoop value*/
+	max_scale = max(max_snp_scale, max_nsnp_scale);
+
+	/* choose the greater max value between snoop and no snoop scales */
+	max_val = max(max_snp_val, max_nsnp_val);
+
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
 	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
@@ -501,6 +523,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
+
+	/*
+	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
+	 * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
+	 */
+	scale = min(scale, max_scale);
+	value = min(value, max_val);
+
 	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 
 	/* Some broken devices only support dword access to L1 SS */
-- 
2.7.4

