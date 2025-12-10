Return-Path: <linux-pci+bounces-42902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359DCB3913
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 18:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CCAB3016CBA
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8232548C;
	Wed, 10 Dec 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G88BvYO1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF49217F31;
	Wed, 10 Dec 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386802; cv=none; b=nDAFYVjcDQgHGnbBfkR1tYKbiutLos1spTgiWiCJGBnq1Ulz0mLaKa1dYIVU4uk3RprwvAL8FS0lKBw8Cn7wzk/17P1ArY2JuKCEIauESZXg3kYqIvka6Y+al4ItSL91MhdGYg2Jo8oABiP7OSwyL2D/bfw3aaXBYsy1T3IHu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386802; c=relaxed/simple;
	bh=pJS26ygWKx0BxFMDuxBlj7ePrti1NRj9FoI83CGRq6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=shc8fzoQCHAF3hNsLZuSweio2SzLqmD+BrqOLZyzHBNK0bSCtS/lIf5dJRUJorzAlbhxDHvNwbFgzYie1SDqxp0BX+QeINQAAbkh/L5PtVrZS5QQUy0MMZ+Mxyd6Wx7bzGAuHKkLLHIm/S1MSwLqf6RppwqbaPUvrEpYMgLQoK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G88BvYO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396F3C116B1;
	Wed, 10 Dec 2025 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765386801;
	bh=pJS26ygWKx0BxFMDuxBlj7ePrti1NRj9FoI83CGRq6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G88BvYO13k++ceLZOusrkKFuwb0efwFVR07wP7OUaQGI1alYOkWjjMsOMlsxjVEBT
	 ESPj7ZYLrQYXEKqqYEaw2zCsIvWHZBPRkzX59WmY160LTBl1sOoGxUlpx2NrrMWiyx
	 2K2CzfGaglEaWE/jdAx1RvHEuHQNCg+B2OH9oFHx9Gt/aPzZCb4uvhtPG41HAfa/oR
	 4NRzJDaHJ3d5XFh2WOZeb1Opd9VEKTnQH9ieBNFoeGGCj19nxGXjb/VzHdGIS7SM0C
	 nBEyP6ZQkbFfYN3IfuARMmvJ9FIaPcFsV+dUB5lmczL40ttoZFvLogIiQUntK142st
	 GDVXyr/bVAI3A==
Date: Wed, 10 Dec 2025 11:13:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH 1/1] PCI: Use resource_set_range() that correctly sets
 ->end
Message-ID: <20251210171319.GA3530931@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251208145654.5294-1-ilpo.jarvinen@linux.intel.com>

On Mon, Dec 08, 2025 at 04:56:54PM +0200, Ilpo Järvinen wrote:
> __pci_read_base() sets resource start and end addresses when resource
> is larger than 4G but pci_bus_addr_t or resource_size_t are not capable
> of representing 64-bit PCI addresses. This creates a problematic
> resource that has non-zero flags but the start and end addresses do not
> yield to resource size of 0 but 1.
> 
> Replace custom resource addresses setup with resource_set_range()
> that correctly sets end address as -1 which results in resource_size()
> returning 0.
> 
> For consistency, also use resource_set_range() in the other branch that
> does size based resource setup.

IIUC this fixes an ath11k regression (and probably others).  And
typically when booting a 32-bit kernel with a device with a BAR larger
than 4GB?

Christian, is there any dmesg snippet we could include here to help
users diagnose the problem?  I guess the "can't handle BAR larger than
4GB" message is probably one clue.

Are you able to test this and verify that it fixes the regression you
saw?

> Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
> Link: https://lore.kernel.org/all/20251207215359.28895-1-ansuelsmth@gmail.com/T/#m990492684913c5a158ff0e5fc90697d8ad95351b
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/pci/probe.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 124d2d309c58..b8294a2f11f9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -287,8 +287,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
>  		    && sz64 > 0x100000000ULL) {
>  			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
> -			res->start = 0;
> -			res->end = 0;
> +			resource_set_range(res, 0, 0);
>  			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
>  				res_name, (unsigned long long)sz64);
>  			goto out;
> @@ -297,8 +296,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		if ((sizeof(pci_bus_addr_t) < 8) && l) {
>  			/* Above 32-bit boundary; try to reallocate */
>  			res->flags |= IORESOURCE_UNSET;
> -			res->start = 0;
> -			res->end = sz64 - 1;
> +			resource_set_range(res, 0, sz64);
>  			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
>  				 res_name, (unsigned long long)l64);
>  			goto out;
> 
> base-commit: 43dfc13ca972988e620a6edb72956981b75ab6b0
> -- 
> 2.39.5
> 

