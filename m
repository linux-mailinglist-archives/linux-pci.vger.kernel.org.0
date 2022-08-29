Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22E25A46CF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 12:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiH2KJp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 06:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiH2KJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 06:09:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175635FAE2;
        Mon, 29 Aug 2022 03:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7789B80E4F;
        Mon, 29 Aug 2022 10:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A021EC433C1;
        Mon, 29 Aug 2022 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661767774;
        bh=9sKH2mSrNaQ7LI9aJ4fsaCG5CDcmGfP79u2J90WddVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rno65nTxDVtYMgFdz8vao5f3j8OXd7ViF39CscvYdK+jVWPM91SYt4teT0adZIF12
         hHzVklXYnsegVB1kkWLw5r1WOpkb1IDoNmMp6MMBL1Dafhn6tAjMCbiEhysjHdgvcg
         qjXCh6TSGCWHGzAtpDjn76LUh7+YodAvwAoXFoOwiZw62tCGGCpzdJbLnPjviw1Ijt
         4JH0CIkzEQ2dBYQOx1pfuWrVGfF8ScKjo7nmyYNrrTs1iZwgtTX+pf8cSh/Ur3wOGP
         VICIa03kjUN78Q+ym/NVdpelWd829HOdy+AdVmrjzUI8C4aKnpqx6Gw6xGI+aLIHuQ
         TlyuqQW4WtQIg==
Date:   Mon, 29 Aug 2022 12:09:24 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/20] PCI: dwc: Add generic resources and Baikal-T1
 support
Message-ID: <YwyQVAer0YRA406o@lpieralisi>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 22, 2022 at 09:46:41PM +0300, Serge Semin wrote:
> This patchset is a third one in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: Done v5] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> Merged: kernel 6.0-rc1
> [2: Done v4] PCI: dwc: Add hw version and dma-ranges support
> Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
> Merged: kernel 6.0-rc1
> [3: In-review v5] PCI: dwc: Add generic resources and Baikal-T1 support
> Link: ---you are looking at it---
> [4: Done v4] dmaengine: dw-edma: Add RP/EP local DMA support
> Link: https://lore.kernel.org/linux-pci/20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru/
> 
> Note it is very recommended to merge the patchsets in the same order as
> they are listed in the set above in order to have them applied smoothly.
> Nothing prevents them from being reviewed synchronously though.
> 
> Originally the patches submitted in this patchset were a part of the series:
> Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> but due to the reviewers requests the series was expanded to about 30
> patches which made it too bulky for a comfortable review. So I decided to
> split it up into two patchsets: 2. and 3. in the table above.
> 
> Regarding the series content. This patchset is mainly about adding new DW
> PCIe platform support - Baikal-T1 PCIe of DW PCIe v4.60a IP-core. But a
> set of feature-reach preparations are done first. It starts from
> converting the currently available DT-schema into a more flexible schemas
> hierarchy with separately defined regs, clocks, resets and interrupts
> properties. As a result the common schema can be easily re-used by all the
> currently available platforms while the named properties above can be
> either re-defined or used as is if the platforms support they. In the
> framework of that modification we also suggest to add a set of generic
> regs, clocks, resets and interrupts resource names in accordance with what
> the DW PCIe hardware reference manual describes and what the DW PCIe core
> driver already expects to be specified. Thus the new platform driver will
> be able to re-use the common resources infrastructure.
> 
> Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Rename 'syscon' property to 'baikal,bt1-syscon'. (@Rob)
> - Move the iATU region selection procedure into a helper function (@Rob).
> - Rebase from kernel v5.17 onto v5.18-rc3 since the later kernel has
>   already DT bindings converted. (@Rob)
> - Use 'definitions' property instead of the '$defs' one. It fixes the
>   dt-validate error: 'X is not of type array.'
> - Drop 'interrupts' and 'interrupt-names' property from being required
>   for the native DW PCIe host.
> - Evaluate the 'snps,dw-pcie-common.yaml' schema in the
>   'socionext,uniphier-pcie-ep.yaml' DT-bindings since the later has
>   platform-specific names defined.
> 
> Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru
> Changelog v3:
> - Split up the patch "dt-bindings: PCI: dwc: Define common and native DT
>   bindings" into a series of modifications. (@Rob)
> - Detach this series of the patches into a dedicated patchset.
> - Add a new feature patch: "PCI: dwc: Introduce generic controller
>   capabilities interface".
> - Add a new feature patch: "PCI: dwc: Introduce generic resources getter".
> - Add a new cleanup patch: "PCI: dwc: Combine iATU detection procedures".
> - Add a method to at least request the generic clocks and resets. (@Rob)
> - Add GPIO-based PERST# signal support to the core module.
> - Redefine Baikal-T1 PCIe host bridge config space accessors with the
>   pci_generic_config_read32() and pci_generic_config_write32() methods.
>   (@Rob)
> - Drop synonymous from the names list in the common DT-schema since the
>   device sub-schemas create their own enumerations anyway.
> - Rebase onto kernel v5.18.
> 
> Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v4:
> - Drop PCIBIOS_* macros usage. (@Rob)
> - Add "static const" to the dw_pcie_ops and dw_pcie_host_ops structure
>   instances. (@Bjorn)
> - Rename bt1_pcie_dw_ops to bt1_pcie_ops. (@Bjorn)
> - Rename bt1_pcie_ops to bt1_pci_ops. (@Bjorn)
> - Use start_link/stop_link suffixes in the Baikal-T1 PCIe
>   start/stop link callbacks. (@Bjorn)
> - Change the get_res() method suffix to being get_resources(). (@Bjorn)
> - Change *_{add,del}_dw_port() method to *_{add,del}_port(). (@Bjorn)
> - Drop dma_coerce_mask_and_coherent() applied to the PCI host bridge
>   kernel device instance. (@Bjorn)
> - Add the comment above the dma_set_mask_and_coherent() method usage
>   regarding the controller eDMA feature. (@Bjorn)
> - Fix the comment above the core reset controls assertion. (@Bjorn)
> - Replace delays and timeout numeric literals with macros. (@Bjorn)
> - Convert the method name from dw_pcie_get_res() to
>   dw_pcie_get_resources(). (@Bjorn)
> - Rebase onto the kernel v5.19-rcX.
> 
> Link: https://lore.kernel.org/linux-pci/20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v5:
> - Add a note about having line-based PHY phandles order. (@Rob)
> - Prefer 'pcie[0-9]+' PHY-names over the rest of the cases. (@Rob)
> - Drop generic fallback names from the Baikal-T1 compatible property
>   constraints. (@Rob)
> - Define ordered {reg,interrupt,clock,reset}-names Baikal-T1 PCIe
>   properties. (@Rob)
> - Drop minItems from the Baikal-T1 PCIe clocks and reset properties,
>   since it equals to the maxItems for them.
> - Drop num-ob-windows and num-ib-windows properties constraint from
>   Baikal-T1 PCIe bindings. (@Rob)
> - Add a note about having line-based PHY phandles order. (@Rob)
> - Prefer 'pcie[0-9]+' PHY-names over the rest of the cases. (@Rob)
> - Add platform-specific reg/interrupt/clock/reset names to the generic
>   schema, but mark them as deprecated.
> - Add new patches:
>   dt-bindings: visconti-pcie: Fix interrupts array max constraints
>   dt-bindings: imx6q-pcie: Fix clock names for imx6sx and imx8mq

