Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E654B5472
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355741AbiBNPTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 10:19:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355750AbiBNPTA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 10:19:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36C555A5BC
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 07:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644851931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qtxii3fDgLz/BjfAaX9vX0zo678hl9XTBNM9+pp5Auk=;
        b=ifqS2dm4XeI0Dt7lCwcHBP0dVJlfg1CuWCwNC0dEaPRp8yd4eC0B+kc/J/a07/J58iNbE2
        tHlGvom/3MqJGH/17koO49TTAfjN0sf9UMHB/pGol3PX3HXLnbgk1DaEtOb+Xylpt7hnOb
        1wcw5FIjr/0/9UReGjckU16/tIh4gts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-ywGxEZJ_MfqW6Ba62kVU-A-1; Mon, 14 Feb 2022 10:18:46 -0500
X-MC-Unique: ywGxEZJ_MfqW6Ba62kVU-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E9C22F25;
        Mon, 14 Feb 2022 15:18:44 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F2AD2B598;
        Mon, 14 Feb 2022 15:18:24 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 2/2] x86/PCI: Ignore EFI memmap MMIO entries
Date:   Mon, 14 Feb 2022 16:17:59 +0100
Message-Id: <20220214151759.98267-3-hdegoede@redhat.com>
In-Reply-To: <20220214151759.98267-1-hdegoede@redhat.com>
References: <20220214151759.98267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Linux excludes E820 reserved addresses when allocating addresses from the
PCI host bridge window. This behavior is needed for at least 2 reasons:

1. Some BIOS-es contain a bug where they add addresses which map to system
RAM in the PCI host bridge window returned by the ACPI _CRS method, see
commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
space").

2. At least the Lenovo X1 carbon gen 2 BIOS has an overlap between an
E820 reserved range and the ACPI _CRS providing the PCI bridge windows:
 BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
 pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
then the system fails to resume after a suspend.

Recently (2019) some systems have shown-up with EFI memmap MMIO entries
covering the entire _CRS returned PCI bridge memory window. These memmap
entries get converted into e820_table entries, causing all attempts to
assign memory to PCI BARs which have not been setup by the BIOS to fail.
For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:

 efi: mem63: [MMIO   |RUN|  |  |  |  |  |  |  |  |   |  |  |  |UC] range=
     [0x0000000065400000-0x00000000cfffffff] (1708MB)
 [mem 0x000000004bc50000-0x00000000cfffffff] reserved
 pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
 pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
 pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]

Since the problem is specifically caused by EFI memmap entries with
a MMIO type, use the new E820_TYPE_MMIO marking of e820 entries
translated from MMIO EFI memmap entries to skip these entries when
excluding e820 reservations in arch_remove_reservations(), fixing the
problem of not being able to find free space for unassigned BARs.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2029207
BugLink: https://bugs.launchpad.net/bugs/1878279
BugLink: https://bugs.launchpad.net/bugs/1931715
BugLink: https://bugs.launchpad.net/bugs/1932069
BugLink: https://bugs.launchpad.net/bugs/1921649
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/kernel/resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 9b9fb7882c20..bd501f787a10 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -31,6 +31,10 @@ static void remove_e820_regions(struct resource *avail)
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 
+		/* Some fw reserves the entire PCI bridge window as MMIO */
+		if (entry->type == E820_TYPE_MMIO)
+			continue;
+
 		resource_clip(avail, entry->addr,
 			      entry->addr + entry->size - 1);
 	}
-- 
2.33.1

