Return-Path: <linux-pci+bounces-28596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA70BAC7C72
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AD24A4CBF
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE87B28E560;
	Thu, 29 May 2025 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6d4Jq0M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312C207A0B;
	Thu, 29 May 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517287; cv=none; b=n5TAbO0jjDFfEcVdsmuSGRxd1BvaWiOC5pLgBYJ1Jc+GuTdmbbesl5+eRQTNhkxTv0QIfSxjBf7ZIWeHLWH8nEie3p3v9TdlzzCZVkUb78Yvq81fOMhtzlAa1ra6sjmUhM3R/5quoP+nliFDO0D82pXTGSC3Ad2WXvZGS6zmUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517287; c=relaxed/simple;
	bh=m9cw6xNYlfVUW5fGzoPuQKjTw1qi9nFw9HPmQqmdH0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S94mVcrkvLwRvECGN98b02J2wdBkiHtwt/IXXWIJjrH1gZnKiwrAbc4PfhoIe1VSyv8rO5SfuOp2zWLvSotWyNQK5vqKZjebfNY+Ad5UKFWHj75fBi0ZMv8GUcMDt9Xt4y5HQB4qPQHU1soDPN1cSRMJaiP4/X4tjoOnLO4tTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6d4Jq0M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748517286; x=1780053286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m9cw6xNYlfVUW5fGzoPuQKjTw1qi9nFw9HPmQqmdH0U=;
  b=m6d4Jq0Myg5QrH7kpytdB547zzYkShYm7fW5qehIWWWXAfPHXPapIG98
   1yBI7csA8PN3Nz5VObxgRjed8bBg5TuBbE/OkfQrx0i6C6PCXytHKGKMu
   WZ7hFzbQnXiki2f2JKhExrbiqoSJdVRzH1+P+VeHxrxSSIkvUiAeCwLMe
   JF45vISbUxf2/CJDO76+vlwNcEMya2mkGG1ULdOXP4Ga+gK/NTXdrUA3V
   pmRXzQ7CEnr7a8OmzENnwYgLWEH6aCUO2ruv16LSOuxG+Cic4meX5UxpI
   cIRYhOP2TJmII+NrIkagxnA+aBbIoDUV8oGk5d0O+fv8vPtI8KwATzOZh
   Q==;
X-CSE-ConnectionGUID: 6PQMAYpvSDu9wcKidWkVdQ==
X-CSE-MsgGUID: WlNfqsmxQkeupxaSclhdpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68123086"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="68123086"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:14:45 -0700
X-CSE-ConnectionGUID: vDOsLtxwTs6/Pbg/56o+Rw==
X-CSE-MsgGUID: q4Kiwg8dTcyc+AInkJMsyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="143510364"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:14:42 -0700
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
Subject: [PATCH v4 00/11] VRAM Self Refresh 
Date: Thu, 29 May 2025 16:46:43 +0530
Message-Id: <20250529111654.3140766-1-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


