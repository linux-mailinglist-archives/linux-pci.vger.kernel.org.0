Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C627FE9AD8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 12:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfJ3Ld7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 07:33:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:42159 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3Ld7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 07:33:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 04:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="211306127"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2019 04:33:53 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 30 Oct 2019 13:33:53 +0200
Date:   Wed, 30 Oct 2019 13:33:53 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add missing link delays required by the PCIe
 spec
Message-ID: <20191030113353.GY2593@lahna.fi.intel.com>
References: <20191004123947.11087-3-mika.westerberg@linux.intel.com>
 <20191029205456.GA100782@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029205456.GA100782@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 03:54:56PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 04, 2019 at 03:39:47PM +0300, Mika Westerberg wrote:
> > Currently Linux does not follow PCIe spec regarding the required delays
> > after reset. A concrete example is a Thunderbolt add-in-card that
> > consists of a PCIe switch and two PCIe endpoints:
> > ...
> 
> > @@ -1025,15 +1025,11 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
> >  	if (state == PCI_D0) {
> >  		pci_platform_power_transition(dev, PCI_D0);
> >  		/*
> > -		 * Mandatory power management transition delays, see
> > -		 * PCI Express Base Specification Revision 2.0 Section
> > -		 * 6.6.1: Conventional Reset.  Do not delay for
> > -		 * devices powered on/off by corresponding bridge,
> > -		 * because have already delayed for the bridge.
> > +		 * Mandatory power management transition delays are handled
> > +		 * in pci_pm_runtime_resume() of the corresponding
> > +		 * downstream/root port.
> >  		 */
> >  		if (dev->runtime_d3cold) {
> > -			if (dev->d3cold_delay && !dev->imm_ready)
> > -				msleep(dev->d3cold_delay);
> 
> This removes the only use of d3cold_delay.  I assume that's
> intentional?  If we no longer need it, we might as well remove it from
> the pci_dev and remove the places that set it.  It'd be nice if that
> could be a separate patch, even if we waited a little longer than
> necessary at that one bisection point.

Yes, it is intentional. In the previous version I had function
pcie_get_downstream_delay() that used both d3cold_delay and imm_ready to
calculate the downstream device delay but you said:

  I'm not sold on the idea that this delay depends on what's *below* the                                                                                                   
  bridge.  We're using sec 6.6.1 to justify the delay, and that section                                                                                               
  doesn't say anything about downstream devices.

So I dropped it and use 100 ms instead.

Now that you mention, I think if we want to continue support that _DSM,
we should still take d3cold_delay into account in this patch. There is
also one driver (drivers/mfd/intel-lpss-pci.c) that sets it to 0.

> It also removes one of the three uses of imm_ready, leaving only the
> two in FLR.  I suspect there are other places we should use imm_ready,
> e.g., transitions to/from D1 and D2, but that would be beyond the
> scope of this patch.

Right, I think imm_ready does not apply here. If I understand correctly
it is exactly for D1, D2 and D3hot transitions which we should take into
account in pci_dev_d3_sleep() (which we don't do right now).

> > +	/*
> > +	 * For PCIe downstream and root ports that do not support speeds
> > +	 * greater than 5 GT/s need to wait minimum 100 ms. For higher
> > +	 * speeds (gen3) we need to wait first for the data link layer to
> > +	 * become active.
> > +	 *
> > +	 * However, 100 ms is the minimum and the PCIe spec says the
> > +	 * software must allow at least 1s before it can determine that the
> > +	 * device that did not respond is a broken device. There is
> > +	 * evidence that 100 ms is not always enough, for example certain
> > +	 * Titan Ridge xHCI controller does not always respond to
> > +	 * configuration requests if we only wait for 100 ms (see
> > +	 * https://bugzilla.kernel.org/show_bug.cgi?id=203885).
> > +	 *
> > +	 * Therefore we wait for 100 ms and check for the device presence.
> > +	 * If it is still not present give it an additional 100 ms.
> > +	 */
> > +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> > +	    pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
> > +		return;
> 
> Shouldn't this be:
> 
>   if (!pcie_downstream_port(dev))
>     return
> 
> so we include PCI/PCI-X to PCIe bridges?

Yes, I'll change it in v3.
