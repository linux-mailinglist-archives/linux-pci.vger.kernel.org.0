Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE221469F4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 14:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAWNyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 08:54:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgAWNyP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jan 2020 08:54:15 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7545C217F4;
        Thu, 23 Jan 2020 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579787654;
        bh=YBOdkpX3/7VZ9p1SNELglQVwxf7us5kSkFFMsE9oaD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ss/0hO3H8ff/EV8TF3zh8MTjkmvC2FGEZecraEZCkppMC32HmsVCPE/MbYGFAJjyy
         If/Rxy428Bi9ZOQBJsnsmcoWMT0P5ldxCSWUfoLf+KmYpOTcI9eMO0j+pmcA51xyXE
         a3q4lBZxLiIyNEWNsS3i1k7XDE8k8qg9agp6WKcs=
Date:   Thu, 23 Jan 2020 07:54:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Kamlakant Patel <kamlakantp@marvell.com>,
        "prabhakar.pkin@gmail.com" <prabhakar.pkin@gmail.com>
Subject: Re: [PATCH] ata: ahci: Add shutdown to freeze hardware resources of
 ahci
Message-ID: <20200123135413.GA90883@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579776109-31578-1-git-send-email-pkushwaha@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 23, 2020 at 10:41:57AM +0000, Prabhakar Kushwaha wrote:
> device_shutdown() called from reboot/power_shutdown expect all
> devices to be shutdown. Same is true for ahci pci driver.
> As no shutdown function was implemented ata subsystem remains
> always alive and DMA/interrupt still active.
> 
> It creates problem during kexec, here "M" bit is cleared to stop
> DMA usage.

Maybe this is obvious to AHCI folks, but I don't know what "M" bit you
are referring to, and I don't see anything in the patch itself that
looks like an "M" bit.  I thought maybe you meant the "Bus Master
Enable" bit (PCI_COMMAND_MASTER), but I don't see an obvious
connection to that either.

> Any further DMA transaction may cause instability and
> the hard-disk may even not get detected for second kernel.
> One of possible case is periodic file system sync.

I think "may cause instability" and "disk may even not get detected"
is too vague and hand-wavy to really add useful information to the
commit log.

> So defining ahci pci driver shutdown to freeze hardware (mask
> interrupt, stop DMA engine and free DMA resources).
> 
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  drivers/ata/ahci.c        |  8 ++++++++
>  drivers/ata/libata-core.c | 21 +++++++++++++++++++++
>  include/linux/libata.h    |  1 +
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 4bfd1b14b390..31fc934740b6 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -81,6 +81,7 @@ enum board_ids {
>  
>  static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
>  static void ahci_remove_one(struct pci_dev *dev);
> +static void ahci_shutdown_one(struct pci_dev *dev);
>  static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
>  				 unsigned long deadline);
>  static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
> @@ -606,6 +607,7 @@ static struct pci_driver ahci_pci_driver = {
>  	.id_table		= ahci_pci_tbl,
>  	.probe			= ahci_init_one,
>  	.remove			= ahci_remove_one,
> +	.shutdown		= ahci_shutdown_one,
>  	.driver = {
>  		.pm		= &ahci_pci_pm_ops,
>  	},
> @@ -626,6 +628,7 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> +

Spurious whitespace change, please remove.

>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
>  		dev_info(&pdev->dev, "JMB361 has only one port\n");
>  		hpriv->force_port_map = 1;
> @@ -1877,6 +1880,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	return 0;
>  }
>  
> +static void ahci_shutdown_one(struct pci_dev *pdev)
> +{
> +	ata_pci_shutdown_one(pdev);
> +}
> +
>  static void ahci_remove_one(struct pci_dev *pdev)
>  {
>  	pm_runtime_get_noresume(&pdev->dev);
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6f4ab5c5b52d..42c8728f6117 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6767,6 +6767,26 @@ void ata_pci_remove_one(struct pci_dev *pdev)
>  	ata_host_detach(host);
>  }
>  
> +void ata_pci_shutdown_one(struct pci_dev *pdev)
> +{
> +	struct ata_host *host = pci_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < host->n_ports; i++) {
> +		struct ata_port *ap = host->ports[i];
> +
> +		ap->pflags |= ATA_PFLAG_FROZEN;
> +
> +		/* Disable port interrupts */
> +		if (ap->ops->freeze)
> +			ap->ops->freeze(ap);
> +
> +		/* Stop the port DMA engines */
> +		if (ap->ops->port_stop)
> +			ap->ops->port_stop(ap);
> +	}
> +}
> +
>  /* move to PCI subsystem */
>  int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
>  {
> @@ -7387,6 +7407,7 @@ EXPORT_SYMBOL_GPL(ata_timing_cycle2mode);
>  
>  #ifdef CONFIG_PCI
>  EXPORT_SYMBOL_GPL(pci_test_config_bits);
> +EXPORT_SYMBOL_GPL(ata_pci_shutdown_one);
>  EXPORT_SYMBOL_GPL(ata_pci_remove_one);
>  #ifdef CONFIG_PM
>  EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2dbde119721d..bff539918d82 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1221,6 +1221,7 @@ struct pci_bits {
>  };
>  
>  extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
> +extern void ata_pci_shutdown_one(struct pci_dev *pdev);
>  extern void ata_pci_remove_one(struct pci_dev *pdev);
>  
>  #ifdef CONFIG_PM
> -- 
> 2.17.1
> 
