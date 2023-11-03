Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300117E05C2
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbjKCPvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCPva (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 11:51:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886901BF;
        Fri,  3 Nov 2023 08:51:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E77C433C7;
        Fri,  3 Nov 2023 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699026687;
        bh=IutdH8zanBFtnsKY2r07pCOYRS1qw6WY7R1gK1g7a3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IeOGr+JIPmLiaqdsuoEAC2A3yTBwWlAQu81syWGQJgrKR3+daJ4NzIgaFJWetDsjC
         HBxaazVVECApMigMVXfZjFI4c/NxmYuGjMy/oB6HwJq7q1oP1Uki9lKJWwvNQQEpwv
         TaA9YYLwD6yCIK7lYU651utt12Jc9CszHNPF+cqh5KNdne0MYLhk2dfA7rJAal4ZI7
         aq4k8h00/wayv2T16EHJQLfiNXn5XKJMMmX3b46rDcHUQNXQSXs3cWqgOq8UwzYzeo
         2uB8/WEejtHQULZoqF2OYU6kA6Zb2ZaEIzUMkdueDCnKWkbGSd8JhQqtoTqpNsH1bI
         QHczVoicdoTLQ==
Date:   Fri, 3 Nov 2023 10:51:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Use FIELD_PREP() and remove *_SHIFT defines
Message-ID: <20231103155125.GA155966@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dcedbee-8d81-1cb5-a5a6-020df8ea2@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 03, 2023 at 04:07:19PM +0200, Ilpo Järvinen wrote:
> On Fri, 3 Nov 2023, Ilpo Järvinen wrote:
> 
> > On Tue, 31 Oct 2023, Bjorn Helgaas wrote:
> > > On Fri, Oct 27, 2023 at 11:38:11AM +0300, Ilpo Järvinen wrote:
> > > > Instead of open-coded masking and shifting with PCI_CONF1_* bitfields,
> > > > use GENMASK() and FIELD_PREP(), and then remove the *_SHIFT defines
> > > > that are no longer needed.
> > 
> > > > @@ -797,19 +799,15 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
> > > >   * Section 3.2.2.3.2, Figure 3-2, p. 50.
> > > >   */
> > > >  
> > > > -#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
> > > > -#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
> > > > -#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
> > > > -
> > > > -#define PCI_CONF1_BUS_MASK	0xff
> > > > -#define PCI_CONF1_DEV_MASK	0x1f
> > > > -#define PCI_CONF1_FUNC_MASK	0x7
> > > > +#define PCI_CONF1_BUS_MASK	GENMASK(23, 16)
> > > > +#define PCI_CONF1_DEV_MASK	GENMASK(15, 11)
> > > > +#define PCI_CONF1_FUNC_MASK	GENMASK(10, 8)
> > > >  #define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */
> > > >  
> > > >  #define PCI_CONF1_ENABLE	BIT(31)
> > > > -#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
> > > > -#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
> > > > -#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
> > > > +#define PCI_CONF1_BUS(x)	FIELD_PREP(PCI_CONF1_BUS_MASK, (x))
> > > > +#define PCI_CONF1_DEV(x)	FIELD_PREP(PCI_CONF1_DEV_MASK, (x))
> > > > +#define PCI_CONF1_FUNC(x)	FIELD_PREP(PCI_CONF1_FUNC_MASK, (x))
> > > >  #define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)
> > > 
> > > I love getting rid of the _SHIFT #defines.
> > >
> > > I'm a dinosaur and haven't been completely converted to the wonders of
> > > GENMASK yet.
> > 
> > Okay but would it convince even "a dinosaur" like you :-) if you imagine
> > a Bit Location column in some spec which says:
> > 	23:16
> > 
> > GENMASK just happens to mystically repeat those two numbers:
> > 	GENMASK(23, 16)
> > 
> > Pretty magic, isn't it?
> > 
> > > PCI_CONF1_ADDRESS is the only user of PCI_CONF1_BUS etc,
> > > so I think this would be simpler overall:
> > > 
> > >   #define PCI_CONF1_BUS  0x00ff0000
> > >   #define PCI_CONF1_DEV  0x0000f800
> > >   #define PCI_CONF1_FUNC 0x00000700
> > >   #define PCI_CONF1_REG  0x000000ff
> > > 
> > >   #define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
> > >     (FIELD_PREP(PCI_CONF1_BUS, (bus)) | \
> > >      FIELD_PREP(PCI_CONF1_DEV, (dev)) | \
> > >      FIELD_PREP(PCI_CONF1_FUNC, (func)) | \
> > >      FIELD_PREP(PCI_CONF1_REG, (reg & ~0x3)))
> 
> This ended up not working, because FIELD_PREP() detects ext regs not 
> fitting into PCI_CONF1_REG:
> 	FIELD_PREP(PCI_CONF1_REG, (reg) & ~0x3)
> 
> There are two partially overlapping things here when it comes to reg 
> (addressing side and parameter input side):
> 
> #define PCI_CONF1_REG_ADDR	0x000000ff
> // for PCI_CONF1_EXT_ADDRESS:
> #define PCI_CONF1_EXT_REG_ADDR	0x0f000000
> 
> /* PCI Config register (parameter input side) */
> #define PCI_CONF1_REG		0x0fc
> #define PCI_CONF1_EXT_REG	0xf00
> 
> Would those 4 defines be acceptable? Or should I mark the input side with
> _IN or use different prefix for the defines?

No opinion here yet.  Maybe PCI_CONF1_EXT_ADDRESS() needs to
explicitly pull out the low 8 bits before giving them to
PCI_CONF1_ADDRESS()?

> > Yes, it makes sense to remove the extra layer.
> > 
> > One additional thing, I just noticed lots of arch/ code is duplicating 
> > this calculation so perhaps this should also be moved outside of 
> > drivers/pci/ into include/linux/pci.h ? (Not in the same patch.)
> 
> I also noticed you took PCI_CONF1_ENABLE away from PCI_CONF1_ADDRESS(),
> did you intend for it to be moved at the caller site?
> 
> Moving it outside of PCI_CONF1_ADDRESS() would certainly help reusing this 
> code as notall arch code wants PCI_CONF1_ENABLE I think.

Honestly, I didn't think about PCI_CONF1_ENABLE; I just wanted to show
the idea of using FIELD_PREP() directly in PCI_CONF1_ADDRESS().

I *did* later think that the "& ~0x3" part maybe doesn't belong in
PCI_CONF1_ADDRESS(), since that's really connected with the use of
readl()/writel() in the caller.  Hmmm, I guess only
faraday_raw_pci_read_config() and ixp4xx_config_addr() actually use
this.  Maybe those places should mask out the low bits themselves?

Maybe the same with PCI_CONF1_ENABLE, since ixp4xx_config_addr()
removes that bit anyway?  Not sure.

Bjorn
