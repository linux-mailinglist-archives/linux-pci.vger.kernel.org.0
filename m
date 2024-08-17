Return-Path: <linux-pci+bounces-11783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03895558C
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 07:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38141F21EB3
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD6978276;
	Sat, 17 Aug 2024 05:29:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C91119A;
	Sat, 17 Aug 2024 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723872582; cv=none; b=FszkDVMeBmtjE82UjEJ5n76U1oMD62wjRoS6nueWiYbt1wR9y3d3/OlYwbPAEI2fgNv+v5Ar38R6Nlww4aahw8rMshLZk+lz2Yy2gtXovlHdmbokpwLkp7x9UyiCK1f9aZieIZDoWu0Kt6Du8mM7pekeQVqRsZrbItrnRd4iV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723872582; c=relaxed/simple;
	bh=uzVpqMmC7E5SKGFzefSKhbIkSobZJj0bkq99bpCXnHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cox+mWhjwuN+nxeM0ZvNAGkWjcUXIiytc1uYhnKYzJlDOEIEHk82/me8m5miNzR9GFJvSmp1C4/otjlgyciYrRgCY+g0I54POg+vhxWHtPyOhz9eLwfZ7zWfrT4Ohc/wtG8ZtQrMj079GViMjnD8jQsUO4BjnWHmCQnZ0nuTwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id AC43B2800B3C8;
	Sat, 17 Aug 2024 07:20:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 89E8D2C5689; Sat, 17 Aug 2024 07:20:51 +0200 (CEST)
Date: Sat, 17 Aug 2024 07:20:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: scott@spiteful.org, bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] PCI: hotplug: check the return of hotplug bridge
Message-ID: <ZsAzM8K9PnN5jxR9@wunner.de>
References: <20240817032228.6844-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817032228.6844-1-trintaeoitogc@gmail.com>

[shorten subject, cc += Nam Cao, start of thread:
https://lore.kernel.org/all/20240817032228.6844-1-trintaeoitogc@gmail.com/
]

On Sat, Aug 17, 2024 at 12:22:27AM -0300, Guilherme Giacomo Simoes wrote:
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Hm, the body of the commit message ended up in the subject
and the patch was submitted twice.


> --- a/drivers/pci/hotplug/shpchp_pci.c
> +++ b/drivers/pci/hotplug/shpchp_pci.c
> @@ -48,8 +48,11 @@ int shpchp_configure_device(struct slot *p_slot)
>  	}
>  
>  	for_each_pci_bridge(dev, parent) {
> -		if (PCI_SLOT(dev->devfn) == p_slot->device)
> -			pci_hp_add_bridge(dev);
> +		if (PCI_SLOT(dev->devfn) == p_slot->device) {
> +			ret = pci_hp_add_bridge(dev);
> +			if (ret)
> +				goto out;
> +		}
>  	}
>  
>  	pci_assign_unassigned_bridge_resources(bridge);

Nam Cao worked on this back in May:

v1:
https://lore.kernel.org/all/cover.1714762038.git.namcao@linutronix.de/

v2:
https://lore.kernel.org/all/cover.1714838173.git.namcao@linutronix.de/

v3:
https://lore.kernel.org/all/cover.1715609848.git.namcao@linutronix.de/

Note that there was discussion on v2 after v3 had been submitted,
i.e. the last messages in the discussion are in the v2 thread.

Nam Cao's patches didn't get applied, I think we hadn't reached
consensus or were waiting for a v4.

Nam Cao's v2 uses the exact same approach that you're proposing
and they subsequently found a way to crash the kernel despite the
newly introduced error handling:

https://lore.kernel.org/all/20240506083701.NZNifFGn@linutronix.de/

So I'm afraid your patch may not work in every scenario.

Thanks,

Lukas

