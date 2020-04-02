Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75219CA49
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 21:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbgDBTkK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 15:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732625AbgDBTkJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Apr 2020 15:40:09 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83F0206F8;
        Thu,  2 Apr 2020 19:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585856408;
        bh=pverSPU32ehzvi/6uILs11ZGZuyU/iubPLzeloiCKC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s8H6rbB+0cPjjF5RR95Zz0MFmgQ/FSphxeIxljYSsXH5VvAYsqo0yX2qnPYhqXbui
         JwdQvYu/tBhNTZYcqXPlyY1s4LxRkbNqjq4SM+omvnmst0p29AD9e3zm1pmDacaTK5
         A14Caex2L5sCS6AcEIbHuuLcn2lVDwteMVY0adsc=
Date:   Thu, 2 Apr 2020 14:40:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v6 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
Message-ID: <20200402194005.GA35725@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88456b80396331814fca9c929c2129861aaa35bd.camel@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 02, 2020 at 01:32:35PM +0200, Nicolas Saenz Julienne wrote:
> On Wed, 2020-04-01 at 15:37 -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 24, 2020 at 07:28:10PM +0100, Nicolas Saenz Julienne wrote:
> > > On the Raspberry Pi 4, after a PCI reset, VL805's firmware may
> > > either be loaded directly from an EEPROM or, if not present, by
> > > the SoC's VideCore. The function informs VideCore that VL805 was
> > > just reset, or requests for a probe defer.

Is VL805 the XHCI USB device?  A hint here would help non-RPi experts
know how this fits into the topology.

> > > Based on Tim Gover's downstream implementation.
> >
> > Maybe a URL?
> 
> I was under the impression that adding links in the commit log that
> are likely to be short-lived was frowned upon. That said I could've
> added it into the cover letter. For reference here it is:
> 
> https://github.com/raspberrypi/linux/commit/9935b4c7e360b4494b4cb6e3ce797238a1ab78bd

I think your impression is correct.  If this was posted to a mailing
list archived on lore.kernel.org, a link to the cover letter would be
ideal.

> To pass messages down the mailbox, you call rpi_firmware_property(),
> which takes care of contention, formating and DMA issues, before
> passing it into the actual mailbox interface and beyond.

OK.  The "rpi_firmware_property" name doesn't give much of a hint that
it is sending messages.  It sounds like it might be a lookup function.
But that's an existing thing, not something you're changing here.

> > > + */
> > > +int rpi_firmware_init_vl805(struct pci_dev *pdev)
> > > +{
> > > +	struct device_node *fw_np;
> > > +	struct rpi_firmware *fw;
> > > +	u32 dev_addr;
> > > +	int ret;
> > > +
> > > +	fw_np = of_find_compatible_node(NULL, NULL,
> > > +					"raspberrypi,bcm2835-firmware");
> > > +	if (!fw_np)
> > > +		return 0;
> > > +
> > > +	fw = rpi_firmware_get(fw_np);
> > > +	of_node_put(fw_np);
> > > +	if (!fw)
> > > +		return -EPROBE_DEFER;
> > > +
> > > +	dev_addr = pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
> > > +		   PCI_FUNC(pdev->devfn) << 12;
> > > +
> > > +	ret = rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
> > > +				    &dev_addr, sizeof(dev_addr));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	dev_dbg(&pdev->dev, "loaded Raspberry Pi's VL805 firmware\n");
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(rpi_firmware_init_vl805);
> > > +
> > >  static const struct of_device_id rpi_firmware_of_match[] = {
> > >  	{ .compatible = "raspberrypi,bcm2835-firmware", },
> > >  	{},
> 
> [...]
> 
> Regards,
> Nicolas
> 


