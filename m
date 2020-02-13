Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F215B953
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 07:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgBMGJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 01:09:56 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:45672 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgBMGJ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 01:09:56 -0500
Received: from localhost (unknown [192.168.167.8])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0DBC77B572;
        Thu, 13 Feb 2020 14:09:50 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P16450T140624477026048S1581574189162340_;
        Thu, 13 Feb 2020 14:09:50 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <bf2bbd6009bc82268b1b0e4b1c4c96d8>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, William Wu <william.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/6] Add Rockchip new PCIe controller and combo phy support
Date:   Thu, 13 Feb 2020 14:08:05 +0800
Message-Id: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Rockchip's new PCIe controller is based on DesignWare IP and the
combo phy is shard by PCIe and USB3.0 controller. This series adds
both of controller and phy drivers found on Rockchip RV1808 platform.


Changes in v2:
- fix yaml format
- add commit log and fix Kconfig
- remove dead code

Shawn Lin (3):
  dt-bindings: add binding for Rockchip combo phy using an Innosilicon
    IP
  PCI: dwc: Skip allocating own MSI domain if using external MSI domain
  MAINTAINERS: Update PCIe drivers for Rockchip

Simon Xue (2):
  dt-bindings: rockchip: Add DesignWare based PCIe controller
  PCI: rockchip: add DesignWare based PCIe controller

William Wu (1):
  phy/rockchip: inno-combophy: Add initial support

 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  148 +++
 .../bindings/phy/rockchip,inno-combophy.yaml       |   80 ++
 MAINTAINERS                                        |    4 +-
 drivers/pci/controller/Kconfig                     |    4 +-
 drivers/pci/controller/dwc/Kconfig                 |    9 +
 drivers/pci/controller/dwc/Makefile                |    1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |   10 +-
 drivers/pci/controller/dwc/pcie-designware.h       |    1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |  439 ++++++++
 drivers/phy/rockchip/Kconfig                       |    8 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-inno-combphy.c   | 1056 ++++++++++++++++++++
 12 files changed, 1757 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-combphy.c

-- 
1.9.1



