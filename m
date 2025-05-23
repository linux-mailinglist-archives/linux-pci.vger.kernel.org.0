Return-Path: <linux-pci+bounces-28341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F2CAC2A0E
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF485458F5
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D829AB02;
	Fri, 23 May 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZiiSFHm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6482989A7;
	Fri, 23 May 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026797; cv=none; b=jXZg8E+DFSgXVKn/CSR8ntIemJWCMG/+SlAHsMyTC1uAbQNDfDzs8Q3TfhVteMmLqmMh/SR4Yv21fAldVX5b/vh4MG0UedpAb42Rt8BVqogi7gC053uWBJ6mQnaQvs8bPZBozSDeINwLgIQ1AFvUz5yBNQ22JZrbbFVHtifr4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026797; c=relaxed/simple;
	bh=Gd3nxeskl+1e/UW3Q2boLJWQgtOmeyicUfEvA9zMX8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XIZAsbtJAfRXCHiUPjG+eaeRux7HQaNwdXW6mj+xfOqkteBVi+RnlI37c+eIvNuB6w7GbQJj+ZXJ23WAJmP1HymOzjK3aiTaHO8GeiOayZB6wym8WZckV7H1a5BUZz7dSQbTTVvqI/HSz4rzKvkph7hkk4CHNSgUj7F+ihHlCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZiiSFHm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026796; x=1779562796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gd3nxeskl+1e/UW3Q2boLJWQgtOmeyicUfEvA9zMX8o=;
  b=WZiiSFHmuRehbKPGRDZfnx9njS/emQ0w/XcGrpbAmjwhrA53Lbf+BJ6Z
   Bqccs5790DGlybvR6ByCPBisCsJ/BYh5PQbG49nSgSq9Fv3jTicA8YmQZ
   VtngAf20+DQg9nrT96IEz5LvvOuGvBEPLnNPxGNG9NILY7nugzQw30zWk
   Q4lnjMfJnwjCXrbA+RRLlvQQkL/ZkNus5dwhgwAyuyakL886kMKsbUjiD
   ykKVP3nJrmpGkzmkx30t3DNro84ItgnCnqox7TpwokQjKA/QPlmqR1S+L
   yV3DI0ah1smuktwWNz8Mtwc8hAQv22tOIPwJNd2BmWr/DS1Qh/zL2bIlE
   A==;
X-CSE-ConnectionGUID: r+xua2LOSJaWvLNj+HT2Uw==
X-CSE-MsgGUID: 3olzET0YQUO4kJQAlYoQyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61498407"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61498407"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:59:48 -0700
X-CSE-ConnectionGUID: ESAXp8dLSTu3fuTTRB37eQ==
X-CSE-MsgGUID: QTxSXvT0Ql2jmOlJ+O1DIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141758822"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:59:44 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: [PATCH v3 00/11] VRAM Self Refresh 
Date: Sat, 24 May 2025 00:31:44 +0530
Message-Id: <20250523190155.2623462-1-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision has fixed the below review comment on rev2 series.

PCIe ACPI Patches:
- dropped the notifier block code and added patch to allow only one Aux
  power limit request per root port (Rafael)
- Addressed Review comments (Rafael J. Wysocki, Bjorn Helgaas)

Xe Pacthes:
- Addressed Review comments (Bjorn Helgaas)



Anshuman Gupta (6):
  PCI/ACPI: Add D3cold Aux Power Limit_DSM method
  PCI/ACPI: Add PERST# Assertion Delay _DSM method
  drm/xe/vrsr: Detect VRSR Capability
  drm/xe/vrsr: Refactor d3cold.allowed to a enum
  drm/xe/pm: D3Cold target state
  drm/xe/vrsr: Enable VRSR

Badal Nilawar (5):
  PCI/ACPI: Per root port allow one Aux power limit request
  drm/xe/vrsr: Introduce flag has_vrsr
  drm/xe/vrsr: Initialize VRSR feature
  drm/xe/vrsr: Enable VRSR on default VGA boot device
  drm/xe/vrsr: Introduce a debugfs node named vrsr_capable

 drivers/acpi/scan.c                     |   1 +
 drivers/gpu/drm/xe/display/xe_display.c |  28 +++-
 drivers/gpu/drm/xe/display/xe_display.h |   2 +
 drivers/gpu/drm/xe/regs/xe_regs.h       |   3 +
 drivers/gpu/drm/xe/xe_debugfs.c         |  20 +++
 drivers/gpu/drm/xe/xe_device_types.h    |  12 +-
 drivers/gpu/drm/xe/xe_pci.c             |  13 +-
 drivers/gpu/drm/xe/xe_pcode_api.h       |   7 +
 drivers/gpu/drm/xe/xe_pm.c              | 206 +++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_pm.h              |   9 +-
 drivers/pci/pci-acpi.c                  | 167 +++++++++++++++++++
 include/acpi/acpi_bus.h                 |   2 +
 include/linux/pci-acpi.h                |  16 +-
 13 files changed, 456 insertions(+), 30 deletions(-)

-- 
2.34.1


