Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8730742BC50
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbhJMKCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 06:02:13 -0400
Received: from foss.arm.com ([217.140.110.172]:59718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239124AbhJMKCN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 06:02:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B94F91063;
        Wed, 13 Oct 2021 03:00:09 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994AD3F70D;
        Wed, 13 Oct 2021 03:00:07 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:00:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, svarbanov@mm-sol.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 0/5] Add DT bindings and DT nodes for PCIe and PHY in
 SC7280
Message-ID: <20211013100005.GB9901@lpieralisi>
References: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 07, 2021 at 11:18:38PM +0530, Prasad Malisetty wrote:
> Changes added in v12:
> 
> 	* Sorted pipe_clk muxing changes in patch 4 & 5 as per the commit log.
> 	  -Suggested by Bjorn.
> 
> Changes added in v11:
> 
> 	* Modified nvme_pwren name as nvme_pwren.
> 	* Removed bias-pullup option in nvme_pwren entry [v11 Patch 3/5].
> 	* Changed pcie1_default_state name to pcie1_clkreq_n.
> 	* Added NULL pointer check for pcie_cfg.
> 
> Changes added in v10:
> 
> 	* v9 [Patch 4/4/] has been split into two separate patches
> 	* Addressed all comments in IDP [Patch 3/4] file.
>  	
> Changes added in v9:
>     * Added fixed regulator entry for nvme.suggested by Stephen Boyd
>     * Added NULL pointer check before accessing ops in pcie probe
>       Suggested by Stephen Boyd
> 
> Changes added in v8:
> 
>     * Added seperate pinctrl state for NVMe LDO enable pin [v8 P3/4]
>     * Removed pointer initialization for pcie_cfg [v8 P4/4]
>     * Replaced bool pcie_pipe_clk_src with unsigned int:1 [v8 P4/4]
>     * Changed gcc_pcie_1_pipe_clk_src to pipe_clk_src
> 
> Changes added in v7:
> 
>         * Removed two fallbacks qcom,pcie-sm8250 and snps,dw-pcie.
>         * Replaced compatible method in get_resources_2_7_0 with
>             flag approach suggested by Bjorn Helgaas .
>         * Setting gcc_pcie_1_clk_src as XO in init_2_7_0 for
>           gdsc enable.
>         * Added specific NVMe GPIO entries for SKU1 and SKU2 support
>           in idp.dts and idp2.dts respectively.
>         * Moved pcie_1 and pcie_1_phy board specific entries into common
>           board file sc7280-idp.dtsi file.
> 
> Changes in v6:
> 
>     * Removed platform check while setting gcc_pcie_1_pipe_clk_src
>           as clk_set_parent will return 0 with nop if platform doesn't
>           need to switch pipe clk source.
>         * Moved wake-n gpio to board specific file sc7280-idp.dtsi
>         * Sorted gpio.h header entry in sc7280.dtsi file
> 
> Changes in v5:
> 
>         * Re ordered PCIe, PHY nodes in Soc and board specific dtsi files.
>         * Removed ref_clk entry in current patch [PATCH v4 P4/4].
>         * I will add ref clk entry in suspend/ resume commits.
>         * Added boolean flag in Soc specific dtsi file to differentiate
>           SM8250 and SC7280 platforms. based on boolean flag, platforms will handle
>           the pipe clk handling.
> 
> Changes in v4 as suggested by Bjorn:
> 
>         * Changed pipe clk mux name as gcc_pcie_1_pipe_clk_src.
>         * Changed pipe_ext_src as phy_pipe_clk.
>         * Updated commit message for [PATCH v4 4/4].
> 
> Changes in v3:
>         * Changed pipe clock names in dt bindings as pipe_mux and phy_pipe.
>         * Moved reset and NVMe GPIO pin configs into board specific file.
>         * Updated pipe clk mux commit message.
> 
> Changes in v2:
>         * Moved pcie pin control settings into IDP file.
>         * Replaced pipe_clk_src with pipe_clk_mux in pcie driver
>         * Included pipe clk mux setting change set in this series
> 
> Prasad Malisetty (5):
>   dt-bindings: pci: qcom: Document PCIe bindings for SC7280
>   arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes
>   arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
>   PCI: qcom: Add a flag in match data along with ops
>   PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  17 +++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts            |   8 ++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  50 +++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp2.dts           |   8 ++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 118 +++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom.c             |  95 +++++++++++++++--
>  6 files changed, 285 insertions(+), 11 deletions(-)

I applied patches [4-5] to pci/qcom for v5.16, thanks I expect other
patches to go via the relevant trees.

Lorenzo
