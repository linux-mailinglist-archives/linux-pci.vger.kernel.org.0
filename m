Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2B5BA7D2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIPIJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 04:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIPIJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 04:09:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B144213F4A;
        Fri, 16 Sep 2022 01:09:39 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G3oinI003897;
        Fri, 16 Sep 2022 08:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=XWQt6XbmcvimFUoy52Add1s9OZBwCF4j/jqklaojP7k=;
 b=md0VJWzb4YJJ5yxrDdlLgYmRfQ4Qv6IHbO/qnIKq8baF/vsJVxM/XAC3GuYMIGCkqP+W
 OakNFASrRwgoATyJtKzTPZfVwUKL2w1mrL2VxY31eEKIwcFbAVYdpMPWKu8kT3ZbsG/P
 0o4R9LxIVbq9rVSEj1Ph79/eLZqEfFQ8R4dJ7Nd+KQJWZk1ocuKZJEbOWm11nh7ovTqa
 pDh4lvXr/7jVogBFqa25qCeMldW9OtZbiV809X1gFtmcuDuAwT9FYown087BSxT3i6po
 S+POP5jm0MLpljbd6xysXuTD7pK1x3X0f08s82+b7KOkUxFt3w72IpTmWSsjMAFw+YMd jA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm9m1a7j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 08:09:22 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28G89Ig6026002;
        Fri, 16 Sep 2022 08:09:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jh450cw34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Sep 2022 08:09:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28G89IMh025997;
        Fri, 16 Sep 2022 08:09:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 28G89Iod025996;
        Fri, 16 Sep 2022 08:09:18 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 319D8112E; Fri, 16 Sep 2022 13:39:17 +0530 (+0530)
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
        Vidya Sagar <vidyas@nvidia.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v7] PCI/ASPM: Update LTR threshold based upon reported max latencies
Date:   Fri, 16 Sep 2022 13:38:37 +0530
Message-Id: <1663315719-21563-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rmdEVe21uGuM9xFrwc1XPWgodjLRIPX4
X-Proofpoint-GUID: rmdEVe21uGuM9xFrwc1XPWgodjLRIPX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_04,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160060
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In ASPM driver, LTR threshold scale and value are updated based on
tcommon_mode and t_poweron values. In Kioxia NVMe L1.2 is failing due to
LTR threshold scale and value are greater values than max snoop/non-snoop
value.

Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
reported snoop/no-snoop values is greater than or equal to
LTR_L1.2_THRESHOLD value.

Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

I am taking this patch forward as prasad is no more working with our org.
changes since v6:
	- Rebasing with pci/next.
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
index 928bf64..2bb8470 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -486,13 +486,35 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 val1, val2, scale1, scale2;
+	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
 	u32 pctl1, pctl2, cctl1, cctl2;
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
@@ -525,6 +547,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
+
+	/*
+	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
+	 * snoop/no-snoop values are greater than or equal to LTR_L1.2_THRESHOLD value.
+	 */
+	scale = min(scale, max_scale);
+	value = min(value, max_val);
+
 	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 
 	/* Some broken devices only support dword access to L1 SS */
-- 
2.7.4

