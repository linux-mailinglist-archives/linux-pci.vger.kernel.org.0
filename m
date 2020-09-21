Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E602721C1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgIULDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 07:03:41 -0400
Received: from foss.arm.com ([217.140.110.172]:41178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIULDl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 07:03:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FA0D31B;
        Mon, 21 Sep 2020 04:03:40 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9E483F70D;
        Mon, 21 Sep 2020 04:03:37 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:03:32 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
        kishon@ti.com, leoyang.li@nxp.com, gustavo.pimentel@synopsys.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, andrew.murray@arm.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com
Subject: Re: [PATCHv8 00/12]PCI: dwc: Add the multiple PF support for DWC and
 Layerscape
Message-ID: <20200921110332.GA1235@e121166-lin.cambridge.arm.com>
References: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 04:00:12PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add the PCIe EP multiple PF support for DWC and Layerscape, and use
> a list to manage the PFs of each PCIe controller; add the doorbell
> MSIX function for DWC; and refactor the Layerscape EP driver due to
> some difference in Layercape platforms PCIe integration.
> 
> Rebased this series against pci/dwc branch of git tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git

I have merged the series on top of the current pci/dwc branch,
tentatively for v5.10, thanks.

Lorenzo

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
>  .../pci/controller/dwc/pcie-designware-ep.c   | 245 ++++++++++++++----
>  drivers/pci/controller/dwc/pcie-designware.c  |  59 +++--
>  drivers/pci/controller/dwc/pcie-designware.h  |  48 +++-
>  7 files changed, 397 insertions(+), 96 deletions(-)
> 
> -- 
> 2.17.1
> 
