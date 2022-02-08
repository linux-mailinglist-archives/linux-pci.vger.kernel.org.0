Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21C54AE194
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 19:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbiBHS5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385021AbiBHS5C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 13:57:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F1FC0612C0;
        Tue,  8 Feb 2022 10:57:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC49613FB;
        Tue,  8 Feb 2022 18:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B991EC004E1;
        Tue,  8 Feb 2022 18:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346620;
        bh=OgIu6AK4dgnMnAdqrBey/VPos4o+Hdn3KXBEeOS9NZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MRurM7rglIFff8R+cc3JtR6t1ZAmhGXTRzcDlPpHwjWz0LKUPybd4Cy6aYfv/56XD
         Yh1KddAwSZP5ShE9DOC+1W4kW74TDXZ7VCQJL3k3tmUw7G0L+59KDxjpey2fklq/xl
         JbIpF6PEonVknoj75KQXe0g4A0y4xRoabw1rJCJK1GjbEA322iaERjl7jGHU8y7J+D
         trvw4GGeWGo4DIejwmwByDHKtQbgK6CuQ9Dc+lkt075c7b5reL2QptRQLNydBzfxNX
         gvkW/ybVgSmG47B8JPzVchhclLeL1M0+rly/JPgiw5M1OG8QZimBz5Ouzy8rMynfU/
         qiynlyHJ0c4dw==
Date:   Tue, 8 Feb 2022 12:56:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Spencer <dspencer577@gmail.com>,
        Joey Corleone <joey.corleone@mail.ru>,
        Sergiu Deitsch <sergiu.deitsch@gmail.com>
Subject: Re: [PATCH v2] PCI/portdrv: Do not setup up IRQs if there are no
 users
Message-ID: <20220208185658.GA489586@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f6bc890-3a49-3056-ccee-210de546688e@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc David, Joey, Sergiu]

