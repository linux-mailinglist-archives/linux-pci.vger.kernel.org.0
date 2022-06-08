Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863B6543274
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 16:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbiFHOY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbiFHOY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 10:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E004617E;
        Wed,  8 Jun 2022 07:24:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7345961A97;
        Wed,  8 Jun 2022 14:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCEAC34116;
        Wed,  8 Jun 2022 14:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654698263;
        bh=lfp5MteEMqeLmLkwvI2zA+stynTrMoOeGm+VdRjMKTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aLyPcHIYueMqC4wvgXch1zV6fD4XJaRffBi+pbVw+kDKsnkr2/Zv49N/E7JSWAqXV
         qpLkUCptxy39RQ9Wi2/YPOKnwj1yLfypQmGVZd+0CzTPV85Wjg8YxiCtcZPW60xcK5
         ORjpVu1mlqaVKLT80OdMq3ebKgdKZSGrqcnAF3ZCw2T/L9eDKitrmGqGRqjeN1OvB7
         /3wILjBffvDBZSBLIjzhUwlfFNZK5kS0eRi/z6mCktfemcZF6GZMqE+u09d1qpwGCB
         RfSvr8jdo+Gy7mQ0FCiQop0wUW7BH7luCgBRA1TLG0wHF+rT+V5T7Q9OizsyfSBQkt
         lgKZyiMOUJTSw==
Date:   Wed, 8 Jun 2022 09:24:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux1394-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] firewire: ohci: Convert to generic power management
Message-ID: <20220608142419.GA396923@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607212157.343033-1-helgaas@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 07, 2022 at 04:21:57PM -0500, Bjorn Helgaas wrote:
> From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> 
> Convert firewire-ohci from legacy PCI power management to the generic power
> management framework.
> 
> Previously firewire-ohci used legacy PCI power management, and
> pci_suspend() and pci_resume() were responsible for both device-specific
> things and generic PCI things like saving and restoring config space and
> managing power state:
> 
>   pci_suspend
>     software_reset                         <-- device-specific
>     pci_save_state                         <-- generic PCI
>     pci_set_power_state                    <-- generic PCI
>     pmac_ohci_off                          <-- device-specific
> 
>   pci_resume
>     pmac_ohci_on                           <-- device-specific
>     pci_set_power_state(PCI_D0)            <-- generic PCI
>     pci_restore_state                      <-- generic PCI
>     pci_enable_device                      <-- generic PCI
>     ohci_enable                            <-- device-specific
> 
> Convert to generic power management where the PCI bus PM methods do the
> generic PCI things, and the driver needs only the device-specific part,
> i.e.,
> 
>   suspend_devices_and_enter
>     dpm_suspend_start(PMSG_SUSPEND)
>       pci_pm_suspend                       # PCI bus .suspend() method
>         pci_suspend                        # driver->pm->suspend
>           software_reset                   <-- device-specific
>           pmac_ohci_off                    <-- device-specific
>     suspend_enter
>       dpm_suspend_noirq(PMSG_SUSPEND)
>         pci_pm_suspend_noirq               # PCI bus .suspend_noirq() method
>           pci_save_state                   <-- generic PCI
>           pci_prepare_to_sleep             <-- generic PCI
>             pci_set_power_state
>     ...
>     dpm_resume_end(PMSG_RESUME)
>       pci_pm_resume                        # PCI bus .resume() method
>         pci_restore_standard_config
>           pci_set_power_state(PCI_D0)      <-- generic PCI
>           pci_restore_state                <-- generic PCI
>         pci_resume                         # driver->pm->resume
>           pmac_ohci_on                     <-- device-specific
>           ohci_enable                      <-- device-specific

I want to point out that this changes the ordering of pmac_ohci_off()
with respect to pci_save_state() and pci_set_power_state().
Previously we did those as:

  pci_save_state
  pci_set_power_state
  pmac_ohci_off

and after this patch it would be:

  pmac_ohci_off
  pci_save_state
  pci_set_power_state

The ordering of pmac_ohci_on() in the resume path is similarly
changed.

