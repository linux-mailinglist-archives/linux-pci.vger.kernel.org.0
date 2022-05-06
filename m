Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386C351D971
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441843AbiEFNoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441814AbiEFNo3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 09:44:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A32BE7;
        Fri,  6 May 2022 06:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF808B835AA;
        Fri,  6 May 2022 13:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5040EC385A8;
        Fri,  6 May 2022 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651844442;
        bh=RT1F1zNAaJmkdaF49UnBjI25nZ5pYOQV7wKcebKfjIA=;
        h=From:To:Cc:Subject:Date:From;
        b=POIqY7hRPVqRnKVU7bJThf6D6fVf8sDOi3cAgufXdobV1guN0UAx5CuwtDzOr6hAg
         x5h2CV9WPv54Fi//9WoyVx/vkWq0vBDV1+UlxFtpnnffzktD3rVPwXXJLBcqcQIz3/
         TRNCEU4YH2I2m1gI1Wum1gVnaBQmIjD7ERe5yr5U24DS5SKCPHG1XLHkDttoXqUAsu
         q9CFVaeXYz3BedK/5foq0NmU2AiyHqALDUe9MYJM3sDAUwSzJP8iJ463SO8h5VstVf
         kt2tREwT+cfKXkdKcVvMgw4sOcKbjL5LTA4dlK9ykOlACMnza6G7zS1KfjnySkh/6B
         oROnzoZTL0I5A==
Received: by pali.im (Postfix)
        id 8180D1141; Fri,  6 May 2022 15:40:39 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/6] PCI: mvebu: Add support for PME and AER interrupts
Date:   Fri,  6 May 2022 15:40:23 +0200
Message-Id: <20220506134029.21470-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

mvebu PCIe PME and AER interrupts are reported via PCIe summary
interrupt. PCIe summary interrupt is reported via mvebu MPIC SoC error
summary interrupt. And MPIC SoC error summary interrupt is reported via
MPIC IRQ 4.

This patch series implements support for interrupts in MPIC SoC error
hierarchy in irq-armada-370-xp.c driver and support for interrupts in
mvebu PCIe hierarchy in pci-mvebu.c.

Finally PCIe PME and AER interrupts are routed to the correct PCIe Root
Port, which allows kernel PME and AER drivers to take care of them.

Tested on A385 board and kernel PME and AER drivers works correctly:

[    0.898482] pcieport 0000:00:01.0: PME: Signaling with IRQ 61
[    0.904422] pcieport 0000:00:01.0: AER: enabled with IRQ 61
[    0.910113] pcieport 0000:00:02.0: enabling device (0140 -> 0142)
[    0.916299] pcieport 0000:00:02.0: PME: Signaling with IRQ 62
[    0.922216] pcieport 0000:00:02.0: AER: enabled with IRQ 62
[    0.927917] pcieport 0000:00:03.0: enabling device (0140 -> 0142)
[    0.934090] pcieport 0000:00:03.0: PME: Signaling with IRQ 63
[    0.940006] pcieport 0000:00:03.0: AER: enabled with IRQ 63

This change finally allows to debug PCIe issues on A385 boards.

Pali Rohár (6):
  dt-bindings: irqchip: armada-370-xp: Update information about MPIC SoC
    Error
  irqchip/armada-370-xp: Implement SoC Error interrupts
  ARM: dts: armada-38x.dtsi: Add node for MPIC SoC Error IRQ controller
  dt-bindings: PCI: mvebu: Update information about summary interrupt
  PCI: mvebu: Implement support for interrupts on emulated bridge
  ARM: dts: armada-385.dtsi: Add definitions for PCIe summary interrupts

 .../marvell,armada-370-xp-mpic.txt            |   9 +
 .../devicetree/bindings/pci/mvebu-pci.txt     |   1 +
 arch/arm/boot/dts/armada-385.dtsi             |  20 +-
 arch/arm/boot/dts/armada-38x.dtsi             |   5 +
 drivers/irqchip/irq-armada-370-xp.c           | 213 +++++++++++++++++-
 drivers/pci/controller/pci-mvebu.c            | 208 +++++++++++++++--
 6 files changed, 426 insertions(+), 30 deletions(-)

-- 
2.20.1

