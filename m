Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5640B7E036B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 14:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377661AbjKCNLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377652AbjKCNLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 09:11:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648EED4E;
        Fri,  3 Nov 2023 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699017059; x=1730553059;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=82gtgHy+UyeFF9D+kUBnovik770jSxM5CJchREAlcII=;
  b=gO/xW4duaEGzaAiuYnR00duK3p37iEHX4MWS7Z19VW7XZUQJina53aM9
   0YDXkLBBY2y9LcM8yJa9y9j5aG8GX/Wd2eTpMBVOZIjUTVV1l4pQuiaTP
   l0HzqjGl6bVOh8vh5LpNE488bDwKbXqjwdYEzmLdifaAHENNSpaIXKxoX
   /cLwb85YBgiJafR0I+yIMCdp1iUAnmVOu9RE8wTWLg9bTLd/aih2yNRwq
   WW8//ReKJK7vBrIhcFtvU/Y5XiZ1M1cR34Ae5zsz3xyFX+UpOXsdo12gz
   KnOtHSYSFTiMpZZ5QlWncY4pMbn9Vp8MpBuwMkDaIDBH5NIiU571d/xMe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="373979944"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="373979944"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 06:10:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="9719049"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.35.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 06:10:57 -0700
Date:   Fri, 3 Nov 2023 15:10:54 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Use FIELD_PREP() and remove *_SHIFT defines
In-Reply-To: <20231031200312.GA25127@bhelgaas>
Message-ID: <86b70bf-a62e-2723-894b-7b67f7caf594@linux.intel.com>
References: <20231031200312.GA25127@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-553048239-1699017058=:1725"
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

--8323329-553048239-1699017058=:1725
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 31 Oct 2023, Bjorn Helgaas wrote:
> On Fri, Oct 27, 2023 at 11:38:11AM +0300, Ilpo Järvinen wrote:
> > Instead of open-coded masking and shifting with PCI_CONF1_* bitfields,
> > use GENMASK() and FIELD_PREP(), and then remove the *_SHIFT defines
> > that are no longer needed.

> > @@ -797,19 +799,15 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
> >   * Section 3.2.2.3.2, Figure 3-2, p. 50.
> >   */
> >  
> > -#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
> > -#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
> > -#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
> > -
> > -#define PCI_CONF1_BUS_MASK	0xff
> > -#define PCI_CONF1_DEV_MASK	0x1f
> > -#define PCI_CONF1_FUNC_MASK	0x7
> > +#define PCI_CONF1_BUS_MASK	GENMASK(23, 16)
> > +#define PCI_CONF1_DEV_MASK	GENMASK(15, 11)
> > +#define PCI_CONF1_FUNC_MASK	GENMASK(10, 8)
> >  #define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */
> >  
> >  #define PCI_CONF1_ENABLE	BIT(31)
> > -#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
> > -#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
> > -#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
> > +#define PCI_CONF1_BUS(x)	FIELD_PREP(PCI_CONF1_BUS_MASK, (x))
> > +#define PCI_CONF1_DEV(x)	FIELD_PREP(PCI_CONF1_DEV_MASK, (x))
> > +#define PCI_CONF1_FUNC(x)	FIELD_PREP(PCI_CONF1_FUNC_MASK, (x))
> >  #define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)
> 
> I love getting rid of the _SHIFT #defines.
>
> I'm a dinosaur and haven't been completely converted to the wonders of
> GENMASK yet.

Okay but would it convince even "a dinosaur" like you :-) if you imagine
a Bit Location column in some spec which says:
	23:16

GENMASK just happens to mystically repeat those two numbers:
	GENMASK(23, 16)

Pretty magic, isn't it?

> PCI_CONF1_ADDRESS is the only user of PCI_CONF1_BUS etc,
> so I think this would be simpler overall:
> 
>   #define PCI_CONF1_BUS  0x00ff0000
>   #define PCI_CONF1_DEV  0x0000f800
>   #define PCI_CONF1_FUNC 0x00000700
>   #define PCI_CONF1_REG  0x000000ff
> 
>   #define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
>     (FIELD_PREP(PCI_CONF1_BUS, (bus)) | \
>      FIELD_PREP(PCI_CONF1_DEV, (dev)) | \
>      FIELD_PREP(PCI_CONF1_FUNC, (func)) | \
>      FIELD_PREP(PCI_CONF1_REG, (reg & ~0x3)))

Yes, it makes sense to remove the extra layer.

One additional thing, I just noticed lots of arch/ code is duplicating 
this calculation so perhaps this should also be moved outside of 
drivers/pci/ into include/linux/pci.h ? (Not in the same patch.)

> The v6.7 merge window just opened, and I won't start merging v6.8
> material until v6.7-rc1 (probably Nov 12), so no hurry on this.

Yes I knew I was sending it quite late because I tried to meet your 
request in getting it all done in the same merge window (which I 
obviously failed but it isn't the end of the world).

-- 
 i.

--8323329-553048239-1699017058=:1725--
