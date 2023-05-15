Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91897702C28
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 14:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbjEOMCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbjEOMCH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 08:02:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AD01FC6;
        Mon, 15 May 2023 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684152012; x=1715688012;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=lXKrOwj5PNXOGKYnVu6DDSnA2jMvT5ryqCZud7eQiLY=;
  b=cxHkjYWnAItLLE0+qZjhBXvIIKbtIdiGc4S0/DbEOqjGsmMCEAE4cEqG
   jFQH0lddWSzXTa9JRH29YGLSKVOqHri2OH1lxQnZklIa+elbIPL3JMIij
   Iv3RAb8zD5q9CKG0d5v5n60wu1ZenOrA4mtFXNTH4GxM40Sb3PES/2WVu
   mH+mz8ULoBI1vtTXtPW01F72Ux91bsmmjXuEYRswzMiiVFKbzKQVlqfnU
   L2Mns2NHTbhJjz/48ROeGnkDlHJr36JYuT3gUMqPTtBtgp6MFgD/bRjuL
   zyznhr0d6vnj9W/1UhptxwLVJziyUNaFsXixZa973tp8XwKYZifIyVM9B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="354337606"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="354337606"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 04:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="703964116"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="703964116"
Received: from fsamelis-mobl.ger.corp.intel.com ([10.252.42.18])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 04:59:47 -0700
Date:   Mon, 15 May 2023 14:59:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
In-Reply-To: <20230514101041.GA1881@wunner.de>
Message-ID: <2832e4a-8ef5-8695-3ca2-2b2f287a44d@linux.intel.com>
References: <20230511131441.45704-2-ilpo.jarvinen@linux.intel.com> <ZF0P2hedTFXPv8IK@bhelgaas> <20230511202332.GD31598@wunner.de> <51577aaa-dc96-d588-2ecf-5bac4b59284@linux.intel.com> <20230514101041.GA1881@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1734733710-1684147086=:2173"
Content-ID: <bc617524-c5f3-4ced-f67a-378470bd19ac@linux.intel.com>
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

--8323329-1734733710-1684147086=:2173
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <6044db88-bfe0-d5dd-baa3-6ca6ecdc6ba9@linux.intel.com>

On Sun, 14 May 2023, Lukas Wunner wrote:

> On Fri, May 12, 2023 at 11:25:32AM +0300, Ilpo Järvinen wrote:
> > On Thu, 11 May 2023, Lukas Wunner wrote:
> > > On Thu, May 11, 2023 at 10:55:06AM -0500, Bjorn Helgaas wrote:
> > > > I didn't see the prior discussion with Lukas, so maybe this was
> > > > answered there, but is there any reason not to add locking to
> > > > pcie_capability_clear_and_set_word() and friends directly?
> > > > 
> > > > It would be nice to avoid having to decide whether to use the locked
> > > > or unlocked versions.
> > > 
> > > I think we definitely want to also offer lockless accessors which
> > > can be used in hotpaths such as interrupt handlers if the accessed
> > > registers don't need any locking (e.g. because there are no concurrent
> > > accesses).
> > > 
> > > So the relatively lean approach chosen here which limits locking to
> > > Link Control and Link Control 2, but allows future expansion to other
> > > registers as well, seemed reasonable to me.
> > 
> > I went through every single use of these functions in the mainline tree 
> > excluding LNKCTL/LNKCTL2 ones which will be having the lock anyway:
> > 
> > - pcie_capability_clear_and_set_*
> > - pcie_capability_set_*
> > - pcie_capability_clear_*
> 
> We're also performing RMW through pcie_capability_read_word() +
> pcie_capability_write_word() combos, see drivers/pci/hotplug/pciehp_hpc.c
> for examples.

That's why I said there could be other RMW operations outside of what
I carefully looked at. It, however, does not mean I didn't take any look 
at those.

But since brought it up, lets go through this case with
drivers/pci/hotplug/pciehp_hpc.c, it won't change anything:

All PCI_EXP_SLTSTA ones looked not real RMW but ACK bits type of writes
(real RMW = preverse other bits vs ACK write = other bits are written as 
zeros). Using RMW accessors would need an odd construct such as this
(and pcie_capability_set/clear_word() would be plain wrong):
	pcie_capability_clear_and_set_word(dev, PCI_EXP_SLTSTA,
					   ~PCI_EXP_SLTSTA_CC,
					   PCI_EXP_SLTSTA_CC);

PCI_EXP_SLTCTL write is protected by a mutex, it doesn't look something 
that matches your initial concern about "hot paths (e.g. interrupt 
handlers)".

In general, outside of drivers/pci/hotplug there are not that many 
capability writes (beyond LNKCTL/LNKCTL2 and now also RTCTL). None of 
those seem hot paths.

> > Do you still feel there's a need to differentiate this per capability 
> > given all the information above?
> 
> What I think is unnecessary and counterproductive is to add wholesale
> locking of any access to the PCI Express Capability Structure.
> 
> It's fine to have a single spinlock, but I'd suggest only using it
> for registers which are actually accessed concurrently by multiple
> places in the kernel.

While it does feel entirely unnecessary layer of complexity to me, it would 
be possible to rename the original pcie_capability_clear_and_set_word() to 
pcie_capability_clear_and_set_word_unlocked() and add this into 
include/linux/pci.h:

static inline int pcie_capability_clear_and_set_word(struct pci_dev *dev,
					int pos, u16 clear, u16 set)
{
	if (pos == PCI_EXP_LNKCTL || pos == PCI_EXP_LNKCTL2 ||
	    pos == PCI_EXP_RTCTL)
		pcie_capability_clear_and_set_word_locked(...);
	else
		pcie_capability_clear_and_set_word_unlocked(...);
}

It would keep the interface exactly the same but protect only a selectable 
set of registers. As pos is always a constant, the compiler should be able 
to optimize all the dead code away.

Would that be ok then?

-- 
 i.


> > spinlock + irq / work drivers/pci/pcie/pme.c: pcie_capability_set_word(dev, PCI_EXP_RTCTL,
> > spinlock + irq / work drivers/pci/pcie/pme.c: pcie_capability_clear_word(dev, PCI_EXP_RTCTL,
> [...]
> > What's more important though, isn't it possible that AER and PME RMW
> > PCI_EXP_RTCTL at the same time so it would need this RMW locking too 
> > despite the pme internal spinlock?
> 
> Yes that looks broken, so RTCTL would be another register besides
> LNKCTL and LNKCTL2 that needs protection, good catch.
> 
> Thanks,
> 
> Lukas
> 
--8323329-1734733710-1684147086=:2173--
