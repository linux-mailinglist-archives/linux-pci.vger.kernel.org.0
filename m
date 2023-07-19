Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C247592A6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGSKVF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGSKVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:21:04 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF64C1FC1;
        Wed, 19 Jul 2023 03:21:01 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3AC1724DBBD;
        Wed, 19 Jul 2023 18:21:00 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:00 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:20:59 +0800
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 0/9] Refactoring Microchip PolarFire PCIe driver
Date:   Wed, 19 Jul 2023 18:20:48 +0800
Message-ID: <20230719102057.22329-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

So first step is extract the PLDA common codes from microchip, and
refactoring the microchip codes.(patch1 - 4)
Then add the PLDA platform codes. (patch5, 6)
At last, add Starfive codes. (patch7 - 9)

This patchset is base on v6.5-rc1

patch1 is add PLDA XpressRICH PCIe host common properties dt-binding
       docs, most are extracted from microchip,pcie-host.yaml
patch2 is add plda,xpressrich-pcie-common.yaml(patch1 file) reference
       and remove the PLDA common properties.
patch3 is extracting the PLDA common codes from microchip Polarfire PCIe
       codes. The change list in the commit message.
patch4 is move microchip driver to PLDA directory and remove the PLDA
       common codes.
patch5 is add PLDA Xpressrich platform driver dt-binding doc.
patch6 is PLDA Xpressrich platform driver.
patch7 is add StarFive JH7110 PCIe dt-binding doc.
patch8 is add StarFive JH7110 Soc PCIe platform codes.
patch9 is StarFive JH7110 device tree configuration.

I have noticed that Daire have changed microchip's codes.
https://patchwork.kernel.org/project/linux-pci/cover/20230630154859.2049521-1-daire.mcnamara@microchip.com/
I have changed patch3 and patch4 base on their commits. StarFive
PCIe driver still can work. But their codes is under reviewed and 
maybe changing. Do not base on their changes first.
I will base on their commit to change patch3 and patch4 as soon as
their commits are accepted.

List below is old patchset and is dropped, which is non-refractored version.
https://patchwork.kernel.org/project/linux-pci/cover/20230406111142.74410-1-minda.chen@starfivetech.com/

Minda Chen (9):
  dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
  dt-bindings: PCI: microchip: Remove the PLDA common properties
  PCI: PLDA: Get PLDA common codes from Microchip PolarFire host
  PCI: microchip: Move PCIe driver to PLDA directory
  dt-bindings: PLDA: Add PLDA XpressRICH PCIe host controller
  PCI: PLDA: Add host conroller platform driver
  dt-bindings: PCI: Add StarFive JH7110 PCIe controller
  PCI: PLDA: starfive: Add JH7110 PCIe controller
  riscv: dts: starfive: add PCIe dts configuration for JH7110

 .../bindings/pci/microchip,pcie-host.yaml     |  45 +-
 .../pci/plda,xpressrich-pcie-common.yaml      |  72 ++
 .../pci/plda,xpressrich-pcie-host.yaml        |  66 ++
 .../bindings/pci/starfive,jh7110-pcie.yaml    | 138 ++++
 MAINTAINERS                                   |  19 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  44 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  88 +++
 drivers/pci/controller/Kconfig                |   9 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/plda/Kconfig           |  35 +
 drivers/pci/controller/plda/Makefile          |   5 +
 .../{ => plda}/pcie-microchip-host.c          | 594 ++--------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 665 ++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda-plat.c  |  64 ++
 drivers/pci/controller/plda/pcie-plda.h       | 230 ++++++
 drivers/pci/controller/plda/pcie-starfive.c   | 415 +++++++++++
 16 files changed, 1885 insertions(+), 606 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (50%)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda-plat.c
 create mode 100644 drivers/pci/controller/plda/pcie-plda.h
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.17.1

