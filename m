Return-Path: <linux-pci+bounces-6655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4808B15EB
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 00:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AF4282204
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 22:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7371715FA6C;
	Wed, 24 Apr 2024 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keWecVF6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C48155358;
	Wed, 24 Apr 2024 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996807; cv=none; b=LMkOey6aHvopGI1oUYjirXJ/aPlypAr8l+UqnPNggaa31GaSGFqFLkMuDe5iEOTaSebmbLfaGUcsgWNT+J0DL/sluTYL9aZ131oXzjUSlBtkEp2QIH/opsrQgWYx9KH8/wBxEHUgqGI/RPZ9A7yetAWEL3eqOhuMq2StaXk+yCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996807; c=relaxed/simple;
	bh=4bQJ7JirAI+w3LGE99LfMfq4WHSrk26qLx4ak0gTGNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DBt0RhAD/a+odQa7flc0oRQmS0OpOQXdEAiuvjtrk7XlwJ3aqvWH/iKrS28Z6W5I21E1BTeJMeVBkRlgJrJU786M76w1k2RTUy4BwHebQPHkW8+C+wvqZh7BoJLwEwkBriAS7d41oJuT/QiSKdx7aHiGYCfFyUdS9ngVvaEzMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keWecVF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A12C113CD;
	Wed, 24 Apr 2024 22:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996806;
	bh=4bQJ7JirAI+w3LGE99LfMfq4WHSrk26qLx4ak0gTGNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=keWecVF6rkVNdokOxM8bILl/lRA109CTZI0oJ0VCTvMEKv2mAgVGvf45kx3U/V96K
	 Pv2IFRRReeyR2P2/DjAI5RuU94DzKH4k15Pm+ustdNLUR8c6algWXUO5NDRbMdqUUs
	 zRlV6qxhASMrk/KHXhcR5y1NV3oVQbwMewgqZCJn3bInZW5q6TJCUuglXXLmw5469y
	 v9ROhlQ+3ZBZx+B+ghYr2lzfVLNSZYlTeEPlgai/j/NB9i8PidI7XFaK6Tvzm/uVfY
	 wpzRRC2iw7chCYcYmsIKeDvpHSyXsBfcO42aKww7ufl/56sd5uCKiGea5fkSfkWz/+
	 6Dk3efyrWYDLg==
Date: Wed, 24 Apr 2024 17:13:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Correct error reporting with PCIe failed link
 retraining
Message-ID: <20240424221324.GA510262@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk>

On Sat, Feb 10, 2024 at 01:43:50AM +0000, Maciej W. Rozycki wrote:
> Only return successful completion status from `pcie_failed_link_retrain' 
> if retraining has actually been done, preventing excessive delays from 
> being triggered at call sites in a hope that communication will finally 
> be established with the downstream device where in fact nothing has been 
> done about the link in question that would justify such a hope.
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: stable@vger.kernel.org # v6.5+
> ---
>  drivers/pci/quirks.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> linux-pcie-failed-link-retrain-status-fix.diff
> Index: linux-macro/drivers/pci/quirks.c
> ===================================================================
> --- linux-macro.orig/drivers/pci/quirks.c
> +++ linux-macro/drivers/pci/quirks.c
> @@ -74,7 +74,8 @@
>   * firmware may have already arranged and lift it with ports that already
>   * report their data link being up.
>   *
> - * Return TRUE if the link has been successfully retrained, otherwise FALSE.
> + * Return TRUE if the link has been successfully retrained, otherwise FALSE,
> + * also when retraining was not needed in the first place.

Can you recast this?  I think it's slightly unclear what is returned
when retraining is not needed.  I *think* you return FALSE when
retraining is not needed.  Maybe this?

  Return TRUE if the link has been successfully retrained.  Return
  FALSE if retraining was not needed or we attempted a retrain and it
  failed.

>   */
>  bool pcie_failed_link_retrain(struct pci_dev *dev)
>  {
> @@ -83,10 +84,11 @@ bool pcie_failed_link_retrain(struct pci
>  		{}
>  	};
>  	u16 lnksta, lnkctl2;
> +	bool ret = false;
>  
>  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
>  	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> -		return false;
> +		return ret;

We know the value here, so IMO it's easier to read if we return
"false" instead of "ret".

>  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> @@ -98,9 +100,10 @@ bool pcie_failed_link_retrain(struct pci
>  		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
>  		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
>  
> -		if (pcie_retrain_link(dev, false)) {
> +		ret = pcie_retrain_link(dev, false) == 0;
> +		if (!ret) {
>  			pci_info(dev, "retraining failed\n");
> -			return false;
> +			return ret;

Same here.  We're here because !ret was true, so ret must be false.
I guess in the next patch you want to return the pcie_retrain_link()
return value up the chain, so it will make sense there.

>  		}
>  
>  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> @@ -117,13 +120,14 @@ bool pcie_failed_link_retrain(struct pci
>  		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
>  		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
>  
> -		if (pcie_retrain_link(dev, false)) {
> +		ret = pcie_retrain_link(dev, false) == 0;
> +		if (!ret) {
>  			pci_info(dev, "retraining failed\n");
> -			return false;
> +			return ret;
>  		}
>  	}
>  
> -	return true;
> +	return ret;

It gets awfully subtle by the time we get here.  I guess we could set
a "retrain_attempted" flag above and do this:

  if (retrain_attempted)
    return true;

  return false;

But I dunno if it's any better.  I understand the need for a change
like this, but the whole idea of returning failure (false) for a
retrain failure and also for a "no retrain needed" is a little
mind-bending.

>  }
>  
>  static ktime_t fixup_debug_start(struct pci_dev *dev,

