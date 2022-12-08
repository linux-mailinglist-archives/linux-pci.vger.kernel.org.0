Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2D06475E3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 20:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiLHTDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 14:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHTDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 14:03:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8608D8DFF3;
        Thu,  8 Dec 2022 11:03:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 263E0B825E5;
        Thu,  8 Dec 2022 19:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91283C433F0;
        Thu,  8 Dec 2022 19:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670526226;
        bh=94W/beXAHAD9dN/LgrT9hR5vmz5L5kct+KScNhLaOgQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HcYSMsmEkHd/IW97n6EKouw1E7Nt8jYTsp+VszEz3jMWmEOC5GapqO5WN+z4h2QjG
         eIaqsGBuwovVRMHzyCfu/pwtJvZ1SSFp2PPQCpblmnXFtKNkQdQKIds1m/wLQBaQub
         Fy7OVxVXN9npyNSuPFlnh9n0k9C2mvV6Wmwntnra8UjNS15W5plPx6tRK8iTJ5IDdE
         iKNzNqfNm5f6eBc2zizQ1oTOFnTYXOTthjs6RNSG5wYMYCypshylX4ZB33xPv6Xv3Y
         5SzUfYwlrLo3E8uE8onhAD2CsnD2etnqPilqJ8cFcUvJsWZ5zltvfbdV9TKa88B3cK
         D4nCFls88kvJA==
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
Subject: [PATCH v2 0/4] PCI: Continue E820 vs host bridge window saga
Date:   Thu,  8 Dec 2022 13:03:37 -0600
Message-Id: <20221208190341.1560157-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
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

When allocating space for PCI BARs, Linux avoids allocating space mentioned
in the E820 map.  This was originally done by 4dc2287c1805 ("x86: avoid
E820 regions when allocating address space") to work around BIOS defects
that included unusable space in host bridge _CRS.

Some recent machines use EfiMemoryMappedIO for PCI MMCONFIG and host bridge
apertures, and bootloaders and EFI stubs convert those to E820 regions,
which means we can't allocate space for hot-added PCI devices (often a
dock) or for devices the BIOS didn't configure (often a touchpad)

The current strategy is to add DMI quirks that disable the E820 filtering
on these machines and to disable it entirely starting with 2023 BIOSes:

  d341838d776a ("x86/PCI: Disable E820 reserved region clipping via quirks")
  0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting in 2023")

But the quirks are problematic because it's really hard to list all the
machines that need them.

This series is an attempt at a more generic approach.  I'm told by firmware
folks that EfiMemoryMappedIO means "the OS should map this area so EFI
runtime services can use it in virtual mode," but does not prevent the OS
from using it.

The first patch removes large EfiMemoryMappedIO areas from the E820 map.
This doesn't affect any virtual mapping of those areas (that would have to
be done directly from the EFI memory map) but it means Linux can allocate
space for PCI MMIO.

The rest are basically cosmetic log message changes.

Changes from v1 to v2:
- Remove only large (>= 256KB) EfiMemoryMappedIO areas from E820 to avoid
  the Lenovo X1 Carbon suspend/resume problems.  This machine includes
  64KB of non-window space in the PNP0A03 _CRS, and a corresponding
  EfiMemoryMappedIO area seems to be the only clue to avoid it (see
  https://bugzilla.redhat.com/show_bug.cgi?id=2029207).  Interdiff below.


Bjorn Helgaas (4):
  efi/x86: Remove EfiMemoryMappedIO from E820 map
  PCI: Skip allocate_resource() if too little space available
  x86/PCI: Tidy E820 removal messages
  x86/PCI: Fix log message typo

 arch/x86/kernel/resource.c  |  8 +++++--
 arch/x86/pci/acpi.c         |  2 +-
 arch/x86/platform/efi/efi.c | 46 +++++++++++++++++++++++++++++++++++++
 drivers/pci/bus.c           |  4 ++++
 4 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.25.1

  diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
  index 4728f60119da..dee1852e95cd 100644
  --- a/arch/x86/platform/efi/efi.c
  +++ b/arch/x86/platform/efi/efi.c
  @@ -315,8 +315,12 @@ static void __init efi_clean_memmap(void)
    * PCI host bridge windows, which means Linux can't allocate BAR space for
    * hot-added devices.
    *
  - * Remove any EfiMemoryMappedIO regions from the E820 map to avoid this
  + * Remove large EfiMemoryMappedIO regions from the E820 map to avoid this
    * problem.
  + *
  + * Retain small EfiMemoryMappedIO regions because on some platforms, these
  + * describe non-window space that's included in host bridge _CRS.  If we
  + * assign that space to PCI devices, they don't work.
    */
   static void __init efi_remove_e820_mmio(void)
   {
  @@ -327,11 +331,17 @@ static void __init efi_remove_e820_mmio(void)
	  for_each_efi_memory_desc(md) {
		  if (md->type == EFI_MEMORY_MAPPED_IO) {
			  size = md->num_pages << EFI_PAGE_SHIFT;
  -			start = md->phys_addr;
  -			end = start + size - 1;
  -			pr_info("Remove mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluMB) from e820 map\n",
  -				i, start, end, size >> 20);
  -			e820__range_remove(start, size, E820_TYPE_RESERVED, 1);
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
		  }
		  i++;
	  }
