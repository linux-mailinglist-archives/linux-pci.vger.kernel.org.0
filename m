Return-Path: <linux-pci+bounces-36124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47787B5743D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAE0164AB2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1214D1F30BB;
	Mon, 15 Sep 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gukKyiqQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEC1ADFFB;
	Mon, 15 Sep 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927656; cv=none; b=WzWXSRxjcRJkCK6wQrOWj4fPDldLhK44OkTXiPVCph+baHwHEH+EGBAlUv+o0XATEF18lXkHMz9GGb+V09cx51BNsh/d9JZmjkG1MG1VyL9bRcO9p8Defxp8NOLwk0F3eqsW4BRfvUleokfV167nkxYg3Ax2Md1ktVgFOZ4GW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927656; c=relaxed/simple;
	bh=AxVnpcaVMfU77Gl4c7H9h18KifP1c77MUN1TjexI22g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=e+cX1u7nCR65JuD0s2+No1B1rcc1ppD4tDJjgslTbVw/QBrtNjYiN2mx0ZjM9d2mdKwxGOMLZYgYB69VfIyZhvX+brq/9qHy26VoSaGJF+QQiMLcIe06WzGvzv1uPsaYxA2zwfIcxRfvUK/eRHKV+u8pNC1RftZEEEYUIy93WwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gukKyiqQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757927654; x=1789463654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AxVnpcaVMfU77Gl4c7H9h18KifP1c77MUN1TjexI22g=;
  b=gukKyiqQBSdhjUIxkuir1JQIc4Png2fvrfUVFC07D1EbucytCwSPLL6k
   SuE25OW1E1SmiCZ/OMUSFt3pBqPsnG1TKuB6vkUD62YjC+5IUuIDhggDN
   R5hlEMIsK8+wrU46e2TkWyb/Ymt+OWSixyQiO3OUfSRmF2qxvGc08Xios
   4Y7qTIpFDaL+uIQfUWrGr3QW/fdZZa1infQPgB9aaJ0WlL453jUq+nfyl
   uyhOJ/ZUprGJnOQ80xMP/RkdRfsRZScxpdrIS7qe7+Te4zUYi5AMZZz+8
   24DvxSFLgy5CkR3iut8ez0/V498FptBu11ofiMcXbq+FQOzTRe/ZElC5I
   w==;
X-CSE-ConnectionGUID: whd/oK6BTzOUbBNnJBLiGw==
X-CSE-MsgGUID: 186CdedRTGeLPd7Rd/khNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="85610445"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="85610445"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:14:13 -0700
X-CSE-ConnectionGUID: d9gd8qNIQe2edfK9Cn3AtQ==
X-CSE-MsgGUID: LGbc/gSNTj2vnhflODtAAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="174497118"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 02:14:05 -0700
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
	?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Michael J . Ruhl" <mjruhl@habana.ai>
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/11] PCI: Resizable BAR improvements
Date: Mon, 15 Sep 2025 12:13:47 +0300
Message-Id: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
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

These are based on pci/main plus a simple "adapter" patch to add the
include for xe_vram_types.h that was added by a commit in drm-tip.
Hopefully that is enough to avoid the within context conflict with
BAR_SIZE_SHIFT removal to let the xe CI tests to be run for this
series.

There are two minor conflicts with the work in pci/resource but I'm
hesitant to base this on top of it as this is otherwise entirely
independent (and would likely prevent GPU CI tests as well). If we end
up having to pull the bridge window select changes, there should be no
reason why this does have to become collateral damage (so my
suggestion, if this is good to go in this cycle, to take this into a
separate branch than pci/resource and deal with those small conflicts
while merging into pci/next).

I've tested sysfs resize, i915, and xe BAR resizing functionality. In
the case of xe, I did small hack patch as its resize is anyway broken
as is because BAR0 pins the bridge window so resizing BAR2 fails. My
hack caused other problems further down the road (likely because BAR0
is in use by the driver so releasing it messed assumptions xe driver
has) but the BAR resize itself was working which was all I was
interested to know. I'm not planning to pursue fixing the pinning
problem within xe driver because the core changes to consider maximum
size of the resizable BARs should take care of the main problem by
different means.

Some parts of this are to be used by the resizable BAR changes into the
resource fitting/assingment logic but these seem to stand on their own
so sending these out now to reduce the size of the other patch series.

v2:
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


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
prerequisite-patch-id: 35bd3cd7a60ff7d887450a7fdde73b055a76ae24
-- 
2.39.5


