Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26F26F699E
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 13:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjEDLNc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 07:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjEDLNb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 07:13:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC1446B3
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 04:13:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55a42c22300so3578667b3.2
        for <linux-pci@vger.kernel.org>; Thu, 04 May 2023 04:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683198809; x=1685790809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9g2B6J+/lgtLQJAP5WaYm5jJ2a9tEyo3V63mEq29uc=;
        b=2elmKMxGTVN+ms5SSwBMyMgPp3nEJjEe1tNhRYWUa5ElspqbjR2qFcHw/miaZvcOdx
         GwjOd//yJY5CjS/KyMYS5vml7nGDpkio8EH/SMRzCPhOjk7IrMJ7ounStqLAa3Ms98Xp
         WZGB4jZt9RLMLQY8iyaA1WIKp1XEpEnYoGlwjD8rjuecFhqc1pikRXjj4fuAkl4KvKSI
         GAYAGAFwedg0kpWuPT6U62PopXVM/cM4uBMrvdh0ynHYLQuW5Er9wEAJKRpByrKLENHt
         ijKjRdaKTK6GU+qQLRykrwduLvbRgfdEFrydDPUvid9CWSOiflTk4sG2+FgPk4TNHUwm
         dUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683198809; x=1685790809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9g2B6J+/lgtLQJAP5WaYm5jJ2a9tEyo3V63mEq29uc=;
        b=Op2UyY9WHblu4qajtO/RwGT+9NQQyr+Bl9QP+9pRx39HBm3lPdxZoScyJEA/d4rKBI
         sZL3SrH2dCkAYd4OF4FZTBgw7hRtx5ZybkZTHH9jPpsq0pyvX37K0aEpwA+Mu++yL+35
         7aYWS/qaBpc0kEn1KaIwfNZETPYx+e7WkLcwCFbuT/rkrsVtrRFmPjM9SKVSRNCCaUcf
         a9useJ/Mk81fiZ8iW8ti1fOYwO+DQRsRzUnfrQxaIM99KqQnghV6HPBO3DIqkc3tiKWN
         lVwFHexBo2v3bN+8xLl2MSExsfw0iiW2jJYJXJH3ix63c6fCIdNs+gGsIl5jUwmU+rnc
         lXew==
X-Gm-Message-State: AC+VfDy9VtSnff05CZD8d211YGH0htUVrBuT8mSrnjALBh7k/a3kXUwQ
        9PQObkKagi8viBY6Vahg25774HAW27g62fHBnQ==
X-Google-Smtp-Source: ACHHUZ6qDhVW1xrGEu6vTR6XQ5Zkfl4z4tLmG2BKspobTy2QN9n6dqcmlAum5++APnTvyoOO5Z4QNPuwx+hGinquaA==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a81:ae06:0:b0:54f:68a1:b406 with SMTP
 id m6-20020a81ae06000000b0054f68a1b406mr1013413ywh.2.1683198809742; Thu, 04
 May 2023 04:13:29 -0700 (PDT)
Date:   Thu,  4 May 2023 16:43:00 +0530
In-Reply-To: <20230504111301.229358-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230504111301.229358-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504111301.229358-5-ajayagarwal@google.com>
Subject: [PATCH v3 4/5] PCI/ASPM: Rename L1.2 specific functions
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The functions aspm_calc_l1ss_info() and calc_l1ss_pwron() perform
calculations and register programming specific to L1.2 state.
Rename them to aspm_calc_l12_info() and calc_l12_pwron()
respectively.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v2:
 - None

Changelog since v1:
 - New patch to rename L1.2 specific functions

 drivers/pci/pcie/aspm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7c9935f331f1..db7c369a0544 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -337,7 +337,7 @@ static u32 calc_l1_acceptable(u32 encoding)
 }
 
 /* Convert L1SS T_pwr encoding to usec */
-static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
+static u32 calc_l12_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 {
 	switch (scale) {
 	case 0:
@@ -471,7 +471,7 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 }
 
 /* Calculate L1.2 PM substate timing parameters */
-static void aspm_calc_l1ss_info(struct pcie_link_state *link,
+static void aspm_calc_l12_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -495,13 +495,13 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	val2   = (child_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
 	scale2 = (child_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
 
-	if (calc_l1ss_pwron(parent, scale1, val1) >
-	    calc_l1ss_pwron(child, scale2, val2)) {
+	if (calc_l12_pwron(parent, scale1, val1) >
+	    calc_l12_pwron(child, scale2, val2)) {
 		ctl2 |= scale1 | (val1 << 3);
-		t_power_on = calc_l1ss_pwron(parent, scale1, val1);
+		t_power_on = calc_l12_pwron(parent, scale1, val1);
 	} else {
 		ctl2 |= scale2 | (val2 << 3);
-		t_power_on = calc_l1ss_pwron(child, scale2, val2);
+		t_power_on = calc_l12_pwron(child, scale2, val2);
 	}
 
 	/*
@@ -617,7 +617,7 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
 	if (link->aspm_support & ASPM_STATE_L1SS)
-		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
+		aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
 }
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
-- 
2.40.1.495.gc816e09b53d-goog

