Return-Path: <linux-pci+bounces-25073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF4A77F13
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC7A188FFB8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7749B1E6DC5;
	Tue,  1 Apr 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SI+PyBrT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B020B819;
	Tue,  1 Apr 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521766; cv=none; b=leRXW4Mwcgl+JglMmOxC44VcbKj3Q0Ze5lKAxYP8iYnQHDeSdk3ynQSwAE24fK7Qzw0Z6WvwBfqtIlg0eWq1hVK0RfbwcVGLd9Suq0gFuxJFXlJ5Z8PYz9Xv6Wh21eUnWBiHf47A+9jz2pKdArO9JkEiR5QMWBsfNQFMjmChHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521766; c=relaxed/simple;
	bh=y71/VVB6+FiUQ2JljcwF7CHK8xdtsmHsibSeicQnRek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/IGg0xqoMooGQq5M4R9flzPbVwBl76WNE7Aio9a9e2I2OjbcK6vFngGnLPbGbdd2Nx5UCBjUq97yer3eUNAHHuG6PmVo+EmRBF0XowLU3n+rJg887VQht8FSMQtsE4WghBvix0fa7+TdGOT2k7dJIi8WKaAX7oj9qGumoptK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SI+PyBrT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521765; x=1775057765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y71/VVB6+FiUQ2JljcwF7CHK8xdtsmHsibSeicQnRek=;
  b=SI+PyBrT8xJte705I0wL9MXQqyFeWseQ3G35nxXD/4RginXhq7Uj/N7H
   O2LTueVpEdUKPrrWy0b28FR1KHSwfmNqAa+7up+8Hy3mTbsAOknVLbpMb
   kzyhcRSvES83xhxbVqYNJbk5H65gH5cFaj+6f8DBGVrvsNhMmuAAGjh3K
   ra5wIsLXZhPuOH7aUB3U//Fvgw6Ej2vNuJh6DbptsnsOX+SXYJyHQJXoI
   hy/T/JM0UiH/VNPMMgpRQQFA7CTYV4ioL/vYjyylZfxdZkkKokVmeQeIq
   t9/2cbENUN1KM6hkSL3gS5mmb4mBaQJ7pItVBq1u0hrBKy6pIcJ1EPqyx
   A==;
X-CSE-ConnectionGUID: 8N0u64IvTE6LaqE7b23T9w==
X-CSE-MsgGUID: mCpTX2tnS0+Y8D31JZ0TfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324747"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324747"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:04 -0700
X-CSE-ConnectionGUID: m/vp4MPWT0WHv3/2XXL3Ww==
X-CSE-MsgGUID: SuYRzfubRp+PubW2UpshRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410715"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:00 -0700
From: Anshuman Gupta <anshuman.gupta@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	badal.nilawar@intel.com,
	anshuman.gupta@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: [PATCH 00/12] VRAM Self Refresh 
Date: Tue,  1 Apr 2025 21:02:13 +0530
Message-ID: <20250401153225.96379-1-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision has fixed the below review comment on RFC[1] series.

PCIe ACPI Patches:
- Break the _DSM {10, 11} Patch for different _DSM Method "D3cold Aux Power Limit", "PERST# Assertion Delay"
  (Bjorn Helgaas)
- Remove the Battlemage-specific language from commit log and Document that this implementation
  does not track and aggregate requests from all child devices `below the Downstream Port.
  (Bjorn Helgaas)
- Add Rev 3.3 along with Section in commit log.
- Address cosmetic review comment.
- Added a notifier block.

Xe Pacthes:
- %s/VRAM_/VRAM_SR/
  (Rodrigo)
- %s/d3cold.allowed/d3cold.target_state
  (Rodrigo)
- Add has_vrsr flag and refactor pci_acpi_aux_power_setup.
  (Rodrigo)
- Reorder the xe_d3_state enum.
  (Karthik)
- Use default VGA gpu to enable VRSR.


VRAM Self Refresh

This revision has fixed the below review cpmment on RFC[1] series.

PCIe ACPI Patches:
- Break the _DSM {10, 11} Patch for different _DSM Method "D3cold Aux Power Limit", "PERST# Assertion Delay"
  (Bjorn Helgaas)
- Remove the Battlemage-specific language from commit log and Document that this implementation
  does not track and aggregate requests from all child devices `below the Downstream Port.
  (Bjorn Helgaas)
- Add Rev 3.3 along with Section in commit log.
- Address cosmetic review comment.
- Added a notifier block.

Xe Patches:
- %s/VRAM_/VRAM_SR/
  (Rodrigo)
- %s/d3cold.allowed/d3cold.target_state
  (Rodrigo)
- Add has_vrsr flag and refactor pci_acpi_aux_power_setup.
  (Rodrigo)
- Reorder the xe_d3_state enum.
  (Karthik)
- Use default VGA gpu to enable VRSR.

[1] https://patchwork.freedesktop.org/series/145342/

Anshuman Gupta (8):
  PCI/ACPI: Add D3cold Aux Power Limit_DSM method
  PCI/ACPI: Add PERST# Assertion Delay _DSM method
  PCI/ACPI: Add aux power grant notifier
  drm/xe/vrsr: Detect VRSR Capability
  drm/xe: Add PCIe ACPI Aux Power notifier
  drm/xe/vrsr: Refactor d3cold.allowed to a enum
  drm/xe/pm: D3Cold target state
  drm/xe/vrsr: Enable VRSR

Badal Nilawar (4):
  drm/xe/vrsr: Introduce flag has_vrsr
  drm/xe/vrsr: Initialize VRSR feature
  drm/xe/vrsr: Enable VRSR on default VGA boot device
  drm/xe/vrsr: Introduce a debugfs node named vrsr_capable

 drivers/gpu/drm/xe/display/xe_display.c |  28 ++-
 drivers/gpu/drm/xe/display/xe_display.h |   2 +
 drivers/gpu/drm/xe/regs/xe_regs.h       |   3 +
 drivers/gpu/drm/xe/xe_debugfs.c         |  20 ++
 drivers/gpu/drm/xe/xe_device_types.h    |  15 +-
 drivers/gpu/drm/xe/xe_pci.c             |  13 +-
 drivers/gpu/drm/xe/xe_pcode_api.h       |   8 +
 drivers/gpu/drm/xe/xe_pm.c              | 236 ++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_pm.h              |   9 +-
 drivers/pci/pci-acpi.c                  | 159 ++++++++++++++++
 include/linux/pci-acpi.h                |  26 +++
 11 files changed, 490 insertions(+), 29 deletions(-)

-- 
2.43.0


