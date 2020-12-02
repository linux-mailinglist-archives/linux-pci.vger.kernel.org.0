Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF72CB5C6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 08:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgLBH3H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 02:29:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:55567 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgLBH3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 02:29:07 -0500
IronPort-SDR: gDseQ8CfVFOtB1bxI5x9RCQ0NUlvsh3e7x6gT5SiF/1Hk0u7vYzIWIxe6HRP+BW/T05G7Z4ITH
 w2GnI1vTsU9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="170401378"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="170401378"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 23:28:24 -0800
IronPort-SDR: 7mH0seCdsPXuu1tpBvetF0AtVMclhkS9y/i5PE+CsBlmPzxRD6uDZdryccNVE+q4d5pznRMog2
 uxwpGceSrZVg==
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="549934606"
Received: from qwu16-mobl1.ccr.corp.intel.com ([10.255.30.201])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 23:28:21 -0800
Message-ID: <bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com>
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
From:   Zhang Rui <rui.zhang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        len.brown@intel.com
Date:   Wed, 02 Dec 2020 15:28:18 +0800
In-Reply-To: <87eekairc0.fsf@nanos.tec.linutronix.de>
References: <20201119181904.149129-1-helgaas@kernel.org>
         <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
         <20201126012421.GA92582@shbuild999.sh.intel.com>
         <87eekfk8bd.fsf@nanos.tec.linutronix.de>
         <20201127061131.GB105524@shbuild999.sh.intel.com>
         <87eekairc0.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-11-30 at 20:21 +0100, Thomas Gleixner wrote:
> Feng,
> 
> On Fri, Nov 27 2020 at 14:11, Feng Tang wrote:
> > On Fri, Nov 27, 2020 at 12:27:34AM +0100, Thomas Gleixner wrote:
> > > On Thu, Nov 26 2020 at 09:24, Feng Tang wrote:
> > > Yes, that can happen. But OTOH, we should start to think about
> > > the
> > > requirements for using the TSC watchdog.

My original proposal is to disable jiffies and refined-jiffies as the
clocksource watchdog, because they are not reliable and it's better to
use clocksource that has a hardware counter as watchdog, like the patch
below, which I didn't sent out for upstream.

From cf9ce0ecab8851a3745edcad92e072022af3dbd9 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Fri, 19 Jun 2020 22:03:23 +0800
Subject: [RFC PATCH] time/clocksource: do not use refined-jiffies as watchdog

On IA platforms, if HPET is disabled, either via x86 early-quirks, or
via kernel commandline, refined-jiffies will be used as clocksource
watchdog in early boot phase, before acpi_pm timer registered.

This is not a problem if jiffies are accurate.
But in some cases, for example, when serial console is enabled, it may
take several milliseconds to write to the console, with irq disabled,
frequently. Thus many ticks may become longer than it should be.

Using refined-jiffies as watchdog in this case breaks the system because
a) duration calculated by refined-jiffies watchdog is always consistent
   with the watchdog timeout issued using add_timer(), say, around 500ms.
b) duration calculated by the running clocksource, usually TSC on IA
   platforms, reflects the real time cost, which may be much larger.
This results in the running clocksource being disabled erroneously.

This is reproduced on ICL because HPET is disabled in x86 early-quirks,
and also reproduced on a KBL and a WHL platform when HPET is disabled
via command line.

BTW, commit fd329f276eca
("x86/mtrr: Skip cache flushes on CPUs with cache self-snooping") is
another example that refined-jiffies causes the same problem when ticks
become slow for some other reason.

IMO, the right solution is to only use hardware clocksource as watchdog.
Then even if ticks are slow, both the running clocksource and the watchdog
returns real time cost, and they still match.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 kernel/time/clocksource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 02441ead3c3b..e7e703858fa6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -364,6 +364,10 @@ static void clocksource_select_watchdog(bool fallback)
 		watchdog = NULL;
 
 	list_for_each_entry(cs, &clocksource_list, list) {
+		/* Do not use refined-jiffies as clocksource watchdog */
+		if (cs->rating <= 2)
+			continue;
+
 		/* cs is a clocksource to be watched. */
 		if (cs->flags & CLOCK_SOURCE_MUST_VERIFY)
 			continue;
-- 
2.17.1

> > > 
> > > I'm inclined to lift that requirement when the CPU has:
> > > 
> > >     1) X86_FEATURE_CONSTANT_TSC
> > >     2) X86_FEATURE_NONSTOP_TSC
> > >     3) X86_FEATURE_NONSTOP_TSC_S3
> > 
> > IIUC, this feature exists for several generations of Atom
> > platforms,
> > and it is always coupled with 1) and 2), so it could be skipped for
> > the checking.
> 
> Yes, we can ignore that bit as it's not widely available and not
> required to solve the problem.
> 
> > >     4) X86_FEATURE_TSC_ADJUST
> > >     
> > >     5) At max. 4 sockets
> > > 
Should we consider some other corner cases like TSC is not used as
clocksource? refined_jiffies watchdog can break any other hardware
clocksource when it becomes inaccurate.

> > > The only reason I hate to disable HPET upfront at least during
> > > boot is
> > > that HPET is the best mechanism for the refined TSC calibration.
> > > PMTIMER
> > > sucks because it's slow and wraps around pretty quick.
> > > 
> > > So we could do the following even on platforms where HPET stops
> > > in some
> > > magic PC? state:
> > > 
> > >   - Register it during early boot as clocksource
> > > 
> > >   - Prevent the enablement as clockevent and the chardev hpet
> > > timer muck
> > > 
> > >   - Prevent the magic PC? state up to the point where the refined
> > >     TSC calibration is finished.
> > > 
> > >   - Unregister it once the TSC has taken over as system
> > > clocksource and
> > >     enable the magic PC? state in which HPET gets disfunctional.
> > 

On the other side, for ICL, the HPET problem is observed on early
samples, and I didn't reproduce the problem on new ones I have.
But I need to confirm internally if it is safe to re-enable it first.

thanks,
rui
> > This looks reasonable to me. 
> > 
> > I have thought about lowering the hpet rating to lower than
> > PMTIMER, so it
> > still contributes in early boot phase, and fades out after PMTIMER
> > is
> > initialised.
> 
> Not a good idea. pm_timer is initialized before the refined
> calibration
> finishes.
> 
> Thanks,
> 
>         tglx

