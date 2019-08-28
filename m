Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A2A0470
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfH1OO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 10:14:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1OOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 10:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6ZfA2t0V1DsXTcYJTI/PW4o+4h9V1E2c8O8ixWWPKp4=; b=ZMIM2nWGQT7ao/o3bSPXDNhdXd
        CCsYN6Sn11RqqUTEuIuAy+lZ9tJp7rrJbndUY1/HGuZyUUamoeTz6aHyT4BIT2n91cEedwlEhs1Zn
        8OqW5mwR2iwa6CM68DzwYsRYjEOjlRRyl8Zh8yhTrdJmug+Jiq9tYqb6uQWhNc5+3ZlbfhLsdCxht
        wGNvpYpUyWBSuhJoNvU5ONwHZOg36J7PIJbG0ziTH+4FJ4hUJdNsftcGWAREfKcBjbvy4xnluyh3n
        HR14xELs8owXLAkCzYe/HvdaoVal7fi9WJu+Mx5wuyrBVkcDorVPqMYsttNJckrJvKosnRZidfoU4
        DWwe3E0w==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2yim-0000T7-Ay; Wed, 28 Aug 2019 14:14:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     x86@kernel.org, joro@8bytes.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] x86/pci: Remove an ifdef __KERNEL__ from pci.h
Date:   Wed, 28 Aug 2019 16:14:39 +0200
Message-Id: <20190828141443.5253-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828141443.5253-1-hch@lst.de>
References: <20190828141443.5253-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Non-UAPI headers can't be included by userspace, so remove the
pointless ifdef.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pci.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index e662f987dfa2..6fa846920f5f 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -12,8 +12,6 @@
 #include <asm/pat.h>
 #include <asm/x86_init.h>
 
-#ifdef __KERNEL__
-
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
@@ -118,7 +116,6 @@ void native_restore_msi_irqs(struct pci_dev *dev);
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
 #endif
-#endif  /* __KERNEL__ */
 
 #ifdef CONFIG_X86_64
 #include <asm/pci_64.h>
-- 
2.20.1

