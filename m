Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7B4BA1B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFSNiT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 09:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFSNiT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 09:38:19 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DEDD21670;
        Wed, 19 Jun 2019 13:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560951498;
        bh=KJcUw/bebtq9I++ah6a4S/3OIf7LqrHtimCrkZ/wWK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wIFQ/Xt1OlABjDVNle4WZFATIxlHnOYobfhKB2GyKvKmPE375fctw17lUNdiT5vq5
         NWaJ8We+ylYcNNbSA56BElUXBi5hsUDw90b4Hw4Q+/0Xd7ce/xEpXxjRDlcW5iGeKf
         0gQKzQcMXHwoZ9dGDLCOGd0Do+Mug3ttP538pUiU=
Date:   Wed, 19 Jun 2019 08:38:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190619133817.GA143205@google.com>
References: <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
 <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
 <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
 <20190613154250.GA32713@ulmo>
 <a523a19c-fdfa-01f7-6f6d-2ca367a10a50@nvidia.com>
 <20190617114745.GL508@ulmo>
 <20190617193024.GC13533@google.com>
 <a7e0472d-f4a7-ed63-836a-b5e8b1360645@nvidia.com>
 <20190618104918.GA28892@ulmo>
 <9c0fb01f0dc6a193265297eaa100a35ff25413e7.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0fb01f0dc6a193265297eaa100a35ff25413e7.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 02:32:59PM +0200, Johannes Berg wrote:
> On Tue, 2019-06-18 at 12:49 +0200, Thierry Reding wrote:
> 
> > > > > > > > > > 1. WiFi devices provides power-off feature for power saving
> > > > > > > > > > in mobiles.  When WiFi is turned off we shouldn't power on
> > > > > > > > > > the HW back without user turning it back on.
> 
> But why would you disconnect the PCIe device just to power it down?!
> 
> > > > > > > The problem that Manikanta is trying to solve here occurs in
> > > > > > > this situation (Manikanta, correct me if I've got this wrong):
> > > > > > > on some setups, a WiFi module connected over PCI will toggle a
> > > > > > > power GPIO as part of runtime suspend. This effectively causes
> > > > > > > the module to disappear from the PCI bus (i.e. it can no longer
> > > > > > > be accessed until the power GPIO is toggled again).
> > > > > > 
> > > > > > GPIO is toggled as part of WiFi on/off, can be triggered from
> > > > > > network manager UI.
> 
> That's kinda icky, IMHO.
> 
> > > > > > Correct, rfkill switch should handle the GPIO.
> > > > > > Sequence will be,
> > > > > >  - WiFi ON
> > > > > >    - rfkill switch enables the WiFi GPIO
> > > > > >    - Tegra PCIe receives hot plug event
> > > > > >    - Tegra PCIe hot plug driver rescans PCI bus and enumerates the device
> > > > > >    - PCI client driver is probed, which will create network interface
> > > > > >  - WiFi OFF
> > > > > >    - rfkill switch disables the WiFi GPIO
> > > > > >    - Tegra PCIe receives hot unplug event
> > > > > >    - Tegra PCIe hot plug driver removes PCI devices under the bus
> > > > > >    - PCI client driver remove is executed, which will remove
> > > > > >      network interface
> > > > > > We don't need current patch in this case because PCI device is not
> > > > > > present in the PCI hierarchy, so there cannot be EP config access
> > > > > > with link down.  However Tegra doesn't support hot plug and unplug
> > > > > > events. I am not sure if we have any software based hot plug event
> > > > > > trigger.
> 
> Looks reasonable to me.
> 
> I guess if you absolutely know in software when the device is
> present or not, you don't need "real" PCIe hotplug, just need to
> tickle the software right?
> 
> > > > How does rfkill work?  It sounds like it completely removes
> > > > power from the wifi device, putting it in D3cold.  Is there
> > > > any software notification other than the "Slot present pin
> > > > change" (which looks like a Tegra-specific thing)?
> 
> Well, they said above it's a GPIO that controls it, so the software
> already knows and doesn't really need an event?

Forgive my ignorance about rfkill.  At least in this Tegra case, it
sounds like rfkill basically controls a power switch for the entire
device, i.e., it doesn't merely turn off the radio portion of the
device; it puts the entire PCI device in D3cold.

Is rfkill integrated with the power management subsystem?  E.g., when
lspci or X tries to read config space via pci_read_config(), does the
pci_config_pm_runtime_get() in that path wake up the device?

IMO, if the struct pci_dev exists, we should be able to rely on the
device actually being accessible (possibly after bringing it back to
D0).  If rfkill only turns off the radio, leaving the PCI interface
active, that would be fine -- in that case generic PCI things like
lspci would work normally and it would be up to the driver to manage
network-related things.

But if rfkill turns off PCI interface and the power management
subsystem can't wake it up, I think we should unbind the driver and
remove the pci_dev, so it wouldn't appear in lspci at all.

Bjorn
