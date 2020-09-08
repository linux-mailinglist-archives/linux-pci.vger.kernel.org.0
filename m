Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96603262269
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 00:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIHWIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 18:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIHWIp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 18:08:45 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFC52087D;
        Tue,  8 Sep 2020 22:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599602925;
        bh=zwjBUwOjGTfEbZT1gPvFnKgEk0SrYJo/S2MVMcETl3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lC8imgfcgq2pSFqv1Kx1AvIUXr85ZofyR35S3lwEryhZWHW59UHA8kbspaVynKSQj
         t2gKD+mZjVwQts/yIt+4zaerE3uOC6+CyVIHjebZ1t7hLJ1/AamgncrfPD/Iv+2h0H
         VloXTVShLvvGz72s3+E/8WrtVccq8DLKw8Zd08jY=
Date:   Tue, 8 Sep 2020 17:08:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Fix bus checks in
 rockchip_pcie_valid_device()
Message-ID: <20200908220843.GA643026@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908100231.GA22909@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 08, 2020 at 11:02:31AM +0100, Lorenzo Pieralisi wrote:
> On Fri, Sep 04, 2020 at 03:09:04PM +0100, Lorenzo Pieralisi wrote:
> > The root bus checks rework in:
> > 
> > commit d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")
> > 
> > caused a regression whereby in rockchip_pcie_valid_device() if
> > the bus parameter is the root bus and the dev value == 0 the
> > function should return 1 (ie true) without checking if the
> > bus->parent pointer is a root bus because that triggers a NULL
> > pointer dereference.
> > 
> > Fix this by streamlining the root bus detection.
> > 
> > Fixes: d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")
> > Reported-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip-host.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Hi Bjorn,
> 
> this is a fix for a patch we merged in the last merge window, can
> we send it for one of the upcoming -rcX please ?

Sure.  I added Samuel's tested-by and put this on for-linus for v5.9.

But is there any chance we can figure out a way to make all these
"valid_device" functions look more similar?  They're a real potpourri
of styles:

  - Most return bool, a couple return int.

  - Some take PCI_SLOT(devfn); others take devfn.

  - Some reject "devfn > 0", others reject only "dev > 0".  Maybe this
    is a real difference, I dunno.

  - A few do unusual things that *look* like pci_is_root_bus():
      bus->primary == to_pci_host_bridge(bus->bridge)->busnr
      bus->number == cfg->busr.start
      bus->number == pcie->root_bus_nr

  - Some check for a negated condition first ("!pci_is_root_bus()"),
    i.e., I always prefer something like this:

      if (pci_is_root_bus(bus))
        return devfn == 0;

      return pcie_link_up();

    over this (from nwl_pcie_valid_device()):

      if (!pci_is_root_bus(bus)) {
        if (!pcie_link_up())
          return false;
      } else if (devfn > 0)
	return false;

      return true;

  - About half check whether the link is up.

  - The comments are pointlessly different.

> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> > index 0bb2fb3e8a0b..9705059523a6 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -71,16 +71,13 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
> >  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
> >  				      struct pci_bus *bus, int dev)
> >  {
> > -	/* access only one slot on each root port */
> > -	if (pci_is_root_bus(bus) && dev > 0)
> > -		return 0;
> > -
> >  	/*
> > -	 * do not read more than one device on the bus directly attached
> > +	 * Access only one slot on each root port.
> > +	 * Do not read more than one device on the bus directly attached
> >  	 * to RC's downstream side.
> >  	 */
> > -	if (pci_is_root_bus(bus->parent) && dev > 0)
> > -		return 0;
> > +	if (pci_is_root_bus(bus) || pci_is_root_bus(bus->parent))
> > +		return dev == 0;
> >  
> >  	return 1;
> >  }
> > -- 
> > 2.26.1
> > 
