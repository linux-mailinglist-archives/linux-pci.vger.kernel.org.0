Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87629700270
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 10:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjELIZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 04:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbjELIZm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 04:25:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F53E100F9;
        Fri, 12 May 2023 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683879941; x=1715415941;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=HcSGSqCMrA93+lGq+m/ENGiOx1XaeSvdWBQmB7W+7u4=;
  b=hcq3TjjGUmlspfktXLF76236xPdN/RwizvEKVTuEaSWb72/NC1hDUISe
   qGSTSxft7mPuWpglIBSNSB/G6uJ6I7Z/U+PjhGqYX5neJeWFPwDEwa7vE
   Txv0fKInM5kLVlmc9GN7OFmix4bfFHFvBEBVzC9LUgOS6aldERU5xfEMV
   8P2Y2DcgUdwCo5oliYkLVHBEsPmdTYBAAp5eVC9wnPSTv7Nz8HfFdCzcz
   bp18T0+4ulcre4zfBv+GAr87I7/Xj62Y3JzZfjwCJuLmSiZ6CbHuZLTcW
   zUfE624rUlEX+/PGy5JqZksne84qijej7dYmNwel1JPVvFIGtJgy2/qZJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="348231957"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="348231957"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 01:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="765093751"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765093751"
Received: from ralbanes-mobl.ger.corp.intel.com ([10.252.40.108])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 01:25:38 -0700
Date:   Fri, 12 May 2023 11:25:32 +0300 (EEST)
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
In-Reply-To: <20230511202332.GD31598@wunner.de>
Message-ID: <51577aaa-dc96-d588-2ecf-5bac4b59284@linux.intel.com>
References: <20230511131441.45704-2-ilpo.jarvinen@linux.intel.com> <ZF0P2hedTFXPv8IK@bhelgaas> <20230511202332.GD31598@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-320857836-1683879198=:1742"
Content-ID: <34b9a5a-82e1-abd9-5b56-b6f12b3e20fa@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-320857836-1683879198=:1742
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <99cc45f2-cec9-c279-504c-669df4d3f6f8@linux.intel.com>

On Thu, 11 May 2023, Lukas Wunner wrote:

> On Thu, May 11, 2023 at 10:55:06AM -0500, Bjorn Helgaas wrote:
> > On Thu, May 11, 2023 at 04:14:25PM +0300, Ilpo Järvinen wrote:
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
> > or unlocked versions.
> 
> I think we definitely want to also offer lockless accessors which
> can be used in hotpaths such as interrupt handlers if the accessed
> registers don't need any locking (e.g. because there are no concurrent
> accesses).
> 
> So the relatively lean approach chosen here which limits locking to
> Link Control and Link Control 2, but allows future expansion to other
> registers as well, seemed reasonable to me.

Hi Lukas,

I went through every single use of these functions in the mainline tree 
excluding LNKCTL/LNKCTL2 ones which will be having the lock anyway:

- pcie_capability_clear_and_set_*
- pcie_capability_set_*
- pcie_capability_clear_*

Everything outside of drivers/pci/ is dev init or dev reset related.

Almost all uses inside drivers/pci/ are init/configure/scan/PCI_FIXUP/pci_flr 
or suspend/resume related. With these exceptions:

->set_attention_status() drivers/pci/hotplug/pnv_php.c: pcie_capability_clear_and_set_word(bridge, PCI_EXP_SLTCTL,
spinlock + work (from pme.c) drivers/pci/pci.c: pcie_capability_set_dword(dev, PCI_EXP_RTSTA
spinlock + irq / work drivers/pci/pcie/pme.c: pcie_capability_set_word(dev, PCI_EXP_RTCTL,
spinlock + irq / work drivers/pci/pcie/pme.c: pcie_capability_clear_word(dev, PCI_EXP_RTCTL,

So the only case which seems relevant to your concern are those in
drivers/pci/pcie/pme.c which already takes a spinlock so it's not lockless 
as is.

What's more important though, isn't it possible that AER and PME RMW
PCI_EXP_RTCTL at the same time so it would need this RMW locking too 
despite the pme internal spinlock?

Do you still feel there's a need to differentiate this per capability 
given all the information above?


There could of course be open-coded capability RMW ops outside of the ones 
I checked but I suspect the conclusion would still remain pretty much the 
same.


-- 
 i.
--8323329-320857836-1683879198=:1742--
