Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1B4BFD80
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 16:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiBVPwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 10:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiBVPwC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 10:52:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DEBCAF;
        Tue, 22 Feb 2022 07:51:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1556761683;
        Tue, 22 Feb 2022 15:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5487FC340E8;
        Tue, 22 Feb 2022 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645545095;
        bh=gaqjZzuA6iYakpfZFHoDkymRGtpDurBMJz1FhrTTdGY=;
        h=From:To:Cc:Subject:Date:From;
        b=cnACiK3O0OSwej4ECYhC2yZKvIQo2o7uA7vAcmCnVE+R7s3POQq1f82kyr7JF9tLC
         h57OyV47KZuhW3oNhT/hju83Cd+z64Z7lrPn9OpFfsZ2sY2CRKKpqKc6v1QUj51x+x
         tGUrS4AGLjOGoocZMu7zMlCylclUhfy91PJCzC9l9Zv45e2/HakgpzhZ5CbNe6dTUE
         H34O+9rmA7bMLKHZnFAhcdLextut5JWgK+lQfANY/ULY6yR0itHpnlGGBf9sJZhnqf
         UReJHS2xNvwy2rwIahBrYblmzBO8EISHjnRk6h5qS/09pHDrDBwKE0nJ1Js0yv77pU
         lDnDpYS7JP3HA==
Received: by pali.im (Postfix)
        id CFBFAFDB; Tue, 22 Feb 2022 16:51:32 +0100 (CET)
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
Subject: [PATCH v4 00/12] PCI: mvebu: subsystem ids, AER and INTx
Date:   Tue, 22 Feb 2022 16:50:18 +0100
Message-Id: <20220222155030.988-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

This patch series extends pci-bridge-emul.c driver to emulate PCI Subsystem
Vendor ID capability and PCIe extended capabilities. And then implement
in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCIe AER
registers, support for legacy INTx interrupts, configuration for X1/X4
mode and usage of new PCI child_ops API.

Changes in v4:
* rebased on c3bd7dc553eea5a3595ca3aa0adee9bf83622a1f

Changes in v3:
* add Marek's Reviewed-by for first two patches
* split comments from "PCI: mvebu: Implement support for legacy INTx
  interrupts" patch into separate patch

Changes in v2:
* use static structures for INTx interrupts
* remove INTx domain after unregistering INTx handler

Pali Rohár (10):
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
  PCI: mvebu: Fix macro names and comments about legacy interrupts
  PCI: mvebu: Implement support for legacy INTx interrupts
  ARM: dts: armada-385.dtsi: Add definitions for PCIe legacy INTx
    interrupts

Russell King (2):
  PCI: pci-bridge-emul: Re-arrange register tests
  PCI: pci-bridge-emul: Add support for PCIe extended capabilities

 .../devicetree/bindings/pci/mvebu-pci.txt     |  16 +
 arch/arm/boot/dts/armada-385.dtsi             |  52 ++-
 drivers/pci/controller/pci-mvebu.c            | 350 +++++++++++++++---
 drivers/pci/pci-bridge-emul.c                 | 167 ++++++---
 drivers/pci/pci-bridge-emul.h                 |  17 +
 5 files changed, 493 insertions(+), 109 deletions(-)

-- 
2.20.1

