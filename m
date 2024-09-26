Return-Path: <linux-pci+bounces-13558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 703BD987209
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF761F210DE
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB701ACE12;
	Thu, 26 Sep 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JX9fYAsk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D041AC883;
	Thu, 26 Sep 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347941; cv=none; b=ahSRNpPfwzXAh1PMtm1iNFKVUsPDNJHWlZ2ITV+3k5W85XIb8ZEAZdNF23eeJeNDIj4hn2nqNBDPG4f4ErXy+EJCRTqyzHbRRNoXay/97o2Pe6HZlTpEpHBnZDDhSpssKWM341AGfeacSiN/yjkr3Mr32LPH4tn5EJY1yzxfrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347941; c=relaxed/simple;
	bh=9WzNs6a9TghPvx2jiO6tLXzf0mbcqwe2XFjZKwbhgZk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oqLgZJvLjFAYP/mPh4+vmsLb7M1amAkiWW6upOUBv/3qYxyBHmrUoNnZU9zfs5a9lyyzdGFvBxiSRvkPIEZr65uRregKHKvel0rKgQ7CMTZsFGg9oW8BbtXRzmmVDStBKnPhdeL61YPeS1DDMX0bM00V7pblNWvcegbAZ8yWP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JX9fYAsk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727347938; x=1758883938;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9WzNs6a9TghPvx2jiO6tLXzf0mbcqwe2XFjZKwbhgZk=;
  b=JX9fYAskOHaJO/dFVSYq/thavLlV59/RaM2hZtsqNqrtCfIq/3OeAPvL
   Vd8Ex/+MZKjnf8GwdBFxzKVuSvjjml5p9IK3z4zKhQzI2SXoMZZurIb/u
   WzfJLi9MZd0efnQmlirC5cZgdzrqrqttsjvqgFeu8AWm9Y5Sl0JssH5uc
   cr0/ReeMvTPSbSkCNUyWk8zG/i0W7RZ+I5guLgiVextPDqV+lxVMwkkIQ
   kS1zc32rqqHpFoVEu8mbIiLq+8vPSmbhU5R9rddXKLDOa7/UHR7pI3Mcd
   Qx+XtALBZ2NK/WcsC69mE8PdhsFph1fAFxjI+HaEEdvLMNdA+wO19GeQu
   A==;
X-CSE-ConnectionGUID: ycXdzTUsRXWs/OL8NArgCw==
X-CSE-MsgGUID: duTC8LwBSEqLLKDwDL2zwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26382557"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="26382557"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 03:52:18 -0700
X-CSE-ConnectionGUID: c6sVX8B9SpG2LluwZMDWHg==
X-CSE-MsgGUID: zEBcAInwRUWmUbWn4+lMMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="76872303"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.208])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 03:52:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 26 Sep 2024 13:52:10 +0300 (EEST)
To: Jian-Hong Pan <jhp@endlessos.org>
cc: david.e.box@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>, 
    Johan Hovold <johan@kernel.org>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@endlessos.org
Subject: Re: [PATCH v9 3/3] PCI: vmd: Save/restore PCIe bridge states
 before/after pci_reset_bus()
In-Reply-To: <CAPpJ_ed09KJY9Gw2qGwOHdKFw4-BAMyG6jOyWHnV7brJutwfVw@mail.gmail.com>
Message-ID: <44275137-97fc-3da9-c01a-6e747c236c8e@linux.intel.com>
References: <20240924070551.14976-2-jhp@endlessos.org> <20240924072858.15929-3-jhp@endlessos.org> <8050f9d4cb851fc301cc35b4fb5a839ff71fdcae.camel@linux.intel.com> <CAPpJ_ed09KJY9Gw2qGwOHdKFw4-BAMyG6jOyWHnV7brJutwfVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1368481887-1727347868=:1148"
Content-ID: <f275b967-ffbf-9ab3-03c1-043b59007802@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1368481887-1727347868=:1148
Content-Type: text/plain; CHARSET=ISO-2022-JP
Content-ID: <c0937035-0f93-a19e-a39c-fd9eeda963df@linux.intel.com>

On Thu, 26 Sep 2024, Jian-Hong Pan wrote:

