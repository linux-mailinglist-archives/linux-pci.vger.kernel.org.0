Return-Path: <linux-pci+bounces-9989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B9F92B5E9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 12:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA021F22A4E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F87155A32;
	Tue,  9 Jul 2024 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbZmbl0b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C89155329;
	Tue,  9 Jul 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522339; cv=none; b=JhNigAN3amIjBCzZahnPjNxHO6rBkmGvl+N8e9KKhhGt2Ae3nGSSi/lnYKwbB6H10kejTmQlQ8bgdn8EyLpyhqdIEoTGxTY2XDZ0mFJwuhmU35jEZJOHk9m+qddr3qBTJjvsgn60WeJ33STtGiywebRTeJiyfF3wBdmccMNkrHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522339; c=relaxed/simple;
	bh=FRgjCLcJ6MXfKDSYddl5jo5cz8bvhM5ilxUGSXDAteA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fy8ocqqH+/wWzOA+m1Uygm/OMNlWzK01M+1GMT1kukoz610K7yOsnp3VbpG7dvkbhSFTtZIu1KA0Oal7pizxq89oLoybAQRIPH0SO/6XKPNiGJ7Qhv/RDbJJPfKI9TNAUppMG79TWtrExxoeXw2uGtjX7cgOihwFD3imF9IOFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbZmbl0b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720522338; x=1752058338;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FRgjCLcJ6MXfKDSYddl5jo5cz8bvhM5ilxUGSXDAteA=;
  b=cbZmbl0brGS1ZuUutOydvwB2jZXKFJxFLGQZvwunGX5AewA7+qw9Jg29
   4TKZhtguygXiO61XOCQ1W/TsdB1qWbo34AgiO2ai3Wq/63mmDQj+pSRQH
   cuAG2L9tRM7IdhcU2NSmOJEnIZIh8V5/RzInEEkWCsvquXhBCydfV6hti
   DTtepvjkPNWQuO+OgBu0E25YPQHy5ROSfOeebXmjhIhpmlq9BK5DsyZzn
   R+ZcMvL/Tq6AGqdyltrbvPkRlqK+vKE2/rEOtM/s0Hen+jx89px/pMnph
   t/DDQLlIJv30zVtocSxaG+c23zncsYqxL8sTKaATOen5AHVAZUrI4z8Ea
   A==;
X-CSE-ConnectionGUID: 2p52lraDRoSMEA11uU3gYQ==
X-CSE-MsgGUID: PCuxifZtTl++tye+Neh+Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28366708"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="28366708"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 03:52:17 -0700
X-CSE-ConnectionGUID: WWaLn5PnTiaOMvwna+yrPQ==
X-CSE-MsgGUID: KrKTrYGrREyTb4p/oMmiRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47708644"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.123])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 03:52:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 9 Jul 2024 13:52:07 +0300 (EEST)
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>, 
    Hagan Billy <billy.hagan@amd.com>, Simon Guinot <simon.guinot@seagate.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
In-Reply-To: <73fd7b2d-9256-9eba-70be-d69ea336fd67@amd.com>
Message-ID: <6014882f-0936-ec31-d641-112a70eb2749@linux.intel.com>
References: <20240617231841.GA1232294@bhelgaas> <27be113e-3e33-b969-c1e3-c5e82d1b8b7f@amd.com> <cf5f3b03-4c70-7a35-056e-5d94fc26f697@amd.com> <ZnKNJxJwdtWRphgX@wunner.de> <73fd7b2d-9256-9eba-70be-d69ea336fd67@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Jun 2024, Smita Koralahalli wrote:

