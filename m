Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDB116A820
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 15:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBXOPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 09:15:54 -0500
Received: from foss.arm.com ([217.140.110.172]:37852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbgBXOPy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 09:15:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC83730E;
        Mon, 24 Feb 2020 06:15:53 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D6CA3F534;
        Mon, 24 Feb 2020 06:15:51 -0800 (PST)
Date:   Mon, 24 Feb 2020 14:15:49 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/7] PCI: amlogic: Make PCIe working reliably on AXG
 platforms
Message-ID: <20200224141549.GB15614@e121166-lin.cambridge.arm.com>
References: <20200123232943.10229-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123232943.10229-1-repk@triplefau.lt>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 24, 2020 at 12:29:36AM +0100, Remi Pommarel wrote:
> PCIe device probing failures have been seen on AXG platforms and were
> due to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit
> in MIPI's PHY registers solved the problem. This bit controls band gap
> reference.
> 
> As discussed here [1] one of these shared MIPI/PCIE analog PHY register
> bits was implemented in the clock driver as CLKID_MIPI_ENABLE. This adds
> a PHY driver to control this bit instead, as well as setting the band
> gap one in order to get reliable PCIE communication.
> 
> While at it add another PHY driver to control PCIE only PHY registers,
> making AXG code more similar to G12A platform thus allowing to remove
> some specific platform handling in pci-meson driver.
> 
> Please note that CLKID_MIPI_ENABLE removable will be done in a different
> serie.
> 
> Changes since v5:
>  - Add additionalProperties in device tree binding documentation
>  - Make analog PHY required
> 
> Changes since v4:
>  - Rename the shared MIPI/PCIe PHY to analog
>  - Chain the MIPI/PCIe PHY to the PCIe one
> 
> Changes since v3:
>  - Go back to the shared MIPI/PCIe phy driver solution from v2
>  - Remove syscon usage
>  - Add all dt-bindings documentation
> 
> Changes since v2:
>  - Remove shared MIPI/PCIE device driver and use syscon to access register
>    in PCIE only driver instead
>  - Include devicetree documentation
> 
> Changes sinve v1:
>  - Move HHI_MIPI_CNTL0 bit control in its own PHY driver
>  - Add a PHY driver for PCIE_PHY registers
>  - Modify pci-meson.c to make use of both PHYs and remove specific
>    handling for AXG and G12A
> 
> [1] https://lkml.org/lkml/2019/12/16/119
> 
> Remi Pommarel (7):
>   dt-bindings: Add AXG PCIE PHY bindings
>   dt-bindings: Add AXG shared MIPI/PCIE analog PHY bindings
>   dt-bindings: PCI: meson: Update PCIE bindings documentation
>   arm64: dts: meson-axg: Add PCIE PHY nodes
>   phy: amlogic: Add Amlogic AXG MIPI/PCIE analog PHY Driver
>   phy: amlogic: Add Amlogic AXG PCIE PHY Driver
>   PCI: amlogic: Use AXG PCIE
> 
>  .../bindings/pci/amlogic,meson-pcie.txt       |  22 +-
>  .../amlogic,meson-axg-mipi-pcie-analog.yaml   |  35 ++++
>  .../bindings/phy/amlogic,meson-axg-pcie.yaml  |  52 +++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  16 ++
>  drivers/pci/controller/dwc/pci-meson.c        | 116 ++---------
>  drivers/phy/amlogic/Kconfig                   |  22 ++
>  drivers/phy/amlogic/Makefile                  |  12 +-
>  .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 188 +++++++++++++++++
>  drivers/phy/amlogic/phy-meson-axg-pcie.c      | 192 ++++++++++++++++++
>  9 files changed, 543 insertions(+), 112 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

Hi Remi,

I am ready to pull this series in, do you want me to ? Or you prefer
it to go via a different tree upstream ?

Thanks,
Lorenzo
