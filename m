Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA42C5FF6
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 07:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392536AbgK0GLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Nov 2020 01:11:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:17080 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392534AbgK0GLg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Nov 2020 01:11:36 -0500
IronPort-SDR: u7upJnnBwpSz2VftdbitE9uZsb2uWuZkE77Bw9KmBumAfI53oP11WbF/6aiTTEtsHWr45hTd5S
 ofpS8S3rAuyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="151612401"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="151612401"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 22:11:35 -0800
IronPort-SDR: uHGVGAOjkyJ4ApbHIf6yu/RmYkcjGgPhUcbrMs9Cap5pR5ODcduVWkkj5PsvF9ZAmKGirAIS0n
 RR4MvVmEzPzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="479584662"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2020 22:11:32 -0800
Date:   Fri, 27 Nov 2020 14:11:31 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rui.zhang@intel.com, len.brown@intel.com
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
Message-ID: <20201127061131.GB105524@shbuild999.sh.intel.com>
References: <20201119181904.149129-1-helgaas@kernel.org>
 <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
 <20201126012421.GA92582@shbuild999.sh.intel.com>
 <87eekfk8bd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eekfk8bd.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Fri, Nov 27, 2020 at 12:27:34AM +0100, Thomas Gleixner wrote:
> Feng,
> 
> On Thu, Nov 26 2020 at 09:24, Feng Tang wrote:
> > On Wed, Nov 25, 2020 at 01:46:23PM +0100, Thomas Gleixner wrote:
> >> Now the more interesting question is why this needs to be a PCI quirk in
> >> the first place. Can't we just disable the HPET based on family/model
> >> quirks?
> >> 
> >> e0748539e3d5 ("x86/intel: Disable HPET on Intel Ice Lake platforms")
> >> f8edbde885bb ("x86/intel: Disable HPET on Intel Coffee Lake H platforms")
> >> fc5db58539b4 ("x86/quirks: Disable HPET on Intel Coffe Lake platforms")
> >> 62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail platform")
> 
> > I added this commit, and I can explain some for Baytrail. There was
> > some discussion about the way to disable it:
> > https://lore.kernel.org/lkml/20140328073718.GA12762@feng-snb/t/
> >
> > It uses PCI ID early quirk in the hope that later Baytrail stepping
> > doesn't have the problem. And later on, there was official document
> > (section 18.10.1.3 http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-1.pdf)
> > stating Baytrail's HPET halts in deep idle. So I think your way of 
> > using CPUID to disable Baytrail HPET makes more sense.
> 
> Correct.
> 
> >> I might be missing something here, but in general on anything modern
> >> HPET is mostly useless.
> >
> > IIUC, nowdays HPET's main use is as a clocksource watchdog monitor.
> 
> Plus for the TSC refined calibration, where it is really better than
> anything else we have _if_ it is functional.
> 
> > And in one debug case, we found it still useful. The debug platform has 
> > early serial console which prints many messages in early boot phase,
> > when the HPET is disabled, the software 'jiffies' clocksource will
> > be used as the monitor. Early printk will disable interrupt will
> > printing message, and this could be quite long for a slow 115200
> > device, and cause the periodic HW timer interrupt get missed, and
> > make the 'jiffies' clocksource not accurate, which will in turn
> > judge the TSC clocksrouce inaccurate, and disablt it. (Adding Rui,
> > Len for more details)
> 
> Yes, that can happen. But OTOH, we should start to think about the
> requirements for using the TSC watchdog.
> 
> I'm inclined to lift that requirement when the CPU has:
> 
>     1) X86_FEATURE_CONSTANT_TSC
>     2) X86_FEATURE_NONSTOP_TSC

>     3) X86_FEATURE_NONSTOP_TSC_S3
IIUC, this feature exists for several generations of Atom platforms,
and it is always coupled with 1) and 2), so it could be skipped for
the checking.
	
>     4) X86_FEATURE_TSC_ADJUST
>     
>     5) At max. 4 sockets
> 
> After two decades of horrors we're finally at a point where TSC seems to
> be halfways reliable and less abused by BIOS tinkerers. TSC_ADJUST was
> really key as we can now detect even small modifications reliably and
> the important point is that we can cure them as well (not pretty but
> better than all other options).
> 
> The only nasty one in the list above is #5 because AFAIK there is still
> no architecural guarantee for TSCs being synchronized on machines with
> more than 4 sockets. I might be wrong, but then nobody told me.
> 
> The only reason I hate to disable HPET upfront at least during boot is
> that HPET is the best mechanism for the refined TSC calibration. PMTIMER
> sucks because it's slow and wraps around pretty quick.
> 
> So we could do the following even on platforms where HPET stops in some
> magic PC? state:
> 
>   - Register it during early boot as clocksource
> 
>   - Prevent the enablement as clockevent and the chardev hpet timer muck
> 
>   - Prevent the magic PC? state up to the point where the refined
>     TSC calibration is finished.
> 
>   - Unregister it once the TSC has taken over as system clocksource and
>     enable the magic PC? state in which HPET gets disfunctional.

This looks reasonable to me. 

I have thought about lowering the hpet rating to lower than PMTIMER, so it
still contributes in early boot phase, and fades out after PMTIMER is
initialised.

Thanks,
Feng

> Hmm?
> 
> Thanks,
> 
>         tglx
> 
> 
