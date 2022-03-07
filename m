Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DA54D0717
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 19:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbiCGTAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 14:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiCGTAL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 14:00:11 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F944E388;
        Mon,  7 Mar 2022 10:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646679557; x=1678215557;
  h=from:to:cc:subject:date:message-id;
  bh=qctIyTYqs9f3ukRf6gbzWZSCRaC9dudhKd5TcrRHiT4=;
  b=R5UBOZ9NzFvczuaYprPdnNS/IBkmJ1PeOELkv8J3LwuK+DEU9SkLdj/L
   1FO1gRJPHoWZmpSWy1Xbelps76kHcQrphp+/hk6BML3sr3TA+LHeNGzku
   tLNa2YCvsy1+hBFbZPKDQVuOEqAdbfkztEk6a0fWl6ZJAzuDx8Ip8I1w+
   s=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 07 Mar 2022 10:59:17 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Mar 2022 10:59:15 -0800
X-QCInternal: smtphost
Received: from pmaliset-linux.qualcomm.com ([10.206.64.233])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Mar 2022 00:29:12 +0530
Received: by pmaliset-linux.qualcomm.com (Postfix, from userid 3848298)
        id D8D9D21422; Tue,  8 Mar 2022 00:29:10 +0530 (IST)
From:   Prasad Malisetty <quic_pmaliset@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, refactormyself@gmail.com
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: [PATCH v2] [RFC PATCH] PCI: Update LTR threshold based on LTRME bit
Date:   Tue,  8 Mar 2022 00:29:09 +0530
Message-Id: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update LTR threshold scale and value based on LTRME (Latency
Tolenrance Reporting Mechanism) from device capabilities.

In ASPM driver, LTR threshold scale and value is updating
based on tcommon_mode and t_poweron values. In kioxia NVMe,
L1.2 is failing due to LTR threshold scale and value is
greater values than max snoop/non snoop value.

In general, updated LTR threshold scale and value should be
less than max snoop/non snoop value to enter the device
into L1.2 state.

Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>

---
Changes since v1:
	- Added missing variable declaration in v1 patch.
---
 drivers/pci/pcie/aspm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a96b742..a67746c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -463,6 +463,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
+	u32 cap;
 	u32 pctl1, pctl2, cctl1, cctl2;
 	u32 pl1_2_enables, cl1_2_enables;
 
@@ -499,9 +500,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	 * Table 5-11.  T(POWER_OFF) is at most 2us and T(L1.2) is at
 	 * least 4us.
 	 */
-	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
-	encode_l12_threshold(l1_2_threshold, &scale, &value);
-	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
+	pcie_capability_read_dword(child, PCI_EXP_DEVCAP2, &cap);
+	if (!(cap & PCI_EXP_DEVCAP2_LTR)) {
+		l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
+		encode_l12_threshold(l1_2_threshold, &scale, &value);
+		ctl1 |= scale << 29 | value << 16;
+	}
+
+	ctl1 |= t_common_mode;
 
 	/* Some broken devices only support dword access to L1 SS */
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

