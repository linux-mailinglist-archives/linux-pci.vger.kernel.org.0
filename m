Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF13FE815
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2019 23:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKOWgu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 17:36:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfKOWgu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Nov 2019 17:36:50 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9655F2072A;
        Fri, 15 Nov 2019 22:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573857409;
        bh=pFHuuk1DQeNxWQLJqPfYmeXm2RCC5xYWFYPN1JIewnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IuOk2R0yvA4bLu7x4386fodrjq/8QGfNzCdXV1IDAYhv5qMPugCJcKzGKpxa1+U4S
         1EKzee7a34UdFHbVat/Ef+p12Wkx1NCrdNj1nhcttfjl1RVErE0hVguScMgHllMjfF
         LrM3CA3uwUCrA0GQHFb+RQLQ9iWDjBGKZ+tnXRyc=
Date:   Fri, 15 Nov 2019 16:36:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191115223647.GA129381@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6625491-dc02-4fdd-a748-fe0d3b573b01@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 15, 2019 at 03:34:23PM +0530, Vidya Sagar wrote:
> On 11/15/2019 12:06 AM, Bjorn Helgaas wrote:
> > On Wed, Nov 13, 2019 at 12:20:43PM +0100, Thierry Reding wrote:
> > > On Tue, Nov 12, 2019 at 12:58:44PM -0600, Bjorn Helgaas wrote:
> > >
> > > > My question is whether this wait should be connected somehow with
> > > > platform_pci_set_power_state().  It sounds like the tegra host
> > > > controller driver already does the platform-specific delays, and I'm
> > > > not sure it's reasonable for platform_pci_set_power_state() to do the
> > > > CRS polling.  Maybe something like this?  I'd really like to get
> > > > Rafael's thinking here.
> > > > 
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index e7982af9a5d8..052fa316c917 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -964,9 +964,14 @@ void pci_refresh_power_state(struct pci_dev *dev)
> > > >    */
> > > >   void pci_power_up(struct pci_dev *dev)
> > > >   {
> > > > +	pci_power_state_t prev_state = dev->current_state;
> > > > +
> > > >   	if (platform_pci_power_manageable(dev))
> > > >   		platform_pci_set_power_state(dev, PCI_D0);
> > > > +	if (prev_state == PCI_D3cold)
> > > > +		pci_dev_wait(dev, "D3cold->D0", PCIE_RESET_READY_POLL_MS);
>
> Is there any specific reason why should there be a check for the
> state?  In Tegra series, I observe that, by the time execution comes
> to this point, prev_state is PCI_D3Hot and in Tegra194 particularly,
> it is PCI_D0 because the host controller driver explicitly keeps the
> downstream devices in PCI_D0 state as a work around for one of the
> Tegra194 specific issues. 

I think you're right, we probably should not try to check "prev_state"
here because we can't rely on that being accurate.

On Tegra, I assume suspend puts the PCIe devices in D3hot, then when
we suspend the RC itself, it looks like tegra_pcie_pm_suspend()
actually turns off the power, so the PCIe devices probably go to
D3cold but nothing updates their dev->current_state, so it's probably
still PCI_D3hot.

On Tegra194, the same probably happens, except that when we suspend
the RC itself, tegra_pcie_downstream_dev_to_D0() puts the PCIe devices
back in D0 (updating their dev->current_state to PCI_D0), and then we
turn off the power, so they probably also end up in D3cold but with
dev_current_state still set to PCI_D0.

> So, I feel the check for current_state may not be need here(?)

I think you're right.  We can't tell what dev->current_state is when
we enter pci_power_up().

Bjorn
