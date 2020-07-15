Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A6A220F28
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgGOO0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 10:26:11 -0400
Received: from lists.nic.cz ([217.31.204.67]:34952 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgGOO0C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 10:26:02 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 0AD0113FC1A;
        Wed, 15 Jul 2020 16:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594823158; bh=Dmmq7c83omCyHjmVGSlaEZEbm4AR1uYjTQdEkSn1A6Y=;
        h=From:To:Date;
        b=EyDL/AxzXK8CilzzMj58XhdopH7oDBuHAZIp+gObouVHtWUad46wexw9nG/syQG6t
         RKFv+WwGHuRMjfaU0x4QAnNzQbHo0IuV3qFOaXPG4ltt9UvJnnovOgMG3wtr5U1yvs
         rDX0c2S3hUooXtf5RfhPqTZ5/rAEd7YzzXKOLhjE=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 0/5] PCIe aardvark controller improvements
Date:   Wed, 15 Jul 2020 16:25:52 +0200
Message-Id: <20200715142557.17115-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

we have some more improvements for PCIe aardvark controller (Armada 3720
SOC - EspressoBIN and Turris MOX).

The main improvement is that with these patches the driver can be compiled
as a module, and can be reloaded at runtime.

This series applies on top of Linus' master branch.

Marek & Pali

Pali Rohár (5):
  PCI: aardvark: Fix compilation on s390
  PCI: aardvark: Check for errors from pci_bridge_emul_init() call
  PCI: pci-bridge-emul: Export API functions
  PCI: aardvark: Implement driver 'remove' function and allow to build
    it as module
  PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()

 drivers/pci/controller/Kconfig        |   2 +-
 drivers/pci/controller/pci-aardvark.c | 102 ++++++++++++++++----------
 drivers/pci/pci-bridge-emul.c         |   4 +
 3 files changed, 69 insertions(+), 39 deletions(-)

-- 
2.26.2

