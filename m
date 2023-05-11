Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B626FFA18
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbjEKTXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 15:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjEKTXa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 15:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CABAD3A;
        Thu, 11 May 2023 12:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF24B650FC;
        Thu, 11 May 2023 19:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A35C433D2;
        Thu, 11 May 2023 19:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683832974;
        bh=QpSSk/1ebWRADeVKkTa0UQcYPlC3k/G654CAP3C9inA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hjjNUy+EMZYUa9Mq/8GFHcLgiNT1wA7pnV4d5hK0g5b5gfK/AxH0JtcG3mfc26cM0
         0TLz0V91O3tCA7Tg68LvnFnyG93r0BojVB4UoPw36+TfN+suZe17QTwllS99InSZd+
         PZmdpfOahm8FX8WgCf9PSAz9+Wg7GLPJSVG0683QUq4698jNt1vleo6u0oI3KvOyjw
         GEarGhSluLFERM0wXSI3EWxkl2wpJE31/ryrcMRzzKONgNDgxz5oo+0rFmfZk7iXCO
         6pUez+FBLUFPTE/ANUW2la4479WLQC31Dz1MWo+kOs2oJ4wCoAsrFsKXBeS07tHNvt
         2WaY/zmB8dPmg==
Date:   Thu, 11 May 2023 14:22:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
Message-ID: <ZF1AjOKDVlbNFJPK@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5140259d-4425-3166-438a-bc9fbbaa49f9@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 08:35:48PM +0300, Ilpo Järvinen wrote:
> On Thu, 11 May 2023, Bjorn Helgaas wrote:
> 
> > On Thu, May 11, 2023 at 04:14:25PM +0300, Ilpo Järvinen wrote:
> > > A few places write LNKCTL and LNKCTL2 registers without proper
> > > concurrency control and this could result in losing the changes
> > > one of the writers intended to make.
> > > 
> > > Add pcie_capability_clear_and_set_word_locked() and helpers to use it
> > > with LNKCTL and LNKCTL2. The concurrency control is provided using a
> > > spinlock in the struct pci_dev.
> > > 
> > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > Thanks for raising this issue!  Definitely looks like something that
> > needs attention.
> > 
> > > ---
> > >  drivers/pci/access.c | 14 ++++++++++++++
> > >  drivers/pci/probe.c  |  1 +
> > >  include/linux/pci.h  | 17 +++++++++++++++++
> > >  3 files changed, 32 insertions(+)
> > > 
> > > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > > index 3c230ca3de58..d92a3daadd0c 100644
> > > --- a/drivers/pci/access.c
> > > +++ b/drivers/pci/access.c
> > > @@ -531,6 +531,20 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
> > >  }
> > >  EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
> > >  
> > > +int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
> > > +					      u16 clear, u16 set)
> > > +{
> > > +	unsigned long flags;
> > > +	int ret;
> > > +
> > > +	spin_lock_irqsave(&dev->cap_lock, flags);
> > > +	ret = pcie_capability_clear_and_set_word(dev, pos, clear, set);
> > > +	spin_unlock_irqrestore(&dev->cap_lock, flags);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL(pcie_capability_clear_and_set_word_locked);
> > 
> > I didn't see the prior discussion with Lukas, so maybe this was
> > answered there, but is there any reason not to add locking to
> > pcie_capability_clear_and_set_word() and friends directly?  
> >
> > It would be nice to avoid having to decide whether to use the locked
> > or unlocked versions.  It would also be nice to preserve the use of
> > PCI_EXP_LNKCTL directly, for grep purposes.  And it would obviate the
> > need for some of these patches, e.g., the use of
> > pcie_capability_clear_word(), where it's not obvious at the call site
> > why a change is needed.
> 
> There wasn't that big discussion about it (internally). I brought both
> alternatives up and Lukas just said he didn't know what's the best 
> approach (+ gave a weak nudge towards the separate accessor so I went 
> with it to make forward progress). Based on that I don't think he had a 
> strong opinion on it.
> 
> I'm certainly fine to just use it in the normal accessor functions that 
> do RMW and add the locking there. It would certainly have to those good 
> sides you mentioned.

Let's start with that, then.

Many of these are ASPM-related updates that IMHO should not be in
drivers at all.  Drivers should use PCI core interfaces so the core
doesn't get confused.

Bjorn


