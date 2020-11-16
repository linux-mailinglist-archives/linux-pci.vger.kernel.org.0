Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57DC2B5352
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 21:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgKPU6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 15:58:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:57947 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgKPU6O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 15:58:14 -0500
IronPort-SDR: NrtG71fztbwf4E8QSKUUJf7n8JOwmnFYdBQSRBG/GWGDMKjG5Kbl1dYf1L6CSO0JDMKFm+OXfi
 FqdnVGvStT9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="158590228"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="158590228"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 12:58:04 -0800
IronPort-SDR: TsyHdZolnBqi88Fug9EssBaYMqlPMT0HER7tHBOPudtNXoVVJTUr0Qq6cjIyuc4jG+K3FIWx7b
 MPxDCVT40N9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="367631456"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2020 12:58:04 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 980AA5802E4;
        Mon, 16 Nov 2020 12:58:04 -0800 (PST)
Message-ID: <40579a7ed0692d535f002112b18d1bb6e25aad0e.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable PTM during suspend on Intel PCI bridges
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 16 Nov 2020 12:58:04 -0800
In-Reply-To: <20201116192320.GA1290192@bjorn-Precision-5520>
References: <20201116192320.GA1290192@bjorn-Precision-5520>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-11-16 at 13:23 -0600, Bjorn Helgaas wrote:
> On Mon, Nov 16, 2020 at 06:53:09PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Oct 7, 2020 at 7:10 PM Bjorn Helgaas <helgaas@kernel.org>
> > wrote:
> > > On Wed, Oct 07, 2020 at 06:53:16PM +0200, Rafael J. Wysocki
> > > wrote:
> > > > On Wed, Oct 7, 2020 at 6:49 PM David E. Box <
> > > > david.e.box@linux.intel.com> wrote:
> > > > > On Intel Platform Controller Hubs (PCH) since Cannon Lake,
> > > > > the Precision
> > > > > Time Measurement (PTM) capability can prevent PCIe root ports
> > > > > from power
> > > > > gating during suspend-to-idle, causing increased power
> > > > > consumption on
> > > > > systems that suspend using Low Power S0 Idle [1]. The issue
> > > > > is yet to be
> > > > > root caused but believed to be coming from a race condition
> > > > > in the suspend
> > > > > flow as the incidence rate varies for different platforms on
> > > > > Linux but the
> > > > > issue does not occur at all in other operating systems. For
> > > > > now, disable
> > > > > the feature on suspend on all Intel root ports and enable
> > > > > again on resume.
> > > > 
> > > > IMV it should also be noted that there is no particular reason
> > > > why PTM
> > > > would need to be enabled while the whole system is
> > > > suspended.  At
> > > > least it doesn't seem to be particularly useful in that state.
> > > 
> > > Is this a hardware erratum?  If not, and this is working as
> > > designed,
> > > it sounds like we'd need to apply this quirk to every device that
> > > supports PTM.  That's not really practical.
> > 
> > Why not?
> 
> My objection was that the original patch is a quirk that applies only
> to Intel devices.
> 
> If this is a generic thing that should be done for *all* devices that
> support PTM, that's fine, but it should not be a quirk, and it should
> not involve a list of Vendor or Device IDs.
> 
> > It looks like the capability should be saved by pci_save_state()
> > (it
> > isn't ATM, which appears to be a mistake) and restored by
> > pci_restore_state(), so if that is implemented, the saving can be
> > combined with the disabling in principle.
> 
> Yup, looks like a mistake.  Maybe David can fix that at the same time
> (probably a separate patch, though).  I don't have a way to test it,
> but he probably does.

Yes, I can test save/restore of the PTM capability and submit a patch.

> 
> > > The bugzilla says "there is no erratum as this does not affect
> > > Windows," but that doesn't answer the question.  What I want to
> > > know
> > > is whether this is a *hardware* defect and whether it will be
> > > fixed in
> > > future hardware.
> > 
> > I cannot answer this question, sorry.
> > 
> > ATM we only know that certain SoCs may not enter the deepest idle
> > state if PTM is enabled on some PCIe root ports during suspend.
> > 
> > Disabling PTM on those ports while suspending helps and hence the
> > patch.
> > 
> > It doesn't appear to qualify as a "hardware defect".
> > 
> > > If it's a "wont-fix" hardware issue, we can just disable PTM
> > > completely on Intel hardware and we won't have to worry about it
> > > during suspend.
> > 
> > I'm not following the logic here, sorry again.
> > 
> > First of all, there are systems that never suspend, so why would
> > they
> > be affected by the remedy (whatever it is)?
> > 
> > Second, it is not about the suspend failing entirely.  It's about
> > being able to make the system draw less power while suspended.
> > 
> > Generally, if someone said "I can make the system draw less power
> > while suspended if I disable PCIe feature X during suspend", would
> > you
> > disregard that?
> 
> My questions were all prompted by the Intel-specific nature of the
> original patch, which suggests an ongoing maintenance burden.  If it
> can be done generically, I have no problem with it.

Okay. I'll add this to the save/restore patch then with the comment
that it saves power on some Intel platforms.

David

