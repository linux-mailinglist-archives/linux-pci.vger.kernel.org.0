Return-Path: <linux-pci+bounces-39014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C79BFC315
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 626C14E6383
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E7346E6D;
	Wed, 22 Oct 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8Og8kVc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1930346E6C;
	Wed, 22 Oct 2025 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140028; cv=none; b=L/ONpsXkMeiNScLiOljfmlcDxdHf4XixG23l72Ocb7QR5yEslSk++9CIj/UzO3SReb8puPfYTBVeyol/ptDWiZKhPoNJTAkztIPc731CP6gqTJ/PHcfik6cgEuUqB3CHZaD3Vr4PkZxyY4wbQDLQlOAEBJxAZhTkcLTj4uoaz1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140028; c=relaxed/simple;
	bh=syDAhxW8a9ZTGx4rBhoijl91vhbCmKS6CmYeLhmIx3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WO/pSMW1prDTPeMk74UKzVGqLeUqqOcB9ddxIfbqNhrhzDdBj9E2nstCKGoIchquVnsMjEUr9LBOv71MfmItJ1DvQggiSADIsSRO+4Ax4ti+XG3M3X619oZwQA2FtJLdI4ae0XZStIG0hyJAgDA+j0jraZ0vDSMqHAJvAWaR1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8Og8kVc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761140026; x=1792676026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=syDAhxW8a9ZTGx4rBhoijl91vhbCmKS6CmYeLhmIx3E=;
  b=m8Og8kVcOvH4FSuxPSBzsCBAzYFtNEmM1zYlXyZ7RXW90FInqXX0hCG8
   3hyG3yDGoP6P2B7VY6vleGDnEadZzK0VTNn4KIOXLjjTCoLTfCPPpM/6K
   nT293+yXNkzFC2nllYzrWucDv01Zpha2JiQW5l/LAScOG3HspKXiZUtdt
   M6A202oHZm2vb+xc8eg2p6H6V7OyVhq1gCueyL7JvP5nlB8spqJrNtQR/
   dBhkPtGRuRUKGvTQDg7qxkoqTdu6U/sMjoPhY/rzBminHDBedXaXmGgTz
   OX3SD2rjuF3moW2fGCgsLEVWg31Wr/n+KiG2xf8CSgNoJia5SApV+VCc0
   g==;
X-CSE-ConnectionGUID: P1yFSgqhQRihpsxORpv3ug==
X-CSE-MsgGUID: aS1MfcQGQjGPempAu1yMlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63325161"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="63325161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:33:45 -0700
X-CSE-ConnectionGUID: y83IkOIRSueholsDShcZYQ==
X-CSE-MsgGUID: LxuUalhSSfuI7YEbJtjZXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183767506"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:33:37 -0700
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
Subject: [PATCH v3 00/11] PCI: Resizable BAR improvements
Date: Wed, 22 Oct 2025 16:33:20 +0300
Message-Id: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>
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

v3:
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
  PCI: Move Resizable BAR code into rebar.c
  PCI: Cleanup pci_rebar_bytes_to_size() and move into rebar.c
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
 drivers/pci/iov.c                           |   9 +-
 drivers/pci/pci-sysfs.c                     |   2 +-
 drivers/pci/pci.c                           | 145 ---------
 drivers/pci/pci.h                           |   5 +-
 drivers/pci/rebar.c                         | 314 ++++++++++++++++++++
 drivers/pci/setup-res.c                     |  78 -----
 include/linux/pci.h                         |  15 +-
 12 files changed, 350 insertions(+), 273 deletions(-)
 create mode 100644 drivers/pci/rebar.c


base-commit: 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
-- 
2.39.5


