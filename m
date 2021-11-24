Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298E945C8F5
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbhKXPpB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 10:45:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241798AbhKXPo7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 10:44:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B82B76104F;
        Wed, 24 Nov 2021 15:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637768509;
        bh=WJvNY+0Pg9RFMP93Ezkwezkf68NlQN8B55mf/eDaHCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RVmubVOYAgO9TjgiPbl5TGVesxZ2yZUGV3t2pespsxrGDULLKyZIWNu7TP+bSymMg
         82kEugAqyeu9tWw9uWF2SOrKHWbzT8Ajy/NzHQiDvQqqbLHHzADmBFzIdmobFhOgPh
         J/IuY7nbruSuSZTjEjOQJ7orecTTcUi7TXW+Vy474qLNTtXYp6JNqflzE1HjM5cxAg
         kng+3vONiAtKQso5r/bLTk79+eWz6y8TBry8OAY0HBgDVFJpTMHAb/0TCjxM7bIIvN
         qcddQHNOivSpd+Cs9BVZaxD2tdiC4C8Cx5kGZQWQSW/295EUkdvqopjw9Mq0jDbBiG
         +U2jAshfhsbUQ==
Received: by pali.im (Postfix)
        id 773BF56D; Wed, 24 Nov 2021 16:41:49 +0100 (CET)
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
Subject: [PATCH 5/5] arm: ioremap: Remove unused ARM-specific function pci_ioremap_io()
Date:   Wed, 24 Nov 2021 16:41:16 +0100
Message-Id: <20211124154116.916-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124154116.916-1-pali@kernel.org>
References: <20211124154116.916-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This function is not used by any driver anymore. So completely remove it.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/include/asm/io.h |  2 --
 arch/arm/mm/ioremap.c     | 11 -----------
 2 files changed, 13 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 12eca75bdee9..0c70eb688a00 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -180,8 +180,6 @@ void pci_ioremap_set_mem_type(int mem_type);
 static inline void pci_ioremap_set_mem_type(int mem_type) {}
 #endif
 
-extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
-
 struct resource;
 
 #define pci_remap_iospace pci_remap_iospace
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index fa3bde48d6a7..197f8eb3a775 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -474,17 +474,6 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 }
 EXPORT_SYMBOL(pci_remap_iospace);
 
-int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
-{
-	BUG_ON(offset + SZ_64K - 1 > IO_SPACE_LIMIT);
-
-	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
-				  PCI_IO_VIRT_BASE + offset + SZ_64K,
-				  phys_addr,
-				  __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
-}
-EXPORT_SYMBOL_GPL(pci_ioremap_io);
-
 void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size)
 {
 	return arch_ioremap_caller(res_cookie, size, MT_UNCACHED,
-- 
2.20.1

