Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78EA41A9BE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 09:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbhI1HgF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 03:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239292AbhI1HgF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 03:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39F41610FC;
        Tue, 28 Sep 2021 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632814466;
        bh=htrqF2oc/dxAQtvS8aSlnb0UgtC3mFheBG7Un+/MuRw=;
        h=From:To:Cc:Subject:Date:From;
        b=JQQrNeJqG4DISlu3Gd9xysq9zxeo/wR/27Jtb2fCC+psPp0GquvfPvGeMW1RGxTsk
         MK/qFKkoSUs4LaV6VvZw9QwQZ8L+q8tC2FxvyWCVpGfDG28rr4dekaHZL/YpJ3Oz7a
         dLS+/U8/BcAK5NdXDI6d/Xh9LNXE+RX27wZdP41RA3nPj+ehnY2KIt4utA8yraTvxu
         6iXRwK8Bq6TPsWN5AFd8PT7qmUecoDUCypTy/RJeSEovPHuV9Uz4kekOnQzhRWDoS1
         hjLdv3YkcEq89dv1x9LLfyzkwtpmNkfjMSFyCL+h8z7LocJ178lQfspT004xzEkeqg
         CJGGIi0bSurcA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mV7dA-000RPY-7t; Tue, 28 Sep 2021 09:34:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Date:   Tue, 28 Sep 2021 09:34:10 +0200
Message-Id: <cover.1632814194.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie-kirin PCIe driver contains internally a PHY interface for
Kirin 960, but it misses support for Kirin 970.

Patch1 contains a PHY for Kirin 970 PCIe.

The remaining patches add support for Kirin 970 at the pcie-kirin driver, and
add the needed logic to compile it as module and to allow to dynamically
remove the driver in runtime.

Tested on HiKey970:

  # lspci -D -PP
  0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
  0000:00:00.0/01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  0000:00:00.0/01:00.0/02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  0000:00:00.0/01:00.0/02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  0000:00:00.0/01:00.0/02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  0000:00:00.0/01:00.0/02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  0000:00:00.0/01:00.0/02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
  0000:00:00.0/01:00.0/02:01.0/03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a809
  0000:00:00.0/01:00.0/02:07.0/06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)

Tested on HiKey960:

  # lspci -D 
  0000:00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)

---

v12:
  - Change a comment at patch 1 to not use c99 style.

v11:
  - patch 5 changed to use the right PCIe topology
  - all other patches are identical to v10.

v10:
  - patch 1: dropped magic numbers from PHY driver
  - patch 5: allow pcie child nodes without reset-gpios
  - all other patches are identical to v9.

v9:
  - Did some cleanups at patches 1 and 5



Mauro Carvalho Chehab (11):
  phy: HiSilicon: Add driver for Kirin 970 PCIe PHY
  PCI: kirin: Reorganize the PHY logic inside the driver
  PCI: kirin: Add support for a PHY layer
  PCI: kirin: Use regmap for APB registers
  PCI: kirin: Add support for bridge slot DT schema
  PCI: kirin: Add Kirin 970 compatible
  PCI: kirin: Add MODULE_* macros
  PCI: kirin: Allow building it as a module
  PCI: kirin: Add power_off support for Kirin 960 PHY
  PCI: kirin: fix poweroff sequence
  PCI: kirin: Allow removing the driver

 drivers/pci/controller/dwc/Kconfig      |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c | 644 +++++++++++++-----
 drivers/phy/hisilicon/Kconfig           |  10 +
 drivers/phy/hisilicon/Makefile          |   1 +
 drivers/phy/hisilicon/phy-hi3670-pcie.c | 845 ++++++++++++++++++++++++
 5 files changed, 1354 insertions(+), 148 deletions(-)
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-pcie.c

-- 
2.31.1


