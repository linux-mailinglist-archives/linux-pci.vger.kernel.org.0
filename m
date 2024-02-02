Return-Path: <linux-pci+bounces-3058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A00847D4C
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 00:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5ED21C216A8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 23:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E60132486;
	Fri,  2 Feb 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zZaZBQti"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F5132480;
	Fri,  2 Feb 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917284; cv=none; b=cyo6352daf3vZkL682RqS/dVtjGbHgw9ahPN46c1B7W0bIq8XFi9vpQ87j1MiQv+EX1cT5w3aeRCDSAUmYyIeJAbdpuNUTq6AVpAkjPHUwF09lZvJAbZ7NUBJS8bd3bBDEVw7VB/j/x15jyNsh97dkahsnIG3kVRy828+LxVxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917284; c=relaxed/simple;
	bh=gX+4EF1aa8LAyzPJib2hQOtkg0CUXK5HquVqw1n55so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFs8gdxcj8N9Airq5RhY43wj5OxueDzIVq7WOGncvu/lLEplgE4mLi4Y/xYqVMfiR2MVeIa0TlCgqlCZRFGb00g6vUDecAQjUt8zwNWxJlP3CFkvzGS/KEGPCetirt+/vyhtMjJMMbippS6H7UzRxeUTdCEJDgaaLIKUlVoUFfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zZaZBQti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7DDC433A6;
	Fri,  2 Feb 2024 23:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706917283;
	bh=gX+4EF1aa8LAyzPJib2hQOtkg0CUXK5HquVqw1n55so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zZaZBQtipCcf5XBGD66l7h1yJKY1ffHOnvxlbMtnRWA3xh9aONF4zzKTO6U6oVTZG
	 j4ftTBoZkLHG6gZyYjjrMLkVh+1o6h3+gq5c0PQg91mWkhiEgE6ngXzTGsBf+39xK8
	 S0wo69WpngQm/A6CTieAkB6+8kZG8WR58yEq4TGw=
Date: Fri, 2 Feb 2024 15:41:23 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Le Ma <le.ma@amd.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	James Zhu <James.Zhu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Shi <alexs@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>,
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/amdgpu: wire up the can_remove() callback
Message-ID: <2024020216-letdown-uproar-718d@gregkh>
References: <20240202222603.141240-1-hamza.mahfooz@amd.com>
 <20240202222603.141240-3-hamza.mahfooz@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202222603.141240-3-hamza.mahfooz@amd.com>

On Fri, Feb 02, 2024 at 05:25:56PM -0500, Hamza Mahfooz wrote:
> Removing an amdgpu device that still has user space references allocated
> to it causes undefined behaviour. So, implement amdgpu_pci_can_remove()
> and disallow devices that still have files allocated to them from being
> unbound.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index cc69005f5b46..cfa64f3c5be5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2323,6 +2323,22 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  	return ret;
>  }
>  
> +static bool amdgpu_pci_can_remove(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +
> +	mutex_lock(&dev->filelist_mutex);
> +
> +	if (!list_empty(&dev->filelist)) {
> +		mutex_unlock(&dev->filelist_mutex);
> +		return false;
> +	}
> +
> +	mutex_unlock(&dev->filelist_mutex);
> +
> +	return true;

Also, to be pedantic, this will not work as right after you returned
"true" here, userspace could open a file, causing the same issue you are
trying to prevent to have happen, happen.

So even if we wanted to do this, which again, we do not, this isn't even
a solution for it because it will still cause you problems.

greg k-h

