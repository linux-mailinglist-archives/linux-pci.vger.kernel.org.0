Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEAD43DAA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbfFMPn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:43:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbfFMJob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 05:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FtWCNVd4QOpMTthKbNz1MFUxeFEvCSuwTqmj0Q74N1M=; b=lGnynT1HToRc+NaRbBtuR81QYR
        NemOaLZIDgAQej+KaIa1UxM9jdzyIje1zBDkPe1VX9Ai3Z8hZ/9xJPbgJt4zVuMpEcWMze36SAPe8
        jadfF1tnyC53GvHJN+XmEhIe1jarXKgqt4YOPBypOu+e8vTxzEa3yDupP2NKBlUg2R8XoiT+70txr
        XjVnT4tikVWG9g+QrpVgLj/2IWv0sdZQEPOrc3z1nIk8VZ3R1YxTTaO5R14SWaIYcAO2xKeDnsgkf
        BG35saHwjH85vx0W3/7W5L524Osw05sNZ5JeAjweKs/0jw6m5MZxo8PHbgl0DcrLc6CYCGDX6R30L
        Li0+Fu8g==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMHS-0001wn-Qc; Thu, 13 Jun 2019 09:44:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/22] mm: sort out the DEVICE_PRIVATE Kconfig mess
Date:   Thu, 13 Jun 2019 11:43:23 +0200
Message-Id: <20190613094326.24093-21-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ZONE_DEVICE support doesn't depend on anything HMM related, just on
various bits of arch support as indicated by the architecture.  Also
don't select the option from nouveau as it isn't present in many setups,
and depend on it instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/Kconfig | 2 +-
 mm/Kconfig                      | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index dba2613f7180..6303d203ab1d 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -85,10 +85,10 @@ config DRM_NOUVEAU_BACKLIGHT
 config DRM_NOUVEAU_SVM
 	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
 	depends on ARCH_HAS_HMM
+	depends on DEVICE_PRIVATE
 	depends on DRM_NOUVEAU
 	depends on STAGING
 	select HMM_MIRROR
-	select DEVICE_PRIVATE
 	default n
 	help
 	  Say Y here if you want to enable experimental support for
diff --git a/mm/Kconfig b/mm/Kconfig
index 406fa45e9ecc..4dbd718c8cf4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -677,13 +677,13 @@ config ARCH_HAS_HMM_MIRROR
 
 config ARCH_HAS_HMM
 	bool
-	default y
 	depends on (X86_64 || PPC64)
 	depends on ZONE_DEVICE
 	depends on MMU && 64BIT
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
 	depends on SPARSEMEM_VMEMMAP
+	default y
 
 config MIGRATE_VMA_HELPER
 	bool
@@ -709,8 +709,7 @@ config HMM_MIRROR
 
 config DEVICE_PRIVATE
 	bool "Unaddressable device memory (GPU memory, ...)"
-	depends on ARCH_HAS_HMM
-	select HMM
+	depends on ZONE_DEVICE
 	select DEV_PAGEMAP_OPS
 
 	help
-- 
2.20.1

