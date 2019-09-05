Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07387A9E76
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 11:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfIEJew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 05:34:52 -0400
Received: from foss.arm.com ([217.140.110.172]:40346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731084AbfIEJew (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 05:34:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 366941576;
        Thu,  5 Sep 2019 02:34:51 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E9E3F67D;
        Thu,  5 Sep 2019 02:34:48 -0700 (PDT)
Date:   Thu, 5 Sep 2019 10:34:44 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 0/6] PCI: tegra: Enable PCIe C5 controller of Tegra194
 in p2972-0000 platform
Message-ID: <20190905093444.GA16642@e121166-lin.cambridge.arm.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
 <7751a77d-5812-49b7-0c6b-00e6740e209b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7751a77d-5812-49b7-0c6b-00e6740e209b@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 01:44:46PM +0530, Vidya Sagar wrote:
> Hi Lorenzo / Bjorn,
> Can you please review this series?
> I have Reviewed-by and Acked-by from Rob, Thierry and Andrew already.

Rebase it on top of my pci/tegra branch (it does not apply),
resend it and I will merge it.

Thanks,
Lorenzo

> Thanks,
> Vidya Sagar
> 
> On 8/28/2019 10:58 PM, Vidya Sagar wrote:
> > This patch series enables Tegra194's C5 controller which owns x16 slot in
> > p2972-0000 platform. C5 controller's PERST# and CLKREQ# are not configured as
> > output and bi-directional signals by default and hence they need to be
> > configured explicitly. Also, x16 slot's 3.3V and 12V supplies are controlled
> > through GPIOs and hence they need to be enabled through regulator framework.
> > This patch series adds required infrastructural support to address both the
> > aforementioned requirements.
> > Testing done on p2972-0000 platform
> > - Able to enumerate devices connected to x16 slot (owned by C5 controller)
> > - Enumerated device's functionality verified
> > - Suspend-Resume sequence is verified with device connected to x16 slot
> > 
> > V3:
> > * Addressed some more review comments from Andrew Murray and Thierry Reding
> > 
> > V2:
> > * Changed the order of patches in the series for easy merging
> > * Addressed review comments from Thierry Reding and Andrew Murray
> > 
> > Vidya Sagar (6):
> >    dt-bindings: PCI: tegra: Add sideband pins configuration entries
> >    dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
> >    PCI: tegra: Add support to configure sideband pins
> >    PCI: tegra: Add support to enable slot regulators
> >    arm64: tegra: Add configuration for PCIe C5 sideband signals
> >    arm64: tegra: Add PCIe slot supply information in p2972-0000 platform
> > 
> >   .../bindings/pci/nvidia,tegra194-pcie.txt     | 16 ++++
> >   .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 24 +++++
> >   .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  4 +-
> >   arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 38 +++++++-
> >   drivers/pci/controller/dwc/pcie-tegra194.c    | 94 ++++++++++++++++++-
> >   5 files changed, 172 insertions(+), 4 deletions(-)
> > 
> 
