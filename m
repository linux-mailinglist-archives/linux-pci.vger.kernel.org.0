Return-Path: <linux-pci+bounces-635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5371D809318
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 22:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5231C2087D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 21:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29251009;
	Thu,  7 Dec 2023 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UUnl53WJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D2D1715
	for <linux-pci@vger.kernel.org>; Thu,  7 Dec 2023 13:08:31 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id BLbcrtsau4QGMBLbcr3MRN; Thu, 07 Dec 2023 22:08:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1701983310;
	bh=LVhaspvPVTyqJBvaCHkZyhAm2CQng56NKQI5+3Lh4jA=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To;
	b=UUnl53WJnFCZ34HGt2SkObn++43sx8PJmqVHQyjhws/np3WsmRvRRxH8a2Fteokf7
	 +n2cSzo/caqMhUNJtxJRMxHL63qTe9ebMbF8gs6TMmX85HLi70yjLBfoFlJLoQUmf1
	 KvrWYR4LFKcVfag2ienkK2keHSDf81GdWnJA7gOYNwlhWyHybPr5qE9TO+l2LDi3Br
	 OyFZgwPkPGhKWyC1O3AtClaRNzvMIFEurbUYCiOYjuWXEiXVVM12uN5AJDNl7ZD4Wy
	 E1T6wRUnebgvK+FUUQBf6fU8vJNW/GSVPkOs/Ei5SIMX/XCCMoUfZkNgiAQqmq+MK1
	 tyjCgwdsuEy5w==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 07 Dec 2023 22:08:30 +0100
X-ME-IP: 92.140.202.140
Message-ID: <89bb5f95-61b0-4e93-a542-49d6c1276f97@wanadoo.fr>
Date: Thu, 7 Dec 2023 22:08:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dns@arista.com
Cc: bhelgaas@google.com, dima@arista.com, helgaas@kernel.org,
 kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
 logang@deltatee.com, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20231122042316.91208-2-dns@arista.com>
Subject: Re: [PATCH v4 1/1] PCI: switchtec: Fix stdev_release() crash after
 surprise hot remove
Content-Language: fr, en-US
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231122042316.91208-2-dns@arista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> A PCI device hot removal may occur while stdev->cdev is held open. The call
> to stdev_release() then happens during close or exit, at a point way past
> switchtec_pci_remove(). Otherwise the last ref would vanish with the
> trailing put_device(), just before return.
> 
> At that later point in time, the devm cleanup has already removed the
> stdev->mmio_mrpc mapping. Also, the stdev->pdev reference was not a counted
> one. Therefore, in DMA mode, the iowrite32() in stdev_release() will cause
> a fatal page fault, and the subsequent dma_free_coherent(), if reached,
> would pass a stale &stdev->pdev->dev pointer.
> 
> Fix by moving MRPC DMA shutdown into switchtec_pci_remove(), after
> stdev_kill(). Counting the stdev->pdev ref is now optional, but may prevent
> future accidents.
> 
> Reproducible via the script at
> https://lore.kernel.org/r/20231113212150.96410-1-dns@arista.com
> 
> Link: https://lore.kernel.org/r/20231113212150.96410-2-dns@arista.com
> Signed-off-by: Daniel Stodden <dns@arista.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Dmitry Safonov <dima@arista.com>
---

...

> @@ -1703,6 +1709,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)  >  	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>  	dev_info(&stdev->dev, "unregistered.\n");
>  	stdev_kill(stdev);
> +	switchtec_exit_pci(stdev);  > + pci_dev_put(stdev->pdev); > + stdev->pdev = NULL; >  	put_device(&stdev->dev);
>  }
  
Hi,

does a similarswitchtec_exit_pci() should be called in the error handling path of switchtec_pci_probe() if an error occurs after switchtec_init_pci()?

CJ


