Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080427E43E8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbjKGPsp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjKGPsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:48:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4410FB;
        Tue,  7 Nov 2023 07:47:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A630C433C7;
        Tue,  7 Nov 2023 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372071;
        bh=SrcMRQiH6AX+pDJ4taijGZpJamQAjKQC4QHHC5HnaMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChIsLCm7CPKnk7GHZzGvpM8TnxxAkZ/oDdnf5oBQxFXUEgxD5zkbWTYc6b2bPId7F
         LnwxQw5gsXRvzEA/GO2zdrXHllcO43P02w4iT5UX9JASIAI6MtrfJdLd3kkzzrwB5s
         AB3aWshIPMxpYMVueOhvjgycQxcLLF52oMGT5M4ZeoXuMsyAwIWFZ0PO4bnqQlnddM
         Dzc3zWErtgzBLJVzvwwMtff/MxAxx9IelBJrcuvYVhlMxNQvYV3w0Ycf51X5c9bvHN
         s0AuWxXsOCnncSZ7/bBrPjQ3fBBcZcdrdMPTlecn/HB6/iXn87QPSbQ0jFw3/V0CpA
         9w5NVOxPkjaNg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/36] PCI: Do error check on own line to split long "if" conditions
Date:   Tue,  7 Nov 2023 10:46:05 -0500
Message-ID: <20231107154654.3765336-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
index 59c01d68c6d5e..5e51e8bd5c13a 100644
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
index 795534589b985..43159965e09e9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1652,15 +1652,15 @@ static void pci_set_removable(struct pci_dev *dev)
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
index eeec1d6f90238..f5fc92441194d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5383,7 +5383,7 @@ int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
  */
 static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 {
-	int pos, i = 0;
+	int pos, i = 0, ret;
 	u8 next_cap;
 	u16 reg16, *cap;
 	struct pci_cap_saved_state *state;
@@ -5429,8 +5429,8 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
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

