Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE813583569
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 00:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiG0WtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 18:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG0WtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 18:49:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A952BB0F;
        Wed, 27 Jul 2022 15:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88CADB82292;
        Wed, 27 Jul 2022 22:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B18C433D6;
        Wed, 27 Jul 2022 22:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658962146;
        bh=Fk3fRNw7neYbwkL80fsElUIv+y/wuN22YX6LBHbzgAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=te4u4Jp7OG9Rg7FplEPdPoEAfohwrDavepzp6qKRp2vaW63bfKoH/sOpkO4G3v3C6
         ZHpNIextOZ+8+3Fg0rxUYsvTYiy/zYYiffk14OqFGdy+k/lFZ4h6uL8fzdLoslTtNM
         Tdekmz76AwcGrPd0D5sLvOg/IiBmGHb8YHBZ97TT5n2XOXm0CUKDMjIpucQqBB/Uym
         RNLcWtI7oj6YDtP1W/wXRUOBlie6XSdlRU/GnXBxH56BUmrqGQbQzGmcJWH6nXSVgm
         iHYM5ySb8+bg2PGkYxndhasV9HcUxRQ4dfw8TI1jp0OuOyXU46JZdJKUL84Mq45MZj
         YtwkyMRsT28Tg==
Date:   Wed, 27 Jul 2022 17:49:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 00/15] PCI: dwc: Add hw version and dma-ranges
 support
Message-ID: <20220727224904.GA253904@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:32PM +0300, Serge Semin wrote:
> This patchset is a second one in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: In-progress v5] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> [2: In-progress v4] PCI: dwc: Add hw version and dma-ranges support
> Link: ---you are looking at it---

https://lore.kernel.org/r/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru

> [3: In-progress v3] PCI: dwc: Add extended YAML-schema and Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> [4: In-progress v3] dmaengine: dw-edma: Add RP/EP local DMA support
> Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru

