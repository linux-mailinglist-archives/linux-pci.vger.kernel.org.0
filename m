Return-Path: <linux-pci+bounces-29195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAD3AD1760
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 05:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED2516896D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 03:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2582701C8;
	Mon,  9 Jun 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad1yNjNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711187DA6D;
	Mon,  9 Jun 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438790; cv=none; b=rgW615bAlQkFlog3UCDWM7gkfoMR+2im9a3sHtXhFtm3gu7OADQsFWf6sUUk1bgFn/vbyXROIxQIhoUho3xg2VJ2iLSZ8rn9rI2dgXru3cq+Ice2WiZ+RLkCjYxTWUKsC/lhL+o1MkO97R8RpW5qENkuJiNyOpGjCZbcrvTro7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438790; c=relaxed/simple;
	bh=K4hlRrQnQJCWwJYZciXsYQ+Uhs0lDRqIdB00BdRadwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2JLHGzxPyR/agATP+zCbUIGK8AXKrhR1Rg2fYqG32ECatYdENA2JZYn0QqiapLGNExebQyCqbXugwq9zGHADEze9lZYygD5UqgWTeru5YgaYCsBCpPE4bH2s1NNyc83BJvv1NRbyR3M9MF6swprNW93nEInHlD9dqAxwWc31vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad1yNjNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03071C4CEEE;
	Mon,  9 Jun 2025 03:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749438790;
	bh=K4hlRrQnQJCWwJYZciXsYQ+Uhs0lDRqIdB00BdRadwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ad1yNjNUKDCtv0Ln0TE6oLLSgw4lne/KoZK+lhfFLnzyQMt/Y4ez4BnQ1RNQ2zWF6
	 m2l9bLC8QQuiiWIeBhKwDYyUciOjePlBkteV6Gq6/rYMlv2tosdosSl511zvxVr8kp
	 5esf1ejT6cZ3bq3BjRSweTZYH70JtZpflNRaVbomuYy6ZDutcBagoV6IKaOjvhXL4x
	 2AXJjEJsqpLFESaMPJWyH3kF6hYz0FWlUldbv1AkrnI/utSj5zAgfhBi65M5Tv1XIS
	 ED9ph3UgVOCoijac7XceGafOkK3PQAGx47X9yz9XGWR20mbFmVT0cr5OvrUdfvvj17
	 SlDK6sC77pxaA==
Date: Mon, 9 Jun 2025 08:43:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PTM: Build debugfs code only if CONFIG_DEBUG_FS is
 enabled
Message-ID: <aoqcrof6edexuem4b2xtboiiwwihyolkfpwj7pchy32mgp2o4r@ib5rlna4z2v7>
References: <20250608033305.15214-1-manivannan.sadhasivam@linaro.org>
 <20250609000809.GH1259@sol>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609000809.GH1259@sol>

On Sun, Jun 08, 2025 at 05:08:09PM -0700, Eric Biggers wrote:
> On Sun, Jun 08, 2025 at 09:03:05AM +0530, Manivannan Sadhasivam wrote:
> > Otherwise, the following build error will happen for CONFIG_DEBUG_FS=n &&
> > CONFIG_PCIE_PTM=y.
> > 
> >     drivers/pci/pcie/ptm.c:498:25: error: redefinition of 'pcie_ptm_create_debugfs'
> >       498 | struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
> >           |                         ^
> >     ./include/linux/pci.h:1915:2: note: previous definition is here
> >      1915 | *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
> >           |  ^
> >     drivers/pci/pcie/ptm.c:546:6: error: redefinition of 'pcie_ptm_destroy_debugfs'
> >       546 | void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
> >           |      ^
> >     ./include/linux/pci.h:1918:1: note: previous definition is here
> >      1918 | pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs) { }
> >           |
> > 
> > Fixes: 132833405e61 ("PCI: Add debugfs support for exposing PTM context")
> > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > Closes: https://lore.kernel.org/linux-pci/20250607025506.GA16607@sol
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/pcie/ptm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index ee5f615a9023..4bd73f038ffb 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -254,6 +254,7 @@ bool pcie_ptm_enabled(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL(pcie_ptm_enabled);
> >  
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> >  static ssize_t context_update_write(struct file *file, const char __user *ubuf,
> >  			     size_t count, loff_t *ppos)
> >  {
> > @@ -552,3 +553,4 @@ void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
> >  	debugfs_remove_recursive(ptm_debugfs->debugfs);
> >  }
> >  EXPORT_SYMBOL_GPL(pcie_ptm_destroy_debugfs);
> > +#endif
> 
> Tested-by: Eric Biggers <ebiggers@kernel.org>
> 
> DEBUG_FS is a bool, not a tristate.  It would be more conventional to write
> '#ifdef CONFIG_DEBUG_FS' instead of '#if IS_ENABLED(CONFIG_DEBUG_FS)'.
> 

I intentionally wanted to avoid using '#ifdef' since mixing both '#ifdef' and
'#if IS_ENABLED' always create issues when one mistakenly uses the former for
tristate symbols. So I always prefer using '#if IS_ENABLED'.

> Also, the #if guards 300 lines of code.  Perhaps they belong in a separate .c
> file?
> 

Perhaps, but not for this fix patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

