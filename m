Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBCCD7732
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 15:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfJONO1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 09:14:27 -0400
Received: from foss.arm.com ([217.140.110.172]:38626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbfJONO1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 09:14:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E359337;
        Tue, 15 Oct 2019 06:14:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1A333F718;
        Tue, 15 Oct 2019 06:14:24 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:14:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, kishon@ti.com, bhelgaas@google.com,
        andrew.murray@arm.com, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yue.wang@Amlogic.com, maz@kernel.org,
        repk@triplefau.lt, nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH v2 0/6] arm64: dts: meson-g12: add support for PCIe
Message-ID: <20191015131419.GA12343@e121166-lin.cambridge.arm.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916125022.10754-1-narmstrong@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 02:50:16PM +0200, Neil Armstrong wrote:
> This patchset :
> - updates the Amlogic PCI bindings for G12A
> - reworks the Amlogic PCIe driver to make use of the
> G12a USB3+PCIe Combo PHY instead of directly writing in
> the PHY register
> - adds the necessary operations to the G12a USB3+PCIe Combo PHY driver
> - adds the PCIe Node for G12A, G12B and SM1 SoCs
> - adds the commented support for the S922X, A311D and S905D3 based
> VIM3 boards.
> 
> The VIM3 schematic can be found at [1].
> 
> This patchset is dependent on Remi's "Fix reset assertion via gpio descriptor"
> patch at [2].

Merged in pci/meson; however, I am not sure what should be done on
Remi's patch, I would like to queue it up too otherwise it looks
to me that merging this series is not right.

Lorenzo

> This patchset has been tested in a A311D VIM3 and S905D3 VIM3L using a
> 128Go TS128GMTE110S NVMe PCIe module.
> 
> For indication, here is a bonnie++ run as ext4 formatted on the VIM3:
>      ------Sequential Output------ --Sequential Input- --Random-
>      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP /sec %CP
>   4G 93865  99 312837  96 194487  23 102808  97 415501 21 +++++ +++
> 
> and the S905D3 VIM3L version:
>      ------Sequential Output------ --Sequential Input- --Random-
>      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
>   4G 52144  95 71766  21 47302  10 57078  98 415469  44 +++++ +++
> 
> Changes since v1 at [3]:
>  - Collected Andrew's and Rob's Reviewed-by tags
>  - Added missing calls to phy_init/phy_exit
>  - Fixes has_shared_phy handling for MIPI clock
>  - Add comment in the DT concerning firmware setting the right properties
>  - Added SM1 Power Domain to PCIe node
> 
> [1] https://docs.khadas.com/vim3/HardwareDocs.html
> [2] https://patchwork.kernel.org/patch/11125261/
> [3] https://patchwork.kernel.org/cover/11136927/
> 
> Neil Armstrong (6):
>   dt-bindings: pci: amlogic,meson-pcie: Add G12A bindings
>   PCI: amlogic: Fix probed clock names
>   PCI: amlogic: meson: Add support for G12A
>   phy: meson-g12a-usb3-pcie: Add support for PCIe mode
>   arm64: dts: meson-g12a: Add PCIe node
>   arm64: dts: khadas-vim3: add commented support for PCIe
> 
>  .../bindings/pci/amlogic,meson-pcie.txt       |  12 +-
>  .../boot/dts/amlogic/meson-g12-common.dtsi    |  33 +++++
>  .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  25 ++++
>  .../amlogic/meson-g12b-s922x-khadas-vim3.dts  |  25 ++++
>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |   4 +
>  .../dts/amlogic/meson-sm1-khadas-vim3l.dts    |  25 ++++
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |   4 +
>  drivers/pci/controller/dwc/pci-meson.c        | 132 ++++++++++++++----
>  .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    |  70 ++++++++--
>  9 files changed, 292 insertions(+), 38 deletions(-)
> 
> -- 
> 2.22.0
> 
