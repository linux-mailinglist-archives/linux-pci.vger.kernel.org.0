Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C952CF418
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 19:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgLDSbf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 13:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgLDSbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 13:31:35 -0500
Date:   Fri, 4 Dec 2020 12:30:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607106654;
        bh=UuBKfwwZyUYGDB525W18eDn2DMd2HDAugInym/c7VaM=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=Twu6FxDsJ5sCFN8s0XlBosvO/6JeQbTYT9GiwnRLvHDJk+jFwg5dNGkKL/YufwpGv
         bfepItJE0XqAzgjFIg5nfo3ef0738wVtieqtdXl3XBJZWiK6OzdcWFfWEMMMZ5XEru
         QDDpTt9DZkl6OtkuSkI02r9T1yy8W0sjP+8MNqjhE9WtJ2Qiuysa5K5voDElSjrty2
         N0wzk3s19JMT3zicYFGAIKBY8Xl1r4195GNMi/VaK2bTT2RVZtf2I7s2041zdNAP0m
         +dPOtkha9DsZ1Tc9B6KBy0JMOIu942sYepSdDuWaAUeFgRnRaO9FrOqd0r+m8t2La1
         eZikW3+XEPLpw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com
Subject: Re: [v4,2/3] PCI: mediatek: Add new generation controller support
Message-ID: <20201204183052.GA1929838@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204073909.GA17699@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 04, 2020 at 08:39:09AM +0100, Lukas Wunner wrote:
> On Mon, Nov 30, 2020 at 11:30:05AM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 23, 2020 at 02:45:13PM +0800, Jianjun Wang wrote:
> > > On Thu, 2020-11-19 at 14:28 -0600, Bjorn Helgaas wrote:
> > > > > +static int mtk_pcie_setup(struct mtk_pcie_port *port)
> > > > > +{
> [...]
> > > > > +	/* Try link up */
> > > > > +	err = mtk_pcie_startup_port(port);
> > > > > +	if (err) {
> > > > > +		dev_notice(dev, "PCIe link down\n");
> > > > > +		goto err_setup;
> > > > 
> > > > Generally it should not be a fatal error if the link is not up at
> > > > probe-time.  You may be able to hot-add a device, or the device may
> > > > have some external power control that will power it up later.
> > > 
> > > This is for the power saving requirement. If there is no device
> > > connected with the PCIe slot, the PCIe MAC and PHY should be powered
> > > off.
> > > 
> > > Is there any standard flow to support power down the hardware at
> > > probe-time if no device is connected and power it up when hot-add a
> > > device?
> > 
> > That's a good question.  I assume this looks like a standard PCIe
> > hot-add event?
> > 
> > When you hot-add a device, does the Root Port generate a Presence
> > Detect Changed interrupt?  The pciehp driver should field that
> > interrupt and turn on power to the slot via the Power Controller
> > Control bit in the Slot Control register.
> > 
> > Does your hardware require something more than that to control the MAC
> > and PHY power?
> 
> Power saving of unused PCIe ports is generally achieved through the
> runtime PM framework.  When a PCIe port runtime suspends, the PCIe
> core will transition it to D3hot.  On top of that, the platform
> may be able to transition the port to D3cold.  Currently only the
> ACPI platform supports that.  Conceivably, devicetree-based systems
> may want to disable certain clocks or regulators when a PCIe port
> runtime suspends.  I think we do not support that yet but it could
> be added to drivers/pci/pcie/portdrv*.
> 
> A hotplug port is expected to signal PDC and DLLSC interrupts even
> when in D3hot.  At least that's our experience with Thunderbolt.
> To support hotplug interrupts in D3cold, some external mechanism
> (such as a PME) is necessary to wake up the port on hotplug.
> This is also supported with recent Thunderbolt systems.
> 
> Because we've seen various incompatibilities when runtime suspending
> PCIe ports, certain conditions must be satisfied for runtime PM
> to be enabled.  They're encoded in pci_bridge_d3_possible().
> Generally, hotplug ports only runtime suspend if they belong to
> a Thunderbolt controller or if the ACPI platform explicitly allows
> runtime PM (through presence of a _PR3 method or a device property).
> Non-hotplug ports runtime suspend if the BIOS is newer than 2015
> (as specified by DMI).
> 
> Obviously, this policy is very x86-focussed because both Thunderbolt
> and DMI are only really a thing on x86.  That's about to change though
> because Apple's new arm64-based Macs have Thunderbolt integrated into
> the SoC and arm64 SoCs are making inroads in the datacenter, which is
> an important use case for PCIe hotplug (hot-swappable NVMe drives).
> So we may have to amend pci_bridge_d3_possible() to whitelist
> PCIe ports for runtime PM on specific arches or systems.

Thanks for all this very useful information!

My interpretation for the mediatek situation:

  - I assume this patch leaves or puts the Root Port in D3cold if no
    downstream devices are present.

  - I don't see any support for PME or similar mechanisms to signal a
    hot-add while the RP is in D3cold.

  - So I assume you don't support hot-add if the slot was empty at
    boot and that's acceptable for your platform.
