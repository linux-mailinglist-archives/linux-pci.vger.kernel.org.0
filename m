Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0123C1692
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 17:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhGHPxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 11:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231944AbhGHPxF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jul 2021 11:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 956D2616ED;
        Thu,  8 Jul 2021 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625759423;
        bh=oa74Tybu5HedvZVZTqYR2f9HSos8k6RTN9dJvzTphn4=;
        h=From:To:Cc:Subject:Date:From;
        b=Q+O6ZDdGEBnkFEr6zQrynCPAe2CjViex2if/DDrh7a8iGMB4gdkfvP6M3dVr6JW5R
         8s5YsA4HU1SJdXiBy2tMuflJey6gHdoldMCk8C3bApOjZB5rStVCKcTNlsHOy17bpP
         cp+dTsNdPnAg0OiONG3gCYPPeW+17PCHGW91Rci53M4lml7E5uU0mhTjpfOXfx9Hpy
         A2k/iaQgivlMcqDUnqttw893u4QmH4yNHNxn4J5EGDXyxck3XG47wEpLWm/9eG7NNd
         1gQTrJI8xy0VEs8p2Eg+Xve2jljhJWPhE6u8L8+/MzGLUZL/LU2y+n7u8hRzb3qoW1
         NWV28/c0V41tw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1WI4-008VV0-Bs; Thu, 08 Jul 2021 17:50:16 +0200
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
Subject: [PATCH RFC 0/7] Add support for Hikey 970 PCIe
Date:   Thu,  8 Jul 2021 17:50:07 +0200
Message-Id: <cover.1625758732.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

That's the third attempt of adding PCIe support for Hikey 970 from my side.
The past attempt was this one:

	https://lore.kernel.org/lkml/cover.1612335031.git.mchehab+huawei@kernel.org/

As requested by Rob Herring, this series use a different approach than
the past attempt: it first splits the PHY part into a separate driver. Then, it
adds support for Kirin 970.

Due to such change, the DT bindings had to change, as several properties moved
from the PCIe driver to the PHY. IMO, it makes a lot more sense now.

This is is currently a work in progress. There are still a few things to be solved,
but let me send what I have so far for a quick review if this approach is
acceptable.

Manivannan,

Please notice that this patch:

  PCI: kirin: split PHY interface from the driver

Contains the code written by you, on your attempt to upstream this.
If you're OK, please send your SoB. I should likely add a Co-authored-by:
tag at the final version.

The same somewhat applies to this patch:

  arm64: dts: hisilicon: Add support for HiKey 970 PCIe controller hardware

but at the reverse direction, as I had to shift some properties from the 
PCIe binding to the PCIe PHY one.

Also, if this approach is OK, I'm considering to move all clock lines to the
PHY driver, as it makes more sense there, and the device is *very* sensitive
to the clock order. Any change at the sequence may cause the SoC to generate
a  NMI interrupt (SError), which, in turn, causes a kernel panic.

Manivannan Sadhasivam (1):
  arm64: dts: hisilicon: Add support for HiKey 970 PCIe controller
    hardware

Mauro Carvalho Chehab (6):
  PCI: kirin: split PHY interface from the driver
  PCI: kirin: use regmap for APB registers
  bindings: kirin-pcie.txt: fix compatible string
  bindings: kirin-pcie.txt: drop PHY properties
  bindings: phy: add bindings for Hikey 960 PCIe PHY
  phy: add driver for Kirin 970 PCIe PHY

 .../devicetree/bindings/pci/kirin-pcie.txt    |  24 +-
 .../phy/hisilicon,phy-hi3660-pcie.yaml        |  70 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |  29 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  72 ++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |   1 -
 drivers/pci/controller/dwc/pcie-kirin.c       | 254 ++----
 drivers/phy/hisilicon/Kconfig                 |  20 +
 drivers/phy/hisilicon/Makefile                |   2 +
 drivers/phy/hisilicon/phy-hi3660-pcie.c       | 273 ++++++
 drivers/phy/hisilicon/phy-hi3670-pcie.c       | 844 ++++++++++++++++++
 10 files changed, 1370 insertions(+), 219 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-pcie.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-pcie.c

-- 
2.31.1


