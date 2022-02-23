Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399564C1D98
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 22:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbiBWVVK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 16:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiBWVUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 16:20:18 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A87E4EA37;
        Wed, 23 Feb 2022 13:19:49 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7946892009C; Wed, 23 Feb 2022 22:19:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7324B92009B;
        Wed, 23 Feb 2022 21:19:47 +0000 (GMT)
Date:   Wed, 23 Feb 2022 21:19:47 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Ben Dooks <ben.dooks@codethink.co.uk>, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCHv4 2/2] PCI: fu740: Force gen1 for initial device probe
In-Reply-To: <20220223205141.GA149346@bhelgaas>
Message-ID: <alpine.DEB.2.21.2202232100220.27002@angie.orcam.me.uk>
References: <20220223205141.GA149346@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 23 Feb 2022, Bjorn Helgaas wrote:

> > +	dw_pcie_dbi_ro_wr_dis(dw);
> > +}
> > +
> >  static int fu740_pcie_start_link(struct dw_pcie *pci)
> >  {
> >  	struct device *dev = pci->dev;
> >  	struct fu740_pcie *afp = dev_get_drvdata(dev);
> >  
> > +	/* Force PCIe gen1 otherwise Unmatched board does not probe */
> > +	fu740_pcie_force_gen1(pci, afp);
> 
> I guess the "Unmatched" board is the only thing we need to care about
> here?  Are there or will there be other boards that don't need this?

 I wonder if this is the other side of a supposed erratum observed here:

<https://lore.kernel.org/all/alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk/>

Downstream there's the same ASMedia ASM2824 PCIe switch whose downstream 
ports don't want to train with a Pericom part above Gen1.

 Of course we don't know an ASM2824 is there until we have successfully 
negotiated the link, so we may have to generalise my proposal if we can 
find a way similar to what I have done for U-boot that does not disturb 
Linux's operation.  This is because there are PCIe option cards out there 
with the ASM2824 onboard, so it could be possible for the problem to 
trigger anywhere where the conditions for the erratum are met.

 Also in that case retraining should work with the cap removed to get a 
higher final speed just as with the Pericom part.

  Maciej
