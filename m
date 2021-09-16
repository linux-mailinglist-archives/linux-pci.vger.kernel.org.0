Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160E840E51E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbhIPRIA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 13:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349527AbhIPRF7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Sep 2021 13:05:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 769D961989;
        Thu, 16 Sep 2021 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631810147;
        bh=X3L0sdB1coWaOhAGeEzEbbKibPUqOLJ8vCBEOJ124JA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FEBZS2Lacl37cxUl/ylSrlRHd9sVtush4cPKLVdLolSBlZXsozavO10MuLHLa544n
         IOucmjhlQRvj/FtINc37QyFAiZ34nLU1osfBEVDaivuQts9JH6J7HXMV08942JeBO6
         mzGyRv8PUuAKplnB/d9kY3bZ4oMjCQhqOatyP2KGZ75wn80u/K/Zyx3cqi+/+L2vm3
         ADsils5jUWL8rvsBJxxlh2cUbbM6jVCItRwSQA7uoD+SORw9o6FF01sArwqlT0lvXS
         wMH8xfN4UI0w8QcES4tj/VlJ2IkAIa85Ycf9jOSdfoBsAbIijBaqmKpd42i3RLV3uj
         MGcvbiTzzUkzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 45E285C028C; Thu, 16 Sep 2021 09:35:47 -0700 (PDT)
Date:   Thu, 16 Sep 2021 09:35:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, x86@kernel.org,
        jose.souza@intel.com, hpa@zytor.com, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, kai.heng.feng@canonical.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, rudolph@fb.com,
        xapienz@fb.com, bmilton@fb.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/intel: Disable HPET on another Intel Coffee Lake
 platform
Message-ID: <20210916163547.GD4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210916131739.1260552-1-kuba@kernel.org>
 <20210916150707.GA1611532@bjorn-Precision-5520>
 <20210916083042.5f63163a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916083042.5f63163a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 08:30:42AM -0700, Jakub Kicinski wrote:
> On Thu, 16 Sep 2021 10:07:07 -0500 Bjorn Helgaas wrote:
> > On Thu, Sep 16, 2021 at 06:17:39AM -0700, Jakub Kicinski wrote:
> > > My Lenovo T490s with i7-8665U had been marking TSC as unstable
> > > since v5.13, resulting in very sluggish desktop experience...  
> > 
> > Including the actual dmesg log line here might help others locate this
> > fix.
> 
> Good point, will add in v2.
> 
> clocksource: timekeeping watchdog on CPU3: hpet read-back delay of 316000ns, attempt 4, marking unstable
> tsc: Marking TSC unstable due to clocksource watchdog
> TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> sched_clock: Marking unstable (14539801827657, -530891666)<-(14539319241737, -48307500)
> clocksource: Checking clocksource tsc synchronization from CPU 3 to CPUs 0-2,6-7.
> clocksource: Switched to clocksource hpet
> 
> > > I have a 8086:3e34 bridge, also known as "Host bridge: Intel
> > > Corporation Coffee Lake HOST and DRAM Controller (rev 0c)".
> > > Add it to the list.
> > > 
> > > We should perhaps consider applying this quirk more widely.
> > > The Intel documentation does not list my device [1], but
> > > linuxhw [2] does, and it seems to list a few more bridges
> > > we do not currently cover (3e31, 3ecc, 3e35, 3e0f).  
> > 
> > In the fine tradition of:
> > 
> >   e0748539e3d5 ("x86/intel: Disable HPET on Intel Ice Lake platforms")
> >   f8edbde885bb ("x86/intel: Disable HPET on Intel Coffee Lake H platforms")
> >   fc5db58539b4 ("x86/quirks: Disable HPET on Intel Coffe Lake platforms")
> >   62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail plat form")
> > 
> > This seems to be an ongoing issue, not just a point defect in a single
> > product, and I really hate the onesy-twosy nature of this.
> 
> Indeed. Or at least cover all Coffee Lakes in one fell swoop.
> 
> > Is there really no way to detect this issue automatically or fix
> > whatever Linux bug makes us trip over this?  I am no clock expert, so
> > I have absolutely no idea whether this is possible.
> 
> I'm deferring to clock experts. Paul mentioned he has some prototype
> patches that may help.
> 
> > > [1] https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/8th-gen-core-family-datasheet-vol-2.pdf
> > > [2] https://github.com/linuxhw/DevicePopulation/blob/master/README.md
> > > 
> > > Cc: stable@vger.kernel.org # v5.13+  
> > 
> > How did you pick v5.13?  force_disable_hpet() was added by
> > 62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail
> > platform"), which appeared in v3.15.
> 
> Erm, good question, it started happening for me (and others with the
> same laptop) with v5.13. I just sort of assumed it was 2e27e793e280
> ("clocksource: Reduce clocksource-skew threshold"). 
> 
> It usually takes  a day to repro (4 hours was the quickest repro I've
> seen) so bisection was kind of out of question.

OK, so this is an intermittent condition where HPET is sometimes slow to
access for a short period of time?  If that is the case, my thought is
to set the clocksource to be reinitialized (without a splat and without
marking the clocksource unstable), and to splat (and mark the clocksource
unstable) if it is not get a good read after 100 subsequent attempts.

So as long as the period of slowness lasts for less than 50 seconds,
things would work fine.

Seem reasonable?

							Thanx, Paul
