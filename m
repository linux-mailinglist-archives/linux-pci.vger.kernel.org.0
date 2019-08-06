Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC46830B0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfHFLb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 07:31:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:62002 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729702AbfHFLb6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 07:31:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 04:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="192643060"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 06 Aug 2019 04:31:55 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 06 Aug 2019 14:31:54 +0300
Date:   Tue, 6 Aug 2019 14:31:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Matthias Andree <matthias.andree@gmx.de>
Subject: Re: [Regression] pcie_wait_for_link_delay (1132.853 ms @ 5039.414431)
Message-ID: <20190806113154.GS2548@lahna.fi.intel.com>
References: <2857501d-c167-547d-c57d-d5d24ea1f1dc@molgen.mpg.de>
 <20190806093626.GF2548@lahna.fi.intel.com>
 <acca5213-7d8b-7db1-ff3c-cb5b4a704f04@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acca5213-7d8b-7db1-ff3c-cb5b4a704f04@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 06, 2019 at 11:57:26AM +0200, Paul Menzel wrote:
> Dear Mika,
> 
> 
> Thank you for your quick reply.
> 
> 
> On 06.08.19 11:36, Mika Westerberg wrote:
> > +Nicholas and Matthias
> > 
> > On Tue, Aug 06, 2019 at 11:20:37AM +0200, Paul Menzel wrote:
> 
> >> Commit c2bf1fc2 (PCI: Add missing link delays required by the PCIe spec) [1] 
> >> increases the resume time from ACPI S3 on a desktop system Dell OptiPlex 5040
> >> by one second. It looks like this is expected from the commit message, but
> >> breaks existing systems with boot time requirements. I measured this with the
> >> help of the pm-graph script `sleepgraph.py` [2].
> >>
> >>     0000:00:01.0 resume_noirq (1134.715 ms @ 5039.412578 to 5040.547293)
> >>         …
> >>             pcie_wait_for_link_delay (1132.853 ms @ 5039.414431)
> 
> By the way, here is the trace excerpt with the interesting comments.
> 
> ```
>  5040.547284 |   1)  kworker-3594  |   1132852 us  |              } /* schedule_timeout */
>  5040.547284 |   1)  kworker-3594  |   1132853 us  |            } /* msleep */
>  5040.547284 |   1)  kworker-3594  |   1132853 us  |          } /* pcie_wait_for_link_delay */
>  5040.547284 |   1)  kworker-3594  |   1132856 us  |        } /* wait_for_downstream_link */
>  5040.547285 |   1)  kworker-3594  |               |        device_for_each_child() {
>  5040.547285 |   1)  kworker-3594  |   0.185 us    |          _raw_spin_lock_irqsave();
>  5040.547286 |   1)  kworker-3594  |   0.136 us    |          _raw_spin_unlock_irqrestore();
>  5040.547286 |   1)  kworker-3594  |   0.190 us    |          pm_iter();
>  5040.547286 |   1)  kworker-3594  |   0.129 us    |          _raw_spin_lock_irqsave();
>  5040.547287 |   1)  kworker-3594  |   0.134 us    |          _raw_spin_unlock_irqrestore();
>  5040.547287 |   1)  kworker-3594  |   0.194 us    |          pm_iter();
>  5040.547287 |   1)  kworker-3594  |   0.134 us    |          _raw_spin_lock_irqsave();
>  5040.547288 |   1)  kworker-3594  |   0.133 us    |          _raw_spin_unlock_irqrestore();
>  5040.547288 |   1)  kworker-3594  |   0.187 us    |          pm_iter();
>  5040.547288 |   1)  kworker-3594  |   0.135 us    |          _raw_spin_lock_irqsave();
>  5040.547289 |   1)  kworker-3594  |   0.135 us    |          _raw_spin_unlock_irqrestore();
>  5040.547289 |   1)  kworker-3594  |   0.271 us    |          pm_iter();
>  5040.547289 |   1)  kworker-3594  |   0.132 us    |          _raw_spin_lock_irqsave();
>  5040.547290 |   1)  kworker-3594  |   0.137 us    |          _raw_spin_unlock_irqrestore();
>  5040.547290 |   1)  kworker-3594  |   5.036 us    |        } /* device_for_each_child */
>  5040.547290 |   1)  kworker-3594  |   1132862 us  |      } /* pcie_port_device_resume_noirq */
>  5040.547290 |   1)  kworker-3594  |   1134709 us  |    } /* pci_pm_resume_noirq */
> ```
> 
> >> $ lspci -nn
> >> 00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers [8086:191f] (rev 07)
> >> 00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07)
> >> 00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-H USB 3.0 xHCI Controller [8086:a12f] (rev 31)
> >> 00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-H Thermal subsystem [8086:a131] (rev 31)
> >> 00:16.0 Communication controller [0780]: Intel Corporation Sunrise Point-H CSME HECI #1 [8086:a13a] (rev 31)
> >> 00:17.0 SATA controller [0106]: Intel Corporation Sunrise Point-H SATA controller [AHCI mode] [8086:a102] (rev 31)
> >> 00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-H PCI Express Root Port #1 [8086:a110] (rev f1)
> >> 00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-H LPC Controller [8086:a146] (rev 31)
> >> 00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-H PMC [8086:a121] (rev 31)
> >> 00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-H HD Audio [8086:a170] (rev 31)
> >> 00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-H SMBus [8086:a123] (rev 31)
> >> 00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (2) I219-V [8086:15b8] (rev 31)
> >> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Oland XT [Radeon HD 8670 / R7 250/350] [1002:6610] (rev 81)
> >> 01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde/Pitcairn HDMI Audio [Radeon HD 7700/7800 Series] [1002:aab0]
> >> 02:00.0 PCI bridge [0604]: Texas Instruments XIO2001 PCI Express-to-PCI Bridge [104c:8240]
> >>
> >> So, it’s about the internal Intel graphics device, which is not used on this 
> >> system, as there is an external AMD graphics device plugged in.
> >>
> >> As far as I understand it, it’s a bug in the firmware, that a one second delay
> >> is specified?
> 
> How can I read out the delay from the system as done in?

