Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7541B833B2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfHFOPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 10:15:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:6847 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732664AbfHFOPk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 10:15:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 07:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="192674660"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 06 Aug 2019 07:15:36 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 06 Aug 2019 17:15:36 +0300
Date:   Tue, 6 Aug 2019 17:15:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Matthias Andree <matthias.andree@gmx.de>
Subject: Re: [Regression] pcie_wait_for_link_delay (1132.853 ms @ 5039.414431)
Message-ID: <20190806141536.GB2548@lahna.fi.intel.com>
References: <2857501d-c167-547d-c57d-d5d24ea1f1dc@molgen.mpg.de>
 <20190806093626.GF2548@lahna.fi.intel.com>
 <acca5213-7d8b-7db1-ff3c-cb5b4a704f04@molgen.mpg.de>
 <20190806113154.GS2548@lahna.fi.intel.com>
 <f83a541d-65de-ed05-c4c1-2bda345b30ef@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f83a541d-65de-ed05-c4c1-2bda345b30ef@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 06, 2019 at 04:02:42PM +0200, Paul Menzel wrote:
> >> How can I read out the delay from the system as done in?
> > 
> > The delay is not system wide so it depends on the device. Typically it
> > is 100ms but there is a way to shorten it using ACPI _DSM.
> 
> Yeah, I know. I was wondering if it can easily be read out for a device
> under `/sys`, other debug level or, for example, with `lspci` or
> `acpidump`.

AFAIK there is no easy way at least without patching the kernel. You can
log pdev->d3cold_delay for each device in pci_pm_init() for example.

> >> ```
> >> static int get_downstream_delay(struct pci_bus *bus)
> >> {
> >>         struct pci_dev *pdev;
> >>         int min_delay = 100;
> >>         int max_delay = 0;
> >>
> >>         list_for_each_entry(pdev, &bus->devices, bus_list) {
> >>                 if (!pdev->imm_ready)
> >>                         min_delay = 0;
> >>                 else if (pdev->d3cold_delay < min_delay)
> >>                         min_delay = pdev->d3cold_delay;
> >>                 if (pdev->d3cold_delay > max_delay)
> >>                         max_delay = pdev->d3cold_delay;
> >>         }
> >>
> >>         return max(min_delay, max_delay);
> >> }
> >> ```
> >>
> >>>> Anyway, there is such firmware out there, so I’d like to avoid the time
> >>>> increases.
> >>>>
> >>>> As a first step, the commit should be extended to print a warning (maybe if
> >>>> `initcall_debug` is specified), when the delay is higher than let’s say 50(?)
> >>>> ms. Also better documentation how to debug these delays would be appreciated.
> >>
> >> As your commit message says the standard demands a delay of at least 100 ms, 50 ms
> >> is of course too short, and maybe 150 ms or so should be used as the threshold.
> >>
> >>>> If there is no easy solution, it’d be great if the commit could be reverted for
> >>>> now, and a better solution be discussed for the next release.
> >>>
> >>> There is also kernel bugzilla entry about another regression this causes
> >>> here:
> >>>
> >>>   https://bugzilla.kernel.org/show_bug.cgi?id=204413
> >>>
> >>> I agree we should revert c2bf1fc2 now. I'll try to come up alternative
> >>> solution to these missing delays that hopefully does not break existing
> >>> setups.
> >>>
> >>> Rafael, Bjorn,
> >>>
> >>> Can you revert the commit or do you want me to send a revert patch?
> >>>
> >>> Thanks and sorry about the breakage.
> >>
> >> No worries.
> > 
> > Thanks for the lspci output. This explains the 1 second delay:
> > 
> >> 		LnkCap:	Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <256ns, L1 <8us
> >> 			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
> > 
> > The port does not support active link reporting. Can you try the below
> > patch?
> > 
> > Nicholas, can you also try it? I think it should solve your issue as
> > well.
> > 
> > Thanks!
> > 
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index 308c3e0c4a34..bb8c753013d0 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -434,7 +434,8 @@ static void wait_for_downstream_link(struct pci_dev *pdev)
> >  	 * need to wait 100ms. For higher speeds (gen3) we need to wait
> >  	 * first for the data link layer to become active.
> >  	 */
> > -	if (pcie_get_speed_cap(pdev) <= PCIE_SPEED_5_0GT)
> > +	if (pcie_get_speed_cap(pdev) <= PCIE_SPEED_5_0GT ||
> > +	    !pdev->link_active_reporting)
> >  		msleep(delay);
> >  	else
> >  		pcie_wait_for_link_delay(pdev, true, delay);
> 
> I can confirm, that the delay is reduced now.
> 
>     pcieport @ 0000:00:01.0 {pcieport} async_device (Total Suspend: 12.118 ms Total Resume: 105.604 ms)

Awesome, thanks.

> How can I enable the verbose log messages you got in your commit
> message like below?
> 
>     pcieport 0000:00:1b.0: wait for 100ms after DLLLA is set before access to 0000:01:00.0

It did not come from any log message, I just wrote it like that for the
commit log.
