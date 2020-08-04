Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683A523BDDC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgHDQNj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 12:13:39 -0400
Received: from foss.arm.com ([217.140.110.172]:46434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgHDQNj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 12:13:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71AF031B;
        Tue,  4 Aug 2020 09:13:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 549E23F718;
        Tue,  4 Aug 2020 09:13:31 -0700 (PDT)
Date:   Tue, 4 Aug 2020 17:13:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen2: Fix crash in resource_list_first_type()
Message-ID: <20200804161325.GA11104@e121166-lin.cambridge.arm.com>
References: <20200804120430.9253-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804120430.9253-1-geert+renesas@glider.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 04, 2020 at 02:04:30PM +0200, Geert Uytterhoeven wrote:
> The conversion to modern host bridge probing made the driver allocate
> its private data using devm_pci_alloc_host_bridge(), but forgot to
> remove the old allocation.  Hence part of the driver initialization is
> done using the new instance, while another part is done using the old
> instance, leading to a crash due to uninitialized bridge DMA ranges:
> 
>     Unable to handle kernel NULL pointer dereference at virtual address 00000008
>     pgd = (ptrval)
>     [00000008] *pgd=00000000
>     Internal error: Oops: 5 [#1] SMP ARM
>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc1-shmobile-00035-g92d69cc6275845a7 #645
>     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>     PC is at rcar_pci_probe+0x154/0x340
>     LR is at _raw_spin_unlock_irqrestore+0x18/0x20
> 
> Fix this by dropping the old allocation.
> 
> Fixes: 92d69cc6275845a7 ("PCI: rcar-gen2: Convert to use modern host bridge probe functions")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pci/controller/pci-rcar-gen2.c | 4 ----
>  1 file changed, 4 deletions(-)

Squashed in the initial commit, pushed out on pci/misc.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
> index 046965d284a6d54e..c9530038ca9a53fc 100644
> --- a/drivers/pci/controller/pci-rcar-gen2.c
> +++ b/drivers/pci/controller/pci-rcar-gen2.c
> @@ -302,10 +302,6 @@ static int rcar_pci_probe(struct platform_device *pdev)
>  	if (mem_res->start & 0xFFFF)
>  		return -EINVAL;
>  
> -	priv = devm_kzalloc(dev, sizeof(struct rcar_pci_priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -
>  	priv->mem_res = *mem_res;
>  	priv->cfg_res = cfg_res;
>  
> -- 
> 2.17.1
> 
