Return-Path: <linux-pci+bounces-15646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EBA9B6A1F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D89282289
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16107217912;
	Wed, 30 Oct 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNX5OTQM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0EA214415;
	Wed, 30 Oct 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307304; cv=none; b=XO/mnd4c2PLga48Jii+f92eJdpMfdeQMC2ZrIlwys41s4INfWYcF5QVidflyeRz+Tw/9I25a7J96SLsPjCHw197rrvCBTiH/PDJE6TWC8zogVeD2RfvUA4UBIXDCf4e8YX2VYoLbT0vgXbsHmnS4Eh+Nfjxj/nvI0na3FNFEvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307304; c=relaxed/simple;
	bh=FRMaysyJlopNPUOC0Ykzd1k5bKHrzJM5YjN8B17Xt+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mc3vfEGEl/r94suCGHCroxU8rI9uy8gyd2JhPCURce/+lMV6mCYCfu6ZPFeycmS4zCJc37lhj0e5nS+8+bNqd35Y1Uu8LiTSj2ndVRVUKlALN2LnUaoeEnl1073rSdpC9MvVMrFw8bMX11K/A9EIx7tfnIDAepxuPuVZA5vklT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNX5OTQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D4AC4CECE;
	Wed, 30 Oct 2024 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730307303;
	bh=FRMaysyJlopNPUOC0Ykzd1k5bKHrzJM5YjN8B17Xt+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FNX5OTQM9O2wnnn6qBm4s0oPfWxcycl7RBrr1C7l68NDY/KX5AKcmjeUaIlBlcu5b
	 z2rht4MLV5uHortvCwP9YWy5mZOsHJHKF8yi6X49/gnxf56iJByiGbf8bEqmGkYmyN
	 MVv6yvRBQp5vZv7OQpFImdV/Wp7MO00y1F8hBh3SXCmTS95wiQXNYdr/Ah84tV8ppc
	 HIQI/m70v6NJsOSd3wCEZTjWlB0MCPqZbE85RECgpvGdq+AT5JZwWwinCXNVXb9lmx
	 npIoa5F2FT0tLRTmn4rmyXpLXImk087P0iqJEjhEU4XPugI6spd0nt2QT/nGsuGYZI
	 1Dx/MkcknjlLQ==
Date: Wed, 30 Oct 2024 11:55:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v4 5/7] PCI/IOV: Check that VF BAR fits within the
 reservation
Message-ID: <20241030165501.GA1205366@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zbazqug3u77eiydb7p6p6gexwowrjcdl52cszczuww4xow7ebc@tke7k5hewrn5>

On Wed, Oct 30, 2024 at 12:43:19PM +0100, Michał Winiarski wrote:
> On Mon, Oct 28, 2024 at 11:56:04AM -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 25, 2024 at 11:50:36PM +0200, Michał Winiarski wrote:
> > > VF MMIO resource reservation, either created by system firmware and
> > > inherited by Linux PCI subsystem or created by the subsystem itself,
> > > should contain enough space to fit the BAR of all SR-IOV Virtual
> > > Functions that can potentially be created (total VFs supported by the
> > > device).
> > 
> > I don't think "VF resource reservation ... should contain enough
> > space" is really accurate or actionable.  It would be *nice* if the PF
> > BAR is large enough to accommodate the largest supported VF BARs for
> > all possible VFs, but if it doesn't, it's not really an error.  It's
> > just a reflection of the fact that resource space is limited.
> 
> From PCI perspective, you're right, IOV resources are optional, and it's
> not really an error for PF device itself.
> From IOV perspective - we do need those resources to be able to create
> VFs.
> 
> All I'm trying to say here, is that the context of the change is the
> "success" case, where the VF BAR reservation was successfully assigned,
> and the PF will be able to create VFs.
> The case where there were not enough resources for VF BAR (and PF won't
> be able to create VFs) remains unchanged.
> 
> > > However, that assumption only holds in an environment where VF BAR size
> > > can't be modified.
> > 
> > There's no reason to assume anything about how many VF BARs fit.  The
> > existing code should avoid enabling the requested nr_virtfn VFs if the
> > PF doesn't have enough space -- I think that's what the "if
> > (res->parent)" is supposed to be checking.
> > 
> > The fact that you need a change here makes me suspect that we're
> > missing some resource claim (and corresponding res->parent update)
> > elsewhere when resizing the VF BAR.
> 
> My understanding is that res->parent is only expressing that the
> resource is assigned.
> We don't really want to change that, the resource is still there and is
> assigned - we just want to make sure that VF enabling fails if the
> caller wants to enable more VFs than possible for current resource size.
> 
> Let's use an example. A device with a single BAR.
> initial_vf_bar_size = X
> total_vfs = 4
> supported_vf_resizable_bar_sizes = X, 2X, 4X

