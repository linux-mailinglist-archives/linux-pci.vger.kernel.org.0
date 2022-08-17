Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A694E5979E6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 01:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbiHQXDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 19:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHQXDi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 19:03:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E48A50F6;
        Wed, 17 Aug 2022 16:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93C10B81FBD;
        Wed, 17 Aug 2022 23:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F84CC433D6;
        Wed, 17 Aug 2022 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660777414;
        bh=1MR315QnADwsilPIFFMT06JsmqGYa2wV+d693CoceVc=;
        h=From:To:Cc:Subject:Date:From;
        b=S5V4hGf981y0IeA4JPZAHR2kr6hDH38wWliHwNqfI2dfWphyATDz5Qk/MZFirD7BX
         nSItPRpmr/FpVPFdAwaIi17YuCagg7a6tuqcuS4Zn1brmsBRUzw4LeiaoFw8n8yVRu
         iwF3PW7JvO+bXDpmburJ981bqJQ0U/RirF28o6jM7QvF0xIBEY3LmgLCmbOjIR0nBp
         xsHlU3UvOd7QTvazuqhCxvqDlJBoKUw8nKoiJE253QeHrpu+omMAXbvLbXrmziqvXx
         6jT0p3R0QQDJomvO0jCcrvdWiKk4KEUbEzziplFe03WpX/mwQVawpYj3qHuuIboPXy
         Pd4ZOodfM1LJw==
Received: by pali.im (Postfix)
        id 58E9277A; Thu, 18 Aug 2022 01:03:31 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] PCI: mvebu: Add support for error interrupt
Date:   Thu, 18 Aug 2022 01:00:32 +0200
Message-Id: <20220817230036.817-1-pali@kernel.org>
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

PCI mvebu error interrupt source is triggered for non-INTx event.
So e.g. when AER or PME event occurs.

This patch series adds support for reporting AER and PME interrupts on
Marvell PCIe Root Ports which allows use to kernel AER and PME drivers.

Without this change kernel AER and PME drivers do not work at all.

DT bindings for this support is currently provided only for Kirkwood and
Dove platforms as other new mvebu SoCs requires extension to armada IRQ
driver, which is currently disallowed.

Without new DTS files, pci-mvebu.c driver acts as before this change,
there is no AER and PME kernel support.

I have tested this change on Armada 385 board (with additional changes
to A385 DTS files and IRQ driver, not included there) and AER interrupt
is delivered to kernel AER driver correctly.

Pali Rohár (4):
  dt-bindings: PCI: mvebu: Update information about error interrupt
  PCI: mvebu: Implement support for interrupts on emulated bridge
  ARM: dts: kirkwood: Add definitions for PCIe error interrupts
  ARM: dts: dove: Add definitions for PCIe error interrupts

 .../devicetree/bindings/pci/mvebu-pci.txt     |   1 +
 arch/arm/boot/dts/dove.dtsi                   |   8 +-
 arch/arm/boot/dts/kirkwood-6192.dtsi          |   4 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi          |   4 +-
 arch/arm/boot/dts/kirkwood-6282.dtsi          |   8 +-
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi      |   4 +-
 drivers/pci/controller/pci-mvebu.c            | 256 ++++++++++++++++--
 7 files changed, 252 insertions(+), 33 deletions(-)

-- 
2.20.1

