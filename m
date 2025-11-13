Return-Path: <linux-pci+bounces-41186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C2C5A0C8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D73DC4E273B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E52D2494;
	Thu, 13 Nov 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldNyGFLN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2D2C11DE;
	Thu, 13 Nov 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067891; cv=none; b=Y/odTH1ypD4gmXmi5r15TwaFF3uE3Z+B2u70Gk4mIXuG9Oj7n/NUpgW+6ThaNupgpqMXyELXcyEtHi1YunmFK1i07tukBDZ6VHxEHcyUtBb9c9tcU1IA0qMltbBC8TvlNf+DyP4jag1v3Se2ro5Ef8nBN64XGRl7kq6Sd8PqsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067891; c=relaxed/simple;
	bh=xLrJZEPePccg2xhmkiorFWRycwjnGRNEZWCFNbWd6RM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=psY2uFTzZEUOWUvdyHVWyjqP3JqcY5CEuvPfG1APdoZG7hmgKkm0mPUKwq2Ms2mLVNGivyAvLGuEwazEl3l0r5po8IYz7u0izIwroTb5spZm2vTXKCGVmE7KudpF7M3ZCrpZPiDUgcewVOa0krJDOp/ELPv79ftvoH+VjFFc5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldNyGFLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3C1C4CEFB;
	Thu, 13 Nov 2025 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763067891;
	bh=xLrJZEPePccg2xhmkiorFWRycwjnGRNEZWCFNbWd6RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ldNyGFLN048R3GGyhgBcoHDVHXNm0rwBymbIAArd3QQ6u3+URAPScIgQbU9uXDa1Z
	 +hURL3mocS3LL1Vj/d8qWyU7mvxa2vQPH846Ses24l5LtjrrfdiDugEN3LsLaBO3vy
	 B6KAhq2B832v44Ug8IAecnvzX5/WjMuLI6CrsAzENUqX3JlcyBhilviwr+KVKWmUIU
	 PoVNdhBMHReNMrXn0NFgk9YWQxzLkZkb8J7+V/4Sh/PHkM+zz6331VRBWpBCpFBKyH
	 cIM27R2cwjrwYevC2oSfl75Wf2kqV+QPNxUMAnLXqI/kZG3tGEwHY/LanZLbWu17mc
	 8MloFM4HijThg==
Date: Thu, 13 Nov 2025 15:04:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] PCI: Resizable BAR improvements
Message-ID: <20251113210450.GA2314988@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>

On Thu, Nov 13, 2025 at 08:00:42PM +0200, Ilpo Järvinen wrote:
> pci.c has been used as catch everything that doesn't fits elsewhere
> within PCI core and thus resizable BAR code has been placed there as
> well. Move Resizable BAR related code to a newly introduced rebar.c to
> reduce size of pci.c. After move, there are no pci_rebar_*() calls from
> pci.c indicating this is indeed well-defined subset of PCI core.
> 
> Endpoint drivers perform Resizable BAR related operations which could
> well be performed by PCI core to simplify driver-side code. This
> series adds a few new API functions to that effect and converts the
> drivers to use the new APIs (in separate patches).
> 
> While at it, also convert BAR sizes bitmask to u64 as PCIe spec already
> specifies more sizes than what will fit u32 to make the API typing more
> future-proof. The extra sizes beyond 128TB are not added at this point.
> 
> Some parts of this are to be used by the resizable BAR changes into the
> resource fitting/assingment logic but these seem to stand on their own
> so sending these out now to reduce the size of the other patch series.
> 
> This v4 rebases what's currently in pci/rebar on top of the BAR resize
> changes in pci/resource as they'd have nasty conflicts otherwise so
> they can start to peacefully coexist in the pci/resource branch.
> 
> v4:
> - Rebased on top of pci/resource changes to solve conflicts
> 
> v3: https://lore.kernel.org/linux-pci/20251022133331.4357-1-ilpo.jarvinen@linux.intel.com/
> - Rebased to solve minor conflicts
> 
> v2: https://lore.kernel.org/linux-pci/20250915091358.9203-1-ilpo.jarvinen@linux.intel.com/
> - Kerneldoc:
>   - Improve formatting of errno returns
>   - Open "ctrl" -> "control"
>   - Removed mislead "bit" words (when referring to BAR size)
>   - Rewrote pci_rebar_get_possible_sizes() kernel doc to not claim the
>     returned bitmask is defined in PCIe spec as the capability bits now
>     span across two registers in the spec and are not continuous (we
>     don't support the second block of bits yet, but this API is expected
>     to return the bits without the hole so it will not be matching with
>     the spec layout).
> - Dropped superfluous zero check from pci_rebar_size_supported()
> - Small improvement to changelog of patch 7
> 
> Ilpo Järvinen (11):
>   PCI: Move Resizable BAR code to rebar.c
>   PCI: Clean up pci_rebar_bytes_to_size() and move to rebar.c
>   PCI: Move pci_rebar_size_to_bytes() and export it
>   PCI: Improve Resizable BAR functions kernel doc
>   PCI: Add pci_rebar_size_supported() helper
>   drm/i915/gt: Use pci_rebar_size_supported()
>   drm/xe/vram: Use PCI rebar helpers in resize_vram_bar()
>   PCI: Add pci_rebar_get_max_size()
>   drm/xe/vram: Use pci_rebar_get_max_size()
>   drm/amdgpu: Use pci_rebar_get_max_size()
>   PCI: Convert BAR sizes bitmasks to u64
> 
>  Documentation/driver-api/pci/pci.rst        |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   8 +-
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c |  10 +-
>  drivers/gpu/drm/xe/xe_vram.c                |  32 +-
>  drivers/pci/Makefile                        |   2 +-
>  drivers/pci/iov.c                           |  10 +-
>  drivers/pci/pci-sysfs.c                     |   2 +-
>  drivers/pci/pci.c                           | 149 ---------
>  drivers/pci/pci.h                           |   5 +-
>  drivers/pci/rebar.c                         | 325 ++++++++++++++++++++
>  drivers/pci/setup-res.c                     |  85 -----
>  include/linux/pci.h                         |  15 +-
>  12 files changed, 361 insertions(+), 285 deletions(-)
>  create mode 100644 drivers/pci/rebar.c

Applied on top of pci/resource, thanks!

