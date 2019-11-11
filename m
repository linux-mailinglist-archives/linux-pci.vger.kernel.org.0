Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C9AF82E9
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 23:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKWcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 17:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKWci (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 17:32:38 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D84920659;
        Mon, 11 Nov 2019 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573511557;
        bh=6nJHdaOx51l52K83j2un8QsW4MPpN5Rp/d7y6ySsr2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k/qXTDPFNSK8ZDXI16rnOlhJC60EOlHfdE3TGJvYKN/02ZmTGggqrPwPcR91GXLs8
         tBI/isvV1LcMleEQHlaHnAgbnNniFSbYxlb+1wOaBpCgS+gUDmxcXbYkL5e7SMRdEi
         MotnVaaQyEgJ5q+w2II8TX+tU9dX4wf25Gv3Gk74=
Date:   Mon, 11 Nov 2019 16:32:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191111223235.GA38578@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f545f7-f14a-d2d9-215c-b3fb22000a5c@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 11, 2019 at 11:31:18AM +0530, Vidya Sagar wrote:
> On 11/6/2019 10:11 PM, Bjorn Helgaas wrote:

> > Based on Vidya's backtrace, I think the resume path with problems
> > is this:
> > 
> >    pci_pm_resume_noirq
> >      pci_pm_default_resume_early
> >        pci_power_up
> >          if (platform_pci_power_manageable(dev))
> >            platform_pci_set_power_state(dev, PCI_D0)  # <-- FW delay here?
> >          pci_raw_set_power_state
> >          pci_update_current_state
> >            pci_device_is_present        # <-- config read returns CRS
> > 
> > So I think your suggestion is that Vidya's firmware should be
> > doing the delay inside platform_pci_set_power_state()?
> > 
> > Vidya, you typically work on Tegra, so I assume this is on an
> > arm64 system?  Does it have ACPI?  Do you have access to the
> > firmware developers to ask about who they expect to do the delays?
>
> Yes. This is on arm64 (Tegra) and we don't have any ACPI or any
> other firmware for that matter. PCIe is brought up directly in the
> kernel.

I assume that your device is coming out of D3cold because apparently
you're seeing a CRS status from the config read when
pci_update_current_state() calls pci_device_is_present().  CRS status
should only happen after reset or power-on from D3cold, and you're not
doing a reset.

I'm pretty sure platform_pci_power_manageable() returns false on
your system (can you confirm that?) because the only scenarios with
platform power management are MID (Intel platform) and ACPI (which you
don't have).

Maybe you have some other platform-specific mechanism that controls
power to PCI devices, and it's not integrated into the
platform_pci_*() framework?

Bjorn