The delay is not system wide so it depends on the device. Typically it
is 100ms but there is a way to shorten it using ACPI _DSM.

> ```
> static int get_downstream_delay(struct pci_bus *bus)
> {
>         struct pci_dev *pdev;
>         int min_delay = 100;
>         int max_delay = 0;
> 
>         list_for_each_entry(pdev, &bus->devices, bus_list) {
>                 if (!pdev->imm_ready)
>                         min_delay = 0;
>                 else if (pdev->d3cold_delay < min_delay)
>                         min_delay = pdev->d3cold_delay;
>                 if (pdev->d3cold_delay > max_delay)
>                         max_delay = pdev->d3cold_delay;
>         }
> 
>         return max(min_delay, max_delay);
> }
> ```
> 
> >> Anyway, there is such firmware out there, so I’d like to avoid the time
> >> increases.
> >>
> >> As a first step, the commit should be extended to print a warning (maybe if
> >> `initcall_debug` is specified), when the delay is higher than let’s say 50(?)
> >> ms. Also better documentation how to debug these delays would be appreciated.
> 
> As your commit message says the standard demands a delay of at least 100 ms, 50 ms
> is of course too short, and maybe 150 ms or so should be used as the threshold.
> 
> >> If there is no easy solution, it’d be great if the commit could be reverted for
> >> now, and a better solution be discussed for the next release.
> > 
> > There is also kernel bugzilla entry about another regression this causes
> > here:
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=204413
> > 
> > I agree we should revert c2bf1fc2 now. I'll try to come up alternative
> > solution to these missing delays that hopefully does not break existing
> > setups.
> > 
> > Rafael, Bjorn,
> > 
> > Can you revert the commit or do you want me to send a revert patch?
> > 
> > Thanks and sorry about the breakage.
> 
> No worries.

Thanks for the lspci output. This explains the 1 second delay:

> 		LnkCap:	Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <256ns, L1 <8us
> 			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+

The port does not support active link reporting. Can you try the below
patch?

Nicholas, can you also try it? I think it should solve your issue as
well.

Thanks!

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 308c3e0c4a34..bb8c753013d0 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -434,7 +434,8 @@ static void wait_for_downstream_link(struct pci_dev *pdev)
 	 * need to wait 100ms. For higher speeds (gen3) we need to wait
 	 * first for the data link layer to become active.
 	 */
-	if (pcie_get_speed_cap(pdev) <= PCIE_SPEED_5_0GT)
+	if (pcie_get_speed_cap(pdev) <= PCIE_SPEED_5_0GT ||
+	    !pdev->link_active_reporting)
 		msleep(delay);
 	else
 		pcie_wait_for_link_delay(pdev, true, delay);
