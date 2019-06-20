Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61B24CC5A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfFTKxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 06:53:08 -0400
Received: from foss.arm.com ([217.140.110.172]:59330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731253AbfFTKxI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 06:53:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10780360;
        Thu, 20 Jun 2019 03:53:07 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5C23F718;
        Thu, 20 Jun 2019 03:53:05 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:53:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V6 00/27] Enable Tegra PCIe root port features
Message-ID: <20190620105301.GA23729@e121166-lin.cambridge.arm.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190620102552.GB28703@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620102552.GB28703@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 12:25:52PM +0200, Thierry Reding wrote:
> On Tue, Jun 18, 2019 at 11:31:39PM +0530, Manikanta Maddireddy wrote:
> > This series of patches adds,
> > - Tegra root port features like Gen2, AER, etc
> > - Power and perf optimizations
> > - Fixes like "power up sequence", "dev_err prints", etc
> > 
> > This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
> > based Jetson-TX1, T124 based Jetson-TK1, Tegra20 and Tegra30 platforms.
> > 
> > Changes from V5 to V6:
> >   - Patch [V4, 20/27]: Replaced pcie_pme_disable_msi() with no_msi quirk
> > 
> > Changes from V4 to V5:
> >  - Patch [V4, 4/28]: Added blank line before block style comment
> >  - Patch [V4, 22/28]: "Access endpoint config only if PCIe link is up"
> > patch is dropped
> >  - Patch [V4, 27/28]:
> > * Updated reset gpio toggle logic to reflect active low usage
> > * Replaced kasprintf() with devm_kasprintf()
> > * Updated commit message with more information.
> > 
> > Changes from V3 to V4:
> >  - Patch [V3,27/29] is dropped
> >  - Patch [V3,28/29]: devm_gpiod_get_from_of_node() is directly used in
> >    pci-tegra driver instead of of_get_pci* wrapper function defined in
> >    Patch [V3,27/29].
> > 
> > Manikanta Maddireddy (27):
> >   soc/tegra: pmc: Export tegra_powergate_power_on()
> >   PCI: tegra: Handle failure cases in tegra_pcie_power_on()
> >   PCI: tegra: Rearrange Tegra PCIe driver functions
> >   PCI: tegra: Mask AFI_INTR in runtime suspend
> >   PCI: tegra: Fix PCIe host power up sequence
> >   PCI: tegra: Add PCIe Gen2 link speed support
> >   PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
> >   PCI: tegra: Program UPHY electrical settings for Tegra210
> >   PCI: tegra: Enable opportunistic UpdateFC and ACK
> >   PCI: tegra: Disable AFI dynamic clock gating
> >   PCI: tegra: Process pending DLL transactions before entering L1 or L2
> >   PCI: tegra: Enable PCIe xclk clock clamping
> >   PCI: tegra: Increase the deskew retry time
> >   PCI: tegra: Add SW fixup for RAW violations
> >   PCI: tegra: Update flow control timer frequency in Tegra210
> >   PCI: tegra: Set target speed as Gen1 before starting LTSSM
> >   PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
> >   PCI: tegra: Program AFI_CACHE* registers only for Tegra20
> >   PCI: tegra: Change PRSNT_SENSE IRQ log to debug
> >   PCI: tegra: Disable MSI for Tegra PCIe root port
> >   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
> >   dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
> >   arm64: tegra: Add PEX DPD states as pinctrl properties
> >   PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
> >   PCI: Add DT binding for "reset-gpios" property
> >   PCI: tegra: Add support for GPIO based PERST#
> >   PCI: tegra: Change link retry log level to debug
> 
> Hi Lorenzo, Bjorn,
> 
> There's a build-time dependency from the PCI patches on patch 1 of this
> series. I've already Acked that, so I think you should take it through
> the PCI tree along with the rest of the series.
> 
> The only patch that I picked up is the DT change in patch 23, which is
> decoupled from the others via DT, though the data that it adds to DT
> will be used in patch 24.
> 
> Does that sound good to you?

Yes, I will drop patch 20 too as requested. Is there a merge ordering
dependency between patch 23 and 24 ? If yes we should let Bjorn know
or you drop patch 23 and I will merge it via PCI, let us know.

Lorenzo

> Thierry
> 
> > 
> >  .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
> >  Documentation/devicetree/bindings/pci/pci.txt |   3 +
> >  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
> >  drivers/pci/controller/pci-tegra.c            | 578 +++++++++++++++---
> >  drivers/pci/quirks.c                          |  39 ++
> >  drivers/soc/tegra/pmc.c                       |   1 +
> >  6 files changed, 568 insertions(+), 80 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 


