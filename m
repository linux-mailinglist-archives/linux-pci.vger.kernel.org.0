Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA778216E50
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGOCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 10:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGGOCr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 10:02:47 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB9ED20738;
        Tue,  7 Jul 2020 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594130566;
        bh=edIgc1HsmNAf0Fn0SMHWtli5jUaKGL0947RRvOW2G+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yXHwPMNojeUXhMOEmzHyHl8EmzY47rKX1qvX5FKtkoDiZpK5tGx06I9dluEM8fJhG
         XCCUlR4qSly/5HxmgHBQ7kXUsBS2Y87+39MBCMt+KqI2CxuDJ7zeGq7wExXuQgnbNK
         cB6vrrfdgounGRCkKNx89GXdGFkMpmrVYJhtGaGk=
Received: by pali.im (Postfix)
        id A62ABBF7; Tue,  7 Jul 2020 16:02:44 +0200 (CEST)
Date:   Tue, 7 Jul 2020 16:02:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Indicate error in 'val' when config read
 fails
Message-ID: <20200707140244.uhmyoqd5mblz5ids@pali>
References: <20200601130315.18895-1-pali@kernel.org>
 <20200619105618.aksoivu4gb5ex3s3@pali>
 <20200707135311.GB17163@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707135311.GB17163@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 07 July 2020 14:53:11 Lorenzo Pieralisi wrote:
> On Fri, Jun 19, 2020 at 12:56:18PM +0200, Pali Rohár wrote:
> > Hello Lorenzo! Could you please review this patch?
> > 
> > On Monday 01 June 2020 15:03:15 Pali Rohár wrote:
> > > Most callers of config read do not check for return value. But most of the
> > > ones that do, checks for error indication in 'val' variable.
> > > 
> > > This patch updates error handling in advk_pcie_rd_conf() function. If PIO
> > > transfer fails then 'val' variable is set to 0xffffffff which indicates
> > > failture.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > I should add credit for Bjorn as he found this issue
> 
> Could you provide a lore archive link to the relevant
> discussion please ? I will apply it then.

Hello Lorenzo! Here is link to the Bjorn's email:
https://lore.kernel.org/linux-pci/20200528162604.GA323482@bjorn-Precision-5520/

> Lorenzo
> 
> > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > 
> > > ---
> > >  drivers/pci/controller/pci-aardvark.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > index 53a4cfd7d377..783a7f1f2c44 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -691,8 +691,10 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > >  	advk_writel(pcie, 1, PIO_START);
> > >  
> > >  	ret = advk_pcie_wait_pio(pcie);
> > > -	if (ret < 0)
> > > +	if (ret < 0) {
> > > +		*val = 0xffffffff;
> > >  		return PCIBIOS_SET_FAILED;
> > > +	}
> > >  
> > >  	advk_pcie_check_pio_status(pcie);
> > >  
> > > -- 
> > > 2.20.1
> > > 
