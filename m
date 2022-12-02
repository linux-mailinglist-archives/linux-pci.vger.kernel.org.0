Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A74E640FDD
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 22:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiLBVS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 16:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiLBVSv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 16:18:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F65915A;
        Fri,  2 Dec 2022 13:18:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900C8623D6;
        Fri,  2 Dec 2022 21:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA10C433D6;
        Fri,  2 Dec 2022 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670015925;
        bh=2rrX47NWa70VI8AqxvMAoJDdj+in56xV4jYSGcyJcbo=;
        h=From:To:Cc:Subject:Date:From;
        b=d4qTFc/f72OMYxi/1HZE0CdQFKVlgLXIQsf6tAbNbpLXfL/lJBiriy9Skujf59U/l
         UTDzQnx5ZAY1+ZeCHAeTueZVZwJG3MpPXzmAnjFtm+rxxzsWuPtng1ikgX6s9D1U9k
         7tk1HQdZIhZCURQkfR9xlVfsZ1IxOZXND7fKXaLauWlAtasxRdI0t762JdMwYay7Mv
         SYxaVcGFm9XnsMlsPSCdH59mEBmngBdsR2ynwvKt3bV6FQI6t+PVDg7NmhkA0VveWW
         3tzTlcIsad84rsaDJJd9vI4bQ+Wwa+xJHXHXiqGi+V6pauXAyoXc4qTuK4jI8VPOf8
         Sz/xgLOG0MGig==
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
Subject: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
Date:   Fri,  2 Dec 2022 15:18:34 -0600
Message-Id: <20221202211838.1061278-1-helgaas@kernel.org>
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

The first patch removes any EfiMemoryMappedIO areas from the E820 map.
This doesn't affect any virtual mapping of those areas (that would have to
be done directly from the EFI memory map) but it means Linux can allocate
space for PCI MMIO.

The rest are basically cosmetic log message changes.

Bjorn Helgaas (4):
  efi/x86: Remove EfiMemoryMappedIO from E820 map
  PCI: Skip allocate_resource() if too little space available
  x86/PCI: Tidy E820 removal messages
  x86/PCI: Fix log message typo

 arch/x86/kernel/resource.c  |  7 +++++--
 arch/x86/pci/acpi.c         |  2 +-
 arch/x86/platform/efi/efi.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/pci/bus.c           |  4 ++++
 4 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.25.1

