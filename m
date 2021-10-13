Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F86742B28C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 04:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhJMCPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 22:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhJMCPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 22:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30DE560E0C;
        Wed, 13 Oct 2021 02:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634091192;
        bh=KiCOpXJtLtS5DgA89L5VHZVV6seYAK79kT/+26LXy+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rbsD9cK4wZlyphGRjfr1ysvki7scvQqV5s3dfffPqIGaP/N/LkDsfLMB+d5CagphS
         4M4P783zd6dkXrVo7WRLzDUp/GDS2oqlaABys/puDUZ1JQ45KFZ5KXbai237P1udeA
         fPugekLr4JfA5M5S/mMyCGYl6R8tVZrXA7SZXhZL6mMg3bwwGcWh40vCqGEHo14LI7
         tJBBW68o+EI+RR10wK8fdNONA1j4Qp7GF2qZ6SPG3aJX4L7KiEjcgez7IKGkl6DiCw
         2wjGw63KR530UJz0DU17dQu12Spzf/cU+dG+gA33w5ZmtyYyQcR+ClKZWwnYeIKLEo
         co8UKkygxVpqw==
Date:   Tue, 12 Oct 2021 21:13:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "moderated list:PCI DRIVER FOR AARDVARK (Marvell Armada 3700)" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 09/22] PCI: aardvark: Use SET_PCI_ERROR_RESPONSE() when
 device not found
Message-ID: <20211013021310.GA1864069@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012155928.3nuyzgrgvyjm2v3r@theprophet>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 09:29:28PM +0530, Naveen Naidu wrote:
> On 11/10, Pali Rohár wrote:
> > On Monday 11 October 2021 23:55:35 Naveen Naidu wrote:
> > > On 11/10, Pali Rohár wrote:
> > > > On Monday 11 October 2021 23:26:33 Naveen Naidu wrote:
> > > > > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > > > > causes a PCI error.  There's no real data to return to satisfy the
> > > > > CPU read, so most hardware fabricates ~0 data.
> > > > > 
> > > > > Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
> > > > > read occurs.
> > > > > 
> > > > > This helps unify PCI error response checking and make error check
> > > > > consistent and easier to find.
> > > > > 
> > > > > Compile tested only.
> > > > > 
> > > > > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > > > > ---
> > > > >  drivers/pci/controller/pci-aardvark.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > > index 596ebcfcc82d..dc2f820ef55f 100644
> > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > @@ -894,7 +894,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > > > >  	int ret;
> > > > >  
> > > > >  	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
> > > > > -		*val = 0xffffffff;
> > > > > +		SET_PCI_ERROR_RESPONSE(val);
> > > > 
> > > > Hello! Now I'm looking at this macro, and should not it depends on
> > > > "size" argument? If doing 8-bit or 16-bit read operation then should not
> > > > it rather sets only low 8 bits or low 16 bits to ones?

> > Function itself is declared as:
> > 
> > static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where, int size, u32 *val);
> > 
> > And in "size" argument is stored number of bytes, kind of read operation
> > (read byte, read word, read dword). In *val is then stored read value.
> > For byte operation, just low 8 bits in *val variable are set.
> > 
> > Because *val is u32 it means that typeof(*val) is always 4 independently
> > of the "size" argument.
> > 
> > For example other project U-Boot has also pci-aardvark.c driver and
> > U-Boot has for (probably same) purpose pci_get_ff() macro, see:
> > https://source.denx.de/u-boot/u-boot/-/blob/v2021.10/drivers/pci/pci-aardvark.c#L367
> > 
> > I'm not saying if current approach to always sets 0xffffffff
> > (independently of "size" argument) is correct or not as I do not know
> > it too! I'm just giving example that this PCI code has very similar
> > implementation of other project (U-Boot) which sets number of ones based
> > on the size argument.

I don't think there's an issue here.  advk_pcie_rd_conf() can set the
whole u32 to 0xffffffff regardless of the "size" value because
pci_bus_read_config_byte() and pci_bus_read_config_word() extract out
the part they need:

  res = bus->ops->read(bus, devfn, pos, len, &data);              \
  *value = (type)data;                                            \

where "type" is u8 or u16 (this is hard to grep for; it's in the
PCI_OP_READ() macro in drivers/pci/access.c).

> I am not sure too, if we would like to have something like pci_get_ff()
> which sets the return mask based on the size.

I'd like to see how pci_get_ff() works because this is potentially a
widespread, invasive change and it's always better to copy a good
existing design than to make up something new.

> > Anyway, I very like this your idea to have a macro which purpose is to
> > explicitly indicate error during config read operation! And to unify all
> > drivers to use same style for signalling config read error.

I definitely think there's a lot of value in making this consistent
*somehow*, so thanks for working on this!

Bjorn
