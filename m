Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C55332F4
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 23:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiEXV35 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 17:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiEXV34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 17:29:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414EF7A821;
        Tue, 24 May 2022 14:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B168EB81BDB;
        Tue, 24 May 2022 21:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214A0C34100;
        Tue, 24 May 2022 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653427792;
        bh=AFWPUQLg3Lbg9QwCKuhXWThTOdPU5aKqp0hjACicNMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PgG98DMxQAVHzO+sjB04gDudV8hBwr42+EVh2JE+rr7R66sLxih4kroDcYWGFuxyi
         y9UkL3Nqj/xB/hcFNTOTxkC7RHBKIYsA+H/H2/L0Iuhwj2npfa+FnH7+qX9mrpV1Hp
         FqdnFr2nwMQIZ9gBBJr+9Nkzcm5Iu7mbqiAb+PPr5oTuslhyu7U9F4aJOqE+Wad+Yn
         ZJPonpjUG6fLIYoXHYP48RzdL+7DYwFlZboPX/JVaQf5S1Q16Xrhj9HfJDzMet+81o
         MmkapYfwS9Gw4qmB/mAQsUETpodamux2rVY5SG/xN63QP9SH+GWx7rrtBBDHz0zXMp
         t5G98Yp9i+8jQ==
Date:   Tue, 24 May 2022 16:29:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v14 04/11] PCI: kirin: Add support for bridge slot DT
 schema
Message-ID: <20220524212950.GA269059@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524215507.16e97815@coco.lan>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Yicong, Rafael, just FYI; trying to figure out how native host
bridge drivers should do power management]

