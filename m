Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974EE7E446A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbjKGPxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343881AbjKGPwc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:52:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80576173B;
        Tue,  7 Nov 2023 07:49:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C96C433CB;
        Tue,  7 Nov 2023 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372181;
        bh=vzVoACxyclgh56ugjZIb3anLX8cjRd7jvqXQzJjLjY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oT7sbPZY7MQVhhEX/XcjxcXVTKng+O5NP9UqP5s6XGJWMxWBO+CG8JiJlsZzhnhXp
         vhJlG84n5+FChsgc3x702D7u4464uUYvIvtGGDLL4MRED37K3PY7zVX4SJoo7YsLDY
         V21KO6n6ABjgZaqRGj+/WUG5D7VLggiVTR35A9OibLgCg32Wmnxw6LXwh2QunAw9fz
         Bl9D0CuPOXTQXE1a7hI0mW38tp+Fxm+M4mobwSTswohHLIx2zKpjLy2WK3/0WMytcA
         i8mrz0Fa79bqTgUL0oNu57jxoo515QFZI1+xrgRXHr7vGNSjy41K6G3HKTPehOzZ5j
         9TIqni2V/hUDw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 21/34] PCI: Do error check on own line to split long "if" conditions
Date:   Tue,  7 Nov 2023 10:48:01 -0500
Message-ID: <20231107154846.3766119-21-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154846.3766119-1-sashal@kernel.org>
References: <20231107154846.3766119-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit d15f18053e5cc5576af9e7eef0b2a91169b6326d ]

Placing PCI error code check inside "if" condition usually results in need
to split lines. Combined with additional conditions the "if" condition
becomes messy.

Convert to the usual error handling pattern with an additional variable to
improve code readability. In addition, reverse the logic in
pci_find_vsec_capability() to get rid of &&.

No functional changes intended.

Link: https://lore.kernel.org/r/20230911125354.25501-5-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[bhelgaas: PCI_POSSIBLE_ERROR()]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c    | 9 ++++++---
 drivers/pci/probe.c  | 6 +++---
 drivers/pci/quirks.c | 6 +++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 702fe577089b4..3cd907eb67b74 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -732,15 +732,18 @@ u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
 {
 	u16 vsec = 0;
 	u32 header;
+	int ret;
 
 	if (vendor != dev->vendor)
 		return 0;
 
 	while ((vsec = pci_find_next_ext_capability(dev, vsec,
 						     PCI_EXT_CAP_ID_VNDR))) {
-		if (pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER,
-					  &header) == PCIBIOS_SUCCESSFUL &&
-		    PCI_VNDR_HEADER_ID(header) == cap)
+		ret = pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
+		if (ret != PCIBIOS_SUCCESSFUL)
+			continue;
+
+		if (PCI_VNDR_HEADER_ID(header) == cap)
 			return vsec;
 	}
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 24a83cf5ace8c..cd08d39fdb1ff 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1653,15 +1653,15 @@ static void pci_set_removable(struct pci_dev *dev)
 static bool pci_ext_cfg_is_aliased(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_QUIRKS
-	int pos;
+	int pos, ret;
 	u32 header, tmp;
 
 	pci_read_config_dword(dev, PCI_VENDOR_ID, &header);
 
 	for (pos = PCI_CFG_SPACE_SIZE;
 	     pos < PCI_CFG_SPACE_EXP_SIZE; pos += PCI_CFG_SPACE_SIZE) {
-		if (pci_read_config_dword(dev, pos, &tmp) != PCIBIOS_SUCCESSFUL
-		    || header != tmp)
+		ret = pci_read_config_dword(dev, pos, &tmp);
+		if ((ret != PCIBIOS_SUCCESSFUL) || (header != tmp))
 			return false;
 	}
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 321156ca273d5..91c34b05374ce 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5381,7 +5381,7 @@ int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
  */
 static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 {
-	int pos, i = 0;
+	int pos, i = 0, ret;
 	u8 next_cap;
 	u16 reg16, *cap;
 	struct pci_cap_saved_state *state;
@@ -5427,8 +5427,8 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 		pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
 
 		pdev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
-		if (pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status) !=
-		    PCIBIOS_SUCCESSFUL || (status == 0xffffffff))
+		ret = pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status);
+		if ((ret != PCIBIOS_SUCCESSFUL) || (PCI_POSSIBLE_ERROR(status)))
 			pdev->cfg_size = PCI_CFG_SPACE_SIZE;
 
 		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
-- 
2.42.0

