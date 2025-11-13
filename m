Return-Path: <linux-pci+bounces-41148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB12C5977A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 406C74F14B5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B730748E;
	Thu, 13 Nov 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAv+ZcCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8C270ED9;
	Thu, 13 Nov 2025 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056871; cv=none; b=dORJV+7Hk29jjJ/A9UUt6szDsSY17PTBj5rPkUzafHUJYocRjD/adRshLiMOEnfVkbwzNv0F/t9uLo6OXHBPGvZSmuvgOLoDJBcNt3yq/bYWc2eBnhqFwwfetOyNK5RL650F50rPawFllFi1OdrhhhON8V9mYOY4BTLrlrVdQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056871; c=relaxed/simple;
	bh=nA81Fk9n7LIA98JvH5Hk8Vg1CCfb82xA0OlHFv7E1lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LeyZgcgzZH6zng81z+1nbpWYOGmwffNIQ17YcVdBHaiuLnSCIrDrN8sUdwKYkPMkgscNx7YOdY0wcPraEFc4sj+oUH6FzcORyEnYPpjWLbuDVGqzgd6iGj9jW1NowO4HOk06wr4U4YRTe7F6H38mJWFb3dKWCL9bMfq+RLj0Pac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAv+ZcCv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763056869; x=1794592869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nA81Fk9n7LIA98JvH5Hk8Vg1CCfb82xA0OlHFv7E1lg=;
  b=FAv+ZcCvrxO2Xjel0wURXdH+GyxHhYmDOI4BzQ91jQjJIVBtyAR0RbwR
   2/yylvYvjRSNlywlVKqKejGkvo7lapm0UZIhnqv4bAr9wOlYOKd8fyaZz
   KgpBSx4FszmkQDYmOTYHXAi6xZ5VZaX9WCloXBi535WtwwdR98WvAkEBd
   mTuBKcElYOSQRO2rXHr3xfua4Iufeva29J6htbXIrNU9yRRyWIi29nVRj
   bwRGpzc5AiyM8LCG3EDxJLToNFZ/dJfIPJOoYoJ9n/5fG5Jk6QO5D80Gi
   q7ikTOp4r6q6EddtcB1V3jyYg5Hpui2Ir13QSU+iY1N6lw4s3hWSf75fk
   w==;
X-CSE-ConnectionGUID: NMmqtI4EQRaiD5j5ifDf8w==
X-CSE-MsgGUID: LS6ijG9QRKaW7xZE1L0waw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75826821"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75826821"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:01:08 -0800
X-CSE-ConnectionGUID: amGgviHGTPilQnAo1TeNbw==
X-CSE-MsgGUID: g0CH5JkHSjq0koaZP/hR0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194713548"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:01:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	Andi Shyti <andi.shyti@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 00/11] PCI: Resizable BAR improvements
Date: Thu, 13 Nov 2025 20:00:42 +0200
Message-Id: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci.c has been used as catch everything that doesn't fits elsewhere
within PCI core and thus resizable BAR code has been placed there as
well. Move Resizable BAR related code to a newly introduced rebar.c to
reduce size of pci.c. After move, there are no pci_rebar_*() calls from
pci.c indicating this is indeed well-defined subset of PCI core.

Endpoint drivers perform Resizable BAR related operations which could
well be performed by PCI core to simplify driver-side code. This
series adds a few new API functions to that effect and converts the
drivers to use the new APIs (in separate patches).

While at it, also convert BAR sizes bitmask to u64 as PCIe spec already
specifies more sizes than what will fit u32 to make the API typing more
future-proof. The extra sizes beyond 128TB are not added at this point.

Some parts of this are to be used by the resizable BAR changes into the
resource fitting/assingment logic but these seem to stand on their own
so sending these out now to reduce the size of the other patch series.

This v4 rebases what's currently in pci/rebar on top of the BAR resize
changes in pci/resource as they'd have nasty conflicts otherwise so
they can start to peacefully coexist in the pci/resource branch.

v4:
- Rebased on top of pci/resource changes to solve conflicts

v3: https://lore.kernel.org/linux-pci/20251022133331.4357-1-ilpo.jarvinen@linux.intel.com/
- Rebased to solve minor conflicts

v2: https://lore.kernel.org/linux-pci/20250915091358.9203-1-ilpo.jarvinen@linux.intel.com/
- Kerneldoc:
  - Improve formatting of errno returns
  - Open "ctrl" -> "control"
  - Removed mislead "bit" words (when referring to BAR size)
  - Rewrote pci_rebar_get_possible_sizes() kernel doc to not claim the
    returned bitmask is defined in PCIe spec as the capability bits now
    span across two registers in the spec and are not continuous (we
    don't support the second block of bits yet, but this API is expected
    to return the bits without the hole so it will not be matching with
    the spec layout).
- Dropped superfluous zero check from pci_rebar_size_supported()
- Small improvement to changelog of patch 7

Ilpo Järvinen (11):
  PCI: Move Resizable BAR code to rebar.c
  PCI: Clean up pci_rebar_bytes_to_size() and move to rebar.c
  PCI: Move pci_rebar_size_to_bytes() and export it
  PCI: Improve Resizable BAR functions kernel doc
  PCI: Add pci_rebar_size_supported() helper
  drm/i915/gt: Use pci_rebar_size_supported()
  drm/xe/vram: Use PCI rebar helpers in resize_vram_bar()
  PCI: Add pci_rebar_get_max_size()
  drm/xe/vram: Use pci_rebar_get_max_size()
  drm/amdgpu: Use pci_rebar_get_max_size()
  PCI: Convert BAR sizes bitmasks to u64

 Documentation/driver-api/pci/pci.rst        |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   8 +-
 drivers/gpu/drm/i915/gt/intel_region_lmem.c |  10 +-
 drivers/gpu/drm/xe/xe_vram.c                |  32 +-
 drivers/pci/Makefile                        |   2 +-
 drivers/pci/iov.c                           |  10 +-
 drivers/pci/pci-sysfs.c                     |   2 +-
 drivers/pci/pci.c                           | 149 ---------
 drivers/pci/pci.h                           |   5 +-
 drivers/pci/rebar.c                         | 325 ++++++++++++++++++++
 drivers/pci/setup-res.c                     |  85 -----
 include/linux/pci.h                         |  15 +-
 12 files changed, 361 insertions(+), 285 deletions(-)
 create mode 100644 drivers/pci/rebar.c


base-commit: 5388d5c3a95dd4f28714a4689c2877ba8c990b6b
-- 
2.39.5


