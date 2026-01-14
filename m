Return-Path: <linux-pci+bounces-44779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A11D2041A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9B243018192
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F83A35D3;
	Wed, 14 Jan 2026 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNDY9xWw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A53A35B6;
	Wed, 14 Jan 2026 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408799; cv=none; b=p8818CZ5LrcH613RWR3e/uSb5DLTLqAdZtvdmIWUDSBGX0MBjUsR7MIw58GIg/UvNolKVxfSC7NhPNWBnMnP87Wx08z3AHW/nyT9JkcePHzLPP07YImZTUR9rkHCAGyM7NQ74Id8CNXQx4D3frmm1WYJmu4AirQLiWaa7IZXPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408799; c=relaxed/simple;
	bh=npWBCjaGR/UM0D2e2/yFYMKRWKoBacRWm319Ji2nh24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K8AOuF0PCQm34XCgEsw3V/VD0V7gmeJK3EYJQayuugTazvhZd31lIxOH31WSH48EyVvhVw0yKFX+wvnVtqQmuq8j+vCSuyH3WQWUVDXxIbuBPVd3u+t0w4xeJCc8KvGTuEUzrzV6LrooifEVeGuzzW0Pncvv4eWkUKjny1O1fxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNDY9xWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F0DC4CEF7;
	Wed, 14 Jan 2026 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768408798;
	bh=npWBCjaGR/UM0D2e2/yFYMKRWKoBacRWm319Ji2nh24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QNDY9xWwSZw2Rb3cNCQ/Nune8K8JfDfBqbOmjH6CG1oHAvjZj6XfZTv4IUcrBY9/K
	 hd8ZK1lnSwiTPBgqHy3AWy3AJRvzzR51w/bcKk1DIUTRNg6bUQJ75T5+Qvlz1qAAym
	 p56j12/UueuI+dgbYm1Nl9+ExTNwfukd/2yiFB4V3Uxr/tlpGpa67gabmm5Xcd7yru
	 OWNygTWFEv4c7lhFhOBjsY7hKe6D1nDxO8dPligeYc9ExNSXCf/ZiAbyhu1vYKDSiO
	 T4wVYVKLWlL1Z+SiT+eg85c3cDpoFVjIcfZXIRmJsSsJOXgD8mAAL2i0poSOwz5Ro3
	 RTkiArZkniBVw==
Date: Wed, 14 Jan 2026 10:39:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PTM: Fix memory leak in pcie_ptm_create_debugfs()
 error path
Message-ID: <20260114163957.GA815952@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pdp4xc4d5ee3e547mmdro5riui3mclduqdl7j6iclfbozo2a4c@7m3qdm6yrhuv>

On Wed, Jan 14, 2026 at 12:58:56PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Jan 11, 2026 at 10:06:50PM +0530, Aadityarangan Shridhar Iyengar wrote:
> > In pcie_ptm_create_debugfs(), if devm_kasprintf() fails after successfully
> > allocating ptm_debugfs with kzalloc(), the function returns NULL without
> > freeing the allocated memory, resulting in a memory leak.
> > 
> > Fix this by adding kfree(ptm_debugfs) before returning NULL in the
> > devm_kasprintf() error path.
> > 
> > This leak is particularly problematic during memory pressure situations
> > where devm_kasprintf() is more likely to fail, potentially compounding
> > the memory exhaustion issue.
> > 
> > Fixes: 132833405e61 ("PCI: Add debugfs support for exposing PTM context")
> > Signed-off-by: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
> > ---
> >  drivers/pci/pcie/ptm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index ed0f9691e7d1..09c0167048a3 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -542,8 +542,10 @@ struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
> >  		return NULL;
> >  
> >  	dirname = devm_kasprintf(dev, GFP_KERNEL, "pcie_ptm_%s", dev_name(dev));
> > -	if (!dirname)
> > +	if (!dirname) {
> > +		kfree(ptm_debugfs);
> >  		return NULL;
> > +	}
> 
> Thanks for spotting the leak. I also forgot to remove it in
> pcie_ptm_destroy_debugfs(). Since this one got applied, Bjorn could you please
> squash the below fix as well?
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index ed0f9691e7d1..2c27bee0773d 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -574,6 +574,7 @@ void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
>  
>         mutex_destroy(&ptm_debugfs->lock);
>         debugfs_remove_recursive(ptm_debugfs->debugfs);
> +       kfree(ptm_debugfs);
>  }
>  EXPORT_SYMBOL_GPL(pcie_ptm_destroy_debugfs);
>  #endif
> 
> For this patch,
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Added the fix and your Reviewed-by, thanks!

