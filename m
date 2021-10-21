Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7983C435F8E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhJUKr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 06:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230527AbhJUKry (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 06:47:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 428D961037;
        Thu, 21 Oct 2021 10:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634813138;
        bh=XwJstpxHMhn9piHQRZ67Cm97+c1ufLdQ++YgvUgXoEM=;
        h=From:To:Cc:Subject:Date:From;
        b=uQZrHNf30Eq5zmJIP4UhpYEnAOEhhx3QZHmHUMZzM40kC5pLhxg9xvlYIApnvILiU
         HOaIjK8ZI+5A9ievq1OdKqHgbOK+iJ8Gt5DDf5XEzf6kWiYrdv15vqgnZ1VhPnn8+V
         HYlPACmJgAptDfaiRG175r5p7/ZNBEg7NADFmaCSydkyEx5T/wyAG1HNZAEOqI2sWd
         XCGAHYzYDzrhKa22ianvJ/jedV3r0dY93LpUL+Dv1g5PDXKrYCiYr8/iB802zmRHED
         eWLkIoW7f+bGsW9WQ6JqsiOUh6bB4A5EX0bi0XZ7KwJCv7dowXPi0hcyJs15Dvhx5L
         3PZoQ89T3d2YQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mdVZi-002z4m-Up; Thu, 21 Oct 2021 11:45:30 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v15 00/13] Add support for Hikey 970 PCIe
Date:   Thu, 21 Oct 2021 11:45:07 +0100
Message-Id: <cover.1634812676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

I split patch 09/10 from v13 into three patches, in order to have one logical
change per patch, adding a proper descriptio to each of them. The final
code didn change.

The pcie-kirin PCIe driver contains internally a PHY interface for
Kirin 960, but it misses support for Kirin 970. A new PHY driver
for it was added at drivers/phy/hisilicon/phy-hi3670-pcie.c
(already merged via PHY tree).

Add support for Kirin 970 PHY driver at the pcie-kirin.c.

While here, also add the needed logic to compile it as module and
to allow to dynamically remove the driver in runtime.

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

v15:
  - The power-off fix patch was split into 3, in order to have one logical change
    per patch.
  -  Removed Fixes: tag from the poweroff patch;
  - Adjusted capitalization of two patch summary lines
  - No functional changes. The diff of this series is identical to v14.

v14:
  - Split a timeout logic from patch 4, placing it on a separate patch;
  - Added fixes: and cc: tags to the power_off fixup patch;
  - change a typecast from of_data to long, in order to avoid a warning on
    some randconfigs;
  - removed uneeded brackets at the power_off patch;
  - reordered struct device pointers at kirin_pcie_get_resource();
  - added a c/c to kishon at the PHY-related patches.

v13:
  - Added Xiaowei's ack for the series.

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

Mauro Carvalho Chehab (13):
  PCI: kirin: Reorganize the PHY logic inside the driver
  PCI: kirin: Add support for a PHY layer
  PCI: kirin: Use regmap for APB registers
  PCI: kirin: Add support for bridge slot DT schema
  PCI: kirin: Give more time for PERST# reset to finish
  PCI: kirin: Add Kirin 970 compatible
  PCI: kirin: Add MODULE_* macros
  PCI: kirin: Allow building it as a module
  PCI: kirin: Add power_off support for Kirin 960 PHY
  PCI: kirin: Move the power-off code to a common routine
  PCI: kirin: Disable clkreq during poweroff sequence
  PCI: kirin: De-init the dwc driver
  PCI: kirin: Allow removing the driver

 drivers/pci/controller/dwc/Kconfig      |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c | 643 ++++++++++++++++++------
 2 files changed, 497 insertions(+), 148 deletions(-)

-- 
2.31.1


