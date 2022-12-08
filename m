Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2E6475E6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 20:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLHTD4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 14:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLHTDx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 14:03:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7A8DFF3;
        Thu,  8 Dec 2022 11:03:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B43B4CE2682;
        Thu,  8 Dec 2022 19:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF5CC433EF;
        Thu,  8 Dec 2022 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670526228;
        bh=nOb1rqG+d8zAEK4Zjd64IrjJmxoyMzvK3YWdEydV4hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjOuOAxixZBCl04IjpGO52FgDvhWH4b8bah7zDSb5uxlbSrHT804XFcsokQR/GnW1
         8dwlbyq5TZj9EHDAl5LvJyQJAz/UaZflGUDInWSJxcPnby73b/R1BjbK/hJfT6hsEQ
         dLo1PngRDgnqgK+wNLIGjTQyt2Yqg2DUwGJPyfuDphY8JoJsfsphcyCvc10SYRmayn
         DLlLZ3zVJ2+b/EbBl0RSsQDJETBxE4t6totU/D/55Y5+PfzHMkJ7pWblSAUPpCmyHS
         qgtW72xKSVvfi+r/REtBsSbog33B5Yl0lWhssgOTxymiooLCHieA0kfEiCtTNtL8bk
         T0x0eGq0mi3Xg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/4] efi/x86: Remove EfiMemoryMappedIO from E820 map
Date:   Thu,  8 Dec 2022 13:03:38 -0600
Message-Id: <20221208190341.1560157-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208190341.1560157-1-helgaas@kernel.org>
References: <20221208190341.1560157-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Firmware can use EfiMemoryMappedIO to request that MMIO regions be mapped
by the OS so they can be accessed by EFI runtime services, but should have
no other significance to the OS (UEFI r2.10, sec 7.2).  However, most
bootloaders and EFI stubs convert EfiMemoryMappedIO regions to
E820_TYPE_RESERVED entries, which prevent Linux from allocating space from
them (see remove_e820_regions()).

Some platforms use EfiMemoryMappedIO entries for PCI MMCONFIG space and PCI
host bridge windows, which means Linux can't allocate BAR space for
hot-added devices.

Remove large EfiMemoryMappedIO regions from the E820 map to avoid this
problem.

Leave small (< 256KB) EfiMemoryMappedIO regions alone because on some
platforms, these describe non-window space that's included in host bridge
_CRS.  If we assign that space to PCI devices, they don't work.  On the
Lenovo X1 Carbon, this leads to suspend/resume failures.

The previous solution to the problem of allocating BARs in these regions
was to add pci_crs_quirks[] entries to disable E820 checking for these
machines (see d341838d776a ("x86/PCI: Disable E820 reserved region clipping
via quirks")):

  Acer   DMI_PRODUCT_NAME    Spin SP513-54N
  Clevo  DMI_BOARD_NAME      X170KM-G
  Lenovo DMI_PRODUCT_VERSION *IIL*

Florent reported the BAR allocation issue on the Clevo NL4XLU.  We could
add another quirk for the NL4XLU, but I hope this generic change can solve
it for many machines without having to add quirks.

This change has been tested on Clevo X170KM-G (Konrad) and Lenovo Ideapad
Slim 3 (Matt) and solves the problem even when overriding the existing
quirks by booting with "pci=use_e820".

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565     Clevo NL4XLU
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206459#c78 Clevo X170KM-G
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1868899    Ideapad Slim 3
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2029207    X1 Carbon
Reported-by: Florent DELAHAYE <kernelorg@undead.fr>
Tested-by: Konrad J Hambrick <kjhambrick@gmail.com>
Tested-by: Matt Hansen <2lprbe78@duck.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/platform/efi/efi.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index ebc98a68c400..dee1852e95cd 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -303,6 +303,50 @@ static void __init efi_clean_memmap(void)
 	}
 }
 
+/*
+ * Firmware can use EfiMemoryMappedIO to request that MMIO regions be
+ * mapped by the OS so they can be accessed by EFI runtime services, but
+ * should have no other significance to the OS (UEFI r2.10, sec 7.2).
+ * However, most bootloaders and EFI stubs convert EfiMemoryMappedIO
+ * regions to E820_TYPE_RESERVED entries, which prevent Linux from
+ * allocating space from them (see remove_e820_regions()).
+ *
+ * Some platforms use EfiMemoryMappedIO entries for PCI MMCONFIG space and
+ * PCI host bridge windows, which means Linux can't allocate BAR space for
+ * hot-added devices.
+ *
+ * Remove large EfiMemoryMappedIO regions from the E820 map to avoid this
+ * problem.
+ *
+ * Retain small EfiMemoryMappedIO regions because on some platforms, these
+ * describe non-window space that's included in host bridge _CRS.  If we
+ * assign that space to PCI devices, they don't work.
+ */
+static void __init efi_remove_e820_mmio(void)
+{
+	efi_memory_desc_t *md;
+	u64 size, start, end;
+	int i = 0;
+
+	for_each_efi_memory_desc(md) {
+		if (md->type == EFI_MEMORY_MAPPED_IO) {
+			size = md->num_pages << EFI_PAGE_SHIFT;
+			if (size >= 256*1024) {
+				start = md->phys_addr;
+				end = start + size - 1;
+				pr_info("Remove mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluMB) from e820 map\n",
+					i, start, end, size >> 20);
+				e820__range_remove(start, size,
+						   E820_TYPE_RESERVED, 1);
+			} else {
+				pr_info("Not removing mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluKB) from e820 map\n",
+					i, start, end, size >> 10);
+			}
+		}
+		i++;
+	}
+}
+
 void __init efi_print_memmap(void)
 {
 	efi_memory_desc_t *md;
@@ -474,6 +518,8 @@ void __init efi_init(void)
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	efi_clean_memmap();
 
+	efi_remove_e820_mmio();
+
 	if (efi_enabled(EFI_DBG))
 		efi_print_memmap();
 }
-- 
2.25.1

