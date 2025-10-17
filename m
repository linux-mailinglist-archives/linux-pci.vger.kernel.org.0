Return-Path: <linux-pci+bounces-38451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B1BE8408
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1EFB4E210D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550F1338F43;
	Fri, 17 Oct 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBXuRErk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1033769C;
	Fri, 17 Oct 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699356; cv=none; b=RyrkAb7QmoGcwvqF5rXvBPakks0c0xlkFwDKkxD30pi0enUgPVNX7j93THDH3KXexLEw7wtQuKCo7mnwsBzdhk3/M+AvRcv1LfprnG/F2WJXSmrcN+d7W10CUb0TGeyEs9xzJmlOmIRL9imfV55UxNpFFmDC2fHappXvfFsgdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699356; c=relaxed/simple;
	bh=sIikt0cxc57OKfiMJajrJD2O++vocOL5adNAafB+1Gk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LBrE/oOaxlXZxrSBe5VVRMBdohCay/Jq4/hhDEyP6Dn5lCuVyS1pQArDiSVojBQcrbjUEJrIC45EEyP9vnyc9oqW6kO5XdRjsw6xYFJ9KoSCvwyqB8xwBFBhvaKgGXirOPxEVVBpE2ESpGG+0nkIEgyywWjneLBW1L4q1IySSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBXuRErk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760699355; x=1792235355;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sIikt0cxc57OKfiMJajrJD2O++vocOL5adNAafB+1Gk=;
  b=cBXuRErkxn04mMLRFEMXfI8fvdGJRjyeQ+7ecu9yYzSblEG8IJhAI3zR
   CEzKt1ORQlI1NS59iYQVDx3dUqkyzbHo1KL1REgQ7p+vEZ1VeT9bloLoJ
   zEeaA9wRjec6bWDa5kVtXYN/Nqgk4m0BLAuAUmX1szugmdEC0XwDbFjqA
   ew58ZjZyrQ+2bfuKk6OyP/xKAoGsVk/KGkHBAawWoJi+DtqExKuKH0YBN
   rqM1sTT6ov9YWJrZ63MyjYk5Jw8AeA05YzKmg/Pn5svnm7s4AtM14AAZl
   NMVAIvLTQUFSbN3JhGBt6qJvZUwsAbfA+IFsSEY0RI0WiRs+vIBwyANx/
   A==;
X-CSE-ConnectionGUID: ccN4GNr6Rs6RNdrD8YFQeA==
X-CSE-MsgGUID: 82W+c5VzSDmrNvf0mWaCsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="74251364"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="74251364"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 04:09:14 -0700
X-CSE-ConnectionGUID: CmcgfCFARe+eDZ4nDZ8uEA==
X-CSE-MsgGUID: 1br6QaVQQkOyUtX94fM9dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="219864219"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 04:09:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] MIPS: Malta: Use pcibios_align_resource() to block io range
Date: Fri, 17 Oct 2025 14:09:03 +0300
Message-Id: <20251017110903.1973-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to Maciej W. Rozycki <macro@orcam.me.uk>, the
mips_pcibios_init() for malta adjusts root bus IO resource start
address to prevent interfering with PIIX4 I/O cycle decoding. Adjusting
lower bound leaves PIIX4 IO resources outside of the root bus resource
and assign_fixed_resource_on_bus() does not link the resources into the
resource tree.

Prior to commit ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
the arch specific pcibios_enable_resources() did not check if the
resources were assigned which diverges from what PCI core checks,
effectively hiding the PIIX4 IO resources were not properly within the
resource tree. After starting to use pcibios_enable_resources() from
PCI core, enabling PIIX4 fails:

ata_piix 0000:00:0a.1: BAR 0 [io  0x01f0-0x01f7]: not claimed; can't enable device
ata_piix 0000:00:0a.1: probe with driver ata_piix failed with error -22

MIPS PCI code already has support for enforcing lower bounds using
PCIBIOS_MIN_IO in pcibios_align_resource() without altering the IO
window start address itself. Make malta PCI code too to use
PCIBIOS_MIN_IO.

Fixes: ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
Fixes: aa0980b80908 ("Fixes for system controllers for Atlas/Malta core cards.")
Link: https://lore.kernel.org/linux-pci/9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net/
Link: https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:

- Remove if and always set PCIBIOS_MIN_IO (suggested by Maciej).
- Minor improvement to the changelog

 arch/mips/pci/pci-malta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-malta.c b/arch/mips/pci/pci-malta.c
index 6aefdf20ca05..2e35aeba45bc 100644
--- a/arch/mips/pci/pci-malta.c
+++ b/arch/mips/pci/pci-malta.c
@@ -230,8 +230,7 @@ void __init mips_pcibios_init(void)
 	}
 
 	/* PIIX4 ACPI starts at 0x1000 */
-	if (controller->io_resource->start < 0x00001000UL)
-		controller->io_resource->start = 0x00001000UL;
+	PCIBIOS_MIN_IO = 0x1000;
 
 	iomem_resource.end &= 0xfffffffffULL;			/* 64 GB */
 	ioport_resource.end = controller->io_resource->end;

base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
-- 
2.39.5


