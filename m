Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B3D77B3DF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjHNIUx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 04:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjHNIUX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 04:20:23 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957C106;
        Mon, 14 Aug 2023 01:20:20 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 833A28159;
        Mon, 14 Aug 2023 16:20:19 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:20:19 +0800
Received: from ubuntu.localdomain (183.27.98.20) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:20:18 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 0/11] Refactoring Microchip PCIe driver and add StarFive PCIe
Date:   Mon, 14 Aug 2023 16:20:05 +0800
Message-ID: <20230814082016.104181-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

So first step is extract the PLDA common codes from microchip, and
refactoring the microchip codes.(patch1 - 8)
Then, add Starfive codes. (patch9 - 11)

This patchset is base on v6.5-rc4

The patch is base on Daire microchip commit,(accepted, not merge in mainline now)
https://patchwork.kernel.org/project/linux-pci/cover/20230728131401.1615724-1-daire.mcnamara@microchip.com/
patch11 dts patch base on stg clk patchset and syscon patch(these will be merged in 6.6-rcx). 
https://patchwork.kernel.org/project/linux-riscv/cover/20230713113902.56519-1-xingyu.wu@starfivetech.com/
https://patchwork.kernel.org/project/linux-riscv/patch/20230717023040.78860-7-xingyu.wu@starfivetech.com/

patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
       docs from microchip,pcie-host.yaml
patch2 is move PolarFire codes to PLDA directory.
patch3 is move PLDA IP register macros to plda-pcie.h
patch4 is rename data structure setup and IRQ functions in microchip codes. 
patch5 is move the patch4 functions to common file pcie-plda-host.c 
patch6 is Add PLDA event interrupt codes and IRQ domain ops.
patch7 is rename IRQ init function in microchip codes, prepare to move
the common file pcie-plda-host.c,
patch8 is move IRQ init functions to pcie-plda-host.c
patch9 is add StarFive JH7110 PCIe dt-binding doc.
patch10 is add StarFive JH7110 Soc PCIe codes.
patch11 is Starfive dts config

previous version:
v1:https://patchwork.kernel.org/project/linux-pci/cover/20230719102057.22329-1-minda.chen@starfivetech.com/
v2:https://patchwork.kernel.org/project/linux-pci/cover/20230727103949.26149-1-minda.chen@starfivetech.com/

change:
  v3:
    patch 2- 8:
      - splite refactoring patches to multiple patch.
      - rename plda_pcie to plda_pcie_rp. Maybe other vendor will
        upstream PLDA ep codes.
    patch 9:
      - Remove the redundant reference.
      - move the offset value to codes in starfive,stg-syscon
      - change reset-gpio to prest-gpio.
    patch10:
      - Add 100ms delay after preset for PCIe 6.0 spec.
      - stg-syscon related modification.
    patch11:
      - Add dts configure.
  v2:
    patch1:
      - squash dt-bindings patches to patch1
      - add 'required' list. 
      - plda doc rename to plda,xpressrich-axi-common.yaml
    patch2 - 8:
      - squash the microchip modification patch.
    patch9:
      - remove the plda common required property.
    patch10:
      - Sync the hide rc bar ops with config read function.
      - Revert the T_PVPERL to 100ms and add comments for the source.
      - Replace the link check function by the standard link ops.
      - Convert to new pm ops marcos.
      - Some formats modification.
      - pcie-plda-host modification merge to patch4.
    other:
      - remove the pcie-plda-plat.c
      - remove the starfive dts patch first. for it depends on
        stg clock and syscon setting.

Minda Chen (11):
  dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
  PCI: microchip: Move pcie-microchip-host.c to plda directory
  PCI: microchip: Move PLDA IP register macros to pcie-plda.h
  PCI: microchip: Rename data structure and functions
  PCI: plda: Move the common functions to pcie-plda-host.c
  PCI: plda: Add event interrupt codes and IRQ domain ops
  PCI: microchip: Rename IRQ init function
  PCI: microchip: Move IRQ init functions to pcie-plda-host.c
  dt-bindings: PCI: Add StarFive JH7110 PCIe controller
  PCI: starfive: Add JH7110 PCIe controller
  riscv: dts: starfive: add PCIe dts configuration for JH7110

 .../bindings/pci/microchip,pcie-host.yaml     |  55 +-
 .../pci/plda,xpressrich3-axi-common.yaml      |  75 +++
 .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++
 MAINTAINERS                                   |  17 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  64 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  86 +++
 drivers/pci/controller/Kconfig                |   9 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/plda/Kconfig           |  30 +
 drivers/pci/controller/plda/Makefile          |   4 +
 .../{ => plda}/pcie-microchip-host.c          | 604 ++---------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 631 ++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       | 236 +++++++
 drivers/pci/controller/plda/pcie-starfive.c   | 461 +++++++++++++
 14 files changed, 1786 insertions(+), 608 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (54%)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
-- 
2.17.1

