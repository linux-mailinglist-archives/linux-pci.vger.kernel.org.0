Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB51157E995
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jul 2022 00:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiGVWR3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 18:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiGVWR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 18:17:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D048AECC;
        Fri, 22 Jul 2022 15:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEABA621E8;
        Fri, 22 Jul 2022 22:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A4FC341C6;
        Fri, 22 Jul 2022 22:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658528247;
        bh=td+YTMshEeyZGR/evZyRigCvIWW9VLZJZY+E/aX4XtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S1ndK01/ka7GJbgw/cDPqIQy+34bqZ9cz0xCTuY/CdrGB80SKtQKydn5MfoLX3dBb
         tIamNlcJei626DkoXe4l5sa+yCoRsCQRV6HiU98yxYX6Qf+Xio79GY8oFBf3P6/m97
         kDRQj2WaYbZXSQvoOA0uBuDgCcn0UkHsD8IhiKUhbT90HV5mqKVxK+fzLPpapScxRt
         SyIU0D3BVrQcjPUCwwZXz3pt6vmNdH4SZHTMiffdg9QuJn94S38ReBfjpDRLc793s3
         D7D1v4U2fjy2fWvFB5vQ2d1lAQLw8ollZ8vDeGKhMOt0rkn3ABl2NVIe+AsK6A8qJj
         ibs3Vt+kwsgrw==
Date:   Fri, 22 Jul 2022 17:17:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, kw@linux.com, kishon@ti.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 00/16] PCI: tegra: Add Tegra234 PCIe support
Message-ID: <20220722221725.GA1945889@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 07:50:36PM +0530, Vidya Sagar wrote:
> Tegra234 has a total of 11 PCIe controllers based on Synopsys DesignWare core.
> There are three Universal PHY (UPHY) blocks (viz. HSIO, NVHS and GBE) with
> each block supporting 8 lanes respectively. Controllers:0~4 use UPHY lanes
> from HSIO block, Controllers:5,6 use UPHY lanes from NVHS block and
> Controllers:7~10 use UPHY lanes from GBE block. Lane mapping in each block
> is controlled in XBAR module by BPMP-FW. Since PCIe core has PIPE interface,
> a glue module called PIPE-to-UPHY (P2U) is used to connect each UPHY lane
> (applicable to all three UPHY bricks i.e. HSIO/NVHS/GBE) to PCIe controller.
> All the controllers can operate in the RootPort mode where as only controllers
> C5, C6, C7 and C10 can operate in the EndPoint mode.
> 
> This patch series
> - Adds support for Tegra234 in the existing P2U PHY driver
> - Adds support for Tegra234 in the existing PCIe platform controller driver
> - Adds device tree nodes for all PCIe controllers
> - Enables nodes applicable to P3737-0000 platform
> 
> Testing done on P3737-0000 platform
> - PCIe link is up with on-board Broadcom WiFi controller
> 
> - PCIe link is up with an NVMe drive connected to M.2 Key-M slot and its
>   functionality is verified
> 
> - PCIe link is up with a variety of cards (NICs and USB3.0 add-on cards)
>   connected to CEM slot and their functionality is verified
> 
> - PCIe link is up with C5 controller configured for the endpoint mode with
>   a host
> 
> V6:
> * Addressed review comments from Bjorn
> * Moved out non-Tegra234 specific changes and created separate patches
> 
> V5:
> * Addressed review comments from Rob
> 
> V4:
> * Addressed review comments from Krzysztof and Rob
> * Changes are only in schema files and regulator patch
> * Dropped PHY related patches as they are already accepted
> 
> V3:
> * Add DT nodes for the controllers that can work in the EndPoint mode
> * Converted the existing device-tree binding documentation from .txt to .yaml
> * Add T234 specific information to the RP and EP .yaml documentation files
> * Added regulators required to power up required power rails
> 
> V2:
> * Dropped 3 patches that add clocks & resets IDs, power-domain IDs and
>   memory IDs for PCIe controllers as the patches are already available
>   in linux-next
> * Based on Bjorn's review comment, reverted the commit b57256918399 ("PCI:
>   tegra194: Rename tegra_pcie_dw to tegra194_pcie") and pushed it as a
>   separate patch before adding support for T234 in the existing driver
> * Addressed review comments from Rob for the other changes
> 
> Vidya Sagar (16):
>   dt-bindings: pci: tegra: Convert to json-schema
>   dt-bindings: PCI: tegra234: Add schema for tegra234 rootport mode
>   dt-bindings: PCI: tegra234: Add schema for tegra234 endpoint mode
>   arm64: tegra: Add regulators required for PCIe
>   arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT
>   arm64: tegra: Enable PCIe slots in P3737-0000 board
>   PCI: Disable MSI for Tegra234 root ports
>   Revert "PCI: tegra194: Rename tegra_pcie_dw to tegra194_pcie"
>   PCI: tegra194: Find RAS DES PCIe capability offset
>   PCI: tegra194: Fix root port interrupt handling
>   PCI: tegra194: Clear bandwidth management status
>   PCI: tegra194: Enable support for 256 Byte payload
>   PCI: tegra194: Cleanup the exit path for endpoint mode
>   PCI: tegra194: Fix link up retry sequence
>   PCI: tegra194: Extend endpoint mode support
>   PCI: tegra: Add Tegra234 PCIe support

I applied these (except the arch/arm64 .dtsi changes, which I assume
should go via arm-soc) to pci/ctrl/tegra194 for v5.20, thanks!

>  .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 318 ++++++
>  .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----
>  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 349 +++++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
>  .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |  36 +
>  .../nvidia/tegra234-p3737-0000+p3701-0000.dts |  51 +
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 927 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  19 +
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 658 ++++++++-----
>  drivers/pci/quirks.c                          |  13 +-
>  10 files changed, 2136 insertions(+), 484 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> 
> -- 
> 2.17.1
> 
