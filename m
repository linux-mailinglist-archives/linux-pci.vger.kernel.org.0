Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6242A5A3F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 23:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgKCWok (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 17:44:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730606AbgKCWok (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 17:44:40 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4779F21534;
        Tue,  3 Nov 2020 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604443479;
        bh=B0hofVyjbIarQN5JcfzWbRMadJujwsK3/oEFwLCaHaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aGJthRPHhGnUHt1ZdKqRmEtO85M2aHQ0EeBOkvpHEdxgqcV5i3Ard2wiJ81JAWc/6
         kqheh439OJUiLwEjikfrm/596btquk1VT+KMzM6CPVKq/RwToIlXTv8sbNUy6UTy0i
         BatF/rWkEZdP538Vqd3i+3FwP4h+TInyIqmAjSB8=
Date:   Tue, 3 Nov 2020 16:44:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/6] Add DW PCIe support for Exynos5433 SoCs
Message-ID: <20201103224437.GA271545@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029134017.27400-1-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 29, 2020 at 02:40:11PM +0100, Marek Szyprowski wrote:
> Dear All,
> 
> This patchset is a resurrection of the DW PCIe support for the Exynos5433
> SoCs posted long time ago here: https://lkml.org/lkml/2016/12/26/6 and
> later here: https://lkml.org/lkml/2017/12/21/296 .
> 
> In meantime the support for the Exynos5440 SoCs has been completely
> dropped from mainline kernel, as those SoCs never reached the market. The
> PCIe driver for Exynos5440 variant however has not been removed yet. This
> patchset simply reworks it to support the Exynos5433 variant. The lack of
> the need to support both variants significantly simplifies the driver
> code.
> 
> This patchset is based on the following branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-more-dwc-cleanup
> 
> Best regards,
> Marek Szyprowski
> 
> 
> Changelog:
> 
> v3:
> - rebased onto "[00/13] PCI: dwc: Another round of clean-ups" patchset:
>   https://patchwork.kernel.org/project/linux-samsung-soc/cover/20201028204646.356535-1-robh@kernel.org/
> - fixed issues pointed by Rob in the driver logic:
>   * removed DBI_RO_WR_EN register poking
>   * made driver a standard module
> - fixed section mismatch issue
> - added "num-viewport = <3>" property to dts and bindings to fix warning
> 
> v2: https://lore.kernel.org/linux-samsung-soc/20201023075744.26200-1-m.szyprowski@samsung.com/
> - fixed issues in dt-bindings pointed by Krzysztof and Rob
> 
> v1: https://lore.kernel.org/linux-samsung-soc/20201019094715.15343-1-m.szyprowski@samsung.com/
> - initial version of this resurrected patchset
> 
> 
> Patch summary:

Please follow the subject line convention:

  PCI: exynos: Rework to support Exynos5433 variant
  arm64: dts: exynos: Add WiFi/PCIe support to TM2(e) boards
  dt-bindings: PCI: exynos: Drop samsung,exynos5440-pcie binding
  dt-bindings: PCI: exynos: Add samsung,exynos-pcie binding
  dt-bindings: phy: exynos: Add samsung,exynos-pcie-phy binding

You can save this trouble by running "git log --oneline" on the file
(or directory, for new files) and copying the style.

> Jaehoon Chung (3):
>   phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433
>     PCIe PHY
>   pci: dwc: pci-exynos: rework the driver to support Exynos5433 variant
>   arm64: dts: exynos: add the WiFi/PCIe support to TM2(e) boards
> 
> Marek Szyprowski (3):
>   dt-bindings: pci: drop samsung,exynos5440-pcie binding
>   dt-bindings: pci: add the samsung,exynos-pcie binding
>   dt-bindings: phy: add the samsung,exynos-pcie-phy binding
> 
>  .../bindings/pci/samsung,exynos-pcie.yaml     | 119 ++++++
>  .../bindings/pci/samsung,exynos5440-pcie.txt  |  58 ---
>  .../bindings/phy/samsung,exynos-pcie-phy.yaml |  51 +++
>  .../boot/dts/exynos/exynos5433-pinctrl.dtsi   |   2 +-
>  .../dts/exynos/exynos5433-tm2-common.dtsi     |  24 +-
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  36 ++
>  drivers/pci/controller/dwc/Kconfig            |  10 +-
>  drivers/pci/controller/dwc/pci-exynos.c       | 353 +++++++-----------
>  drivers/pci/quirks.c                          |   1 +
>  drivers/phy/samsung/phy-exynos-pcie.c         | 304 ++++++---------
>  10 files changed, 489 insertions(+), 469 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> 
> -- 
> 2.17.1
> 
