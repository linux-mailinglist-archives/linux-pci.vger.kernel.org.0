Return-Path: <linux-pci+bounces-6381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9868A8D1B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 22:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0121C20FF3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 20:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6CF44C8D;
	Wed, 17 Apr 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ2zFftC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76B44C7B;
	Wed, 17 Apr 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386457; cv=none; b=priaKU97HkjiSb465UpTKjl0PogvCQX7a+AEKlKWLGnxYjrzdbaZZH7L3+sx+44BnDmclQxen2CO3sYf15fTmgrRjyz2tGijkJQfCGoWcbG6au5DZv3EzblL99XA1y2QdrevOSOV7xiYonn65GMgdGdEgZo+DLVcMu7rKGYl6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386457; c=relaxed/simple;
	bh=oZ2d6BQJiFao+w5iptjGcdQdSKyyboWurZy/GTwx25k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtCqISJT6TWWv+G4UZpheEL2goiILP0Y3rRJkBS5FeCNB2dev8+NzACXfg7MfxWhzR0P3D9a934shVLbXhd03ywQ4L+peFJogkL8AcwF88JH7DAjyoFp3vq/EZ2ALeSlgxTcP2hn4046UJawnDNocKsXL5mUP+PHVEMF3pTY5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ2zFftC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB8DC072AA;
	Wed, 17 Apr 2024 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713386457;
	bh=oZ2d6BQJiFao+w5iptjGcdQdSKyyboWurZy/GTwx25k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQ2zFftC3hpzIHJqd2hN4HRau6ckGUHplil62MUbg29PYDkttbTMkRWoHw2GxJWaB
	 25ZtfkT/G1I+4jEjn0jriCEOvw1F+6De8uaijmOa8RP99MSZPU+1FZYnzEq3AbIfGn
	 xKbKF64LHZOaUwzMRGSSuQofsAmoaANU0ZI6cGCwz+w2/BotdsbJRm8CNMBntvpbRQ
	 qoK7U/KYXNKYWh+946vT3D+saKu7utlKsQgXYiQxwHVqNuI1o23EzEfhprTxHxvpsS
	 l7w081lvJ0m7Y15Yul72n3DiF88FlzUosAz+Fjv3yoEwcCN+F5hag/j4T6CNLWuqtX
	 9P3jLRARof4og==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Mateusz Kaduk <mateusz.kaduk@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tj <linux@iam.tj>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] x86/pci: Skip early E820 check for ECAM region
Date: Wed, 17 Apr 2024 15:40:12 -0500
Message-Id: <20240417204012.215030-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417204012.215030-1-helgaas@kernel.org>
References: <20240417204012.215030-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Arul, Mateusz, Imcarneiro91, and Aman reported a regression caused by
07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").  On the
Lenovo Legion 9i laptop, that commit removes the area containing ECAM from
E820, which means the early E820 validation started failing, which meant we
didn't enable ECAM in the "early MCFG" path

The lack of ECAM caused many ACPI methods to fail, resulting in the
embedded controller, PS/2, audio, trackpad, and battery devices not being
detected.  The _OSC method also failed, so Linux could not take control of
the PCIe hotplug, PME, and AER features:

  # pci_mmcfg_early_init()

  PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
  PCI: not using ECAM ([mem 0xc0000000-0xce0fffff] not reserved)

  ACPI Error: AE_ERROR, Returned by Handler for [PCI_Config] (20230628/evregion-300)
  ACPI: Interpreter enabled
  ACPI: Ignoring error and continuing table load
  ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC00], AE_NOT_FOUND (20230628/dswload2-162)
  ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject-220)
  ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0010)
  ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC00], AE_NOT_FOUND (20230628/dswload2-162)
  ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject-220)
  ...
  ACPI Error: Aborting method \_SB.PC00._OSC due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
  acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_NOT_FOUND)

  # pci_mmcfg_late_init()

  PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
  PCI: [Firmware Info]: ECAM [mem 0xc0000000-0xce0fffff] not reserved in ACPI motherboard resources
  PCI: ECAM [mem 0xc0000000-0xce0fffff] is EfiMemoryMappedIO; assuming valid
  PCI: ECAM [mem 0xc0000000-0xce0fffff] reserved to work around lack of ACPI motherboard _CRS

Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be reserved by a PNP0C02
resource, but it need not be mentioned in E820, so we shouldn't look at
E820 to validate the ECAM space described by MCFG.

946f2ee5c731 ("[PATCH] i386/x86-64: Check that MCFG points to an e820
reserved area") added a sanity check of E820 to work around buggy MCFG
tables, but that over-aggressive validation causes failures like this one.

Keep the E820 validation check only for older BIOSes (pre-2016) so the
buggy 2006-era machines don't break.  Skip the early E820 check for 2016
and newer BIOSes.

Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
Reported-by: Mateusz Kaduk <mateusz.kaduk@gmail.com>
Reported-by: Arul <...>
Reported-by: Imcarneiro91 <...>
Reported-by: Aman <...>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218444
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Mateusz Kaduk <mateusz.kaduk@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/x86/pci/mmconfig-shared.c | 35 +++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 0cc9520666ef..53c7afa606c3 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -518,7 +518,34 @@ static bool __ref pci_mmcfg_reserved(struct device *dev,
 {
 	struct resource *conflict;
 
-	if (!early && !acpi_disabled) {
+	if (early) {
+
+		/*
+		 * Don't try to do this check unless configuration type 1
+		 * is available.  How about type 2?
+		 */
+
+		/*
+		 * 946f2ee5c731 ("Check that MCFG points to an e820
+		 * reserved area") added this E820 check in 2006 to work
+		 * around BIOS defects.
+		 *
+		 * Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be
+		 * reserved by a PNP0C02 resource, but it need not be
+		 * mentioned in E820.  Before the ACPI interpreter is
+		 * available, we can't check for PNP0C02 resources, so
+		 * there's no reliable way to verify the region in this
+		 * early check.  Keep it only for the old machines that
+		 * motivated 946f2ee5c731.
+		 */
+		if (dmi_get_bios_year() < 2016 && raw_pci_ops)
+			return is_mmconf_reserved(e820__mapped_all, cfg, dev,
+						  "E820 entry");
+
+		return true;
+	}
+
+	if (!acpi_disabled) {
 		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev,
 				       "ACPI motherboard resource"))
 			return true;
@@ -554,12 +581,6 @@ static bool __ref pci_mmcfg_reserved(struct device *dev,
 	if (pci_mmcfg_running_state)
 		return true;
 
-	/* Don't try to do this check unless configuration
-	   type 1 is available. how about type 2 ?*/
-	if (raw_pci_ops)
-		return is_mmconf_reserved(e820__mapped_all, cfg, dev,
-					  "E820 entry");
-
 	return false;
 }
 
-- 
2.34.1


