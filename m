Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9255F53A4DC
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiFAMYk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 08:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiFAMYd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 08:24:33 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF73E5F9;
        Wed,  1 Jun 2022 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654086271; x=1685622271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Qs33nKS0x+bYUbXz3PUD+x5Womx8hyZMkTh7yVOAk44=;
  b=bHdvL7L8mmLpMYqBLnZLRQlXix/ZGHOWucHaQfAtV5UUq1t442lEjQaR
   vAWIH3CHu8BsIQ0oRjUYyaNKgk55ZY+67FuW8cZUwNnafzDdk97nAG4TM
   8m1wK8Cu1edvBMiw4s4wycl4yw8OPT7EpkrpZTDYnweg6p2rDF+8cpIwM
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 Jun 2022 05:24:31 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Jun 2022 05:24:29 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg02-blr.qualcomm.com with ESMTP; 01 Jun 2022 17:54:13 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 129AD4140; Wed,  1 Jun 2022 17:54:12 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>
Subject: [PATCH v3] PCI/ASPM: Update LTR threshold based upon reported max latencies
Date:   Wed,  1 Jun 2022 17:53:45 +0530
Message-Id: <1654086232-17055-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
References: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In ASPM driver, LTR threshold scale and value is updating based on
tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
LTR threshold scale and value is greater values than max snoop/non-snoop
value.

Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
reported snoop/no-snoop values is greather than or equal to
LTR_L1.2_THRESHOLD value.

Suggested-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---

I am takking this patch forward as prasad is no more working with our org.

Changes since v2:
	- Replaced LTRME logic with max snoop/no-snoop latencies check.
Changes since v1:
	- Added missing variable declaration in v1 patch
---
 drivers/pci/pcie/aspm.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a96b742..4a15e50 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -465,10 +465,19 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	u32 ctl1 = 0, ctl2 = 0;
 	u32 pctl1, pctl2, cctl1, cctl2;
 	u32 pl1_2_enables, cl1_2_enables;
+	int ltr;
+	u16 max_snoop_lat = 0, max_nosnoop_lat = 0;
 
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
 
+	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return;
+
+	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
+	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
+
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
 	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
@@ -501,7 +510,18 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
-	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
+
+	/*
+	 * If the max snoop and no snoop latencies are '0', then avoid updating scale
+	 * and value.
+	 *
+	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
+	 * snoop/no-snoop values is greather than or equal to LTR_L1.2_THRESHOLD value.
+	 */
+	if ((max_snoop_lat == 0) && (max_nosnoop_lat == 0))
+		ctl1 |= t_common_mode << 8;
+	else
+		ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 
 	/* Some broken devices only support dword access to L1 SS */
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
-- 
2.7.4