In addition, IIUC we're assuming the PF BAR size is 4X, since the
conclusion is that 4 VF BARs of size X fill it completely.

> With that - the initial underlying resource looks like this:
>             +----------------------+
>             |+--------------------+|
>             ||                    ||
>             |+--------------------+|
>             |+--------------------+|
>             ||                    ||
>             |+--------------------+|
>             |+--------------------+|
>             ||                    ||
>             |+--------------------+|
>             |+--------------------+|
>             ||                    ||
>             |+--------------------+|
>             +----------------------+
> Its size is 4X, and it contains BAR for 4 VFs.
> "resource_size >= vf_bar_size * num_vfs" is true for any num_vfs
> Let's assume that there are enough resources to assign it.
> 
> Patch 4/7 allows to resize the entire resource (in addition to changing
> the VF BAR size), which means that after calling:
> pci_resize_resource() with size = 2X, the underlying resource will look
> like this:
>             +----------------------+ 
>             |+--------------------+| 
>             ||                    || 
>             ||                    || 
>             ||                    || 
>             ||                    || 
>             |+--------------------+| 
>             |+--------------------+| 
>             ||                    || 
>             ||                    || 
>             ||                    || 
>             ||                    || 
>             |+--------------------+| 
>             |+--------------------+| 
>             ||                    || 
>             ||                    || 
>             ||                    || 
>             ||                    || 
>             |+--------------------+| 
>             |+--------------------+| 
>             ||                    || 
>             ||                    || 
>             ||                    || 
>             ||                    || 
>             |+--------------------+| 
>             +----------------------+ 
> Its size is 8X, and it contains BAR for 4 VFs.
> "resource_size >= vf_bar_size * num_vfs" is true for any num_vfs

With the assumption that the PF BAR size is 4X, these VFs would no
longer fit.  I guess that's basically what you say here:

> It does require an extra 4X of MMIO resources, so this can fail in
> resource constrained environment, even though the original 4X resource
> was able to be assigned.
> 
> The following patch 6/7 allows to change VF BAR size without touching
> the underlying reservation size.
> After calling pci_iov_vf_bar_set_size() to 4X and enabling a single VF,
> the underlying resource will look like this:
>             +----------------------+ 
>             |+--------------------+| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             ||░░░░░░░░░░░░░░░░░░░░|| 
>             |+--------------------+| 
>             +----------------------+ 
> Its size is 4X, but since pci_iov_vf_bar_set_size() was called, it is no
> longer able to accomodate 4 VFs.
> "resource_size >= vf_bar_size * num_vfs" is only true for num_vfs = 1
> and any attempts to create more than 1 VF should fail.
> We don't need to worry about being MMIO resource constrained, no extra
> MMIO resources are needed.

IIUC this series only resizes VF BARs.  Those VF BARs are carved out
of a PF BAR, and this series doesn't touch the PF BAR resizing path.
I guess the driver might be able to increase the PF BAR size if
necessary, and then increase the VF BAR size.

It sounds like this patch is really a bug fix independent of VF BAR
resizing.  If we currently allow enabling more VFs than will fit in a
PF BAR, that sounds like a bug.

So if we try to enable too many VFs, sriov_enable() should fail.  I
still don't see why this check should change the res->parent test,
though.

> > > Add an additional check that verifies that VF BAR for all enabled VFs
> > > fits within the underlying reservation resource.
> > > 
> > > Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> > > ---
> > >  drivers/pci/iov.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > > index 79143c1bc7bb4..5de828e5a26ea 100644
> > > --- a/drivers/pci/iov.c
> > > +++ b/drivers/pci/iov.c
> > > @@ -645,10 +645,14 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> > >  
> > >  	nres = 0;
> > >  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> > > +		int vf_bar_sz = pci_iov_resource_size(dev,
> > > +						      pci_resource_to_iov(i));
> > >  		bars |= (1 << pci_resource_to_iov(i));
> > >  		res = &dev->resource[pci_resource_to_iov(i)];
> > > -		if (res->parent)
> > > -			nres++;
> > > +		if (!res->parent || vf_bar_sz * nr_virtfn > resource_size(res))
> > > +			continue;
> > > +
> > > +		nres++;
> > >  	}
> > >  	if (nres != iov->nres) {
> > >  		pci_err(dev, "not enough MMIO resources for SR-IOV\n");
> > > -- 
> > > 2.47.0
> > > 

