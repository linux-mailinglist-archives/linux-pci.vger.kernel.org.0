Return-Path: <linux-pci+bounces-13269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2E97B2B1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 18:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3AF284DD1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10AA17838F;
	Tue, 17 Sep 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iae1q3la"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8615ECDF;
	Tue, 17 Sep 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589658; cv=none; b=MCgYJLHYhupbC2gvHLKFH4iWvNj6eJD2mk6rJ1ah0XkY6lfeV6W7JvrVfCIfxZemHZHX4ikzzoKNOZT88bguSjw/vfpd68WfaWyRUmmWGdRYurLIFgHpoAzODRSSAPWfaITiK25KibNsmfQOvxqbO/5pWblJm3yzDhMO1ptzEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589658; c=relaxed/simple;
	bh=3lCP1YC5khIp5O163b0+ZzDWXW18sWQ7tlhhSqHtjWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3pcRXcsf+04P7CAM5I07Yi7UygSRAUZiT5z0QtVSWRQE8Ijqlt3r9LVVVjeF9YUHUhsU4N//aDC+2TaBzwf5uHT1IvNgcwvi5emkVLrpXxdFeXE1JoQrqP9TUtRjv1FVXyds0CA2gDiuHi0149F6JRnBVsh6ea5eCS/bE0E5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iae1q3la; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF213C4CEC7;
	Tue, 17 Sep 2024 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726589658;
	bh=3lCP1YC5khIp5O163b0+ZzDWXW18sWQ7tlhhSqHtjWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iae1q3laGEwD9iNrY7PeMB6RqQWVQOoPS+YM1yL+SrvEiyvwqZo+IIe1ZZzR2tsy/
	 F0GUKy0f+Lg1w5jy+Gdx8EPG6L12cU5yWn5frLfAOT+TZHlbx4r4nPNCSz1EcqDxa1
	 qjcu83hVqFyceeZUouBMH1DYF/Jsb9oE29Q15AE37ibesTwtIHuuIyO2mGrryWd35X
	 vvMVXQdmmoV3RzDZSlhGzrv2tLf3ls7cWaph4NZ/7wUam+LgeposREFL27n3vKfGG6
	 PKUjhk8GNO7YSCrAFHO5CgsIHit6Ngkv5rcxNWjnD//ofYBt/vHZxicqmT7e9DJalm
	 KADkZ5TUQb92w==
Date: Tue, 17 Sep 2024 17:14:10 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V5 2/5] PCI/TPH: Add Steering Tag support
Message-ID: <20240917161410.GP167971@kernel.org>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-3-wei.huang2@amd.com>
 <20240917073215.GH167971@kernel.org>
 <6efc219d-29e1-4169-8393-c7e4610347cc@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6efc219d-29e1-4169-8393-c7e4610347cc@amd.com>

On Tue, Sep 17, 2024 at 09:31:00AM -0500, Wei Huang wrote:
> 
> 
> On 9/17/24 02:32, Simon Horman wrote:
> > On Mon, Sep 16, 2024 at 03:51:00PM -0500, Wei Huang wrote:
> ...
> >> +	val = readl(vec_ctrl);
> >> +	mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
> >> +	val &= ~mask;
> >> +	val |= FIELD_PREP(mask, (u32)tag);
> > 
> > Hi Wei Huang,
> > 
> > Unfortunately clang-18 (x86_64, allmodconfig, W=1, when applied to net-next)
> > complains about this.  I think it is because it expects FIELD_PREP to be
> > used with a mask that is a built-in constant.
> 
> I thought I fixed it, but apparently not enough for clang-18. I will
> address this problem, along with other comments from you and Bjorn (if any).
> 
> BTW there is another code in drivers/gpu/drm/ using a similar approach.

Thanks,

I will run some checks over drivers/gpu/drm/ and let you know if they find
anything.

