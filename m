Return-Path: <linux-pci+bounces-3051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F45847C68
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 23:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EECAB24BB3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB585943;
	Fri,  2 Feb 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0BT3gKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FF85FF01;
	Fri,  2 Feb 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913664; cv=none; b=Yais/WTUy5NhLpPtfvBWVJmYsEtMpb0i9c/jRAWQAwYZ7CPxhHGre089r7Svrivkj4+a/2HnNePxJO3PkF6Ja98pvOJXNZMcdJlHWZew5/akG7HzFts+3xPAg5grlI3gnS/Vi8SbVfGIYw3yi1pqWkhOiD3AsRQIuR1VhTTHe+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913664; c=relaxed/simple;
	bh=exAcKdkKTYBbj02//ly4ATQZUG2yWNQEYrX161BJntQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XReBinshtzcOl61vvAHjnU1hVahw3TkPKdfE8Szrs4swwpWeLZhl0gTgMdnVGx3tv6e1a/3yTv8oh39ud1VO7kZ4W0wQomXai8OSh9QlRj3pBb5u8l9oG315+Fkz3Fef67OFPTeUz8GVo/n1QS6tmodq6uTXTr2a3RTTyNhqOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0BT3gKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09AFC433F1;
	Fri,  2 Feb 2024 22:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706913664;
	bh=exAcKdkKTYBbj02//ly4ATQZUG2yWNQEYrX161BJntQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C0BT3gKqwpPjY19LTrjlAry5YR+7VFmLrXnqBKSxsPdigLPMyFBx1J8fLuBgr6+Lm
	 SlOqNOr5Ox2iiPD8FwnoRna1dURYlqzetiDJ68DVSJKAlQWGXM5rBcBu91MeSbgsjn
	 FSnTpRo7EFNyAoBUtXWrjpuSQQvoSWnAKFGfGA4afTAkdDkrBPMjn5W3bDvsG8cIRq
	 CSXLOS+4bWNuRPtFrlrAQrrcf+vsjyX+BBnZPKKN43iy0nD2+DJDIva9KxjUIxRTPB
	 ax9ObTb5QHrm7ecQsHgyoNM6FgVNee0xu7OxCAwTzZfNui7WbRUtlVBSNXAqkRvUyc
	 3kOV+bOjZbkvQ==
Date: Fri, 2 Feb 2024 16:41:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Le Ma <le.ma@amd.com>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	James Zhu <James.Zhu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Shi <alexs@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>,
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 3/3] drm/amdgpu: wire up the can_remove() callback
Message-ID: <20240202224102.GA732304@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202222603.141240-3-hamza.mahfooz@amd.com>

[+cc Bartosz]

On Fri, Feb 02, 2024 at 05:25:56PM -0500, Hamza Mahfooz wrote:
> Removing an amdgpu device that still has user space references allocated
> to it causes undefined behaviour. So, implement amdgpu_pci_can_remove()
> and disallow devices that still have files allocated to them from being
> unbound.

Maybe this would help for things that are completely built-in or
soldered down, but nothing can prevent a user from physically pulling
a card or cable, so I don't think this is a generic solution to the
problem of dangling user space references.

Maybe Bartosz's recent LPC talk is relevant:
https://lpc.events/event/17/contributions/1627/

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
> +}
> +
>  static void
>  amdgpu_pci_remove(struct pci_dev *pdev)
>  {
> @@ -2929,6 +2945,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>  	.name = DRIVER_NAME,
>  	.id_table = pciidlist,
>  	.probe = amdgpu_pci_probe,
> +	.can_remove = amdgpu_pci_can_remove,
>  	.remove = amdgpu_pci_remove,
>  	.shutdown = amdgpu_pci_shutdown,
>  	.driver.pm = &amdgpu_pm_ops,
> -- 
> 2.43.0
> 

