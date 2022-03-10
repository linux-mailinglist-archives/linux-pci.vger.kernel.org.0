Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E094F4D3DF4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 01:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiCJAQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 19:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238437AbiCJAQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 19:16:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810C122F44;
        Wed,  9 Mar 2022 16:15:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D84CA60BAA;
        Thu, 10 Mar 2022 00:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BCEC340E8;
        Thu, 10 Mar 2022 00:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646871341;
        bh=eCcD3HnBX/oFbLfrBWyYiQjjKNmgnOH2XtVmeNjv88Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gbIsWkSE0eX4PUjx2rjWlKRvWZgm8yOf5j3mY8DCbHtacbW8NkHpY4MP05/vMqXyh
         ipy5jPRvf5Y8BJn/O+SHygq7IhHbXxAt1/ZN56iIYi1SZzS/fmhsqoXpuHbqXhsFIF
         n1S5gRyAD0SbzuakLRArZCEiP/FRLJdgwWahcH5rck3RtmnoP33JzkcpUk1l5V5Y/F
         +RMy+twBqZNlPDPx6lj/NuvtXza2Ifb6L00gPv+JAsnPcIvQRsc0rlKAi1R6o7jEqC
         RI0hhZkRUXAy2QsTG3MSBQkRzqr9GkhfKWnwtNJlgrpiV4tkXD/pAqgcDk+inoneTs
         iz3+e7Ehy/MHw==
Date:   Wed, 9 Mar 2022 18:15:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI: fu740: Force Gen1 to fix initial device probing on
 some boards
Message-ID: <20220310001539.GA94315@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10794ea9-95ff-2cde-5851-b757a73b00ee@codethink.co.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 08, 2022 at 09:45:36AM +0000, Ben Dooks wrote:
> On 28/02/2022 23:22, Ben Dooks wrote:
> > The fu740 PCIe core does not probe any devices on the SiFive Unmatched
> > board without this fix (or having U-Boot explicitly start the PCIe via
> > either boot-script or user command). The fix is to start the link at
> > Gen1 speeds and once the link is up then change the speed back.
> > 
> > The U-Boot driver claims to set the link-speed to Gen1 to get the probe
> > to work (and U-Boot does print link up at Gen1) in the following code:
> > https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > --
> > Note, this patch has had significant re-work since the previous 4
> > sets, including trying to fix style, message, reliance on the U-Boot
> > fix and the comments about usage of LINK_CAP and reserved fields.
> 
> The internal feedback is this version is passing on our CI.
> 
> If there are no comments on this soon, I will post this as either the
> v5 of the original or as a new patch.

Seems like this isn't quite baked yet.  Lorenzo has the v4 of this on
his pci/fu740 branch, but I'm going to drop that for now because (a)
this one is better and (b) it'd be nice to have an ack from a FU740
maintainer (Paul or Greentime).

I'm also not clear on whether this works around a general FU740 defect
or something specific to the Unmatched board or the ASMedia ASM2824
switch.  This patch currently limits to 2.5GT/s on *all* FU740
devices.

I'd prefer to use "2.5GT/s" instead of "Gen1" in the subject, commit
log, and comments because it's more specific and matches the
PCI_EXP_LNKCAP_SLS_2_5GB in the code.

> > ---
> >   drivers/pci/controller/dwc/pcie-fu740.c | 51 ++++++++++++++++++++++++-
> >   1 file changed, 50 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> > index 842b7202b96e..16ad52f53490 100644
> > --- a/drivers/pci/controller/dwc/pcie-fu740.c
> > +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> > @@ -181,10 +181,59 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
> >   {
> >   	struct device *dev = pci->dev;
> >   	struct fu740_pcie *afp = dev_get_drvdata(dev);
> > +	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	int ret;
> > +	u32 orig, tmp;
> > +
> > +	/*
> > +	 * Force Gen1 when starting link, due to some devices not
> > +	 * probing at higher speeds. This happens with the PCIe switch
> > +	 * on the Unmatched board. The fix in U-Boot is to force Gen1
> > +	 * and hope later resets will clear this capaility.

s/capaility/capability/

But the sentence still doesn't quite make sense.  Are you saying that
if we bring the link up at 2.5GT/s, it will stay there?

And that a future reset may clear Link Capabilities?  Actually, I
guess you don't want it *cleared*, you would just want it to
accurately reflect the real max link speed, which would not be 0000b
in the register (since that's not even a defined encoding).

And the reset would also cause link retrain that would then use the
real max link speed?

> > +	dev_dbg(dev, "cap_exp at %x\n", cap_exp);
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +
> > +	tmp = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCAP);
> > +	orig = tmp & PCI_EXP_LNKCAP_SLS;
> > +	tmp &= ~PCI_EXP_LNKCAP_SLS;
> > +	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> > +	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
> >   	/* Enable LTSSM */
> >   	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
> > -	return 0;
> > +
> > +	ret = dw_pcie_wait_for_link(pci);
> > +	if (ret) {
> > +		dev_err(dev, "error: link did not start\n");
> > +		goto err;
> > +	}
> > +
> > +	tmp = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCAP);
> > +	if ((tmp & PCI_EXP_LNKCAP_SLS) != orig) {
> > +		dev_dbg(dev, "changing speed back to original\n");
> > +
> > +		tmp &= ~PCI_EXP_LNKCAP_SLS;
> > +		tmp |= orig;
> > +		dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
> > +
> > +		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +		tmp |= PORT_LOGIC_SPEED_CHANGE;
> > +		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> > +
> > +		ret = dw_pcie_wait_for_link(pci);
> > +		if (ret) {
> > +			dev_err(dev, "error: link did not start at new speed\n");
> > +			goto err;
> > +		}
> > +	}
> > +
> > +	ret = 0;
> > +err:
> > +	// todo - if we do have an unliekly error, what do we do here?

Wrong comment style (use /* */, not //), and s/unliekly/unlikely/

> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +	return ret;
> >   }
