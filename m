Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699466271F7
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 20:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiKMTOx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 14:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiKMTOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 14:14:52 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 146C22BE1;
        Sun, 13 Nov 2022 11:14:46 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 2EE99E0EA0;
        Sun, 13 Nov 2022 22:14:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:message-id
        :mime-version:reply-to:subject:subject:to:to; s=post; bh=r2ypEUn
        uWnZhzrpjOrG8An08uwSie+G9WcFH47IU5PE=; b=GIVXTs2etcqibfBBga9drFU
        Z/sZaD6z0UMAxJ1aYrNBwkU2NY6QW7dORlz5C40z11jX71RhqwMErAbTLEMd9gUX
        XUPB3wCpxWYLcUNEL+wmg9uTXm5o8yPsgZTty/0MquCq8N2xOnci2cCQO8065Tnw
        ErAVl39DK7RHkTl0QCec=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 1183EE0E6A;
        Sun, 13 Nov 2022 22:14:44 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 13 Nov 2022 22:14:43 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 00/20] PCI: dwc: Add generic resources and Baikal-T1 support
Date:   Sun, 13 Nov 2022 22:12:41 +0300
Message-ID: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset is a third one in the series created in the framework of
my Baikal-T1 PCIe/eDMA-related work:

[1: Done v5] PCI: dwc: Various fixes and cleanups
Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
Merged: kernel 6.0-rc1
[2: Done v4] PCI: dwc: Add hw version and dma-ranges support
Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
Merged: kernel 6.0-rc1
[3: In-review v7] PCI: dwc: Add generic resources and Baikal-T1 support
Link: ---you are looking at it---
[4: Done v6] dmaengine: dw-edma: Add RP/EP local DMA support
Link: https://lore.kernel.org/linux-pci/20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru/

Note it is very recommended to merge the patchsets in the same order as
they are listed in the set above in order to have them applied smoothly.
Nothing prevents them from being reviewed synchronously though.

Originally the patches submitted in this patchset were a part of the series:
Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
but due to the reviewers requests the series was expanded to about 30
patches which made it too bulky for a comfortable review. So I decided to
split it up into two patchsets: 2. and 3. in the table above.

Regarding the series content. This patchset is mainly about adding new DW
PCIe platform support - Baikal-T1 PCIe of DW PCIe v4.60a IP-core. But a
set of feature-reach preparations are done first. It starts from
converting the currently available DT-schema into a more flexible schemas
hierarchy with separately defined regs, clocks, resets and interrupts
properties. As a result the common schema can be easily re-used by all the
currently available platforms while the named properties above can be
either re-defined or used as is if the platforms support they. In the
framework of that modification we also suggest to add a set of generic
regs, clocks, resets and interrupts resource names in accordance with what
the DW PCIe hardware reference manual describes and what the DW PCIe core
driver already expects to be specified. Thus the new platform driver will
be able to re-use the common resources infrastructure.

Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Rename 'syscon' property to 'baikal,bt1-syscon'. (@Rob)
- Move the iATU region selection procedure into a helper function (@Rob).
- Rebase from kernel v5.17 onto v5.18-rc3 since the later kernel has
  already DT bindings converted. (@Rob)
- Use 'definitions' property instead of the '$defs' one. It fixes the
  dt-validate error: 'X is not of type array.'
- Drop 'interrupts' and 'interrupt-names' property from being required
  for the native DW PCIe host.
- Evaluate the 'snps,dw-pcie-common.yaml' schema in the
  'socionext,uniphier-pcie-ep.yaml' DT-bindings since the later has
  platform-specific names defined.

Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru
Changelog v3:
- Split up the patch "dt-bindings: PCI: dwc: Define common and native DT
  bindings" into a series of modifications. (@Rob)
- Detach this series of the patches into a dedicated patchset.
- Add a new feature patch: "PCI: dwc: Introduce generic controller
  capabilities interface".
- Add a new feature patch: "PCI: dwc: Introduce generic resources getter".
- Add a new cleanup patch: "PCI: dwc: Combine iATU detection procedures".
- Add a method to at least request the generic clocks and resets. (@Rob)
- Add GPIO-based PERST# signal support to the core module.
- Redefine Baikal-T1 PCIe host bridge config space accessors with the
  pci_generic_config_read32() and pci_generic_config_write32() methods.
  (@Rob)
- Drop synonymous from the names list in the common DT-schema since the
  device sub-schemas create their own enumerations anyway.
- Rebase onto kernel v5.18.

Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
Changelog v4:
- Drop PCIBIOS_* macros usage. (@Rob)
- Add "static const" to the dw_pcie_ops and dw_pcie_host_ops structure
  instances. (@Bjorn)
- Rename bt1_pcie_dw_ops to bt1_pcie_ops. (@Bjorn)
- Rename bt1_pcie_ops to bt1_pci_ops. (@Bjorn)
- Use start_link/stop_link suffixes in the Baikal-T1 PCIe
  start/stop link callbacks. (@Bjorn)
- Change the get_res() method suffix to being get_resources(). (@Bjorn)
- Change *_{add,del}_dw_port() method to *_{add,del}_port(). (@Bjorn)
- Drop dma_coerce_mask_and_coherent() applied to the PCI host bridge
  kernel device instance. (@Bjorn)
