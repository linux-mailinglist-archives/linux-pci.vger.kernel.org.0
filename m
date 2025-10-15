Return-Path: <linux-pci+bounces-38163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A2BDD47C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC24074B5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E02C3252;
	Wed, 15 Oct 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dH5tCCvS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77262BEFF0;
	Wed, 15 Oct 2025 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515348; cv=none; b=KFHKIz6B88mExnJz9uH80BUP/DW09+tHSpQ6XvCJGAuo1Ej2FE8ez8L1jW77Q5ImhLxVarYNERSEElsf+qv3+TbxxeRbPLj10H/PgntRLh7p2TAIuckGzaqvVjsps69H4QjnZHsOdTSo2rj31/XN9oxwEDPBjWnAO99aqLyvFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515348; c=relaxed/simple;
	bh=oMfFYXvGiE25w2JX2q/A2uGGYX6++XuGoMMS7Ksqkag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ye0cDZ7Pn8UcwGrG14SY6D35UYRMQHP7Jedl3xPJtraFI+sWYBT3KlnbLbUrJYCimAEDITRpkT0nAV6d7FyC+5fJk34nI+o6Pby2AKGu1BC0f0xnwR+A2p+wo+8qYQY2o0BYeEt4IBN+3P52wlYZzsSuCisjKcCAOWJbYXewuS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dH5tCCvS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515347; x=1792051347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oMfFYXvGiE25w2JX2q/A2uGGYX6++XuGoMMS7Ksqkag=;
  b=dH5tCCvSxb59e/GTTeBvdRHsOhON7NdeCt3Wxqo5IvDt8kkAXfQH74eQ
   Ta0yNBXdWvg2S1ZHr1pqiCNJYSFFXcyHucVO8mLOs7EudP1+Iys0LiuLX
   +D+vhujmQZjzMc13RuI//TuEAxJDnkICOBp0mWEhWyYGS7qly7qmY2pDe
   aQGQ6AMYEKTvtFDfMb2djPE8KZB78DrZ60OZxcoAeRX4ZegAseuxhfrvA
   AdAKN5sA2vrjw+Z0xLo5MWWkh9Cw9XzuuT/EpyD1EbSf1I46tyo3SfjXB
   8zLRRG2KE/YwBNyOS9wUwR2Zd8FCRfbtrBIJQFZ9CV50DiPVfd27vlPK+
   Q==;
X-CSE-ConnectionGUID: 0i5Hgre5TaiBJ8p3+bAGEw==
X-CSE-MsgGUID: 3gjOwuVaRFi9g/vk3Vogww==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891427"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891427"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:25 -0700
X-CSE-ConnectionGUID: xYZcdeLmSUCKMRXlV+YtwQ==
X-CSE-MsgGUID: AOazhnw0QW64pO9/LqTH7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805322"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:21 -0700
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
	uma.shankar@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v5 00/12] VRAM Self Refresh 
Date: Wed, 15 Oct 2025 13:36:58 +0530
Message-Id: <20251015080710.1468409-1-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
  PCI/ACPI: Per Root/Switch Downstream Port allow one aux power limit
    request
  drm/xe/vrsr: Introduce flag has_vrsr
  drm/xe/vrsr: Initialize VRSR feature
  drm/xe/vrsr: Enable VRSR on default VGA boot device
  drm/xe/pm/s2idle: Don't evict user BOs for D3hot and D3cold-VRSR state
  drm/xe/vrsr: Introduce a debugfs node named vrsr_capable

 drivers/acpi/scan.c                          |   3 +
 drivers/gpu/drm/i915/display/intel_display.c |  22 ++
 drivers/gpu/drm/i915/display/intel_display.h |   1 +
 drivers/gpu/drm/xe/display/xe_display.c      |  11 +-
 drivers/gpu/drm/xe/display/xe_display.h      |   2 +
 drivers/gpu/drm/xe/regs/xe_regs.h            |   3 +
 drivers/gpu/drm/xe/xe_debugfs.c              |   3 +
 drivers/gpu/drm/xe/xe_device_types.h         |  12 +-
 drivers/gpu/drm/xe/xe_pci.c                  |  12 +-
 drivers/gpu/drm/xe/xe_pci_types.h            |   1 +
 drivers/gpu/drm/xe/xe_pcode_api.h            |   7 +
 drivers/gpu/drm/xe/xe_pm.c                   | 231 +++++++++++++++++--
 drivers/gpu/drm/xe/xe_pm.h                   |  10 +-
 drivers/pci/pci-acpi.c                       | 189 +++++++++++++++
 include/acpi/acpi_bus.h                      |   3 +
 include/linux/pci-acpi.h                     |  18 +-
 16 files changed, 494 insertions(+), 34 deletions(-)

-- 
2.34.1


