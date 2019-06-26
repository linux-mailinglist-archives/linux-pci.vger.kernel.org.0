Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635EE56915
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfFZM2i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:28:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfFZM2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 08:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZjBYUWyGZeQFbLdeL3I3vLQlcbJ5I4BbNFzVpFyfAyY=; b=KN1fXz1VRCySW0ycRrfAX1GqWC
        nBzrlUj6EH8tEn5EKRnrhZ/clBQwfvfHZco8c9jjozD1fh/my91ln6undw3f0URs/bl+BIWm9b6hu
        GRC9l8p7WXmZ8Xxi9iA+E0W9Gm1MASDaRp1hsctZvyH++evwZDdjgMK5FluTFNT1RwdwEeDzbsvSM
        2Vaw9si/vPSSHdp8MpGf4yt7KV6VBBfa72BTk2t+4oMw4Ihq6663f/SIsQz3QotN454E3JNgKTXLf
        k83PbIqllqoxK5hwQg9uLoykDjdc5EnRrvh/P54vz5TNn3UfdvW/VR54c5mGcZIc55bXkoE7hGw3x
        iOkrcrng==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg72P-0001gm-Ia; Wed, 26 Jun 2019 12:28:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] mm: don't select MIGRATE_VMA_HELPER from HMM_MIRROR
Date:   Wed, 26 Jun 2019 14:27:24 +0200
Message-Id: <20190626122724.13313-26-hch@lst.de>
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

The migrate_vma helper is only used by noveau to migrate device private
pages around.  Other HMM_MIRROR users like amdgpu or infiniband don't
need it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/nouveau/Kconfig | 1 +
 mm/Kconfig                      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 66c839d8e9d1..96b9814e6d06 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -88,6 +88,7 @@ config DRM_NOUVEAU_SVM
 	depends on DRM_NOUVEAU
 	depends on HMM_MIRROR
 	depends on STAGING
+	select MIGRATE_VMA_HELPER
 	default n
 	help
 	  Say Y here if you want to enable experimental support for
diff --git a/mm/Kconfig b/mm/Kconfig
index 1e426c26b1d6..40cf0562412d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -680,7 +680,6 @@ config HMM_MIRROR
 	depends on (X86_64 || PPC64)
 	depends on MMU && 64BIT
 	select MMU_NOTIFIER
-	select MIGRATE_VMA_HELPER
 	help
 	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
 	  process into a device page table. Here, mirror means "keep synchronized".
-- 
2.20.1

