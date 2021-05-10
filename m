Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7192F379ACF
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 01:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhEJXh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 19:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhEJXhY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 19:37:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B88C061574;
        Mon, 10 May 2021 16:36:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v6so22872321ljj.5;
        Mon, 10 May 2021 16:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKKW+K0dIdsjUJHAnndSYglrw3/aTncWjvYhS3w4Trg=;
        b=IaARyqKetclXdh5XbI4ONYrT/JVdndL0jie0/m3ZlTyGKmtDzmEM0h0R6kJ5rmT+cI
         DvC5O1jbjeRg34VPKlblUDymxwrJlEkSFtOPYBf8/nyhiwcrDC3b9MoRi7N3/MhciKnu
         NRwXpVd/abtzxEO1wnYfDXEAdNSL4Lxz9lqBGqqQCvyVov+P51abf7jU0KE4WBmZ0Z30
         kTaqJylnwhn2/W0isEwM/aHv+Zh01xxTQteKes0PGv87zXOoLDRo7xtQWATSA5Pp/BCA
         n3jm5Rp0CCAWkom+Cgf5Ut91RvEFWZYR6Ai9pCJGukij+P2MpOHBeJ66iPTzattI6Hks
         Nr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKKW+K0dIdsjUJHAnndSYglrw3/aTncWjvYhS3w4Trg=;
        b=NzPExFOF5mbzaBHhor3UUVajRg3DnbORqR+S8R350cm/5RsCxRk5WizSrvdzAZfzhg
         vk5infRMK3p6HgzS30vkdxJywzBnRaD/y8JigGylPxwuhSEdPvEy5SDruMhtbAozihoR
         N7f5WZMfnfN8uTUubSx2Ffj4JP+skylmpdiZSznTBgrK4YiM7jLEMuO90f0Wc8ij980m
         HkTDyTDeY04oi/2S/vL90Evw6mnyfEBtOwMbp9dP3n39EtQo0C3UGjsIUrM2LTsffQNt
         hyz59QgTXC9uXuWovcv4Rlw9dQWc5LifnPkz0IkcrrmM4Kf508y8RvfZv1h3JUcgNDvW
         WYGw==
X-Gm-Message-State: AOAM530LkCWEUmIjexhyBh9MajohZBLTsDyvkT24dldu+0aojibMkj5T
        1FNubJwvgDUYoUL8BRp1uBs=
X-Google-Smtp-Source: ABdhPJwwFZdsy+kgOUzcZ0jND70n4Tg4BvLOOt7Fhi+No+nuR4qT7zrwEb/nnFNWv9ZPmOL2LYp3Tg==
X-Received: by 2002:a2e:9782:: with SMTP id y2mr21349914lji.303.1620689777422;
        Mon, 10 May 2021 16:36:17 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id w21sm349247lfu.174.2021.05.10.16.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 16:36:16 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: 
Date:   Tue, 11 May 2021 01:35:49 +0200
Message-Id: <20210510233549.1329706-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subject: [PATCH] Revert "arm64: PCI: Exclude ACPI "consumer" resources from
 host bridge windows"

The Microsoft Surface Pro X has host bridges defined as

    Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
    Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID

    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
    {
        Name (RBUF, ResourceTemplate ()
        {
            Memory32Fixed (ReadWrite,
                0x60200000,         // Address Base
                0x01DF0000,         // Address Length
                )
            WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                0x0000,             // Granularity
                0x0000,             // Range Minimum
                0x0001,             // Range Maximum
                0x0000,             // Translation Offset
                0x0002,             // Length
                ,, )
        })
        Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
    }

meaning that the memory resources aren't (explicitly) defined as
"producers", i.e. host bridge windows.

Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
host bridge windows") introduced a check that removes such resources,
causing BAR allocation failures later on:

    [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
    [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
    [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
    [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]

This eventually prevents the PCIe NVME drive from being accessible.

On x86 we already skip the check for producer/window due to some history
with negligent firmware. It seems that Microsoft is intent on continuing
that history on their ARM devices, so let's drop that check here too.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Please note: I am not sure if this is the right way to fix that, e.g. I
don't know if any additional checks like on IA64 or x86 might be
required instead, or if this might break things on other devices. So
please consider this more as a bug report rather than a fix.

---
 arch/arm64/kernel/pci.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c60..80f87fe0a2b8 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -94,19 +94,6 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	return 0;
 }
 
-static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
-{
-	struct resource_entry *entry, *tmp;
-	int status;
-
-	status = acpi_pci_probe_root_resources(ci);
-	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
-		if (!(entry->res->flags & IORESOURCE_WINDOW))
-			resource_list_destroy_entry(entry);
-	}
-	return status;
-}
-
 /*
  * Lookup the bus range for the domain in MCFG, and set up config space
  * mapping.
@@ -184,7 +171,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	}
 
 	root_ops->release_info = pci_acpi_generic_release_info;
-	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
 	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
-- 
2.31.1

