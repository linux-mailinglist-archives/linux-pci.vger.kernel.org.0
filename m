Return-Path: <linux-pci+bounces-39302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1226FC0841D
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 00:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C41B94E8004
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD62FC89C;
	Fri, 24 Oct 2025 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUC0KTYP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8235B130
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345984; cv=none; b=JGRbFarsjGa7DEg2DMttOIpAgci3x+oj0WE3hLOqpAmL+5sZNjw+75Ya0Ndizb72e/DdzVsHp4bklwYXB7AJxRoTBS5QHVVAFoV0+KEVpGZcUsYp6i9ZYh3+sfPSjavRZU83rJY1ip2lZjGkn8oqPzqKH2f47Ut+F0mdufdgnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345984; c=relaxed/simple;
	bh=FlGid/p5PGop294WVozz985I5yXVwIP5EFqyCFKib3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXxGV3WBo8eai+X4/VDqnQjgLGuW4NC36WAYQMDwWDU+tItAQJhFGDKoNGGJbvKXZBcgysz2zCpSSiv8kTF/Ij7qFiX82bhutPemAloYUZQAOMAFZgSLUb5fwLXWHPZ6GZFGnRg4bsQuEbvPVtBaSLJKzCxk/Tdq1/FYDDH64JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUC0KTYP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761345982; x=1792881982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FlGid/p5PGop294WVozz985I5yXVwIP5EFqyCFKib3w=;
  b=VUC0KTYPE7pfucPXRDcgDl+z0yv1kh7TUoEtGxHDCrx0aWJkz78n2WMg
   pOfuh2W9CCvs387Q/Om3SzRVBqnp0Klurom8e640OknRWhvbp5P3Fjqr/
   Sn+jNzk8yY7XRGuEuzAfdTZW3ZgK4ElkTaa8IGGxj4alvxwpKbvDmI8xc
   NX17/sznZVmuedCdeRLkhIsAS8AvNPvToobSOXKJhI8wJgqB76xTB4zSV
   Hj1ShJ9GKlWexEh2W/q4tq0+zG6ox/CdFmLqDc5Rh7JcedlSKlhzdCYS1
   /g64YPPsmInSDzxalNqBctHQuWsmKQUj+qAPDeOOi4EXAlDTxs8JUoOj5
   Q==;
X-CSE-ConnectionGUID: X66QiukLSpKz41qEAettJA==
X-CSE-MsgGUID: M66SjRmlTUmQFjwBm/D7bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89001933"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="89001933"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 15:46:20 -0700
X-CSE-ConnectionGUID: lHg1eLg7RiaGAJWue5X6Zg==
X-CSE-MsgGUID: R0dqkQ2qTf6dh8BkpeKORw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="184608443"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa008.jf.intel.com with ESMTP; 24 Oct 2025 15:46:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	jonathan.derrick@linux.dev,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	Szymon Durawa <szymon.durawa@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH v2 2/2] PCI: vmd: Switch to pci_bus_find_emul_domain_nr()
Date: Fri, 24 Oct 2025 15:46:22 -0700
Message-ID: <20251024224622.1470555-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024224622.1470555-1-dan.j.williams@intel.com>
References: <20251024224622.1470555-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new common domain number allocator can replace the custom allocator
in VMD.

Beyond some code reuse benefits it does close a potential race whereby
vmd_find_free_domain() collides with new PCI buses coming online with a
conflicting domain number. Such a race has not been observed in
practice, hence not tagging this change as a fix.

As VMD uses pci_create_root_bus() rather than pci_alloc_host_bridge() +
pci_scan_root_bus_bridge() it has no chance to set ->domain_nr in the
bridge so needs to manage freeing the domain number on its own.

Cc: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/controller/vmd.c | 40 +++++++++++++++---------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index b4b62b9ccc45..03b5920138f0 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -578,22 +578,6 @@ static void vmd_detach_resources(struct vmd_dev *vmd)
 	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
 }
 
-/*
- * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
- * Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of which the lower
- * 16 bits are the PCI Segment Group (domain) number.  Other bits are
- * currently reserved.
- */
-static int vmd_find_free_domain(void)
-{
-	int domain = 0xffff;
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus)) != NULL)
-		domain = max_t(int, domain, pci_domain_nr(bus));
-	return domain + 1;
-}
-
 static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 				resource_size_t *offset1,
 				resource_size_t *offset2)
@@ -878,13 +862,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
-	sd->vmd_dev = vmd->dev;
-	sd->domain = vmd_find_free_domain();
-	if (sd->domain < 0)
-		return sd->domain;
-
-	sd->node = pcibus_to_node(vmd->dev->bus);
-
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
@@ -910,9 +887,24 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
+	sd->vmd_dev = vmd->dev;
+
+	/*
+	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
+	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
+	 * which the lower 16 bits are the PCI Segment Group (domain) number.
+	 * Other bits are currently reserved.
+	 */
+	sd->domain = pci_bus_find_emul_domain_nr(0, 0x10000, INT_MAX);
+	if (sd->domain < 0)
+		return sd->domain;
+
+	sd->node = pcibus_to_node(vmd->dev->bus);
+
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
 				       &vmd_ops, sd, &resources);
 	if (!vmd->bus) {
+		pci_bus_release_emul_domain_nr(sd->domain);
 		pci_free_resource_list(&resources);
 		vmd_remove_irq_domain(vmd);
 		return -ENODEV;
@@ -1005,6 +997,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
+	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
 	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
@@ -1070,6 +1063,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
 	ida_free(&vmd_instance_ida, vmd->instance);
+	pci_bus_release_emul_domain_nr(vmd->sysdata.domain);
 }
 
 static void vmd_shutdown(struct pci_dev *dev)
-- 
2.51.0


