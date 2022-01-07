Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1797F487EB4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 22:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiAGV6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 16:58:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45448 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiAGV6w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 16:58:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59D56B8277F;
        Fri,  7 Jan 2022 21:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8FEC36AE5;
        Fri,  7 Jan 2022 21:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641592729;
        bh=EwP7Xp/LtP68ZAYO3sWeEvF11RHeh/xMBa1nh2xQKNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMe/l16P0abU+OjD+b2yegR9/dxcudNrwpIf0XtUODNTrjqYO8akutI7loyvtc0cL
         oRRGCTR7wRXxtNvReGxcLoB54YQeOcjXbNFcJuObX4f76bIpXH+mkByPiSvbdcWnbO
         GIEWkQ2XdJOhvxbHtf99ZBlChyQUIMtpSWfZAB5wV1i6JVov47z7U+FyrnzhvQnnMp
         bRBd4neGYESw0jQPTCta8yIMA/5EQxLgkNvcutptejZ11/IrLpRJR7eKXNfdxU+iWD
         6sWsxumSoj7vTTv18fYWyDBUH0StdskKgZzbHU6xTsDJlp0thbSr+ppkvD1ccU8ZGp
         GkKPspg8TtcHw==
Received: by pali.im (Postfix)
        id 45718B22; Fri,  7 Jan 2022 22:58:46 +0100 (CET)
Date:   Fri, 7 Jan 2022 22:58:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] PCI: mvebu: Check that PCI bridge specified in DT
 has function number zero
Message-ID: <20220107215846.i5n4gx56deqfs3y4@pali>
References: <20220107181819.yiya3mxhtfsnubg4@pali>
 <20220107210902.GA403155@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107210902.GA403155@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 January 2022 15:09:02 Bjorn Helgaas wrote:
> On Fri, Jan 07, 2022 at 07:18:19PM +0100, Pali Rohár wrote:
> > On Friday 07 January 2022 12:15:12 Bjorn Helgaas wrote:
> > > On Thu, Nov 25, 2021 at 01:45:53PM +0100, Pali Rohár wrote:
> > > > Driver cannot handle PCI bridges at non-zero function address. So add
> > > > appropriate check. Currently all in-tree kernel DTS files set PCI bridge
> > > > function to zero.
> > > 
> > > Why can the driver not handle bridges at non-zero function addresses?
> > > The PCI spec allows that, doesn't it?  Is this a hardware limitation?
> > 
> > It is software / kernel limitation.
> > 
> > Because this bridge is virtual, emulated by pci-bridge-emul.c driver and
> > this driver can emulate only single function PCI-to-PCI bridge device.
> 
> That's weird.  Why does pci-bridge-emul.c care about the function
> number?

pci-bridge-emul.c emulates whole PCI config space and multifunction PCI
device needs to have Multi-Function Device bit set. Which
pci-bridge-emul.c does not do as it "emulates" only singe-function
device. Also some extended PCIe registers needs to be aligned for
multifunction device. And for simplification nothing from this is
implemented in that pci-bridge-emul.c driver. Basically single function
device is easily to emulate than multi function device. And for
simplicity of driver it is just better to do not implement more stuff
if it is not required.

> Or maybe you're saying that pci-mvebu.c isn't smart enough to
> build an emulated bridge at a non-zero function?  Or, since this is
> emulated, maybe there's just no *reason* to ever use a non-zero
> function?

These PCIe root ports are basically on different PCI domains, every root
port with its subtree has its own configuration, including own access
to config space of subdevices. And I do not think that there is a reason
to try putting root port (as emulated pci-to-pci bridge) on non-zero
function and putting separate root ports into "one" multifunction
device.

Technically it could be possible to implement it and also properly, as
it is just emulation of PCI device. But why? Just big complication
without any benefit. At least I do not see benefit.

> It would really be nice to have the commit log and maybe even a
> comment allude to what's going on here .  Otherwise this check sort of
> dangles without having an obvious reason for existence.
> 
> Does this issue also affect pci-aardvark.c (which looks like the only
> other user of pci_bridge_emul_init())?

Theoretically yes. But pci-aardvark is single-root-port hardware and
therefore it is single-function device. And emulated device is
registered by pci-aardvark driver, not by DT. Because it is
single-root-port HW there is no DT node for root port like for any other
single-root-port PCIe controllers. So practically no.

> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/pci/controller/pci-mvebu.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > > index 6197f7e7c317..08274132cdfb 100644
> > > > --- a/drivers/pci/controller/pci-mvebu.c
> > > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > > @@ -864,6 +864,11 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> > > >  	port->devfn = of_pci_get_devfn(child);
> > > >  	if (port->devfn < 0)
> > > >  		goto skip;
> > > > +	if (PCI_FUNC(port->devfn) != 0) {
> > > > +		dev_err(dev, "%s: invalid function number, must be zero\n",
> > > > +			port->name);
> > > > +		goto skip;
> > > > +	}
> > > >  
> > > >  	ret = mvebu_get_tgt_attr(dev->of_node, port->devfn, IORESOURCE_MEM,
> > > >  				 &port->mem_target, &port->mem_attr);
> > > > -- 
> > > > 2.20.1
> > > > 
