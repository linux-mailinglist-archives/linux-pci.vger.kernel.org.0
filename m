Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B28F0182A6B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 09:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbgCLIEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 04:04:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:9243 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387930AbgCLIEp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 04:04:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:04:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="354073180"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2020 01:04:25 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 12 Mar 2020 10:04:24 +0200
Date:   Thu, 12 Mar 2020 10:04:24 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip link training delay for S3 resume
Message-ID: <20200312080424.GH2540@lahna.fi.intel.com>
References: <20200311045249.5200-1-kai.heng.feng@canonical.com>
 <20200311102811.GA2540@lahna.fi.intel.com>
 <2C20385C-4BA4-4D6D-935A-AFDB97FAB5ED@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2C20385C-4BA4-4D6D-935A-AFDB97FAB5ED@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 12:23:46PM +0800, Kai-Heng Feng wrote:
> Hi,
> 
> > On Mar 11, 2020, at 18:28, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > 
> > Hi,
> > 
> > On Wed, Mar 11, 2020 at 12:52:49PM +0800, Kai-Heng Feng wrote:
> >> Commit ad9001f2f411 ("PCI/PM: Add missing link delays required by the
> >> PCIe spec") added a 1100ms delay on resume for bridges that don't
> >> support Link Active Reporting.
> >> 
> >> The commit also states that the delay can be skipped for S3, as the
> >> firmware should already handled the case for us.
> > 
> > Delay can be skipped if the firmware provides _DSM with function 8
> > implemented according to PCI firmwre spec 3.2 sec 4.6.8.
> 
> As someone who doesn't have access to the PCI spec...
> Questions below.
> 
> > 
> >> So let's skip the link training delay for S3, to save 1100ms resume
> >> time.
> >> 
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/pci/pci-driver.c | 3 ++-
> >> 1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >> index 0454ca0e4e3f..3050375bad04 100644
> >> --- a/drivers/pci/pci-driver.c
> >> +++ b/drivers/pci/pci-driver.c
> >> @@ -916,7 +916,8 @@ static int pci_pm_resume_noirq(struct device *dev)
> >> 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
> >> 	pcie_pme_root_status_cleanup(pci_dev);
> >> 
> >> -	if (!skip_bus_pm && prev_state == PCI_D3cold)
> >> +	if (!skip_bus_pm && prev_state == PCI_D3cold
> >> +	    && !pm_resume_via_firmware())
> > 
> > So this would need to check for the _DSM result as well. We do evaluate
> > it in pci_acpi_optimize_delay() (drivers/pci/pci-acpi.c) and that ends
> > up lowering ->d3cold_delay so maybe check that here.
> 
> Do we need to wait for d3cold_delay here?
> Or we can also skip that as long as pci_acpi_dsm_guid and FUNCTION_DELAY_DSM present?

Actually I think pci_bridge_wait_for_secondary_bus() already takes it
into account. Have you checked if the BIOS has this _DSM implemented in
the first place?
