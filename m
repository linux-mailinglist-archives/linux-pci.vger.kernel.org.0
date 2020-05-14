Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07F71D36D1
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 18:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgENQnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 12:43:06 -0400
Received: from foss.arm.com ([217.140.110.172]:40392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgENQnF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 12:43:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B50031FB;
        Thu, 14 May 2020 09:43:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6913F71E;
        Thu, 14 May 2020 09:43:03 -0700 (PDT)
Date:   Thu, 14 May 2020 17:43:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] PCI: Fix pci_host_bridge struct device release/free
 handling
Message-ID: <20200514164301.GB24211@e121166-lin.cambridge.arm.com>
References: <20200513223859.11295-1-robh@kernel.org>
 <20200513223859.11295-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513223859.11295-2-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 13, 2020 at 05:38:59PM -0500, Rob Herring wrote:
> The PCI code has several paths where the struct pci_host_bridge is freed
> directly. This is wrong because it contains a struct device which is
> refcounted and should be freed using put_device(). This can result in
> use-after-free errors. I think this problem has existed since 2012 with
> commit 7b5436635800 ("PCI: add generic device into pci_host_bridge
> struct"). It generally hasn't mattered as most host bridge drivers are
> still built-in and can't unbind.
> 
> The problem is a struct device should never be freed directly once
> device_initialize() is called and a ref is held, but that doesn't happen
> until pci_register_host_bridge(). There's then a window between
> allocating the host bridge and pci_register_host_bridge() where kfree
> should be used. This is fragile and requires callers to do the right
> thing. To fix this, we need to split device_register() into
> device_initialize() and device_add() calls, so that the host bridge
> struct is always freed by using a put_device().
> 
> devm_pci_alloc_host_bridge() is using devm_kzalloc() to allocate struct
> pci_host_bridge which will be freed directly. Instead, we can use a
> custom devres action to call put_device().
> 
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/probe.c  | 36 +++++++++++++++++++-----------------
>  drivers/pci/remove.c |  2 +-
>  2 files changed, 20 insertions(+), 18 deletions(-)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e21dc71b1907..e064ded6fbec 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -565,7 +565,7 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
>  	return b;
>  }
>  
> -static void devm_pci_release_host_bridge_dev(struct device *dev)
> +static void pci_release_host_bridge_dev(struct device *dev)
>  {
>  	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
>  
> @@ -574,12 +574,7 @@ static void devm_pci_release_host_bridge_dev(struct device *dev)
>  
>  	pci_free_resource_list(&bridge->windows);
>  	pci_free_resource_list(&bridge->dma_ranges);
> -}
> -
> -static void pci_release_host_bridge_dev(struct device *dev)
> -{
> -	devm_pci_release_host_bridge_dev(dev);
> -	kfree(to_pci_host_bridge(dev));
> +	kfree(bridge);
>  }
>  
>  static void pci_init_host_bridge(struct pci_host_bridge *bridge)
> @@ -599,6 +594,8 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
>  	bridge->native_dpc = 1;
> +
> +	device_initialize(&bridge->dev);
>  }
>  
>  struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> @@ -616,17 +613,25 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  }
>  EXPORT_SYMBOL(pci_alloc_host_bridge);
>  
> +static void devm_pci_alloc_host_bridge_release(void *data)
> +{
> +	pci_free_host_bridge(data);
> +}
> +
>  struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
>  						   size_t priv)
>  {
> +	int ret;
>  	struct pci_host_bridge *bridge;
>  
> -	bridge = devm_kzalloc(dev, sizeof(*bridge) + priv, GFP_KERNEL);
> +	bridge = pci_alloc_host_bridge(priv);
>  	if (!bridge)
>  		return NULL;
>  
> -	pci_init_host_bridge(bridge);
> -	bridge->dev.release = devm_pci_release_host_bridge_dev;
> +	ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
> +				       bridge);
> +	if (ret)
> +		return NULL;
>  
>  	return bridge;
>  }
> @@ -634,10 +639,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
>  
>  void pci_free_host_bridge(struct pci_host_bridge *bridge)
>  {
> -	pci_free_resource_list(&bridge->windows);
> -	pci_free_resource_list(&bridge->dma_ranges);
> -
> -	kfree(bridge);
> +	put_device(&bridge->dev);
>  }
>  EXPORT_SYMBOL(pci_free_host_bridge);
>  
> @@ -908,7 +910,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	if (err)
>  		goto free;
>  
> -	err = device_register(&bridge->dev);
> +	err = device_add(&bridge->dev);
>  	if (err) {
>  		put_device(&bridge->dev);
>  		goto free;
> @@ -978,7 +980,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  
>  unregister:
>  	put_device(&bridge->dev);
> -	device_unregister(&bridge->dev);
> +	device_del(&bridge->dev);
>  
>  free:
>  	kfree(bus);
> @@ -2953,7 +2955,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  	return bridge->bus;
>  
>  err_out:
> -	kfree(bridge);
> +	put_device(&bridge->dev);
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(pci_create_root_bus);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index e9c6b120cf45..95dec03d9f2a 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -160,6 +160,6 @@ void pci_remove_root_bus(struct pci_bus *bus)
>  	host_bridge->bus = NULL;
>  
>  	/* remove the host bridge */
> -	device_unregister(&host_bridge->dev);
> +	device_del(&host_bridge->dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_remove_root_bus);
> -- 
> 2.20.1
> 
