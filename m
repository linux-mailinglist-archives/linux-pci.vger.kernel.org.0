Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407235AD996
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiIETZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiIETZS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:25:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F98C1A814;
        Mon,  5 Sep 2022 12:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DF790CE13B1;
        Mon,  5 Sep 2022 19:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE930C433D6;
        Mon,  5 Sep 2022 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662405914;
        bh=fO/Wpv5YcoIkYZ8e/EM1T7nTT0WkvQ0tJJN+l68UVfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqF26oiIozeAHlSt/R2brCxL80bI3tHLkT5oMQIRgpa2FGqWNIXUGNh920b2bVz6R
         CoqozJtZU9OJe9tWMLdlXY5nrTifi6CwSeJozAVkZ9u3Lzw2Pivs9oqtK84aIv6ILC
         c1b1QdrGLyCZqgzT2YiQO4u9k7c1UtRFmS2YA/pcpjiCYFQptqkN1uEZ8YzSz7geZB
         ESBsYwMJeJhk17cQ5AX8hBpmX5J4PPuUPq5CaoHwadk8u5IdyXdJ2o0omB3jSPpdHF
         8RzQ0HSz+XvyPY4FIWuo17xaPMn/BSGCX1orNZN/b85WCegEdq8W3nAD7Q28wYIAAr
         cWTWTUgZrAk8g==
Received: by pali.im (Postfix)
        id 217687D7; Mon,  5 Sep 2022 21:25:11 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/7] PCI: mvebu: add support for orion soc
Date:   Mon,  5 Sep 2022 21:23:03 +0200
Message-Id: <20220905192310.22786-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220718202843.6766-1-maukka@ext.kapsi.fi>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
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

Hello! This patch series add support for Orion PCIe controller into
pci-mvebu.c driver. V3 version has completely rewritten pci-mvebu.c code
to parse all physical addresses from device tree files according to
mvebu-pci.txt documentation, allow access to all extended PCIe config
space registers and use modern kernel API pci_remap_cfgspace() and
mvebu_mbus_add_window_by_id() fir mapping PCIe config space.

Most of Marvell device tree code in pci-mvebu.c is giant magic, but it was
there because this change and it is de-facto API between dts files and
kernel used for a long time. Note that it is misused according to PCI
device tree bindings, but we have to follow this Marvell bindings to do
not introduce backward incompatibility issues for other non-Orion
platforms.

Mauri tested these changes on DNS323 board with both DT and non-DT builds.
PCIe AER is working too (one of the feature which proved that access to
extended PCIe config registers is working fine).

After this patch is accepted we are planning to look at existing Orion
arch specific code and covert it to use this new DT based pci-mvebu.c
code. Later this would allow to kill arch specific Orion PCIe code,
which is in arch/arm/plat-orion/pcie.c and parts also in file
arch/arm/mach-orion5x/pci.c (shared with old-PCI bus code).

This patch series depends on another patches:
https://lore.kernel.org/linux-pci/20220524122817.7199-1-pali@kernel.org/
https://lore.kernel.org/linux-pci/20220817230036.817-3-pali@kernel.org/

Mauri Sandberg (2):
  bus: mvebu-mbus: add configuration space aperture
  dt-bindings: PCI: mvebu: Add orion5x compatible

Pali Rohár (5):
  ARM: orion: Move PCIe mbus window mapping from orion5x_setup_wins() to
    pcie_setup()
  PCI: mvebu: Remove unused busn member
  PCI: mvebu: Cleanup error handling in mvebu_pcie_probe()
  PCI: mvebu: Add support for Orion PCIe controller
  ARM: dts: orion5x: Add PCIe node

 .../devicetree/bindings/pci/mvebu-pci.txt     |   4 +-
 arch/arm/boot/dts/orion5x.dtsi                |  51 +++++
 arch/arm/mach-orion5x/common.c                |  13 --
 arch/arm/mach-orion5x/pci.c                   |  14 ++
 drivers/bus/mvebu-mbus.c                      |  26 ++-
 drivers/pci/controller/Kconfig                |   4 +-
 drivers/pci/controller/pci-mvebu.c            | 202 ++++++++++++++----
 include/linux/mbus.h                          |   1 +
 8 files changed, 256 insertions(+), 59 deletions(-)

-- 
2.20.1

