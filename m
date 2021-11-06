Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2744446F8C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhKFR4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbhKFR4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:56:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F8FC061208;
        Sat,  6 Nov 2021 10:54:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ee33so44973432edb.8;
        Sat, 06 Nov 2021 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6A7zCqzCZWyLyiZF3DRuNcihyZACWBNYNUaRORwS67o=;
        b=qz8jGwscVHWwpiGr2NGnGRq0w9XHF+qf2OsfpG7ncBlUEkdMPqeWqwnn7E6SlA7Icw
         /Kz6K0F4fr3DEC70CXj/O12sAc9JX2ZghKr8afemQOuaxyT/ebMKERCwUp7RNS9Xv1xb
         JcP+KU0y8KhtVZRJlEXm7rrGVhDtSZL1A1hZm5l8eVwJmVvYKvfemLGDWT4o2dTZWRom
         /jqRi2IvVw2m66z3GhkmPgp5tJZpgQZHUhSxFFz1rv1oSVzIt8llvKhFHYAWgX74ptsR
         kvlicFoZEqrwFX96TOJ9NrMQWepWsxQ4RPt/UM6s5sFSYMb9UvZ9c+n8mPxgLdShRe54
         vVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6A7zCqzCZWyLyiZF3DRuNcihyZACWBNYNUaRORwS67o=;
        b=PtnguBbZIAV6tU1u8K8JFuXQOI9UjMTP4qqy8T5ZYgJ5v2DWIbInXXGCSEyGarZ1YY
         t0NkxnGGtHYb988naspB9+/HH0fPG/jVlEnpEcjG5KKMGxP94/kI2yOnx5jcr1ZTKyu7
         eAAqQbZNDwKXibRslYLDJUe9G/Z/v6Vqzp13gruHYroOVVXA9mSyMaQuoVuqTJxHjAEM
         E+5INgbNf3c/5gl9kGjfmMSDBakz7ob4zfmz43w+1hfAX7pgeerRuAeTxDkmFTiygA+t
         x0X9YwmWclePyXss9R+09PulYvQezu84wR4Hv9VBBaTHM3706Q2/VFHk5oUBT/oFBA3H
         LRyw==
X-Gm-Message-State: AOAM533Rn+6cycJVsV4j1VKD5539p41lLmwHabJZO+IeTABAh59YptIJ
        VGFfyHX2qoWywNsnRKTGJ4jjFIY5CvI=
X-Google-Smtp-Source: ABdhPJwrXFVzeZ21mBgdDmONxUiJSy9p4dYteuwI75Cq1o8zchlrsJMBtxJEchW9Tq2TBqP+i4Di1w==
X-Received: by 2002:a17:907:8a20:: with SMTP id sc32mr56196955ejc.65.1636221241874;
        Sat, 06 Nov 2021 10:54:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id m12sm5753494ejj.63.2021.11.06.10.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:54:01 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 6/6] PCI/ASPM: Don't cache struct pcie_link_state->aspm_enabled
Date:   Sat,  6 Nov 2021 18:53:53 +0100
Message-Id: <20211106175353.26248-7-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175353.26248-1-refactormyself@gmail.com>
References: <20211106175353.26248-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

aspm_enabled in struct pcie_link_state usually holds the current
enabled states of the link. This value is set in two places:
1. pcie_aspm_cap_init(): if the passed in blacklist value holds true,
   then `link->aspm_enabled = ASPM_STATE_ALL` otherwise values are
   read from the register and link->aspm_enabled is calculated.
   This calculation has been extracted into aspm_calc_enabled_states()
   in an earlier patch in this series.
2. pcie_config_aspm_link(): when a valid state is calculated from the
   value passed in. The result is later written into the register. The
   calculated valid state is then store in struct
   pcie_link_state->aspm_enabled.

The calculations in aspm_calc_enabled_states() reads and uses the
current state in the register. This can be called whenever
link->aspm_enabled is needed. We don't need to store the state.

