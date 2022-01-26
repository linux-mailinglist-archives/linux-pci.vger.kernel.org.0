Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493E349CEC2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 16:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbiAZPkT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 10:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243019AbiAZPkQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 10:40:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A2C06161C;
        Wed, 26 Jan 2022 07:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ECB46194F;
        Wed, 26 Jan 2022 15:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1864C340E3;
        Wed, 26 Jan 2022 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211615;
        bh=07/MIz8fKzhFCCwBfpvqCou3XnqmFxByCSYEulgW10Y=;
        h=From:To:Cc:Subject:Date:From;
        b=XptR4jlYs3Qr0ObepVT4rVv9NF1gMCB3lwPa04JnyftMfCmJCVczvxA2AJphqNrfx
         gll2dSP1hFbsupvnvp5ToX7/OpFyvlQ/QZyttGXDbTUVVUVS7opmZTtx1wS4MOodXj
         HCIzGoAWCcJvqmmdvxH0wjIZOgNBQWhjg4p91E+iuf4V0NEhSq0nHxQsxw53/xkp6i
         og5yltCoFP0kzR6FBDv0bnRyXJzwHjTBwh+u2OUCPEJ2DhpEr02JD1EaJ63i7JqMiv
         R9O4+5dXGKYHcCHAh+Z97x8rNTw0AYAVTVtr3i/xgqtayUC6Dhh0A1pQzHdXmUFyEe
         L01xklJmtuHwg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ia64@vger.kernel.org, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v1] PCI/sysfs: Find shadow ROM before static attribute initialization
Date:   Wed, 26 Jan 2022 09:40:01 -0600
Message-Id: <20220126154001.16895-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Ville reported that the sysfs "rom" file for VGA devices disappeared after
527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute").

Prior to 527139d738d7, FINAL fixups, including pci_fixup_video() where we
find shadow ROMs, were run before pci_create_sysfs_dev_files() created the
sysfs "rom" file.

After 527139d738d7, "rom" is a static attribute and is created before FINAL
fixups are run, so we didn't create "rom" files for shadow ROMs:

  acpi_pci_root_add
    ...
      pci_scan_single_device
        pci_device_add
          pci_fixup_video                    # <-- new HEADER fixup
          device_add
            ...
              if (grp->is_visible())
                pci_dev_rom_attr_is_visible  # after 527139d738d7
    pci_bus_add_devices
      pci_bus_add_device
        pci_fixup_device(pci_fixup_final)
          pci_fixup_video                    # <-- previous FINAL fixup
        pci_create_sysfs_dev_files
          if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
            sysfs_create_bin_file("rom")     # before 527139d738d7

Change pci_fixup_video() to be a HEADER fixup so it runs before sysfs
static attributes are initialized.

Rename the Loongson pci_fixup_radeon() to pci_fixup_video() and make its
dmesg logging identical to the others since it is doing the same job.

Fixes: 527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
Link: https://lore.kernel.org/r/YbxqIyrkv3GhZVxx@intel.com
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Krzysztof Wilczyński <kw@linux.com>
---
 arch/ia64/pci/fixup.c              | 4 ++--
 arch/mips/loongson64/vbios_quirk.c | 9 ++++-----
 arch/x86/pci/fixup.c               | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index acb55a41260d..2bcdd7d3a1ad 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -76,5 +76,5 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		}
 	}
 }
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
-				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID,
+			       PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
diff --git a/arch/mips/loongson64/vbios_quirk.c b/arch/mips/loongson64/vbios_quirk.c
index 9a29e94d3db1..3115d4de982c 100644
--- a/arch/mips/loongson64/vbios_quirk.c
+++ b/arch/mips/loongson64/vbios_quirk.c
@@ -3,7 +3,7 @@
 #include <linux/pci.h>
 #include <loongson.h>
 
-static void pci_fixup_radeon(struct pci_dev *pdev)
+static void pci_fixup_video(struct pci_dev *pdev)
 {
 	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
 
@@ -22,8 +22,7 @@ static void pci_fixup_radeon(struct pci_dev *pdev)
 	res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
 		     IORESOURCE_PCI_FIXED;
 
-	dev_info(&pdev->dev, "BAR %d: assigned %pR for Radeon ROM\n",
-		 PCI_ROM_RESOURCE, res);
+	dev_info(&pdev->dev, "Video device with shadowed ROM at %pR\n", res);
 }
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, 0x9615,
-				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_radeon);
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, 0x9615,
+			       PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 2edd86649468..615a76d70019 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -353,8 +353,8 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		}
 	}
 }
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
-				PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID,
+			       PCI_CLASS_DISPLAY_VGA, 8, pci_fixup_video);
 
 
 static const struct dmi_system_id msi_k8t_dmi_table[] = {
-- 
2.25.1

