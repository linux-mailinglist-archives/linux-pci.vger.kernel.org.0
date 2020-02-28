Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA968173605
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 12:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgB1LaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 06:30:16 -0500
Received: from foss.arm.com ([217.140.110.172]:36764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1LaQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 06:30:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0491F4B2;
        Fri, 28 Feb 2020 03:30:15 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2883F73B;
        Fri, 28 Feb 2020 03:30:12 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:30:10 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v4 00/11] Add the multiple PF support for DWC and
 Layerscape
Message-ID: <20200228113010.GB4064@e121166-lin.cambridge.arm.com>
References: <20190924021849.3185-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924021849.3185-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 24, 2019 at 10:18:38AM +0800, Xiaowei Bao wrote:
> Add the PCIe EP multiple PF support for DWC and Layerscape, add
> the doorbell MSIX function for DWC, use list to manage the PF of
> one PCIe controller, and refactor the Layerscape EP driver due to
> some platforms difference.
> 
> Xiaowei Bao (11):
>   PCI: designware-ep: Add multiple PFs support for DWC
>   PCI: designware-ep: Add the doorbell mode of MSI-X in EP mode
>   PCI: designware-ep: Move the function of getting MSI capability
>     forward
>   PCI: designware-ep: Modify MSI and MSIX CAP way of finding
>   dt-bindings: pci: layerscape-pci: add compatible strings for ls1088a
>     and ls2088a
>   PCI: layerscape: Fix some format issue of the code
>   PCI: layerscape: Modify the way of getting capability with different
>     PEX
>   PCI: layerscape: Modify the MSIX to the doorbell mode
>   PCI: layerscape: Add EP mode support for ls1088a and ls2088a
>   arm64: dts: layerscape: Add PCIe EP node for ls1088a
>   misc: pci_endpoint_test: Add LS1088a in pci_device_id table
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |   2 +
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  31 +++
>  drivers/misc/pci_endpoint_test.c                   |   2 +
>  drivers/pci/controller/dwc/pci-layerscape-ep.c     | 100 ++++++--
>  drivers/pci/controller/dwc/pcie-designware-ep.c    | 255 +++++++++++++++++----
>  drivers/pci/controller/dwc/pcie-designware.c       |  59 +++--
>  drivers/pci/controller/dwc/pcie-designware.h       |  48 +++-
>  7 files changed, 404 insertions(+), 93 deletions(-)

Hi,

are you resending this patchset ? I would also like Andrew and Kishon to
have a look and ACK relevant code before merging it.

Thanks,
Lorenzo
