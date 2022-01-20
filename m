Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A94952B0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 17:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbiATQzf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 11:55:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45288 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377150AbiATQz3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 11:55:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39CF9B81D9A;
        Thu, 20 Jan 2022 16:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B409FC340E0;
        Thu, 20 Jan 2022 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642697726;
        bh=o20Ul3D9Y2N1+dr7mv+rpVpkHpntzq/L0UM+ShSK1vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMUoaQ/Ghu4KvBsNlkhVvvfqakxkDHzLBpJhqUvfx5YkZieHnBgMLJnIWM/KT+EyA
         G7qUMz7AUxV05ngKCb5zYCmWxZTdl2W6fTJzSThJmpDRKe69BTz11+o1wLJIj+aQp3
         PKLCYo/HkZk+CPdC7pYMcnzp6S2nQ/K70Bzuzl0I+3wUip+Nvx4Jt9kI7M701kDoxX
         8vJ6tslAF2h6TVBLR7njLt2hzT3UPaQUOYLbkLddWgRMqdRRqlR3XeqTyKZqEXDlaz
         LtGJRRX9lh9Nw+UqXNrHN43QQ8EyfnVqKnmkM3WbKQGuBomslEFM8+WpguP5AqVJOe
         UKeBtcBUaPxow==
Received: by pali.im (Postfix)
        id A979E791; Thu, 20 Jan 2022 17:55:22 +0100 (CET)
Date:   Thu, 20 Jan 2022 17:55:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/11] PCI: mvebu: Use child_ops API
Message-ID: <20220120165522.v2xitzokcom4phmw@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-9-pali@kernel.org>
 <YemSgTfl7NiTfcKc@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YemSgTfl7NiTfcKc@robh.at.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 20 January 2022 10:49:05 Rob Herring wrote:
> On Wed, Jan 12, 2022 at 04:18:11PM +0100, Pali Rohár wrote:
> > Split struct pci_ops between ops and child_ops. Member ops is used for
> > accessing PCIe Root Ports via pci-bridge-emul.c driver and child_ops for
> > accessing real PCIe cards.
> > 
> > There is no need to mix these two struct pci_ops into one as PCI core code
> > already provides separate callbacks via bridge->ops and bridge->child_ops.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 82 ++++++++++++++++--------------
> >  1 file changed, 44 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index 9ea2f6a7c2b0..1e90ab888075 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -294,11 +294,29 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> >  	mvebu_writel(port, mask, PCIE_MASK_OFF);
> >  }
> >  
> > -static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
> > -				 struct pci_bus *bus,
> > -				 u32 devfn, int where, int size, u32 *val)
> > +static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
> > +						    struct pci_bus *bus,
> > +						    int devfn);
> > +
> > +static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> > +				    int size, u32 *val)
> >  {
> > -	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
> > +	struct mvebu_pcie *pcie = bus->sysdata;
> > +	struct mvebu_pcie_port *port;
> > +	void __iomem *conf_data;
> > +
> > +	port = mvebu_pcie_find_port(pcie, bus, devfn);
> > +	if (!port) {
> > +		*val = 0xffffffff;
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +	}
> > +
> > +	if (!mvebu_pcie_link_up(port)) {
> > +		*val = 0xffffffff;
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +	}
> > +
> > +	conf_data = port->base + PCIE_CONF_DATA_OFF;
> >  
> >  	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
> >  		     PCIE_CONF_ADDR_OFF);
> > @@ -321,11 +339,21 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
> >  
> > -static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
> > -				 struct pci_bus *bus,
> > -				 u32 devfn, int where, int size, u32 val)
> > +static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
> > +				    int where, int size, u32 val)
> >  {
> > -	void __iomem *conf_data = port->base + PCIE_CONF_DATA_OFF;
> > +	struct mvebu_pcie *pcie = bus->sysdata;
> > +	struct mvebu_pcie_port *port;
> > +	void __iomem *conf_data;
> > +
> 
> > +	port = mvebu_pcie_find_port(pcie, bus, devfn);
> > +	if (!port)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	if (!mvebu_pcie_link_up(port))
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	conf_data = port->base + PCIE_CONF_DATA_OFF;
> 
> Again, the same setup code in read and write is a sign to use 
> .map_bus(). You can copy it from my version I pointed you to.
> 
> Rob

I'm planning to do other cleanup in followup patches. But there are too
many mvebu and aardvark patches on the list waiting, and I do not want
to send another batch.