For the case when blacklist value holds in pcie_aspm_cap_init(), this
value comes from pcie_aspm_init_link_state(). We can obtain this value
whenever link->aspm_enabled is needed and determine if the current
enabled states should be set to "ASPM_STATE_ALL". So also in this case
we don't need to store the enabled states, it can be obtained on the
fly.

 - Remove aspm_enabled from struct pcie_link_state.
 - Create a wrapper function arround aspm_calc_enabled_states().
 - Replace references to aspm_enabled with a function call.

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 05ca165380e1..dce0851c6ab5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -54,7 +54,6 @@ struct pcie_link_state {
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
-	u32 aspm_enabled:7;		/* Enabled ASPM state */
 	u32 aspm_capable:7;		/* Capable ASPM state with latency */
 	u32 aspm_default:7;		/* Default ASPM state by BIOS */
 	u32 aspm_disable:7;		/* Disabled ASPM state */
@@ -676,6 +675,18 @@ static u32 aspm_calc_enabled_states(struct pcie_link_state *link,
 	return aspm_enabled;
 }
 
+static u32 aspm_get_enabled_states(struct pcie_link_state *link)
+{
+	u32 up_l1ss_cap, dwn_l1ss_cap;
+
+	if (pcie_aspm_sanity_check(link->pdev))
+		return ASPM_STATE_ALL;
+
+	aspm_calc_both_l1ss_caps(link, &up_l1ss_cap, &dwn_l1ss_cap);
+
+	return aspm_calc_enabled_states(link, up_l1ss_cap, dwn_l1ss_cap);
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -684,8 +695,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	struct pci_bus *linkbus = parent->subordinate;
 
 	if (blacklist) {
-		/* Set enabled/disable so that we will disable ASPM later */
-		link->aspm_enabled = ASPM_STATE_ALL;
+		/* Set disable so that we will disable ASPM later */
 		link->aspm_disable = ASPM_STATE_ALL;
 		return;
 	}
@@ -719,11 +729,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Setup L1 substate */
 	aspm_calc_both_l1ss_caps(link, &parent_l1ss_cap, &child_l1ss_cap);
 
-	link->aspm_enabled = aspm_calc_enabled_states(link, parent_l1ss_cap,
-						      child_l1ss_cap);
-
 	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
+	link->aspm_default = aspm_calc_enabled_states(link, parent_l1ss_cap,
+						      child_l1ss_cap);
 
 	aspm_support = aspm_calc_init_linkcap(parent_lnkcap, child_lnkcap,
 					      parent_l1ss_cap, child_l1ss_cap);
@@ -762,7 +770,7 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	u32 val, enable_req;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 
-	enable_req = (link->aspm_enabled ^ state) & state;
+	enable_req = (aspm_get_enabled_states(link) ^ state) & state;
 
 	/*
 	 * Here are the rules specified in the PCIe spec for enabling L1SS:
@@ -821,6 +829,7 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	u32 upstream = 0, dwstream = 0;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
+	u32 aspm_enabled = aspm_get_enabled_states(link);
 
 	/* Enable only the states that were not explicitly disabled */
 	state &= (link->aspm_capable & ~link->aspm_disable);
@@ -832,11 +841,11 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	/* Spec says both ports must be in D0 before enabling PCI PM substates*/
 	if (parent->current_state != PCI_D0 || child->current_state != PCI_D0) {
 		state &= ~ASPM_STATE_L1_SS_PCIPM;
-		state |= (link->aspm_enabled & ASPM_STATE_L1_SS_PCIPM);
+		state |= (aspm_enabled & ASPM_STATE_L1_SS_PCIPM);
 	}
 
 	/* Nothing to do if the link is already in the requested state */
-	if (link->aspm_enabled == state)
+	if (aspm_enabled == state)
 		return;
 	/* Convert ASPM state to upstream/downstream ASPM register state */
 	if (state & ASPM_STATE_L0S_UP)
@@ -863,8 +872,6 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		pcie_config_aspm_dev(child, dwstream);
 	if (!(state & ASPM_STATE_L1))
 		pcie_config_aspm_dev(parent, upstream);
-
-	link->aspm_enabled = state;
 }
 
 static void pcie_config_aspm_path(struct pcie_link_state *link)
@@ -1238,7 +1245,7 @@ bool pcie_aspm_enabled(struct pci_dev *pdev)
 	if (!link)
 		return false;
 
-	return link->aspm_enabled;
+	return aspm_get_enabled_states(link);
 }
 EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
 
@@ -1249,7 +1256,8 @@ static ssize_t aspm_attr_show_common(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
-	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
+	return sysfs_emit(buf, "%d\n",
+			  (aspm_get_enabled_states(link) & state) ? 1 : 0);
 }
 
 static ssize_t aspm_attr_store_common(struct device *dev,
-- 
2.20.1

