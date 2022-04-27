Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F6F510FEA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 06:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357637AbiD0EZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 00:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiD0EZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 00:25:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D25013CDB;
        Tue, 26 Apr 2022 21:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651033366; x=1682569366;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CWasAYxrQPq1jPx4H4LOu7butVeeUPTCdbMjR9mVIsM=;
  b=Ym3nUC9zgXbMPQ6Vrhy0lXU0epPAbCFxE2HxUV+cEXKkzmxjBjjefj4D
   6sXyLGeOR8BEEjaI7D71QolDqLItssPc8OcCr763ghtnvMrRP2D6EHDNS
   pKkDzVRlee1Tii0rQeHLWjEfU6WpfT1oE3DCWyFOzwpkFdpKOpJ5PnDX5
   T8E4e9+pLruyB1A7FYrXJt78wD1159MjTvH26Sx+62t/3yasjCDC+dMQD
   n8pS/EAY0pf0Vz3Zings1toW83t58k0re4zZGIZC3hFsCxKsS7G0ztRB3
   lElW2rlVyULBfceaGjUbAEWi7w8609ubaQYzsfSN+2+klgtZNUtfwd9u0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="290957547"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="290957547"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 21:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="679847763"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 26 Apr 2022 21:22:45 -0700
Received: from fyang16-mobl1.amr.corp.intel.com (unknown [10.209.85.115])
        by linux.intel.com (Postfix) with ESMTP id 380C7580689;
        Tue, 26 Apr 2022 21:22:45 -0700 (PDT)
Message-ID: <15876cf0cf8c1b158397f1a17f52938a6c633b48.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Jingar, Rajvi" <rajvi.jingar@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "koba.ko@canonical.com" <koba.ko@canonical.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date:   Tue, 26 Apr 2022 21:22:44 -0700
In-Reply-To: <20220426165031.GA1731758@bhelgaas>
References: <20220426165031.GA1731758@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2022-04-26 at 11:50 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 25, 2022 at 11:32:54AM -0700, David E. Box wrote:
> > On Sat, 2022-04-23 at 10:01 -0500, Bjorn Helgaas wrote:
> > > On Sat, Apr 23, 2022 at 12:43:14AM +0000, Jingar, Rajvi wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > On Thu, Apr 14, 2022 at 07:54:02PM +0200, Rafael J. Wysocki wrote:
> > > > > > On 3/25/2022 8:50 PM, Rajvi Jingar wrote:
> > > > > > > For the PCIe devices (like nvme) that do not go into D3 state
> > > > > > > still
> > > > > > > need to
> > > > > > > disable PTM on PCIe root ports to allow the port to enter a lower-
> > > > > > > power PM
> > > > > > > state and the SoC to reach a lower-power idle state as a whole.
> > > > > > > Move
> > > > > > > the
> > > > > > > pci_disable_ptm() out of pci_prepare_to_sleep() as this code path
> > > > > > > is
> > > > > > > not
> > > > > > > followed for devices that do not go into D3. This patch fixes the
> > > > > > > issue
> > > > > > > seen on Dell XPS 9300 with Ice Lake CPU and Dell Precision 5530
> > > > > > > with
> > > > > > > Coffee
> > > > > > > Lake CPU platforms to get improved residency in low power idle
> > > > > > > states.
> > > > > > > 
> > > > > > > Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save
> > > > > > > power")
> > > > > > > Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> > > > > > > Suggested-by: David E. Box <david.e.box@linux.intel.com>
> > > > > > > ---
> > > > > > >   drivers/pci/pci-driver.c | 10 ++++++++++
> > > > > > >   drivers/pci/pci.c        | 10 ----------
> > > > > > >   2 files changed, 10 insertions(+), 10 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > > > > index 8b55a90126a2..ab733374a260 100644
> > > > > > > --- a/drivers/pci/pci-driver.c
> > > > > > > +++ b/drivers/pci/pci-driver.c
> > > > > > > @@ -847,6 +847,16 @@ static int pci_pm_suspend_noirq(struct device
> > > > > > > *dev)
> > > > > > >   	if (!pci_dev->state_saved) {
> > > > > > >   		pci_save_state(pci_dev);
> > > > > > > +		/*
> > > > > > > +		 * There are systems (for example, Intel mobile chips
> > > > > > > since
> > > > > Coffee
> > > > > > > +		 * Lake) where the power drawn while suspended can be
> > > > > significantly
> > > > > > > +		 * reduced by disabling PTM on PCIe root ports as this
> > > > > > > allows the
> > > > > > > +		 * port to enter a lower-power PM state and the SoC to
> > > > > > > reach a
> > > > > > > +		 * lower-power idle state as a whole.
> > > > > > > +		 */
> > > > > > > +		if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> > > > > > > +			pci_disable_ptm(pci_dev);
> > > > > 
> > > > > Why is disabling PTM dependent on pci_dev->state_saved?  The
> > > > > point of this is to change the behavior of the device, and it
> > > > > seems like we want to do that regardless of whether the driver
> > > > > has used pci_save_state().
> > > > 
> > > > Because we use the saved state to restore PTM on the root port.
> > > > And it's under this condition that the root port state gets
> > > > saved.
> > > 
> > > Yes, I understand that pci_restore_ptm_state() depends on a
> > > previous call to pci_save_ptm_state().
> > > 
> > > The point I'm trying to make is that pci_disable_ptm() changes the
> > > state of the device, and that state change should not depend on
> > > whether the driver has used pci_save_state().
> > 
> > We do it here because D3 depends on whether the device state was
> > saved by the driver.
> > 
> > 	if (!pci_dev->state_saved) {
> >         	pci_save_state(pci_dev);
> > 
> > 		/* disable PTM here */
> > 
> > 		if (pci_power_manageable(pci_dev))
> > 			pci_prepare_to_sleep(pci_dev);
> > 	}
> > 
> > 
> > If we disable PTM before the check, we will have saved "PTM
> > disabled" as the restore state. And we can't do it after the check
> > as the device will be in D3.
> 
> Are you suggesting that PTM should be left enabled if the driver
> called pci_save_state(), but disabled otherwise?  I don't see the
> rationale for that.

No. I was saying that because pci_power_manageable() depends on the state not
being saved, we depended on it too ...

> 
> I don't understand all the paths through pci_pm_suspend_noirq() (e.g.,
> skip_bus_pm), but for this one, I think we could do something like
> this:
> 
>   driver_saved = pci_dev->state_saved;
>   if (!driver_saved)
>     pci_save_state(pci_dev);
> 
>   pci_disable_ptm(pci_dev);
> 
>   if (!driver_saved) {
>     if (pci_power_manageable(pci_dev))
>       pci_prepare_to_sleep(pci_dev);
>   }

