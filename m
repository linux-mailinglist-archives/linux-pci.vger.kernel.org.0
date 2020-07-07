Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33D0216F4F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGGOuE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 10:50:04 -0400
Received: from foss.arm.com ([217.140.110.172]:54694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGGOuE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 10:50:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C90C0A;
        Tue,  7 Jul 2020 07:50:03 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36123F68F;
        Tue,  7 Jul 2020 07:50:01 -0700 (PDT)
Date:   Tue, 7 Jul 2020 15:49:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Indicate error in 'val' when config read
 fails
Message-ID: <20200707144955.GA17980@e121166-lin.cambridge.arm.com>
References: <20200601130315.18895-1-pali@kernel.org>
 <20200619105618.aksoivu4gb5ex3s3@pali>
 <20200707135311.GB17163@e121166-lin.cambridge.arm.com>
 <20200707140244.uhmyoqd5mblz5ids@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707140244.uhmyoqd5mblz5ids@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 07, 2020 at 04:02:44PM +0200, Pali Rohár wrote:
> On Tuesday 07 July 2020 14:53:11 Lorenzo Pieralisi wrote:
> > On Fri, Jun 19, 2020 at 12:56:18PM +0200, Pali Rohár wrote:
> > > Hello Lorenzo! Could you please review this patch?
> > > 
> > > On Monday 01 June 2020 15:03:15 Pali Rohár wrote:
> > > > Most callers of config read do not check for return value. But most of the
> > > > ones that do, checks for error indication in 'val' variable.
> > > > 
> > > > This patch updates error handling in advk_pcie_rd_conf() function. If PIO
> > > > transfer fails then 'val' variable is set to 0xffffffff which indicates
> > > > failture.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > I should add credit for Bjorn as he found this issue
> > 
> > Could you provide a lore archive link to the relevant
> > discussion please ? I will apply it then.
> 
> Hello Lorenzo! Here is link to the Bjorn's email:
> https://lore.kernel.org/linux-pci/20200528162604.GA323482@bjorn-Precision-5520/

Thanks applied to pci/aardvark.

Lorenzo

> > Lorenzo
> > 
> > > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > > 
> > > > ---
> > > >  drivers/pci/controller/pci-aardvark.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > index 53a4cfd7d377..783a7f1f2c44 100644
> > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > @@ -691,8 +691,10 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > > >  	advk_writel(pcie, 1, PIO_START);
> > > >  
> > > >  	ret = advk_pcie_wait_pio(pcie);
> > > > -	if (ret < 0)
> > > > +	if (ret < 0) {
> > > > +		*val = 0xffffffff;
> > > >  		return PCIBIOS_SET_FAILED;
> > > > +	}
> > > >  
> > > >  	advk_pcie_check_pio_status(pcie);
> > > >  
> > > > -- 
> > > > 2.20.1
> > > > 
