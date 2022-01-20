Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1ED49530C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377283AbiATRTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 12:19:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53932 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243820AbiATRTV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 12:19:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04B4CB81DCA;
        Thu, 20 Jan 2022 17:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7B7C340E0;
        Thu, 20 Jan 2022 17:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642699158;
        bh=0Y/kJB/srmy+r+MEK/5ohc3fkdE7T0+Rn088nWxZJpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlsTCW3Srryxw9CRk5M2HtWOeoYrv8BPvnKoSZ4+Ch22FZDBSltUgNOwN/V0wxOgn
         8a0tOHGKxhuMWhaTBGAqB0e/kWnix9Hv3TvGPRP5oDkdpDGx109Cn4tWaRWk8i+jFi
         oQ+g2z4/oyrj7MZyMwOlilphbV0SY/NDGomPHhXS+bvzhwCBELuDAAIUqRq3HqAeMS
         AdkXlknIJSOt0LqqsNbMJ4JIjF/tJKMSEC/S6JCxAhnElnrZSOJ65R2Ocv072GYN0M
         /3TzoQ31ALsAW/1uy+Lg610vHArzmjGEYaK2WKny41i5qCC0GRzXhoW6ixa9JF7U4o
         YRnzh1rz3pwNw==
Received: by pali.im (Postfix)
        id DFABC791; Thu, 20 Jan 2022 18:19:15 +0100 (CET)
Date:   Thu, 20 Jan 2022 18:19:15 +0100
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
Subject: Re: [PATCH v2 05/11] PCI: mvebu: Correctly configure x1/x4 mode
Message-ID: <20220120171915.rynfs3hucnfj4kyb@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-6-pali@kernel.org>
 <YemXPQx4F1eRtLxO@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YemXPQx4F1eRtLxO@robh.at.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 20 January 2022 11:09:17 Rob Herring wrote:
> On Wed, Jan 12, 2022 at 04:18:08PM +0100, Pali Rohár wrote:
> > If x1/x4 mode is not set correctly then link with endpoint card is not
> > established.
> > 
> > Use DTS property 'num-lanes' to deteriminate x1/x4 mode.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index a075ba26cff1..0f2ec0a17874 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -93,6 +93,7 @@ struct mvebu_pcie_port {
> >  	void __iomem *base;
> >  	u32 port;
> >  	u32 lane;
> > +	bool is_x4;
> 
> I would just store the number of lanes.
> 
> >  	int devfn;
> >  	unsigned int mem_target;
> >  	unsigned int mem_attr;
> > @@ -233,13 +234,25 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
> >  
> >  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> >  {
> > -	u32 ctrl, cmd, dev_rev, mask;
> > +	u32 ctrl, lnkcap, cmd, dev_rev, mask;
> >  
> >  	/* Setup PCIe controller to Root Complex mode. */
> >  	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
> >  	ctrl |= PCIE_CTRL_RC_MODE;
> >  	mvebu_writel(port, ctrl, PCIE_CTRL_OFF);
> >  
> > +	/*
> > +	 * Set Maximum Link Width to X1 or X4 in Root Port's PCIe Link
> > +	 * Capability register. This register is defined by PCIe specification
> > +	 * as read-only but this mvebu controller has it as read-write and must
> > +	 * be set to number of SerDes PCIe lanes (1 or 4). If this register is
> > +	 * not set correctly then link with endpoint card is not established.
> > +	 */
> > +	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
> > +	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
> > +	lnkcap |= (port->is_x4 ? 4 : 1) << 4;
> 
> then this is just: lanes << 4

As only 1 and 4 are valid valid values, I chose this style (is_x4) to
ensure that no other (invalid) value is written into mvebu register.
Setting width to smaller number (if incorrect value is provided) still
allows controller to work and link should be negotiated. So setting 1 is
a sane default when controller does not have configured 4 SerDes lines
to PCIe.

> > +	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
> > +
> >  	/* Disable Root Bridge I/O space, memory space and bus mastering. */
> >  	cmd = mvebu_readl(port, PCIE_CMD_OFF);
> >  	cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> > @@ -986,6 +999,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> >  	struct device *dev = &pcie->pdev->dev;
> >  	enum of_gpio_flags flags;
> >  	int reset_gpio, ret;
> > +	u32 num_lanes;
> >  
> >  	port->pcie = pcie;
> >  
> > @@ -998,6 +1012,9 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> >  	if (of_property_read_u32(child, "marvell,pcie-lane", &port->lane))
> >  		port->lane = 0;
> >  
> > +	if (!of_property_read_u32(child, "num-lanes", &num_lanes) && num_lanes == 4)
> > +		port->is_x4 = true;
> 
> And this can be:
> 
> num_lanes = 1;
> of_property_read_u32(child, "num-lanes", &num_lanes);
> 
> If you want to validate the DT is only 1 or 4, make the DT schema do 
> that.

The problem is that there is no schema for this platform and PCIe yet.
So adding it would mean to first convert everything to schema and then
this constrain can be expressed in schema.

I'm planning to look at possibility to write schema for this platform
but I do not want to do it before open issues with representation of
other pcie properties in dts schema are resolved.

> 
> > +
> >  	port->name = devm_kasprintf(dev, GFP_KERNEL, "pcie%d.%d", port->port,
> >  				    port->lane);
> >  	if (!port->name) {
> > -- 
> > 2.20.1
> > 
> > 
