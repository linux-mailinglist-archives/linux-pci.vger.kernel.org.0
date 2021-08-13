Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0DD3EBB3E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhHMRUL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 13:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhHMRUL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 13:20:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2171860EE0;
        Fri, 13 Aug 2021 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628875183;
        bh=msAsg60iDFVHnpyg9LVEqM/hZyavjrH7CZzA9eoo7nw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XfHba8JZPJBjF4H/Nc7YY12++rz2cI6GI7oiYeHgM4MModjUlUlcacc/PDPY++6CI
         +B7yJJvJrY/0RqRRhzpdWOrFsAQzmAUfHN/FGGiZj+VVMx5CpAksxRYC6l2aaklLiR
         03tzG8tLLMm4xCb4kPbs8cUwsevGw8um1luMe/8fxovoLJYHI+nOk77gY0z5P5mel0
         sPWjMdNuFSBzcHmDQS6E4dFacMHoqvZkGeqn1524W2MoCIcXdAXeQMgv4mxGAuI5sq
         plQ4yuZODaSbMV3DttsBppcQ8W7Jtm4v5AxtWM8KkyRhTVhLLCHYH1XEFNhcvTONMF
         +3VJdW0NoetpQ==
Date:   Fri, 13 Aug 2021 19:19:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: of: Fix MSI domain lookup with child bus nodes
Message-ID: <20210813191938.6a8a4ee4@coco.lan>
In-Reply-To: <20210813160257.3570515-1-robh@kernel.org>
References: <20210813160257.3570515-1-robh@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Fri, 13 Aug 2021 11:02:57 -0500
Rob Herring <robh@kernel.org> escreveu:

> When a DT contains PCI child bus nodes, lookup of the MSI domain on PCI
> buses fails resulting in the following warnings:
> 
> WARNING: CPU: 4 PID: 7 at include/linux/msi.h:256 __pci_enable_msi_range+0x398/0x59c
> 
> The issue is that pci_host_bridge_of_msi_domain() will check the DT node of
> the passed in bus even if it's not the host bridge's bus. Based on the
> name of the function, that's clearly not what we want. Fix this by
> walking the bus parents to the root bus.
> 
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Compile tested only. Mauro, Can you see if this fixes your issue.
> 
>  drivers/pci/of.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a143b02b2dcd..ea70aede054c 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -84,6 +84,10 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
>  	if (!bus->dev.of_node)
>  		return NULL;
>  
> +	/* Find the host bridge bus */
> +	while (!pci_is_root_bus(bus))
> +		bus = bus->parent;
> +
>  	/* Start looking for a phandle to an MSI controller. */
>  	d = of_msi_get_domain(&bus->dev, bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
>  	if (d)

Nope, it didn't solve the issue.


Thanks,
Mauro
