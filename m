Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DC24BD0F8
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243180AbiBTTeQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiBTTeQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCAF4506A
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:33:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D1BAB80DB6
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489D5C340E8;
        Sun, 20 Feb 2022 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385631;
        bh=5Y8A0/tZzQBaf1BEHX5aYVJwrs7tRMeBrlezCbI3i4E=;
        h=From:To:Cc:Subject:Date:From;
        b=pesEdHRN/1A0ZngVaBXRJenfScKdEeRkt0DdUIuSmryeMbrYJHNEeuSS4R3lUIERQ
         IivjI+QTZR12piVVsmrMn1gUUd9eidyfaMjWyHrusz/P17/6l7PHhUUgWBO3USjBB9
         Z7Fb1B2IN7IbBS5IhtYl4CuUNcRShEjyu8GBrncNbkWpl44/aMkDj4vt8LfV5ZYvtY
         9NISBEenlXM54PYjKBM4dNaVGWiZbx5Onhkyd/9iBRwNPhdqd45EVVTChSBJqHnvBz
         W1bXtHfWzUVfx5XL4g3Ihpcz8IJC5hDXrDFk2GQR3w5p3CeV75if8JNHJZxEjO021V
         Q2OR3I3DcdP2A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 00/18] PCI: aardvark controller changes BATCH 5
Date:   Sun, 20 Feb 2022 20:33:28 +0100
Message-Id: <20220220193346.23789-1-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo, Krzysztof,

here comes batch 5 of changes for Aardvark PCIe controller.

This batch
- adds support for AER
- adds support for DLLSC and hotplug interrupt
- adds support for sending slot power limit message
- adds enabling/disabling PCIe clock
- adds suspend support
- optimizes link training by adding it into separate worker
- optimizes GPIO resetting by asserting it only if it wasn't asserted
  already

Marek

Marek Behún (1):
  arm64: dts: marvell: armada-37xx: Add clock to PCIe node

Miquel Raynal (2):
  PCI: aardvark: Add clock support
  PCI: aardvark: Add suspend to RAM support

Pali Rohár (13):
  PCI: aardvark: Add support for AER registers on emulated bridge
  PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
  PCI: aardvark: Fix reporting Slot capabilities on emulated bridge
  PCI: pciehp: Enable DLLSC interrupt only if supported
  PCI: pciehp: Enable Command Completed Interrupt only if supported
  PCI: aardvark: Add support for DLLSC and hotplug interrupt
  PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
  PCI: Add function for parsing `slot-power-limit-milliwatt` DT property
  dt-bindings: PCI: aardvark: Describe slot-power-limit-milliwatt
  PCI: aardvark: Send Set_Slot_Power_Limit message
  arm64: dts: armada-3720-turris-mox: Define slot-power-limit-milliwatt
    for PCIe
  PCI: aardvark: Run link training in separate worker
  PCI: aardvark: Optimize PCIe card reset via GPIO

Russell King (2):
  PCI: pci-bridge-emul: Re-arrange register tests
  PCI: pci-bridge-emul: Add support for PCIe extended capabilities

 .../devicetree/bindings/pci/aardvark-pci.txt  |   2 +
 .../dts/marvell/armada-3720-turris-mox.dts    |   1 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   1 +
 drivers/pci/controller/pci-aardvark.c         | 380 ++++++++++++++++--
 drivers/pci/hotplug/pciehp_hpc.c              |  34 +-
 drivers/pci/hotplug/pnv_php.c                 |  13 +-
 drivers/pci/of.c                              |  64 +++
 drivers/pci/pci-bridge-emul.c                 | 130 +++---
 drivers/pci/pci-bridge-emul.h                 |  15 +
 drivers/pci/pci.h                             |  15 +
 include/uapi/linux/pci_regs.h                 |   4 +
 11 files changed, 565 insertions(+), 94 deletions(-)

-- 
2.34.1

