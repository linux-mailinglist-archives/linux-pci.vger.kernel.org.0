Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDDF545F8D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbiFJIoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiFJIoy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:44:54 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAE6424BE1;
        Fri, 10 Jun 2022 01:44:47 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 5411A16A0;
        Fri, 10 Jun 2022 11:45:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 5411A16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654850738;
        bh=PxLnRJBRYiUNOOX4llSwUbxNuI8ujFsec8Z6EuQxrSs=;
        h=From:To:CC:Subject:Date:From;
        b=GP1AW/lmE0F07Ypr0o9L6pO8yMdnIk5fXQdyCnunm1jJaG20BvLAqfnDXN54qNt3C
         cygBaPKYkjPST4f15KxvHgbL4oa5TWfzg6/v3yxzrDr0Wtt2RRThklpLmgzq3uZ5Jy
         EbdhhKkvdJt/tAVXRIkUbxkUIZptT/BwczlFoLu8=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:44:44 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/15] PCI: dwc: Add hw version and dma-ranges support
Date:   Fri, 10 Jun 2022 11:44:28 +0300
Message-ID: <20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset is a second one in the series created in the framework of
my Baikal-T1 PCIe/eDMA-related work:

[1: In-progress v4] PCI: dwc: Various fixes and cleanups
Link: https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
[2: In-progress v3] PCI: dwc: Add hw version and dma-ranges support
Link: ---you are looking at it---
[3: In-progress v3] PCI: dwc: Add extended YAML-schema and Baikal-T1 support
Link: ---being submitted afterwards---
[4: In-progress v2] dmaengine: dw-edma: Add RP/EP local DMA support
Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/

Note it is very recommended to merge the patchsets in the same order as
they are listed in the set above in order to have them applied smoothly.
Nothing prevents them from being reviewed synchronously though.

Originally the patches submitted in this patchset were a part of the series:
Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
but due to the reviewers requests the series was expanded to about 30
patches which made it too bulky for a comfortable review. So I decided to
split it up into two patchsets: 2. and 3. in the table above.

Regarding the series content. This patchset is about adding new features
to the DW PCIe core, Root Port and Endpoint drivers. First we suggest to
add a more verbose link-up log message. Really printing link generation
and width would be much more informative than just "link up". Then a
series of IP-core version-related patches go, like using a native FourCC
version representation, adding the IP-core auto-detection, adding a better
structured IP-core version/type interface and finally dropping manual
IP-core version setups from the platforms which are supposed to have it
auto-detected. After that the platform-specific host de-initialization
method is introduced. It's unused in the framework of this patchset but
will be utilized in the next one (see the table above). A series of iATU
optimizations, cleanups and new features goes afterwards. In particular we
suggest to drop some redundant enumerations, add iATU regions size
detection procedure and then use the regions parameters to verify the
requested by the platform iATU ranges/dma-ranges settings. After that the
dma-ranges property support is added for the DW PCIe Host controllers.

Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Test the error condition first and return straight away if it comes true
  in the link up waiting and link state logging method (@Joe).
- Move the dw_pcie_region_type enumeration removal patch to being applied
  before the IB/OB iATU windows setup simplification patch (@Rob).
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

Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru
Changelog v3:
- Fix pcie-tegra194-acpi.c driver to using the new macros names.
  (@Manivannan)
- Drop in/outbound iATU window size alignment constraint. (@Manivannan)
- Detach this series of patches into a dedicated patchset.
- Rebase onto kernel v5.18.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (15):
  PCI: dwc: Add more verbose link-up message
  PCI: dwc: Detect iATU settings after getting "addr_space" resource
  PCI: dwc: Convert to using native IP-core versions representation
  PCI: dwc: Add IP-core version detection procedure
  PCI: dwc: Introduce Synopsys IP-core versions/types interface
  PCI: intel-gw: Drop manual DW PCIe controller version setup
  PCI: tegra194: Drop manual DW PCIe controller version setup
  PCI: dwc: Add host de-initialization callback
  PCI: dwc: Drop inbound iATU types enumeration - dw_pcie_as_type
  PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
  PCI: dwc: Simplify in/outbound iATU setup methods
  PCI: dwc: Add iATU regions size detection procedure
  PCI: dwc: Verify in/out regions against iATU constraints
  PCI: dwc: Check iATU in/outbound ranges setup methods status
  PCI: dwc: Introduce dma-ranges property support for RC-host

 drivers/pci/controller/dwc/pci-keystone.c     |  12 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  40 +-
 .../pci/controller/dwc/pcie-designware-host.c | 202 +++++---
 drivers/pci/controller/dwc/pcie-designware.c  | 461 ++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  | 123 ++---
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  22 +-
 .../pci/controller/dwc/pcie-tegra194-acpi.c   |   7 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   1 -
 8 files changed, 461 insertions(+), 407 deletions(-)

-- 
2.35.1