- Add the comment above the dma_set_mask_and_coherent() method usage
  regarding the controller eDMA feature. (@Bjorn)
- Fix the comment above the core reset controls assertion. (@Bjorn)
- Replace delays and timeout numeric literals with macros. (@Bjorn)
- Convert the method name from dw_pcie_get_res() to
  dw_pcie_get_resources(). (@Bjorn)
- Rebase onto the kernel v5.19-rcX.

Link: https://lore.kernel.org/linux-pci/20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru/
Changelog v5:
- Add a note about having line-based PHY phandles order. (@Rob)
- Prefer 'pcie[0-9]+' PHY-names over the rest of the cases. (@Rob)
- Drop generic fallback names from the Baikal-T1 compatible property
  constraints. (@Rob)
- Define ordered {reg,interrupt,clock,reset}-names Baikal-T1 PCIe
  properties. (@Rob)
- Drop minItems from the Baikal-T1 PCIe clocks and reset properties,
  since it equals to the maxItems for them.
- Drop num-ob-windows and num-ib-windows properties constraint from
  Baikal-T1 PCIe bindings. (@Rob)
- Add a note about having line-based PHY phandles order. (@Rob)
- Prefer 'pcie[0-9]+' PHY-names over the rest of the cases. (@Rob)
- Add platform-specific reg/interrupt/clock/reset names to the generic
  schema, but mark them as deprecated.
- Add new patches:
  dt-bindings: visconti-pcie: Fix interrupts array max constraints
  dt-bindings: imx6q-pcie: Fix clock names for imx6sx and imx8mq
- Move the patch:
  PCI: dwc: Introduce dma-ranges property support for RC-host
  from the previous patchset in here. (@Bjorn)
- Rebase onto the kernel v6.0-rc2.

Link: https://lore.kernel.org/linux-pci/20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru/
Changelog v6:
- Add the Nvidia Tegra194-specific "p2u-[0-7]" phy-names too. (@DT-tbot)
- Drop 'deprecated' keywords from the vendor-specific names. (@Rob)
- Move the common *-names definitions to the RP/EP schemas. Thus drop
  the 'definitions' property usage from the DT-schemas. (@Rob)
- Move the DMA-mask setup to the eDMA driver. (@Robin)
- Rebase onto the kernel v6.1-rc3.

Link: https://lore.kernel.org/linux-pci/20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru/
Changelog v7:
- Replace if-then-dev_err_probe-return statement with just
  return-dev_err_probe one in the pcie-bt1 driver.
- Get back device.of_node pointer to the dw_pcie_ep_init() method.
  (@Yoshihiro)
- Drop the dtschema tool 'lib.py' fix chunk from under the '---' pattern.
  (@Yoshihiro)
- Move the allOf clause to the bottom of the fsl,imx6q-pcie.yaml bindings.
  (@Krzysztof)
- Get back the names to the clock-names property and make sure the
  platform-specific cloc-names constraint is applied in the allOf clause
  in the fsl,imx6q-pcie.yaml bindings. (@Rob)

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: caihuoqing <caihuoqing@baidu.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (20):
  dt-bindings: imx6q-pcie: Fix clock names for imx6sx and imx8mq
  dt-bindings: visconti-pcie: Fix interrupts array max constraints
  dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
  dt-bindings: PCI: dwc: Remove bus node from the examples
  dt-bindings: PCI: dwc: Add phys/phy-names common properties
  dt-bindings: PCI: dwc: Add max-link-speed common property
  dt-bindings: PCI: dwc: Apply generic schema for generic device only
  dt-bindings: PCI: dwc: Add max-functions EP property
  dt-bindings: PCI: dwc: Add interrupts/interrupt-names common
    properties
  dt-bindings: PCI: dwc: Add reg/reg-names common properties
  dt-bindings: PCI: dwc: Add clocks/resets common properties
  dt-bindings: PCI: dwc: Add dma-coherent property
  dt-bindings: PCI: dwc: Apply common schema to Rockchip DW PCIe nodes
  dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
  PCI: dwc: Introduce dma-ranges property support for RC-host
  PCI: dwc: Introduce generic controller capabilities interface
  PCI: dwc: Introduce generic resources getter
  PCI: dwc: Combine iATU detection procedures
  PCI: dwc: Introduce generic platform clocks and resets
  PCI: dwc: Add Baikal-T1 PCIe controller support

 .../bindings/pci/baikal,bt1-pcie.yaml         | 168 +++++
 .../bindings/pci/fsl,imx6q-pcie.yaml          |  46 +-
 .../bindings/pci/rockchip-dw-pcie.yaml        |   4 +-
 .../bindings/pci/snps,dw-pcie-common.yaml     | 266 ++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 212 ++++--
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 260 +++++--
 .../bindings/pci/toshiba,visconti-pcie.yaml   |   7 +-
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-bt1.c         | 643 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |  29 +-
 .../pci/controller/dwc/pcie-designware-host.c |  47 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 262 +++++--
 drivers/pci/controller/dwc/pcie-designware.h  |  63 +-
 14 files changed, 1796 insertions(+), 221 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-bt1.c

-- 
2.38.1


