Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE4D45C8FD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbhKXPpI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 10:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344439AbhKXPo4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 10:44:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6EDF60FD9;
        Wed, 24 Nov 2021 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637768506;
        bh=dWjAjYTv1UJNuz4DlD4z4Q3QWuFZ2bz6r9JNBl8Oe8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJEc/g9s3M1t31hg6BTMpM9Qih98I29UPN+TCro87IWeQRjQHPkQatmiMwEk52okt
         QzBxwgD2jpwaDrH1I31gmMkKhRVi0dOO8aXbWFCxLPcTto9Q7LyOxj/lqJwNbtEdLp
         m/ftjBpEWPyXbwKv3u3OA25epyy/ULuTzgTRy22NlNKLh+LCAuh+LRb85llZWy72Pe
         u2pWSfGw5PBM6wzyuXXj1A5uLR9nzezKBIgYuhvRKyYntur0abMORJFaOnHRv3iluy
         uCfcUDi2KBKNLim/6zQ4OMxCS43jo0BUH+m+PPRBOMX5cGrkFO08Scp1TGo5lK5lKv
         H2Ha90ndMggEw==
Received: by pali.im (Postfix)
        id EB6E5AFB; Wed, 24 Nov 2021 16:41:44 +0100 (CET)
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
Subject: [PATCH 1/5] arm: ioremap: Implement standard PCI function pci_remap_iospace()
Date:   Wed, 24 Nov 2021 16:41:12 +0100
Message-Id: <20211124154116.916-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124154116.916-1-pali@kernel.org>
References: <20211124154116.916-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_remap_iospace() is standard PCI core function. Architecture code can
reimplement default core implementation if needs custom arch specific
functionality.

ARM needs custom implementation due to pci_ioremap_set_mem_type() hook
which allows ARM platforms to change mem type for iospace.

Implement this pci_remap_iospace() function for ARM architecture to
correctly handle pci_ioremap_set_mem_type() hook, which allows usage of
this standard PCI core function also for platforms which needs different
mem type (e.g. Marvell Armada 375, 38x and 39x).

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/include/asm/io.h |  5 +++++
 arch/arm/mm/ioremap.c     | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index c576fa7d9bf8..12eca75bdee9 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -182,6 +182,11 @@ static inline void pci_ioremap_set_mem_type(int mem_type) {}
 
 extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
 
+struct resource;
+
+#define pci_remap_iospace pci_remap_iospace
+int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
+
 /*
  * PCI configuration space mapping function.
  *
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 6e830b9418c9..fa3bde48d6a7 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -459,6 +459,21 @@ void pci_ioremap_set_mem_type(int mem_type)
 	pci_ioremap_mem_type = mem_type;
 }
 
+int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
+{
+	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
+
+	if (!(res->flags & IORESOURCE_IO))
+		return -EINVAL;
+
+	if (res->end > IO_SPACE_LIMIT)
+		return -EINVAL;
+
+	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
+				  __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
+}
+EXPORT_SYMBOL(pci_remap_iospace);
+
 int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 {
 	BUG_ON(offset + SZ_64K - 1 > IO_SPACE_LIMIT);
-- 
2.20.1

