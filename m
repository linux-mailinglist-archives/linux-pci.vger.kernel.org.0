Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4714F664819
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 19:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjAJSF0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 13:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjAJSEu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 13:04:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FC984BCB;
        Tue, 10 Jan 2023 10:02:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3AAEB818ED;
        Tue, 10 Jan 2023 18:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBDAC433D2;
        Tue, 10 Jan 2023 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673373776;
        bh=LPpzoeHYi2j3MioTZ/ZfEBoc1LHscwPMxPEaHTQLHMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svSLJsikLXRw4iRJaQTBGxNd09rSFTSsUnFxvU07Za8WHGA5pvYTYNcNBbm6fAKmN
         4ePzRBqiU5Ga/gMxmjQjdR4QspKM4FGKt+7fkjOtIGujd8gEupF5vKE8cHxXYovLwm
         goXHxb4wXTfR0JLp86mzYYcVbFcs/Wbd5Nd0/JuAl3LgukH3uuC5WROTQeOCORrg53
         Ls4SiLhzNzjhRp0pdCTFCLWugBUnPgsUz8Pe08/OWakvNjvOZnPK2+aTdWwDKd9hq8
         OqBsWU8k821XL46zmo7x4n+KjBt3nTSnHbpPmbp1Xo7F/UPGRJrqawIx7rBLd8eaPv
         upT9zKgoj0iww==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
Date:   Tue, 10 Jan 2023 12:02:43 -0600
Message-Id: <20230110180243.1590045-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110180243.1590045-1-helgaas@kernel.org>
References: <20230110180243.1590045-1-helgaas@kernel.org>
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

Normally we reject ECAM space unless it is reported as reserved in the E820
table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
means PCI extended config space (offsets 0x100-0xfff) may not be accessible.

Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
normally converted to an E820 entry by a bootloader or EFI stub.

07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
E820 entries that correspond to EfiMemoryMappedIO regions because some
other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
E820 entries prevent Linux from allocating BAR space for hot-added devices.

Allow use of ECAM for extended config space when the region is covered by
an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
_CRS.

Reported by Kan Liang, Tony Luck, and Giovanni Cabiddu.

Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Reported-by: Tony Luck <tony.luck@intel.com>
Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index cd16bef5f2d9..da4b6e8e9df0 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/bitmap.h>
@@ -442,6 +443,32 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
 	return mcfg_res.flags;
 }
 
+static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
+{
+#ifdef CONFIG_EFI
+	efi_memory_desc_t *md;
+	u64 size, mmio_start, mmio_end;
+
+	for_each_efi_memory_desc(md) {
+		if (md->type == EFI_MEMORY_MAPPED_IO) {
+			size = md->num_pages << EFI_PAGE_SHIFT;
+			mmio_start = md->phys_addr;
+			mmio_end = mmio_start + size;
+
+			/*
+			 * N.B. Caller supplies (start, start + size),
+			 * so to match, mmio_end is the first address
+			 * *past* the EFI_MEMORY_MAPPED_IO area.
+			 */
+			if (mmio_start <= start && end <= mmio_end)
+				return true;
+		}
+	}
+#endif
+
+	return false;
+}
+
 typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
 
 static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
@@ -513,6 +540,10 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
 			       "MMCONFIG at %pR not reserved in "
 			       "ACPI motherboard resources\n",
 			       &cfg->res);
+
+		if (is_mmconf_reserved(is_efi_mmio, cfg, dev,
+				       "EfiMemoryMappedIO"))
+			return true;
 	}
 
 	/*
-- 
2.25.1

