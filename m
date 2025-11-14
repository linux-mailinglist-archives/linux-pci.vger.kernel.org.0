Return-Path: <linux-pci+bounces-41264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C2C5ED89
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 19:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A25535293E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918734679C;
	Fri, 14 Nov 2025 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM0NFKeF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFD274B53;
	Fri, 14 Nov 2025 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144427; cv=none; b=dNTLfpQ4ihnZJv/sh5y85/Feh51PVnRoLUUXT5ps362bcIgxfSlaNV+vz3jGv/kwoJzBvItSnnsu4vxN7yj8PnddgQPr2msq27AI5XpouiEnv9erCHM8HDRDnHaB0j/QVmjSCEiA5OLy81oXQ7AnmVwkXchf+f7gf2KoMUu+cPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144427; c=relaxed/simple;
	bh=fyyv/5dYz+olt2A/AtaVxpkvtC9klfScZeacl49Zk74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pmcpXhKSoir/d892W1WLT9aA+0OcL5w7AbWgOTHcHFAVcod0Yw+x0Tn3WYB+fo+VEipKMWvEueTLPcFJLYCgL+CjBLvuVZ0wL42vt6MdUqrmi7kCCJWy6XJIstMhu3miajtOccFFCipHeBXyiww8JRPtY7SbGZbsdu/usJcfrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM0NFKeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1CAC4CEF5;
	Fri, 14 Nov 2025 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763144427;
	bh=fyyv/5dYz+olt2A/AtaVxpkvtC9klfScZeacl49Zk74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uM0NFKeFvpOfvmFEGmZuwbb08xgBBse25Ll8tr53AN/aPTPIs7pD2ajHW+hVL1oT2
	 QtYysfb2/snyB8jqmbz41ffFkbeo2ZGKp2pVaDku7vUCSliT9WhAWoTXoac+3INPJU
	 ofEYpnV+uyxHo2RUvxQxnH62fi9hri6x9dtLq3Mnzhq+KAsMVSOCZ28YZqPfA9oqQI
	 UCD13c0kHYF9o74exSCV6zl8O2kxezcBvDrft5ak+3L5nqjZY3z+MLVLkBA7I9UOGJ
	 aieASlzwg5HwmfBtMDBAULwgP82P9XfqF5gse3BU5GZgG8fyU49nJCXlfqzkSpHxHj
	 k6/LAJ59DvcBw==
Date: Fri, 14 Nov 2025 12:20:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI (& drm/amdgpu): BAR to be excluded depends on HW
 generation
Message-ID: <20251114182026.GA2332245@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251114103053.13778-1-ilpo.jarvinen@linux.intel.com>

On Fri, Nov 14, 2025 at 12:30:53PM +0200, Ilpo Järvinen wrote:
> Depending on HW generation, BAR that needs to be excluded from
> pci_resize_resource() is either 2 or 5.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> This change should be be folded into the commit 73cd7ee85e78 ("PCI: Fix
> restoring BARs on BAR resize rollback path") in the pci/resource branch.
> 
> Also the changelog should be changed: "(BAR 5)" -> "(BAR 2 or 5)".
> 
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Squashed into 73cd7ee85e78, thanks:

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=40a8789930e2

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4e241836ae68..bf0bc38e1c47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1736,7 +1736,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>  
>  	pci_release_resource(adev->pdev, 0);
>  
> -	r = pci_resize_resource(adev->pdev, 0, rbar_size, 1 << 5);
> +	r = pci_resize_resource(adev->pdev, 0, rbar_size,
> +				(adev->asic_type >= CHIP_BONAIRE) ? 1 << 5
> +								  : 1 << 2);
>  	if (r == -ENOSPC)
>  		dev_info(adev->dev,
>  			 "Not enough PCI address space for a large BAR.");
> 
> base-commit: 73cd7ee85e788bc2541bfce2500e3587cf79f081
> -- 
> 2.39.5
> 

