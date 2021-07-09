Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5C53C2259
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 12:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhGIKoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 06:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhGIKoe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 06:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 390F5613D6;
        Fri,  9 Jul 2021 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625827311;
        bh=LIIAa/aqK4HB8FJB22iEgxigFKB0TfOTlDkd+ACAaEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=l+AHKjtkC4zwuTRSoEPGei9fYxI51Dc8P8waNHA4MdpkUCBKqdWWk2+p2JofNH372
         AKD0zhy6ejV+UUO2ZEqD8Xr58XkRDTmx1J2an3JG6Rb5rtWbKcelyRmGTAWSpp1OAw
         s1vIKZJaHa13/cmHYiu6nk61+Yv7ekJM5lqTRf2rcmKKF+kCM32erCLOvk82/GGufA
         +0YCG6sCyJ3XKBBIh6J0lTUG2O9FSb5hco2KeV8/WN5ctCCHcbmlyMDsUeSqI/xoek
         aqumwamXfIfXiu1p/B3Y2FUfZzqHuCVKAq2ICK2dhriFSYiNtcD/16+LvyjscR3iWn
         2+MY7cCM889FA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1nx7-00B5FP-3x; Fri, 09 Jul 2021 12:41:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v3 0/9] Add support for Hikey 970 PCIe
Date:   Fri,  9 Jul 2021 12:41:36 +0200
Message-Id: <cover.1625826353.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As requested by Rob Herring, this series split the PHY part into a separate driver.
Then, it adds support for Kirin 970 on a single patch.

With this change, the PHY-specific device tree bindings for Kirin 960 moved
to its own PHY properties.

Manivannan,

Please notice that the last two patches are marked as co-developed:

	phy: hisilicon: add driver for Kirin 970 PCIe PHY
	arm64: dts: hisilicon: Add support for HiKey 970 PCIe controller hardware

The first one contains the code you submitted in the past adding
support for Kirin 970 at the pcie-kirin driver, modified by me and
moved to a separate driver.

The second one is the DTS file, also modified by me in order to split the PHY
properties from the PCIe ones.

Please send your SoB to confirm that both changes are OK for you.

Tested on Hikey970:

  $ lspci
  00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
  01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)

  $ ethtool enp6s0
  Settings for enp6s0:
	Supported ports: [ TP	 MII ]
	Supported link modes:   10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Half 1000baseT/Full
	Supported pause frame use: Symmetric Receive-only
	Supports auto-negotiation: Yes
	Supported FEC modes: Not reported
	Advertised link modes:  10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Half 1000baseT/Full
	Advertised pause frame use: Symmetric Receive-only
	Advertised auto-negotiation: Yes
	Advertised FEC modes: Not reported
	Link partner advertised link modes:  10baseT/Half 10baseT/Full
	                                     100baseT/Half 100baseT/Full
	Link partner advertised pause frame use: Symmetric Receive-only
	Link partner advertised auto-negotiation: Yes
	Link partner advertised FEC modes: Not reported
	Speed: 100Mb/s
	Duplex: Full
	Auto-negotiation: on
	master-slave cfg: preferred slave
	master-slave status: slave
	Port: Twisted Pair
	PHYAD: 0
	Transceiver: external
	MDI-X: Unknown
  netlink error: Operation not permitted
	Link detected: yes

Partially tested on Hikey 960[1]:

  $ lspci
  00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)

[1] The Hikey 960 doesn't come with any internal PCIe device.
    Its hardware supports just an external device via a M.2 slot that
    doesn't support SATA. I ordered a NVMe device to test, but the vendor
    is currently out of supply. It should take 4-5 weeks to arrive here. I'll
    run an extra test on it once it arrives.

Manivannan Sadhasivam (1):
  arm64: dts: hisilicon: Add support for HiKey 970 PCIe controller
    hardware

Mauro Carvalho Chehab (8):
  dt-bindings: phy: add bindings for Hikey 960 PCIe PHY
  dt-bindings: phy: add bindings for Hikey 970 PCIe PHY
  dt-bindings: PCI: kirin: fix compatible string
  dt-bindings: PCI: kirin: drop PHY properties
  phy: hisilicon: add a PHY driver for Kirin 960
  PCI: kirin: drop the PHY logic from the driver
  PCI: kirin: use regmap for APB registers
  phy: hisilicon: add driver for Kirin 970 PCIe PHY

 .../devicetree/bindings/pci/kirin-pcie.txt    |  21 +-
 .../phy/hisilicon,phy-hi3660-pcie.yaml        |  82 ++
 .../phy/hisilicon,phy-hi3670-pcie.yaml        | 101 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |  29 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  72 ++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |   1 -
 drivers/pci/controller/dwc/pcie-kirin.c       | 298 ++----
 drivers/phy/hisilicon/Kconfig                 |  20 +
 drivers/phy/hisilicon/Makefile                |   2 +
 drivers/phy/hisilicon/phy-hi3660-pcie.c       | 325 +++++++
 drivers/phy/hisilicon/phy-hi3670-pcie.c       | 892 ++++++++++++++++++
 11 files changed, 1572 insertions(+), 271 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-pcie.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-pcie.c

-- 
2.31.1