> Sorry for the delay here. Took some time to find a system to run experiments.
> Comments inline.
>
> On 6/19/2024 12:47 AM, Lukas Wunner wrote:
> > On Tue, Jun 18, 2024 at 02:23:21PM -0700, Smita Koralahalli wrote:
> > > On 6/18/2024 11:51 AM, Smita Koralahalli wrote:
> > > > > > > But IIUC LBMS is set by hardware but never cleared by hardware, so
> > > > > > > if
> > > > > > > we remove a device and power off the slot, it doesn't seem like
> > > > > > > LBMS
> > > > > > > could be telling us anything useful (what could we do in response
> > > > > > > to
> > > > > > > LBMS when the slot is empty?), so it makes sense to me to clear
> > > > > > > it.
> > > > > > > 
> > > > > > > It seems like pciehp_unconfigure_device() does sort of PCI core
> > > > > > > and
> > > > > > > driver-related things and possibly could be something shared by
> > > > > > > all
> > > > > > > hotplug drivers, while remove_board() does things more specific to
> > > > > > > the
> > > > > > > hotplug model (pciehp, shpchp, etc).
> > > > > > > 
> > > > > > >  From that perspective, clearing LBMS might fit better in
> > > > > > > remove_board(). In that case, I wonder whether it should be done
> > > > > > > after turning off slot power? This patch clears is *before*
> > > > > > > turning
> > > > > > > off the power, so I wonder if hardware could possibly set it again
> > > > > > > before the poweroff?
> > > 
> > > While clearing LBMS in remove_board() here:
> > > 
> > > if (POWER_CTRL(ctrl)) {
> > > 	pciehp_power_off_slot(ctrl);
> > > +	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
> > > 				   PCI_EXP_LNKSTA_LBMS);
> > > 
> > > 	/*
> > > 	 * After turning power off, we must wait for at least 1 second
> > > 	 * before taking any action that relies on power having been
> > > 	 * removed from the slot/adapter.
> > > 	 */
> > > 	msleep(1000);
> > > 
> > > 	/* Ignore link or presence changes caused by power off */
> > > 	atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> > > 		   &ctrl->pending_events);
> > > }
> > > 
> > > This can happen too right? I.e Just after the slot poweroff and before
> > > LBMS
> > > clearing the PDC/PDSC could be fired. Then
> > > pciehp_handle_presence_or_link_change() would hit case "OFF_STATE" and
> > > proceed with pciehp_enable_slot() ....pcie_failed_link_retrain() and
> > > ultimately link speed drops..
> > > 
> > > So, I added clearing just before turning off the slot.. Let me know if I'm
> > > thinking it right.
> 
> I guess I should have experimented before putting this comment out.
> 
> After talking to the HW/FW teams, I understood that, none of our CRBs support
> power controller for NVMe devices, which means the "Power Controller Present"
> in Slot_Cap is always false. That's what makes it a "surprise removal." If the
> OS was notified beforehand and there was a power controller attached, the OS
> would turn off the power with SLOT_CNTL. That's an "orderly" removal. So
> essentially, the entire block from "if (POWER_CTRL(ctrl))" will never be
> executed for surprise removal for us.
> 
> There could be board designs outside of us, with power controllers for the
> NVME devices, which I'm not aware of.
> > 
> > This was added by 3943af9d01e9 ("PCI: pciehp: Ignore Link State Changes
> > after powering off a slot").  You can try reproducing it by writing "0"
> > to the slot's "power" file in sysfs, but your hardware needs to support
> > slot power.
> > 
> > Basically the idea is that after waiting for 1 sec, chances are very low
> > that any DLLSC or PDSC events caused by removing slot power may still
> > occur.
> 
> PDSC events occurring in our case aren't by removing slot power. It
> should/will always happen on a surprise removal along with DLLSC for us. But
> this PDSC is been delayed and happens after DLLSC is invoked and ctrl->state =
> OFF_STATE in pciehp_disable_slot(). So the PDSC is mistook to enable slot in
> pciehp_enable_slot() inside pciehp_handle_presence_or_link_change().
> > 
> > Arguably the same applies to LBMS changes, so I'd recommend to likewise
> > clear stale LBMS after the msleep(1000).
> > 
> > pciehp_ctrl.c only contains the state machine and higher-level logic of
> > the hotplug controller and all the actual register accesses are in helpers
> > in pciehp_hpc.c.  So if you want to do it picture-perfectly, add a helper
> > in pciehp_hpc.c to clear LBMS and call that from remove_board().
> > 
> > That all being said, I'm wondering how this plays together with Ilpo's
> > bandwidth control driver?
> > 
> > https://lore.kernel.org/all/20240516093222.1684-1-ilpo.jarvinen@linux.intel.com/
> 
> I need to yet do a thorough reading of Ilpo's bandwidth control driver. Ilpo
> please correct me if I misspeak something as I don't have a thorough
> understanding.
> 
> Ilpo's bandwidth controller also checks for lbms count to be greater than zero
> to bring down link speeds if CONFIG_PCIE_BWCTRL is true. If false, it follows
> the default path to check LBMS bit in link status register. So if,
> CONFIG_PCIE_BWCTRL is disabled by default we continue to see link speed drops.
> Even, if BWCTRL is enabled, LBMS count is incremented to 1 in
> pcie_bwnotif_enable() so likely pcie_lbms_seen() might return true thereby
> bringing down speeds here as well if DLLLA is clear?

I did add code to clear the LBMS count in pciehp_unconfigure_device() in 
part thanks to this patch of yours. Do you think it wouldn't work?

But I agree there would still be problem if BWCTRL is not enabled. I 
already have to keep part of it enabled due to the Target Speed quirk
and now this is another case where just having it always on would be
beneficial.

> > IIUC, the bandwidth control driver will be in charge of handling LBMS
> > changes.  So clearing LBMS behind the bandwidth control driver's back
> > might be problematic.  Ilpo?

Yes, BW controller will take control of LBMS and other code should not 
touch it directly (and LBMS will be kept cleared by the BW controller). 
However, in this case I'll just need to adapt the code to replace the 
LBMS clearing with resetting the LBMS count (if this patch is accepted 
before BW controller), the resetting is already there anyway.

> > Also, since you've confirmed that this issue is fallout from
> > a89c82249c37 ("PCI: Work around PCIe link training failures"),
> > I'm wondering if the logic introduced by that commit can be
> > changed so that the quirk is applied more narrowly, i.e. *not*
> > applied to unaffected hardware, such as AMD's hotplug ports.
> > That would avoid the need to undo the effect of the quirk and
> > work around the downtraining you're seeing.
> > 
> > Maciej, any ideas?
> 
> Yeah I'm okay to go down to that approach as well. Any ideas would be helpful
> here.

One thing I don't like in the Target Speed quirk is that it leaves the 
Link Speed into the lower value if the quirk fails to bring the link up, 
the quirk could restore the original Link Speed on failure to avoid these 
problems. I even suggested that earlier, however, the downside of 
restoring the original Link Speed is that it will require triggering yet 
another retraining (perhaps we could avoid waiting for its completion 
though since we expect it to fail).

It might be possible to eventually trigger the Target Speed quirk from the 
BW controller but it would require writing some state machine so that the 
quirk is not repeatedly attempted. It seemed to complicate things too much 
to add such a state machine at this point.

-- 
 i.


