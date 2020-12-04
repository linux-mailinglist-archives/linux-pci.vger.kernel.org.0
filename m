Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB62CE8B4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 08:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgLDHkf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 02:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgLDHkf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 02:40:35 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB7C061A51
        for <linux-pci@vger.kernel.org>; Thu,  3 Dec 2020 23:39:55 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C8EE42800A27A;
        Fri,  4 Dec 2020 08:38:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 478004A0D; Fri,  4 Dec 2020 08:39:09 +0100 (CET)
Date:   Fri, 4 Dec 2020 08:39:09 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20201204073909.GA17699@wunner.de>
References: <1606113913.14736.37.camel@mhfsdcap03>
 <20201130173005.GA1088958@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130173005.GA1088958@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 11:30:05AM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 23, 2020 at 02:45:13PM +0800, Jianjun Wang wrote:
> > On Thu, 2020-11-19 at 14:28 -0600, Bjorn Helgaas wrote:
> > > > +static int mtk_pcie_setup(struct mtk_pcie_port *port)
> > > > +{
[...]
> > > > +	/* Try link up */
> > > > +	err = mtk_pcie_startup_port(port);
> > > > +	if (err) {
> > > > +		dev_notice(dev, "PCIe link down\n");
> > > > +		goto err_setup;
> > > 
> > > Generally it should not be a fatal error if the link is not up at
> > > probe-time.  You may be able to hot-add a device, or the device may
> > > have some external power control that will power it up later.
> > 
> > This is for the power saving requirement. If there is no device
> > connected with the PCIe slot, the PCIe MAC and PHY should be powered
> > off.
> > 
> > Is there any standard flow to support power down the hardware at
> > probe-time if no device is connected and power it up when hot-add a
> > device?
> 
> That's a good question.  I assume this looks like a standard PCIe
> hot-add event?
> 
> When you hot-add a device, does the Root Port generate a Presence
> Detect Changed interrupt?  The pciehp driver should field that
> interrupt and turn on power to the slot via the Power Controller
> Control bit in the Slot Control register.
> 
> Does your hardware require something more than that to control the MAC
> and PHY power?

Power saving of unused PCIe ports is generally achieved through the
runtime PM framework.  When a PCIe port runtime suspends, the PCIe
core will transition it to D3hot.  On top of that, the platform
may be able to transition the port to D3cold.  Currently only the
ACPI platform supports that.  Conceivably, devicetree-based systems
may want to disable certain clocks or regulators when a PCIe port
runtime suspends.  I think we do not support that yet but it could
be added to drivers/pci/pcie/portdrv*.

A hotplug port is expected to signal PDC and DLLSC interrupts even
when in D3hot.  At least that's our experience with Thunderbolt.
To support hotplug interrupts in D3cold, some external mechanism
(such as a PME) is necessary to wake up the port on hotplug.
This is also supported with recent Thunderbolt systems.

Because we've seen various incompatibilities when runtime suspending
PCIe ports, certain conditions must be satisfied for runtime PM
to be enabled.  They're encoded in pci_bridge_d3_possible().
Generally, hotplug ports only runtime suspend if they belong to
a Thunderbolt controller or if the ACPI platform explicitly allows
runtime PM (through presence of a _PR3 method or a device property).
Non-hotplug ports runtime suspend if the BIOS is newer than 2015
(as specified by DMI).

Obviously, this policy is very x86-focussed because both Thunderbolt
and DMI are only really a thing on x86.  That's about to change though
because Apple's new arm64-based Macs have Thunderbolt integrated into
the SoC and arm64 SoCs are making inroads in the datacenter, which is
an important use case for PCIe hotplug (hot-swappable NVMe drives).
So we may have to amend pci_bridge_d3_possible() to whitelist
PCIe ports for runtime PM on specific arches or systems.

Thanks,

Lukas
