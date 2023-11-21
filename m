Return-Path: <linux-pci+bounces-54-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139447F360F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3071281F26
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A351009;
	Tue, 21 Nov 2023 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOI8lHHo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544820DD3
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6610C433C7;
	Tue, 21 Nov 2023 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700591812;
	bh=pWuDQ59uPEfBjFMTjgUcZ8je0YmKAaZY2YBS88kvYBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOI8lHHo+cShXXbkN9hUVNV6xcoPgxi6T9uoyZuaygotASAvLVPt90j9/qha5EQYi
	 jhKUYdK30UmaXXEF8K2zQzyJfnZzyBl0zk9xYVwDl0pjULCaqJb6+G2WTEv0wascYn
	 E/Bp3tMNG7Tv0NDMZq4Nu0/3fOsxVrbQjruGVk/CvN9Tr/EgRVkWBg0nw7KrOIhKWB
	 b80a5++hMfF800x7fDgVoPMRD/f+VX6AwiMZmAzy4PAPL15tWX/5HCNDAjVijRZEjS
	 wkqyuGjYSbgAa62nsXwfnmBOYmS7ZiuMLx9GPuiJ+b1N1MO8PjJgunq6OI1ZcYirU2
	 Lw2/rvIpvstOA==
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
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/9] x86/pci: Reserve ECAM if BIOS didn't include it in PNP0C02 _CRS
Date: Tue, 21 Nov 2023 12:36:35 -0600
Message-Id: <20231121183643.249006-2-helgaas@kernel.org>
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

Tomasz, Sebastian, and some Proxmox users reported problems initializing
ixgbe NICs.

I think the problem is that ECAM space described in the ACPI MCFG table is
not reserved via a PNP0C02 _CRS method as required by the PCI Firmware spec
(r3.3, sec 4.1.2), but it *is* included in the PNP0A03 host bridge _CRS as
part of the MMIO aperture.

If we allocate space for a PCI BAR, we're likely to allocate it from that
ECAM space, which obviously cannot work.

This could happen for any device, but in the ixgbe case it happens because
it's an SR-IOV device and the BIOS didn't allocate space for the VF BARs,
so Linux reallocated the bridge window leading to ixgbe and put it on top
of the ECAM space.  From Tomasz' system:

  PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
  PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
  pci_bus 0000:00: root bus resource [mem 0x80000000-0xfbffffff window]

  pci 0000:00:01.1: PCI bridge to [bus 02-03]
  pci 0000:00:01.1:   bridge window [mem 0xfb900000-0xfbbfffff]
  pci 0000:02:00.0: [8086:10fb] type 00 class 0x020000  # ixgbe
  pci 0000:02:00.0: reg 0x10: [mem 0xfba80000-0xfbafffff 64bit]
  pci 0000:02:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit] (contains BAR0 for 64 VFs)
  pci 0000:02:00.0: BAR 7: no space for [mem size 0x00100000 64bit]   # VF BAR 0

  pci_bus 0000:00: No. 2 try to assign unassigned res
  pci 0000:00:01.1: resource 14 [mem 0xfb900000-0xfbbfffff] released
  pci 0000:00:01.1: BAR 14: assigned [mem 0x80000000-0x806fffff]
  pci 0000:02:00.0: BAR 0: assigned [mem 0x80000000-0x8007ffff 64bit]
  pci 0000:02:00.0: BAR 7: assigned [mem 0x80204000-0x80303fff 64bit] # VF BAR 0

Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
Fixes: fd3a8cff4d4a ("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space")
Reported-by: Tomasz Pala <gotar@polanet.pl>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218050
Sebastian Manciulea <manciuleas@protonmail.com>
Reported-by: Sebastian Manciulea <manciuleas@protonmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218107
Link: https://forum.proxmox.com/threads/proxmox-8-kernel-6-2-16-4-pve-ixgbe-driver-fails-to-load-due-to-pci-device-probing-failure.131203/
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org	# v6.2+
---
 arch/x86/pci/mmconfig-shared.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 4b3efaa82ab7..e9497ee0f854 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -525,6 +525,8 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 static bool __ref
 pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int early)
 {
+	struct resource *conflict;
+
 	if (!early && !acpi_disabled) {
 		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev,
 				       "ACPI motherboard resource"))
@@ -542,8 +544,17 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
 			       &cfg->res);
 
 		if (is_mmconf_reserved(is_efi_mmio, cfg, dev,
-				       "EfiMemoryMappedIO"))
+				       "EfiMemoryMappedIO")) {
+			conflict = insert_resource_conflict(&iomem_resource,
+							    &cfg->res);
+			if (conflict)
+				pr_warn("MMCONFIG %pR conflicts with %s %pR\n",
+					&cfg->res, conflict->name, conflict);
+			else
+				pr_info("MMCONFIG %pR reserved to work around lack of ACPI motherboard _CRS\n",
+					&cfg->res);
 			return true;
+		}
 	}
 
 	/*
-- 
2.34.1


