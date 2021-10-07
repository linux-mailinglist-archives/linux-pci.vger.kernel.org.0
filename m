Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF24253C8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbhJGNOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 09:14:33 -0400
Received: from foss.arm.com ([217.140.110.172]:53224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241234AbhJGNOd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 09:14:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3910D6D;
        Thu,  7 Oct 2021 06:12:39 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 717E43F66F;
        Thu,  7 Oct 2021 06:12:37 -0700 (PDT)
Date:   Thu, 7 Oct 2021 14:12:32 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, bhelgaas@google.com, robh@kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, bjorn.andersson@linaro.org,
        sallenki@codeaurora.org, skananth@codeaurora.org,
        vpernami@codeaurora.org, vbadigan@codeaurora.org
Subject: Re: [PATCH v8 0/3] Add Qualcomm PCIe Endpoint driver support
Message-ID: <20211007131232.GA19662@lpieralisi>
References: <20210920065946.15090-1-manivannan.sadhasivam@linaro.org>
 <20211004041949.GA16442@workstation>
 <20211007125724.GA27987@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007125724.GA27987@thinkpad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 07, 2021 at 06:27:24PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Oct 04, 2021 at 09:49:49AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Sep 20, 2021 at 12:29:43PM +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > This series adds support for Qualcomm PCIe Endpoint controller found
> > > in platforms like SDX55. The Endpoint controller is based on the designware
> > > core with additional Qualcomm wrappers around the core.
> > > 
> > > The driver is added separately unlike other Designware based drivers that
> > > combine RC and EP in a single driver. This is done to avoid complexity and
> > > to maintain this driver autonomously.
> > > 
> > > The driver has been validated with an out of tree MHI function driver on
> > > SDX55 based Telit FN980 EVB connected to x86 host machine over PCIe.
> > > 
> > 
> > Ping on this series! Patchwork says the state is still "New". Both
> > binding and driver patches got enough reviews I believe. Are there any
> > issues pending to be addressed?
> > 
> 
> Sorry for the noise. But not seeing any activity on this series is tempting me
> to ping this thread. This series has been under review for almost 3 releases and
> I don't want to miss this one too without any obvious reasons.

You won't and thanks for your patience, I will pull it.

Lorenzo

> 
> Thanks,
> Mani
> 
> > Thanks,
> > Mani
> > 
> > > Thanks,
> > > Mani
> > > 
> > > Changes in v8:
> > > 
> > > * Added Reviewed-by tag from Rob for the driver patch
> > > * Rebased on top of v5.15-rc1
> > > 
> > > Changes in v7:
> > > 
> > > * Used existing naming convention for callback functions
> > > * Used active low state for PERST# gpio
> > > 
> > > Changes in v6:
> > > 
> > > * Removed status property in DT and added reviewed tag from Rob
> > > * Switched to _relaxed variants as suggested by Rob
> > > 
> > > Changes in v5:
> > > 
> > > * Removed the DBI register settings that are not needed
> > > * Used the standard definitions available in pci_regs.h
> > > * Added defines for all the register fields
> > > * Removed the left over code from previous iteration
> > > 
> > > Changes in v4:
> > > 
> > > * Removed the active_config settings needed for IPA integration
> > > * Switched to writel for couple of relaxed versions that sneaked in
> > > 
> > > Changes in v3:
> > > 
> > > * Lot of minor cleanups to the driver patch based on review from Bjorn and Stan.
> > > * Noticeable changes are:
> > >   - Got rid of _relaxed calls and used readl/writel
> > >   - Got rid of separate TCSR memory region and used syscon for getting the
> > >     register offsets for Perst registers
> > >   - Changed the wake gpio handling logic
> > >   - Added remove() callback and removed "suppress_bind_attrs"
> > >   - stop_link() callback now just disables PERST IRQ
> > > * Added MMIO region and doorbell interrupt to the binding
> > > * Added logic to write MMIO physicall address to MHI base address as it is
> > >   for the function driver to work
> > > 
> > > Changes in v2:
> > > 
> > > * Addressed the comments from Rob on bindings patch
> > > * Modified the driver as per binding change
> > > * Fixed the warnings reported by Kbuild bot
> > > * Removed the PERST# "enable_irq" call from probe()
> > > 
> > > Manivannan Sadhasivam (3):
> > >   dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP
> > >     controller
> > >   PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver
> > >   MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
> > > 
> > >  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 158 ++++
> > >  MAINTAINERS                                   |  10 +-
> > >  drivers/pci/controller/dwc/Kconfig            |  10 +
> > >  drivers/pci/controller/dwc/Makefile           |   1 +
> > >  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 710 ++++++++++++++++++
> > >  5 files changed, 888 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > 
> > > -- 
> > > 2.25.1
> > > 
