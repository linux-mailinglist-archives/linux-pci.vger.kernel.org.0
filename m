Return-Path: <linux-pci+bounces-40791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4DCC4994B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77841188FE23
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5DB341AAE;
	Mon, 10 Nov 2025 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNFz9FBi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C381534165B;
	Mon, 10 Nov 2025 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813791; cv=none; b=RHickX1kW7NtNHE7lgeqebFx1aP+xAXucdacs5efGTHk0XldUgjJMuQt2TU4LNyn0fly4GK0Itokwokslp9wnioaZwC7cBZ0MbRuYVMu/fOiqaIKm7n8/0XB6+fq4N9JGHyrRtrDMVskljvYjEEOERazK0+YAYtwJtsYgGSOWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813791; c=relaxed/simple;
	bh=Gx7BkbwEI9+5WMZh15d9ZFjuWteQ62dZWggKcssX+Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKQAaTVXRTsfhKGtP57qxchh6XFkvqyGAoned7IRNRSUXWE6Of8tkNbCF4nxCrwvEmtfmiVAtLZZyECNRI0ZgIde+PjeBlq7SuMSAiVfPe/BrdyWHJjw1UwQ3jyBEBDT+e6Z+kKh9J9lFLJtBZ5L6lZWLBmNEsV8N0xJC+0yAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNFz9FBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B33C19424;
	Mon, 10 Nov 2025 22:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762813791;
	bh=Gx7BkbwEI9+5WMZh15d9ZFjuWteQ62dZWggKcssX+Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNFz9FBih/mYXpq/gsNbwuNA74zWvSFiptmRL1aT9H7fmgR+AFRr7VHDJna3cTTsK
	 C8vz+5GBsnr5erRIT+t8B+7s4T2X2jIFbtPetV87/Fs3XvgQNZkRHWaQ8nRnk26Gp4
	 7NgoTQ1DUIU/NZJwo9yXv1T0/FMjvQBjE5FEFd07v0U3l7Hy0ht8tYrS4d0FHCowU+
	 /3L6Mxev64P4A8k6nA/3ZQlXjp5LgVQHFhgSZNszuypiiPwRM6rLZ4O/MJpCPcdeNA
	 KJse0nccDJGUwCAkx5wdnFC6FPX3yVsTlqW1x9+7csvBnZ1bGWByyL0Ef9bFHt+q0s
	 ThKIm+vwz3Xdg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>,
	Al <al@datazap.net>,
	Roland <rol7and@gmx.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/4] PCI/ASPM: Convert quirks to override advertised link states
Date: Mon, 10 Nov 2025 16:22:27 -0600
Message-ID: <20251110222929.2140564-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110222929.2140564-1-helgaas@kernel.org>
References: <20251110222929.2140564-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Existing quirks to disable ASPM L0s and L1 use pci_disable_link_state(),
which disables ASPM states and prevents their use in the future.  But since
they are FINAL quirks, they happen after ASPM has already been enabled.
Here's a typical call path:

  pci_host_probe
    pci_scan_root_bus_bridge
      pci_scan_child_bus
        pci_scan_slot
          pci_scan_single_device
            pci_device_add
              pci_fixup_device(pci_fixup_header)  # HEADER quirks
          pcie_aspm_init_link_state
            pcie_config_aspm_path
              pcie_config_aspm_link
                pcie_config_aspm_dev              # ASPM may be enabled
    pci_bus_add_devices
      pci_bus_add_devices
        pci_fixup_device(pci_fixup_final)         # FINAL quirks
          quirk_disable_aspm_l0s
            pci_disable_link_state(dev, PCIE_LINK_STATE_L0S)

Sometimes enabling ASPM can make the link non-functional, so if we know
ASPM is broken on a device, we shouldn't enable it at all, even
temporarily.

Convert the existing quirks to use pcie_aspm_remove_cap() instead, which
overrides the ASPM Support advertised in PCIe Link Capabilities, and make
them HEADER quirks so they run before pcie_aspm_init_link_state() has a
chance to enable ASPM.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..922c77c627a1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2494,28 +2494,27 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
  */
 static void quirk_disable_aspm_l0s(struct pci_dev *dev)
 {
-	pci_info(dev, "Disabling L0s\n");
-	pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
+	pcie_aspm_remove_cap(dev, PCI_EXP_LNKCAP_ASPM_L0S);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10a7, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10a9, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10b6, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10c6, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10c7, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10c8, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10d6, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10db, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10dd, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10e1, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10ec, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10a7, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10a9, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10b6, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10c6, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10c7, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10c8, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10d6, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10db, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10dd, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10e1, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10ec, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
 
 static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
 {
-	pci_info(dev, "Disabling ASPM L0s/L1\n");
-	pci_disable_link_state(dev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
+	pcie_aspm_remove_cap(dev,
+			     PCI_EXP_LNKCAP_ASPM_L0S | PCI_EXP_LNKCAP_ASPM_L1);
 }
 
 /*
@@ -2523,7 +2522,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  * upstream PCIe root port when ASPM is enabled. At least L0s mode is affected;
  * disable both L0s and L1 for now to be safe.
  */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
-- 
2.43.0


