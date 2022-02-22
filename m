Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84344BFEA7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiBVQdC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiBVQcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:32:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1C6E8E7;
        Tue, 22 Feb 2022 08:32:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EEB6ACE1767;
        Tue, 22 Feb 2022 16:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCF7C340E8;
        Tue, 22 Feb 2022 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547536;
        bh=deQThiFosCfgbDDY9+kUsiyxUvwfdDyovhHUVd2d6Es=;
        h=From:To:Cc:Subject:Date:From;
        b=owqOXQsmE+DCQm/rkbWl89cTxGH6CkxC7SDpWtLvOdiSFd+pmRreHeb++Q27fRxJ5
         8TVokOpf4FHh+KrCnrm5atIUkG83YW0TD0KbvxnBFB6AHGcgkwsU6rH1V2TIj23ufS
         NBKNtGpynCuuzWK1a7cA37qcDr4HhFhkNqI8K2P4WmcIHIivFWBaKNe3qMzyIOf8xX
         c7El312WoZotOkpJ4DcqkMYf+j3dDS+mCgIh2pFWgthQkGXTM3LVF8VpvKPGZLaHsx
         +wH2uHfLmWr20lUPKhEJTNh3fYtiqM1oCId9QpRPMFENHdPYDGtFNPqlm47qiT6BNd
         e9L/xRe4Nkp5Q==
Received: by pali.im (Postfix)
        id E2C85FDB; Tue, 22 Feb 2022 17:32:13 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] PCI: mvebu: Slot support
Date:   Tue, 22 Feb 2022 17:31:52 +0100
Message-Id: <20220222163158.1666-1-pali@kernel.org>
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

This patch series add slot support to pci-mvebu.c driver.

It is based on branch pci/mvebu of git repository:
https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git

Some patches were reviewed in other patch series.

Pali Rohár (6):
  PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
  PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
  dt-bindings: Add 'slot-power-limit-milliwatt' PCIe port property
  PCI: Add function for parsing 'slot-power-limit-milliwatt' DT property
  PCI: mvebu: Add support for sending Set_Slot_Power_Limit message
  ARM: dts: turris-omnia: Set PCIe slot-power-limit-milliwatt properties

 Documentation/devicetree/bindings/pci/pci.txt |  6 ++
 arch/arm/boot/dts/armada-385-turris-omnia.dts |  3 +
 drivers/pci/controller/pci-mvebu.c            | 85 +++++++++++++++++--
 drivers/pci/of.c                              | 64 ++++++++++++++
 drivers/pci/pci.h                             | 15 ++++
 include/uapi/linux/pci_regs.h                 |  4 +
 6 files changed, 172 insertions(+), 5 deletions(-)

-- 
2.20.1

