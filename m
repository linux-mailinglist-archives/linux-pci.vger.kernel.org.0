Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5625F52A1FE
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346438AbiEQMvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 08:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbiEQMvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 08:51:47 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25C473A72C;
        Tue, 17 May 2022 05:51:39 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C7574BB0;
        Tue, 17 May 2022 15:52:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru C7574BB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652791953;
        bh=e0oqIv7Q6nCXovmQnZdIVn0EIywE4XZz8YIanf/pr1M=;
        h=From:To:CC:Subject:Date:From;
        b=G1EeHgmHWK9za+PtT9dWSk7AnPFXaIL7FPxqB+rSDXO2EUqEKiWsX3lADFpr4Aj6n
         ZF0GxQ+FlD1+bpVkvzqbSuvUSdQHuODqVfJA3USVBTxH4J+n46/x23X3lqeq08xmIO
         y/YnOkfp0a90Iyi3any2DxXADSpOh9D/rZcZGX9A=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 May 2022 15:51:35 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/13] PCI: dwc: Various fixes and cleanups
Date:   Tue, 17 May 2022 15:50:45 +0300
Message-ID: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_XBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset is a second one in the series created in the framework of
my Baikal-T1 PCIe/eDMA-related work:

[1: In-progress v3] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
Link: https://lore.kernel.org/linux-pci/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
[2: In-progress v2] PCI: dwc: Various fixes and cleanups
Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
[3: In-progress v1] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
[4: In-progress v1] dmaengine: dw-edma: Add RP/EP local DMA controllers support
Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/

Note it is very recommended to merge the patchsets in the same order as
they are placed in the list above in order to prevent possible merge
conflicts. Nothing prevents them from being reviewed synchronously though.
Any tests are very welcome!

As it can be easily inferred from the patchset title, this series is about
the DW PCIe Root Port/End-point driver fixes and the code cleanups, where
fixes come before the cleanup patches. The patchset starts with adding the
stop_link() platform-specific method invocation in case of the PCIe host
probe procedure errors. It has been missing in the cleanup-on-error path
of the DW PCIe Host initialization method. After that there is a patch
which fixes the host own cfg-space accessors for the case of the
platform-specific DBI implementation. Third the unrolled CSRs layout is
added to the iATU disable procedure. Fourth the disable iATU procedure is
fixed to be called only for the internal ATU as being specific for the
internal ATU implementation. Last but no least the outbound iATU extended
region setup procedure is fixed to have the INCREASE_REGION_SIZE flag set
based on the limit-address - not the region size one.

Afterwards there is a series of cleanups. It concerns the changes like
adding braces to the multi-line if-else constructions, trailing new-lines
to the print format-string, dropping unnecessary version checking, and
various code simplifications and optimizations.

New features like adding two-level DT bindings abstraction, adding better
structured IP-core version interface, adding iATU regions size detection
and the PCIe regions verification procedure, adding dma-ranges support,
introducing a set of generic platform clocks and resets and finally adding
Baikal-T1 PCIe interface support will be submitted in the next part of the
series.

Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Fix the end address of the example in the patch log with
  the INCREASE_REGION_SIZE flag usage fixup. It should be
  0x1000FFFF and not 0x0000FFFF (@Manivannan).
- Add the cleanup-on-error path to the dw_pcie_ep_init() function.
  (@Manivannan)

Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/
Changelog v3:
- Convert region variable type to u32 in order to fix the implicit type
  conversion peculiarity. (@kbot)
- Rebase onto v5.18-rc6.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Rob Herring <robh@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (13):
  PCI: dwc: Stop link in the host init error and de-initialization
  PCI: dwc: Don't use generic IO-ops for DBI-space access
  PCI: dwc: Add unroll iATU space support to the regions disable method
  PCI: dwc: Disable outbound windows for controllers with iATU
  PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
  PCI: dwc: Add braces to the multi-line if-else statements
  PCI: dwc: Add trailing new-line literals to the log messages
  PCI: dwc: Discard IP-core version checking on unrolled iATU detection
  PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
  PCI: dwc: Deallocate EPC memory on EP init error
  PCI: dwc-plat: Simplify the probe method return value handling
  PCI: dwc-plat: Discard unused regmap pointer
  PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration

 .../pci/controller/dwc/pcie-designware-ep.c   | 22 +++++--
 .../pci/controller/dwc/pcie-designware-host.c | 66 +++++++++++++++----
 .../pci/controller/dwc/pcie-designware-plat.c | 13 ++--
 drivers/pci/controller/dwc/pcie-designware.c  | 50 +++++++++-----
 4 files changed, 110 insertions(+), 41 deletions(-)

-- 
2.35.1

