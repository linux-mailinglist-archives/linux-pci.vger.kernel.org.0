Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A374EFCDDA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 19:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfKNSgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 13:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfKNSgR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 13:36:17 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F5F20709;
        Thu, 14 Nov 2019 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573756576;
        bh=3N3ORHSWplgQB2yrSzul7TxRqWWNumXaOWA2qsRA2Og=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KYE0cTPSD86mRekB3mIYFnaoooR0S8JguMskasQI1INAUCzTP/mutf0FLqDaastzI
         VKtkPW2W7mWd5Mbpi4X1aiLoxfjxAOn9JpAqwZtyZmqskUmrIdToh7aKXWKkqjbZ8I
         +zClV+dtJrT+vG5sf2jDH+ZPG8KzCHWKvwWvasRQ=
Date:   Thu, 14 Nov 2019 12:36:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191114183612.GA215974@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113112043.GA329424@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 13, 2019 at 12:20:43PM +0100, Thierry Reding wrote:
> On Tue, Nov 12, 2019 at 12:58:44PM -0600, Bjorn Helgaas wrote:

> > My question is whether this wait should be connected somehow with
> > platform_pci_set_power_state().  It sounds like the tegra host
> > controller driver already does the platform-specific delays, and I'm
> > not sure it's reasonable for platform_pci_set_power_state() to do the
> > CRS polling.  Maybe something like this?  I'd really like to get
> > Rafael's thinking here.
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e7982af9a5d8..052fa316c917 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -964,9 +964,14 @@ void pci_refresh_power_state(struct pci_dev *dev)
> >   */
> >  void pci_power_up(struct pci_dev *dev)
> >  {
> > +	pci_power_state_t prev_state = dev->current_state;
> > +
> >  	if (platform_pci_power_manageable(dev))
> >  		platform_pci_set_power_state(dev, PCI_D0);
> >  
> > +	if (prev_state == PCI_D3cold)
> > +		pci_dev_wait(dev, "D3cold->D0", PCIE_RESET_READY_POLL_MS);
> 
> Is there any reason in particular why you chose to call pci_dev_wait()?
> It seems to me like that's a little broader than pci_bus_wait_crs(). The
> latter is static in drivers/pci/probe.c so we'd need to change that in
> order to use it from drivers/pci/pci.c, but it sounds like the more
> explicit thing to do.

Broader in what sense?  They work essentially identically except that
pci_bus_wait_crs() doesn't need a pci_dev * (because it's used during
enumeration when we don't have a pci_dev yet) and it does dword reads
instead of word reads.

It is a shame that the logic is duplicated, but we don't have to worry
about that here.

I think I would stick with pci_dev_wait() in this case since we do
have a pci_dev * and it's a little simpler, unless I'm missing the
advantage of pci_bus_wait_crs().

Bjorn
