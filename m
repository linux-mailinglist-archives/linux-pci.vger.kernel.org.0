Return-Path: <linux-pci+bounces-12144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3673295D919
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 00:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE26A1F23367
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B027194C8F;
	Fri, 23 Aug 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghjmg0XJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F69189B89;
	Fri, 23 Aug 2024 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451025; cv=none; b=kqjU1RDNvSy4hreKXbCt9I7SjLUWVdo6lnYogAyEqKzKo2pMV5SUmqeaczoX320EBa63pY1qka/JdWMQWw51q2iUnQmOOmE3XUG7UQ9VGVSq94uL8QHRMBE6Z4RPGo6MHYLzQDPyTocdhI6RItb255AOv/mGyaNdKbwUc9q3qYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451025; c=relaxed/simple;
	bh=NJcXayjTbzsChmOeToGMlIG/vnfPC/xi03r9HY6Yrxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cv7PUm6CWkklg6baJrM8MzkEycJjKfKz9pJwvcXWlYJErFlZli0HiXiUwog6EU1slizSG9fzCvN9cOJFEmBu5MeEgjdmA7WpoaJaOdndkfkTeMrg37RRmnLqeMSbGtcSYor/j36uITPhliqS85gPURX2TEOBwoON+o1E/+7zv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghjmg0XJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E729C32786;
	Fri, 23 Aug 2024 22:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724451023;
	bh=NJcXayjTbzsChmOeToGMlIG/vnfPC/xi03r9HY6Yrxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ghjmg0XJOEfV2A1r6aMLzQkNkE2pbaKSoildozqPY0Lhm1EmbH4Vmk2/W6H72WTH5
	 2hCEXZLy4IGjD378d1MWwIRT80Xiw45MW82LcM4czSR4T4F/oBAooJGALPjRYVk7xe
	 jSPCtEXPlF8zPojUPSMjNlyJVfcZIMz4Cge4hh5x14ulioeV4HYXOFZSeaYm+Fst1y
	 qqRtto+2aGWOFyGCc0PadpPzc3wFK3z6t4rwHPzg4u+sPFSxpQLdfX35a32uf3KJ60
	 LRxI9uKGMpWEEbPp//hrrZbJizydFJs3f9W85BQQ7FtmuD9Kqn99ZBdHXpasA4PRnb
	 1s9/hI9avZ4+w==
Date: Fri, 23 Aug 2024 17:10:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 1/2] PCI: don't rely on of_platform_depopulate() for
 reused OF-nodes
Message-ID: <20240823221021.GA388724@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823093323.33450-2-brgl@bgdev.pl>

[+to Rob]

On Fri, Aug 23, 2024 at 11:33:22AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> of_platform_depopulate() doesn't play nice with reused OF nodes - it
> ignores the ones that are not marked explicitly as populated and it may
> happen that the PCI device goes away before the platform device in which
> case the PCI core clears the OF_POPULATED bit. We need to
> unconditionally unregister the platform devices for child nodes when
> stopping the PCI device.

Rob, any concerns with this?

> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/remove.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 910387e5bdbf..4770cb87e3f0 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -1,7 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/pci.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
>  #include "pci.h"
>  
>  static void pci_free_resources(struct pci_dev *dev)
> @@ -14,12 +17,25 @@ static void pci_free_resources(struct pci_dev *dev)
>  	}
>  }
>  
> +static int pci_pwrctl_unregister(struct device *dev, void *data)
> +{
> +	struct device_node *pci_node = data, *plat_node = dev_of_node(dev);
> +
> +	if (dev_is_platform(dev) && plat_node && plat_node == pci_node) {
> +		of_device_unregister(to_platform_device(dev));
> +		of_node_clear_flag(plat_node, OF_POPULATED);
> +	}
> +
> +	return 0;
> +}
> +
>  static void pci_stop_dev(struct pci_dev *dev)
>  {
>  	pci_pme_active(dev, false);
>  
>  	if (pci_dev_is_added(dev)) {
> -		of_platform_depopulate(&dev->dev);
> +		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
> +				      pci_pwrctl_unregister);
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> -- 
> 2.43.0
> 

