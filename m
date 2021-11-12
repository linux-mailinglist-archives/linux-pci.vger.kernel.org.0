Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB644EF4E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 23:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhKLWhx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 17:37:53 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57060 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235934AbhKLWhx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 17:37:53 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C03851A0350;
        Fri, 12 Nov 2021 23:35:00 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 829FD1A031E;
        Fri, 12 Nov 2021 23:35:00 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 9D8F540A77;
        Fri, 12 Nov 2021 15:34:59 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 00/11] ls1028a device tree updates
Date:   Fri, 12 Nov 2021 16:34:46 -0600
Message-Id: <20211112223457.10599-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some accumulated ls1028a dts changes from the SDK.  Also included two
binding updates needed for these dts changes.

Alex Marginean (1):
  arm64: dts: ls1028a-qds: add overlays for various serdes protocols

Biwen Li (4):
  arm64: dts: ls1028a: add ftm_alarm1 node to be used as wakeup source
  arm64: dts: ls1028a: add flextimer based pwm nodes
  arm64: dts: ls1028a-rdb: enable pwm0
  arm64: dts: ls1028a-qds: move rtc node to the correct i2c bus

Li Yang (2):
  dt-bindings: pci: layerscape-pci: define aer/pme interrupts
  arm64: dts: ls1028a-rdb: reorder nodes to be alphabetic

Sahil Malhotra (1):
  arm64: dts: ls1028a-qds: enable optee node

Vabhav Sharma (1):
  arm64: dts: ls1028a-qds: enable lpuart1

Xiaowei Bao (2):
  dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for
    ls1028a
  arm64: dts: ls1028a: Add PCIe EP nodes

 .../bindings/pci/layerscape-pci.txt           |  15 +-
 arch/arm64/boot/dts/freescale/Makefile        |  16 +++
 .../dts/freescale/fsl-ls1028a-qds-13bb.dts    | 113 +++++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-65bb.dts    | 108 +++++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-7777.dts    |  82 +++++++++++
 .../dts/freescale/fsl-ls1028a-qds-85bb.dts    | 107 ++++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-899b.dts    |  75 ++++++++++
 .../dts/freescale/fsl-ls1028a-qds-9999.dts    |  79 +++++++++++
 .../boot/dts/freescale/fsl-ls1028a-qds.dts    |  43 ++++--
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 102 +++++++-------
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 130 +++++++++++++++++-
 11 files changed, 809 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts

-- 
2.25.1

