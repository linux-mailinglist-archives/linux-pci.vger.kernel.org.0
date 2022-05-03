Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4365190A5
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbiECVuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiECVue (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:50:34 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69502205DE;
        Tue,  3 May 2022 14:47:00 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id F2A0D16A9;
        Wed,  4 May 2022 00:47:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru F2A0D16A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651614453;
        bh=aKUxuPvmevJfjD0GEeGZWEXIqIxRcfllKsCVy2d/umI=;
        h=From:To:CC:Subject:Date:From;
        b=q5waB3N5s8G183pcKzelx4bHLTXauehKXq3EBxpcwXzBPRZW71W0jjtVtZOh1OmG9
         L32l8oMvA0JR5MYEiK/sNYBWAZ7GnegFX4/ulnNiwS8A49/74zjstRtrkkR3l7q7XK
         mRtJbqm8Be7QwQffD32HqH2PwHB/keQu/ug+NBwk=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:46:57 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
Date:   Wed, 4 May 2022 00:46:21 +0300
Message-ID: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
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

This patchset is a third one in the series created in the framework of
my Baikal-T1 PCIe/eDMA-related work:

[1: In-progress v3] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
Link: https://lore.kernel.org/linux-pci/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
[2: In-progress v2] PCI: dwc: Various fixes and cleanups
Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/
[3: In-progress v2] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
Link: --you are looking at it--
[4: In-progress v1] dmaengine: dw-edma: Add RP/EP local DMA controllers support
Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/

Note it is very recommended to merge the patchsets in the same order as
they are listed in the set above in order to have them applied smoothly.
Nothing prevents them from being reviewed synchronously though.

This series is about adding new features to the DW PCIe Host/End-point
driver. First of all we start from splitting up the DT-bindings into
common properties schema and generic DW PCIe bindings definition. It's
done to support the generic DW PCIe Host/End-point available platforms
with adding a common YAML-schema to be reused by the platform-specific DW
PCIe bindings. @Rob could you please take a look at that patch? I've got a
problem with dt_bindings_check-ing the schema which is likely caused by
the dt-schema parser misbehaviour. After that we suggest to add a more
verbose link-up log message. Really printing link generation and width
would be much more informative than just "link up". Then a series of
IP-core version-related patches go, like using a native FourCC version
representation, adding the IP-core auto-detection, adding better
structured IP-core version/type interface. After that the
platform-specific host de-initialization method is introduced. A series of
iATU optimizations, cleanups and new features goes afterwards. In
particular we suggest to drop some redundant enumerations, add iATU
regions size detection procedure and then use the regions parameters to
verify the requested by the platform iATU ranges/dma-ranges settings.
After that the dma-ranges property support is added for the DW PCIe Host
controllers. Then a structured set of the DW PCIe RP/EP specific clocks
and resets names/IDs is introduced so to be re-used by the generic and new
platforms. Note it is fully coherent with the DW PCIe controller manuals
(see the patch log for details). Also note the patch doesn't affect the
already available DW PCIe platform-specific code since it would be too
risky for my to do the corresponding conversion, but the maintainers are
welcome to do that. Finally at the series closure we introduce the
Baikal-T1 PCIe interface support, which uses all the recently added
features including the set of the generic clocks and resets names.

Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Test the error condition first and return straight away if it comes true
  in the link up waiting and link state logging method (@Joe).
- Move the dw_pcie_region_type enumeration removal patch to being applied
  before the IB/OB iATU windows setup simplification patch (@Rob).
- Rename 'syscon' property to 'baikal,bt1-syscon'. (@Rob)
- Move the iATU region selection procedure into a helper function (@Rob).
- Rebase from kernel v5.17 onto v5.18-rc3 since the later kernel has
  already DT bindings converted. (@Rob)
- Simplify the iATU region selection procedure by recalculating the base
  address only if the space is unrolled. The iATU viewport base address
  will be saved in the pci->atu_base field.
- Move the IP-core version detection procedure call from
  dw_pcie_ep_init_complete() to dw_pcie_ep_init().
- Add a new patch: "PCI: dwc: Detect iATU settings after getting
  "addr_space" resource."
- Use 'definitions' property instead of the '$defs' one. It fixes the
  dt-validate error: 'X is not of type array.'
- Drop 'interrupts' and 'interrupt-names' property from being required
  for the native DW PCIe host.
- Evaluate the 'snps,dw-pcie-common.yaml' schema in the
  'socionext,uniphier-pcie-ep.yaml' DT-bindings since the later has
  platform-specific names defined.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Rob Herring <robh@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (17):
  dt-bindings: PCI: dwc: Define common and native DT bindings
  dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
  PCI: dwc: Add more verbose link-up message
  PCI: dwc: Detect iATU settings after getting "addr_space" resource
  PCI: dwc: Convert to using native IP-core versions representation
  PCI: dwc: Add IP-core version detection procedure
  PCI: dwc: Introduce Synopsys IP-core versions/types interface
  PCI: dwc: Add host de-initialization callback
  PCI: dwc: Drop inbound iATU types enumeration - dw_pcie_as_type
  PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
  PCI: dwc: Simplify in/outbound iATU setup methods
  PCI: dwc: Add iATU regions size detection procedure
  PCI: dwc: Verify in/out regions against iATU constraints
  PCI: dwc: Check iATU in/outbound ranges setup methods status
  PCI: dwc: Introduce dma-ranges property support for RC-host
  PCI: dwc: Introduce generic platform clocks and resets sets
  PCI: dwc: Add Baikal-T1 PCIe controller support

 .../bindings/pci/baikal,bt1-pcie.yaml         | 158 +++++
 .../bindings/pci/fsl,imx6q-pcie.yaml          |   5 +-
 .../bindings/pci/hisilicon,kirin-pcie.yaml    |   4 +-
 .../bindings/pci/sifive,fu740-pcie.yaml       |   4 +-
 .../bindings/pci/snps,dw-pcie-common.yaml     | 306 +++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 143 ++--
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 189 ++++--
 .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
 .../bindings/pci/toshiba,visconti-pcie.yaml   |   2 +-
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pci-keystone.c     |  12 +-
 drivers/pci/controller/dwc/pcie-bt1.c         | 639 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |  40 +-
 .../pci/controller/dwc/pcie-designware-host.c | 198 ++++--
 drivers/pci/controller/dwc/pcie-designware.c  | 463 ++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  | 202 ++++--
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  10 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 19 files changed, 1877 insertions(+), 512 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-bt1.c

-- 
2.35.1