> David E. Box <david.e.box@linux.intel.com> 於 2024年9月26日 週四 上午10:51寫道：
> >
> > Hi Jian-Hong,
> >
> > On Tue, 2024-09-24 at 15:29 +0800, Jian-Hong Pan wrote:
> > > PCI devices' parameters on the VMD bus have been programmed properly
> > > originally. But, cleared after pci_reset_bus() and have not been restored
> > > correctly. This leads the link's L1.2 between PCIe Root Port and child
> > > device gets wrong configs.
> > >
> > > Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> > > bridge and NVMe device should have the same LTR1.2_Threshold value.
> > > However, they are configured as different values in this case:
> > >
> > > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor
> > > PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> > >   ...
> > >   Capabilities: [200 v1] L1 PM Substates
> > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> > >       PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
> > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >       T_CommonMode=0us LTR1.2_Threshold=0ns
> > >     L1SubCtl2: T_PwrOn=0us
> > >
> > > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue
> > > SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> > >   ...
> > >   Capabilities: [900 v1] L1 PM Substates
> > >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
> > >       PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
> > >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > >       T_CommonMode=0us LTR1.2_Threshold=101376ns
> > >     L1SubCtl2: T_PwrOn=50us
> > >
> > > Here is VMD mapped PCI device tree:
> > >
> > > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> > >  | ...
> > >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
> > >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> > >
> > > When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> > > restores NVMe's state before and after reset. Because bus [e1] has only one
> > > device: 10000:e1:00.0 NVMe. The PCIe bridge is missed. However, when it
> > > restores the NVMe's state, it also restores the ASPM L1SS between the PCIe
> > > bridge and the NVMe by pci_restore_aspm_l1ss_state(). The NVMe's L1SS is
> > > restored correctly. But, the PCIe bridge's L1SS is restored with the wrong
> > > value 0x0. Becuase, the PCIe bridge's state is not saved before reset.
> > > That is why pci_restore_aspm_l1ss_state() gets the parent device (PCIe
> > > bridge)'s saved state capability data and restores L1SS with value 0.
> > >
> > > So, save the PCIe bridge's state before pci_reset_bus(). Then, restore the
> > > state after pci_reset_bus(). The restoring state also consumes the saving
> > > state.
> > >
> > > Link: https://www.spinics.net/lists/linux-pci/msg159267.html
> > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > ---
> > > v9:
> > > - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.
> > >
> > >  drivers/pci/controller/vmd.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > index 11870d1fc818..2820005165b4 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -938,9 +938,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > > unsigned long features)
> > >               if (!list_empty(&child->devices)) {
> > >                       dev = list_first_entry(&child->devices,
> > >                                              struct pci_dev, bus_list);
> >
> > Newline here
> > > +                     /* To avoid pci_reset_bus restore wrong ASPM L1SS
> > > +                      * configuration due to missed saving parent device's
> > > +                      * states, save & restore the parent device's states
> > > +                      * as well.
> > > +                      */
> >
> > No text on first line of comment.
> 
> Oops!  Thanks
> 
> >     /*
> >      * To avoid pci_reset_bus restore wrong ASPM L1SS
> >      * ...
> >      */
> >
> > > +                     pci_save_state(dev->bus->self);
> > >                       ret = pci_reset_bus(dev);
> > >                       if (ret)
> > >                               pci_warn(dev, "can't reset device: %d\n",
> > > ret);
> > > +                     pci_restore_state(dev->bus->self);
> >
> > I think Ilpo's point was that pci_save_aspm_l1ss_state() and
> > pci_restore_aspm_l1ss_state() should be more symmetric. If
> > pci_save_aspm_l1ss_state() is changed to also handle the state for the device
> > and its parent in the same call, then no change is needed here. But that would
> > only handle L1SS settings and not anything else that might need to be restored
> > after the bus reset. So I'm okay with it either way.

Why would something else need to be restored? The spec explicitly says the 
bus reset should not cause config changes on the parent other than 
to status bits.

Based on what is seen so far, the problem here is not the reset itself 
breaking parent's config but ASPM code restoring values from state beyond 
what it had saved and thus it programs pseudogarbage into the L1SS 
settings.

> Yes, that made me think the whole day before I sent out this patch. I
> do not know what is the best reset bus procedure, especially how other
> drivers reset the bus.
> 
> If trace the code path:
> pci_reset_bus()
>   __pci_reset_bus()
>     pci_bus_reset()
>       pci_bus_save_and_disable_locked()
> 
> pci_bus_save_and_disable_locked()'s comment shows "Save and disable
> devices from the top of the tree down while holding the @dev mutex
> lock for the entire tree". I think that means the PCI(e) bridge should
> save state first, then the following bus' devices. However, VMD resets
> the child device (10000:e1:00.0 NVMe)'s bus first and only saves the
> child device (10000:e1:00.0 NVMe)'s state. It does not visit the tree
> from the top to down. So, it misses the PCIe bridge.  Therefore, I
> make it save & restore its parent (10000:e0:06.0 PCIe bridge)'s state
> as compensation.

The problem with your fix is it only takes care of part of the cases (i.e. 
VMD). But there are other callers of pci_reset_bus() which would also 
restore incorrect L1SS settings, no?

I'd suggest making the L1SS code symmetric on this, even if it means 
saving the register value twice when walking the tree downwards (it seems 
harmless to write the same value twice).

-- 
 i.
--8323328-1368481887-1727347868=:1148--

