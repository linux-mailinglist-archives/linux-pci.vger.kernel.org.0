Return-Path: <linux-pci+bounces-23149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320DA5727E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 20:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8141783CF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 19:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A97DDA9;
	Fri,  7 Mar 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXXUCTAz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CB1C84D8;
	Fri,  7 Mar 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377035; cv=none; b=JeqPBaVYE9IfGnyA1SksntENlJBYapZGO/PrCSAB6UNykUkzNt+OfJg4FkxUoGqzUSPI8J/UO8w/KwHpezI+uDkzD0JxnhGZifTGD23bn3pDEyWFaeXuuKdRoFoadA9WgbB7LNSVkv1Djgs/5cpM7IQDZAnwSuLYMl9XIA41crc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377035; c=relaxed/simple;
	bh=C0C8Bn5jGriQdOz9Y0DgUGOoFUomtPkJJEMNiF4l8Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=L/02ZxtXenUyc6ZnCVN/QAA+uwvWfJKvnewuVdxyR9zrWlnOgWkkdyZJ61Rah2KETj7+D9wYcBdBHtNgF6pmKhmXu5sgluDIrNrTI3AukRN9+k4IV2+dC4pkR2Yq6Z/O3XeUYZ5vUxd5eM+KF1urNCbypLYww0vUVs3rKcog75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXXUCTAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7550C4CED1;
	Fri,  7 Mar 2025 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741377035;
	bh=C0C8Bn5jGriQdOz9Y0DgUGOoFUomtPkJJEMNiF4l8Z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nXXUCTAzZw6U6PBNZDukTlfSej25PhYso83VCp8kRb6zvXzUcL+gMawRM7z5HtqvD
	 7ml5IkUMmouOG2JtcQP7HeENDBriKCD0lea9R6xAmxMJ1aoCF7OOJnI8tf5H6p3SFs
	 /tMcvpGIZPHAQ6JEFcWzn9IamBoOw3S2IGZmCTrPqt4YsQI7lff9Irhl0bsaAV4ofN
	 NCJl4PwDgeMNlvtRai4lp1p8jcnbwu3LDzns82MCZTN8HIs3Z1zzd++f72mIf2amRT
	 xx/57qdgHMGdm4nYhM4rY2U97bzlYsZMW02Nw1AO5c50qTO0MhpnWFQjmOZ8n60Xqn
	 YiE6RhoXEY2Vg==
Date: Fri, 7 Mar 2025 13:50:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ma Ke <make24@iscas.ac.cn>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Fix double free in pci_register_host_bridge()
Message-ID: <20250307195033.GA424012@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db806a6c-a91b-4e5a-a84b-6b7e01bdac85@stanley.mountain>

On Fri, Mar 07, 2025 at 11:46:41AM +0300, Dan Carpenter wrote:
> Calling put_device(&bus->dev) will call release_pcibus_dev() which will
> free the bus.  It leads to a use after free when we dereference "bus" in
> the cleanup code and the kfree(bus) is a double free.
> 
> Fixes: b80b4d4972e6 ("PCI: Fix reference leak in pci_register_host_bridge()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Squashed into the b80b4d4972e6 commit on pci/enumeration for v6.15,
thanks!

> ---
>  drivers/pci/probe.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 819d23ce3565..c13f2c957002 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -957,6 +957,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	resource_size_t offset, next_offset;
>  	LIST_HEAD(resources);
>  	struct resource *res, *next_res;
> +	bool bus_registered = false;
>  	char addr[64], *fmt;
>  	const char *name;
>  	int err;
> @@ -1020,10 +1021,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	name = dev_name(&bus->dev);
>  
>  	err = device_register(&bus->dev);
> -	if (err) {
> -		put_device(&bus->dev);
> +	bus_registered = true;
> +	if (err)
>  		goto unregister;
> -	}
>  
>  	pcibios_add_bus(bus);
>  
> @@ -1110,12 +1110,15 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  unregister:
>  	put_device(&bridge->dev);
>  	device_del(&bridge->dev);
> -
>  free:
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	pci_bus_release_domain_nr(parent, bus->domain_nr);
>  #endif
> -	kfree(bus);
> +	if (bus_registered)
> +		put_device(&bus->dev);
> +	else
> +		kfree(bus);
> +
>  	return err;
>  }
>  
> -- 
> 2.47.2
> 

