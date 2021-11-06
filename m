Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086B2446FA0
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhKFR6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhKFR6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:58:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13546C061570;
        Sat,  6 Nov 2021 10:55:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r4so43906706edi.5;
        Sat, 06 Nov 2021 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/P8WA+2iDdON1mVpjkOQgEA/jNZnIHNrCcb1i4JNhk=;
        b=mCbhhQvCpzIbaUdVptVQuuWEcyFQbeb4SxVVpooNFqpe5eKvzkzdDpgz2mSG9lzdoE
         FsZF+P3ZOdyVK3Bwp2j1sgcI38i/fwkl7og7mVoqmOF8vtXpFb0UnO859n3mAaflP+UJ
         tYvjwLzFOjKeP/uib5riCgl21lNGMuH14pqqLroUxOUoSLml7M1ex2z3/NSANpz0uCoX
         rOMzqM1egL45rGQYW0w5tj5K6n5W8+3VUWntSxUeDCdoEAHFQ0Z5aBwCfDNyC9UrOKBi
         fsTGZla+nZl57Rs5KXMIxbi8KjTErgta21Lz3Kf3kwda3qmEWVrT2bOZcHPbBmiwYkjc
         DCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/P8WA+2iDdON1mVpjkOQgEA/jNZnIHNrCcb1i4JNhk=;
        b=peaAGzrLTOHSBt6g17NFabhLx4vwWunq1p4005uzIlA7asAS3pYHah8ZdliT84Ah44
         cf1TUN/qDPlrGXdvwtd4xIXokU7H6ih8z9Wm+j7jKHqDh+0C+jz6zRnyJs61VjZaCrLG
         JUsyVdcs7zZ05oE+6CKPhpy+xyMw8qyty9QJYj11hMBmyDT8DalX/Mjp7sFyQK5DYyn1
         FDA8y/vqIYzLrCK5LULPKhZQgNVFJJJToa8IGe3vjUyV3ogK/6ZJEu4IMxquw72jampI
         0Tn4HCozL7hPjodQ1Uhik1WZex4bghepvN69GQkog8ZoQyNAW7hKUrACSVZQ27/L/0pj
         iISw==
X-Gm-Message-State: AOAM533LO1US/rEHOW90xiCyYdd/cKGgnjo54s0uiM3IcY/jP4sjRp96
        HpnIK2d80Jm1s9sJNzYiDok=
X-Google-Smtp-Source: ABdhPJzf0l6z2FsdOkMX7iPQ9Tt30I2/jqGVaorLESRXNTDWiQ1nwbgHtykobVRJvEtqpbwh1Z3EFw==
X-Received: by 2002:a05:6402:40c5:: with SMTP id z5mr17027775edb.185.1636221351717;
        Sat, 06 Nov 2021 10:55:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id j3sm5742310ejo.2.2021.11.06.10.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:51 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] PCI/ASPM: Remove struct pcie_link_state.clkpm_capable
Date:   Sat,  6 Nov 2021 18:55:45 +0100
Message-Id: <20211106175546.27785-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175546.27785-1-refactormyself@gmail.com>
References: <20211106175546.27785-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The clkpm_capable member of the struct pcie_link_state indicates
if the device is Clock PM capable. This can be calculated when
it is needed, because it comes from Link Capabilities, a read-only
register.

  - remove clkpm_capable from struct pcie_link_state
  - move the calculation of clkpm_capable into
    pcie_is_clkpm_capable()
  - replace references to clkpm_capable with a call to
    pcie_is_clkpm_capable()

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e5202cc16ef0..c1f8f10b7a4c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -61,7 +61,6 @@ struct pcie_link_state {
 	u32 aspm_disable:7;		/* Disabled ASPM state */
 
 	/* Clock PM state */
-	u32 clkpm_capable:1;		/* Clock PM capable? */
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
@@ -105,6 +104,20 @@ static const char *policy_str[] = {
 
 #define LINK_RETRAIN_TIMEOUT HZ
 
+static int pcie_clkpm_capable(struct pci_dev *pdev)
+{
+	u32 cap;
+	struct pci_dev *child;
+	struct pci_bus *linkbus = pdev->subordinate;
+
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
+		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &cap);
+		if (!(cap & PCI_EXP_LNKCAP_CLKPM))
+			return 0;
+	}
+	return 1;
+}
+
 static int policy_to_aspm_state(struct pcie_link_state *link)
 {
 	switch (aspm_policy) {
@@ -149,7 +162,7 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 	 * Don't enable Clock PM if the link is not Clock PM capable
 	 * or Clock PM is disabled
 	 */
-	if (!link->clkpm_capable || link->clkpm_disable)
+	if (!pcie_clkpm_capable(link->pdev) || link->clkpm_disable)
 		enable = 0;
 	/* Need nothing if the specified equals to current state */
 	if (link->clkpm_enabled == enable)
@@ -166,7 +179,7 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	int capable = 1, enabled = 1;
+	int enabled = 1;
 	u32 reg32;
 	u16 reg16;
 	struct pci_dev *child;
@@ -176,7 +189,6 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
 		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
-			capable = 0;
 			enabled = 0;
 			break;
 		}
@@ -186,7 +198,6 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 	link->clkpm_enabled = enabled;
 	link->clkpm_default = enabled;
-	link->clkpm_capable = capable;
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
@@ -1327,7 +1338,7 @@ static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
 		return 0;
 
 	if (n == 0)
-		return link->clkpm_capable ? a->mode : 0;
+		return pcie_clkpm_capable(link->pdev) ? a->mode : 0;
 
 	return link->aspm_capable & aspm_state_map[n - 1] ? a->mode : 0;
 }
-- 
2.20.1

