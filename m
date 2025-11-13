Return-Path: <linux-pci+bounces-41121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E20CC58D88
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDCE85420D8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04FB35771D;
	Thu, 13 Nov 2025 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FImPdnPQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACEC17D2
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051204; cv=none; b=t29bDg9D6JI1J1erRWIZIxybW+76QAcJNblmXon6yEANzPT0DOXWaD0lNt4HkVMM0NnasvJFzlyiawBXrRVK1MANc+mbeMIJ0B0Rrrn62gLrDqXULT/tNevFRTJxgqOJ9RrJMFVDd6oFxSzYu7XbxgWljQ5kBpaSW17K7Wttyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051204; c=relaxed/simple;
	bh=q5Skt0OtlAqHnc+PsJMhZYM80doWwAu7rSkxepWYXmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M9zDB1y9UpXDJU24btBwJG7Mxh9X52HerPf9/5tym5HL4KadrJkiagBINoDxRfBom2JNIxE08lJCHAt1Lemd8wWD4bBeZJE83zEcHh8/k0o9yKHdBKmIvhd7XTMR4AYiw9CJ2YXHYwjwblPgH4yCDtMyKcDE6t9hNPHAMo6GtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FImPdnPQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051203; x=1794587203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q5Skt0OtlAqHnc+PsJMhZYM80doWwAu7rSkxepWYXmk=;
  b=FImPdnPQCn/ELYRVHVUDcamQVPH/pHB4WCSdZK7tsWCVF1KnS1JS8jhd
   S3+iRygCXnM5NyXbBaXBhf3MKLZU+K66qwL135EwIsH2nTXmqTB2p76lq
   EJfcZLNi4oboooI1rypVWvEoV2AgmKgDjQJXJRzFLYAK0FlSHtDnVBoN1
   9MC3L8mJ9bWjtZaAA34H13FnPU6hvtg2ApS0N7nsFLgHX5/fFlz7mAVqf
   9i/BpT9nwS1ZQ82BimpIBqtEi0M4cQFVu2H0qmOb6NE3Txxx3Jnwp9deH
   8djTihoYXg+nVWBaG+ms+Oq5PzmsVtUqd3Lizfg9LM1skoovE37v7Ulev
   A==;
X-CSE-ConnectionGUID: sdMX2O/WQeihcKBIpC5CNQ==
X-CSE-MsgGUID: NwrpgsQXQzCptNPBqErBEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65074078"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65074078"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:26:42 -0800
X-CSE-ConnectionGUID: Mp0m3lPLSZSKY1ATLvKgcw==
X-CSE-MsgGUID: OVCixanWRwmVQCKrct9tjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="226864796"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:26:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/11] PCI: BAR resizing fix/rework
Date: Thu, 13 Nov 2025 18:26:17 +0200
Message-Id: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Thanks to issue reports from Simon Richter and Alex Bennée, I
discovered BAR resize rollback can corrupt the resource tree. As fixing
corruption requires avoiding overlapping resource assignments, the
correct fix can unfortunately results in worse user experience, what
appeared to be "working" previously might no longer do so. Thus, I had
to do a larger rework to pci_resize_resource() in order to properly
restore resource states as it was prior to BAR resize.

This rework has been on my TODO list anyway but it wasn't the highest
prio item until pci_resize_resource() started to cause regressions due
to other resource assignment algorithm changes.

BAR resize rollback does not always restore BAR resources as they were
before the resize operation was started. Currently, when
pci_resize_resource() call is made by a driver, the driver must release
device resource prior to the call. This is a design flaw in
pci_resize_resource() API as PCI core cannot then save the state of
those resources from what it was prior to release so it could restore
them later if the BAR size change has to be rolled back.

PCI core's BAR resize operation doesn't even attempt to restore the
device resources currently when rolling back BAR resize operation. If
the normal resource assignment algorithm assigned those resources, then
device resources might be assigned after pci_resize_resource() call but
that could also trigger the resource tree corruption issue so what
appeared to an user as "working" might be a corrupted state.

With the new pci_resize_resource() interface, the driver calling
pci_resize_resource() should no longer release the device resources.

I've added WARN_ON_ONCE() to pick up similar bugs that cause resource
tree corruption. At least in my tests all looked clear on that front
after this series.

It would still be nice if the reporters could test these changes
resolve the claim conflicts (while I've tested the series to some extent,
I don't have such conflicts here).

This series will likely conflict with some drm changes from Lucas (will
make them partially obsolete by removing the need to release dev's
resources on the driver side).

I'll soon submit refresh of pci/rebar series on top of this series as
there are some conflicts with them.

v2:
- Add exclude_bars parameter to pci_resize_resource()
- Add Link tags
- Add kerneldoc patch
- Add patch to release pci_bus_sem earlier.
- Fix to uninitialized var warnings.
- Don't use guard() as goto from before it triggers error with clang.

Ilpo Järvinen (11):
  PCI: Prevent resource tree corruption when BAR resize fails
  PCI/IOV: Adjust ->barsz[] when changing BAR size
  PCI: Change pci_dev variable from 'bridge' to 'dev'
  PCI: Try BAR resize even when no window was released
  PCI: Freeing saved list does not require holding pci_bus_sem
  PCI: Fix restoring BARs on BAR resize rollback path
  PCI: Add kerneldoc for pci_resize_resource()
  drm/xe: Remove driver side BAR release before resize
  drm/i915: Remove driver side BAR release before resize
  drm/amdgpu: Remove driver side BAR release before resize
  PCI: Prevent restoring assigned resources

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  10 +-
 drivers/gpu/drm/i915/gt/intel_region_lmem.c |  14 +--
 drivers/gpu/drm/xe/xe_vram.c                |   5 +-
 drivers/pci/iov.c                           |  15 +--
 drivers/pci/pci-sysfs.c                     |  17 +--
 drivers/pci/pci.c                           |   4 +
 drivers/pci/pci.h                           |   9 +-
 drivers/pci/setup-bus.c                     | 126 ++++++++++++++------
 drivers/pci/setup-res.c                     |  52 ++++----
 include/linux/pci.h                         |   3 +-
 10 files changed, 142 insertions(+), 113 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.39.5


