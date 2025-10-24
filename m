Return-Path: <linux-pci+bounces-39219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6550C0413B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC5DE4F2125
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B605E221710;
	Fri, 24 Oct 2025 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gh/f7OO1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3051C860C
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271464; cv=none; b=rUSOAjBLXVGzi5Px1SfLAKwgKiboJPFJiRIpGMqdz2hclIhrcrkobSGKW/J2Lcv12LTnwiYAA+iUWQXn/iIuhqfoGFvrPLwzcvrBucYkLx6zGQKBPcMg8ZBcXO33nij7K1OQQTXa0muxaC1op8SzReWNE8LnBpWqthKU95m/LsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271464; c=relaxed/simple;
	bh=gqmP6v7SBzdUu4/0ddGH3gnejwqBt/2HoaQemSO54SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJbklwGCeXMrywBk934yQGMim4wo7UogebXU8lXd9vjPeVGcE/DbEq+JuxFyb/h7dl3pO8VvE6gHl4EvolyrOJPShnfnctRDLccrX74OgcZpeuBOWd0U0D61CQHTaom5NDuN4E+yI98E+pO/0ntyQ2fkNDFDDJY3w0upiRsNvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gh/f7OO1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761271462; x=1792807462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqmP6v7SBzdUu4/0ddGH3gnejwqBt/2HoaQemSO54SM=;
  b=gh/f7OO14QUFmNA29GBeuY6Nqp3WcS3GEPWsA4pQqUQib4AWWbuIQd/M
   jLJyjBvDEWrxOtsRIeycwtcJXAB+JRWoYBfOhVoIRdQgB7olQQzAUpxla
   ftFS3Up3QwKik+B+LHrS/Wq7a8vq1Jvo55PnGVwZqY88AOmXNLBbdT0DM
   Ft2BVFmgUJihRb6Nx1X3qdUSnSSXXIeR2cTxwtQoNjUy4m87qIbI1aQ8D
   eW1CL8woF5bHeIEAjZRge8heizRCmnwSWAUdurLF3OYY8N4iJlinQsBUz
   CcV+g3nWQP4yp81KCs6mr9ubENFUDTIvwqqvYAjKHMR+smjKUj+CQbANn
   g==;
X-CSE-ConnectionGUID: jumKydR+Qi6gxOduAPUH8g==
X-CSE-MsgGUID: iwR0mX0rRjyoKQFTDNTWDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67319380"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="67319380"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:04:19 -0700
X-CSE-ConnectionGUID: IaSsUruJTRKhKlwh6VXRlQ==
X-CSE-MsgGUID: W9zeHdXsSraPzrr3dbd5ew==
X-ExtLoop1: 1
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa003.fm.intel.com with ESMTP; 23 Oct 2025 19:04:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: aik@amd.com,
	yilun.xu@linux.intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH v7 6/9] PCI: Establish document for PCI host bridge sysfs attributes
Date: Thu, 23 Oct 2025 19:04:15 -0700
Message-ID: <20251024020418.1366664-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024020418.1366664-1-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
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


