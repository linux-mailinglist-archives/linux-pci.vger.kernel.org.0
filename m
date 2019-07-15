Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEDB69766
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 17:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfGOPK1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 11:10:27 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43476 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbfGOPK1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 11:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7d9E/+uS/LbEKMv/pk7fdGoaJqxaCi45qzlBCe6X+y4=; b=lHtyRcscbEO/YUttpfQ+8XJXr
        SgvcFo5dej0fLuJGCyAUQXfY8b7qYZk7MA6Ry/NOsaCVP3Seq9QZlTyxUxFNY2xCJisicRvGtqVrB
        i1H/ucs5/MDbD49uoiiQZJ/nYSi4yQ37Kq1Pp5EQLu9WpbxAsJ1FfywnHKzJQ+Qg5kWZay77jQM+l
        kwTdjJRNzEzwarQKzBLxMa/1Xocfi88NjsQEQXFGnvis2ZfUkrgKMB40yIxya+AmzwX2WgTo0S/4W
        bSRDMckeCH7L3Y7eAR0R0y/WKu90pE3bnZj935+9oie6ejVn80D1rLQOTUFamgZsdHw30JnP7sqag
        wKfX3hLwg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:59426)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hn2cO-0005fa-A5; Mon, 15 Jul 2019 16:10:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hn2cK-0008SY-Ik; Mon, 15 Jul 2019 16:10:16 +0100
Date:   Mon, 15 Jul 2019 16:10:16 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Grzegorz Jaszczyk <jaz@semihalf.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mw@semihalf.com
Subject: Re: [PATCH] PCI: aardvark: fix big endian support
Message-ID: <20190715151016.6amymuikizmmmsph@shell.armlinux.org.uk>
References: <1563200122-8323-1-git-send-email-jaz@semihalf.com>
 <20190715170840.326acd73@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715170840.326acd73@windsurf>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 15, 2019 at 05:08:40PM +0200, Thomas Petazzoni wrote:
> Hello Grzegorz,
> 
> Thanks for this work. I indeed never tested this code on BE platforms,
> and it is very possible that I overlooked endianness issues, so thanks
> for having a look at this and proposing some patches. See some
> questions/comments below.
> 
> On Mon, 15 Jul 2019 16:15:22 +0200
> Grzegorz Jaszczyk <jaz@semihalf.com> wrote:
> 
> > Initialise every not-byte wide fields of emulated pci bridge config
> > space with proper cpu_to_le* macro. This is required since the structure
> > describing config space of emulated bridge assumes little-endian
> > convention.
> > 
> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 134e030..06a12749 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -479,8 +479,10 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  {
> >  	struct pci_bridge_emul *bridge = &pcie->bridge;
> >  
> > -	bridge->conf.vendor = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff;
> > -	bridge->conf.device = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16;
> > +	bridge->conf.vendor =
> > +		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
> > +	bridge->conf.device =
> > +		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16);
> >  	bridge->conf.class_revision =
> >  		advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;
> 
> So conf.vendor and conf.device and stored as little-endian in the
> emulated config address space, but conf.class_revision is stored in the
> CPU endianness ?
> 
> >  
> > @@ -489,8 +491,8 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  	bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
> 
> >  
> >  	/* Support 64 bits memory pref */
> > -	bridge->conf.pref_mem_base = PCI_PREF_RANGE_TYPE_64;
> > -	bridge->conf.pref_mem_limit = PCI_PREF_RANGE_TYPE_64;
> > +	bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> > +	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> 
> Same here: why are conf.pref_mem_{base,limit} converted to LE, but not
> conf.iolimit ?
> 
> Also, the advk_pci_bridge_emul_pcie_conf_read() and
> advk_pci_bridge_emul_pcie_conf_write() return values that are in the
> CPU endianness.
> 
> Am I missing something ?

Getting the types correct and then using Sparse to validate the code
will help to identify issues exactly like this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
