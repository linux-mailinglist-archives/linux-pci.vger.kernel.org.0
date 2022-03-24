Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87414E9A6B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 17:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbiC1PKv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 11:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbiC1PKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 11:10:50 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0C4953A46;
        Mon, 28 Mar 2022 08:09:08 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 77A861E28FE;
        Thu, 24 Mar 2022 04:25:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 77A861E28FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085128;
        bh=XwzvvtL/dT24V03s6InJN8ConPAeILjK/Hyr0vsALr0=;
        h=From:To:CC:Subject:Date:From;
        b=l7EO32Sm0pmbk7PhPVh4G1It2BGuhG8hGCXmMP+myDTbG7djOAClIagKzANPKPxuQ
         cirk1lx0T/XSSG5lnZh/nEMklcyDTWS+WkDy4zSpRTQk+BWRBf5/tAtdtFOs1P9DUG
         F86C02AKXyCORs8QrXHrJSoHwHVq1qGcJj+DFjbA=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:25:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/12] PCI: dwc: Various fixes and cleanups
Date:   Thu, 24 Mar 2022 04:25:11 +0300
Message-ID: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset is a second one in the series created in the framework of
my Baikal-T1 PCIe/eDMA-related work:

[1: In-progress] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
Link: --submitted--
[2: In-progress] PCI: dwc: Various fixes and cleanups
Link: --you are looking at it--
[3: Stalling]    PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
Link: --being submitted afterwards--
[4: Stalling]    dmaengine: dw-edma: Add RP/EP local DMA controllers support
Link: --being submitted afterwards--

Note it is very recommended to merge the patchsets in the same order as
they are placed in the list above in order to prevent possible merge/build
conflicts. Nothing prevents them from being reviewed synchronously though.

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

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (12):
  PCI: dwc: Stop link in the host init error and de-initialization
  PCI: dwc: Don't use generic IO-ops for DBI-space access
  PCI: dwc: Add unroll iATU space support to the regions disable method
  PCI: dwc: Disable outbound windows for controllers with iATU
  PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
  PCI: dwc: Add braces to the multi-line if-else statements
  PCI: dwc: Add trailing new-line literals to the log messages
  PCI: dwc: Discard IP-core version checking on unrolled iATU detection
  PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
  PCI: dwc-plat: Simplify the probe method return value handling
  PCI: dwc-plat: Discard unused regmap pointer
  PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration

 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
 .../pci/controller/dwc/pcie-designware-host.c | 66 +++++++++++++++----
 .../pci/controller/dwc/pcie-designware-plat.c | 13 ++--
 drivers/pci/controller/dwc/pcie-designware.c  | 48 +++++++++-----
 4 files changed, 93 insertions(+), 38 deletions(-)

-- 
2.35.1

