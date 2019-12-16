Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706AE120779
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 14:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfLPNpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 08:45:31 -0500
Received: from foss.arm.com ([217.140.110.172]:55834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfLPNpa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 08:45:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E22C11FB;
        Mon, 16 Dec 2019 05:45:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5412F3F718;
        Mon, 16 Dec 2019 05:45:29 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:45:27 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 01/13] PCI: cadence: Remove stray "pm_runtime_put_sync()"
 in error path
Message-ID: <20191216134526.GW24359@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-2-kishon@ti.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:35PM +0530, Kishon Vijay Abraham I wrote:
> commit bd22885aa188f135fd9 ("PCI: cadence: Refactor driver to use
> as a core library") while refactoring the Cadence PCIe driver to be
> used as library, removed pm_runtime_get_sync() from cdns_pcie_ep_setup()
> and cdns_pcie_host_setup() but missed to remove the corresponding
> pm_runtime_put_sync() in the error path. Fix it here.
> 
> Fixes: commit bd22885aa188f135fd9 ("PCI: cadence: Refactor driver to use

As this is a fix, a commit subject starting with PCI: cadence: Fix ... may
be more obvious.

I'd suggest you use the shorter form of this, i.e. Fixes: %h (\"%s\"))

Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")

> as a core library")
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c   | 2 --
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 1c173dad67d1..560f22b4d165 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -473,7 +473,5 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	pci_epc_mem_exit(epc);
>  
>   err_init:
> -	pm_runtime_put_sync(dev);
> -
>  	return ret;
>  }
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 9b1c3966414b..ccf55e143e1d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -275,7 +275,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	pci_free_resource_list(&resources);
>  
>   err_init:
> -	pm_runtime_put_sync(dev);
> -

There is probably more you can do here for both -host and -ep:

 - Remove the possibly now unused <linux/pm_runtime.h> include
 - Remove the err_init label and return directly from source.

Thanks,

Andrew Murray

>  	return ret;
>  }
> -- 
> 2.17.1
> 
