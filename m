Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3160F4CE006
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 23:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiCDWCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 17:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiCDWCS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 17:02:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BBA27C7A3;
        Fri,  4 Mar 2022 14:01:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA1961E6A;
        Fri,  4 Mar 2022 22:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5CFC340E9;
        Fri,  4 Mar 2022 22:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646431289;
        bh=NPSR2P2E9oglZhlRfhiq9YTm0uMP5sV5KksP4bLLrfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HIxZcn7WPBbkoeTEu+C1p6Ky46Ni1FwuHZBIXFab56JpNahvB1RMS5lcMipCcWK66
         VPux6dE0ZQJpzxWNytW1wNestxWXPgBTkuonq5AtTdM52Tt04xMulaxlW9BiDbw25a
         EE1bNV6InHH+NqAoCmWJ7hcbjCs7IQpWvrRX2IrXf3+JmrSfR8BlX1KW/R2w/PONbN
         GFYRwreK2G7oNrMhfRkXtlFEgGAYC5QWxO99TJKAbiWQEXUNV4S6t1rcpmfmZqAuJ9
         2ZpTpSFPPnwhgP1sHp4m7hKB5/rZelRP20kdkxmn+8cXZFDigC+MslYt31qRmvqcfl
         MROt6CD2RNrmQ==
Date:   Fri, 4 Mar 2022 16:01:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] PCI: Reduce warnings on possible RW1C corruption
Message-ID: <20220304220127.GA1058143@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679ac5f4-d6b7-5c94-39d5-441c68576911@alliedtelesis.co.nz>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 04, 2022 at 01:30:29AM +0000, Chris Packham wrote:
> Hi All,
> 
> On 21/08/20 10:11, Bjorn Helgaas wrote:
> > On Thu, Aug 06, 2020 at 04:14:55PM +1200, Mark Tomlinson wrote:
> >> For hardware that only supports 32-bit writes to PCI there is the
> >> possibility of clearing RW1C (write-one-to-clear) bits. A rate-limited
> >> messages was introduced by fb2659230120, but rate-limiting is not the
> >> best choice here. Some devices may not show the warnings they should if
> >> another device has just produced a bunch of warnings. Also, the number
> >> of messages can be a nuisance on devices which are otherwise working
> >> fine.
> >>
> >> This patch changes the ratelimit to a single warning per bus. This
> >> ensures no bus is 'starved' of emitting a warning and also that there
> >> isn't a continuous stream of warnings. It would be preferable to have a
> >> warning per device, but the pci_dev structure is not available here, and
> >> a lookup from devfn would be far too slow.
> >>
> >> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> >> Fixes: fb2659230120 ("PCI: Warn on possible RW1C corruption for sub-32 bit config writes")
> >> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> > Applied with collected reviews/acks to pci/enumeration for v5.10,
> > thanks!
> 
> Whatever happened to this change?
> 
> I'm just going through our queue of patches that have been sent upstream 
> and expected this one to be gone after we pulled v5.10. Looking at 
> Linus's tree I don't see it ever having been applied. I couldn't see 
> anything on the relevant mailing lists suggesting that there was a 
> problem with this change so I'm just wondering what's happened to it?

Sorry, I blew it somehow and dropped it.  I applied it again for
v5.18.  Thanks for noticing!

> >> ---
> >> changes in v4:
> >>   - Use bitfield rather than bool to save memory (was meant to be in v3).
> >>
> >>   drivers/pci/access.c | 9 ++++++---
> >>   include/linux/pci.h  | 1 +
> >>   2 files changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> >> index 79c4a2ef269a..b452467fd133 100644
> >> --- a/drivers/pci/access.c
> >> +++ b/drivers/pci/access.c
> >> @@ -160,9 +160,12 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
> >>   	 * write happen to have any RW1C (write-one-to-clear) bits set, we
> >>   	 * just inadvertently cleared something we shouldn't have.
> >>   	 */
> >> -	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> >> -			     size, pci_domain_nr(bus), bus->number,
> >> -			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> >> +	if (!bus->unsafe_warn) {
> >> +		dev_warn(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> >> +			 size, pci_domain_nr(bus), bus->number,
> >> +			 PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> >> +		bus->unsafe_warn = 1;
> >> +	}
> >>   
> >>   	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
> >>   	tmp = readl(addr) & mask;
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 34c1c4f45288..85211a787f8b 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -626,6 +626,7 @@ struct pci_bus {
> >>   	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
> >>   	struct bin_attribute	*legacy_mem;	/* Legacy mem */
> >>   	unsigned int		is_added:1;
> >> +	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
> >>   };
> >>   
> >>   #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
> >> -- 
> >> 2.28.0
> >>
