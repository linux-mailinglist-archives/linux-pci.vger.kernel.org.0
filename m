Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767E22C999A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 09:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgLAIf3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 03:35:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:7906 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbgLAIf3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Dec 2020 03:35:29 -0500
IronPort-SDR: JAwRlSeW35vWh7h5WFqMDW19zGwmmpuC5b0ZNacKUs3TwQ4TPGHEdZ1jwA8exrdAmAgc5J6At/
 G2IRy87NNjqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="190985420"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="190985420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 00:34:48 -0800
IronPort-SDR: 4wlBkTRi8+ykZpMr20MHGKn2z5KPNloVqp+R8YUnBQEHhrTlmntmGjat5hvB9IVZpcEkamoWz1
 lqBT4ikPsZWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="335001904"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by orsmga006.jf.intel.com with ESMTP; 01 Dec 2020 00:34:44 -0800
Date:   Tue, 1 Dec 2020 16:34:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rui.zhang@intel.com, len.brown@intel.com
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
Message-ID: <20201201083443.GA8855@shbuild999.sh.intel.com>
References: <20201119181904.149129-1-helgaas@kernel.org>
 <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
 <20201126012421.GA92582@shbuild999.sh.intel.com>
 <87eekfk8bd.fsf@nanos.tec.linutronix.de>
 <20201127061131.GB105524@shbuild999.sh.intel.com>
 <87eekairc0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eekairc0.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Mon, Nov 30, 2020 at 08:21:03PM +0100, Thomas Gleixner wrote:
> Feng,
> 
> On Fri, Nov 27 2020 at 14:11, Feng Tang wrote:
> > On Fri, Nov 27, 2020 at 12:27:34AM +0100, Thomas Gleixner wrote:
> >> On Thu, Nov 26 2020 at 09:24, Feng Tang wrote:
> >> Yes, that can happen. But OTOH, we should start to think about the
> >> requirements for using the TSC watchdog.
> >> 
> >> I'm inclined to lift that requirement when the CPU has:
> >> 
> >>     1) X86_FEATURE_CONSTANT_TSC
> >>     2) X86_FEATURE_NONSTOP_TSC
> >
> >>     3) X86_FEATURE_NONSTOP_TSC_S3
> > IIUC, this feature exists for several generations of Atom platforms,
> > and it is always coupled with 1) and 2), so it could be skipped for
> > the checking.
> 
> Yes, we can ignore that bit as it's not widely available and not
> required to solve the problem.
> 
> >>     4) X86_FEATURE_TSC_ADJUST
> >>     
> >>     5) At max. 4 sockets
> >> 
> >> The only reason I hate to disable HPET upfront at least during boot is
> >> that HPET is the best mechanism for the refined TSC calibration. PMTIMER
> >> sucks because it's slow and wraps around pretty quick.
> >> 
> >> So we could do the following even on platforms where HPET stops in some
> >> magic PC? state:
> >> 
> >>   - Register it during early boot as clocksource
> >> 
> >>   - Prevent the enablement as clockevent and the chardev hpet timer muck
> >> 
> >>   - Prevent the magic PC? state up to the point where the refined
> >>     TSC calibration is finished.
> >> 
> >>   - Unregister it once the TSC has taken over as system clocksource and
> >>     enable the magic PC? state in which HPET gets disfunctional.
> >
> > This looks reasonable to me. 
> >
> > I have thought about lowering the hpet rating to lower than PMTIMER, so it
> > still contributes in early boot phase, and fades out after PMTIMER is
> > initialised.
> 
> Not a good idea. pm_timer is initialized before the refined calibration
> finishes.

Yes, you are right. I missed the part.

I dug some old notes, and found another old case (kernel 3.4) that a
broken PMTIMER as the watchdog clocksource wrongly judged TSC to be
unstable and disabled it, which makes me agree more to the idea of
"lift that requirement when the CPU has ..." 

If the TSC has those bits to garantee its reliability, then no need
to use a less reliable clocksource to monitor it.

Thanks,
Feng