On Tue, May 24, 2022 at 09:55:41PM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 24 May 2022 12:19:47 -0500
> Bjorn Helgaas <helgaas@kernel.org> escreveu:
> > On Tue, Oct 19, 2021 at 07:06:41AM +0100, Mauro Carvalho Chehab wrote:
> > > On HiKey970, there's a PEX 8606 PCI bridge on its PHY with
> > > 6 lanes. Only 4 lanes are connected:
> > > 
> > > 	lane 0 - connected to Kirin 970;
> > > 	lane 4 - M.2 slot;
> > > 	lane 5 - mini PCIe slot;
> > > 	lane 6 - in-board Ethernet controller.
> > > 
> > > Each lane has its own PERST# gpio pin, and needs a clock
> > > request.
> > > 
> > > Add support to parse a DT schema containing the above data.
> > > 
> > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > > 
> > > See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/
> > > 
> > >  drivers/pci/controller/dwc/pcie-kirin.c | 262 +++++++++++++++++++++---
> > >  1 file changed, 231 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > index 86c13661e02d..de375795a3b8 100644
> > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > @@ -52,6 +52,19 @@
> > >  #define PCIE_DEBOUNCE_PARAM	0xF0F400
> > >  #define PCIE_OE_BYPASS		(0x3 << 28)
> > >  
> > > +/*
> > > + * Max number of connected PCI slots at an external PCI bridge
> > > + *
> > > + * This is used on HiKey 970, which has a PEX 8606 bridge with has
> > > + * 4 connected lanes (lane 0 upstream, and the other tree lanes,
> > > + * one connected to an in-board Ethernet adapter and the other two
> > > + * connected to M.2 and mini PCI slots.
> > > + *
> > > + * Each slot has a different clock source and uses a separate PERST#
> > > + * pin.
> > > ...  
> > 
> > > +static int kirin_pcie_add_bus(struct pci_bus *bus)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
> > > +	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
> > > +	int i, ret;
> > > +
> > > +	if (!kirin_pcie->num_slots)
> > > +		return 0;
> > > +
> > > +	/* Send PERST# to each slot */
> > > +	for (i = 0; i < kirin_pcie->num_slots; i++) {
> > > +		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
> > > +		if (ret) {
> > > +			dev_err(pci->dev, "PERST# %s error: %d\n",
> > > +				kirin_pcie->reset_names[i], ret);
> > > +		}
> > > +	}
> > > +	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +
> > >  static struct pci_ops kirin_pci_ops = {
> > >  	.read = kirin_pcie_rd_own_conf,
> > >  	.write = kirin_pcie_wr_own_conf,
> > > +	.add_bus = kirin_pcie_add_bus,  
> > 
> > This seems a little weird.  Can you educate me?
> > 
> > From [1], it looks like the topology here is:
> > 
> >   00:00.0 Root Port
> >   01:00.0 PEX 8606 Upstream Port
> >   02:01.0 PEX 8606 Downstream Port
> >   02:04.0 PEX 8606 Downstream Port
> >   02:05.0 PEX 8606 Downstream Port
> >   02:07.0 PEX 8606 Downstream Port
> >   02:09.0 PEX 8606 Downstream Port
> >   06:00.0 RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller 
> > 
> > The .add_bus() callback will be called for *every* child bus we want
> > to enumerate.  So if any of those PEX 8606 Downstream Ports are
> > connected to another switch, when we enumerate the secondary buses of
> > that other switch, it looks like we'll send PERST# to all the slots
> > again, which doesn't sound right.  Am I missing something?
> 
> The implementation made on Kirin 960/970 for PCI is to not have a
> PERST# bus. Instead, it has one independent GPIO driving the PERST#
> signal for each single individual port that is physically connected.
> 
> See the schematics at:
> 
> 	- https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
> 	- https://github.com/96boards/documentation/blob/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> 
> Yet, my first proposal were to send all GPIOs altogether. See, for
> instance:
> 
> 	https://lore.kernel.org/all/3acf2c073e8ea67efaae91074dda0763bf7a2ab9.1626768323.git.mchehab+huawei@kernel.org/
> 
> There, the PERST# signals are initialized altogether, at the end
> of hi3670_pcie_phy_power_on():
> 
> 	/* perst assert Endpoints */
> 	usleep_range(21000, 23000);
> 	for (i = 0; i < phy->n_gpio_resets; i++) {
> 		ret = gpio_direction_output(phy->gpio_id_reset[i], 1);
> 		if (ret)
> 			return ret;
> 	}
> 	usleep_range(10000, 11000);
> 
> 	ret = is_pipe_clk_stable(phy);
> 	if (!ret)
> 		goto disable_clks;
> 
> 	hi3670_pcie_set_eyeparam(phy);
> 
> 	ret = hi3670_pcie_noc_power(phy, false);
> 	if (ret)
> 		goto disable_clks;
> 
> During the review process, I was requested to change it in order to do it
> via .add_bus. 

I see Rob suggested .add_bus() at
https://lore.kernel.org/all/CAL_JsqLA7Z908SQKkZpyEcCvpkWsW3pa42eajpxCSkbUy4rv9g@mail.gmail.com/

This seems sort of similar to what Yicong is doing here:
https://lore.kernel.org/r/20220517124319.47125-1-yangyicong@hisilicon.com
but I don't know enough to put all the pieces together.

> On my tests at the boards, I didn't see the same PERST#
> signal to hit more than once, and the driver is working fine. 
> So, this wasn't an actual issue, as far as I can tell. 

Do you remember whether you tested with a switch below the PEX 8606?
E.g., something like this:

  00:00.0 Root Port                to [bus 01-ff]
  01:00.0 PEX 8606 Upstream Port   to [bus 02-ff]
  02:01.0 PEX 8606 Downstream Port to [bus 06-ff]
  06:00.0 Switch Upstream Port     to [bus 07-ff]
  07:01.0 Switch Downstream Port   to [bus 08]
  08:00.0 Endpoint

I think kirin_pcie_add_bus() will be called several times, probably
once for each bus (00, 01, 02, 06, 07, 08), and it looks like it will
do the same thing every time.  Do we reset the 8606 again when we're
about to scan bus 08?  Surely not, because otherwise we would have
reset the 8606 when scanning bus 06 in the original topology where the
8606 is the only switch.

I don't know enough about GPIOs to understand what happens here.  The
doc suggests that gpio_direction_output() sets the direction (output)
and the initial output value (1).  But I don't see any other reference
to gpio_id_reset[i] that looks like it deasserts PERST#.

Bjorn
