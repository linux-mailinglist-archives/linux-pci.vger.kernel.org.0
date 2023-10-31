Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4C7DCC31
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 12:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344036AbjJaLyq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 07:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjJaLyn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 07:54:43 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1579ADB;
        Tue, 31 Oct 2023 04:54:40 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 42CE28102;
        Tue, 31 Oct 2023 19:54:33 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 31 Oct
 2023 19:54:33 +0800
Received: from ubuntu.localdomain (113.72.146.247) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 31 Oct
 2023 19:54:32 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Daire McNamara" <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v10 0/20] Refactoring Microchip PCIe driver and add StarFive PCIe
Date:   Tue, 31 Oct 2023 19:54:10 +0800
Message-ID: <20231031115430.113586-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.247]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
same IP and have commit their codes, which are mixed with PLDA
controller codes and Microchip platform codes.

For re-use the PLDA controller codes, I request refactoring microchip
codes, move PLDA common codes to PLDA files.
Desigware and Cadence is good example for refactoring codes.

----------------------------------------------------------
The refactoring patches total number is 16,(patch 1-16)
which do NOT contain changing logic of codes.

These patches just contain three type basic operations.
(rename, modify codes to support starfive platform, and moving to common file)
If these patched are all be reviewed. They can be accepted first.

Refactoring patches can be devided to different groups
1. (patch 1- 3 is the prepare work of refactoring)
patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
       docs from microchip,pcie-host.yaml
patch2 is move PolarFire codes to PLDA directory.
patch3 is move PLDA IP register macros to plda-pcie.h

2. (patch4 - 6 is processing and re-use PCIe host instance)
patch4 is add bridge_addr field to PCIe host instance.
patch5 is rename data structure in microchip codes.
patch6 is moving two data structures to head file

3. (patch 7 - 9 are for re-use two PCIe setup function)
patch7 is rename two setup functions in microchip codes, prepare to move
to common file.
patch8 is change the arguments of plda_pcie_setup_iomems()
patch9 is move the two setup functions to common file pcie-plda-host.c

4.(patch 10 - 16 are for re-use interupt processing codes)
patch10 is rename the IRQ related functions, prepare to move to
pcie-plda-host.c
patch 11 - 15 is modify the interrupt event codes, preparing for support starfive
and microchip two platforms.
patch16 is move IRQ related functions to pcie-plda-host.c

------------------------------------------------------------
The remainder patches (patch 17 -20) are not refactoring patch.
They are for adding StarFive codes and dont modify the microchip's
codes.

patch17 is Add PLDA event interrupt codes and host init/deinit functions.
patch18 is add StarFive JH7110 PCIe dt-binding doc.
patch19 is add StarFive JH7110 Soc PCIe codes.
patch20 is Starfive dts config

This patchset is base on v6.6

previous version:
v6:https://patchwork.kernel.org/project/linux-pci/cover/20230915102243.59775-1-minda.chen@starfivetech.com/
v7:https://patchwork.kernel.org/project/linux-pci/cover/20230927100802.46620-1-minda.chen@starfivetech.com/
v8:https://patchwork.kernel.org/project/linux-pci/cover/20231011110514.107528-1-minda.chen@starfivetech.com/
v9:https://patchwork.kernel.org/project/linux-pci/cover/20231020104341.63157-1-minda.chen@starfivetech.com/

change:
  v10:
   All the commit message set to fit in 75 columns.
   All the codes fit in less than 80 colunms.
   patch 14: 
	Commit message changes suggested by Conor.
   patch 19:
        Add 100 ms delay macro to pci.h
	generic phy pointer related codes moving to pcie-starfive.c
	This patch Change pcie-starfive only, bus_ops move to patch 16.
	Some Codes changes suggested by Bjorn.

  v9:
   v8 patch 10 squash to v9 patch 12, v8 patch 18 squash to v9 patch 16.
   patch 4 - 16: Add new review tags and add more accurate commit messages.
   patch 17: move the plda_pcie_host_init/deinit from patch 19. Make
plda driver become to whole driver.

  v8:
    The patch description in cover-letter has been changed.

    v7 patch 4 split to v8 patch 4 - 6.
        (It is patches about re-use pcie host data structure, new patches just contain one
	function modification. It is more reguluar and easier to review).

    patch 7- 9: modify the commit messages and add reason of
		modifcation.
    patch10- 16 :
             Add review tag and add more commit messages to declear the
	     reason of modifying the codes.
    patch17: plda_handle_events() using bit mask macro. The function are
	     easier to read.

  v7:
    patch17: fix the build warning.
    patch19: Some format changes (Emil's comment)
    patch20: change the pcie node sequences by alphabetical
             delete the "interupt-parent" in pcie node.

  v6:
    v5 patch 4 split to patch 4 -9. New patches just contain one
function modification. It is more reguluar.
    patch 9: Just move the two setup functions only
    patch 19 : draw a graph of PLDA local register, make it easier to
review the codes.
    v5 patch 7 split to patch 10- 16. Each patch just contain one
function modification. It is more regular.
    patch 10: rename IRQ related functions.
    patch 11 - 15 : modify the events codes, total five patch.
    patch 16: move IRQ related functions to pcie-plda-host.c
    patch 19- 20 using "linux,pci-domain" dts setting.

Minda Chen (20):
  dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
  PCI: microchip: Move pcie-microchip-host.c to plda directory
  PCI: microchip: Move PLDA IP register macros to pcie-plda.h
  PCI: microchip: Add bridge_addr field to struct mc_pcie
  PCI: microchip: Rename two PCIe data structures
  PCI: microchip: Move PCIe host data structure to plda-pcie.h
  PCI: microchip: Rename two setup functions
  PCI: microchip: Change the argument of plda_pcie_setup_iomems()
  PCI: microchip: Move setup functions to pcie-plda-host.c
  PCI: microchip: Rename interrupt related functions
  PCI: microchip: Add num_events field to struct plda_pcie_rp
  PCI: microchip: Add request_event_irq() callback function
  PCI: microchip: Add INTx and MSI event num to struct plda_event
  PCI: microchip: Add get_events() callback function
  PCI: microchip: Add event IRQ domain ops to struct plda_event
  PCI: microchip: Move IRQ functions to pcie-plda-host.c
  PCI: plda: Add event interrupt codes and host init/deinit functions
  dt-bindings: PCI: Add StarFive JH7110 PCIe controller
  PCI: starfive: Add JH7110 PCIe controller
  riscv: dts: starfive: add PCIe dts configuration for JH7110

 .../bindings/pci/microchip,pcie-host.yaml     |  55 +-
 .../pci/plda,xpressrich3-axi-common.yaml      |  75 ++
 .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++
 MAINTAINERS                                   |  19 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  64 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  86 +++
 drivers/pci/controller/Kconfig                |   9 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/plda/Kconfig           |  29 +
 drivers/pci/controller/plda/Makefile          |   4 +
 .../{ => plda}/pcie-microchip-host.c          | 602 ++--------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 657 ++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       | 266 +++++++
 drivers/pci/controller/plda/pcie-starfive.c   | 460 ++++++++++++
 drivers/pci/pci.h                             |   7 +
 15 files changed, 1851 insertions(+), 604 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (54%)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c


base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.17.1

