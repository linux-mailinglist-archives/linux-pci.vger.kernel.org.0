Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0AE60D642
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJYVlh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJYVlf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 17:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7E7B5BD;
        Tue, 25 Oct 2022 14:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 389B261B44;
        Tue, 25 Oct 2022 21:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FCCC433C1;
        Tue, 25 Oct 2022 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666734091;
        bh=g0MQtgRYZfDOv+tEhLc+C4W38o44WvYauhAjZ+Pk7Fo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eRHSsYYNd2WHenoJlMdU7oedcYXyv4fgNtea/qfBXDf04xxtRxqePF08Kc3T/Vx/F
         mylfxCeDlCh5158Ob2ZHqnnYXHLDS3f1LvRL7va8B8+FLTfnIo4FXBcO4R39MfeLWn
         Y8KKUT4fc0/TDNAv8jt7Q24dY0ZCm9e8N1gpRQyqRWuAPzu8E7YiJGz7v9pyw5xHyB
         //19100QJbm8QVP9PULkOb3GXGu0Dqtee6uAsWNy1KQn4BWhjt9fj4ofOvYmwC+bgs
         hPsK5AszLMIfzlLxEdBfcbX9UOBuPux4RGueWK6Yhz67SP1p/Sxi7IOyt0Y4IesILv
         yVz6eGduq1cIw==
Date:   Tue, 25 Oct 2022 16:41:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] firewire: ohci: convert to generic power management
Message-ID: <20221025214129.GA688126@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025212521.686779-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 04:25:21PM -0500, Bjorn Helgaas wrote:
> From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> 
> Convert ohci from legacy PCI power management to the generic power
> management framework.

> v1 was posted at https://lore.kernel.org/r/20200720150715.624520-1-vaibhavgupta40@gmail.com
> 
> Changes from v1 to v2:
>   - Convert from SIMPLE_DEV_PM_OPS() (which is deprecated) to
>     DEFINE_SIMPLE_DEV_PM_OPS() and remove __maybe_unused annotations.
>   - Expand commit log.

My mistake: This should have been marked *v3*.  v1 was posted as
listed above.

I posted a v2 in June at https://lore.kernel.org/all/20220607212157.343033-1-helgaas@kernel.org/,
which had an expanded commit log and trivial parameter renames.

So this should have been marked v3 and added the
DEFINE_SIMPLE_DEV_PM_OPS() conversion.

Bjorn

>  drivers/firewire/ohci.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
> index 17c9d825188b..f3cceca51e59 100644
> --- a/drivers/firewire/ohci.c
> +++ b/drivers/firewire/ohci.c
> @@ -3165,7 +3165,6 @@ static int ohci_set_iso_channels(struct fw_iso_context *base, u64 *channels)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_PM
>  static void ohci_resume_iso_dma(struct fw_ohci *ohci)
>  {
>  	int i;
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
> +static int pci_suspend(struct device *dev)
>  {
> -	struct fw_ohci *ohci = pci_get_drvdata(dev);
> -	int err;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct fw_ohci *ohci = pci_get_drvdata(pdev);
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
> -	pmac_ohci_off(dev);
> +	pmac_ohci_off(pdev);
>  
>  	return 0;
>  }
>  
> -static int pci_resume(struct pci_dev *dev)
> +static int pci_resume(struct device *dev)
>  {
> -	struct fw_ohci *ohci = pci_get_drvdata(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct fw_ohci *ohci = pci_get_drvdata(pdev);
>  	int err;
>  
> -	pmac_ohci_on(dev);
> -	pci_set_power_state(dev, PCI_D0);
> -	pci_restore_state(dev);
> -	err = pci_enable_device(dev);
> -	if (err) {
> -		ohci_err(ohci, "pci_enable_device failed\n");
> -		return err;
> -	}
> +	pmac_ohci_on(pdev);
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
> +static DEFINE_SIMPLE_DEV_PM_OPS(pci_pm_ops, pci_suspend, pci_resume);
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
