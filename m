Return-Path: <linux-pci+bounces-11540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7161494D14C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 15:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C761C2144A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F07C192B7F;
	Fri,  9 Aug 2024 13:31:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2191194AFA;
	Fri,  9 Aug 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210315; cv=none; b=gG+wpRR0kO6VK/VCnBEPeJ2jlYXSzHb4pHOQxxepEz4ds2I+TTG9b+fC9dl/7p9haAm0SVE1FKW5uvlnKEoR2j7eOG7mbjEXHQcD8+pLM1HwdXUP9tWQjcLdsdL4zYgemtU67jWYpc/1eWWgPXEQTioVhshSfKSp4ozFA+vL0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210315; c=relaxed/simple;
	bh=WfFpJcJQ35dzLTQUD05Fr67TBk4HOaFQYQsu6eFGzc0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X5r5h0ThRiOK52rFCt0PgyqpCURDIf9Ge1seX/Dw6GSJZ5rdU1OXk7POVRaR+zIhqvjvJLhd9CRetv1JeqFS0yaAlu0+PbS7n/U46yqwmpzcU6tDn7cqcCSYPiiGVjNTwua3jq8YXvxUrTM7zjJnEh8O+pzkerHt3CK6aCBr23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8885192009C; Fri,  9 Aug 2024 15:31:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 82E7492009B;
	Fri,  9 Aug 2024 14:31:52 +0100 (BST)
Date: Fri, 9 Aug 2024 14:31:52 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Correct error reporting with PCIe failed link
 retraining
In-Reply-To: <20240424221324.GA510262@bhelgaas>
Message-ID: <alpine.DEB.2.21.2408082349330.61955@angie.orcam.me.uk>
References: <20240424221324.GA510262@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Apr 2024, Bjorn Helgaas wrote:

> > linux-pcie-failed-link-retrain-status-fix.diff
> > Index: linux-macro/drivers/pci/quirks.c
> > ===================================================================
> > --- linux-macro.orig/drivers/pci/quirks.c
> > +++ linux-macro/drivers/pci/quirks.c
> > @@ -74,7 +74,8 @@
> >   * firmware may have already arranged and lift it with ports that already
> >   * report their data link being up.
> >   *
> > - * Return TRUE if the link has been successfully retrained, otherwise FALSE.
> > + * Return TRUE if the link has been successfully retrained, otherwise FALSE,
> > + * also when retraining was not needed in the first place.
> 
> Can you recast this?  I think it's slightly unclear what is returned
> when retraining is not needed.  I *think* you return FALSE when
> retraining is not needed.  Maybe this?
> 
>   Return TRUE if the link has been successfully retrained.  Return
>   FALSE if retraining was not needed or we attempted a retrain and it
>   failed.

 Sure, thanks for the suggestion.  Applied verbatim except for formatting.

> > @@ -83,10 +84,11 @@ bool pcie_failed_link_retrain(struct pci
> >  		{}
> >  	};
> >  	u16 lnksta, lnkctl2;
> > +	bool ret = false;
> >  
> >  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
> >  	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> > -		return false;
> > +		return ret;
> 
> We know the value here, so IMO it's easier to read if we return
> "false" instead of "ret".

 Well, either patch in the series has to make this change.  If you prefer 
it to be the second one, then I'm fine with it.  Applied throughout then.

> > @@ -117,13 +120,14 @@ bool pcie_failed_link_retrain(struct pci
> >  		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
> >  		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> >  
> > -		if (pcie_retrain_link(dev, false)) {
> > +		ret = pcie_retrain_link(dev, false) == 0;
> > +		if (!ret) {
> >  			pci_info(dev, "retraining failed\n");
> > -			return false;
> > +			return ret;
> >  		}
> >  	}
> >  
> > -	return true;
> > +	return ret;
> 
> It gets awfully subtle by the time we get here.  I guess we could set
> a "retrain_attempted" flag above and do this:
> 
>   if (retrain_attempted)
>     return true;
> 
>   return false;
> 
> But I dunno if it's any better.  I understand the need for a change
> like this, but the whole idea of returning failure (false) for a
> retrain failure and also for a "no retrain needed" is a little
> mind-bending.

 I agree it's a bit subtle, but not incorrect and to go away with the next 
change, which I want to keep separate from this one for clarity.  Let's 
not overdesign for this transitional state then please.

 I've posted v2 now with extra patches to address further issues discussed 
recently: 
<https://patchwork.kernel.org/project/linux-pci/list/?series=878216>.  

 Thank you for your review!

  Maciej

