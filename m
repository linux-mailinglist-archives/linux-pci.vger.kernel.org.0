Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628CC640FE0
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 22:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiLBVS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 16:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiLBVSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 16:18:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D573F75;
        Fri,  2 Dec 2022 13:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E641DCE1FBA;
        Fri,  2 Dec 2022 21:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8581C433C1;
        Fri,  2 Dec 2022 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670015926;
        bh=ubkFfiu5Wnnhs5ib/lclNCLynBsh33oIb0GlenBh+UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1Btn/vL5p35gOwKHoiCm8WQDttirgms2zGjwwU/ndnOUY96WabGqgLcHzPcAYf4a
         PXzk1gHcdUxMKKrb7ApFKVqUM5iRyPTdZ19dwhZm1Zol0VikITpNngYJYyrhxlbV7l
         3kKNjjR4VOCBgpOURKbkqJ5+C26iaz+PGC0088mVCcFAFuEqMB5gJVFNXeYybw/SWj
         CcL8svAVJSFUKv9OchGxOwabE8rehffMzEFqotkr9FhjJreJcub+Fd/I9KviVZjvpG
         dceJ/A9sIoo4xjs6wG0Oekui8aRBxRnshTP+KB9yZuj7xpqiF7P77qSPiQcIBwaEpB
         c1EwXgAUkpQjQ==
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
Subject: [PATCH 1/4] efi/x86: Remove EfiMemoryMappedIO from E820 map
Date:   Fri,  2 Dec 2022 15:18:35 -0600
Message-Id: <20221202211838.1061278-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202211838.1061278-1-helgaas@kernel.org>
References: <20221202211838.1061278-1-helgaas@kernel.org>
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

Remove any EfiMemoryMappedIO regions from the E820 map to avoid this
problem.

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
Reported-by: Florent DELAHAYE <kernelorg@undead.fr>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Konrad J Hambrick <kjhambrick@gmail.com>
Tested-by: Matt Hansen <2lprbe78@duck.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/platform/efi/efi.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index ebc98a68c400..4728f60119da 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -303,6 +303,40 @@ static void __init efi_clean_memmap(void)
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
+ * Remove any EfiMemoryMappedIO regions from the E820 map to avoid this
+ * problem.
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
+			start = md->phys_addr;
+			end = start + size - 1;
+			pr_info("Remove mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluMB) from e820 map\n",
+				i, start, end, size >> 20);
+			e820__range_remove(start, size, E820_TYPE_RESERVED, 1);
+		}
+		i++;
+	}
+}
+
 void __init efi_print_memmap(void)
 {
 	efi_memory_desc_t *md;
@@ -474,6 +508,8 @@ void __init efi_init(void)
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	efi_clean_memmap();
 
+	efi_remove_e820_mmio();
+
 	if (efi_enabled(EFI_DBG))
 		efi_print_memmap();
 }
-- 
2.25.1

