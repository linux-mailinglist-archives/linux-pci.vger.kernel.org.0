Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8F3C6A82
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 08:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhGMGbf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 02:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233638AbhGMGbe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 02:31:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28D9361283;
        Tue, 13 Jul 2021 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626157725;
        bh=PEvDrwtE2bMG2PczNSuL9uDCvMHHowXcV5u6IAjX46w=;
        h=From:To:Cc:Subject:Date:From;
        b=nzR1lod7qK3qD1h91+LXHZfHDOmr09o67FANoX2f945kRzxW7YVw5ryLhmpjzPRT0
         dg5X5Ib+GN17behzFF1jEoKiodoQXaTea+OTRHkz0YeRujajnE3wtSLPa95KnOmqZv
         0zSx7bFZPr4S/R4W6DuyC2f7xed92vJ0wmBNrmBMFMfhAR+hNtUST7dMSyKEmhX+18
         Yvt3T83wZFiJaYGz2JDj5XbUFEKytST75Q701vh0UQ91G+tUeSEAa8w8xnVW5Cv42w
         u2e5w+duPsL5HnC/YAzrwJrEsl3EVnJMvA2H41wmEKEePaq0l2pF7fduR/5fWcmGqz
         1ZH0zWoAcZ/SA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3BuM-005yPU-OH; Tue, 13 Jul 2021 08:28:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v5 0/8] Add support for Hikey 970 PCIe
Date:   Tue, 13 Jul 2021 08:28:33 +0200
Message-Id: <cover.1626157454.git.mchehab+huawei@kernel.org>
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
    is currently out of supply. It should take 3-4 weeks to arrive here. I'll
    run an extra test on it once it arrives.

---

v5:
- added "static" to hi3670_pcie_get_eyeparam() declaration on patch 6/8

v4:

- dropped the DTS patch, as it depends on a PMIC-related patch series;
- minor changes at the patch description;
- HiKey and HiSilicon are now using the preferred CamelCase format.


Mauro Carvalho Chehab (8):
  dt-bindings: phy: Add bindings for HiKey 960 PCIe PHY
  dt-bindings: phy: Add bindings for HiKey 970 PCIe PHY
  dt-bindings: PCI: kirin: Fix compatible string
  dt-bindings: PCI: kirin: Drop PHY properties
  phy: HiSilicon: Add driver for Kirin 960 PCIe PHY
  phy: HiSilicon: add driver for Kirin 970 PCIe PHY
  PCI: kirin: Drop the PHY logic from the driver
  PCI: kirin: Use regmap for APB registers

 .../devicetree/bindings/pci/kirin-pcie.txt    |  21 +-
 .../phy/hisilicon,phy-hi3660-pcie.yaml        |  82 ++
 .../phy/hisilicon,phy-hi3670-pcie.yaml        | 101 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |  29 +-
 drivers/pci/controller/dwc/pcie-kirin.c       | 298 ++----
 drivers/phy/hisilicon/Kconfig                 |  20 +
 drivers/phy/hisilicon/Makefile                |   2 +
 drivers/phy/hisilicon/phy-hi3660-pcie.c       | 325 +++++++
 drivers/phy/hisilicon/phy-hi3670-pcie.c       | 892 ++++++++++++++++++
 9 files changed, 1500 insertions(+), 270 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-pcie.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-pcie.c

-- 
2.31.1


