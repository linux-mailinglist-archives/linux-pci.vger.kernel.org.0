Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED1835D2C1
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 23:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbhDLVxz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 17:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238235AbhDLVxy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Apr 2021 17:53:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A27E61220;
        Mon, 12 Apr 2021 21:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618264415;
        bh=ZIZgJKwfVBJrstNIymJVrVmHSmffZAW87wBEKIznNVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SIfwuGOcMaV7JjISjp4xsAw5n0OfXXOjOidUoy4hl0QT7AJuHvkZuWk1fFOvbblvq
         7JsW3/nQxgUCNEDKaDmHtqHWvVr9Sx0ixIk5DdIHG1lN0XhzsJvbFlv0ZDg3YFyLPM
         /Z1SQdmxr3H5SyR2h7uPJ6Lv6yc5R/mqzTjvIlfggOV69qr1VeGTbSXrlSeeagHXSw
         A2OmkFEyEgfbEaO8tsebR6Gkr7Dglt2YXWoYvzROEyBipx6N8UOuEQ4jCbS/QwkrI6
         XsI8fIZULwxO0ENOlCUbSw3Dq7RtK7/za0z5tKLYoEg2u7/2G0d9D83u+dQheRNtNE
         9NSNPgt9ebu1w==
Date:   Mon, 12 Apr 2021 16:53:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        amurray@thegoodpenguin.co.uk, robh@kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: Device driver location for the PCIe root port's DMA engine
Message-ID: <20210412215333.GA2144302@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d840687e-bfd7-71b4-e8f0-37c971d3d414@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Matthew for portdrv comment]

On Mon, Apr 12, 2021 at 10:31:02PM +0530, Vidya Sagar wrote:
> Hi
> I'm starting this mail to seek advice on the best approach to be taken to
> add support for the driver of the PCIe root port's DMA engine.
> To give some background, Tegra194's PCIe IPs are dual-mode PCIe IPs i.e.
> they work either in the root port mode or in the endpoint mode based on the
> boot time configuration.
> Since the PCIe hardware IP as such is the same for both (RP and EP) modes,
> the DMA engine sub-system of the PCIe IP is also made available to both
> modes of operation.
> Typically, the DMA engine is seen only in the endpoint mode, and that DMA
> engine’s configuration registers are made available to the host through one
> of its BARs.
> In the situation that we have here, where there is a DMA engine present as
> part of the root port, the DMA engine isn’t a typical general-purpose DMA
> engine in the sense that it can’t have both source and destination addresses
> targeting external memory addresses.
> RP’s DMA engine, while doing a write operation,
> would always fetch data (i.e. source) from local memory and write it to the
> remote memory over PCIe link (i.e. destination would be the BAR of an
> endpoint)
> whereas while doing a read operation,
> would always fetch/read data (i.e. source) from a remote memory over the
> PCIe link and write it to the local memory.
> 
> I see that there are at least two ways we can have a driver for this DMA
> engine.
> a) DMA engine driver as one of the port service drivers
> 	Since the DMA engine is a part of the root port hardware itself (although
> it is not part of the standard capabilities of the root port), it is one of
> the options to have the driver for the DMA engine go as one of the port
> service drivers (along with AER, PME, hot-plug, etc...). Based on Vendor-ID
> and Device-ID matching runtime, either it gets binded/enabled (like in the
> case of Tegra194) or it doesn't.
> b) DMA engine driver as a platform driver
> 	The DMA engine hardware can be described as a sub-node under the PCIe
> controller's node in the device tree and a separate platform driver can be
> written to work with it.
> 
> I’m inclined to have the DMA engine driver as a port service driver as it
> makes it cleaner and also in line with the design philosophy (the way I
> understood it) of the port service drivers.
> Please let me know your thoughts on this.

Personally I'm not a fan of the port service driver model.  It creates
additional struct devices for things that are not separate devices.
And it creates a parallel hierarchy in /sys/bus/pci_express/devices/
that I think does not accurately model the hardware.

The existing port services (AER, DPC, hotplug, etc) are things the
device advertises via the PCI Capabilities defined by the generic PCIe
spec, and in my opinion the support for them should be directly part
of the PCI core and activated when the relevant Capability is present.

The DMA engine is different -- this is device-specific functionality
and I think the obvious way to discover it and bind a driver to it is
via the PCI Vendor and Device ID.

This *is* complicated by the fact that you can't just use
pci_register_driver() to claim functionality implemented in Root Ports
or Switch Ports because portdrv binds to them before you have a
chance.  I think that's a defect in the portdrv design.  The usual
workaround is to use pci_get_device(), which has its own issues (it's
ugly, it's outside the normal driver binding model, doesn't work
nicely with hotplug or udev, doesn't coordinate with other drivers
using the same device, etc).  There are many examples of this in the
EDAC code.

Bjorn
