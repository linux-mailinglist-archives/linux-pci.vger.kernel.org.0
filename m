Return-Path: <linux-pci+bounces-22237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3799A42848
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C9D168384
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF09262D10;
	Mon, 24 Feb 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUSvn+D3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909A2627F2;
	Mon, 24 Feb 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415814; cv=none; b=L97hAJAlASW6yxgbBbguw3knDWh+Chl1Unq+GE/sB3k2zbXcT5VOSnJvdyQQg+o3QPHk7N41xRzNmqJ2w4fUc1ht7JZv+v6OtdYRMcAfmYiR3vfyV53b+Vel8dGXrHQp+As5koGD85ERCKRtynPfC5PfzESmPm9z+zMz/DxkEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415814; c=relaxed/simple;
	bh=PBOLO0GBx96JGT4qrXhptEiNiHxk8kr/C/IWh68LCnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+5MKRnkWZ3Okqp6svt8aUEA+mhHPugpznpdiZ3/DMGzDyb3Z39e8J54XRReHFXv1lB7/nayIA1HQwKusLgV5ieTs8kQmdt80wrk8YjyGj4W7oUC1zS+4Y7QR0K0vvCgdIns1ZUOSay97m8LRouWWs71sEKvqeWsa/NFBqpIk2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUSvn+D3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740415812; x=1771951812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PBOLO0GBx96JGT4qrXhptEiNiHxk8kr/C/IWh68LCnE=;
  b=lUSvn+D3rfs43hERl5i7agfziYy+Ffdal2sbWXM+4l6jP7OHTaP/CibC
   MAr/15DIOlmEsDzGj4qNtV4ZI/BtEs4cXtkx4bVIRzuYMy/6T2DROzUkU
   Ot4EF3f2MEXnDvk0OxTFCdl8xZdc4HuT5K7XE+LXxB10pHLm8abFXeU0v
   FIQGCZDu5DLhO/g+/7ctkuINUsa9QPcP7t575/rgtewp1nOexCF4UbC9x
   Pu/StVB+P7gk1DHoAezUqdIKhdY1g+SxdAK1vz6Gs+p9o3vGAW4t6R4B+
   wlD9hoeh0oXwVTSwQk2+z8bHq1gY93feDPT2t9r5Dk6tHnMAlpd6MPUUh
   A==;
X-CSE-ConnectionGUID: Ocyn8sOZSp+eGxWrqTFZcA==
X-CSE-MsgGUID: ieR3ORtKTqW1d1W5sCnL8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41063169"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41063169"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:11 -0800
X-CSE-ConnectionGUID: xVfYQ1ZXS96ynZ/alvZgww==
X-CSE-MsgGUID: FHhZOsdXSW+BQ+FjHvPgNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121032312"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:08 -0800
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
	kam.nasim@intel.com,
	Anshuman Gupta <anshuman.gupta@intel.com>
Subject: [RFC 0/6] VRAM Self Refresh
Date: Mon, 24 Feb 2025 22:18:43 +0530
Message-Id: <20250224164849.3746751-1-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling VRAM Self Refresh on Intel BMG GPU.
VRAM Self Refresh feature requires XeKMD
to request for D3Cold Aux Power Limit and PERST
Assertion Delay by calling _DSM 10 and _DSM 11 method.

Reference: PCI Firmware Specification
Section {4.6.10, 4.6.11}.

Anshuman Gupta (5):
  PCI/ACPI: Implement PCI FW _DSM method
  drm/xe/vrsr: Detect vrsr capability
  drm/xe/vrsr: Refactor d3cold.allowed to a enum
  drm/xe/pm: D3Cold target state
  drm/xe/vrsr: Enable VRSR

Badal Nilawar (1):
  drm/xe/vrsr: Apis to init and enable VRSR feature

 drivers/gpu/drm/xe/display/xe_display.c |  22 +++
 drivers/gpu/drm/xe/display/xe_display.h |   1 +
 drivers/gpu/drm/xe/regs/xe_regs.h       |   3 +
 drivers/gpu/drm/xe/xe_device_types.h    |  10 +-
 drivers/gpu/drm/xe/xe_pci.c             |   4 +-
 drivers/gpu/drm/xe/xe_pcode_api.h       |   8 +
 drivers/gpu/drm/xe/xe_pm.c              | 185 ++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_pm.h              |   9 ++
 drivers/pci/pci-acpi.c                  | 123 ++++++++++++++++
 include/linux/pci-acpi.h                |  13 ++
 10 files changed, 358 insertions(+), 20 deletions(-)

-- 
2.34.1


