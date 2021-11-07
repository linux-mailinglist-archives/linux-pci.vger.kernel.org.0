Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0FA4473D1
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 17:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhKGQcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbhKGQcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 11:32:42 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D67C061570;
        Sun,  7 Nov 2021 08:29:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m14so52081717edd.0;
        Sun, 07 Nov 2021 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poWzBna8Q7V3exJi/2cqueSy7kuer5ibESKko9F1UGU=;
        b=HOjupI9r75bO2EzvidRff/ggfTph1/BGa6gkGDgs1zef4PXXVYVXy2Hpl/MM40NLzW
         U6ZojXBWMYOVxUWOwmJfbzHuQvFcwS5KpL8/9bezOBXbSBIKirKGAcuGtQFDYhTNbHX/
         is1MToBp5DOchkhzK+f7OurXlV9H9O61ilc4/tiHgOOKn2/tm0xGnf7+IbtNBZgCfePl
         bRri+qmJIqgQjGNWkXdx0DCwsW/uzT1WI9TRrfdrcFYD8wS/gsFvZ3JUoWRIl5YYOepS
         NsSVbLs4QHoqz/YtANR8+ynezt80AUDkDoUSFGQQ/eS+7T2kdkzPgLI8qEY9B1OypTba
         VkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poWzBna8Q7V3exJi/2cqueSy7kuer5ibESKko9F1UGU=;
        b=TYQ/itYWYCuA1OVIRnZIxwKTrbvtGDOcT/I1zqYIVefTNVS4IewXAO1naJ6s+Zilsd
         imwBqWf3FGxdR8EhDXDfKTblLn5YMyK+4TUOdMUuSDxzlqViCwPgB5RMg7AvUV/pI2pz
         QvaB1JelswbuFFr18IuEsB6npBgYBkDLAqs2fLWvq5ArkIlQta9wGbTE+VPUgc6TXjmJ
         5kbei6RYSuei24QM8Q/hAr/p/02DIE6owSlNYsTvIE16LWkAcV7iK/iBPHJSMcluYBha
         KS63x1ojplmeGHhRCBLQl2InA4BBHmHflwPm+bmX6SxjWGFZNMgMtLfCDZ9traQ1B5S2
         gtpA==
X-Gm-Message-State: AOAM532azrk/Pe9QdZeuIT4K6xe66i1NdEFYRNjtvbiNIdhAGA8Qn1HU
        01mAitlNvSoc/xy+i371FyL8TuXlLCs=
X-Google-Smtp-Source: ABdhPJz1bAn9D1wowPdDJfPD4eySIm/xgTonrRdAdpzAsCqsKd5p8V6oW5SctHSsKIZVpHmYuZL5Fw==
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr59581317ejc.318.1636302597962;
        Sun, 07 Nov 2021 08:29:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id hq37sm7195270ejc.116.2021.11.07.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 08:29:57 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 4/5] PCI/ASPM: Remove struct pcie_link_state.downstream
Date:   Sun,  7 Nov 2021 17:29:40 +0100
Message-Id: <20211107162941.1196-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211107162941.1196-1-refactormyself@gmail.com>
References: <20211107162941.1196-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

Information on the downstream component is cached in
struct pcie_link_state.downstream it obtained within
alloc_pcie_link_state() by calling pci_function_0()

 - remove *downstream* from the struct pcie_link_state.
 - replaces references to pcie_link_state.downstream with
   a call to pci_function_0(pdev->subordinate).

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 90c7a0b379f4..12623556f750 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -48,7 +48,6 @@ struct aspm_latency {
 
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
-	struct pci_dev *downstream;	/* Downstream component, function 0 */
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
@@ -462,7 +461,8 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
@@ -552,7 +552,8 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	u32 parent_l1ss_cap, child_l1ss_cap;
@@ -694,7 +695,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
 	u32 val, enable_req;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 
 	enable_req = (link->aspm_enabled ^ state) & state;
 
@@ -753,7 +755,8 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 {
 	u32 upstream = 0, dwstream = 0;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	struct pci_bus *linkbus = parent->subordinate;
 
 	/* Enable only the states that were not explicitly disabled */
@@ -879,7 +882,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 
 	INIT_LIST_HEAD(&link->sibling);
 	link->pdev = pdev;
-	link->downstream = pci_function_0(pdev->subordinate);
 
 	list_add(&link->sibling, &link_list);
 	pdev->link_state = link;
-- 
2.20.1

