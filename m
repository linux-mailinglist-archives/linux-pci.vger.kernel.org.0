Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0090C45C8F4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbhKXPpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 10:45:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344394AbhKXPo4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 10:44:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59E5360FDA;
        Wed, 24 Nov 2021 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637768506;
        bh=bGzR9xx4PGIc06Ok2806l3n4SBlt+u6vIdSZQi5wHHg=;
        h=From:To:Cc:Subject:Date:From;
        b=XW3kkFy0n6jvhaxKQWSTaXggyIMEs3ZzQCDVT0L8tP3TTQM+Ua1xw3IBkiOlUc+aT
         7V4a1tpp0IUOA9t54EKzmTMwbh2TFdQ2bORzw/HTqAClXbH6cTBTJpWfcz+vR4dOYi
         YolMeP6GVeUR/g5OuCKd8ydziNCON5AIBsCiQOrgtmPNFHDzVpvyn7U1bq23SSmmac
         1q07JzG6gG2P6Fifplmt+XOoVwkBCqD6GfQJJpJBZ7i9sPHU6vdKyPGuUr6fANspgU
         8SFJZy+GgcHZmJztFie0WpwBeS2w6iXwRsupdanSm4Vy0vGumaCgl85ykPfApQ1PrI
         yMsfXeGLK0RoA==
Received: by pali.im (Postfix)
        id D8D4056D; Wed, 24 Nov 2021 16:41:43 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm: ioremap: Remove pci_ioremap_io() and mvebu_pci_host_probe()
Date:   Wed, 24 Nov 2021 16:41:11 +0100
Message-Id: <20211124154116.916-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series removes ARM specific functions pci_ioremap_io() and
mvebu_pci_host_probe() functions.

pci_ioremap_io() is replaced by standard PCI core function pci_remap_iospace()
and mvebu_pci_host_probe() by standard PCI core function pci_host_probe().

ARM needs custom implementation of pci_remap_iospace() because of
pci_ioremap_set_mem_type() hook used by Marvell Armada 375, 38x and 39x
platforms due to HW errata.

Patch series was compile-tested for all affected platforms and runtime
tested on Armada 385 with pci-mvebu.c driver.

Pali Rohár (5):
  arm: ioremap: Implement standard PCI function pci_remap_iospace()
  PCI: mvebu: Replace pci_ioremap_io() usage by devm_pci_remap_iospace()
  PCI: mvebu: Remove custom mvebu_pci_host_probe() function
  arm: ioremap: Replace pci_ioremap_io() usage by pci_remap_iospace()
  arm: ioremap: Remove unused ARM-specific function pci_ioremap_io()

 arch/arm/include/asm/io.h          |  5 ++-
 arch/arm/mach-dove/pcie.c          |  9 ++---
 arch/arm/mach-iop32x/pci.c         |  5 ++-
 arch/arm/mach-mv78xx0/pcie.c       |  5 ++-
 arch/arm/mach-orion5x/pci.c        | 10 ++++--
 arch/arm/mm/ioremap.c              | 16 +++++----
 drivers/pci/controller/pci-mvebu.c | 54 +++---------------------------
 drivers/pcmcia/at91_cf.c           |  6 +++-
 8 files changed, 45 insertions(+), 65 deletions(-)

-- 
2.20.1