... but this solution gets us away from dependency. We'll make this change.

> 
> Or I guess one could argue that a driver calling pci_save_state() is
> implicitly taking responsibility for all PCI-related suspend work, and
> it should be disabling PTM itself.  But that doesn't really seem
> maintainable.
> 
> > As to disabling PTM on all devices, I see no problem with this, but the
> > reasoning is different. We disabled the root port PTM for power savings.
> 
> The power saving is good.  I'm trying to make the argument that we
> need to disable PTM on all devices for correctness.
> 
> If we disable PTM on the root port, are we guaranteed that it will
> never receive a PTM Request from a downstream device?  Per PCIe r6.0,
> sec 6.21.3, such a request would cause an Unsupported Request error.
> 
> I sort of expect that if we're putting a root port in a low-power
> state, all downstream devices are already in the same or a lower-power
> state (but I don't understand PM well enough to be confident).
> 
> And I don't really *expect* devices in a low-power state to generate
> PTM Requests, but I haven't seen anything in the spec that prohibits
> it.
> 
> This leads me to believe that if we disable PTM in a root port, we
> must first disable PTM in any downstream devices.  Otherwise, the root
> port may log UR errors if the downstream device issues a PTM Request.

I don't know that Kai-Heng's case is due to this, but it's a fair reading of the
spec that downstream devices should be disabled first. We'll change the patch to
disable PTM on all devices. Thanks.

David

> 
> > > When we're putting a device into a low-power state, I think we want to
> > > disable PTM *always*, no matter what the driver did.  And I think we
> > > want to do it for all devices, not just Root Ports.
> > > 
> > > Bjorn

