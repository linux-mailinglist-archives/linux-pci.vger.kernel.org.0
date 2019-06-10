Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E70E63BB06
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbfFJReC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 13:34:02 -0400
Received: from foss.arm.com ([217.140.110.172]:46788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387492AbfFJReC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jun 2019 13:34:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940F9337;
        Mon, 10 Jun 2019 10:34:01 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E77D3F246;
        Mon, 10 Jun 2019 10:34:00 -0700 (PDT)
Date:   Mon, 10 Jun 2019 18:33:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 00/28] Enable Tegra PCIe root port features
Message-ID: <20190610173354.GA12678@redmoon>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <b7d09498-b97e-3428-02bd-ecd7c7f3e733@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d09498-b97e-3428-02bd-ecd7c7f3e733@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 10, 2019 at 10:15:07AM +0530, Manikanta Maddireddy wrote:
> Hi Lorenzo,
> 
> Thierry Ack'ed most of the patches, I am planning to address the review
> comments for remaining two patches and publish V5. If you can review the
> series, I will consolidate both the comments and address in V5.

It will take me some time to get to this series but it is on my
radar, start preparing v5 but wait before posting it, I should
be able to comment shortly.

Lorenzo

> Manikanta
> 
> 
> On 16-May-19 11:22 AM, Manikanta Maddireddy wrote:
> > This series of patches adds,
> > - Tegra root port features like Gen2, AER, etc
> > - Power and perf optimizations
> > - Fixes like "power up sequence", "dev_err prints", etc
> >
> > This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
> > based Jetson-TX1, T124 based Jetson-TK1 platforms, Tegra20 and Tegra30
> > platforms.
> >
> > Manikanta Maddireddy (28):
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
> >   PCI: tegra: Use legacy IRQ for port service drivers
> >   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
> >   PCI: tegra: Access endpoint config only if PCIe link is up
> >   dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
> >   arm64: tegra: Add PEX DPD states as pinctrl properties
> >   PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
> >   PCI: Add DT binding for "reset-gpios" property
> >   PCI: tegra: Add support for GPIO based PERST#
> >   PCI: tegra: Change link retry log level to debug
> >
> >  .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
> >  Documentation/devicetree/bindings/pci/pci.txt |   3 +
> >  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
> >  drivers/pci/controller/pci-tegra.c            | 615 +++++++++++++++---
> >  drivers/soc/tegra/pmc.c                       |   1 +
> >  5 files changed, 566 insertions(+), 80 deletions(-)
> >
> 
