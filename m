Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37C4CCC64
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 04:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiCDDxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 22:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiCDDxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 22:53:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D317F6AF;
        Thu,  3 Mar 2022 19:52:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1D561AB8;
        Fri,  4 Mar 2022 03:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B743AC340F0;
        Fri,  4 Mar 2022 03:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646365938;
        bh=75N+jcmKzyM15eD5aiw09cfBllrrBCD9pGfIotildII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKgomiKxjAbEBYHFRqv8oZyBrDoEinlAxLe1VGVFAwtZw0nu5Ru8XsWX7+upw4bVk
         hg8kU2Q6BwdOJUPPzAZWFmeTW3W7qIhgcJC1MdZTCA7RLLGeyv6BWLF7sKTiRQm+UV
         Kyl1OsUbExBTMwX0UgifFG9l5gv4slkKwQg9djZ4cGaNUBQxJxUWcdHrU/WpkEGw50
         I7Z7RV7IBsMUra0wNZpkILMe8EEIrwNczcKXBrx0FTgZzQACc4WoYKfgALAT3gEtRq
         2lqqjrZW9tY2T3x82Oz+jQ1nnVWixoqi4nNTWzbOH6hzpI3YhrQYlJn3YvO9cCe8P5
         XWLUMkEBLejkQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wse@tuxedocomputers.com
Subject: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely covered by E820
Date:   Thu,  3 Mar 2022 21:51:11 -0600
Message-Id: <20220304035110.988712-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304035110.988712-1-helgaas@kernel.org>
References: <20220304035110.988712-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Many folks have reported PCI devices not working.  It could affect any
device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.

In every report, a region in the E820 table entirely encloses a PCI host
bridge window from _CRS, and because of 4dc2287c1805 ("x86: avoid E820
regions when allocating address space"), we ignore the entire window,
preventing us from assigning space to PCI devices.

For example, the dmesg log [2] from bug report [1] shows:

  BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
  pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]

The efi=debug dmesg log [3] from the same report shows the EFI memory map
entries that created the E820 map:

  efi: mem47: [Reserved |   |WB|WT|WC|UC] range=[0x4bc50000-0x5fffffff]
  efi: mem48: [Reserved |   |WB|  |  |UC] range=[0x60000000-0x60ffffff]
  efi: mem49: [Reserved |   |  |  |  |  ] range=[0x61000000-0x653fffff]
  efi: mem50: [MMIO     |RUN|  |  |  |UC] range=[0x65400000-0xcfffffff]

4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
works around issues where _CRS contains non-window address space that can't
be used for PCI devices.  It does this by removing E820 regions from host
bridge windows.  But in these reports, the E820 region covers the entire
window, so 4dc2287c1805 makes it completely unusable.

Per UEFI v2.8, sec 7.2, the EfiMemoryMappedIO type means:

  Used by system firmware to request that a memory-mapped IO region be
  mapped by the OS to a virtual address so it can be accessed by EFI
  runtime services.

A host bridge window is definitely a memory-mapped IO region, and EFI
runtime services may need to access it, so I don't think we can argue that
this is a firmware defect.

Instead, change the 4dc2287c1805 strategy so it only removes E820 regions
when they overlap *part* of a host bridge window on the assumption that a
partial overlap is really register space, not part of the window proper.

If an E820 region covers the entire window from _CRS, assume the _CRS
window is correct and do nothing.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1868899
[2] https://bugzilla.redhat.com/attachment.cgi?id=1711424
[3] https://bugzilla.redhat.com/attachment.cgi?id=1861407

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214259
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
BugLink: https://bugs.launchpad.net/bugs/1878279
BugLink: https://bugs.launchpad.net/bugs/1931715
BugLink: https://bugs.launchpad.net/bugs/1932069
BugLink: https://bugs.launchpad.net/bugs/1921649
Fixes: 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
Link: https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redhat.com
Based-on-patch-by: Hans de Goede <hdegoede@redhat.com>
Reported-by: Benoit Grégoire <benoitg@coeus.ca>   # BZ 206459
Reported-by: wse@tuxedocomputers.com              # BZ 214259
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/kernel/resource.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 7378ea146976..405f0af53e3d 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -39,6 +39,17 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
 		e820_start = entry->addr;
 		e820_end = entry->addr + entry->size - 1;
 
+		/*
+		 * If an E820 entry covers just part of the resource, we
+		 * assume E820 is telling us about something like host
+		 * bridge register space that is unavailable for PCI
+		 * devices.  But if it covers the *entire* resource, it's
+		 * more likely just telling us that this is MMIO space, and
+		 * that doesn't need to be removed.
+		 */
+		if (e820_start <= avail->start && avail->end <= e820_end)
+			continue;
+
 		resource_clip(avail, e820_start, e820_end);
 		if (orig.start != avail->start || orig.end != avail->end) {
 			dev_info(dev, "clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
-- 
2.25.1

