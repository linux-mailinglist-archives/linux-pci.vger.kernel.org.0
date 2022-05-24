Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481DD5330F6
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 21:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbiEXTA1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 15:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbiEXTAL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 15:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D75D18B;
        Tue, 24 May 2022 11:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2438A615D9;
        Tue, 24 May 2022 18:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06077C34100;
        Tue, 24 May 2022 18:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653418787;
        bh=+h+ieYCTWkYVako7OctaUrToDWnh7uksB1QAVUpZpic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=juO+rQ74GC8VC0mAtTo7BoGHdi+NZ5QVbJeSLyx2Ep1+1RqUgR1ZiYBGmDP5M3f84
         N+wussL4mt8XimZG49naSJ09N4HHTh4S3A7xQb57SfyJzEsY9JU2wrAakv2XkdNM2S
         Buwq3mWQTnqQXpeL0tQXNDzxEtLxsewy7mgfrW57PT2J1+FD4qNpmjIZBccIirVgGW
         a0EVoXWK8a+xmsQXfRQ8nyqhrdN3QFufGkGBD588pjcBruvLM7H0xCnosngohuLuir
         WTAuJ0VDPlZuPUVu/1fRCAWuZrau+hExu9I9RrcuzWyMYLDA/Wd+5YgLlBjio9iV6L
         zlINC49r2Zz9Q==
Date:   Tue, 24 May 2022 13:59:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v14 04/11] PCI: kirin: Add support for bridge slot DT
 schema
Message-ID: <20220524185944.GA260276@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524171947.GA255208@bhelgaas>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[resending with updated address for Mauro]

On Tue, May 24, 2022 at 12:19:50PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 19, 2021 at 07:06:41AM +0100, Mauro Carvalho Chehab wrote:
> > On HiKey970, there's a PEX 8606 PCI bridge on its PHY with
> > 6 lanes. Only 4 lanes are connected:
> > 
> > 	lane 0 - connected to Kirin 970;
> > 	lane 4 - M.2 slot;
> > 	lane 5 - mini PCIe slot;
> > 	lane 6 - in-board Ethernet controller.
> > 
> > Each lane has its own PERST# gpio pin, and needs a clock
> > request.
> > 
> > Add support to parse a DT schema containing the above data.
> > 
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> > 
> > See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/
> > 
> >  drivers/pci/controller/dwc/pcie-kirin.c | 262 +++++++++++++++++++++---
> >  1 file changed, 231 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > index 86c13661e02d..de375795a3b8 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -52,6 +52,19 @@
> >  #define PCIE_DEBOUNCE_PARAM	0xF0F400
> >  #define PCIE_OE_BYPASS		(0x3 << 28)
> >  
> > +/*
> > + * Max number of connected PCI slots at an external PCI bridge
> > + *
> > + * This is used on HiKey 970, which has a PEX 8606 bridge with has
> > + * 4 connected lanes (lane 0 upstream, and the other tree lanes,
> > + * one connected to an in-board Ethernet adapter and the other two
> > + * connected to M.2 and mini PCI slots.
> > + *
> > + * Each slot has a different clock source and uses a separate PERST#
> > + * pin.
> > ...
> 
> > +static int kirin_pcie_add_bus(struct pci_bus *bus)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
> > +	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
> > +	int i, ret;
> > +
> > +	if (!kirin_pcie->num_slots)
> > +		return 0;
> > +
> > +	/* Send PERST# to each slot */
> > +	for (i = 0; i < kirin_pcie->num_slots; i++) {
> > +		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
> > +		if (ret) {
> > +			dev_err(pci->dev, "PERST# %s error: %d\n",
> > +				kirin_pcie->reset_names[i], ret);
> > +		}
> > +	}
> > +	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
> > +
> > +	return 0;
> > +}
> > +
> > +
> >  static struct pci_ops kirin_pci_ops = {
> >  	.read = kirin_pcie_rd_own_conf,
> >  	.write = kirin_pcie_wr_own_conf,
> > +	.add_bus = kirin_pcie_add_bus,
> 
> This seems a little weird.  Can you educate me?
> 
> From [1], it looks like the topology here is:
> 
>   00:00.0 Root Port
>   01:00.0 PEX 8606 Upstream Port
>   02:01.0 PEX 8606 Downstream Port
>   02:04.0 PEX 8606 Downstream Port
>   02:05.0 PEX 8606 Downstream Port
>   02:07.0 PEX 8606 Downstream Port
>   02:09.0 PEX 8606 Downstream Port
>   06:00.0 RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller 
> 
> The .add_bus() callback will be called for *every* child bus we want
> to enumerate.  So if any of those PEX 8606 Downstream Ports are
> connected to another switch, when we enumerate the secondary buses of
> that other switch, it looks like we'll send PERST# to all the slots
> again, which doesn't sound right.  Am I missing something?
> 
> Bjorn
> 
> [1] https://lore.kernel.org/all/20210129173057.30288c9d@coco.lan/
