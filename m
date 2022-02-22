Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC51C4BF668
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 11:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiBVKrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 05:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiBVKrL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 05:47:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67594A8EEF;
        Tue, 22 Feb 2022 02:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04BFB61604;
        Tue, 22 Feb 2022 10:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3726AC340E8;
        Tue, 22 Feb 2022 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645526805;
        bh=6HCy67i32Aa1PmtKy+in+Ktr5yO8lY2us1tc8/Y5o6A=;
        h=From:To:Cc:Subject:Date:From;
        b=iRa3duzz37M6i6gMqISsG9Y1Zziccn0+sM8yfyE4Q2vuAp+szKAq2G9ySTm7WBqvc
         gb3JWk6fnfU9s1ZxoNphHRIwad0CJXsJJQ7Bw0HcG2vBH3p5UpRm4vq76xJJa2h6LM
         dNzL0Rs5GT96MtkDFU0lrIHArnjO9HmMELPRxhakaRspsu+RqGA8Fa7evTYbKQt81a
         C2XNRzyfzxjQ2weBAGV+aMBKEO2NA5t/cu4Wu6hKi98oOWlAz7YuUBkOnxu70bVHz4
         DWCXiIF4bQ5cicgT5TlPMFkasa+HRD3Qg6aPzy/AcLBwAg4Xtf0xmozftFEJC3nrbi
         t2TrrcYAUBvVA==
Received: by pali.im (Postfix)
        id 5C4B0FDB; Tue, 22 Feb 2022 11:46:42 +0100 (CET)
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
Subject: [PATCH v3 00/12] PCI: mvebu: subsystem ids, AER and INTx
Date:   Tue, 22 Feb 2022 11:46:13 +0100
Message-Id: <20220222104625.28461-1-pali@kernel.org>
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
 drivers/pci/controller/pci-mvebu.c            | 355 +++++++++++++++---
 drivers/pci/pci-bridge-emul.c                 | 167 +++++---
 drivers/pci/pci-bridge-emul.h                 |  17 +
 5 files changed, 497 insertions(+), 110 deletions(-)

-- 
2.20.1

