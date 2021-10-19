Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F61F432DC1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 08:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhJSGJN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 02:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233970AbhJSGJH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 02:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C128613A4;
        Tue, 19 Oct 2021 06:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623615;
        bh=A+8OJOQFa1NkBhZm9e9KfmnEBHPF/zzuaCmLT+Q7mo4=;
        h=From:To:Cc:Subject:Date:From;
        b=QpeTiOVf46zjtrdudazE8ouuFKari0yy/GZssp4hrKBNMmAGC5FPJFjQF1pY++wJS
         WJG+nk6HqqYTBzBdRdeh30STE9YEmWzTM7Stl8+oSdnna8gknEiGN9hMBCjV7/6+fo
         Fb4plMTo6/lOIJKwEkZtii98QsNtddzFQf+/q7DI/ftKJ3jgugVLz7DC+vQHzhnYJp
         g3gCweD+F06pAbdkqQM7w4p2U5i44s5sgwZaKzuPCeB+ZxCTW1d7yKXvSQx0HpGaNe
         aORC8T2MGqVpxS93pLrtetlEOAMSPJelVJ6YDo0SKnjhVXmALhsKypdmWeMUcg47Lq
         MRIC2RzbbYfbA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mciGx-001krV-O9; Tue, 19 Oct 2021 07:06:51 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Songxiaowei (Kirin_DRV)" <songxiaowei@hisilicon.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>, Simon Xue <xxm@rock-chips.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Wesley Sheng <wesley.sheng@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v14 00/11] Add support for Hikey 970 PCIe
Date:   Tue, 19 Oct 2021 07:06:37 +0100
Message-Id: <cover.1634622716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

I addressed the issues you pointed on this review.

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

Diff from v13:

@@ -455,7 +455,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
                                    struct platform_device *pdev)
 {
        struct device *dev = &pdev->dev;
-       struct device_node *node = dev->of_node, *child;
+       struct device_node *child, *node = dev->of_node;
        void __iomem *apb_base;
        int ret;
 
@@ -687,9 +687,8 @@ static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
        if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
                return hi3660_pcie_phy_power_off(kirin_pcie);
 
-       for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
+       for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++)
                gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
-       }
 
        phy_power_off(kirin_pcie->phy);
        phy_exit(kirin_pcie->phy);
@@ -790,7 +789,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
                return -EINVAL;
        }
 
-       phy_type = (enum pcie_kirin_phy_type)of_id->data;
+       phy_type = (long)of_id->data;
 
        kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
        if (!kirin_pcie)

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

Mauro Carvalho Chehab (11):
  PCI: kirin: Reorganize the PHY logic inside the driver
  PCI: kirin: Add support for a PHY layer
  PCI: kirin: Use regmap for APB registers
  PCI: kirin: Add support for bridge slot DT schema
  PCI: kirin: give more time for PERST# reset to finish
  PCI: kirin: Add Kirin 970 compatible
  PCI: kirin: Add MODULE_* macros
  PCI: kirin: Allow building it as a module
  PCI: kirin: Add power_off support for Kirin 960 PHY
  PCI: kirin: fix poweroff sequence
  PCI: kirin: Allow removing the driver

 drivers/pci/controller/dwc/Kconfig      |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c | 643 ++++++++++++++++++------
 2 files changed, 497 insertions(+), 148 deletions(-)

-- 
2.31.1


