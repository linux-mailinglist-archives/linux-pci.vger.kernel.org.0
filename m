Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0EA446FA2
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhKFR6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhKFR6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:58:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28D8C061570;
        Sat,  6 Nov 2021 10:55:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w1so45034460edd.10;
        Sat, 06 Nov 2021 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3tmpUFdzGmDZ4WUOB/oWLSIyqVvdPUkHVycX9v/1S4=;
        b=ePDCO4SURPuf12mUqAZnXPG+s5RIrdRkWYYIhMGzf2AKmjPt++Rwf+eONXFTaqE7Ap
         XPq2ZBvwSHzquYUrwFGV+NGfi9Y3SN3wqPm4IHreVRU6whxAfIuVcHZoPpcJZ+HL6RvU
         7Nn19DdicBpjbiBXgEFPaxQiqst/Hc4al3Gxees3duvqViw1+n6sGdEve17YGLNJSYLt
         r98uu19QQntGvVuaex68lUhdiYF5HDppZhKcz5kjJ+xMFRqqRHQXeB7S3uXyL0mRC7QW
         VCiCykoSnTTtlactA3Up4CUdyEdyompOUFKOg7sppA53iy0OL5dgRxhdONEOlwaS+1wD
         2zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3tmpUFdzGmDZ4WUOB/oWLSIyqVvdPUkHVycX9v/1S4=;
        b=a/Io8UQiYs+cIoeDedwSG33Wy+HZXl/LDVjYo4cSgcdWXyYP6AKWv1lyzcwCiB7uZS
         Wc3jdDLhte3wgchdq4VBFY2J1v0b3CmazLrQ99lYNsXNWisqodlhD+mQPwpj1dYZYHl7
         SeaZPJ7T61nqINU5thLK4w0rP+Obde+eEhcba/Od06MLwlxLnOYkFqgkL6SaO9q14yAI
         vzP15iad2zrsUible5YMUgWhIAbA9goev1HvtZKZhJlpePim0uEVU+jA/Ec3yfOW2AEU
         mMp9PLo3TWnxKrJNhSBkAmgyoM/DfTbGiO6DZ0SASr14t6KcE5xxElZapBnSjqSL+CSf
         dUlQ==
X-Gm-Message-State: AOAM530TJPfvpodie+D6G0Czusd74s5UaubrCDHt7HF1g9Jx2bj+ZiZI
        lIBz+/QshPc6nnx8c+rcKRY=
X-Google-Smtp-Source: ABdhPJyIPH25JvkWo5A1A6qxxj/pUIvTUH/wUWSVevJtRgABfK+CW/BIPFs5alv7FE0jMalnDWFyyA==
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr81379072ejc.24.1636221352613;
        Sat, 06 Nov 2021 10:55:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id j3sm5742310ejo.2.2021.11.06.10.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:52 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] PCI/ASPM: Remove struct pcie_link_state.clkpm_enabled
Date:   Sat,  6 Nov 2021 18:55:46 +0100
Message-Id: <20211106175546.27785-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175546.27785-1-refactormyself@gmail.com>
References: <20211106175546.27785-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The clkpm_enabled member of the struct pcie_link_state stores the
current Clock PM state for the device. However, when the state changes
it is persisted and thus can be retieved directly.

   - move calculations into pcie_clkpm_enabled()
   - removes clkpm_enabled from the struct pcie_link_state
   - removes all instance where clkpm_enable is set
   - replaces references to clkpm_enabled with a call to
     pcie_get_clkpm_state()

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 43 +++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c1f8f10b7a4c..9425d1e38c51 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -61,7 +61,6 @@ struct pcie_link_state {
 	u32 aspm_disable:7;		/* Disabled ASPM state */
 
 	/* Clock PM state */
-	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
 
@@ -104,6 +103,21 @@ static const char *policy_str[] = {
 
 #define LINK_RETRAIN_TIMEOUT HZ
 
+static int pcie_clkpm_enabled(struct pci_dev *pdev)
+{
+	struct pci_dev *child;
+	struct pci_bus *linkbus = pdev->subordinate;
+	u16 ctl;
+
+	/* CLKREQ_EN is only applicable for Upstream Ports */
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
+		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &ctl);
+		if (!(ctl & PCI_EXP_LNKCTL_CLKREQ_EN))
+			return 0;
+	}
+	return 1;
+}
+
 static int pcie_clkpm_capable(struct pci_dev *pdev)
 {
 	u32 cap;
@@ -165,7 +179,7 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 	if (!pcie_clkpm_capable(link->pdev) || link->clkpm_disable)
 		enable = 0;
 	/* Need nothing if the specified equals to current state */
-	if (link->clkpm_enabled == enable)
+	if (pcie_clkpm_enabled(link->pdev) == enable)
 		return;
 
 	val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
@@ -173,31 +187,11 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_CLKREQ_EN,
 						   val);
-
-	link->clkpm_enabled = !!enable;
 }
 
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	int enabled = 1;
-	u32 reg32;
-	u16 reg16;
-	struct pci_dev *child;
-	struct pci_bus *linkbus = link->pdev->subordinate;
-
-	/* All functions should have the same cap and state, take the worst */
-	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
-		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
-			enabled = 0;
-			break;
-		}
-		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
-		if (!(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
-			enabled = 0;
-	}
-	link->clkpm_enabled = enabled;
-	link->clkpm_default = enabled;
+	link->clkpm_default = pcie_clkpm_enabled(link->pdev);
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
@@ -1272,9 +1266,8 @@ static ssize_t clkpm_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
-	return sysfs_emit(buf, "%d\n", link->clkpm_enabled);
+	return sysfs_emit(buf, "%d\n", pcie_clkpm_enabled(pdev));
 }
 
 static ssize_t clkpm_store(struct device *dev,
-- 
2.20.1

