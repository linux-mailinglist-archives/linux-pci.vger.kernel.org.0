Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952C1345C95
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 12:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhCWLPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 07:15:51 -0400
Received: from foss.arm.com ([217.140.110.172]:44132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230358AbhCWLP3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 07:15:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C3F1042;
        Tue, 23 Mar 2021 04:15:28 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3CE3F719;
        Tue, 23 Mar 2021 04:15:27 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:15:24 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com
Subject: Re: [PATCH 0/7] PCI: layerscape: Add power management support
Message-ID: <20210323111524.GD29286@e121166-lin.cambridge.arm.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 01:37:54PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch series is to add PCIe power management support for NXP
> Layerscape platfroms.
> 
> Hou Zhiqiang (7):
>   PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
>   PCI: layerscape: Change to use the DWC common link-up check function
>   dt-bindings: pci: layerscape-pci: Add a optional property big-endian
>   arm64: dts: layerscape: Add big-endian property for PCIe nodes
>   dt-bindings: pci: layerscape-pci: Update the description of SCFG
>     property
>   dts: arm64: ls1043a: Add SCFG phandle for PCIe nodes
>   PCI: layerscape: Add power management support
> 
>  .../bindings/pci/layerscape-pci.txt           |   6 +-
>  .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   1 +
>  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   6 +
>  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +
>  drivers/pci/controller/dwc/pci-layerscape.c   | 473 ++++++++++++++----
>  drivers/pci/controller/dwc/pcie-designware.c  |  12 +-
>  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
>  7 files changed, 388 insertions(+), 114 deletions(-)

I don't know which patches are still applicable, I will mark this
series as superseded since you will have to rebase it anyway - please
let me know what's the plan.

Thanks,
Lorenzo
