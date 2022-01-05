Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B74485545
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiAEPC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiAEPCy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 10:02:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D8EC061245;
        Wed,  5 Jan 2022 07:02:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48716B81BA3;
        Wed,  5 Jan 2022 15:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A0BC36AE0;
        Wed,  5 Jan 2022 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641394972;
        bh=wjn320Q4DEOaeeCjYoDrjX9G/mND1Q5tCyT5sWz6ZRk=;
        h=From:To:Cc:Subject:Date:From;
        b=t0qz88ik2Pzibi2tVKTFQjxOFnHlX475pqu0tIpbLtqyZQd8XkFMpecb68tjMozt/
         GOuOM2dyNH27tzm8YNIvFL00OMGl23X0o+IQEuy70581NkvHviRghI0Rkc48qrgaNt
         ukSBuUN2vtDEBNFc7wVOeb8XavNINzpuerLf+Ac6ZkkXIAKFLKXAxnMgLwg1Bsnvda
         IobkkbsegtwSONSrBy3K+R7DBejpbUxw3oxFrh2GzW8Fq8iAfmFxOzdj6Z8i+9mg4x
         nJsbPVQafv/XlCCHXVP5KwpixIotm7cBz5fVKizfzp3Lg6UhNmQb6+UV503DXi7ECA
         uH+iuxIGJ1omQ==
Received: by pali.im (Postfix)
        id 0C10582A; Wed,  5 Jan 2022 16:02:49 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/11] PCI: mvebu: subsystem ids, AER and INTx
Date:   Wed,  5 Jan 2022 16:02:28 +0100
Message-Id: <20220105150239.9628-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series extends pci-bridge-emul.c driver to emulate PCI Subsystem
Vendor ID capability and PCIe extended capabilities. And then implement
in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCIe AER
registers, support for legacy INTx interrupts, configuration for X1/X4
mode and usage of new PCI child_ops API.

This patch series depends on other pci-mvebu and pci-bridge-emul patches from:
https://lore.kernel.org/linux-pci/20220104153529.31647-1-pali@kernel.org/

Pali Rohár (9):
  PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem Vendor ID
    capability
  dt-bindings: PCI: mvebu: Add num-lanes property
  PCI: mvebu: Correctly configure x1/x4 mode
  PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID on emulated
    bridge
  PCI: mvebu: Add support for Advanced Error Reporting registers on
    emulated bridge
  PCI: mvebu: Use child_ops API
  dt-bindings: PCI: mvebu: Update information about intx interrupts
  PCI: mvebu: Implement support for legacy INTx interrupts
  ARM: dts: armada-385.dtsi: Add definitions for PCIe legacy INTx
    interrupts

Russell King (2):
  PCI: pci-bridge-emul: Re-arrange register tests
  PCI: pci-bridge-emul: Add support for PCIe extended capabilities

 .../devicetree/bindings/pci/mvebu-pci.txt     |  16 +
 arch/arm/boot/dts/armada-385.dtsi             |  52 ++-
 drivers/pci/controller/pci-mvebu.c            | 352 +++++++++++++++---
 drivers/pci/pci-bridge-emul.c                 | 167 ++++++---
 drivers/pci/pci-bridge-emul.h                 |  17 +
 5 files changed, 494 insertions(+), 110 deletions(-)

-- 
2.20.1

