Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0816FFAED
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 21:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbjEKT6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjEKT6s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 15:58:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DAA2D74;
        Thu, 11 May 2023 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683835126; x=1715371126;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pUsvKdquvKmuHGamcnxWxip93E9oYVuUB3NcqWyDNOY=;
  b=Aki7zXhMvR1fJeAjtnkRcp1xPdvzXWToDz/WexsxRr/pia1QzUuhk4+i
   vQPKcd3ntFnsQX+UOxjN+Dt5S+0RdFcn09a61d6VFA6g0/jX479WnzO5a
   LzCymrP+FCtoxbrWRWD8AMwfliAyg9hVo6qg9/FNsfQ9gTVpbotLeNJHI
   6Umq2OnRe8pXS45+oQb6mIwqE2EIa3fG2iYz4YI6dsCcevA6nmw/4wPMT
   iaar+2eyPQ3uPGwiESL7Pz8JrUClYD6GeUlvOejqIBPh9sz88FOIdOqO8
   WGKH4m6lxxVNWCgjz7z6mNFJgWtuXgnbK7mcat7XnjhUC6US3S7FPBOJW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="413976012"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="413976012"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 12:58:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="811762514"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="811762514"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.252.39.112])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 12:58:43 -0700
Date:   Thu, 11 May 2023 22:58:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
In-Reply-To: <ZF1AjOKDVlbNFJPK@bhelgaas>
Message-ID: <1d5aaff-c7b5-39f6-92ca-319fad6c7fc5@linux.intel.com>
References: <ZF1AjOKDVlbNFJPK@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-975131088-1683835125=:1900"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-975131088-1683835125=:1900
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 11 May 2023, Bjorn Helgaas wrote:

> On Thu, May 11, 2023 at 08:35:48PM +0300, Ilpo Järvinen wrote:
> > On Thu, 11 May 2023, Bjorn Helgaas wrote:
> > 
> > > On Thu, May 11, 2023 at 04:14:25PM +0300, Ilpo Järvinen wrote:
> > > > A few places write LNKCTL and LNKCTL2 registers without proper
> > > > concurrency control and this could result in losing the changes
> > > > one of the writers intended to make.
> > > > 
> > > > Add pcie_capability_clear_and_set_word_locked() and helpers to use it
> > > > with LNKCTL and LNKCTL2. The concurrency control is provided using a
> > > > spinlock in the struct pci_dev.
> > > > 
> > > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > 
> > > Thanks for raising this issue!  Definitely looks like something that
> > > needs attention.
> > > 
> > > > ---
> > > >  drivers/pci/access.c | 14 ++++++++++++++
> > > >  drivers/pci/probe.c  |  1 +
> > > >  include/linux/pci.h  | 17 +++++++++++++++++
> > > >  3 files changed, 32 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > > > index 3c230ca3de58..d92a3daadd0c 100644
> > > > --- a/drivers/pci/access.c
> > > > +++ b/drivers/pci/access.c
> > > > @@ -531,6 +531,20 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
> > > >  }
> > > >  EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
> > > >  
> > > > +int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
> > > > +					      u16 clear, u16 set)
> > > > +{
> > > > +	unsigned long flags;
> > > > +	int ret;
> > > > +
> > > > +	spin_lock_irqsave(&dev->cap_lock, flags);
> > > > +	ret = pcie_capability_clear_and_set_word(dev, pos, clear, set);
> > > > +	spin_unlock_irqrestore(&dev->cap_lock, flags);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +EXPORT_SYMBOL(pcie_capability_clear_and_set_word_locked);
> > > 
> > > I didn't see the prior discussion with Lukas, so maybe this was
> > > answered there, but is there any reason not to add locking to
> > > pcie_capability_clear_and_set_word() and friends directly?  
> > >
> > > It would be nice to avoid having to decide whether to use the locked
> > > or unlocked versions.  It would also be nice to preserve the use of
> > > PCI_EXP_LNKCTL directly, for grep purposes.  And it would obviate the
> > > need for some of these patches, e.g., the use of
> > > pcie_capability_clear_word(), where it's not obvious at the call site
> > > why a change is needed.
> > 
> > There wasn't that big discussion about it (internally). I brought both
> > alternatives up and Lukas just said he didn't know what's the best 
> > approach (+ gave a weak nudge towards the separate accessor so I went 
> > with it to make forward progress). Based on that I don't think he had a 
> > strong opinion on it.
> > 
> > I'm certainly fine to just use it in the normal accessor functions that 
> > do RMW and add the locking there. It would certainly have to those good 
> > sides you mentioned.
> 
> Let's start with that, then.
> 
> Many of these are ASPM-related updates that IMHO should not be in
> drivers at all.  Drivers should use PCI core interfaces so the core
> doesn't get confused.

Ah, yes. I forgot to mention it in the cover letter but I noticed that 
some of those seem to be workarounds for the cases where core refuses to 
disable ASPM. Some sites even explicit have a comment about that after 
the call to pci_disable_link_state():

static void bcm4377_disable_aspm(struct bcm4377_data *bcm4377)
{
        pci_disable_link_state(bcm4377->pdev,
                               PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);

        /*
         * pci_disable_link_state can fail if either CONFIG_PCIEASPM is disabled
         * or if the BIOS hasn't handed over control to us. We must *always*
         * disable ASPM for this device due to hardware errata though.
         */
        pcie_capability_clear_word(bcm4377->pdev, PCI_EXP_LNKCTL,
                                   PCI_EXP_LNKCTL_ASPMC);
}

That kinda feels something that would want a force disable quirk that is 
reliable. There are quirks for some devices which try to disable it but 
could fail for reasons mentioned in that comment. (But I'd prefer to make 
another series out of it rather than putting it into this one.)

It might even be that some drivers don't even bother to make the 
pci_disable_link_state() call because it isn't reliable enough.


-- 
 i.

--8323329-975131088-1683835125=:1900--
