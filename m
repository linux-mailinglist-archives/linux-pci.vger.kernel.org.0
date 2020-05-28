Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CAF1E6793
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 18:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405079AbgE1QiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 12:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405066AbgE1QiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 12:38:12 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C30A1207F5;
        Thu, 28 May 2020 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590683891;
        bh=rYOzZYw6qVcWw1+Bgcj/D7ePhlH1Yu7bCEXs98o9kyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KM4GsGGiBme8F3C1xykXFeOmV5RsIvJclB1FhdnudGbtu6HE7QAttcQ9C9wzj09yO
         UquC0s0Yti69s9yLYQ7Ii2DKASs4aCyPR4iyHiiSBUCsc1wgoCd6WcXVh1xiKkEWe+
         rHtIXrxYPUbQszvc85RV9TksBsRhjb9YRRZSzF/g=
Received: by pali.im (Postfix)
        id 6CB79865; Thu, 28 May 2020 18:38:09 +0200 (CEST)
Date:   Thu, 28 May 2020 18:38:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200528163809.54f5ldvphrjg3zg3@pali>
References: <20200528143141.29956-1-pali@kernel.org>
 <20200528162604.GA323482@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528162604.GA323482@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 28 May 2020 11:26:04 Bjorn Helgaas wrote:
> On Thu, May 28, 2020 at 04:31:41PM +0200, Pali Rohár wrote:
> > When there is no PCIe card connected and advk_pcie_rd_conf() or
> > advk_pcie_wr_conf() is called for PCI bus which doesn't belong to emulated
> > root bridge, the aardvark driver throws the following error message:
> > 
> >   advk-pcie d0070000.pcie: config read/write timed out
> > 
> > Obviously accessing PCIe registers of disconnected card is not possible.
> > 
> > Extend check in advk_pcie_valid_device() function for validating
> > availability of PCIe bus. If PCIe link is down, then the device is marked
> > as Not Found and the driver does not try to access these registers.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 90ff291c24f0..53a4cfd7d377 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -644,6 +644,9 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
> >  	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
> >  		return false;
> >  
> > +	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
> > +		return false;
> 
> I don't think this is the right fix.  This makes it racy because the
> link may go down after we call advk_pcie_valid_device() but before we
> perform the config read.

Yes, it is racy, but I do not think it cause problems. Trying to read
PCIe registers when device is not connected cause just those timeouts,
printing error message and increased delay in advk_pcie_wait_pio() due
to polling loop. This patch reduce unnecessary access to PCIe registers
when advk_pcie_wait_pio() polling just fail.

I think it is a good idea to not call blocking advk_pcie_wait_pio() when
it is not needed. We could have faster enumeration of PCIe buses when
card is not connected.

> I have no objection to removing the "config read/write timed out"
> message.  The "return PCIBIOS_SET_FAILED" in the read case probably
> should be augmented by setting "*val = 0xffffffff".
> 
> >  	return true;
> >  }
> >  
> > -- 
> > 2.20.1
> > 
