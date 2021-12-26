Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912D247F6B4
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 13:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhLZMEw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 07:04:52 -0500
Received: from foss.arm.com ([217.140.110.172]:40026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233379AbhLZMEw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Dec 2021 07:04:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2AEC6D;
        Sun, 26 Dec 2021 04:04:51 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D822F3F5A1;
        Sun, 26 Dec 2021 04:04:50 -0800 (PST)
Date:   Sun, 26 Dec 2021 12:04:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/23] PCI: Name structs, functions consistently
Message-ID: <20211226120445.GA19807@lpieralisi>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 22, 2021 at 07:10:31PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a v2 of Fan's patches, previously posted at:
> 
>   https://lore.kernel.org/r/cover.1637678103.git.ffclaire1224@gmail.com
>   https://lore.kernel.org/r/cover.1638021831.git.ffclaire1224@gmail.com
> 
> I added a few more patches along the same lines and added driver
> maintainers to the cc lists.
> 
> There should be no functional changes here at all; this is strictly to make
> the drivers more consistent so it's easier to see defects and opportunities
> for consolidation.
> 
> Lorenzo, if this seems OK, I propose that I merge it after all of your
> branches so it doesn't get in the way of what you have pending.

That works for me, thank you very much for putting it together.

Lorenzo

> 
> This series applies on v5.16-rc1.
> 
> Bjorn Helgaas (10):
>   PCI: j721e: Drop pointless of_device_get_match_data() cast
>   PCI: j721e: Drop redundant struct device *
>   PCI: iproc: Rename iproc_pcie_bcma_ to iproc_bcma_pcie_
>   PCI: iproc: Rename iproc_pcie_pltfm_ to iproc_pltfm_pcie_
>   PCI: ls-gen4: Rename ls_pcie_g4 to ls_g4_pcie
>   PCI: microchip: Rename mc_port to mc_pcie
>   PCI: mt7621: Make pci_ops static
>   PCI: mt7621: Rename mt7621_pci_ to mt7621_pcie_
>   PCI: rcar-gen2: Rename rcar_pci_priv to rcar_pci
>   PCI: xilinx-cpm: Rename xilinx_cpm_pcie_port to xilinx_cpm_pcie
> 
> Fan Fei (13):
>   PCI: altera: Prefer of_device_get_match_data()
>   PCI: artpec6: Prefer of_device_get_match_data()
>   PCI: cadence: Prefer of_device_get_match_data()
>   PCI: designware-plat: Prefer of_device_get_match_data()
>   PCI: dra7xx: Prefer of_device_get_match_data()
>   PCI: keystone: Prefer of_device_get_match_data()
>   PCI: kirin: Prefer of_device_get_match_data()
>   PCI: intel-gw: Rename intel_pcie_port to intel_pcie
>   PCI: mediatek-gen3: Rename mtk_pcie_port to mtk_gen3_pcie
>   PCI: tegra194: Rename tegra_pcie_dw to tegra194_pcie
>   PCI: uniphier: Rename uniphier_pcie_priv to uniphier_pcie
>   PCI: xgene: Rename xgene_pcie_port to xgene_pcie
>   PCI: xilinx: Rename xilinx_pcie_port to xilinx_pcie
> 
>  drivers/pci/controller/cadence/pci-j721e.c    |  18 +-
>  .../controller/cadence/pcie-cadence-plat.c    |   6 +-
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   6 +-
>  drivers/pci/controller/dwc/pci-keystone.c     |   4 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c     |   6 +-
>  .../pci/controller/dwc/pcie-designware-plat.c |   6 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c    | 204 +++++-----
>  drivers/pci/controller/dwc/pcie-kirin.c       |   6 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 222 +++++------
>  drivers/pci/controller/dwc/pcie-uniphier.c    | 147 +++----
>  .../mobiveil/pcie-layerscape-gen4.c           |  84 ++--
>  drivers/pci/controller/pci-rcar-gen2.c        |  14 +-
>  drivers/pci/controller/pci-xgene.c            |  46 +--
>  drivers/pci/controller/pcie-altera.c          |   8 +-
>  drivers/pci/controller/pcie-iproc-bcma.c      |  22 +-
>  drivers/pci/controller/pcie-iproc-platform.c  |  16 +-
>  drivers/pci/controller/pcie-mediatek-gen3.c   | 372 +++++++++---------
>  drivers/pci/controller/pcie-microchip-host.c  |  42 +-
>  drivers/pci/controller/pcie-mt7621.c          |  36 +-
>  drivers/pci/controller/pcie-xilinx-cpm.c      |  44 +--
>  drivers/pci/controller/pcie-xilinx.c          | 158 ++++----
>  21 files changed, 727 insertions(+), 740 deletions(-)
> 
> -- 
> 2.25.1
> 
