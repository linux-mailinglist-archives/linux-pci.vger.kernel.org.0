Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3E50E850
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 20:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244394AbiDYSgB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 14:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiDYSgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 14:36:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CAEBEF;
        Mon, 25 Apr 2022 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650911575; x=1682447575;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmlGUQOKfZ1fEEUeDa+ZjhpmUMMaxIHAYo6P39XG2Tc=;
  b=OaTAtKKWsu0M7SZbE71kujYeNgCCCoi5MwKrNFsKeuUjG0/d67aH1JnE
   u47tfpk28HCmx/RldGmI4bBo42+sKv9it27jumXFi1zg0SZmd9NvqdayW
   GK79fiknh7KQThRik6NTW1v6FzrstV5KwkHq6CmrmH5BCLKeDi9D4YAic
   yVt2Iy+pfrxuUOP51+G2FDhpUbIRLdzeVmIYJJzOi2zK+S1hhvkqJ6ssJ
   sCXO08nfY3Mejw9Ws5wp1m6/7Lb8i332YeAN7HWwXWX000sy/i1VIeNZY
   F9gc3W4jBXQLBY/ndx3h3e1+yNqoWkLGJwwRS9QuZnsr2ydhlhhItmDjh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="262929321"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="262929321"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="532246106"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 25 Apr 2022 11:32:55 -0700
Received: from jiunhong-mobl.amr.corp.intel.com (unknown [10.209.83.58])
        by linux.intel.com (Postfix) with ESMTP id C001B5809EB;
        Mon, 25 Apr 2022 11:32:54 -0700 (PDT)
Message-ID: <44ebf450aa3300e02aba6ec009d8bea20c0fc535.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Jingar, Rajvi" <rajvi.jingar@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
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
Date:   Mon, 25 Apr 2022 11:32:54 -0700
In-Reply-To: <20220423150132.GA1552054@bhelgaas>
References: <20220423150132.GA1552054@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2022-04-23 at 10:01 -0500, Bjorn Helgaas wrote:
> On Sat, Apr 23, 2022 at 12:43:14AM +0000, Jingar, Rajvi wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > On Thu, Apr 14, 2022 at 07:54:02PM +0200, Rafael J. Wysocki wrote:
> > > > On 3/25/2022 8:50 PM, Rajvi Jingar wrote:
> > > > > For the PCIe devices (like nvme) that do not go into D3 state still
> > > > > need to
> > > > > disable PTM on PCIe root ports to allow the port to enter a lower-
> > > > > power PM
> > > > > state and the SoC to reach a lower-power idle state as a whole. Move
> > > > > the
> > > > > pci_disable_ptm() out of pci_prepare_to_sleep() as this code path is
> > > > > not
> > > > > followed for devices that do not go into D3. This patch fixes the
> > > > > issue
> > > > > seen on Dell XPS 9300 with Ice Lake CPU and Dell Precision 5530 with
> > > > > Coffee
> > > > > Lake CPU platforms to get improved residency in low power idle states.
> > > > > 
> > > > > Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> > > > > Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> > > > > Suggested-by: David E. Box <david.e.box@linux.intel.com>
> > > > > ---
> > > > >   drivers/pci/pci-driver.c | 10 ++++++++++
> > > > >   drivers/pci/pci.c        | 10 ----------
> > > > >   2 files changed, 10 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > > index 8b55a90126a2..ab733374a260 100644
> > > > > --- a/drivers/pci/pci-driver.c
> > > > > +++ b/drivers/pci/pci-driver.c
> > > > > @@ -847,6 +847,16 @@ static int pci_pm_suspend_noirq(struct device
> > > > > *dev)
> > > > >   	if (!pci_dev->state_saved) {
> > > > >   		pci_save_state(pci_dev);
> > > > > +		/*
> > > > > +		 * There are systems (for example, Intel mobile chips
> > > > > since
> > > Coffee
> > > > > +		 * Lake) where the power drawn while suspended can be
> > > significantly
> > > > > +		 * reduced by disabling PTM on PCIe root ports as this
> > > > > allows the
> > > > > +		 * port to enter a lower-power PM state and the SoC to
> > > > > reach a
> > > > > +		 * lower-power idle state as a whole.
> > > > > +		 */
> > > > > +		if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> > > > > +			pci_disable_ptm(pci_dev);
> > > 
> > > Why is disabling PTM dependent on pci_dev->state_saved?  The point of
> > > this is to change the behavior of the device, and it seems like we
> > > want to do that regardless of whether the driver has used
> > > pci_save_state().
> > 
> > Because we use the saved state to restore PTM on the root port. 
> > And it's under this condition that the root port state gets saved.
> 
> Yes, I understand that pci_restore_ptm_state() depends on a previous
> call to pci_save_ptm_state().
> 
> The point I'm trying to make is that pci_disable_ptm() changes the
> state of the device, and that state change should not depend on
> whether the driver has used pci_save_state().

We do it here because D3 depends on whether the device state was saved by the
driver.

	if (!pci_dev->state_saved) {
        	pci_save_state(pci_dev);

		/* disable PTM here */

		if (pci_power_manageable(pci_dev))
			pci_prepare_to_sleep(pci_dev);
	}


If we disable PTM before the check, we will have saved "PTM disabled" as the
restore state. And we can't do it after the check as the device will be in D3.

As to disabling PTM on all devices, I see no problem with this, but the
reasoning is different. We disabled the root port PTM for power savings.


David

> 
> When we're putting a device into a low-power state, I think we want to
> disable PTM *always*, no matter what the driver did.  And I think we
> want to do it for all devices, not just Root Ports.
> 
> Bjorn

