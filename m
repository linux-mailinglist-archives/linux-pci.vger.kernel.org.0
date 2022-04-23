Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAE850CB82
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiDWPEg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 11:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiDWPEe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 11:04:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B1A1668F0;
        Sat, 23 Apr 2022 08:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52267612C8;
        Sat, 23 Apr 2022 15:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BCCC385A0;
        Sat, 23 Apr 2022 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650726095;
        bh=uaq6jNypdiikbr84HxxnRbgSGuCdBE8n2XWA2kVi2Go=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j4W+UeVu3/Vi110qIfDgsZqhpYu8qMnJWI5iwdqmEpz6rWP2cQz6EBroNuEBknJSt
         Pajs7dX7YzmIgbttwC9wDbnRxYZV+ydbrIk7w/o6T8XiPN+o7fk7kKZyl6V2t8SlqS
         y2Vp0AlB/QEOBmxSznnjFkmK1SmrVmzGqvxuDu7/4C91717uTC5+JM+2VtKVYlCLoa
         GSn+cdsFeV7jmjOjLNH6WByptK7hTvUzISBNOpHmM/bpS34kwjP4y6d5i213GV86wT
         X6Ml966XTBxMhEKT4pyIyNqqu8WnOMSB8q42TueLKq1HmPXKsaikWy5t2IMnOrNibw
         xpaRC8DS/Cu/w==
Date:   Sat, 23 Apr 2022 10:01:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Jingar, Rajvi" <rajvi.jingar@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
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
Message-ID: <20220423150132.GA1552054@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB507047C0109C5163EF20D9AE9EF69@SJ0PR11MB5070.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 23, 2022 at 12:43:14AM +0000, Jingar, Rajvi wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > On Thu, Apr 14, 2022 at 07:54:02PM +0200, Rafael J. Wysocki wrote:
> > > On 3/25/2022 8:50 PM, Rajvi Jingar wrote:
> > > > For the PCIe devices (like nvme) that do not go into D3 state still need to
> > > > disable PTM on PCIe root ports to allow the port to enter a lower-power PM
> > > > state and the SoC to reach a lower-power idle state as a whole. Move the
> > > > pci_disable_ptm() out of pci_prepare_to_sleep() as this code path is not
> > > > followed for devices that do not go into D3. This patch fixes the issue
> > > > seen on Dell XPS 9300 with Ice Lake CPU and Dell Precision 5530 with Coffee
> > > > Lake CPU platforms to get improved residency in low power idle states.
> > > >
> > > > Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> > > > Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> > > > Suggested-by: David E. Box <david.e.box@linux.intel.com>
> > > > ---
> > > >   drivers/pci/pci-driver.c | 10 ++++++++++
> > > >   drivers/pci/pci.c        | 10 ----------
> > > >   2 files changed, 10 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > index 8b55a90126a2..ab733374a260 100644
> > > > --- a/drivers/pci/pci-driver.c
> > > > +++ b/drivers/pci/pci-driver.c
> > > > @@ -847,6 +847,16 @@ static int pci_pm_suspend_noirq(struct device *dev)
> > > >   	if (!pci_dev->state_saved) {
> > > >   		pci_save_state(pci_dev);
> > > > +		/*
> > > > +		 * There are systems (for example, Intel mobile chips since
> > Coffee
> > > > +		 * Lake) where the power drawn while suspended can be
> > significantly
> > > > +		 * reduced by disabling PTM on PCIe root ports as this allows the
> > > > +		 * port to enter a lower-power PM state and the SoC to reach a
> > > > +		 * lower-power idle state as a whole.
> > > > +		 */
> > > > +		if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> > > > +			pci_disable_ptm(pci_dev);
> > 
> > Why is disabling PTM dependent on pci_dev->state_saved?  The point of
> > this is to change the behavior of the device, and it seems like we
> > want to do that regardless of whether the driver has used
> > pci_save_state().
> 
> Because we use the saved state to restore PTM on the root port. 
> And it's under this condition that the root port state gets saved.

Yes, I understand that pci_restore_ptm_state() depends on a previous
call to pci_save_ptm_state().

The point I'm trying to make is that pci_disable_ptm() changes the
state of the device, and that state change should not depend on
whether the driver has used pci_save_state().

When we're putting a device into a low-power state, I think we want to
disable PTM *always*, no matter what the driver did.  And I think we
want to do it for all devices, not just Root Ports.

Bjorn
