Return-Path: <linux-pci+bounces-39974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA93C270A7
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BBE3AF7DC
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 21:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B76325714;
	Fri, 31 Oct 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7x16Nxo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F39326D4A
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946147; cv=none; b=sJYYZYYc80jHm9v0A3/MD5EIsp2qbOFg0p29WLXIguNxc8/26fAMdoCSo5NzSvkiByDuG799RKJym7Xve15YMhZAmkIq6Ki+2NRyC8Rj+NYviANn6i58Lx0u79Ln0uRjXBB8gxCzgTHFbDuUt9QztJgJiqd2RmTXIghB2iBiTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946147; c=relaxed/simple;
	bh=1MoSqvMx8H64Yz4FuXIdtzLwQ2vFAw6PyBFGUiL5j+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGHwTHA9dy4ic3kvDDnSF5OpkWk+Jxmvp4aAJ9BoZ3o65jXil1GqXouGH6CKjrsjYJYsd5mv1QpvVKRYp8WkL/rUM5ZMrXmjWlA2QYzqCfWVKELkr4vyw8UVwLwhtsswHUdxIGKrXdhTWfH+NXbjQ110cJ+zq8/7k1fswOgHP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7x16Nxo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761946146; x=1793482146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1MoSqvMx8H64Yz4FuXIdtzLwQ2vFAw6PyBFGUiL5j+c=;
  b=O7x16NxoWVjgJU2OZ4boYoU1rZ4EMYTpZNXoCkLPMYBETCkhvXdnZBiw
   KBJyTVWfvLCxSiTno91pFZ8Iu7blgq1wnCIZskDlRQaB2DPzCOkDkkVko
   Hrxw4dq/kORKoH5+KBAwLG+VstCG42kmCes/VcfAPxHqz5c8AoX5Dq1Lf
   AE5WeNd8E0BmclFC00UWRywuAblFhUTUZN6Cl6vkEvsKBQgb2u84Fp+rN
   Kh4c01UstpLM/17w5QWAeTOQpo7mPF5/bOSU9P0QfTdqXdf0WQMac5/zP
   8sfprSpf6lUt46DigtNnFwR+czIGHdo9RHsiDHtbsSdtxAgYZZb9a4fy0
   g==;
X-CSE-ConnectionGUID: BhbRBnzXSLysJkix/ZnSjA==
X-CSE-MsgGUID: YG4oZv1AT6mOc0eK+x8Adg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64002417"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="64002417"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 14:29:00 -0700
X-CSE-ConnectionGUID: vDZ17qcORfmMuLAmYxOPMw==
X-CSE-MsgGUID: Cus9rZMRRuCStx8+jL8v6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="216986671"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2025 14:28:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v8 6/9] PCI: Establish document for PCI host bridge sysfs attributes
Date: Fri, 31 Oct 2025 14:28:58 -0700
Message-ID: <20251031212902.2256310-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031212902.2256310-1-dan.j.williams@intel.com>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding more host bridge sysfs attributes, document the
existing naming format and 'firmware_node' attribute.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge | 19 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
new file mode 100644
index 000000000000..8c3a652799f1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -0,0 +1,19 @@
+What:		/sys/devices/pciDDDD:BB
+		/sys/devices/.../pciDDDD:BB
+Contact:	linux-pci@vger.kernel.org
+Description:
+		A PCI host bridge device parents a PCI bus device topology. PCI
+		controllers may also parent host bridges. The DDDD:BB format
+		conveys the PCI domain (ACPI segment) number and root bus number
+		(in hexadecimal) of the host bridge. Note that the domain number
+		may be larger than the 16-bits that the "DDDD" format implies
+		for emulated host-bridges.
+
+What:		pciDDDD:BB/firmware_node
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) Symlink to the platform firmware device object "companion"
+		of the host bridge. For example, an ACPI device with an _HID of
+		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
+		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
+		format.
diff --git a/MAINTAINERS b/MAINTAINERS
index ebf6988666eb..9b961fb11b09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19896,6 +19896,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 F:	Documentation/PCI/
 F:	Documentation/devicetree/bindings/pci/
 F:	arch/x86/kernel/early-quirks.c
-- 
2.51.0


