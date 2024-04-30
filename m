Return-Path: <linux-pci+bounces-6905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D598B816E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 22:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33131C22ED3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0725950287;
	Tue, 30 Apr 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qa1rlbag"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA7179B2
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509026; cv=none; b=MqvN9G+5mOcpGpkbvb13PZtpiqVJdVzb/MDuHsuvO5A/IwWr6kCCpvyZkJaOW3IQTWSRt+lJ8w92GE+tvF66jaY/PE9oHtudH0q020Sg3aL/KcJzeTG9rYWnZaEiud6GkQKHAVD67GLPglG5YUaMLt2NIX1pkPWlL08bUCfkwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509026; c=relaxed/simple;
	bh=Vc7d+Fk4QLCsp+y8E+aIN9cXq8GzYuELndE72pDBBXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t8s0hen1VWw7dsfsfk13QjdeopfckCq5Dt6uyel8u0rSAXnxkptQYj6IqyfC1gb2L7z4C9OquMV9m8i7dzQ/rKCKzKqtdhVj2irvbZQh/DWXwDkByx59Ih90swBqRpDRl71tWN2fAfUNNVlCh9d1AnW+/JgUTLDXnnIoakoCKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qa1rlbag; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714509024; x=1746045024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vc7d+Fk4QLCsp+y8E+aIN9cXq8GzYuELndE72pDBBXU=;
  b=Qa1rlbagyf7Im6UDX/lKW/1zDAuZD7XtWjr5d6fnkRmX3XULQTZc1Jyy
   MR6wD6Tvw8kOMMvola8C44b1n/Fjyrf9eYg96ArVjZ4F8nC6f9GWBL3LZ
   I488ZXj8CSeaLiU3g+v8Cupd3TO/DGvUveswf1jGGuGydPjCQLCBbc/dW
   cr1rRH9pQw4aS4EL74caUQvZhQzw9Ik1KBhYDv2J7bCreGC+DpVbF18tV
   jKYNJ8mKELHe6AilEn06sr2OOSIdqXUK1jqfs4k3Y1WSjAFsAp3Objkur
   C2zQh0ZPxqdb3EzMpeYAVe3jMbRAXI8tSbUdjVq0DM7y9yjZYQxu5x2MK
   g==;
X-CSE-ConnectionGUID: SkUhLKMhRD+EM0CfO0dlbg==
X-CSE-MsgGUID: nnUuwuBzS4ef/eXPt7ISEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20851989"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="20851989"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 13:30:23 -0700
X-CSE-ConnectionGUID: SgpmMYhOQ0CGsoViYvTSuA==
X-CSE-MsgGUID: S2pLknQlTICsHoPR1tJnKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31034471"
Received: from pmstillw-desk1.amr.corp.intel.com ([10.125.129.88])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 13:30:22 -0700
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
To: linux-pci@vger.kernel.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Subject: [PATCH v2] Documentation: PCI: add vmd documentation
Date: Tue, 30 Apr 2024 13:30:07 -0700
Message-Id: <20240430203007.113-1-paul.m.stillwell.jr@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding documentation for the Intel VMD driver and updating the index
file to include it.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
---
v1->v2:
- updated documentation to add commit message from initial patch
  submission
- small changes based on community feedback
---
 Documentation/PCI/controller/vmd.rst | 74 ++++++++++++++++++++++++++++
 Documentation/PCI/index.rst          |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/PCI/controller/vmd.rst

diff --git a/Documentation/PCI/controller/vmd.rst b/Documentation/PCI/controller/vmd.rst
new file mode 100644
index 000000000000..ff4851f9a62d
--- /dev/null
+++ b/Documentation/PCI/controller/vmd.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=================================================================
+Linux Base Driver for the Intel(R) Volume Management Device (VMD)
+=================================================================
+
+Intel vmd Linux driver.
+
+Contents
+========
+
+The Intel Volume Management Device (VMD) is a Root Complex Integrated
+Endpoint that acts as a host bridge to a secondary PCIe domain. The BIOS
+can enable or disable VMD. Additioanlly the BIOS can reassign one or more
+Root Ports to appear within a VMD domain instead of the primary domain.
+The immediate benefit is that additional PCIe domains allow more than 256
+buses in a system by letting bus numbers be reused across different domains.
+
+VMD domains do not define ACPI _SEG, so to avoid domain clashing with host
+bridges defining this segment, VMD domains start at 0x10000, which is
+greater than the highest possible 16-bit ACPI defined _SEG.
+
+This driver enumerates and enables the domain using the root bus
+configuration interface provided by the PCI subsystem. The driver provides
+configuration space accessor functions (pci_ops), bus and memory resources,
+an MSI IRQ domain with irq_chip implementation, and DMA operations
+necessary to use devices through the VMD endpoint's interface.
+
+VMD routes I/O as follows:
+
+   1) Configuration Space: BAR 0 ("CFGBAR") of VMD provides the base
+   address and size for configuration space register access to VMD-owned
+   root ports. It works similarly to MMCONFIG for extended configuration
+   space.  Bus numbering is independent and does not conflict with the
+   primary domain.
+
+   2) MMIO Space: BARs 2 and 4 ("MEMBAR1" and "MEMBAR2") of VMD provide the
+   base address, size, and type for MMIO register access. These addresses
+   are not translated by VMD hardware; they are simply reservations to be
+   distributed to root ports' memory base/limit registers and subdivided
+   among devices downstream.
+
+   3) DMA: To interact appropriately with an IOMMU, the source ID DMA read
+   and write requests are translated to the bus-device-function of the VMD
+   endpoint. Otherwise, DMA operates normally without VMD-specific address
+   translation.
+
+   4) Interrupts: Part of VMD's BAR 4 is reserved for VMD's MSI-X Table and
+   PBA. MSIs from VMD domain devices and ports are remapped to appear as
+   if they were issued using one of VMD's MSI-X table entries. Each MSI
+   and MSI-X address of VMD-owned devices and ports has a special format
+   where the address refers to specific entries in the VMD's MSI-X table.
+   As with DMA, the interrupt source ID is translated to VMD's
+   bus-device-function.
+
+   The driver provides its own MSI and MSI-X configuration functions
+   specific to how MSI messages are used within the VMD domain, and
+   provides an irq_chip for independent IRQ allocation to relay interrupts
+   from VMD's interrupt handler to the appropriate device driver's handler.
+
+   5) Errors: PCIe error message are intercepted by the root ports normally
+   (e.g., AER), except with VMD, system errors (i.e. firmware first) are
+   disabled by default. AER and hotplug interrupts are translated in the
+   same way as endpoint interrupts.
+
+   6) VMD does not support INTx interrupts or IO ports. Devices or drivers
+   requiring these features should either not be placed below VMD-owned
+   root ports, or VMD should be disabled by BIOS for such endpoints.
+
+The driver can run on both a host and a guest. The BIOS provides a mechanism
+to specify which VMD devices should be passed through to a guest and the
+hypervisor can select that device by specifying the bus-device-function. The
+device that is passed through to a guest is not seen by the driver on the
+host.
\ No newline at end of file
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index e73f84aebde3..6558adc703f9 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -18,3 +18,4 @@ PCI Bus Subsystem
    pcieaer-howto
    endpoint/index
    boot-interrupts
+   controller/vmd
-- 
2.39.1


