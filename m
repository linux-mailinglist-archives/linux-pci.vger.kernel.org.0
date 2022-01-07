Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15DC487E03
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 22:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiAGVJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 16:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiAGVJH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 16:09:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAD6C061574;
        Fri,  7 Jan 2022 13:09:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78A97B82604;
        Fri,  7 Jan 2022 21:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05A8C36AE9;
        Fri,  7 Jan 2022 21:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641589744;
        bh=K/JhrwqQbSMuUehTwf3TsC5iGJ5JuvB2mFD5WJYCTBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C687/ms8TsF5D5FYUSJ8JkUCZI2qUNUy6Ru/vxOD+KCd8ojQDMInY4fdY7dZkUTm0
         QoMgHmVZyTsFCEyBqKzOQBmNumfOxV1MJNrmVJEm5YluP+MHXYWUZXt5l3mkJ1bBKJ
         TXC8q4nctPDoyqUyAaCHBUMw+6dweoml6yoS4XhHDdFMqaoWpbMwTw1/Sb6CdE43M8
         eI3NZ0R8inL/ni1eC+90YBJE9Jyl7GWB6/wHsj/xgbM3zgiBDqMNZgYaqmGIwMmtAZ
         bBb9I2qz8QVHl+HR6ylBDhgFlV0qucRbMCzySXuvSPU7XEIAtWkGzWKLOyxkrAWZ0P
         5CSI43yYmlNeQ==
Date:   Fri, 7 Jan 2022 15:09:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] PCI: mvebu: Check that PCI bridge specified in DT
 has function number zero
Message-ID: <20220107210902.GA403155@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107181819.yiya3mxhtfsnubg4@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 07, 2022 at 07:18:19PM +0100, Pali Rohár wrote:
> On Friday 07 January 2022 12:15:12 Bjorn Helgaas wrote:
> > On Thu, Nov 25, 2021 at 01:45:53PM +0100, Pali Rohár wrote:
> > > Driver cannot handle PCI bridges at non-zero function address. So add
> > > appropriate check. Currently all in-tree kernel DTS files set PCI bridge
> > > function to zero.
> > 
> > Why can the driver not handle bridges at non-zero function addresses?
> > The PCI spec allows that, doesn't it?  Is this a hardware limitation?
> 
> It is software / kernel limitation.
> 
> Because this bridge is virtual, emulated by pci-bridge-emul.c driver and
> this driver can emulate only single function PCI-to-PCI bridge device.

That's weird.  Why does pci-bridge-emul.c care about the function
number?  Or maybe you're saying that pci-mvebu.c isn't smart enough to
build an emulated bridge at a non-zero function?  Or, since this is
emulated, maybe there's just no *reason* to ever use a non-zero
function?

It would really be nice to have the commit log and maybe even a
comment allude to what's going on here .  Otherwise this check sort of
dangles without having an obvious reason for existence.

Does this issue also affect pci-aardvark.c (which looks like the only
other user of pci_bridge_emul_init())?

> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/pci/controller/pci-mvebu.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > index 6197f7e7c317..08274132cdfb 100644
> > > --- a/drivers/pci/controller/pci-mvebu.c
> > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > @@ -864,6 +864,11 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> > >  	port->devfn = of_pci_get_devfn(child);
> > >  	if (port->devfn < 0)
> > >  		goto skip;
> > > +	if (PCI_FUNC(port->devfn) != 0) {
> > > +		dev_err(dev, "%s: invalid function number, must be zero\n",
> > > +			port->name);
> > > +		goto skip;
> > > +	}
> > >  
> > >  	ret = mvebu_get_tgt_attr(dev->of_node, port->devfn, IORESOURCE_MEM,
> > >  				 &port->mem_target, &port->mem_attr);
> > > -- 
> > > 2.20.1
> > > 
