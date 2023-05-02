Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE40E6F4A65
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 21:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjEBTcN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEBTcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 15:32:12 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1581FC3
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 12:32:10 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63b6527a539so2689323b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 02 May 2023 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683055930; x=1685647930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeYkAsKQQ0HUkQlGdNcCWqmm6pKxSbFqjQ7L6hKU1cI=;
        b=IJvrnkqYtqY/gza8yo6sMsL8dnzUvt42ulBZukPS4CabKLTOMVUOR8FmFm2wd/FrRF
         3UMsNMgFDLJAvI7KZkB2a3pJ2Ff4DWk73W94vDiHPLweBPhZyKuejnOygwfxHE2PrQZu
         Vy4L7b2uBLpjGhYuncL9irfIA9CfOzPZOggMwhCu8OqefsJ0l0hTh3hGV2psSLRGimQx
         HSxC7QEcyu0n+KFPCSDl/JA5qSLabBKtBvu3pMCfhsG9aAtB7/7IrmMMxB+UaFzf4bkc
         QaylLXomFO00bxyQC7rWgvK2rE72NZnsbrJlUt5LYY6UScZuVvGLNPgkB+WOygAGw5SN
         Yxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055930; x=1685647930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeYkAsKQQ0HUkQlGdNcCWqmm6pKxSbFqjQ7L6hKU1cI=;
        b=AtjmpTlpDf+mYvtBb1YFl8xb5iVdhjLMv47soM2dbguU52nrub8FNgkSIcaIfAd4S7
         LVzuRs2PzaegGOQQxmO0dOw3fpQukC3Xz6BbYm4r9w8iMubRpWuEPTINhl2PVkT+VtiW
         aoITY+LlyuHlXNNCs/0kb+EFlMT1EToBiJMZLWum6taHYlRJT4pLQrvXs3TrVBJD9zUe
         lRVRnvLOvRyvS1Eb9pvdQn3OnyLJoP8tFosMmczX0TGFoh5IVHvl54ZeKM2J2P3Vybfr
         HAYdpsVMZKhLO2Z9j1RP/I7mT7Cpc40/GHIz/zLNCNzfB7H1Sf58Y8CXTCwjy7nWnm8X
         yqdg==
X-Gm-Message-State: AC+VfDyCfeFYpV7f4ZdT9uHN38wm0OjC64K1hGZ6BlVDoclx4wwoL1Ht
        23Z1sfjxibkQkcftM+fa+c3bzPwWXk9TR8/kHQ==
X-Google-Smtp-Source: ACHHUZ56CNsPi9qvIApoShEq3odHTS/m7gRgjB2uNfB6pjtZ9NJPHSeHU4RIBCYKLm7gM9qoQ0Z8aHRmf+IaXyFSfA==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a05:6a00:bd4:b0:641:31b1:e781 with
 SMTP id x20-20020a056a000bd400b0064131b1e781mr3532928pfu.5.1683055930098;
 Tue, 02 May 2023 12:32:10 -0700 (PDT)
Date:   Wed,  3 May 2023 01:01:39 +0530
In-Reply-To: <20230502193140.1062470-1-ajayagarwal@google.com>
Mime-Version: 1.0
References: <20230502193140.1062470-1-ajayagarwal@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502193140.1062470-5-ajayagarwal@google.com>
Subject: [PATCH v2 4/5] PCI/ASPM: Rename L1.2 specific functions
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

