Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D538E45797A
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 00:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhKSXXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 18:23:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhKSXXV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 18:23:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 780DF61B04;
        Fri, 19 Nov 2021 23:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637364018;
        bh=fI3IY92kN4g5zKp0563/0ygFQsUxH+aYssnQOt7mNZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WYTOz3LqwChP05T/Za3QBIa04oUWpTxf0P9IaO3gjkMLTk72YPIrv4KRuSJDwrPm1
         PB4fIHZyJqgdKfX30vLMj3Alh/e/Rjle4ZAIksH3qtTaU5yUEK0h/tSUxPUAq/6eDP
         S7U9JYyFoSE0myh1aJWX5Ec83hBIhViwZt/pMtzinP+Y1YtuT8Y1p+zg6N2HeYGAd4
         9tSn9gJnos3e9FGwGZzbLDoIrmV4rz0Q+vGtwuaSyUgLsZeVBkhtrZvmrFrOUe+7VO
         HGuuDn4FhpnNs+vxDlIHyneO58+yf3r2FSRknPS6CnMwBlmKgkgNZmBFtdmpq/gg7D
         zvjccNswhXIyg==
Date:   Fri, 19 Nov 2021 17:20:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/5] PCI: let 'pcibios_root_bridge_prepare()' access to
 'bridge->windows'
Message-ID: <20211119232017.GA1981034@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115070809.15529-2-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thierry]

In subject,

  PCI: Let pcibios_root_bridge_prepare() access bridge->windows

On Mon, Nov 15, 2021 at 08:08:05AM +0100, Sergio Paracuellos wrote:
> When function 'pci_register_host_bridge()' is called, 'bridge->windows' are
> already available. However this windows are being moved temporarily from
> there. To let 'pcibios_root_bridge_prepare()' to have access to this windows
> move this windows movement after call this function. This is interesting for
> MIPS ralink mt7621 platform to be able to properly set I/O coherence units
> with this information and avoid custom MIPs code in generic PCIe controller
> drivers.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 087d3658f75c..372a70efccc6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -898,8 +898,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  
>  	bridge->bus = bus;
>  
> -	/* Temporarily move resources off the list */
> -	list_splice_init(&bridge->windows, &resources);

Arnd added this with 37d6a0a6f470 ("PCI: Add
pci_register_host_bridge() interface") [1].

I can't remember why this was done, but we did go to some trouble to
move things around, so there must have been a good reason.

Arnd or Thierry, do you remember?

>  	bus->sysdata = bridge->sysdata;
>  	bus->ops = bridge->ops;
>  	bus->number = bus->busn_res.start = bridge->busnr;
> @@ -925,6 +923,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	if (err)
>  		goto free;
>  
> +	/* Temporarily move resources off the list */
> +	list_splice_init(&bridge->windows, &resources);
>  	err = device_add(&bridge->dev);
>  	if (err) {
>  		put_device(&bridge->dev);
> -- 
> 2.33.0
> 

[1] https://git.kernel.org/linus/37d6a0a6f470
