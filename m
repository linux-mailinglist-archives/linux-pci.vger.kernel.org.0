Return-Path: <linux-pci+bounces-39205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E0C038C5
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 23:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F92C3A2281
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D659277037;
	Thu, 23 Oct 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvl8UzLd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457641DB375;
	Thu, 23 Oct 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254985; cv=none; b=HyEK9pBeGRS9lFEEC0ih131X48EXYQzV3GMPfCpUgV0M7rcEMlPb+5VM1Ufl0NHixJa693hndCRAIUSVIZUbPs8w7fMpxnv6Jm24qHm941vT2tF17XEry9PsfDXYeh2/23SCCtqqtA3offvdm2DwbwH0WtcVbjqoM974J9V8qdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254985; c=relaxed/simple;
	bh=emwRloXZzRmCi7nWJ6HO3oC22fkEU2I9umHmEoh5j/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mHcwsN4hi91SlDrhXzPeDFYUFGiH3m/KIzjK68Fg4MJ57WehiHFYoGf3ctSRZNmJmSqp/WEJs4IPLySTOiub7O+7nb67RENu3PC6PAtqg8ATqxf5Tj4/nXI23LdYA4Aw8aaP92bxs69VNFXx7TCg8fnONmjrkl/58D50QUSMG8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvl8UzLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB488C4CEE7;
	Thu, 23 Oct 2025 21:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761254984;
	bh=emwRloXZzRmCi7nWJ6HO3oC22fkEU2I9umHmEoh5j/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qvl8UzLdv5Vt4s6f2q/7BcWvpQHWw34mv9XKAVHst0B4WWtdg01KOhKtJMkzbCSKt
	 2G1LvrnxxEoRV9Fryp/L9stUFd+avmHXkJZE4yhLJdC1i4zZGbwmaTtHZB4VT5jI6E
	 1xMHVd/YkOeA7w1AV93xcALBZMO0m7RBiIFx2GvWQLd23P4p5vDg30FWGjvVuC7oaP
	 CJbfEaWg1d4ABsujIzKMTmwLds45yyVECmKGjxxryjN+S4+gEidXZIJQm4hiq4/axk
	 W2PlkxqlRQvNvAIT3Fk5FaQEBdbwBCWey7WPbMUhxiiAMk83kDNmRXSsYjZgwQOrGR
	 vw4y8ntPRtGYg==
Date: Thu, 23 Oct 2025 16:29:43 -0500
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
Subject: Re: [PATCH v3 00/11] PCI: Resizable BAR improvements
Message-ID: <20251023212943.GA1323026@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>

On Wed, Oct 22, 2025 at 04:33:20PM +0300, Ilpo Järvinen wrote:
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
> v3:
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
>   PCI: Move Resizable BAR code into rebar.c
>   PCI: Cleanup pci_rebar_bytes_to_size() and move into rebar.c
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
>  drivers/pci/iov.c                           |   9 +-
>  drivers/pci/pci-sysfs.c                     |   2 +-
>  drivers/pci/pci.c                           | 145 ---------
>  drivers/pci/pci.h                           |   5 +-
>  drivers/pci/rebar.c                         | 314 ++++++++++++++++++++
>  drivers/pci/setup-res.c                     |  78 -----
>  include/linux/pci.h                         |  15 +-
>  12 files changed, 350 insertions(+), 273 deletions(-)
>  create mode 100644 drivers/pci/rebar.c

Applied to pci/rebar for v6.18, thanks, Ilpo!

If we have follow-on resource assignment changes that depend on these,
maybe I'll rename the branch to be more generic before applying them.

Also applied the drivers/gpu changes based on the acks.  I see the CI
merge failures since this series is based on v6.18-rc1; I assume the
CI applies to current linux-next or similar.  I'll check the conflicts
later and we can defer those changes if needed.

