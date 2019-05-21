Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F7A2585E
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 21:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfEUTgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 15:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfEUTgW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 May 2019 15:36:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0CB217D9;
        Tue, 21 May 2019 19:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558467381;
        bh=KIETrny8+uJ6mb/6sbywMXsqjLr/B13v3e2H5fLDq/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xsAf94Br7UIrfKZQZlaeMGdzgOt2IN/9tfSepnhZ0KrezAUPzlKQ/O4r+xK/7dBYH
         luMzlO9OxVdclvvHY7utbK1jvz+7ovtu4aW5LS1rc3VTYJc9zEvrfQAuQDqx1tqDma
         pc60VB7NdUlB4TT4YKcs782g29IIsk8H6GaSeUA4=
Date:   Tue, 21 May 2019 14:36:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 02/15] PCI: Disable MSI for Tegra194 root port
Message-ID: <20190521193616.GE57618@google.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-3-vidyas@nvidia.com>
 <20190521102729.GB29166@ulmo>
 <f63051b0-a220-125b-219e-25156d65ea6d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f63051b0-a220-125b-219e-25156d65ea6d@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 21, 2019 at 10:17:26PM +0530, Vidya Sagar wrote:
> On 5/21/2019 3:57 PM, Thierry Reding wrote:
> > On Fri, May 17, 2019 at 06:08:33PM +0530, Vidya Sagar wrote:
> > > Tegra194 rootports don't generate MSI interrupts for PME events and hence
> > > MSI needs to be disabled for them to avoid root ports service drivers
> > > registering their respective ISRs with MSI interrupt.

The service drivers (AER, hotplug, etc) don't know whether the
interrupt is INTx or MSI; they just register their ISRs with
pcie_device.irq.

The point of this patch is that the PCI core doesn't support devices
that use MSI and INTx at the same time, and since this device can't
generate MSI for PME, we have to use INTx for *all* its interrupts.

> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > > Changes since [v6]:
> > > * This is a new patch
> > > 
> > >   drivers/pci/quirks.c | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 0f16acc323c6..28f9a0380df5 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -2592,6 +2592,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
> > >   			PCI_DEVICE_ID_NVIDIA_NVENET_15,
> > >   			nvenet_msi_disable);
> > > +/*
> > > + * Tegra194's PCIe root ports don't generate MSI interrupts for PME events
> > > + * instead legacy interrupts are generated. Hence, to avoid service drivers
> > > + * registering their respective ISRs for MSIs, need to disable MSI interrupts
> > > + * for root ports.
> > > + */
> > > +static void disable_tegra194_rp_msi(struct pci_dev *dev)
> > > +{
> > > +	dev->no_msi = 1;
> > > +}
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad0, disable_tegra194_rp_msi);
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad1, disable_tegra194_rp_msi);
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad2, disable_tegra194_rp_msi);
> > > +
> > 
> > Later functions in this file seem to use a more consistent naming
> > pattern, according to which the name for this would become:
> > 
> > 	pci_quirk_nvidia_tegra194_disable_rp_msi
> > 
> > Might be worth considering making this consistent.
> > 
> > This could also be moved to the DWC driver to restrict this to where it
> > is needed. In either case, this seems like a good solution, so:
> > 
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > 
> Ok. I'll move it to DWC driver along with name change for the quirk API.

Is there any possibility this hardware would be used in an ACPI
system?  If so, the quirk should probably stay in drivers/pci/quirks.c
because the DWC driver would not be present.

Either way, please also add some PCIe spec references about this in
the changelog and a comment in the code about working around this
issue.  I think the MSI/MSI-X sections that prohibit a device from
using both INTx and MSI/MSI-X are probably the most pertinent.

The reason I want a comment about this is to discourage future
hardware from following this example because every device that *does*
follow this example requires a kernel update that would be otherwise
unnecessary.

Bjorn
