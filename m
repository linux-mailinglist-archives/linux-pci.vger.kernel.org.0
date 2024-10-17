Return-Path: <linux-pci+bounces-14788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D51F9A24A3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08DEB27F5B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CE51DE3D1;
	Thu, 17 Oct 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djU3W3O6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3451DE4FC;
	Thu, 17 Oct 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174291; cv=none; b=dQoiLb1FTdN6yc3CFjcMG2aNKBjSK/z0Zco88qc99rXz9m0jDZOe+fo2wbo89AGJgMbZk9e1sP6QSDfOjtHD54MAhSx++kSFWflp5JqLvNK+QlyNhOARhIxFqH/CfO7OzhRijFYpJ7nh/6vwvjvaIL1SvXihNWbXA2fKILqOBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174291; c=relaxed/simple;
	bh=XY7zdhu7QudhUkiM0AodZhJmfPNC9EYIGL5unKDNQ8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QJeCZWqF+i1+RrtQ/W4dHJcPSFAGciOVrLBpZxUXkqGES2XOTPRhcRB+h6ynnZR+u8SDNcaXlSb7/w5bSvSunTS4/wCW2d9wgYeWr3M1YbNgqW4ry+DCiDXI8dd2FDalb6ac3P9wsExAaSpcOG5aocSOB1W2/CoCCDhElCtfImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djU3W3O6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729174286; x=1760710286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XY7zdhu7QudhUkiM0AodZhJmfPNC9EYIGL5unKDNQ8M=;
  b=djU3W3O6D09D8ub6LhGTuZW+sW865oEcUBSHgPtuLvjTzihs8FJ5m23G
   qtVWarOfdEdzxGafo8LusiiiL2C4g8yYQgd2hd02Z90K8+XIRyDTzOQUA
   XLgr3cXnySIjPVoHFLG1dq56eHMqf1+ozF6qfYmMOP5yK3fVEkgszVJEv
   WDaKbs6vJ8oCFxTr57k4hIB41e8e29FvYlZad9836zpX3APdmSguGL/n4
   g4DIPrtkky4XcbAVB+YSe3t3PyfycXminpSvcThAq4gArbPr0Rh8Wu/xP
   fjfe0BiA05s0ofwIzWQ/naBjXSMkhzPpMM5YeWauRqh9qLUJbDfSzaKcx
   g==;
X-CSE-ConnectionGUID: wyTzASqiT0uxyueUURE/Jw==
X-CSE-MsgGUID: gmkI/b2pS1WybbieWhzFcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54075335"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="54075335"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:11:25 -0700
X-CSE-ConnectionGUID: p9664RvmRn28cOnoBFRtYg==
X-CSE-MsgGUID: 03bod7CHSoe54/Uv7tvVmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78701325"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:11:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] PCI: Remove unused PCI_SUBTRACTIVE_DECODE
Date: Thu, 17 Oct 2024 17:11:08 +0300
Message-Id: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit 2fe2abf896c1 ("PCI: augment bus resource table with a list")
added PCI_SUBTRACTIVE_DECODE which is put into the struct
pci_bus_resource flags field but is never read. There seems to never
have been users for it. Remove both PCI_SUBTRACTIVE_DECODE and the
flags field from the struct pci_bus_resource.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/s390/pci/pci_bus.c |  2 +-
 arch/x86/pci/fixup.c    |  2 +-
 drivers/pci/bus.c       |  4 +---
 drivers/pci/probe.c     |  5 ++---
 include/linux/pci.h     | 12 +-----------
 5 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index daa5d7450c7d..5630af5deb8b 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -53,7 +53,7 @@ static int zpci_bus_prepare_device(struct zpci_dev *zdev)
 		zpci_setup_bus_resources(zdev);
 		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			if (zdev->bars[i].res)
-				pci_bus_add_resource(zdev->zbus->bus, zdev->bars[i].res, 0);
+				pci_bus_add_resource(zdev->zbus->bus, zdev->bars[i].res);
 		}
 	}
 
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 98a9bb92d75c..0681ecfe3430 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -757,7 +757,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 		dev_info(&dev->dev, "adding root bus resource %pR (tainting kernel)\n",
 			 res);
 		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-		pci_bus_add_resource(dev->bus, res, 0);
+		pci_bus_add_resource(dev->bus, res);
 	}
 
 	base = ((res->start >> 8) & AMD_141b_MMIO_BASE_MMIOBASE_MASK) |
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 55c853686051..9cf6d0f3ab2b 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -46,8 +46,7 @@ void pci_free_resource_list(struct list_head *resources)
 }
 EXPORT_SYMBOL(pci_free_resource_list);
 
-void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
-			  unsigned int flags)
+void pci_bus_add_resource(struct pci_bus *bus, struct resource *res)
 {
 	struct pci_bus_resource *bus_res;
 
@@ -58,7 +57,6 @@ void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
 	}
 
 	bus_res->res = res;
-	bus_res->flags = flags;
 	list_add_tail(&bus_res->list, &bus->resources);
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..4243b1e6ece2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -546,8 +546,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	if (dev->transparent) {
 		pci_bus_for_each_resource(child->parent, res) {
 			if (res && res->flags) {
-				pci_bus_add_resource(child, res,
-						     PCI_SUBTRACTIVE_DECODE);
+				pci_bus_add_resource(child, res);
 				pci_info(dev, "  bridge window %pR (subtractive decode)\n",
 					   res);
 			}
@@ -1032,7 +1031,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		if (res->flags & IORESOURCE_BUS)
 			pci_bus_insert_busn_res(bus, bus->number, res->end);
 		else
-			pci_bus_add_resource(bus, res, 0);
+			pci_bus_add_resource(bus, res);
 
 		if (offset) {
 			if (resource_type(res) == IORESOURCE_IO)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..6a9cf80d0d4b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -633,18 +633,9 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
  * Use pci_bus_for_each_resource() to iterate through all the resources.
  */
 
-/*
- * PCI_SUBTRACTIVE_DECODE means the bridge forwards the window implicitly
- * and there's no way to program the bridge with the details of the window.
- * This does not apply to ACPI _CRS windows, even with the _DEC subtractive-
- * decode bit set, because they are explicit and can be programmed with _SRS.
- */
-#define PCI_SUBTRACTIVE_DECODE	0x1
-
 struct pci_bus_resource {
 	struct list_head	list;
 	struct resource		*res;
-	unsigned int		flags;
 };
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
@@ -1498,8 +1489,7 @@ void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
 void pci_free_resource_list(struct list_head *resources);
-void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
-			  unsigned int flags);
+void pci_bus_add_resource(struct pci_bus *bus, struct resource *res);
 struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
 void pci_bus_remove_resources(struct pci_bus *bus);
 void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res);
-- 
2.39.5


