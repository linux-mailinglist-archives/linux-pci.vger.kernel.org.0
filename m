Return-Path: <linux-pci+bounces-6379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5F8A8CD3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 22:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16C82819E3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 20:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1214637163;
	Wed, 17 Apr 2024 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRR9N6sr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80C18C1F
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384958; cv=none; b=dL2aBxy4J0QUUJDMAWVFGEc3oU3GK7wvsgg6KO+lqNpBMJ925yfuTbOYY9p1+GDM/azQJ8z4jJIj83EitCduP/102CpGyaxt2PbUKmT8igc9pAbIg5YgR0E6z+8mm2E4gtpYMVgSZ+U03+6mEyovuWJFPrZWJDVwfWF2rN5eYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384958; c=relaxed/simple;
	bh=kFLi+Mj2Hw219P2rmWvKnRaVWoyNxwMgr4eri0971V0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bxVAhbLoGKTpHCfAYGdPdhsO/mNWIFL7QcCjRbU5Um4hRvj0WYxA1lwjxfZZLm+INlPFR56UImoP1Gx7eZn2RNXY00jua2Ne1FK8JfZocUxbp0118spTuePGGgJB3GVfmb1m1SZsrnvZ9DB8fPptnZsCxFXsI9pvdJKzs63P9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRR9N6sr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713384956; x=1744920956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kFLi+Mj2Hw219P2rmWvKnRaVWoyNxwMgr4eri0971V0=;
  b=eRR9N6sr/+17CLGd05yc7cWE6SzC5qPqZ3KmxcSomNQQ86aaXKH4G/xU
   F6TPJV2oQAdx2OKSjlQ6qkYzzOGJh1CyYJHNWfDEXKw0QST2+ZDoeg740
   vQ782txRmLef92pGUDBm3GRzfJObjZTlXQgWTGoNvy71eiMxlTlrcRQsr
   1fUIIK3D5gYalGd7dpVwgL/FNVc1s6foEZzVtVSxO3jF57toPm9/H9Fah
   dn/o8f+0qE4Wxd0MHNt9mWlNukm5hhzEWwg9zaq61j/BgSWUbril1QCVr
   iEjUGd1nJQM/Gxb2TrJXEU2kFRUeU5ns+VpDUk+nM9ee8Dd/mH6RB1coK
   A==;
X-CSE-ConnectionGUID: oNXQEIZ7ROeHVlT4JcCBrg==
X-CSE-MsgGUID: vcTNjmQtQMSI6SCHYTkzsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19505075"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="19505075"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 13:15:55 -0700
X-CSE-ConnectionGUID: 4ZpPcR25Ss2fpxJCIv27pA==
X-CSE-MsgGUID: sul9Zuu+T3yfyU9vip5Kdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27540008"
Received: from pmstillw-desk1.amr.corp.intel.com ([10.246.118.104])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 13:15:54 -0700
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
To: linux-pci@vger.kernel.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Subject: [PATCH] Documentation: PCI: add vmd documentation
Date: Wed, 17 Apr 2024 13:15:42 -0700
Message-Id: <20240417201542.102-1-paul.m.stillwell.jr@intel.com>
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
 Documentation/PCI/controller/vmd.rst | 51 ++++++++++++++++++++++++++++
 Documentation/PCI/index.rst          |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/PCI/controller/vmd.rst

diff --git a/Documentation/PCI/controller/vmd.rst b/Documentation/PCI/controller/vmd.rst
new file mode 100644
index 000000000000..e1a019035245
--- /dev/null
+++ b/Documentation/PCI/controller/vmd.rst
@@ -0,0 +1,51 @@
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
+- Overview
+- Features
+- Limitations
+
+The Intel VMD provides the means to provide volume management across separate
+PCI Express HBAs and SSDs without requiring operating system support or
+communication between drivers. It does this by obscuring each storage
+controller from the OS, but allowing a single driver to be loaded that would
+control each storage controller. A Volume Management Device (VMD) provides a
+single device for a single storage driver. The VMD resides in the IIO root
+complex and it appears to the OS as a root bus integrated endpoint. In the IIO,
+the VMD is in a central location to manipulate access to storage devices which
+may be attached directly to the IIO or indirectly through the PCH. Instead of
+allowing individual storage devices to be detected by the OS and allow it to
+load a separate driver instance for each, the VMD provides configuration
+settings to allow specific devices and root ports on the root bus to be
+invisible to the OS.
+
+VMD works by creating separate PCI domains for each VMD device in the system.
+This makes VMD look more like a host bridge than an endpoint so VMD must try
+to adhere to the ACPI Operating System Capabilities (_OSC) flags of the system.
+A couple of the _OSC flags regard hotplug support.  Hotplug is a feature that
+is always enabled when using VMD regardless of the _OSC flags.
+
+Features
+========
+
+- Virtualization
+- MSIX interrupts
+- Power Management
+- Hotplug
+
+Limitations
+===========
+
+When VMD is enabled and used in a hypervisor the _OSC flags provided by the
+hypervisor BIOS may not be correct. The most critical of these flags are the
+hotplug bits. If these bits are incorrect then the storage devices behind the
+VMD will not be able to be hotplugged. The driver always supports hotplug for
+the devices behind it so the hotplug bits reported by the OS are not used.
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


