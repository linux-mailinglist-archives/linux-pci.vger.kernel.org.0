Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE05D3EA018
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 10:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhHLIC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 04:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhHLICv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 04:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F5B26103E;
        Thu, 12 Aug 2021 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628755345;
        bh=0xWGFcLzUWDh9TpyGptikfq/gqtzq/wUyMbGsf4HPqU=;
        h=From:To:Cc:Subject:Date:From;
        b=lx++LT8xe57SJghG2hVUuUD1LixkP47bHlJ/aI+FjBMkEPKKLf0RZ5ojLh6DBjuJ4
         qyWVl2wZm7fS77yp3DQsjZwuA2eNEjs9v1n0zukbGs66mq9dcbGWdlcp0fZL0Upfn2
         R/hVwIM5P5iYtvRer/oLwijVh36LA4V36Acm1bFE40rGUCejIqTd9S0fp+9sjK5E02
         tWUVfAohkLoMTa2wuN9bqJx+M0ZJ7JeOIc8vBcvf6K7fnZsR2JN9BnDxXooh0N2MWd
         ajcGB4vaXSivPVTvNTGJ6r+p2y5ejzbFqocpfzBzv4Er1xwmRSqFrgeqgUCYA3lqrT
         DPogf1EcSLmFg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mE5fT-00DZCe-G2; Thu, 12 Aug 2021 10:02:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v11 00/11] Add support for Hikey 970 PCIe
Date:   Thu, 12 Aug 2021 10:02:11 +0200
Message-Id: <cover.1628755058.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DT schema used by this series got merged at:

	https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=dt/next

Version 11 was modified to reflect this patch:

	https://lore.kernel.org/lkml/655e21422a14620ae2d55335eb72bcaa66f5384d.1628754620.git.mchehab+huawei@kernel.org/T/#u

Which contains a fix to the DT schema meant to make it produce the right sysfs
of_node devnodes.

The series should apply cleanly on the top of v5.14-rc1.

patch1 contains a PHY for Kirin 970 PCIe.

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
 drivers/pci/controller/dwc/pcie-kirin.c | 644 ++++++++++++++----
 drivers/phy/hisilicon/Kconfig           |  10 +
 drivers/phy/hisilicon/Makefile          |   1 +
 drivers/phy/hisilicon/phy-hi3670-pcie.c | 857 ++++++++++++++++++++++++
 5 files changed, 1366 insertions(+), 148 deletions(-)
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-pcie.c

-- 
2.31.1


