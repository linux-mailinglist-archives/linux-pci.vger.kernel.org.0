Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38D06FCDB7
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjEISYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEISYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 14:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA94A1B5;
        Tue,  9 May 2023 11:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29CA0615B3;
        Tue,  9 May 2023 18:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E256C433EF;
        Tue,  9 May 2023 18:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683656658;
        bh=JxRLdpeyathG6LDtAP61I3JBOatVT/wKrI3SwwTHfJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S6DSqFnRRQd+uzd2S8vyMRJPsT5ehnxOFoFqHn01vGeS7zf3eWRaBmHZUrm0KhXqW
         k7SWasXPaFZZwVGfzoFqjdw7MzW7Y/LJzmmsYPBrLP46NIyw/cFBIm5ImBLHG3/Dku
         z3CObWE52WKtpd8fgRkLeu8x9qHopwVeXEE1QSonqU29Nj/qKldfqJvWv8AyESL/Yg
         D4sFMws1a4gdsj3PgdYlTT7F21SdFRCTO9sWulqEbEOj6Ek9yVomkFHeOJsyuUJ7G9
         uiNICB3+wbWEwFzh6SzSfdhZO/i5NNma+yIbMDa8yvpjK+TNWvWAYK222M3F8VI/a/
         5Iptz6PscZ3Jg==
Date:   Tue, 9 May 2023 13:24:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     tjoseph@cadence.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, nadeem@cadence.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <20230509182416.GA1259841@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd91ab0-cc7f-45c4-bded-688bab5d6050@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 09, 2023 at 12:37:31PM +0530, Siddharth Vadapalli wrote:
> Bjorn,
> 
> Thank you for reviewing the patch.
> 
> On 09/05/23 02:44, Bjorn Helgaas wrote:
> > On Wed, Mar 15, 2023 at 12:38:00PM +0530, Siddharth Vadapalli wrote:
> >> The Link Retraining process is initiated to account for the Gen2 defect in
> >> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> >> is i2085, documented at:
> >> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> >>
> >> The existing workaround implemented for the errata waits for the Data Link
> >> initialization to complete and assumes that the link retraining process
> >> at the Physical Layer has completed. However, it is possible that the
> >> Physical Layer training might be ongoing as indicated by the
> >> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> >>
> >> Fix the existing workaround, to ensure that the Physical Layer training
> >> has also completed, in addition to the Data Link initialization.
> >>
> >> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> >> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> >> ---
> >> Changes from v1:
> >> 1. Collect Reviewed-by tag from Vignesh Raghavendra.
> >> 2. Rebase on next-20230315.
> >>
> >> v1:
> >> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com
> >>
> >>  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> index 940c7dd701d6..5b14f7ee3c79 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> @@ -12,6 +12,8 @@
> >>  
> >>  #include "pcie-cadence.h"
> >>  
> >> +#define LINK_RETRAIN_TIMEOUT HZ
> >> +
> >>  static u64 bar_max_size[] = {
> >>  	[RP_BAR0] = _ULL(128 * SZ_2G),
> >>  	[RP_BAR1] = SZ_2G,
> >> @@ -77,6 +79,27 @@ static struct pci_ops cdns_pcie_host_ops = {
> >>  	.write		= pci_generic_config_write,
> >>  };
> >>  
> >> +static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
> > 
> > This is kind of weird because it's named like a predicate, i.e., "this
> > function tells me whether link training is complete", but it returns
> > *zero* for success.
> > 
> > This is the opposite of j721e_pcie_link_up(), which returns "true"
> > when the link is up, so code like this reads naturally:
> > 
> >   if (pcie->ops->link_up(pcie))
> >     /* do something if the link is up */
> 
> I agree. The function name can be changed to indicate that it is
> waiting for completion rather than indicating completion. If this is
> the only change, I will post a patch to fix it. On the other hand,
> based on your comments in the next section, I am thinking of an
> alternative approach of merging the current
> "cdns_pcie_host_training_complete()" function's operation as well
> into the "cdns_pcie_host_wait_for_link()" function. If this is
> acceptable, I will post a different patch and the name change patch
> won't be necessary.

Yeah, sorry, I meant to delete this part of my response after I wrote
the one below.

> >> @@ -118,6 +141,10 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
> >>  		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
> >>  				    lnk_ctl);
> >>  
> >> +		ret = cdns_pcie_host_training_complete(pcie);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >>  		ret = cdns_pcie_host_wait_for_link(pcie);
> > 
> > It seems a little clumsy that we wait for two things in succession:
> > 
> >   - cdns_pcie_host_training_complete() waits up to 1s for
> >     PCI_EXP_LNKSTA_LT to be cleared
> > 
> >   - cdns_pcie_host_wait_for_link() waits between .9s and 1s for
> >     LINK_UP_DL_COMPLETED on j721e (and not at all for other platforms)
> 
> Is it acceptable to merge "cdns_pcie_host_training_complete()" into
> "cdns_pcie_host_wait_for_link()"?

That's what I'm proposing.  Maybe someone who is more familiar with
Cadence would have an argument against it, but I think making it
structurally the same as dw_pcie_wait_for_link() would be a good
thing.

Bjorn
