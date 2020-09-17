Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF826E4A0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 20:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgIQSxm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 14:53:42 -0400
Received: from foss.arm.com ([217.140.110.172]:48708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbgIQQUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:20:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C88412FC;
        Thu, 17 Sep 2020 09:20:25 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D90443F68F;
        Thu, 17 Sep 2020 09:20:22 -0700 (PDT)
Date:   Thu, 17 Sep 2020 17:20:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        bhelgaas@google.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, gustavo.pimentel@synopsys.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, andrew.murray@arm.com, mingkai.hu@nxp.com,
        minghuan.Lian@nxp.com
Subject: Re: [PATCHv7 00/12]PCI: dwc: Add the multiple PF support for DWC and
 Layerscape
Message-ID: <20200917162017.GA6830@e121166-lin.cambridge.arm.com>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 11, 2020 at 05:54:29PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add the PCIe EP multiple PF support for DWC and Layerscape, and use
> a list to manage the PFs of each PCIe controller; add the doorbell
> MSIX function for DWC; and refactor the Layerscape EP driver due to
> some difference in Layercape platforms PCIe integration.
> 
> Hou Zhiqiang (1):
>   misc: pci_endpoint_test: Add driver data for Layerscape PCIe
>     controllers
> 
> Xiaowei Bao (11):
>   PCI: designware-ep: Add multiple PFs support for DWC
>   PCI: designware-ep: Add the doorbell mode of MSI-X in EP mode
>   PCI: designware-ep: Move the function of getting MSI capability
>     forward
>   PCI: designware-ep: Modify MSI and MSIX CAP way of finding
>   dt-bindings: pci: layerscape-pci: Add compatible strings for ls1088a
>     and ls2088a
>   PCI: layerscape: Fix some format issue of the code
>   PCI: layerscape: Modify the way of getting capability with different
>     PEX
>   PCI: layerscape: Modify the MSIX to the doorbell mode
>   PCI: layerscape: Add EP mode support for ls1088a and ls2088a
>   arm64: dts: layerscape: Add PCIe EP node for ls1088a
>   misc: pci_endpoint_test: Add LS1088a in pci_device_id table
> 
>  .../bindings/pci/layerscape-pci.txt           |   2 +
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  31 +++
>  drivers/misc/pci_endpoint_test.c              |   8 +-
>  .../pci/controller/dwc/pci-layerscape-ep.c    | 100 +++++--
>  .../pci/controller/dwc/pcie-designware-ep.c   | 258 ++++++++++++++----
>  drivers/pci/controller/dwc/pcie-designware.c  |  59 ++--
>  drivers/pci/controller/dwc/pcie-designware.h  |  48 +++-
>  7 files changed, 410 insertions(+), 96 deletions(-)

Side note: I will change it for you but please keep Signed-off-by:
tags together in the log instead of mixing them with other tags
randomly.

Can you rebase this series against my pci/dwc branch please and
send a v8 ?

I will apply it then.

Thanks,
Lorenzo
