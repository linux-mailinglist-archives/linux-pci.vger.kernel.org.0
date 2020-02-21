Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9401A167D4D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 13:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgBUMUB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 07:20:01 -0500
Received: from foss.arm.com ([217.140.110.172]:38146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgBUMUB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Feb 2020 07:20:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9BBD30E;
        Fri, 21 Feb 2020 04:20:00 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F5BA3F68F;
        Fri, 21 Feb 2020 04:19:58 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:19:56 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, catalin.marinas@arm.com, will.deacon@arm.com,
        Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 00/13] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Message-ID: <20200221121956.GC12711@e121166-lin.cambridge.arm.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:31PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set is to recode the Mobiveil driver and add
> PCIe support for NXP Layerscape series SoCs integrated
> Mobiveil's PCIe Gen4 controller.
> 
> Hou Zhiqiang (13):
>   PCI: mobiveil: Introduce a new structure mobiveil_root_port
>   PCI: mobiveil: Move the host initialization into a function
>   PCI: mobiveil: Collect the interrupt related operations into a
>     function
>   PCI: mobiveil: Modularize the Mobiveil PCIe Host Bridge IP driver
>   PCI: mobiveil: Add callback function for interrupt initialization
>   PCI: mobiveil: Add callback function for link up check
>   PCI: mobiveil: Allow mobiveil_host_init() to be used to re-init host
>   PCI: mobiveil: Add 8-bit and 16-bit CSR register accessors
>   PCI: mobiveil: Add Header Type field check
>   dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4 controller
>   PCI: mobiveil: Add PCIe Gen4 RC driver for NXP Layerscape SoCs
>   arm64: dts: lx2160a: Add PCIe controller DT nodes
>   arm64: defconfig: Enable CONFIG_PCIE_LAYERSCAPE_GEN4
> 
>  .../bindings/pci/layerscape-pcie-gen4.txt     |  52 ++
>  MAINTAINERS                                   |  10 +-
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 +++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/pci/controller/Kconfig                |  11 +-
>  drivers/pci/controller/Makefile               |   2 +-
>  drivers/pci/controller/mobiveil/Kconfig       |  33 +
>  drivers/pci/controller/mobiveil/Makefile      |   5 +
>  .../mobiveil/pcie-layerscape-gen4.c           | 267 +++++++++
>  .../pcie-mobiveil-host.c}                     | 564 ++++--------------
>  .../controller/mobiveil/pcie-mobiveil-plat.c  |  61 ++
>  .../pci/controller/mobiveil/pcie-mobiveil.c   | 230 +++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 226 +++++++
>  13 files changed, 1170 insertions(+), 455 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
>  create mode 100644 drivers/pci/controller/mobiveil/Kconfig
>  create mode 100644 drivers/pci/controller/mobiveil/Makefile
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
>  rename drivers/pci/controller/{pcie-mobiveil.c => mobiveil/pcie-mobiveil-host.c} (54%)
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h

I dropped the last two patches since they must be re-routed via arm-soc
(defconfig update and dts), I tweaked most of commit logs and applied
the series to pci/mobiveil, please check everything is in order.

Thanks,
Lorenzo
