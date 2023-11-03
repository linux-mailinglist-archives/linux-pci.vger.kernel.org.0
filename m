Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3187E0461
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 15:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjKCOHu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKCOHt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 10:07:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA5D45;
        Fri,  3 Nov 2023 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699020444; x=1730556444;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=d1zLJhWuW6i245DJHNutztuBpdZkMiKcv1cL6dyMksQ=;
  b=THNM0tIYRSTS6vZQN9lAUe8/0JB91K4fsnbfZKOPKf1jqp+QoaY2JWWz
   UCNURDXLheV1seyeFWN30ix2WkJTrjysrUP5sW9dOxvxjpc7PtD0wBcQb
   8zJNsgIB3rIaR5xNwh4QZzUKPsjabUM9oDSXHMnNb4WfMvm0os2HRnDmX
   5WxF7bJduUx426OC31OUpLn92Rs2JtIZVLEVjYigpWd3sCIzEIZU0LPHk
   vIzvR0dK4QwVtALV/cgh+39QTLolmuIHcLeUz7J3uR9DEo9jfougCiF7U
   rNbkEzYqdYGLGA2DUOCLjIA0UkjKiFU90WFuoNN4vXc2pSsMdFvMnqEGG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="373987390"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="373987390"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 07:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="9734157"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 07:07:22 -0700
Date:   Fri, 3 Nov 2023 16:07:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Use FIELD_PREP() and remove *_SHIFT defines
In-Reply-To: <86b70bf-a62e-2723-894b-7b67f7caf594@linux.intel.com>
Message-ID: <7dcedbee-8d81-1cb5-a5a6-020df8ea2@linux.intel.com>
References: <20231031200312.GA25127@bhelgaas> <86b70bf-a62e-2723-894b-7b67f7caf594@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1898808338-1699020443=:1725"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1898808338-1699020443=:1725
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 3 Nov 2023, Ilpo Järvinen wrote:

> On Tue, 31 Oct 2023, Bjorn Helgaas wrote:
> > On Fri, Oct 27, 2023 at 11:38:11AM +0300, Ilpo Järvinen wrote:
> > > Instead of open-coded masking and shifting with PCI_CONF1_* bitfields,
> > > use GENMASK() and FIELD_PREP(), and then remove the *_SHIFT defines
> > > that are no longer needed.
> 
> > > @@ -797,19 +799,15 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
> > >   * Section 3.2.2.3.2, Figure 3-2, p. 50.
> > >   */
> > >  
> > > -#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
> > > -#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
> > > -#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
> > > -
> > > -#define PCI_CONF1_BUS_MASK	0xff
> > > -#define PCI_CONF1_DEV_MASK	0x1f
> > > -#define PCI_CONF1_FUNC_MASK	0x7
> > > +#define PCI_CONF1_BUS_MASK	GENMASK(23, 16)
> > > +#define PCI_CONF1_DEV_MASK	GENMASK(15, 11)
> > > +#define PCI_CONF1_FUNC_MASK	GENMASK(10, 8)
> > >  #define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */
> > >  
> > >  #define PCI_CONF1_ENABLE	BIT(31)
> > > -#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
> > > -#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
> > > -#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
> > > +#define PCI_CONF1_BUS(x)	FIELD_PREP(PCI_CONF1_BUS_MASK, (x))
> > > +#define PCI_CONF1_DEV(x)	FIELD_PREP(PCI_CONF1_DEV_MASK, (x))
> > > +#define PCI_CONF1_FUNC(x)	FIELD_PREP(PCI_CONF1_FUNC_MASK, (x))
> > >  #define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)
> > 
> > I love getting rid of the _SHIFT #defines.
> >
> > I'm a dinosaur and haven't been completely converted to the wonders of
> > GENMASK yet.
> 
> Okay but would it convince even "a dinosaur" like you :-) if you imagine
> a Bit Location column in some spec which says:
> 	23:16
> 
> GENMASK just happens to mystically repeat those two numbers:
> 	GENMASK(23, 16)
> 
> Pretty magic, isn't it?
> 
> > PCI_CONF1_ADDRESS is the only user of PCI_CONF1_BUS etc,
> > so I think this would be simpler overall:
> > 
> >   #define PCI_CONF1_BUS  0x00ff0000
> >   #define PCI_CONF1_DEV  0x0000f800
> >   #define PCI_CONF1_FUNC 0x00000700
> >   #define PCI_CONF1_REG  0x000000ff
> > 
> >   #define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
> >     (FIELD_PREP(PCI_CONF1_BUS, (bus)) | \
> >      FIELD_PREP(PCI_CONF1_DEV, (dev)) | \
> >      FIELD_PREP(PCI_CONF1_FUNC, (func)) | \
> >      FIELD_PREP(PCI_CONF1_REG, (reg & ~0x3)))

This ended up not working, because FIELD_PREP() detects ext regs not 
fitting into PCI_CONF1_REG:
	FIELD_PREP(PCI_CONF1_REG, (reg) & ~0x3)

There are two partially overlapping things here when it comes to reg 
(addressing side and parameter input side):

#define PCI_CONF1_REG_ADDR	0x000000ff
// for PCI_CONF1_EXT_ADDRESS:
#define PCI_CONF1_EXT_REG_ADDR	0x0f000000

/* PCI Config register (parameter input side) */
#define PCI_CONF1_REG		0x0fc
#define PCI_CONF1_EXT_REG	0xf00

Would those 4 defines be acceptable? Or should I mark the input side with
_IN or use different prefix for the defines?

> Yes, it makes sense to remove the extra layer.
> 
> One additional thing, I just noticed lots of arch/ code is duplicating 
> this calculation so perhaps this should also be moved outside of 
> drivers/pci/ into include/linux/pci.h ? (Not in the same patch.)

I also noticed you took PCI_CONF1_ENABLE away from PCI_CONF1_ADDRESS(),
did you intend for it to be moved at the caller site?

Moving it outside of PCI_CONF1_ADDRESS() would certainly help reusing this 
code as notall arch code wants PCI_CONF1_ENABLE I think.

> > The v6.7 merge window just opened, and I won't start merging v6.8
> > material until v6.7-rc1 (probably Nov 12), so no hurry on this.
> 
> Yes I knew I was sending it quite late because I tried to meet your 
> request in getting it all done in the same merge window (which I 
> obviously failed but it isn't the end of the world).
> 
> 

-- 
 i.

--8323329-1898808338-1699020443=:1725--
