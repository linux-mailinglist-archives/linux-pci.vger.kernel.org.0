Return-Path: <linux-pci+bounces-44630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89100D1A4EA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7D930674CA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E93093BB;
	Tue, 13 Jan 2026 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hT2yjFUY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020452EC084;
	Tue, 13 Jan 2026 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321921; cv=none; b=rVjStsItXaNDH4mLDzYIcdrlRMVVDdtgKbehI0R+XsoTeEnnpzo/QPkCBFY8Ctvfce/vTvAmyy9seJiHiNnKVqB7To+ezKMEPAJ49PCrOSbORnTGWJN/TX1eShZZKJ5B6fe5dSGbM+s8SH/umoLs46HvSXrYDIpukIRr63WkbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321921; c=relaxed/simple;
	bh=elOL5vf13bvux5sGmCgBwMWCcvFXHP/z36pbMRr677I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKfRiVmiErhbe5QxQj/f2U6leN6dhcHsWm1JBah1lnCcJotWkUXBljSsNWIq9XmI+gqT+XARk6ruQKkZPlFHFD3Yqsz48jGDKDWiYKD/U4vQVkpyaEFzjyS0fFlJ6ufAyXE+70OJzKlhhgATBkFpMnc0suGGHW0kUz3zihDjMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hT2yjFUY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321919; x=1799857919;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=elOL5vf13bvux5sGmCgBwMWCcvFXHP/z36pbMRr677I=;
  b=hT2yjFUY1uRwZUvvXmyAZlq34aqjdjP20FqOirVFBR3Q9J7IOJTuEbR6
   lCvsMbkQtfzav9IOXeEQbZrMs6MtzCJ887IdjNw1SHwIRZq/JbVowYfcr
   8p55Mr+cfmtGKds4UQhsND7THJ1fxqeWt7dZ+MFbOppF/eZbydWbMCI7d
   F8VEvZBexdLi+RYeBC7MLMCV/qo11R8gYGlIlRkUQd+kRWVrMztr/pPaX
   wogWseka67sWn+6+bkk0Gz/zmI4TBFmnw+4SDnb8tWH4go1mavKdRlo8U
   FsOO6/TJlPB5auUVzPD9Z++sovU+OYMWIX+Pn+LzEViAjAHSm9Mh9E9lo
   w==;
X-CSE-ConnectionGUID: L4R73Q4TSR6PgZzExic4RQ==
X-CSE-MsgGUID: JzYd0QlwSn2fuh/m2OkV+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69520981"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69520981"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:31:58 -0800
X-CSE-ConnectionGUID: DAOd7/YiRayTyK8TA8RxQg==
X-CSE-MsgGUID: ci9wyHnURjSS6rWQ0y12ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060102"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:31:54 -0800
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com,
	karthik.poosa@intel.com,
	matthew.auld@intel.com,
	sk.anirban@intel.com,
	raag.jadav@intel.com
Subject: [PATCH v6 00/12] VRAM Self Refresh 
Date: Tue, 13 Jan 2026 22:12:01 +0530
Message-ID: <20260113164200.1151788-14-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v6:
  - Addressed review comments from Rafael J. Wysocki.
  - Added now patch to refactor PM Sleep Ops

Changes in v5:
  - Added Co-developed by, whereever necessary
  - Addressed review comments 
  - Added new patch to handle vrsr in s2idle
    drm/xe/pm/s2idle: Don't evict user BOs for D3hot and D3cold-VRSR state  

Changes in v4:
  - Resolved build warnings

Changes in v3:
 PCIe ACPI Patches:
  - dropped the notifier block code and added patch to allow only one Aux
    power limit request per root port (Rafael J. Wysocki)
  - Addressed Review comments (Rafael J. Wysocki, Bjorn Helgaas)

 Xe Pacthes:
  - Addressed Review comments (Bjorn Helgaas)

Anshuman Gupta (6):
  PCI/ACPI: Add D3cold Aux Power Limit_DSM method
  PCI/ACPI: Add PERST# Assertion Delay _DSM method
  drm/xe/vrsr: Detect VRSR Capability
  drm/xe/vrsr: Refactor d3cold.allowed to a enum
  drm/xe/pm: D3cold target state
  drm/xe/vrsr: Enable VRSR

Badal Nilawar (6):
  drm/xe/vrsr: Introduce flag has_vrsr
  drm/xe/vrsr: Initialize VRSR feature
  drm/xe/vrsr: Enable VRSR on default VGA boot device
  drm/xe/pm: Refactor PM Sleep Ops
  drm/xe/pm/s2idle: Don't evict user BOs D3cold-VRSR state
  drm/xe/vrsr: Introduce a debugfs node named vrsr_capable

 drivers/gpu/drm/i915/display/intel_display.c |  22 ++
 drivers/gpu/drm/i915/display/intel_display.h |   1 +
 drivers/gpu/drm/xe/display/xe_display.c      |  11 +-
 drivers/gpu/drm/xe/display/xe_display.h      |   2 +
 drivers/gpu/drm/xe/regs/xe_regs.h            |   3 +
 drivers/gpu/drm/xe/xe_debugfs.c              |   2 +
 drivers/gpu/drm/xe/xe_device_types.h         |  12 +-
 drivers/gpu/drm/xe/xe_pci.c                  |  76 +++++-
 drivers/gpu/drm/xe/xe_pci_types.h            |   1 +
 drivers/gpu/drm/xe/xe_pcode_api.h            |   7 +
 drivers/gpu/drm/xe/xe_pm.c                   | 244 ++++++++++++++++---
 drivers/gpu/drm/xe/xe_pm.h                   |  14 +-
 drivers/pci/pci-acpi.c                       | 196 +++++++++++++++
 include/linux/pci-acpi.h                     |  18 +-
 14 files changed, 564 insertions(+), 45 deletions(-)

-- 
2.52.0


