Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7383B89BD
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 22:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhF3UdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 16:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234268AbhF3UdB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jun 2021 16:33:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF55613D3;
        Wed, 30 Jun 2021 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625085032;
        bh=C7fRTeYDA+xvhe4oWh/Ia8vUpNmTjFr8ErXmCrxyWkU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GiBrfa5bm9GsfYVC/nyNBmqxQfpAy4fDB2rJ6aUQ93pz9zOiVbFZV5GgxrGcHTsRA
         /PCtkYWIgip1hkPZUXqN0u6lBnmKGDw9ID16ry82Hg7K/MMj12UBIN903+79Dug8WD
         dBvXb0Qt/dnf1LViXZ6ijkjZ+6CpPi1YUvyGjj/+ksTR5gqnjCOKKRmcEM3XrtbXaK
         HyBQr527P9Yy1p1T2RiXB+LDhtvop8UaDhP4ci0pbnaJA55ArMJ1ETye/2O+pM3UHX
         GfQmrAXDo6Ej/UdrH3rPksKhBy1MPoH373Z2+mlusuKKYLsn8SQmiAsswumMIckFZ9
         5XvLsPfWBPVzA==
Date:   Wed, 30 Jun 2021 15:30:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
Message-ID: <20210630203030.GA4178852@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f3bd28-8e5e-362d-11a9-43a60ff79dd2@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 30, 2021 at 09:59:58PM +0200, Javier Martinez Canillas wrote:
> On 6/30/21 8:59 PM, Bjorn Helgaas wrote:
> > [+cc Michal, Jingoo, Thierry, Jonathan]
> 
> [snip]
> 
> > 
> > I think the above commit log is perfectly accurate, but all the
> > details might suggest that this is something specific to rockchip or
> > CONFIG_DEBUG_SHIRQ, which it isn't, and they might obscure the
> > fundamental problem, which is actually very simple: we registered IRQ
> > handlers before we were ready for them to be called.
> > 
> > I propose the following commit log in the hope that it would help
> > other driver authors to make similar fixes:
> >
> >     PCI: rockchip: Register IRQ handlers after device and data are ready
> > 
> >     An IRQ handler may be called at any time after it is registered, so
> >     anything it relies on must be ready before registration.
> > 
> >     rockchip_pcie_subsys_irq_handler() and rockchip_pcie_client_irq_handler()
> >     read registers in the PCIe controller, but we registered them before
> >     turning on clocks to the controller.  If either is called before the clocks
> >     are turned on, the register reads fail and the machine hangs.
> > 
> >     Similarly, rockchip_pcie_legacy_int_handler() uses rockchip->irq_domain,
> >     but we installed it before initializing irq_domain.
> > 
> >     Register IRQ handlers after their data structures are initialized and
> >     clocks are enabled.
> > 
> > If this is inaccurate or omits something important, let me know.  I
> > can make any updates locally.
> >
> 
> I think your description is accurate and agree that the commit message may
> be misleading. As you said, this is a general problem and the fact that an
> IRQ is shared and CONFIG_DEBUG_SHIRQ fires a spurious interrupt just make
> the assumptions in the driver to fall apart.
> 
> But maybe you can also add a paragraph that mentions the CONFIG_DEBUG_SHIRQ
> option and shared interrupts? That way, other driver authors could know that
> by enabling this an underlying problem might be exposed for them to fix.

Good idea, thanks!  I added this; is it something like what you had in
mind?

    Found by enabling CONFIG_DEBUG_SHIRQ, which calls the IRQ handler when it
    is being unregistered.  An error during the probe path might cause this
    unregistration and IRQ handler execution before the device or data
    structure init has finished.

Bjorn
