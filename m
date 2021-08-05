Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4543E1190
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhHEJnA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 05:43:00 -0400
Received: from foss.arm.com ([217.140.110.172]:41868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234746AbhHEJm7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 05:42:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 342BA6D;
        Thu,  5 Aug 2021 02:42:45 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B7A73F719;
        Thu,  5 Aug 2021 02:42:42 -0700 (PDT)
Date:   Thu, 5 Aug 2021 10:42:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] arm64: IPQ6018 PCIe support
Message-ID: <20210805094237.GA18330@lpieralisi>
References: <cover.1620203062.git.baruch@tkos.co.il>
 <87o8acxtqm.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8acxtqm.fsf@tarshish>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 09:58:57AM +0300, Baruch Siach wrote:
> Hi Lorenzo, Rob, Krzysztof,
> 
> On Wed, May 05 2021, Baruch Siach wrote:
> > This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is 
> > ported from downstream Codeaurora v5.4 kernel. The main difference from 
> > downstream code is the split of PCIe registers configuration from .init to 
> > .post_init, since it requires phy_power_on().
> >
> > Tested on IPQ6010 based hardware.
> 
> It's been 3 months with no comment. Would you consider applying the dwc
> part (patches #1 and #2) for the v5.15 merge window?
> 
> I tested the patches here successfully on top of v5.14-rc4.

You need an ACK from the respective drivers maintainers. We look into
overall pci/controller drivers structure and common code, it is up
to drivers maintainers to review and ACK your patches, I will certainly
pick them up when that's done.

Thanks,
Lorenzo

> Thanks,
> baruch
> 
> >
> > Changes in v2:
> >
> >   * Add patch moving GEN3_RELATED macros to a common header
> >
> >   * Drop ATU configuration from pcie-qcom
> >
> >   * Remove local definition of common registers
> >
> >   * Use bulk clk and reset APIs
> >
> >   * Remove msi-parent from device-tree
> >
> > Baruch Siach (3):
> >   PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
> >   dt-bindings: phy: qcom,qmp: Add IPQ60xx PCIe PHY bindings
> >   dt-bindings: pci: qcom: Document PCIe bindings for IPQ6018 SoC
> >
> > Selvam Sathappan Periakaruppan (3):
> >   PCI: qcom: add support for IPQ60xx PCIe controller
> >   phy: qcom-qmp: add QMP V2 PCIe PHY support for ipq60xx
> >   arm64: dts: ipq6018: Add pcie support
> >
> >  .../devicetree/bindings/pci/qcom,pcie.txt     |  24 +++
> >  .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  25 +++
> >  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  99 ++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h  |   7 +
> >  drivers/pci/controller/dwc/pcie-qcom.c        | 150 ++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |   6 -
> >  drivers/phy/qualcomm/phy-qcom-qmp.c           | 147 +++++++++++++++++
> >  drivers/phy/qualcomm/phy-qcom-qmp.h           | 132 +++++++++++++++
> >  8 files changed, 584 insertions(+), 6 deletions(-)
> 
> 
> -- 
>                                                      ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
