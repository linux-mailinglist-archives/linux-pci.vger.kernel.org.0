Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13B3277533
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgIXPYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXPYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 11:24:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77049C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so3741990edo.10
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CxVW/OWl4rMkNznVqITBMJOJXHc5RmUmH3vwqAEU0DQ=;
        b=ncu8qcj7DhmsrWBGM835amPn69Jtz8xy5/AVqlrbz/f8VqtykGkGQk3dt1ePfMkS16
         vp98Ke8jse+gelLvzSTkVGgchExsJbhWH/J6ZZJeSK5rH+vIdJGiH5BtUcvZfEdA6hLq
         KJodMN30l64ciHdTZ08q1wQt6ts88Sc/vYs+/o+C+WeZT2s8Db3BtO6DB7p2F8jGWQPB
         pORPnoIYfOazcyL8JjvdqoV776zJHjFRoWweh4XjisfUpQTmbTw9gOrSvnqupn5nYW7/
         CXPTIPZfvheWAQyqMCnH1ltZsgVXY/q2EhpsxG4ls2A16LRN1qXVGSPlMH/JWq9E7YRu
         CS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CxVW/OWl4rMkNznVqITBMJOJXHc5RmUmH3vwqAEU0DQ=;
        b=SEVxKtpuVW026DWiiMp719oEydcfreg4L0a6axTei6zzNBQ+2UdZOTEus5+Ju0Z4Ie
         k0ER8FLoMUaLh4Yl89KjbVVtWnNF5FSduT/idIl6k4xB1W7l8nNGjH/iW9tABb2VNSo9
         4z6rQ/PYw+OakoEwo5TWFEbGBzT4vM0hwxWkIU6ZydvtrLurzUoWfa2X9ZxXqM/Fobek
         gY7pLApgYqZ+usfkyISjz6e8gBJQbj4aBK65ao4lyqsIp/CzdUQ3muSwraGPKIUBaoTi
         5JfLuK62gACDhUZ0TpxXLcvkariy+fH2IHjTiSuSdt4gK358BFJW08b9KNwriu77OiQV
         tRJg==
X-Gm-Message-State: AOAM5323RL3VxFihx/3neqFg5xIR08Bd77wua1hAVH0uUDpxJdrfJE29
        WdLV6AaV2ESa3la9tEGZhqkB62qND2g7ew==
X-Google-Smtp-Source: ABdhPJz+E3+k23UgUoB72jvcjx9LSIqrhy1VdKY3oyc8cJ4WHRNxBc/lf+E+DWYl+qvLBFMr1nN2lw==
X-Received: by 2002:aa7:db02:: with SMTP id t2mr420466eds.95.1600961059103;
        Thu, 24 Sep 2020 08:24:19 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id i7sm2641735ejo.22.2020.09.24.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:24:18 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 6/7] PCI/ASPM: Remove struct aspm_register_info and pcie_get_aspm_reg()
Date:   Thu, 24 Sep 2020 16:24:42 +0200
Message-Id: <20200924142443.260861-7-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200924142443.260861-1-refactormyself@gmail.com>
References: <20200924142443.260861-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 - Create get_aspm_enable() to compute aspm_register_info.enable directly
 - Replace all aspm_register_info.enable references with get_aspm_enable()
 - Remove pcie_get_aspm_reg() and all calls to it. All the values are now
   calculated elsewhere.
 - Remove struct aspm_register_info and its references

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cec8acad6363..f4fc2d65240c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -382,19 +382,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 	}
 }
 
-struct aspm_register_info {
-	u32 enabled:2;
-};
-
-static void pcie_get_aspm_reg(struct pci_dev *pdev,
-			      struct aspm_register_info *info)
-{
-	u16 ctl;
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
-	info->enabled = ctl & PCI_EXP_LNKCTL_ASPMC;
-}
-
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 latency, l1_switch_latency = 0;
@@ -511,11 +498,18 @@ static void aspm_support(struct pci_dev *pdev)
 	return (pdev->lnkcap & PCI_EXP_LNKCAP_ASPMS) >> 10;
 }
 
+static u32 get_aspm_enable(struct pci_dev *pdev)
+{
+	u16 ctl;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &ctl);
+	return (ctl & PCI_EXP_LNKCTL_ASPMC);
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
-	struct aspm_register_info upreg, dwreg;
 	u32 up_l1ss_ctl1, dw_l1ss_ctl1;
 
 	if (blacklist) {
@@ -525,10 +519,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		return;
 	}
 
-	/* Get upstream/downstream components' register state */
-	pcie_get_aspm_reg(parent, &upreg);
-	pcie_get_aspm_reg(child, &dwreg);
-
 	/*
 	 * If ASPM not supported, don't mess with the clocks and link,
 	 * bail out now.
@@ -544,13 +534,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	pci_read_config_dword(child, child->l1ss_cap_ptr + PCI_L1SS_CTL1,
 				&dw_l1ss_ctl1);
 
-	/*
-	 * Re-read upstream/downstream components' register state
-	 * after clock configuration
-	 */
-	pcie_get_aspm_reg(parent, &upreg);
-	pcie_get_aspm_reg(child, &dwreg);
-
 	/*
 	 * Setup L0s state
 	 *
@@ -561,9 +544,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L0S)
 		link->aspm_support |= ASPM_STATE_L0S;
 
-	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
+	if (get_aspm_enable(child) & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
-	if (upreg.enabled & PCIE_LINK_STATE_L0S)
+	if (get_aspm_enable(parent) & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
 	link->latency_up.l0s = calc_l0s_latency(parent);
 	link->latency_dw.l0s = calc_l0s_latency(child);
@@ -572,7 +555,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (aspm_support(parent) & aspm_support(child) & PCIE_LINK_STATE_L1)
 		link->aspm_support |= ASPM_STATE_L1;
 
-	if (upreg.enabled & dwreg.enabled & PCIE_LINK_STATE_L1)
+	if (get_aspm_enable(parent) & get_aspm_enable(child)
+				    & PCIE_LINK_STATE_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
 	link->latency_up.l1 = calc_l1_latency(parent);
 	link->latency_dw.l1 = calc_l1_latency(child);
-- 
2.18.4

