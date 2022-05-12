Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD2452572E
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353016AbiELVlx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358786AbiELVlw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 17:41:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA9956FA10;
        Thu, 12 May 2022 14:41:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78550106F;
        Thu, 12 May 2022 14:41:50 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.4.238])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84BA23F66F;
        Thu, 12 May 2022 14:41:48 -0700 (PDT)
Date:   Thu, 12 May 2022 22:41:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] PCI: dwc: Various fixes and cleanups
Message-ID: <Yn1/GRzXNCTJnMHj@lpieralisi>
References: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 12:22:47AM +0300, Serge Semin wrote:
> This patchset is a second one in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: In-progress v3] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> Link: https://lore.kernel.org/linux-pci/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
> [2: In-progress v2] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> [3: In-progress v1] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
> [4: In-progress v1] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
> 
> Note it is very recommended to merge the patchsets in the same order as
> they are placed in the list above in order to prevent possible merge/build
> conflicts. Nothing prevents them from being reviewed synchronously though.
> 
> As it can be easily inferred from the patchset title, this series is about
> the DW PCIe Root Port/End-point driver fixes and the code cleanups, where
> fixes come before the cleanup patches. The patchset starts with adding the
> stop_link() platform-specific method invocation in case of the PCIe host
> probe procedure errors. It has been missing in the cleanup-on-error path
> of the DW PCIe Host initialization method. After that there is a patch
> which fixes the host own cfg-space accessors for the case of the
> platform-specific DBI implementation. Third the unrolled CSRs layout is
> added to the iATU disable procedure. Fourth the disable iATU procedure is
> fixed to be called only for the internal ATU as being specific for the
> internal ATU implementation. Last but no least the outbound iATU extended
> region setup procedure is fixed to have the INCREASE_REGION_SIZE flag set
> based on the limit-address - not the region size one.
> 
> Afterwards there is a series of cleanups. It concerns the changes like
> adding braces to the multi-line if-else constructions, trailing new-lines
> to the print format-string, dropping unnecessary version checking, and
> various code simplifications and optimizations.

Hi,

I went through the series and I don't have any specific objections.

We can try to queue it for v5.19, with the caveat that the fixes
_need_ testing on several DWC platforms (and I _strongly_ encourage
DWC maintainers to chime in). To sum it up:

- It is a mixture of clean-ups and fixes. I would prefer having the
  cleanups earlier in the series and rebase (if there is a need, I
  can try to reshuffle the patches myself) the fixes on top. That
  because we may have to drop some of the fixes (and if we merge them
  we may have to revert them as cleanly as we can), my concern is that
  they require testing on a number of platforms you have not been
  exposed to
- Kbot complained about patch (3)
- I will have comments about the commit logs but I can try to fix them
  myself

I have concerns especially about patches (2, 3, 4, 5, 8, 9), because
they can affect DWC platforms other than the ones you are testing on.

The cleanups we can definitely queue them up. As I said, and there
is nothing I can do about it, I will be off the radar for two months
from wednesday, please try to repost with the Kbot issue fixed and
with the comments above in mind and I will do my best to queue as
many patches from this series as possible for v5.19.

Thanks,
Lorenzo

> New features like adding two-level DT bindings abstraction, adding better
> structured IP-core version interface, adding iATU regions size detection
> and the PCIe regions verification procedure, adding dma-ranges support,
> introducing a set of generic platform clocks and resets and finally adding
> Baikal-T1 PCIe interface support will be submitted in the next part of the
> series.
> 
> Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Fix the end address of the example in the patch log with
>   the INCREASE_REGION_SIZE flag usage fixup. It should be
>   0x1000FFFF and not 0x0000FFFF (@Manivannan).
> - Add the cleanup-on-error path to the dw_pcie_ep_init() function.
>   (@Manivannan)
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (13):
>   PCI: dwc: Stop link in the host init error and de-initialization
>   PCI: dwc: Don't use generic IO-ops for DBI-space access
>   PCI: dwc: Add unroll iATU space support to the regions disable method
>   PCI: dwc: Disable outbound windows for controllers with iATU
>   PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
>   PCI: dwc: Add braces to the multi-line if-else statements
>   PCI: dwc: Add trailing new-line literals to the log messages
>   PCI: dwc: Discard IP-core version checking on unrolled iATU detection
>   PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
>   PCI: dwc: Deallocate EPC memory on EP init error
>   PCI: dwc-plat: Simplify the probe method return value handling
>   PCI: dwc-plat: Discard unused regmap pointer
>   PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 22 +++++--
>  .../pci/controller/dwc/pcie-designware-host.c | 66 +++++++++++++++----
>  .../pci/controller/dwc/pcie-designware-plat.c | 13 ++--
>  drivers/pci/controller/dwc/pcie-designware.c  | 48 +++++++++-----
>  4 files changed, 109 insertions(+), 40 deletions(-)
> 
> -- 
> 2.35.1
> 
