Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDFC6971D5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 00:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBNXaW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 18:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNXaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 18:30:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D142FCF1;
        Tue, 14 Feb 2023 15:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84CBBB81E44;
        Tue, 14 Feb 2023 23:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A11C433EF;
        Tue, 14 Feb 2023 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676417418;
        bh=xbo7MQECVZ2N5Erw40Zayy9i4HJGCqYWQMcC7nAyysY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ADz3w4Rp/ymbWVEaKp32Yt0TMPZo9c7pB9jicyVtwyhi8IQLmNHUV72FcV6n81X8K
         aUzR0KxltK2XTSMSxFoA3KABP4C8bT0Y3VgGlNOetEXwQGu5vvZHJQQfSjEbxoYSZC
         okF2n5GnhuAWakvsNRt60dM9xPx16iqKdCFIzbIz9ZZe0v9HiP0o9bjI8As12VvysW
         z9SxuMfYrn4J399kQN873YGiGOcEP8mjiSU1mC3YjgC+eXICZ1RgFr6EzH3P92qAK8
         airu9fjiWqMFaK2Rt6eCK/IttF6Hnnr7f6L6YVP/koqqU2ObWP3ALAgQV/GTG9deBr
         o3ZkaQZpvJh1g==
Date:   Tue, 14 Feb 2023 17:30:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vsethi@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V2] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Message-ID: <20230214233016.GA3095090@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111190533.29979-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, Alex for pciehp and ACS comments]

On Thu, Jan 12, 2023 at 12:35:33AM +0530, Vidya Sagar wrote:
> PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted to
> send upstream messages before they have been assigned a bus number and
> such messages have a Requester ID with Bus number set to 00h.
> If the Downstrem port has ACS Source Validation enabled, these messages
> will be detected as ACS violation error.
> Hence, disable ACS Source Validation in the bridge device during
> hot-remove operation and re-enable it after enumeration of the
> downstream hierarchy but before binding the respective device drivers.

s/Downstrem/Downstream/

Format as paragraphs (blank line between).

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v2:
> * Fixed build issues
> 
>  drivers/pci/hotplug/pciehp_pci.c | 13 ++++++++++++-
>  drivers/pci/pci.c                | 22 ++++++++++++++++++++++
>  include/linux/pci.h              |  6 ++++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index d17f3bf36f70..ad90bcf3f621 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -63,6 +63,7 @@ int pciehp_configure_device(struct controller *ctrl)
>  
>  	pci_assign_unassigned_bridge_resources(bridge);
>  	pcie_bus_configure_settings(parent);
> +	pci_configure_acs_sv(bridge, true);
>  	pci_bus_add_devices(parent);
>  
>   out:
> @@ -117,6 +118,16 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>  		}
>  		pci_dev_put(dev);
>  	}
> -
> +	/*
> +	 * PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted
> +	 * to send upstream messages before they have been assigned a bus
> +	 * number and such messages have a Requester ID with Bus number
> +	 * set to 00h. If the Downstrem port has ACS Source Validation enabled,

s/Downstrem/Downstream/

> +	 * these messages will be detected as ACS violation error.
> +	 * Hence, disable ACS Source Validation here and re-enable it after
> +	 * enumeration of the downstream hierarchy and before binding the
> +	 * respective device drivers in pciehp_configure_device().
> +	 */
> +	pci_configure_acs_sv(ctrl->pcie->port, false);

What if we have a slot that's empty at boot and we add a device later?
It looks like we still might see ACS errors there because the add
happens before a remove?

>  	pci_unlock_rescan_remove();
>  }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..9cefaf814f49 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -991,6 +991,28 @@ static void pci_enable_acs(struct pci_dev *dev)
>  	pci_disable_acs_redir(dev);
>  }
>  
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE
> +void pci_configure_acs_sv(struct pci_dev *dev, bool flag)
> +{
> +	u16 cap;
> +	u16 ctrl;
> +
> +	if (!pci_acs_enable || !dev->acs_cap)
> +		return;
> +
> +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CAP, &cap);
> +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &ctrl);
> +
> +	if (flag)
> +		ctrl |= (cap & PCI_ACS_SV);
> +	else
> +		ctrl &= ~(cap & PCI_ACS_SV);
> +
> +	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, ctrl);

I guess we don't have a way to do this for the non-standard ACS-like
devices, i.e., pci_dev_specific_enable_acs().  Not the end of the
world, just unfortunate that we'll have different behavior there.

> +}
> +EXPORT_SYMBOL_GPL(pci_configure_acs_sv);

Doesn't seem like this needs to be exported or exposed via
linux/pci.h.  pciehp cannot be built as a module.

> +#endif
> +
>  /**
>   * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
>   * @dev: PCI device to have its BARs restored
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 060af91bafcd..edf516e39764 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2239,6 +2239,12 @@ void pci_hp_create_module_link(struct pci_slot *pci_slot);
>  void pci_hp_remove_module_link(struct pci_slot *pci_slot);
>  #endif
>  
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE
> +void pci_configure_acs_sv(struct pci_dev *dev, bool flag);
> +#else
> +static inline void pci_configure_acs_sv(struct pci_dev *dev, bool flag) { }
> +#endif
> +
>  /**
>   * pci_pcie_cap - get the saved PCIe capability offset
>   * @dev: PCI device
> -- 
> 2.17.1
> 
