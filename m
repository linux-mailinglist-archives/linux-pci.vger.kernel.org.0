Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97867EFDC7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 13:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbfKEM6Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 07:58:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:58347 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388008AbfKEM6Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 07:58:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 04:58:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="212536444"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 Nov 2019 04:58:18 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Nov 2019 14:58:18 +0200
Date:   Tue, 5 Nov 2019 14:58:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add missing link delays required by the PCIe
 spec
Message-ID: <20191105125818.GW2552@lahna.fi.intel.com>
References: <20191101111918.GL2593@lahna.fi.intel.com>
 <20191105000000.GA126282@google.com>
 <20191105095428.GR2552@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105095428.GR2552@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 11:54:33AM +0200, Mika Westerberg wrote:
> > For understandability, I think the wait needs to go in some function
> > that contains "PCI_D0", e.g., platform_pci_set_power_state() or
> > pci_power_up(), so it's connected with the transition from D3cold to
> > D0.
> > 
> > Since pci_pm_default_resume_early() is the only caller of
> > pci_power_up(), maybe we should just inline pci_power_up(), e.g.,
> > something like this:
> > 
> >   static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
> >   {
> >     pci_power_state_t prev_state = pci_dev->current_state;
> > 
> >     if (platform_pci_power_manageable(pci_dev))
> >       platform_pci_set_power_state(pci_dev, PCI_D0);
> > 
> >     pci_raw_set_power_state(pci_dev, PCI_D0);
> >     pci_update_current_state(pci_dev, PCI_D0);
> > 
> >     pci_restore_state(pci_dev);
> >     pci_pme_restore(pci_dev);
> > 
> >     if (prev_state == PCI_D3cold)
> >       pci_bridge_wait_for_secondary_bus(dev);
> >   }
> 
> OK, I'll see if this works.

Well, I think we want to execute pci_fixup_resume_early before we delay
for the downstream component (same for runtime resume path). Currently
nobody is using that for root/downstream ports but in theory at least
some port may need it before it works properly. Also probably good idea
to disable wake as soon as possible to avoid possible extra PME messages
coming from the port.

I feel that the following is the right place to perform the delay but if
you think we can ignore the above, I will just do what you say and do it
in pci_pm_default_resume_early() (and pci_restore_standard_config() for
runtime path).

[The below diff does not have check for pci_dev->skip_bus_pm because I
 was planning to move it inside pci_bridge_wait_for_secondary_bus() itself.]

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 08d3bdbc8c04..3c0e52aaef79 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -890,6 +890,7 @@ static int pci_pm_resume_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t prev_state = pci_dev->current_state;
 
 	if (dev_pm_may_skip_resume(dev))
 		return 0;
@@ -914,6 +915,9 @@ static int pci_pm_resume_noirq(struct device *dev)
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 	pcie_pme_root_status_cleanup(pci_dev);
 
+	if (prev_state == PCI_D3cold)
+		pci_bridge_wait_for_secondary_bus(pci_dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
 
@@ -1299,6 +1303,7 @@ static int pci_pm_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t prev_state = pci_dev->current_state;
 	int error = 0;
 
 	/*
@@ -1314,6 +1319,9 @@ static int pci_pm_runtime_resume(struct device *dev)
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 	pci_pm_default_resume(pci_dev);
 
+	if (prev_state == PCI_D3cold)
+		pci_bridge_wait_for_secondary_bus(pci_dev);
+
 	if (pm && pm->runtime_resume)
 		error = pm->runtime_resume(dev);
 
