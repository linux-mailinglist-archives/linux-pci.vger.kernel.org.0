Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5F1B24C4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 13:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgDULRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 07:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgDULRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 07:17:05 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F20EC061A0F
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2020 04:17:05 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 5552914088B;
        Tue, 21 Apr 2020 13:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587467822; bh=TAG7UGkroiUF+Iz9YmZwmer/vqlVCFSQ5u8kjGzBoUk=;
        h=From:To:Date;
        b=vmfkY1fqlmElzrg7ikOLC0g5FxlNs/8d2B8Kchwl5bDRRp3h2npC6j0yb67ckjNwo
         6xnG1HvVVIQB3yrX8EjLAE8QjN9Czx+L3XeDTUbcO+xzmtmmJ/8+1ci0pFk9ltcwT5
         0xRJOTkOAaqXttvb/QUmbnXZhcTj7v4CRYzlerEE=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v2 0/9] PCI: aardvark: Fix support for Turris MOX and Compex wifi cards
Date:   Tue, 21 Apr 2020 13:16:52 +0200
Message-Id: <20200421111701.17088-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

this is the second version of the patch series for Armada 3720 PCIe
controller (aardvark). It's main purpose is to fix some bugs regarding
buggy ath10k cards, but we also found out some suspicious stuff about
the driver and the SOC itself, which we try to address.

Changes since v1:
- commit titles and messages were reviewed and some of them were rewritten
- patches 1 and 5 from v1 which touch PCIe speed configuration were
  reworked into one patch
- patch 2 from v1 was removed, it is not needed anymore
- patch 7 from v1 now touches the device tree of armada-3720-db
- a patch was added that tries to enable PCIe PHY via generic-phy API
  (if a phandle to the PHY is found in the device tree)
- a patch describing the new PCIe node DT properties was added
- a patch was added that moves the PHY phandle from board device trees
  to armada-37xx.dtsi

Marek and Pali

Marek Behún (5):
  PCI: aardvark: improve link training
  PCI: aardvark: add PHY support
  dt-bindings: PCI: aardvark: describe new properties
  arm64: dts: marvell: armada-37xx: set pcie_reset_pin to gpio function
  arm64: dts: marvell: armada-37xx: move PCIe comphy handle property

Pali Rohár (4):
  PCI: aardvark: train link immediately after enabling training
  PCI: aardvark: don't write to read-only register
  PCI: aardvark: issue PERST via GPIO
  PCI: aardvark: add FIXME comment for PCIE_CORE_CMD_STATUS_REG access

 .../devicetree/bindings/pci/aardvark-pci.txt  |   4 +
 .../arm64/boot/dts/marvell/armada-3720-db.dts |   3 +
 .../dts/marvell/armada-3720-espressobin.dtsi  |   2 +-
 .../dts/marvell/armada-3720-turris-mox.dts    |   5 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   3 +-
 drivers/pci/controller/pci-aardvark.c         | 219 +++++++++++++++---
 6 files changed, 203 insertions(+), 33 deletions(-)

-- 
2.24.1

