Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B07559BB0
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiFXOel (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiFXOek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:34:40 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F32DF4E3BB;
        Fri, 24 Jun 2022 07:34:33 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id DD2A316D7;
        Fri, 24 Jun 2022 17:35:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com DD2A316D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081352;
        bh=dl1pmMziOzXIj+32gBup2/UOO8PRGsVK8sv4CehJaxg=;
        h=From:To:CC:Subject:Date:From;
        b=YAxeTfTM5N0IO+xRE0CXDNoCqIoYcOXhVbzXQl6pAuY+XogslyaPaAc4Aw66KCGRi
         qaod5paSBPCrpcPnucwz/5Q7gfAUI+GQWBjUR1sfj3S00Y0yrzghZsoel8H0hy2W4m
         H2IgDzK8LDZb3gybJZARS1OBgMOpt3426l1MuVMQ=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:34:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 00/18] PCI: dwc: Various fixes and cleanups
Date:   Fri, 24 Jun 2022 17:34:10 +0300
Message-ID: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset is a first one in the series created in the framework of
my Baikal-T1 PCIe/eDMA-related work:

[1: In-progress v5] PCI: dwc: Various fixes and cleanups
Link: ---you are looking at it---
[2: In-progress v3] PCI: dwc: Add hw version and dma-ranges support
Link: https://lore.kernel.org/linux-pci/20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru/
[3: In-progress v3] PCI: dwc: Add generic resources and Baikal-T1 support
Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
[4: In-progress v3] dmaengine: dw-edma: Add RP/EP local DMA support
Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru/

Note it is very recommended to merge the patchsets in the same order as
they are placed in the list above in order to prevent possible merge
conflicts. Nothing prevents them from being reviewed synchronously though.
Any tests are very welcome!

As it can be easily inferred from the patchset title, this series is about
the DW PCIe Root Port/Endpoint driver fixes and the code cleanups, where
fixes come before the cleanup patches. The patchset starts with adding the
stop_link() platform-specific method invocation in case of the PCIe host
probe procedure errors. It has been missing in the cleanup-on-error path
of the DW PCIe Host initialization method. After that the unrolled CSRs
layout is added to the iATU disable procedure. In third the disable iATU
procedure is fixed to be called only for the internal ATU as being
specific for the internal ATU implementation. Then the outbound iATU
extended region setup procedure is fixed to have the INCREASE_REGION_SIZE
flag set based on the limit-address - not the region size one. The last
but not least the CDM-check enabling procedure is fixed to be independent
from the non-related num_lanes field state.

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

Link: https://lore.kernel.org/linux-pci/20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru/
Changelog v4:
- Move the patch "PCI: dwc: Deallocate EPC memory on EP init error" to
  being applied before the cleanup patches.
- Add a new fixes patch: "PCI: dwc: Enable CDM-check independently from
  the num_lanes value".
- Add a new cleanup patch: "PCI: dwc: Organize local variables usage".
- Add a new cleanup patch: "PCI: dwc: Re-use local pointer to the
  resource data".
- Add a new cleanup patch: "PCI: dwc: Add start_link/stop_link inliners".
- Add a new cleanup patch: "PCI: dwc: Move io_cfg_atu_shared to the Root
  Port descriptor".
- Add a new cleanup patch: "PCI: dwc: Add dw_ prefix to the pcie_port
  structure name".
- Drop the patch "PCI: dwc: Don't use generic IO-ops for DBI-space
  access". (@Rob)
- Drop Manivannan tested tag from the changed patches.
- Rebase onto v5.18.

Link: https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
Changelog v5:
- Just resend the series.
- Rebase onto v5.19-rcX.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (18):
  PCI: dwc: Stop link in the host init error and de-initialization
  PCI: dwc: Add unroll iATU space support to the regions disable method
  PCI: dwc: Disable outbound windows for controllers with iATU
  PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
  PCI: dwc: Deallocate EPC memory on EP init error
  PCI: dwc: Enable CDM-check independently from the num_lanes value
  PCI: dwc: Add braces to the multi-line if-else statements
  PCI: dwc: Add trailing new-line literals to the log messages
  PCI: dwc: Discard IP-core version checking on unrolled iATU detection
  PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
  PCI: dwc: Organize local variables usage
  PCI: dwc: Re-use local pointer to the resource data
  PCI: dwc: Add start_link/stop_link inliners
  PCI: dwc: Move io_cfg_atu_shared to the Root Port descriptor
  PCI: dwc: Add dw_ prefix to the pcie_port structure name
  PCI: dwc-plat: Simplify the probe method return value handling
  PCI: dwc-plat: Discard unused regmap pointer
  PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration

 drivers/pci/controller/dwc/pci-dra7xx.c       |  12 +--
 drivers/pci/controller/dwc/pci-exynos.c       |   6 +-
 drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
 drivers/pci/controller/dwc/pci-keystone.c     |  20 ++--
 .../pci/controller/dwc/pci-layerscape-ep.c    |  12 ---
 drivers/pci/controller/dwc/pci-layerscape.c   |   2 +-
 drivers/pci/controller/dwc/pci-meson.c        |   2 +-
 drivers/pci/controller/dwc/pcie-al.c          |   6 +-
 drivers/pci/controller/dwc/pcie-armada8k.c    |   4 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  30 ++++--
 .../pci/controller/dwc/pcie-designware-host.c | 102 ++++++++++--------
 .../pci/controller/dwc/pcie-designware-plat.c |  25 ++---
 drivers/pci/controller/dwc/pcie-designware.c  |  72 +++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  46 +++++---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   4 +-
 drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
 drivers/pci/controller/dwc/pcie-histb.c       |  10 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |   6 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   4 +-
 drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |   4 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   6 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  22 ++--
 drivers/pci/controller/dwc/pcie-uniphier.c    |  10 +-
 drivers/pci/controller/dwc/pcie-visconti.c    |   6 +-
 26 files changed, 224 insertions(+), 201 deletions(-)

-- 
2.35.1

