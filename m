Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74160545B73
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 07:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiFJFJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 01:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiFJFJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 01:09:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1640425FB;
        Thu,  9 Jun 2022 22:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654837760; x=1686373760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MISAWTCBlLMTTXWFcRmnJRZqF26y/VDz+IG6SwiAu48=;
  b=ZzPHWhnMdn4MMOw28SqehASjdEUiM9nWrx2dCiZGkflXYVI4stVS83+e
   Qrfiiixu75eOtwEGkSzPbc2SUSopdJvu/Yiejbv3OowsGLfX/kLXoUjqT
   2fI3NHHC23QV5BI1F6u39PYtYs1oy80jug9ha5WDIjFNQshaE+yILJLY3
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Jun 2022 22:09:19 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jun 2022 22:09:17 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg02-blr.qualcomm.com with ESMTP; 10 Jun 2022 10:38:56 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id E439331C9; Fri, 10 Jun 2022 10:38:55 +0530 (+0530)
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
        Rajat Jain <rajatja@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v5] PCI/ASPM: Update LTR threshold based upon reported max latencies
Date:   Fri, 10 Jun 2022 10:38:28 +0530
Message-Id: <1654837710-30561-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654242861-15695-1-git-send-email-quic_krichai@quicinc.com>
References: <1654242861-15695-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

