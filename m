Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2C422FB2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhJESL4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhJESL4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3F7A613E6;
        Tue,  5 Oct 2021 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457405;
        bh=9tzIM5W/TqDJWnSr+/QPnOVaLHNcjqauWSuOivUBFxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upUGolMze8OH/+1nfmg4nNPgRziLUygcPlv54N/fOdA0RBTqjOBpWivyRKQ+UdZyW
         1Z9kZEFSuKAZiWuJ7fvsWMcgTElbVyUsiJ6zYJ9GBwS0DPzOGyc4Fs9WtNrTtBWfNq
         jHbAqJs3F6cqJlCEhlaaSCbOF0YhrHW90R4kb5nJCAbBp7JtCA8mRKs+wrM8E+lus2
         CTFpHdwNx7XVWj159XjN4P0r9bddVVr62TgbN8efAOkxzI2LSm7MQGq6Oz+aaLDKlP
         RrFVXVyl7lKxiIoaHsYmdKg2Ai8MRT3Pi09RybcTQrdz7l/PPcVbBbami4C4x0SYZ/
         uJQWdWcRErouQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 07/13] PCI: aardvark: Do not unmask unused interrupts
Date:   Tue,  5 Oct 2021 20:09:46 +0200
Message-Id: <20211005180952.6812-8-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

There are lot of undocumented interrupt bits. Fix all *_ALL_MASK macros to
define all interrupt bits, so that driver can properly mask all interrupts,
including those which are undocumented.

Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index f7eebf453e83..3448a8c446d4 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -107,13 +107,13 @@
 #define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
 #define     PCIE_ISR0_INTX_ASSERT(val)		BIT(16 + (val))
 #define     PCIE_ISR0_INTX_DEASSERT(val)	BIT(20 + (val))
-#define	    PCIE_ISR0_ALL_MASK			GENMASK(26, 0)
+#define     PCIE_ISR0_ALL_MASK			GENMASK(31, 0)
 #define PCIE_ISR1_REG				(CONTROL_BASE_ADDR + 0x48)
 #define PCIE_ISR1_MASK_REG			(CONTROL_BASE_ADDR + 0x4C)
 #define     PCIE_ISR1_POWER_STATE_CHANGE	BIT(4)
 #define     PCIE_ISR1_FLUSH			BIT(5)
 #define     PCIE_ISR1_INTX_ASSERT(val)		BIT(8 + (val))
-#define     PCIE_ISR1_ALL_MASK			GENMASK(11, 4)
+#define     PCIE_ISR1_ALL_MASK			GENMASK(31, 0)
 #define PCIE_MSI_ADDR_LOW_REG			(CONTROL_BASE_ADDR + 0x50)
 #define PCIE_MSI_ADDR_HIGH_REG			(CONTROL_BASE_ADDR + 0x54)
 #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
@@ -199,7 +199,7 @@
 #define     PCIE_IRQ_MSI_INT2_DET		BIT(21)
 #define     PCIE_IRQ_RC_DBELL_DET		BIT(22)
 #define     PCIE_IRQ_EP_STATUS			BIT(23)
-#define     PCIE_IRQ_ALL_MASK			0xfff0fb
+#define     PCIE_IRQ_ALL_MASK			GENMASK(31, 0)
 #define     PCIE_IRQ_ENABLE_INTS_MASK		PCIE_IRQ_CORE_INT
 
 /* Transaction types */
-- 
2.32.0

