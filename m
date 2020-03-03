Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB6177CA4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 18:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgCCRBd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 12:01:33 -0500
Received: from foss.arm.com ([217.140.110.172]:49824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbgCCRBd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 12:01:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C5CE2F;
        Tue,  3 Mar 2020 09:01:32 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B8393F534;
        Tue,  3 Mar 2020 09:01:30 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:01:16 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 0/5] Add support for PCIe endpoint mode in Tegra194
Message-ID: <20200303170103.GA9641@e121166-lin.cambridge.arm.com>
References: <20200303105418.2840-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303105418.2840-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 03, 2020 at 04:24:13PM +0530, Vidya Sagar wrote:
> Tegra194 has three (C0, C4 & C5) dual mode PCIe controllers that can operate
> either in root port mode or in end point mode but only in one mode at a time.
> Platform P2972-0000 supports enabling endpoint mode for C5 controller. This
> patch series adds support for PCIe endpoint mode in both the driver as well as
> in DT.
> This patch series depends on the changes made for Synopsys DesignWare endpoint
> mode subsystem that are recently accepted.
> @ https://patchwork.kernel.org/project/linux-pci/list/?series=202211
> which in turn depends on the patch made by Kishon
> @ https://patchwork.kernel.org/patch/10975123/
> which is also under review.
> 
> V4:
> * Started using threaded irqs instead of kthreads

Hi Vidya,

sorry for the bother, may I ask you to rebase the series (after
answering Thierry's query) on top of my pci/endpoint branch please ?

Please resend it and I will merge patches {1,2,5} then.

Thanks,
Lorenzo

> V3:
> * Re-ordered patches in the series to make the driver change as the last patch
> * Took care of Thierry's review comments
> 
> V2:
> * Addressed Thierry & Bjorn's review comments
> * Added EP mode specific binding documentation to already existing binding documentation file
> * Removed patch that enables GPIO controller nodes explicitly as they are enabled already
> 
> Vidya Sagar (5):
>   soc/tegra: bpmp: Update ABI header
>   dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
>   arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
>   arm64: tegra: Add support for PCIe endpoint mode in P2972-0000
>     platform
>   PCI: tegra: Add support for PCIe endpoint mode in Tegra194
> 
>  .../bindings/pci/nvidia,tegra194-pcie.txt     | 125 +++-
>  .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  18 +
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  99 +++
>  drivers/pci/controller/dwc/Kconfig            |  30 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 681 +++++++++++++++++-
>  include/soc/tegra/bpmp-abi.h                  |  10 +-
>  6 files changed, 918 insertions(+), 45 deletions(-)
> 
> -- 
> 2.17.1
> 
