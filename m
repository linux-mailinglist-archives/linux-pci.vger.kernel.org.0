Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C912D2812
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 10:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgLHJsG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 04:48:06 -0500
Received: from foss.arm.com ([217.140.110.172]:46448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgLHJsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 04:48:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEEDC30E;
        Tue,  8 Dec 2020 01:47:19 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88A03F68F;
        Tue,  8 Dec 2020 01:47:17 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:47:12 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org
Subject: Re: [PATCH v5 0/5] Add PCIe support for SM8250 SoC
Message-ID: <20201208094712.GA30430@e121166-lin.cambridge.arm.com>
References: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 10:30:28PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds PCIe support for Qualcomm SM8250 SoC with relevant PHYs.
> There are 3 PCIe instances on this SoC each with different PHYs. The PCIe
> controller and PHYs are mostly comaptible with the ones found on SDM845
> SoC, hence the old drivers are modified to add the support.
> 
> This series has been tested on RB5 board with QCA6391 chipset connected
> onboard.

Hi,

I would be merging this series, I understand patch {2) was already
taken by Vinod - should I take {1,3,4,5} via the pci tree ?

Thanks,
Lorenzo

> Thanks,
> Mani
> 
> Changes in v5:
> 
> * Added Review tags from Rob
> * Cleaned up the bdf to sid patch after discussing with Tony
> 
> Changes in v4:
> 
> * Fixed an issue with tx_tbl_sec in PHY driver
> 
> Changes in v3:
> 
> * Rebased on top of phy/next
> * Renamed ops_sm8250 to ops_1_9_0 to maintain uniformity
> 
> Changes in v2:
> 
> * Fixed the PHY and PCIe bindings
> * Introduced secondary table in PHY driver to abstract out the common configs.
> * Used a more generic way of configuring BDF to SID mapping
> * Dropped ATU change in favor of a patch spotted by Rob
> 
> Manivannan Sadhasivam (5):
>   dt-bindings: phy: qcom,qmp: Add SM8250 PCIe PHY bindings
>   phy: qcom-qmp: Add SM8250 PCIe QMP PHYs
>   dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
>   PCI: qcom: Add SM8250 SoC support
>   PCI: qcom: Add support for configuring BDF to SID mapping for SM8250
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     |   6 +-
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml |   6 +
>  drivers/pci/controller/dwc/Kconfig            |   1 +
>  drivers/pci/controller/dwc/pcie-qcom.c        |  92 ++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 281 +++++++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |  18 ++
>  6 files changed, 398 insertions(+), 6 deletions(-)
> 
> -- 
> 2.17.1
> 
