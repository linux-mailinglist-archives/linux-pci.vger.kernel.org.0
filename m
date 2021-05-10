Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3921379ADD
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 01:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhEJXlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 19:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhEJXlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 19:41:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247E0C061574;
        Mon, 10 May 2021 16:40:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w15so22856105ljo.10;
        Mon, 10 May 2021 16:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4x0vN9DJqs7gJDwDfxyEg064VHqNhSWYWI838BdyA6Y=;
        b=bv+qY0q2mO9tHNg79PZMj8hkZ9C8rxnsgQTKmo/G7H1nlKCoAMKWz7Bw0X25Cou4jU
         IknSAu6Jq8pZ0M5/91i+w6wG4XX8btm6dMQ4QFmGR0GTRhQmZhLliRXUAc68CBtoLBMI
         ZLLX7kJV2Ld+if87BOnwOGqel6FQy3k1Knai6gSjVXUWyvNVwKauZp1dvovV0JEEoyP4
         mhjO8CFhNjZcmPzwVRv/e7dLqnoxbrqGKHCwXpJQFAX+vMR6ajjmjV5EVsLMhxyVDc+d
         5LxZ/932j4mszXXmeMlynvNsST6XOZQer9Fkk/r4ycNUG4aa4q957Zd9eyp6g63OCS/C
         6LoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4x0vN9DJqs7gJDwDfxyEg064VHqNhSWYWI838BdyA6Y=;
        b=QcPkAQMYd7tM5t30Mda+qYjjFvq3l7UqPnG37y7pb4+Eymz7FpSfglS08tCGMybkvx
         XsqPGT+3ktnhAwVrxnb0VDh4EwoteapVa4+DtjeI6dE2+rSDfy16z0Gp1PVSCg1Qgo0P
         /8tKn55X7csDXxx7BzacxhXrz7RzSANu6IoSVOkhxkbUcI0oYL0gUp9lvRZNf0WiVnIC
         t1sYzv3FOPeI14tJzuPvDJjJDzBe0R7SrAVGpyeFMBAC3O1LQVHe6pzHfr5YiE3thdjd
         CvWg2JQyQSq8gvHg0ZYQpAp/MNOuDTZ2dnFjH8Jihv9T3gLoZXDCpzsnYsd0eLq5ijsR
         y9eQ==
X-Gm-Message-State: AOAM532a11OoF5pjN2dar8Mjhw0p1yhD08FYCI0CBjH4ST0DgPYiFIrh
        uqFOrVC1Gv15drRpeNeuOqU=
X-Google-Smtp-Source: ABdhPJzQrUm5bDZEPSU5ieS3hk7r8BouKV4qqzcZDrrRCosV82J5oK0C5TjXP9oalqSbpSSxLWqE+Q==
X-Received: by 2002:a2e:9b82:: with SMTP id z2mr19980857lji.366.1620690038713;
        Mon, 10 May 2021 16:40:38 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id z12sm2398926lfe.195.2021.05.10.16.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 16:40:38 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Revert "arm64: PCI: Exclude ACPI "consumer" resources from host bridge windows"
Date:   Tue, 11 May 2021 01:40:20 +0200
Message-Id: <20210510234020.1330087-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

Apologies for the re-send, I seem to have unintentionally added a blank
line before the subject.

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

