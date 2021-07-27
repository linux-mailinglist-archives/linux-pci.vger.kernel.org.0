Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ECD3D8409
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 01:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhG0Xa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 19:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbhG0Xa1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 19:30:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4CF760FE7;
        Tue, 27 Jul 2021 23:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627428627;
        bh=C+hq6qoVwouKkZahhd4EeTOs3dFZy6RWX6t25IskRfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oUoxzdzwJhoALmsycWC7djvElgH91p+1NvuikzzLGHIXdpUbX/yvT2dN9PornItps
         JCPKr0FLkyXoze6OFR9wLxOaME35C8ckoNvcRRMu+ESi3NVSzF6W5RyeDznuhPtVU5
         MbhdHy12fYJL7ln+lKENMAwrg4y5BqTC9rkHB24km/NK5zMM5kO5d4wEq3payvTuVA
         WLoyIeKA3J93HOL23gqTxO1XGz3pKlup2gQi5oL8zeJMutiDoq5B8iqC5rgSdaCX2r
         AaFXifFyIH3plcaXIJQimN6K3M99SLT4/q9gWWyUvANyQgJJoSebIIGmz/SeqMYCQZ
         h0ZAS3QLGVcbw==
Date:   Tue, 27 Jul 2021 18:30:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 6/8] PCI: Setup ACPI fwnode early and at the same
 time with OF
Message-ID: <20210727233025.GA756574@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709123813.8700-7-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 09, 2021 at 06:08:11PM +0530, Amey Narkhede wrote:
> From: Shanker Donthineni <sdonthineni@nvidia.com>
> 
> The pci_dev objects are created through two mechanisms 1) during PCI
> bus scan and 2) from I/O Virtualization. The fwnode in pci_dev object
> is being set at different places depends on the type of firmware used,
> device creation mechanism, and acpi_pci_bridge_d3() WAR.

WAR?

> The software features which have a dependency on ACPI fwnode properties
> and need to be handled before device_add() will not work. One use case,
> the software has to check the existence of _RST method to support ACPI
> based reset method.
> 
> This patch does the two changes in order to provide fwnode consistently.
>  - Set ACPI and OF fwnodes from pci_setup_device().
>  - Remove pci_set_acpi_fwnode() in acpi_pci_bridge_d3().
> 
> After this patch, ACPI/OF firmware properties are visible at the same
> time during the early stage of pci_dev setup. And also call sites should
> be able to use firmware agnostic functions device_property_xxx() for the
> early PCI quirks in the future.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>  drivers/pci/pci-acpi.c | 1 -
>  drivers/pci/probe.c    | 7 ++++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index eaddbf701..dae021322 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -952,7 +952,6 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  		return false;
>  
>  	/* Assume D3 support if the bridge is power-manageable by ACPI. */
> -	pci_set_acpi_fwnode(dev);
>  	adev = ACPI_COMPANION(&dev->dev);
>  
>  	if (adev && acpi_device_power_manageable(adev))
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c272e23db..c911d6a5c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1790,6 +1790,9 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->error_state = pci_channel_io_normal;
>  	set_pcie_port_type(dev);
>  
> +	pci_set_of_node(dev);
> +	pci_set_acpi_fwnode(dev);
> +
>  	pci_dev_assign_slot(dev);
>  
>  	/*
> @@ -1925,6 +1928,7 @@ int pci_setup_device(struct pci_dev *dev)
>  	default:				    /* unknown header */
>  		pci_err(dev, "unknown header type %02x, ignoring device\n",
>  			dev->hdr_type);
> +		pci_release_of_node(dev);
>  		return -EIO;
>  
>  	bad:
> @@ -2352,10 +2356,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	dev->vendor = l & 0xffff;
>  	dev->device = (l >> 16) & 0xffff;
>  
> -	pci_set_of_node(dev);
> -
>  	if (pci_setup_device(dev)) {
> -		pci_release_of_node(dev);
>  		pci_bus_put(dev->bus);
>  		kfree(dev);
>  		return NULL;
> -- 
> 2.32.0
> 
