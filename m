Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8C9446F9F
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhKFR6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhKFR6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:58:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58931C061570;
        Sat,  6 Nov 2021 10:55:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w1so45034289edd.10;
        Sat, 06 Nov 2021 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Q6q3isMgPDupqsbJoM92sZ54D8XuX4Je+/qZDkIAWk=;
        b=d+bfy1B6PpfYhUEFK0kXh35yU+4gWis+46PpMvWc0VpIZy9dDUb1YDSr+HQZxEIV1e
         hsi+9NovKp384hXhvBxJSw1F7Bnq6aahySVSWH1FqrZ+vpcuAbvGSL18izlaUeWNxQsC
         3ZoZ4Y87DS2UqD4xBNsW8d/489+kWr9BMp830rImLdMrrNK1bJhxuvlym0WcRuj2eX0v
         j6jEt7KwiQNb1mM8zAanQeVOZTJCTVVxRLfwu1JRgAg4eVQ/H5FZ+87TjTsxrqtGldxM
         o4aMirVrFpkYUE5SclDmtgkqt6iNHTmAoxBJjYTUz6SwNKT1PRNFkFsHczKZNzlQYbn8
         U40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Q6q3isMgPDupqsbJoM92sZ54D8XuX4Je+/qZDkIAWk=;
        b=uDfK1ucPeBCuMYzAoEY7OAl58I3/2NLAoWHi+8G76PgMBagwf3cYTbB/Yoceq0Ca1s
         1bWtgm0n/OA7YDYLEtyt6T/X9m3yx740t19MmvMX+pK5POyiE4KzruLNRzoZbE2Ui6HG
         DxSgQesxyQpRYcK0RM3/6TABFl7a1KlLCtwdtfBFnjfl1w0YWgqD0nzfbslX2ogqj8rF
         3BuAmZdrwCFivtbVtk4rBlrUuidR+gPxoIhUs37DTifcTTEch4j2CSI9yGvw1gOU/aoL
         XsltasVZhVtmwM+9h0kkfQGS84ioUXcU42+AlAYgmTMlmcbuAz9+1NOb1XXB727x977Y
         qEAA==
X-Gm-Message-State: AOAM5332OCMCrv59gVKYDgmLD+s9Xld7Tpn/J0LX5ZgSZWpIVGMlana/
        FtuffBFZjBgfI9nLAKT0N1X+Xm5I8rU=
X-Google-Smtp-Source: ABdhPJy8f1Xs600hPHGAXRobrm65xm91pySG4J58FkRzEXjyqKsdJ4cHFgZoVqdH6Ya4mytdd+CJlg==
X-Received: by 2002:a17:906:a14a:: with SMTP id bu10mr82704284ejb.540.1636221350977;
        Sat, 06 Nov 2021 10:55:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id j3sm5742310ejo.2.2021.11.06.10.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:50 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/3] PCI/ASPM: Merge pcie_set_clkpm_nocheck() into pcie_set_clkpm()
Date:   Sat,  6 Nov 2021 18:55:44 +0100
Message-Id: <20211106175546.27785-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175546.27785-1-refactormyself@gmail.com>
References: <20211106175546.27785-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_set_clkpm_nocheck() is only called from pcie_set_clkpm().

Merge the two functions

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..e5202cc16ef0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -139,21 +139,12 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 	return 0;
 }
 
-static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
+static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 {
+	u32 val;
 	struct pci_dev *child;
 	struct pci_bus *linkbus = link->pdev->subordinate;
-	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
-
-	list_for_each_entry(child, &linkbus->devices, bus_list)
-		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_CLKREQ_EN,
-						   val);
-	link->clkpm_enabled = !!enable;
-}
 
-static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
-{
 	/*
 	 * Don't enable Clock PM if the link is not Clock PM capable
 	 * or Clock PM is disabled
@@ -163,7 +154,14 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 	/* Need nothing if the specified equals to current state */
 	if (link->clkpm_enabled == enable)
 		return;
-	pcie_set_clkpm_nocheck(link, enable);
+
+	val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CLKREQ_EN,
+						   val);
+
+	link->clkpm_enabled = !!enable;
 }
 
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
-- 
2.20.1

