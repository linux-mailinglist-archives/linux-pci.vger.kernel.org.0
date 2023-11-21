Return-Path: <linux-pci+bounces-55-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB97F3611
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A801C20CED
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0BA2D;
	Tue, 21 Nov 2023 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FstPSUpx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF205101C
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8E8C433C9;
	Tue, 21 Nov 2023 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700591813;
	bh=u1Z+uhkAAWZ5rmqaUW2oCllaPTDshYz0d6+Ko3LZvdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FstPSUpxC6bCoYdEGw+0ftTkOH9n+o9k4xcso+Xrb8l8tQGVcojhaAEIIzGs17XMn
	 BzP+EQYOWy7UrrOew+ypwZWCIAD6j0j39mMxxOaVNfDokmMESfydlF6/s0KysXtkLr
	 Umf2mfbJzUgHIAEuE1SCrpvyPRCfV7fGVhZgj8qW/Y2cEN4xN5u2ncQvLj4Byao35o
	 Nyyzms7y11zd9VkV6PgxhMl0zT6RB5F8LBfHpO9R466L+XW2VmEk5JdlX+t3O7n1kJ
	 KsHHShrU2fTrpwAxBpSf9QUCdg8jkgZBIrfqM/27zXbLxXvnkDX2e4TyZylZ8ZoY0c
	 dADffB1y8tpJA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Yunying Sun <yunying.sun@intel.com>,
	Tomasz Pala <gotar@polanet.pl>,
	Sebastian Manciulea <manciuleas@protonmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/9] x86/pci: Reword ECAM EfiMemoryMappedIO logging to avoid 'reserved'
Date: Tue, 21 Nov 2023 12:36:36 -0600
Message-Id: <20231121183643.249006-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121183643.249006-1-helgaas@kernel.org>
References: <20231121183643.249006-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

fd3a8cff4d4a ("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM
space") added the concept of using the EFI memory map to help decide
whether ECAM space mentioned in the MCFG table is valid.

Unfortunately it described that EfiMemoryMappedIO space as "reserved", but
it is actually not *reserved* by the EFI memory map.  EfiMemoryMappedIO
only means the firmware requested that the OS map this space for use by
firmware runtime services.

Change the dmesg logging to describe it as simply "EfiMemoryMappedIO", not
as "reserved as EfiMemoryMappedIO".  A previous commit actually *does*
reserve the space if ACPI PNP0C01/02 devices haven't done so:

  - PCI: ECAM at [mem 0xe0000000-0xefffffff] reserved as EfiMemoryMappedIO
  + PCI: ECAM at [mem 0xe0000000-0xefffffff] is EfiMemoryMappedIO; assuming valid
    PCI: ECAM [mem 0xe0000000-0xefffffff] reserved to work around lack of ACPI motherboard _CRS

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index e9497ee0f854..64c39a23d37a 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -443,9 +443,11 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
 	return mcfg_res.flags;
 }
 
-static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
+static bool is_efi_mmio(struct resource *res)
 {
 #ifdef CONFIG_EFI
+	u64 start = res->start;
+	u64 end = res->start + resource_size(res);
 	efi_memory_desc_t *md;
 	u64 size, mmio_start, mmio_end;
 
@@ -455,11 +457,6 @@ static bool is_efi_mmio(u64 start, u64 end, enum e820_type not_used)
 			mmio_start = md->phys_addr;
 			mmio_end = mmio_start + size;
 
-			/*
-			 * N.B. Caller supplies (start, start + size),
-			 * so to match, mmio_end is the first address
-			 * *past* the EFI_MEMORY_MAPPED_IO area.
-			 */
 			if (mmio_start <= start && end <= mmio_end)
 				return true;
 		}
@@ -543,8 +540,9 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
 			       "ACPI motherboard resources\n",
 			       &cfg->res);
 
-		if (is_mmconf_reserved(is_efi_mmio, cfg, dev,
-				       "EfiMemoryMappedIO")) {
+		if (is_efi_mmio(&cfg->res)) {
+			pr_info("ECAM %pR is EfiMemoryMappedIO; assuming valid\n",
+				&cfg->res);
 			conflict = insert_resource_conflict(&iomem_resource,
 							    &cfg->res);
 			if (conflict)
-- 
2.34.1