Are these two new patches linked to the remainder of the series ?

Thanks,
Lorenzo

> - Move the patch:
>   PCI: dwc: Introduce dma-ranges property support for RC-host
>   from the previous patchset in here. (@Bjorn)
> - Rebase onto the kernel v6.0-rc2.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: linux-pci@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (20):
>   dt-bindings: imx6q-pcie: Fix clock names for imx6sx and imx8mq
>   dt-bindings: visconti-pcie: Fix interrupts array max constraints
>   dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
>   dt-bindings: PCI: dwc: Remove bus node from the examples
>   dt-bindings: PCI: dwc: Add phys/phy-names common properties
>   dt-bindings: PCI: dwc: Add max-link-speed common property
>   dt-bindings: PCI: dwc: Apply generic schema for generic device only
>   dt-bindings: PCI: dwc: Add max-functions EP property
>   dt-bindings: PCI: dwc: Add interrupts/interrupt-names common
>     properties
>   dt-bindings: PCI: dwc: Add reg/reg-names common properties
>   dt-bindings: PCI: dwc: Add clocks/resets common properties
>   dt-bindings: PCI: dwc: Add dma-coherent property
>   dt-bindings: PCI: dwc: Apply common schema to Rockchip DW PCIe nodes
>   dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
>   PCI: dwc: Introduce dma-ranges property support for RC-host
>   PCI: dwc: Introduce generic controller capabilities interface
>   PCI: dwc: Introduce generic resources getter
>   PCI: dwc: Combine iATU detection procedures
>   PCI: dwc: Introduce generic platform clocks and resets
>   PCI: dwc: Add Baikal-T1 PCIe controller support
> 
>  .../bindings/pci/baikal,bt1-pcie.yaml         | 153 ++++
>  .../bindings/pci/fsl,imx6q-pcie.yaml          |  47 +-
>  .../bindings/pci/rockchip-dw-pcie.yaml        |   4 +-
>  .../bindings/pci/snps,dw-pcie-common.yaml     | 327 +++++++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         | 169 +++--
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 236 +++++--
>  .../bindings/pci/toshiba,visconti-pcie.yaml   |   7 +-
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-bt1.c         | 653 ++++++++++++++++++
>  .../pci/controller/dwc/pcie-designware-ep.c   |  30 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  47 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 262 +++++--
>  drivers/pci/controller/dwc/pcie-designware.h  |  63 +-
>  14 files changed, 1785 insertions(+), 223 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-bt1.c
> 
> -- 
> 2.35.1
> 
