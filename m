Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1475B53C68C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242655AbiFCHzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 03:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiFCHzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 03:55:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156135DC1;
        Fri,  3 Jun 2022 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654242922; x=1685778922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=idd1rNj/CX3H0NOTNJzw+JpUrFbH6zOoQ/T+QLi/PZg=;
  b=dgSCgdHIlLH9b/SEqOSnzVr1lxcd1X96WmuBSZm/LUihPNqaavs/eR/Q
   Z0Qw6SOkx7ZCimzp9h+8p4AVwqC2vQ3hk/7Zq55BoDDBS5GX055g/BvdG
   nilYvHuvkABIN9TvkxT52umfsvcW1Qk2CCHsFptfFsgCPRYOUJm1jsXg6
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Jun 2022 00:55:22 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Jun 2022 00:55:04 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Jun 2022 13:24:44 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 33E644151; Fri,  3 Jun 2022 13:24:43 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>
Subject: [PATCH v4] PCI/ASPM: Update LTR threshold based upon reported max latencies
Date:   Fri,  3 Jun 2022 13:24:19 +0530
Message-Id: <1654242861-15695-1-git-send-email-quic_krichai@quicinc.com>
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

From: Prasad Malisetty <quic_pmaliset@quicinc.com>

In ASPM driver, LTR threshold scale and value are updated based on
tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
LTR threshold scale and value are greater values than max snoop/non-snoop
value.

Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
reported snoop/no-snoop values is greather than or equal to
LTR_L1.2_THRESHOLD value.

Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---

I am taking this patch forward as prasad is no more working with our org.
changes since v3:
	- Changed the logic to include this condition "snoop/nosnoop
	  latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
Changes since v2:
	- Replaced LTRME logic with max snoop/no-snoop latencies check.
Changes since v1:
	- Added missing variable declaration in v1 patch
---
 drivers/pci/pcie/aspm.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a96b742..c8f6253 100644
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
+	max_snp_val = (max_snoop_lat & PCI_LTR_VALUE_MASK);
+
+	max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
+	max_nsnp_val = (max_nosnoop_lat & PCI_LTR_VALUE_MASK);
+
+	/* choose the greater max scale value between snoop and no snoop value*/
+	max_scale = (max_snp_scale > max_nsnp_scale) ? max_snp_scale: max_nsnp_scale;
+
+	/* choose the greater max value between snoop and no snoop scales */
+	max_val = (max_snp_val > max_nsnp_val) ? max_snp_val: max_nsnp_val;
+
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
 	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
@@ -501,6 +523,16 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
+
+	/*
+	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
+	 * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
+	 */
+	if (scale > max_scale)
+		scale = max_scale;
+	if (value > max_val)
+		value = max_val;
+
 	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 
 	/* Some broken devices only support dword access to L1 SS */
-- 
2.7.4

