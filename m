Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E559941BBDE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbhI2Apv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243529AbhI2Aps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C3C061749;
        Tue, 28 Sep 2021 17:44:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dj4so1959564edb.5;
        Tue, 28 Sep 2021 17:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvkhxBWTCQGc5UyPf7Ik8EwSava2UkxqSV31MfuF8nE=;
        b=QmKx3iZK2fcPq3tcKQWeGQpK56PhAEBPSlHylMW2fvWhv77rsW98W1VMTBQ5HGT79f
         tFyQ6kdzzKhRWgJ8ZxdvZCnNQz1Gkg3rT8drlqbySlC+HKsY6U4LA5tcwAEYJfpzhI/y
         JUiN5BT/jYmYVf8q0ffCgTVRscUnL27Je6YziBpJDdZaZZ3bcpuB2ROcirimI9RYIPwB
         BBOZekQwo6auv8VitAspG+8RjyW9uNpcu+g7MbJnThjujqHNqpISf7UAc9KyXlkRBm0M
         pNmjd/ZLWZK5TTF2Iip4r+FQQUPbyBUYjHX+T/qQ7BxS38tpBDD2CoOVWw5G8mBbuX67
         hpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvkhxBWTCQGc5UyPf7Ik8EwSava2UkxqSV31MfuF8nE=;
        b=edsOd1Wb6gz78D+AobmVtPHMESHRSI5KbWYe0GtwntgA0vV+dC2uoL29EPNMIEm/6u
         uIM5tepNoK4BWgP8BTEpZauaMpQXRbJiHNH2SCRINXUtRw+ZAE87dqkQO+ho24uP094j
         HpkFnnmyykyfeZJtfmt5vrEkcxjzehHAgjLk+SUqdEna2gVCKhDWggEieJvCxnt7CBJ0
         DOia8kkgOY/XoVoJl3piH79Mldsr2HHavUQM0jBPvr4c9Os/YrRLUDTHuHk0NisuGoNG
         zh0XLV9Gkx+FD6iY79ulL+fQtKwSvQdd3rBfiR0orlHxzElAE6rRUovPZyVMdKEFtqgF
         wx9g==
X-Gm-Message-State: AOAM5304K2R3oEsgHnQS7h4IV4qvgqYe34y48Zo29jh23LxxRfKFbe0/
        O8bBnfDtUM4Yf3wSt1b13wUZQ68YlzY=
X-Google-Smtp-Source: ABdhPJyyhVu9B+DglJnyfKL9QAwmjvnPdY04DUdxV0BDhK/hGzfacYFP8Vf+XUuH5d6Pjbx6ecs4rQ==
X-Received: by 2002:a05:6402:19a9:: with SMTP id o9mr11227421edz.233.1632876247239;
        Tue, 28 Sep 2021 17:44:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id r19sm383578edt.54.2021.09.28.17.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:44:06 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/4] PCI/ASPM: Remove struct pcie_link_state.clkpm_enabled
Date:   Wed, 29 Sep 2021 02:43:59 +0200
Message-Id: <20210929004400.25717-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004400.25717-1-refactormyself@gmail.com>
References: <20210929004400.25717-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

The clkpm_enabled member of the struct pcie_link_state stores the
current Clock PM state for the device. However, when the state changes
it is persisted and can be retrieve by calling pcie_get_clkpm_state()
introduced in patch [1/3] in this series.

This patch:
   - removes clkpm_enabled from the struct pcie_link_state
   - removes all instance where clkpm_enable is set
   - replaces references to clkpm_enabled with a call to
     pcie_get_clkpm_state()

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9e65da9a22dd..368828cd427d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -61,7 +61,6 @@ struct pcie_link_state {
 	u32 aspm_disable:7;		/* Disabled ASPM state */
 
 	/* Clock PM state */
-	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
 
 	/* Exit latencies */
@@ -190,7 +189,6 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_CLKREQ_EN,
 						   val);
-	link->clkpm_enabled = !!enable;
 }
 
 static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
@@ -203,14 +201,13 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 	if (!capable || link->clkpm_disable)
 		enable = 0;
 	/* Need nothing if the specified equals to current state */
-	if (link->clkpm_enabled == enable)
+	if (pcie_get_clkpm_state(link->pdev) == enable)
 		return;
 	pcie_set_clkpm_nocheck(link, enable);
 }
 
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	link->clkpm_enabled = pcie_get_clkpm_state(link->pdev);
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
@@ -1287,7 +1284,7 @@ static ssize_t clkpm_show(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
-	return sysfs_emit(buf, "%d\n", link->clkpm_enabled);
+	return sysfs_emit(buf, "%d\n", pcie_get_clkpm_state(link->pdev));
 }
 
 static ssize_t clkpm_store(struct device *dev,
-- 
2.20.1

