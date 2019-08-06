Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B561E82EC5
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 11:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHFJga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 05:36:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:37925 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFJga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 05:36:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="192626592"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 06 Aug 2019 02:36:26 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 06 Aug 2019 12:36:26 +0300
Date:   Tue, 6 Aug 2019 12:36:26 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        matthias.andree@gmx.de
Subject: Re: [Regression] pcie_wait_for_link_delay (1132.853 ms @ 5039.414431)
Message-ID: <20190806093626.GF2548@lahna.fi.intel.com>
References: <2857501d-c167-547d-c57d-d5d24ea1f1dc@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2857501d-c167-547d-c57d-d5d24ea1f1dc@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Nicholas and Matthias

On Tue, Aug 06, 2019 at 11:20:37AM +0200, Paul Menzel wrote:
> Dear Mika, dear Rafael,
> 
> 
> Commit c2bf1fc2 (PCI: Add missing link delays required by the PCIe spec) [1] 
> increases the resume time from ACPI S3 on a desktop system Dell OptiPlex 5040
> by one second. It looks like this is expected from the commit message, but
> breaks existing systems with boot time requirements. I measured this with the
> help of the pm-graph script `sleepgraph.py` [2].
> 
>     0000:00:01.0 resume_noirq (1134.715 ms @ 5039.412578 to 5040.547293)
>         …
>             pcie_wait_for_link_delay (1132.853 ms @ 5039.414431)
> 
> $ lspci -nn
> 00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers [8086:191f] (rev 07)
> 00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07)
> 00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-H USB 3.0 xHCI Controller [8086:a12f] (rev 31)
> 00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-H Thermal subsystem [8086:a131] (rev 31)
> 00:16.0 Communication controller [0780]: Intel Corporation Sunrise Point-H CSME HECI #1 [8086:a13a] (rev 31)
> 00:17.0 SATA controller [0106]: Intel Corporation Sunrise Point-H SATA controller [AHCI mode] [8086:a102] (rev 31)
> 00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-H PCI Express Root Port #1 [8086:a110] (rev f1)
> 00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-H LPC Controller [8086:a146] (rev 31)
> 00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-H PMC [8086:a121] (rev 31)
> 00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-H HD Audio [8086:a170] (rev 31)
> 00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-H SMBus [8086:a123] (rev 31)
> 00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (2) I219-V [8086:15b8] (rev 31)
> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Oland XT [Radeon HD 8670 / R7 250/350] [1002:6610] (rev 81)
> 01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde/Pitcairn HDMI Audio [Radeon HD 7700/7800 Series] [1002:aab0]
> 02:00.0 PCI bridge [0604]: Texas Instruments XIO2001 PCI Express-to-PCI Bridge [104c:8240]
> 
> So, it’s about the internal Intel graphics device, which is not used on this 
> system, as there is an external AMD graphics device plugged in.
> 
> As far as I understand it, it’s a bug in the firmware, that a one second delay
> is specified?
> 
> Anyway, there is such firmware out there, so I’d like to avoid the time
> increases.
> 
> As a first step, the commit should be extended to print a warning (maybe if
> `initcall_debug` is specified), when the delay is higher than let’s say 50(?)
> ms. Also better documentation how to debug these delays would be appreciated.
> 
> If there is no easy solution, it’d be great if the commit could be reverted for
> now, and a better solution be discussed for the next release.

There is also kernel bugzilla entry about another regression this causes
here:

  https://bugzilla.kernel.org/show_bug.cgi?id=204413

I agree we should revert c2bf1fc2 now. I'll try to come up alternative
solution to these missing delays that hopefully does not break existing
setups.

Rafael, Bjorn,

Can you revert the commit or do you want me to send a revert patch?

Thanks and sorry about the breakage.
