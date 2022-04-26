Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7195104A4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 18:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353570AbiDZQzf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 12:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353732AbiDZQy2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 12:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF16C21803;
        Tue, 26 Apr 2022 09:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4B860F2E;
        Tue, 26 Apr 2022 16:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2946C385A4;
        Tue, 26 Apr 2022 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650991833;
        bh=d+I84Q1PYqLr/ykJNwwHSQgjeeZM+iYFOcHNWTpzypU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UrLDJh26RraUwH13/R1gNmjzfYhu1mrVXQpGOX1RI+bJmLiUcaty5XxwhJRKkyJiA
         ZmqUp2naP1YHzEjq3AmOlJe9n9UN9fpY/53kqKWX1NGRMlub3niSuvw3CvT5GYk6I4
         r2bx52e92hwX2ORN37OADnM9IRKGEjwqXLKfacGMrUba3Bp8huhNBbnaKCgLjn7BSp
         UQg6a2P3Ya3/6CiAvobeckJdLOWjApF/nekL40ueij8tsiiE/H0ZK/7Spsf4lb1dCA
         TxTBsKMSZx4d7Jcm44l/E957B4SJSeVY56JIG4+ALrdAfn5tYzKsgJMbA5XmXBEZYK
         OPROa5rg9XX8g==
Date:   Tue, 26 Apr 2022 11:50:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
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
Subject: Re: [PATCH v4 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
Message-ID: <20220426165031.GA1731758@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ebf450aa3300e02aba6ec009d8bea20c0fc535.camel@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 25, 2022 at 11:32:54AM -0700, David E. Box wrote:
> On Sat, 2022-04-23 at 10:01 -0500, Bjorn Helgaas wrote:
> > On Sat, Apr 23, 2022 at 12:43:14AM +0000, Jingar, Rajvi wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > On Thu, Apr 14, 2022 at 07:54:02PM +0200, Rafael J. Wysocki wrote:
> > > > > On 3/25/2022 8:50 PM, Rajvi Jingar wrote:
> > > > > > For the PCIe devices (like nvme) that do not go into D3 state still
> > > > > > need to
> > > > > > disable PTM on PCIe root ports to allow the port to enter a lower-
> > > > > > power PM
> > > > > > state and the SoC to reach a lower-power idle state as a whole. Move
> > > > > > the
> > > > > > pci_disable_ptm() out of pci_prepare_to_sleep() as this code path is
> > > > > > not
> > > > > > followed for devices that do not go into D3. This patch fixes the
> > > > > > issue
> > > > > > seen on Dell XPS 9300 with Ice Lake CPU and Dell Precision 5530 with
> > > > > > Coffee
> > > > > > Lake CPU platforms to get improved residency in low power idle states.
> > > > > > 
> > > > > > Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> > > > > > Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> > > > > > Suggested-by: David E. Box <david.e.box@linux.intel.com>
> > > > > > ---
> > > > > >   drivers/pci/pci-driver.c | 10 ++++++++++
> > > > > >   drivers/pci/pci.c        | 10 ----------
> > > > > >   2 files changed, 10 insertions(+), 10 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > > > index 8b55a90126a2..ab733374a260 100644
> > > > > > --- a/drivers/pci/pci-driver.c
> > > > > > +++ b/drivers/pci/pci-driver.c
> > > > > > @@ -847,6 +847,16 @@ static int pci_pm_suspend_noirq(struct device
> > > > > > *dev)
> > > > > >   	if (!pci_dev->state_saved) {
> > > > > >   		pci_save_state(pci_dev);
> > > > > > +		/*
> > > > > > +		 * There are systems (for example, Intel mobile chips
> > > > > > since
> > > > Coffee
> > > > > > +		 * Lake) where the power drawn while suspended can be
> > > > significantly
> > > > > > +		 * reduced by disabling PTM on PCIe root ports as this
> > > > > > allows the
> > > > > > +		 * port to enter a lower-power PM state and the SoC to
> > > > > > reach a
> > > > > > +		 * lower-power idle state as a whole.
> > > > > > +		 */
> > > > > > +		if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> > > > > > +			pci_disable_ptm(pci_dev);
> > > > 
> > > > Why is disabling PTM dependent on pci_dev->state_saved?  The
> > > > point of this is to change the behavior of the device, and it
> > > > seems like we want to do that regardless of whether the driver
> > > > has used pci_save_state().
> > > 
> > > Because we use the saved state to restore PTM on the root port.
> > > And it's under this condition that the root port state gets
> > > saved.
> > 
> > Yes, I understand that pci_restore_ptm_state() depends on a
> > previous call to pci_save_ptm_state().
> > 
> > The point I'm trying to make is that pci_disable_ptm() changes the
> > state of the device, and that state change should not depend on
> > whether the driver has used pci_save_state().
> 
> We do it here because D3 depends on whether the device state was
> saved by the driver.
> 
> 	if (!pci_dev->state_saved) {
>         	pci_save_state(pci_dev);
> 
> 		/* disable PTM here */
> 
> 		if (pci_power_manageable(pci_dev))
> 			pci_prepare_to_sleep(pci_dev);
> 	}
> 
> 
> If we disable PTM before the check, we will have saved "PTM
> disabled" as the restore state. And we can't do it after the check
> as the device will be in D3.

Are you suggesting that PTM should be left enabled if the driver
called pci_save_state(), but disabled otherwise?  I don't see the
rationale for that.

I don't understand all the paths through pci_pm_suspend_noirq() (e.g.,
skip_bus_pm), but for this one, I think we could do something like
this:

  driver_saved = pci_dev->state_saved;
  if (!driver_saved)
    pci_save_state(pci_dev);

  pci_disable_ptm(pci_dev);

  if (!driver_saved) {
    if (pci_power_manageable(pci_dev))
      pci_prepare_to_sleep(pci_dev);
  }

Or I guess one could argue that a driver calling pci_save_state() is
implicitly taking responsibility for all PCI-related suspend work, and
it should be disabling PTM itself.  But that doesn't really seem
maintainable.

> As to disabling PTM on all devices, I see no problem with this, but the
> reasoning is different. We disabled the root port PTM for power savings.

The power saving is good.  I'm trying to make the argument that we
need to disable PTM on all devices for correctness.

If we disable PTM on the root port, are we guaranteed that it will
never receive a PTM Request from a downstream device?  Per PCIe r6.0,
sec 6.21.3, such a request would cause an Unsupported Request error.

I sort of expect that if we're putting a root port in a low-power
state, all downstream devices are already in the same or a lower-power
state (but I don't understand PM well enough to be confident).

And I don't really *expect* devices in a low-power state to generate
PTM Requests, but I haven't seen anything in the spec that prohibits
it.

This leads me to believe that if we disable PTM in a root port, we
must first disable PTM in any downstream devices.  Otherwise, the root
port may log UR errors if the downstream device issues a PTM Request.

> > When we're putting a device into a low-power state, I think we want to
> > disable PTM *always*, no matter what the driver did.  And I think we
> > want to do it for all devices, not just Root Ports.
> > 
> > Bjorn
> 
