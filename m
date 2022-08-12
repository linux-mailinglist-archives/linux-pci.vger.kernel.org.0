Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052C85911C7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiHLN6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 09:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiHLN6s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 09:58:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3C6A50E1;
        Fri, 12 Aug 2022 06:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57482B8243A;
        Fri, 12 Aug 2022 13:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5901C433C1;
        Fri, 12 Aug 2022 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660312725;
        bh=xh5J5TASioRfOeCFMDXvtupuSBvJ7WbXoTGn877mnnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCCsa0p2UBi6sZpooriV0YmzPMP5tTpKco8A5NLhoBTJwVW5Ys06UitalfBCRzCa7
         Wf+lUQ04QeKe4hzMr7T/Hx2nIpY4opUsL/hnt4d3jQMlGiAw9yEMvKtjtMAOYSG9Xc
         DIuNRGfFEbQaoIYuegJK4pTG0HAiH26rdtJFYP0rdZMApBM25cRbzyqeiYtOqycgZx
         BH/NLpIncOQj206IkvdXakmL4df/QYb+HfEoKx/V7E9YWPLVlwhdUqN5QVETI6BTSS
         xXIMED9PznDBup60i/dfBLyl1JQlywVzb7xAt3Q5XxTst6IIfWnV9D18L25iCkDg3q
         qAcy/NtPGzVjA==
Received: by pali.im (Postfix)
        id B34BC9CF; Fri, 12 Aug 2022 15:58:41 +0200 (CEST)
Date:   Fri, 12 Aug 2022 15:58:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Fix endianity when accessing pci emul bridge
 members
Message-ID: <20220812135841.uhmdkpvjok574ijf@pali>
References: <20220812094058.16141-1-pali@kernel.org>
 <3096bb82-62e6-bc9f-1600-fb58d6826302@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3096bb82-62e6-bc9f-1600-fb58d6826302@arm.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 12 August 2022 11:32:59 Robin Murphy wrote:
> On 2022-08-12 10:40, Pali Rohár wrote:
> > PCI emul bridge members iolimitupper, iobaseupper, memlimit and membase are
> > of type __le16, so correctly access these members via le16_to_cpu() macros.
> > 
> > Fixes: 4ded69473adb ("PCI: mvebu: Propagate errors when updating PCI_IO_BASE and PCI_MEM_BASE registers")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >   drivers/pci/controller/pci-mvebu.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index c1ffdb06c971..00ea0836b81a 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -523,7 +523,7 @@ static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
> >   	/* Are the new iobase/iolimit values invalid? */
> >   	if (conf->iolimit < conf->iobase ||
> > -	    conf->iolimitupper < conf->iobaseupper)
> > +	    le16_to_cpu(conf->iolimitupper) < le16_to_cpu(conf->iobaseupper))
> >   		return mvebu_pcie_set_window(port, port->io_target, port->io_attr,
> >   					     &desired, &port->iowin);
> > @@ -535,10 +535,10 @@ static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
> >   	 * is the CPU address.
> >   	 */
> >   	desired.remap = ((conf->iobase & 0xF0) << 8) |
> > -			(conf->iobaseupper << 16);
> > +			le16_to_cpu(conf->iobaseupper << 16);
> 
> This will always give 0, even when natively LE.

You are right, I overlooked it and I put closing parenthesis at wrong
place. Bit shifting should be applied after le to cpu conversion. I will
fix it in V2.

> >   	desired.base = port->pcie->io.start + desired.remap;
> >   	desired.size = ((0xFFF | ((conf->iolimit & 0xF0) << 8) |
> > -			 (conf->iolimitupper << 16)) -
> > +			 le16_to_cpu(conf->iolimitupper << 16)) -
> 
> Similarly here.
> 
> Robin.
> 
> >   			desired.remap) +
> >   		       1;
> > @@ -552,7 +552,7 @@ static int mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
> >   	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
> >   	/* Are the new membase/memlimit values invalid? */
> > -	if (conf->memlimit < conf->membase)
> > +	if (le16_to_cpu(conf->memlimit) < le16_to_cpu(conf->membase))
> >   		return mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
> >   					     &desired, &port->memwin);
> > @@ -562,8 +562,8 @@ static int mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
> >   	 * window to setup, according to the PCI-to-PCI bridge
> >   	 * specifications.
> >   	 */
> > -	desired.base = ((conf->membase & 0xFFF0) << 16);
> > -	desired.size = (((conf->memlimit & 0xFFF0) << 16) | 0xFFFFF) -
> > +	desired.base = ((le16_to_cpu(conf->membase) & 0xFFF0) << 16);
> > +	desired.size = (((le16_to_cpu(conf->memlimit) & 0xFFF0) << 16) | 0xFFFFF) -
> >   		       desired.base + 1;
> >   	return mvebu_pcie_set_window(port, port->mem_target, port->mem_attr, &desired,
