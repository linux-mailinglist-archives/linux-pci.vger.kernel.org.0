Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C447D446F89
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhKFR4t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhKFR4n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:56:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC344C061570;
        Sat,  6 Nov 2021 10:54:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w1so45022437edd.10;
        Sat, 06 Nov 2021 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IejH8ev4vgD/YiYMP4qv3THZTQhq4FVdFOE+OZylfw=;
        b=W80ZFKlzqux/TEjxfoRqzfCUu/+eAk3WS8wY999TBdLB9bg+xTnc7UPetB7DzjfXHr
         OxZ+gIijlMq4hBWgCeWAkxrxqkGJy7tUvYk56zjp5yyGDJH01Z5Pti+U8fwcHB+iQaH8
         0eFN9XFY/BkPQqrUkjqkg3sdkxoZW0J3Na1bkbcPuapcxQ4taXddilI2s3YG71T6r0ml
         CWG8ZLxBOBI/l7VUTaFkpj5bSYh5NcfxQ2sLjLWslpUgJfkzhntoTWAdKj/eVlGdZhk9
         HCNGTia80Wu+CVd3LuLRhZL+637xxLTasXLSs3rwSlnR8DX+AgDKD9Vefvft8duTxWPO
         HBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IejH8ev4vgD/YiYMP4qv3THZTQhq4FVdFOE+OZylfw=;
        b=4Ib0LRxcfAnIFVHKfKcyfCUdVCV0knHEh2SDfu+9+I4bQsmSWwGv9m2ysOitRWboXT
         XNstOF0hihiujnXICKeZFH8KoviXOcZGUOiXb9cLfue7uT1cefWcATpxqf2iLOCLrybx
         7lMgzSi65GPYKFsJS0dfu49Do3xJkn39Y0TlCGPDIOLtIaFAgTKA+4w+tMte5BT5JCR2
         v1vrQwOje6/8/46CwOdtaor+ADfI71dUdaxIc4i7mKjQsNnwChlyjoqPaGwJBL/+AEtK
         9ggg7sPrAnc3pIKHkxY7/+BUy1oy1vkG44+SYhtSqaMhXRTb5vM8MCUopDXxz5w0K2i3
         XstQ==
X-Gm-Message-State: AOAM531zwNYc78iK+ZdJJ8X1ampDbMmIPuLlMNppg/5j6woXmiozcBUy
        rNUWgFFyQXfUssDgcaAtrAQ=
X-Google-Smtp-Source: ABdhPJwgm5cmEwXIiN+OKz5hy65lr2B3U1xLy5fFu0rgZk+3icDr88dyKHrTmzh9nUf3FKlQzVIZAw==
X-Received: by 2002:a50:9dca:: with SMTP id l10mr90558216edk.61.1636221240228;
        Sat, 06 Nov 2021 10:54:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id m12sm5753494ejj.63.2021.11.06.10.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:59 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/6] PCI/ASPM: Don't cache struct pcie_link_state->aspm_support
Date:   Sat,  6 Nov 2021 18:53:51 +0100
Message-Id: <20211106175353.26248-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175353.26248-1-refactormyself@gmail.com>
References: <20211106175353.26248-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

aspm_support in struct pcie_link_state is used to cache the
initial supported ASPM capabilty states as calculated within
aspm_calc_init_linkcap(). This value can be accessed directly
by calling aspm_calc_init_linkcap().

- Remove aspm_support from struct pcie_link_state;
- Create a wrapper function for aspm_calc_init_linkcap()
- Call the wrapper function outside pcie_aspm_cap_init()
- Within pcie_aspm_cap_init() use a local variable to replace
  struct pcie_link_state->aspm_support.

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5e8613cb5db6..9aaae476ea31 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -54,7 +54,6 @@ struct pcie_link_state {
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
-	u32 aspm_support:7;		/* Supported ASPM state */
 	u32 aspm_enabled:7;		/* Enabled ASPM state */
 	u32 aspm_capable:7;		/* Capable ASPM state with latency */
 	u32 aspm_default:7;		/* Default ASPM state by BIOS */
@@ -450,7 +449,8 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
-				u32 parent_l1ss_cap, u32 child_l1ss_cap)
+				u32 aspm_support, u32 parent_l1ss_cap,
+				u32 child_l1ss_cap)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 val1, val2, scale1, scale2;
@@ -459,7 +459,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	u32 pctl1, pctl2, cctl1, cctl2;
 	u32 pl1_2_enables, cl1_2_enables;
 
-	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
+	if (!(aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
 
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
@@ -591,6 +591,20 @@ static u32 aspm_calc_init_linkcap(u32 up_lnkcap, u32 dwn_lnkcap,
 	return link_cap;
 }
 
+static u32 aspm_get_init_cap(struct pcie_link_state *link)
+{
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	u32 parent_lnkcap, child_lnkcap;
+	u32 parent_l1ss_cap, child_l1ss_cap;
+
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
+	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
+	aspm_calc_both_l1ss_caps(link, &parent_l1ss_cap, &child_l1ss_cap);
+
+	return aspm_calc_init_linkcap(parent_lnkcap, child_lnkcap,
+				      parent_l1ss_cap, child_l1ss_cap);
+}
+
 static u32 aspm_calc_enabled_states(struct pcie_link_state *link,
 				    u32 up_l1ss_cap, u32 dwn_l1ss_cap)
 {
@@ -630,7 +644,7 @@ static u32 aspm_calc_enabled_states(struct pcie_link_state *link,
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
-	u32 parent_lnkcap, child_lnkcap;
+	u32 parent_lnkcap, child_lnkcap, aspm_support;
 	u32 parent_l1ss_cap, child_l1ss_cap;
 	struct pci_bus *linkbus = parent->subordinate;
 
@@ -676,15 +690,14 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
 
-	link->aspm_support = aspm_calc_init_linkcap(parent_lnkcap,
-						    child_lnkcap,
-						    parent_l1ss_cap,
-						    child_l1ss_cap);
-	if (link->aspm_support & ASPM_STATE_L1SS)
-		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
+	aspm_support = aspm_calc_init_linkcap(parent_lnkcap, child_lnkcap,
+					      parent_l1ss_cap, child_l1ss_cap);
+	if (aspm_support & ASPM_STATE_L1SS)
+		aspm_calc_l1ss_info(link, aspm_support, parent_l1ss_cap,
+				    child_l1ss_cap);
 
 	/* Setup initial capable state. Will be updated later */
-	link->aspm_capable = link->aspm_support;
+	link->aspm_capable = aspm_support;
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
@@ -994,7 +1007,7 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
 	list_for_each_entry(link, &link_list, sibling) {
 		if (link->root != root)
 			continue;
-		link->aspm_capable = link->aspm_support;
+		link->aspm_capable = aspm_get_init_cap(link);
 	}
 	list_for_each_entry(link, &link_list, sibling) {
 		struct pci_dev *child;
-- 
2.20.1