I don't know what pmac_ohci_off() and pmac_ohci_on() do, so I don't
know whether this is an issue.  In general, drivers don't need to do
anything after their device is put in D3hot, but maybe firewire-ohci
is unique in this way.

> [bhelgaas: commit log]
> Link: https://lore.kernel.org/r/20200720150715.624520-1-vaibhavgupta40@gmail.com
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/firewire/ohci.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
> index 17c9d825188b..aee705132330 100644
> --- a/drivers/firewire/ohci.c
> +++ b/drivers/firewire/ohci.c
> @@ -3165,8 +3165,7 @@ static int ohci_set_iso_channels(struct fw_iso_context *base, u64 *channels)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_PM
> -static void ohci_resume_iso_dma(struct fw_ohci *ohci)
> +static void __maybe_unused ohci_resume_iso_dma(struct fw_ohci *ohci)
>  {
>  	int i;
>  	struct iso_context *ctx;
> @@ -3183,7 +3182,6 @@ static void ohci_resume_iso_dma(struct fw_ohci *ohci)
>  			ohci_start_iso(&ctx->base, 0, ctx->sync, ctx->tags);
>  	}
>  }
> -#endif
>  
>  static int queue_iso_transmit(struct iso_context *ctx,
>  			      struct fw_iso_packet *packet,
> @@ -3789,39 +3787,24 @@ static void pci_remove(struct pci_dev *dev)
>  	dev_notice(&dev->dev, "removed fw-ohci device\n");
>  }
>  
> -#ifdef CONFIG_PM
> -static int pci_suspend(struct pci_dev *dev, pm_message_t state)
> +static int __maybe_unused pci_suspend(struct device *devp)
>  {
> +	struct pci_dev *dev = to_pci_dev(devp);
>  	struct fw_ohci *ohci = pci_get_drvdata(dev);
> -	int err;
>  
>  	software_reset(ohci);
> -	err = pci_save_state(dev);
> -	if (err) {
> -		ohci_err(ohci, "pci_save_state failed\n");
> -		return err;
> -	}
> -	err = pci_set_power_state(dev, pci_choose_state(dev, state));
> -	if (err)
> -		ohci_err(ohci, "pci_set_power_state failed with %d\n", err);
>  	pmac_ohci_off(dev);
>  
>  	return 0;
>  }
>  
> -static int pci_resume(struct pci_dev *dev)
> +static int __maybe_unused pci_resume(struct device *devp)
>  {
> +	struct pci_dev *dev = to_pci_dev(devp);
>  	struct fw_ohci *ohci = pci_get_drvdata(dev);
>  	int err;
>  
>  	pmac_ohci_on(dev);
> -	pci_set_power_state(dev, PCI_D0);
> -	pci_restore_state(dev);
> -	err = pci_enable_device(dev);
> -	if (err) {
> -		ohci_err(ohci, "pci_enable_device failed\n");
> -		return err;
> -	}
>  
>  	/* Some systems don't setup GUID register on resume from ram  */
>  	if (!reg_read(ohci, OHCI1394_GUIDLo) &&
> @@ -3838,7 +3821,6 @@ static int pci_resume(struct pci_dev *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct pci_device_id pci_table[] = {
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_FIREWIRE_OHCI, ~0) },
> @@ -3847,15 +3829,14 @@ static const struct pci_device_id pci_table[] = {
>  
>  MODULE_DEVICE_TABLE(pci, pci_table);
>  
> +static SIMPLE_DEV_PM_OPS(pci_pm_ops, pci_suspend, pci_resume);
> +
>  static struct pci_driver fw_ohci_pci_driver = {
>  	.name		= ohci_driver_name,
>  	.id_table	= pci_table,
>  	.probe		= pci_probe,
>  	.remove		= pci_remove,
> -#ifdef CONFIG_PM
> -	.resume		= pci_resume,
> -	.suspend	= pci_suspend,
> -#endif
> +	.driver.pm	= &pci_pm_ops,
>  };
>  
>  static int __init fw_ohci_init(void)
> -- 
> 2.25.1
> 
