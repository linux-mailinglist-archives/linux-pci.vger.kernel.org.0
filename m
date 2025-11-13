Return-Path: <linux-pci+bounces-41145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0406C59248
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 360B634F4FF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DC935C195;
	Thu, 13 Nov 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+E5hd7v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372C35BDDD
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054190; cv=none; b=pjlablfb74oeHRplZ0H6h8HFXHzBK9+iUpd62gaUktAkk2ivfOLiMlXF/jCaqyNY9bMKjTHFNSZL43cTrjIkV7FOviEvlibRrlAzoWH8riKBqYPVlKlY8qI4qBWDb4ZfzeSDQz+9Y7V53jNZVF5TSXYhkqK2oEadNtEhDjNre5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054190; c=relaxed/simple;
	bh=RLYBYfVHjIEMWHEPxpA+FPVBYUlCXdZShnKBX5VZ6D4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FumQOTRQFV3mTrjfrgl7qnaOxJHXwaZ8NC1nhPeJpJXbuEXKXnN1G41fJVFdlNbdvCUQopxpEAU4t/lvxsHDAZArd74IOx3JQVbcNQ9PZbG9Egqfk6u55Ig19GOTge1NDm36niK7v6HRr+nQTyDIIMyXvFwgDbyI7PmiQE4Nea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+E5hd7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC260C2BC86;
	Thu, 13 Nov 2025 17:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763054190;
	bh=RLYBYfVHjIEMWHEPxpA+FPVBYUlCXdZShnKBX5VZ6D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V+E5hd7vsSH7unWIowU8FVguRIrWx1/Z+o0sfMpkkl4i0FZ7Fce7LA/IRSa7pkQjy
	 seZUSHKsie8LOOXBbKr7ZiYrQB1VNOerkqboZslETqhnrU2B27RcAFtv8JbZNsSXAM
	 KP/7fCZikhA4/fjjEX5AdHpXatrOt65NviYk+T/qLSCueMOKK4Rfit/aAsmjhmxPCH
	 bBKrm+zj8GEagEWxt/u1FpAYX/N8RhpdM6XTmU2NADnD1DYp7s4NsBKuJfLDu7n9Ys
	 6EpczafG/5Yl6fP/d3JrXa16zIOKo595+cERKRmFfjDlAoR37srMNTWxAu/hNINjT1
	 xq5JXT+6UbrEQ==
Date: Thu, 13 Nov 2025 11:16:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 00/11] PCI: BAR resizing fix/rework
Message-ID: <20251113171628.GA2291281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>

On Thu, Nov 13, 2025 at 06:26:17PM +0200, Ilpo Järvinen wrote:
> Hi all,
> 
> Thanks to issue reports from Simon Richter and Alex Bennée, I
> discovered BAR resize rollback can corrupt the resource tree. As fixing
> corruption requires avoiding overlapping resource assignments, the
> correct fix can unfortunately results in worse user experience, what
> appeared to be "working" previously might no longer do so. Thus, I had
> to do a larger rework to pci_resize_resource() in order to properly
> restore resource states as it was prior to BAR resize.
> 
> This rework has been on my TODO list anyway but it wasn't the highest
> prio item until pci_resize_resource() started to cause regressions due
> to other resource assignment algorithm changes.
> 
> BAR resize rollback does not always restore BAR resources as they were
> before the resize operation was started. Currently, when
> pci_resize_resource() call is made by a driver, the driver must release
> device resource prior to the call. This is a design flaw in
> pci_resize_resource() API as PCI core cannot then save the state of
> those resources from what it was prior to release so it could restore
> them later if the BAR size change has to be rolled back.
> 
> PCI core's BAR resize operation doesn't even attempt to restore the
> device resources currently when rolling back BAR resize operation. If
> the normal resource assignment algorithm assigned those resources, then
> device resources might be assigned after pci_resize_resource() call but
> that could also trigger the resource tree corruption issue so what
> appeared to an user as "working" might be a corrupted state.
> 
> With the new pci_resize_resource() interface, the driver calling
> pci_resize_resource() should no longer release the device resources.
> 
> I've added WARN_ON_ONCE() to pick up similar bugs that cause resource
> tree corruption. At least in my tests all looked clear on that front
> after this series.
> 
> It would still be nice if the reporters could test these changes
> resolve the claim conflicts (while I've tested the series to some extent,
> I don't have such conflicts here).
> 
> This series will likely conflict with some drm changes from Lucas (will
> make them partially obsolete by removing the need to release dev's
> resources on the driver side).
> 
> I'll soon submit refresh of pci/rebar series on top of this series as
> there are some conflicts with them.
> 
> v2:
> - Add exclude_bars parameter to pci_resize_resource()
> - Add Link tags
> - Add kerneldoc patch
> - Add patch to release pci_bus_sem earlier.
> - Fix to uninitialized var warnings.
> - Don't use guard() as goto from before it triggers error with clang.
> 
> Ilpo Järvinen (11):
>   PCI: Prevent resource tree corruption when BAR resize fails
>   PCI/IOV: Adjust ->barsz[] when changing BAR size
>   PCI: Change pci_dev variable from 'bridge' to 'dev'
>   PCI: Try BAR resize even when no window was released
>   PCI: Freeing saved list does not require holding pci_bus_sem
>   PCI: Fix restoring BARs on BAR resize rollback path
>   PCI: Add kerneldoc for pci_resize_resource()
>   drm/xe: Remove driver side BAR release before resize
>   drm/i915: Remove driver side BAR release before resize
>   drm/amdgpu: Remove driver side BAR release before resize
>   PCI: Prevent restoring assigned resources
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  10 +-
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c |  14 +--
>  drivers/gpu/drm/xe/xe_vram.c                |   5 +-
>  drivers/pci/iov.c                           |  15 +--
>  drivers/pci/pci-sysfs.c                     |  17 +--
>  drivers/pci/pci.c                           |   4 +
>  drivers/pci/pci.h                           |   9 +-
>  drivers/pci/setup-bus.c                     | 126 ++++++++++++++------
>  drivers/pci/setup-res.c                     |  52 ++++----
>  include/linux/pci.h                         |   3 +-
>  10 files changed, 142 insertions(+), 113 deletions(-)

Applied to pci/resource for build testing.

Will watch for acks from xd, i915, amdgpu folks before merging.