Hi Serge, is the above the latest and greatest list?  The 3rd series
doesn't apply cleanly for me:

  05:40:34 ~/linux (main)$ git checkout -b wip/serge v5.19-rc1
  Switched to a new branch 'wip/serge'

  # fetch 1: PCI: dwc: Various fixes and cleanups
  05:40:45 ~/linux (wip/serge)$ b4 am -om/ https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
  Analyzing 37 messages in the thread
  Checking attestation on all messages, may take a moment...
  ---
    ✓ [PATCH v5 1/18] PCI: dwc: Stop link in the host init error and de-initialization
    ✓ [PATCH v5 2/18] PCI: dwc: Add unroll iATU space support to the regions disable method
    ✓ [PATCH v5 3/18] PCI: dwc: Disable outbound windows for controllers with iATU
    ✓ [PATCH v5 4/18] PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
    ✓ [PATCH v5 5/18] PCI: dwc: Deallocate EPC memory on EP init error
      + Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> (✓ DKIM/linaro.org)
    ✓ [PATCH v5 6/18] PCI: dwc: Enable CDM-check independently from the num_lanes value
      + Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> (✓ DKIM/linaro.org)
    ✓ [PATCH v5 7/18] PCI: dwc: Add braces to the multi-line if-else statements
    ✓ [PATCH v5 8/18] PCI: dwc: Add trailing new-line literals to the log messages
    ✓ [PATCH v5 9/18] PCI: dwc: Discard IP-core version checking on unrolled iATU detection
    ✓ [PATCH v5 10/18] PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
    ✓ [PATCH v5 11/18] PCI: dwc: Organize local variables usage
      + Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> (✓ DKIM/linaro.org)
    ✓ [PATCH v5 12/18] PCI: dwc: Re-use local pointer to the resource data
      + Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> (✓ DKIM/linaro.org)
    ✓ [PATCH v5 13/18] PCI: dwc: Add start_link/stop_link inliners
      + Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> (✓ DKIM/linaro.org)
    ✓ [PATCH v5 14/18] PCI: dwc: Move io_cfg_atu_shared to the Root Port descriptor
      + Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> (✓ DKIM/linaro.org)
    ✓ [PATCH v5 15/18] PCI: dwc: Add dw_ prefix to the pcie_port structure name
      + Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> (✓ DKIM/axis.com)
      + Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> (✓ DKIM/linaro.org)
      + Reviewed-by: Neil Armstrong <narmstrong@baylibre.com> (✓ DKIM/baylibre-com.20210112.gappssmtp.com)
    ✓ [PATCH v5 16/18] PCI: dwc-plat: Simplify the probe method return value handling
    ✓ [PATCH v5 17/18] PCI: dwc-plat: Discard unused regmap pointer
    ✓ [PATCH v5 18/18] PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration
    ---
    ✓ Signed: DKIM/baikalelectronics.ru
  ---
  Total patches: 18
  ---
  NOTE: some trailers ignored due to from/email mismatches:
      ! Trailer: Link: https://lore.kernel.org/linux-pci/20220616152048.gcqacgs2ed66vsl4@mobilestation/
       Msg From: Serge Semin <fancer.lancer@gmail.com>
  NOTE: Rerun with -S to apply them anyway
  ---
  Cover: m/v5_20220624_sergey_semin_pci_dwc_various_fixes_and_cleanups.cover
   Link: https://lore.kernel.org/r/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru
   Base: applies clean to current tree
	 git am m/v5_20220624_sergey_semin_pci_dwc_various_fixes_and_cleanups.mbx

  # apply 1: PCI: dwc: Various fixes and cleanups
  05:41:24 ~/linux (wip/serge)$ git am m/v5_20220624_sergey_semin_pci_dwc_various_fixes_and_cleanups.mbx
  Applying: PCI: dwc: Stop link in the host init error and de-initialization
  Applying: PCI: dwc: Add unroll iATU space support to the regions disable method
  Applying: PCI: dwc: Disable outbound windows for controllers with iATU
  Applying: PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
  Applying: PCI: dwc: Deallocate EPC memory on EP init error
  Applying: PCI: dwc: Enable CDM-check independently from the num_lanes value
  Applying: PCI: dwc: Add braces to the multi-line if-else statements
  Applying: PCI: dwc: Add trailing new-line literals to the log messages
  Applying: PCI: dwc: Discard IP-core version checking on unrolled iATU detection
  Applying: PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
  Applying: PCI: dwc: Organize local variables usage
  Applying: PCI: dwc: Re-use local pointer to the resource data
  Applying: PCI: dwc: Add start_link/stop_link inliners
  Applying: PCI: dwc: Move io_cfg_atu_shared to the Root Port descriptor
  Applying: PCI: dwc: Add dw_ prefix to the pcie_port structure name
  Applying: PCI: dwc-plat: Simplify the probe method return value handling
  Applying: PCI: dwc-plat: Discard unused regmap pointer
  Applying: PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration

  # fetch 2: PCI: dwc: Add hw version and dma-ranges support
  05:41:46 ~/linux (wip/serge)$ b4 am -om/ https://lore.kernel.org/r/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
  Looking up https://lore.kernel.org/r/20220624143947.8991-1-Sergey.Semin%40baikalelectronics.ru
  Analyzing 19 messages in the thread
  Checking attestation on all messages, may take a moment...
  ---
    ✓ [PATCH v4 1/15] PCI: dwc: Add more verbose link-up message
    ✓ [PATCH v4 2/15] PCI: dwc: Detect iATU settings after getting "addr_space" resource
    ✓ [PATCH v4 3/15] PCI: dwc: Convert to using native IP-core versions representation
    ✓ [PATCH v4 4/15] PCI: dwc: Add IP-core version detection procedure
    ✓ [PATCH v4 5/15] PCI: dwc: Introduce Synopsys IP-core versions/types interface
    ✓ [PATCH v4 6/15] PCI: intel-gw: Drop manual DW PCIe controller version setup
    ✓ [PATCH v4 7/15] PCI: tegra194: Drop manual DW PCIe controller version setup
    ✓ [PATCH v4 8/15] PCI: dwc: Add host de-initialization callback
    ✓ [PATCH v4 9/15] PCI: dwc: Drop inbound iATU types enumeration - dw_pcie_as_type
    ✓ [PATCH v4 10/15] PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
    ✓ [PATCH v4 11/15] PCI: dwc: Simplify in/outbound iATU setup methods
    ✓ [PATCH v4 12/15] PCI: dwc: Add iATU regions size detection procedure
    ✓ [PATCH v4 13/15] PCI: dwc: Verify in/out regions against iATU constraints
    ✓ [PATCH v4 14/15] PCI: dwc: Check iATU in/outbound ranges setup methods status
    ✓ [PATCH v4 15/15] PCI: dwc: Introduce dma-ranges property support for RC-host
    ---
    ✓ Signed: DKIM/baikalelectronics.ru
  ---
  Total patches: 15
  ---
  NOTE: some trailers ignored due to from/email mismatches:
      ! Trailer: Link: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci%2Fctrl%2Fdwc-fixes
       Msg From: Serge Semin <fancer.lancer@gmail.com>
      ! Trailer: Link: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/edma
       Msg From: Serge Semin <fancer.lancer@gmail.com>
  NOTE: Rerun with -S to apply them anyway
  ---
  Cover: m/v4_20220624_sergey_semin_pci_dwc_add_hw_version_and_dma_ranges_support.cover
   Link: https://lore.kernel.org/r/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
   Base: applies clean to current tree
	 git am m/v4_20220624_sergey_semin_pci_dwc_add_hw_version_and_dma_ranges_support.mbx

  # apply 2: PCI: dwc: Add hw version and dma-ranges support
  05:42:05 ~/linux (wip/serge)$ git am m/v4_20220624_sergey_semin_pci_dwc_add_hw_version_and_dma_ranges_support.mbx
  Applying: PCI: dwc: Add more verbose link-up message
  Applying: PCI: dwc: Detect iATU settings after getting "addr_space" resource
  Applying: PCI: dwc: Convert to using native IP-core versions representation
  Applying: PCI: dwc: Add IP-core version detection procedure
  Applying: PCI: dwc: Introduce Synopsys IP-core versions/types interface
  Applying: PCI: intel-gw: Drop manual DW PCIe controller version setup
  Applying: PCI: tegra194: Drop manual DW PCIe controller version setup
  Applying: PCI: dwc: Add host de-initialization callback
  Applying: PCI: dwc: Drop inbound iATU types enumeration - dw_pcie_as_type
  Applying: PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
  Applying: PCI: dwc: Simplify in/outbound iATU setup methods
  Applying: PCI: dwc: Add iATU regions size detection procedure
  Applying: PCI: dwc: Verify in/out regions against iATU constraints
  Applying: PCI: dwc: Check iATU in/outbound ranges setup methods status
  Applying: PCI: dwc: Introduce dma-ranges property support for RC-host

  # fetch 3: PCI: dwc: Add extended YAML-schema and Baikal-T1 support
  05:42:40 ~/linux (wip/serge)$ b4 am -om/ https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
  Analyzing 51 messages in the thread
  Checking attestation on all messages, may take a moment...
  ---
    ✓ [PATCH v3 1/17] dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
    ✓ [PATCH v3 2/17] dt-bindings: PCI: dwc: Remove bus node from the examples
      + Reviewed-by: Rob Herring <robh@kernel.org>
    ✓ [PATCH v3 3/17] dt-bindings: PCI: dwc: Add phys/phy-names common properties
    ✓ [PATCH v3 4/17] dt-bindings: PCI: dwc: Add max-link-speed common property
    ✓ [PATCH v3 5/17] dt-bindings: PCI: dwc: Stop selecting generic bindings by default
    ✓ [PATCH v3 6/17] dt-bindings: PCI: dwc: Add max-functions EP property
      + Reviewed-by: Rob Herring <robh@kernel.org>
    ✓ [PATCH v3 7/17] dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
    ✓ [PATCH v3 8/17] dt-bindings: PCI: dwc: Add reg/reg-names common properties
    ✓ [PATCH v3 9/17] dt-bindings: PCI: dwc: Add clocks/resets common properties
    ✓ [PATCH v3 10/17] dt-bindings: PCI: dwc: Add dma-coherent property
    ✓ [PATCH v3 11/17] dt-bindings: PCI: dwc: Apply common schema to Rockchip DW PCIe nodes
    ✓ [PATCH v3 12/17] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
    ✓ [PATCH v3 13/17] PCI: dwc: Introduce generic controller capabilities interface
      + Reviewed-by: Rob Herring <robh@kernel.org>
    ✓ [PATCH v3 14/17] PCI: dwc: Introduce generic resources getter
      + Reviewed-by: Rob Herring <robh@kernel.org>
    ✓ [PATCH v3 15/17] PCI: dwc: Combine iATU detection procedures
      + Reviewed-by: Rob Herring <robh@kernel.org>
    ✓ [PATCH v3 16/17] PCI: dwc: Introduce generic platform clocks and resets
    ✓ [PATCH v3 17/17] PCI: dwc: Add Baikal-T1 PCIe controller support
    ---
    ✓ Signed: DKIM/baikalelectronics.ru
  ---
  Total patches: 17
  ---
  NOTE: some trailers ignored due to from/email mismatches:
      ! Trailer: Link: https://lore.kernel.org/linux-pci/20220610091459.17612-23-Sergey.Semin@baikalelectronics.ru/
       Msg From: Serge Semin <fancer.lancer@gmail.com>
      ! Trailer: Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru/
       Msg From: Serge Semin <fancer.lancer@gmail.com>
  NOTE: Rerun with -S to apply them anyway
  ---
  Cover: m/v3_20220610_sergey_semin_pci_dwc_add_generic_resources_and_baikal_t1_support.cover
   Link: https://lore.kernel.org/r/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru
   Base: not specified
	 git am m/v3_20220610_sergey_semin_pci_dwc_add_generic_resources_and_baikal_t1_support.mbx

  # apply 3: PCI: dwc: Add extended YAML-schema and Baikal-T1 support
  05:42:58 ~/linux (wip/serge)$ git am m/v3_20220610_sergey_semin_pci_dwc_add_generic_resources_and_baikal_t1_support.mbx
  Applying: dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
  error: patch failed: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml:36
  error: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml: patch does not apply
  error: patch failed: Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml:37
  error: Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml: patch does not apply
  Patch failed at 0001 dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
  hint: Use 'git am --show-current-patch' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".
  05:43:07 ~/linux (wip/serge|AM 1/17)$
