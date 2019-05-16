Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D653B207BF
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 15:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfEPNNA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 09:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfEPNNA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 May 2019 09:13:00 -0400
Received: from localhost (50-82-73-190.client.mchsi.com [50.82.73.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C2C20848;
        Thu, 16 May 2019 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558012379;
        bh=ZtQao7hvDrKa3RULUBUe6l06x0fudhcp2vfY9dv/TwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R74n4upAT6jcFRwHCLqrGU91b4HuDhe6V+oMHyK2HgGs7zE6CGHrz9W2qM/iAl0rN
         2A7cECUDsaf8EriTHBNsDAo0iNh0xXbWQ2crDRTP+DlUH/sKtKA6ltWxUJ9MekxL2W
         jzzuQhwSiPmnlurXuRopKEq8UCgRjXm1//zmVeXQ=
Date:   Thu, 16 May 2019 08:12:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 00/28] Enable Tegra PCIe root port features
Message-ID: <20190516131257.GA101793@google.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 16, 2019 at 11:22:39AM +0530, Manikanta Maddireddy wrote:
> This series of patches adds,
> - Tegra root port features like Gen2, AER, etc
> - Power and perf optimizations
> - Fixes like "power up sequence", "dev_err prints", etc

Please:

  1) Put the brakes on.  You posted v3 of these 30 patches on May 13
     and v4 on May 16.  There's no hurry; the merge window is still
     open and nothing will be added to -next until at least next week.
     If you space these out a little, people will have time to digest
     them.

  2) Mention in the cover letter what changed between v3 and v4 so
     people know where to spend their effort.

> This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
> based Jetson-TX1, T124 based Jetson-TK1 platforms, Tegra20 and Tegra30
> platforms.
> 
> Manikanta Maddireddy (28):
>   soc/tegra: pmc: Export tegra_powergate_power_on()
>   PCI: tegra: Handle failure cases in tegra_pcie_power_on()
>   PCI: tegra: Rearrange Tegra PCIe driver functions
>   PCI: tegra: Mask AFI_INTR in runtime suspend
>   PCI: tegra: Fix PCIe host power up sequence
>   PCI: tegra: Add PCIe Gen2 link speed support
>   PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
>   PCI: tegra: Program UPHY electrical settings for Tegra210
>   PCI: tegra: Enable opportunistic UpdateFC and ACK
>   PCI: tegra: Disable AFI dynamic clock gating
>   PCI: tegra: Process pending DLL transactions before entering L1 or L2
>   PCI: tegra: Enable PCIe xclk clock clamping
>   PCI: tegra: Increase the deskew retry time
>   PCI: tegra: Add SW fixup for RAW violations
>   PCI: tegra: Update flow control timer frequency in Tegra210
>   PCI: tegra: Set target speed as Gen1 before starting LTSSM
>   PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
>   PCI: tegra: Program AFI_CACHE* registers only for Tegra20
>   PCI: tegra: Change PRSNT_SENSE IRQ log to debug
>   PCI: tegra: Use legacy IRQ for port service drivers
>   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
>   PCI: tegra: Access endpoint config only if PCIe link is up
>   dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
>   arm64: tegra: Add PEX DPD states as pinctrl properties
>   PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
>   PCI: Add DT binding for "reset-gpios" property
>   PCI: tegra: Add support for GPIO based PERST#
>   PCI: tegra: Change link retry log level to debug
> 
>  .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
>  Documentation/devicetree/bindings/pci/pci.txt |   3 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
>  drivers/pci/controller/pci-tegra.c            | 615 +++++++++++++++---
>  drivers/soc/tegra/pmc.c                       |   1 +
>  5 files changed, 566 insertions(+), 80 deletions(-)
> 
> -- 
> 2.17.1
> 
