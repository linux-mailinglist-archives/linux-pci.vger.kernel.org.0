Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79B4211E6C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgGBIYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 04:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbgGBIYD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 04:24:03 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 635FF20720;
        Thu,  2 Jul 2020 08:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593678242;
        bh=A4x8rASu1MxlGaK4Uw98Lg3c9yofoP0D7gnk1mnvwQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x7OVPlAjY6MGQp6wnGj9/IFkiOBoc/jegOMFsboi3w/M/7o0WD9ubPagnMIcFwMyJ
         6ruT2TpqQtkJGu5k2iETtFULovOrL+bhlfJqgN/oX3AczHJOtX8v2Cf5YpBhZsQ3U7
         vnxCNNP9F5uS2V+vYf57H/iyktY5nVDHGvMzGNts=
Received: by pali.im (Postfix)
        id D496DE92; Thu,  2 Jul 2020 10:23:59 +0200 (CEST)
Date:   Thu, 2 Jul 2020 10:23:59 +0200
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
Subject: Re: [PATCH v2] PCI: aardvark: Don't touch PCIe registers if no card
 connected
Message-ID: <20200702082359.h6f6r3hsr57fnquh@pali>
References: <20200701082044.4494-1-pali@kernel.org>
 <20200701213442.GA3662456@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701213442.GA3662456@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 01 July 2020 16:34:42 Bjorn Helgaas wrote:
> On Wed, Jul 01, 2020 at 10:20:44AM +0200, Pali Rohár wrote:
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
> > This is just an optimization to prevent accessing PCIe registers when card
> > is disconnected. Trying to access PCIe registers of disconnected card does
> > not cause any crash, kernel just needs to wait for a timeout. So if card
> > disappear immediately after checking for PCIe link (before accessing PCIe
> > registers), it does not cause any problems.
> 
> Thanks, this is good.  I'd really like a short comment in the code as
> well, because this sort of link-up check tends to get copied to new
> drivers where it shouldn't be used, e.g., something like this:
> 
>   /*
>    * If the link goes down after we check for link-up, nothing bad
>    * happens but the config access times out.
>    */

Ok, it makes sense! I will send a new patch version.

> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > ---
> > Changes in V2:
> > * Update commit message, mention that this is optimization
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
> > +
> >  	return true;
> >  }
> >  
> > -- 
> > 2.20.1
> > 
