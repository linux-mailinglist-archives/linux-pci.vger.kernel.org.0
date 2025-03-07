Return-Path: <linux-pci+bounces-23148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A463A5727C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 20:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46AF179D00
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 19:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F50B250C1C;
	Fri,  7 Mar 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiZGr/kv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B48250BFB;
	Fri,  7 Mar 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377004; cv=none; b=DvnxulnuuH3vyjjMD9nJ0cMwyhBaHBoCwopC74Pn5Q2ENUDGGrYjjgL7yNZlYZ4wtaVI4A74g8mwtNSsQ0f/fkuzWVfWUrwfcPFyiDVHwW7zwYvHOrWUQ/bwBcJIGT0L/PatGh0vJxtVQ1kJnb+Nm6WWg6f1E8+e15Kf0h5Ko1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377004; c=relaxed/simple;
	bh=HXmLou/1O5TbzFoCbzWR2GBgKZ06xJF76/RahB3t0ro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gxfH6G3Xgcc4Bsy6LPmBuDqLXzaHuHEeC53XBH5Toc10RO034O2E1/KwcxgmHa2T+oyJj9GQ4lAhJkWLgGl8Ka0aisVMEByyfXeFCvC8xOqhW0l/f8uffHsYbu5h+y1oNxaHv/unPi7qUlJmfpluL6sqVxhRiGjlpgYsrp5+RY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiZGr/kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C308C4CED1;
	Fri,  7 Mar 2025 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741377003;
	bh=HXmLou/1O5TbzFoCbzWR2GBgKZ06xJF76/RahB3t0ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HiZGr/kvqrJCHlcdQp0m7SwEVZtuKVBEv/y6IOCiHD8LfvW2LXUmg1lS9YSEc98L9
	 uVJrAQHCiQX1Ek0e26rL0ZEXZh+sCDR5BiOd8k74/IXmpwc9HhKxsS+zdMwF71lTNo
	 lM9sdBWkk+DHvjSGEsvwYCdZc+FONUhltAoZIYiNyppTmz7C1bn8i9NS0OMriepoB0
	 +NLT5RJuFVuPLaoGFTCqLR9OLt0W655+tDH2v7zVNXrEbD+11PeucMxEdOkkgLWuJv
	 oQ1uq1AjerS3ZEtejQwQuhb8R10WCpfjsgjIaKscndE32Ux3ZXdlPzDINmpSO+XU9r
	 mdDSNI+/vTIsQ==
Date: Fri, 7 Mar 2025 13:50:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: remove stray put_device() in
 pci_register_host_bridge()
Message-ID: <20250307195002.GA423291@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b24870-89fb-4c91-b85d-744e35db53c2@stanley.mountain>

On Fri, Mar 07, 2025 at 11:46:34AM +0300, Dan Carpenter wrote:
> This put_device() was accidentally left over from when we changed the
> code from using device_register() to calling device_add().  Delete it.
> 
> Fixes: 9885440b16b8 ("PCI: Fix pci_host_bridge struct device release/free handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to pci/enumeration for v6.15, thanks!

> ---
>  drivers/pci/probe.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9ce83a1d6e31..819d23ce3565 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -999,10 +999,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	/* Temporarily move resources off the list */
>  	list_splice_init(&bridge->windows, &resources);
>  	err = device_add(&bridge->dev);
> -	if (err) {
> -		put_device(&bridge->dev);
> +	if (err)
>  		goto free;
> -	}
> +
>  	bus->bridge = get_device(&bridge->dev);
>  	device_enable_async_suspend(bus->bridge);
>  	pci_set_bus_of_node(bus);
> -- 
> 2.47.2
> 

