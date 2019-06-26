Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A375691A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfFZM2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:28:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfFZM2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 08:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q7MnaJX/iVm/t0Em26EnUyAunznzqEObFDwyR3G5AJk=; b=Tbo19KxPBD9CoStAag7hFRkhL1
        UVbFR8/CEYnn6vco/RRdP7PkksW7LjaWOT2ywOSCt9dpWa1RFcZy8LipzSnYlREvTu9l5/oK26ATg
        Nk0WFaww+s7avBAde8Jm8KV50DOvVQEgDhHB6A8NSXWHXbsvgvkGAlYyeSqX2vJCoK3eLU9ouWC1p
        iel5ayxHoDx57ghhSjAUcaejPQLgxHwBJURlO9R2A5MY23VdntE10dntwJYao10el5aD5sXkfAOSY
        FOQs8Fuhnmthsq51h7FNDZAyBxsUOGDEFV0k50lYyd/nwnlHH9m9h+Q6hRj6OU7uwuOEV50gFx+DI
        HsH+LMPw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg72K-0001eP-1U; Wed, 26 Jun 2019 12:28:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/25] mm: sort out the DEVICE_PRIVATE Kconfig mess
Date:   Wed, 26 Jun 2019 14:27:22 +0200
Message-Id: <20190626122724.13313-24-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626122724.13313-1-hch@lst.de>
References: <20190626122724.13313-1-hch@lst.de>
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
index 6f35b85b3052..eecf037a54b3 100644
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

