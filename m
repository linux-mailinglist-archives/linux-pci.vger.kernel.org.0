Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5463C1A1E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 04:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfI3CJM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Sep 2019 22:09:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39518 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbfI3CJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Sep 2019 22:09:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so3274482plp.6
        for <linux-pci@vger.kernel.org>; Sun, 29 Sep 2019 19:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpdB7/NTd3wtvGApi+SbwzoSWGyyJYFNhOXdPw30ujU=;
        b=uSdLpYVJI6agqhIuFFc4HJVODoORgxFLSHEYcs3h5PWTlzvNM38KyCuA3zuniy92Gm
         0S1yVfu+E3c3jS9CSgQboR+fQEObkxkoQDodLfnczAQVKswxCqEdc84kLOjJb7Y+4gTT
         hUx2CFIW1GT7FuQZ4bEO+FwWOjlmRvMvy30OEfxtP83zMi5J92mIsTcaT8Yg0iAxDc18
         vn7icu7d2alBoSA6xCNEHb+AIOP84KwDeZvnwDByYGITxVyVgUdSN4sOr3NW+9NdjrvI
         ZoCOp6vVtARf+jf7Df3HZFQ6hfSAgnhCimUws6ZDXA6SkVY/MIaNe0N2kstXVNdxClhv
         ORSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpdB7/NTd3wtvGApi+SbwzoSWGyyJYFNhOXdPw30ujU=;
        b=JGw+4rbUGPrEfNGEn01TSUcoOK9FAYd4MU/SlCi51f/cmRDVvcI0WJsJ78LV8CP881
         tpTxoG5dDZwT295+Kc0QdvhLfwVSleVzofTd/5iyimS7/4FgqPYJwXOHjx4oyjWVhgNK
         1m8aFFevTutiED6zGBrKyvqM+S3Y5PxD1D36UL53BID0TcQuhhJX+0+BtQp2uIs/jqXR
         Zk6/th1DyeDzP6dykS4pC39qCjjnID0siG3OR4667mja5GgBWiWVUTlHW0alE/wcsiuy
         YTet94cM+8pKfZit3jKNBMKU+WrgUCe6jLBW6YiFlUbR+u6ILvkPe7F9b8aob+Rvq/qL
         ID+A==
X-Gm-Message-State: APjAAAUXzfinsCJYoHsADHkFgRBddxAOGwNcTeYuP2PZr64ICqX1vmfN
        ROEypnaPw7Law19LVgo8OAw=
X-Google-Smtp-Source: APXvYqzkHaoeDmSN7IhITXbXlspuHGKFl8/ESO8gCTP8d/M8lRKpa0zl41o5kYYshR3e5JSieRd/sA==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4mr16891124pls.142.1569809350280;
        Sun, 29 Sep 2019 19:09:10 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id x72sm11450733pfc.89.2019.09.29.19.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 19:09:09 -0700 (PDT)
From:   Oliver O'Halloran <oohall@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     aik@ozlabs.ru, shawn@anastas.io, linux-pci@vger.kernel.org,
        Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 3/3] powerpc/pci: Remove pcibios_setup_bus_devices()
Date:   Mon, 30 Sep 2019 12:08:48 +1000
Message-Id: <20190930020848.25767-4-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930020848.25767-1-oohall@gmail.com>
References: <20190930020848.25767-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With the previous patch applied pcibios_setup_device() will always be run
when pcibios_bus_add_device() is called. There are several code paths where
pcibios_setup_bus_device() is still called (the PowerPC specific PCI
hotplug support is one) so with just the previous patch applied the setup
can be run multiple times on a device, once before the device is added
to the bus and once after.

There's no need to run the setup in the early case any more so just
remove it entirely.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/pci.h    |  1 -
 arch/powerpc/kernel/pci-common.c  | 25 -------------------------
 arch/powerpc/kernel/pci-hotplug.c |  1 -
 arch/powerpc/kernel/pci_of_scan.c |  1 -
 4 files changed, 28 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 327567b..63ed7e3 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -113,7 +113,6 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 pgprot_t prot);
 
 extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
-extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
 extern void pcibios_scan_phb(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b89925ed..f8a59d7 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1000,24 +1000,6 @@ int pcibios_add_device(struct pci_dev *dev)
 	return 0;
 }
 
-void pcibios_setup_bus_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pr_debug("PCI: Fixup bus devices %d (%s)\n",
-		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/* Cardbus can call us to add new devices to a bus, so ignore
-		 * those who are already fully discovered
-		 */
-		if (pci_dev_is_added(dev))
-			continue;
-
-		pcibios_setup_device(dev);
-	}
-}
-
 void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
@@ -1036,13 +1018,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-void pci_fixup_cardbus(struct pci_bus *bus)
-{
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
-}
-
-
 static int skip_isa_ioresource_align(struct pci_dev *dev)
 {
 	if (pci_has_flag(PCI_CAN_SKIP_ISA_ALIGN) &&
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index fc62c4b..d6a67f8 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -134,7 +134,6 @@ void pci_hp_add_devices(struct pci_bus *bus)
 		 */
 		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
 		pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
-		pcibios_setup_bus_devices(bus);
 		max = bus->busn_res.start;
 		/*
 		 * Scan bridges that are already configured. We don't touch
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index f91d7e9..c3024f1 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -414,7 +414,6 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
 	 */
 	if (!rescan_existing)
 		pcibios_setup_bus_self(bus);
-	pcibios_setup_bus_devices(bus);
 
 	/* Now scan child busses */
 	for_each_pci_bridge(dev, bus)
-- 
2.9.5

