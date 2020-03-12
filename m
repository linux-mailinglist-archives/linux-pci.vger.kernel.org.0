Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC26182D0F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 11:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCLKIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 06:08:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:27100 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLKIw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 06:08:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 03:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="354095719"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2020 03:08:45 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 12 Mar 2020 12:08:44 +0200
Date:   Thu, 12 Mar 2020 12:08:44 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip link training delay for S3 resume
Message-ID: <20200312100844.GR2540@lahna.fi.intel.com>
References: <20200311045249.5200-1-kai.heng.feng@canonical.com>
 <20200311102811.GA2540@lahna.fi.intel.com>
 <2C20385C-4BA4-4D6D-935A-AFDB97FAB5ED@canonical.com>
 <20200312080424.GH2540@lahna.fi.intel.com>
 <ABD5242B-E118-4811-AA8A-DF7C2A3B2E8B@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ABD5242B-E118-4811-AA8A-DF7C2A3B2E8B@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 05:45:32PM +0800, Kai-Heng Feng wrote:
> 
> 
> > On Mar 12, 2020, at 16:04, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > 
> > On Thu, Mar 12, 2020 at 12:23:46PM +0800, Kai-Heng Feng wrote:
> >> Hi,
> >> 
> >>> On Mar 11, 2020, at 18:28, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> >>> 
> >>> Hi,
> >>> 
> >>> On Wed, Mar 11, 2020 at 12:52:49PM +0800, Kai-Heng Feng wrote:
> >>>> Commit ad9001f2f411 ("PCI/PM: Add missing link delays required by the
> >>>> PCIe spec") added a 1100ms delay on resume for bridges that don't
> >>>> support Link Active Reporting.
> >>>> 
> >>>> The commit also states that the delay can be skipped for S3, as the
> >>>> firmware should already handled the case for us.
> >>> 
> >>> Delay can be skipped if the firmware provides _DSM with function 8
> >>> implemented according to PCI firmwre spec 3.2 sec 4.6.8.
> >> 
> >> As someone who doesn't have access to the PCI spec...
> >> Questions below.
> >> 
> >>> 
> >>>> So let's skip the link training delay for S3, to save 1100ms resume
> >>>> time.
> >>>> 
> >>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>> ---
> >>>> drivers/pci/pci-driver.c | 3 ++-
> >>>> 1 file changed, 2 insertions(+), 1 deletion(-)
> >>>> 
> >>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >>>> index 0454ca0e4e3f..3050375bad04 100644
> >>>> --- a/drivers/pci/pci-driver.c
> >>>> +++ b/drivers/pci/pci-driver.c
> >>>> @@ -916,7 +916,8 @@ static int pci_pm_resume_noirq(struct device *dev)
> >>>> 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
> >>>> 	pcie_pme_root_status_cleanup(pci_dev);
> >>>> 
> >>>> -	if (!skip_bus_pm && prev_state == PCI_D3cold)
> >>>> +	if (!skip_bus_pm && prev_state == PCI_D3cold
> >>>> +	    && !pm_resume_via_firmware())
> >>> 
> >>> So this would need to check for the _DSM result as well. We do evaluate
> >>> it in pci_acpi_optimize_delay() (drivers/pci/pci-acpi.c) and that ends
> >>> up lowering ->d3cold_delay so maybe check that here.
> >> 
> >> Do we need to wait for d3cold_delay here?
> >> Or we can also skip that as long as pci_acpi_dsm_guid and FUNCTION_DELAY_DSM present?
> > 
> > Actually I think pci_bridge_wait_for_secondary_bus() already takes it
> > into account. Have you checked if the BIOS has this _DSM implemented in
> > the first place?
> 
> -[0000:00]-+-00.0  Intel Corporation Device 9b44
>            +-1c.0-[03-3b]----00.0-[04-3b]--+-00.0-[05]----00.0  Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 2C 2018]
>            |                               +-01.0-[06-3a]--
>            |                               \-02.0-[3b]----00.0  Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 2C 2018]
> 
> 00:1c.0 has _DSM implemented.
> How do I check for the Thunderbolt device?

Most likely you see it only under the root port (1c.0) so check
/sys/bus/pci/devices/0000:00:1c.0/firmware_node/path and match that one
to the ACPI tables.

> It doesn't seem to have a fixed _ADR so I don't know how to locate it in DSDT/SSDT table.
> 
> Log with additional debug message:
> [  948.813025] ACPI: EC: interrupt unblocked
> [  948.925017] pcieport 0000:00:01.0: pcie_wait_for_link_delay sleep 1100ms
> [  949.065466] pcieport 0000:04:00.0: pcie_wait_for_link_delay sleep 1100ms
> [  949.065468] pcieport 0000:04:02.0: pcie_wait_for_link_delay sleep 1100ms
> 
> 00:01.0 is the port for discrete graphics.

There is something wrong somewhere because the 1100ms sleep is totally
not expected to happen, but I think this is the same issue that we
discuss on another thread so let's use that thread instead to avoid
confusion :)