On Mon, Jan 31, 2022 at 10:22:28PM +0100, Jan Kiszka wrote:
> On 30.08.21 10:08, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > Avoid registering service IRQs if there is no service that offers them
> > or no driver to register a handler against them. This saves IRQ vectors
> > when they are limited (e.g. on x86) and also avoids that spurious events
> > could hit a missing handler. Such spurious events need to be generated
> > by the Jailhouse hypervisor for active MSI vectors when enabling or
> > disabling itself.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> > 
> > Changes in v2:
> >   - move initialization of irqs to address test bot finding
> > 
> >   drivers/pci/pcie/portdrv_core.c | 47 +++++++++++++++++++++------------
> >   1 file changed, 30 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index e1fed6649c41..0e2556269429 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -166,9 +166,6 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
> >   {
> >   	int ret, i;
> > -	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> > -		irqs[i] = -1;
> > -
> >   	/*
> >   	 * If we support PME but can't use MSI/MSI-X for it, we have to
> >   	 * fall back to INTx or other interrupts, e.g., a system shared
> > @@ -312,8 +309,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
> >    */
> >   int pcie_port_device_register(struct pci_dev *dev)
> >   {
> > -	int status, capabilities, i, nr_service;
> > -	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
> > +	int status, capabilities, irq_services, i, nr_service;
> > +	int irqs[PCIE_PORT_DEVICE_MAXSERVICES] = {
> > +		[0 ... PCIE_PORT_DEVICE_MAXSERVICES-1] = -1
> > +	};
> >   	/* Enable PCI Express port device */
> >   	status = pci_enable_device(dev);
> > @@ -326,18 +325,32 @@ int pcie_port_device_register(struct pci_dev *dev)
> >   		return 0;
> >   	pci_set_master(dev);
> > -	/*
> > -	 * Initialize service irqs. Don't use service devices that
> > -	 * require interrupts if there is no way to generate them.
> > -	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
> > -	 * that can be used in the absence of irqs.  Allow them to determine
> > -	 * if that is to be used.
> > -	 */
> > -	status = pcie_init_service_irqs(dev, irqs, capabilities);
> > -	if (status) {
> > -		capabilities &= PCIE_PORT_SERVICE_HP;
> > -		if (!capabilities)
> > -			goto error_disable;
> > +
> > +	irq_services = 0;
> > +	if (IS_ENABLED(CONFIG_PCIE_PME))
> > +		irq_services |= PCIE_PORT_SERVICE_PME;
> > +	if (IS_ENABLED(CONFIG_PCIEAER))
> > +		irq_services |= PCIE_PORT_SERVICE_AER;
> > +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> > +		irq_services |= PCIE_PORT_SERVICE_HP;
> > +	if (IS_ENABLED(CONFIG_PCIE_DPC))
> > +		irq_services |= PCIE_PORT_SERVICE_DPC;
> > +	irq_services &= capabilities;
> > +
> > +	if (irq_services) {
> > +		/*
> > +		 * Initialize service irqs. Don't use service devices that
> > +		 * require interrupts if there is no way to generate them.
> > +		 * However, some drivers may have a polling mode (e.g.
> > +		 * pciehp_poll_mode) that can be used in the absence of irqs.
> > +		 * Allow them to determine if that is to be used.
> > +		 */
> > +		status = pcie_init_service_irqs(dev, irqs, irq_services);
> > +		if (status) {
> > +			irq_services &= PCIE_PORT_SERVICE_HP;
> > +			if (!irq_services)
> > +				goto error_disable;
> > +		}
> >   	}
> >   	/* Allocate child services if any */
> 
> It turns out that this patch causes troubles on some machines, see [1].
> That could be "resolved" by doing
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index bda630889f95..68b0013c3662 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -331,7 +331,7 @@ int pcie_port_device_register(struct pci_dev *dev)
>  	pci_set_master(dev);
> -	irq_services = 0;
> +	irq_services = PCIE_PORT_SERVICE_BWNOTIF;
>  	if (IS_ENABLED(CONFIG_PCIE_PME))
>  		irq_services |= PCIE_PORT_SERVICE_PME;
>  	if (IS_ENABLED(CONFIG_PCIEAER))
> 
> thus considering bandwidth notification as an IRQ-providing service as
> well. But as far as I can see, there is no driver for this port service,
> thus no one should ever request or even handle that interrupt.
> 
> I'm not yet seeing the key difference that could explain this effect.
> What else happens via pcie_device_init() when called for
> PCIE_PORT_SERVICE_BWNOTIF, although there will never be a driver?
> 
> Jan
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215533

Comparing David's "pci=earlydump" logs from [2,3] I see these
differences:

  - BIOS 1.12
  + BIOS 1.14
      00:1d.0 Root Port to [bus 04]
  -     Status: INTx-
  +     Status: INTx+
  -       DevSta: CorrErr+
  +       DevSta: CorrErr-
  -       LnkCtl: CommClk+ AutWidDis+ BWInt- AutBWInt+
  +       LnkCtl: CommClk- AutWidDis- BWInt+ AutBWInt-
      04:00.0 NVMe SSD
  -       LnkCtl: CommClk+ ClockPM-
  +       LnkCtl: CommClk- ClockPM+

It looks like BIOS 1.14 leaves the BWInt bit (Link Bandwidth
Management Interrupt Enable) *set*, while BIOS 1.12 left it cleared.

Joey's log [4] with BIOS 1.14 also shows BWInt set:

  + BIOS 1.14
      00:1d.0 Root Port to [bus 04]
  +     Status: INTx+
  +       DevSta: CorrErr-
  +       LnkCtl: CommClk- AutWidDis- BWInt+ AutBWInt-
      04:00.0 NVMe SSD
  +       LnkCtl: CommClk- ClockPM-

In my opinion this is a BIOS defect.  The BIOS should not leave an
interrupt enabled unless it is prepared to handle the interrupt.

But Linux should be able to tolerate this.  Maybe we could clear
PCI_EXP_LNKCTL_LBMIE and PCI_EXP_LNKCTL_LABIE somewhere like
pci_configure_device().

Maybe we should also clear other PCIe interrupt enables like
PCI_EXP_SLTCTL_CCIE, PCI_EXP_SLTCTL_HPIE, PCI_EXP_RTCTL_PMEIE.
They should be enabled after installing an interrupt handler for them.

Bjorn

[2] https://bugzilla.kernel.org/attachment.cgi?id=300397 [BIOS 1.12 (David)]
[3] https://bugzilla.kernel.org/attachment.cgi?id=300396 [BIOS 1.14 (David)]
[4] https://bugzilla.kernel.org/attachment.cgi?id=300370 [BIOS 1.14 (Joey)]
