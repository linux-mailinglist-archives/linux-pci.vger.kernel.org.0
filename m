Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0B1BF210
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 10:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgD3IGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 04:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgD3IGl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 04:06:41 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DE22073E;
        Thu, 30 Apr 2020 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588234000;
        bh=/yZOHoDX1nONlr6EIuWq1MLzabyhsCxyiK11zIWZqK8=;
        h=From:To:Cc:Subject:Date:From;
        b=ajtL/aqywUl5X1FHyaEFS+da9+i3QR+qOmoX2r7A8jPKoT1iMx2YUAsSzDqQuwjvh
         NtC8kBMeHg9SqYczMGSCw0B+IepJcGHh+OKt+TLreyNgA9t9GU2wOF+4uj/jdoJ1P6
         43753G4QnsHbYv7RTUc2ZKm8m4r/NdjLw9I0gj7E=
Received: by pali.im (Postfix)
        id 8D14C7AD; Thu, 30 Apr 2020 10:06:38 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and Compex wifi cards
Date:   Thu, 30 Apr 2020 10:06:13 +0200
Message-Id: <20200430080625.26070-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

this is the fourth version of the patch series for Armada 3720 PCIe
controller (aardvark). It's main purpose is to fix some bugs regarding
buggy ath10k cards, but we also found out some suspicious stuff about
the driver and the SOC itself, which we try to address.

Patches are available also in my git branch pci-aardvark:
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark

Changes since v3:
- do not change return value of of_pci_get_max_link_speed() function
- mark zero 'max-link-speed' as invalid
- silently use gen3 speed when 'max-link-speed' as invalid

Changes since v2:
- move PCIe max-link-speed property to armada-37xx.dtsi
- replace custom macros by standard linux/pci_regs.h macros
- increase PERST delay to 10ms (needed for initialized Compex WLE900VX)
- disable link training before PERST (needed for Compex WLE900VX)
- change of_pci_get_max_link_speed() function to signal -ENOENT
- handle errors from of_pci_get_max_link_speed() function
- updated comments, commit titles and messages

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
  PCI: aardvark: Improve link training
  PCI: aardvark: Add PHY support
  dt-bindings: PCI: aardvark: Describe new properties
  arm64: dts: marvell: armada-37xx: Set pcie_reset_pin to gpio function
  arm64: dts: marvell: armada-37xx: Move PCIe comphy handle property

Pali Rohár (7):
  PCI: aardvark: Train link immediately after enabling training
  PCI: aardvark: Don't blindly enable ASPM L0s and don't write to
    read-only register
  PCI: of: Zero max-link-speed value is invalid
  PCI: aardvark: Issue PERST via GPIO
  PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
  PCI: aardvark: Replace custom macros by standard linux/pci_regs.h
    macros
  arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed property

 .../devicetree/bindings/pci/aardvark-pci.txt  |   4 +
 .../arm64/boot/dts/marvell/armada-3720-db.dts |   3 +
 .../dts/marvell/armada-3720-espressobin.dtsi  |   2 +-
 .../dts/marvell/armada-3720-turris-mox.dts    |   6 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   4 +-
 drivers/pci/controller/pci-aardvark.c         | 263 +++++++++++++++---
 drivers/pci/of.c                              |   2 +-
 7 files changed, 231 insertions(+), 53 deletions(-)

-- 
2.20.1

