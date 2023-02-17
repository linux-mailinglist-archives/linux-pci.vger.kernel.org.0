Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9445769AA35
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 12:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBQLVF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 06:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBQLVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 06:21:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7346AC
        for <linux-pci@vger.kernel.org>; Fri, 17 Feb 2023 03:21:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D45861924
        for <linux-pci@vger.kernel.org>; Fri, 17 Feb 2023 11:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C542FC433D2;
        Fri, 17 Feb 2023 11:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676632863;
        bh=1owbu3bNV8v2E0CP7o4YeS/ESD+MP9CnLvQTDSGv4/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e+57rYVRpmR+csf9lTHMVmjzbF0rmm21E5T1drLXYannEmYFk6Kfp/ujcSvjuBdDK
         xwtSJzWom1aXKQ0beFvj4Z4y2ufTBjjSvVVGdvLav/cKNEdsZ2t1RlN/pi0FHxrr0v
         DkXnOHsRRexl4juPYM6Te/SCOf+Uisv0756LlpHIukDabng+uWx/5ph5ly06zubq8Q
         y7HVboXR+gejWSargN5vdatg7lInvZjdg02HU94WhpLOkSOUOrZbBkU3/sZcq22ISa
         1MwqF2ucT3cIfsfkIdPJHnrd74ru1H5CPBb6Euwtb+eijgEeG+OIMHP7D/LL+qfPRr
         JKSmqmJRVW/hQ==
Date:   Fri, 17 Feb 2023 05:21:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Message-ID: <20230217112101.GA3387033@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217080656.2rhkfzf7ivhrbvub@mobilestation>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 17, 2023 at 11:06:56AM +0300, Serge Semin wrote:
> On Fri, Feb 17, 2023 at 12:46:03AM +0000, Yoshihiro Shimoda wrote:
> > > From: Serge Semin, Sent: Friday, February 17, 2023 5:50 AM
> > > On Thu, Feb 16, 2023 at 11:58:22AM -0600, Bjorn Helgaas wrote:
> > > > On Thu, Feb 16, 2023 at 06:20:12PM +0900, Yoshihiro Shimoda wrote:
> > > > > The "val" of PCIE_PORT_LINK_CONTROL will be reused on the
> > > > > "Set the number of lanes". But, if snps,enable-cdm-check" exists,
> > > > > the "val" will be set to PCIE_PL_CHK_REG_CONTROL_STATUS.
> > > > > Therefore, unexpected register value is possible to be used
> > > > > to PCIE_PORT_LINK_CONTROL register if snps,enable-cdm-check" exists.
> > > > > So, read PCIE_PORT_LINK_CONTROL register again to fix the issue.
> > > > >
> > > > > Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
> > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-designware.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > index 6d5d619ab2e9..3bb9ca14fb9c 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -824,6 +824,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > > >  	}
> > > > >
> > > > >  	/* Set the number of lanes */
> > > > > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > > >
> > > > Definitely a bug, thanks for the fix and the Fixes: tag.
> > > >
> > > > But I would like the whole function better if it could be structured
> > > > so we read PCIE_PORT_LINK_CONTROL once and wrote it once.  And the
> > > > same for PCIE_LINK_WIDTH_SPEED_CONTROL.

> ...
> IMO I would leave the procedure as is for now seeing you are going to
> move the rcar_gen4_pcie_set_max_link_width() code to the generic part
> of the driver in the framework of this patch:
> https://lore.kernel.org/linux-pci/20230210134917.2909314-7-yoshihiro.shimoda.uh@renesas.com/
> per Rob and my requests.
> 
> Thus you'll be able to combine all the bus-width updates into a single
> method, like dw_pcie_link_set_max_link_width(). The function will look
> as coherent as possible meanwhile the dw_pcie_setup() method body will
> turn to be smaller and easier to comprehend. Alas that will imply
> updating the PCIE_PORT_LINK_CONTROL and PCIE_LINK_WIDTH_SPEED_CONTROL
> registers twice.
> 
> @Bjorn, are you ok with that?

I haven't looked at the rcar_gen4_pcie_set_max_link_width()
restructuring so don't have an opinion on that.

We read PCIE_PORT_LINK_CONTROL once, we lost the value by using "val"
for something else, and then we need it again.  My point was only that
re-reading PCIE_PORT_LINK_CONTROL seems like overkill compared to
adding another local variable to remember it.

If the updates are in different parts of the framework, maybe two
updates make sense.  I'm not suggesting we need to contort things to
achieve a single update at all costs.  It's just that two updates in
a single function looks like it should be avoidable.

Bjorn
