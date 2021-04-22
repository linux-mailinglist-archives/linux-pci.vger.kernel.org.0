Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B15367C20
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhDVIQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 04:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbhDVIQS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Apr 2021 04:16:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF29AC06138C
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 01:15:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i190so31127713pfc.12
        for <linux-pci@vger.kernel.org>; Thu, 22 Apr 2021 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3ItV5y5XoEhSqi+d51HdmwBWLH2Hb4UsI3M8OVWu24=;
        b=Cisfd6jfRp7ZntllQG9J21QpT0tbDCUmO7Sd4z/S5YfmrCvvZiaBUR0BPZFuQ5hvd/
         gxJhZ2pu34BRLPXqvLavDRaBXVqLQLA1W1/STuSvpHuqa+BPpv9DUpeEZVvPd4m/EZM3
         aXG1VDvl65ykf2+uaD2EnhVf7WefQlXtPpuHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3ItV5y5XoEhSqi+d51HdmwBWLH2Hb4UsI3M8OVWu24=;
        b=nnQDY1xoXQnrYR/EssEnYXvQzOQwEd6gVDUJkGQB/Fus3wIWzhBVgIg4EtKF+TCGZ7
         h+p/NFyl/fuzrCnnT9D0LsH63xi9ptOaKlO2NHVmIAHNuizhid4FrY1eC1nJ2goQnahv
         +/DKmbOmGCUZA3C72yi0w6EbPAGGY7DdODcD/CLbwlz50xmfv8zC7mQ00WViTuJy0NQb
         76Asf2yo8pBLpNhDAyXTWBN9pYCNRS0czOyTV+Y1a9eAk/8Z8rhCb+TRvILNITo6m4Ls
         4Lz/YkifgnmgJIsohgCHvLjsJqWygFyrEVr+5pyFqWAsIRzc0N6as1/AytSjCsmtGC7F
         M7Nw==
X-Gm-Message-State: AOAM532nXIkn74/fKRh7JWPhZevLisB/Lff6MM+qnO+70Zef/WuqtTxc
        7BmfOjg9pRJAnHI6XPIVvJ0t8A==
X-Google-Smtp-Source: ABdhPJxkEqOgBe8WdlOJ16Imv3NTakOO84xcsb4CT6RBz2bwANEVo+9MWgQ4ffM3wlaap5K1DgM+6A==
X-Received: by 2002:a63:4106:: with SMTP id o6mr2436897pga.104.1619079344334;
        Thu, 22 Apr 2021 01:15:44 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:1a8e:1bde:f79e:c302])
        by smtp.gmail.com with UTF8SMTPSA id n48sm1357349pfv.130.2021.04.22.01.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:15:43 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Subject: [PATCH v5 03/16] swiotlb: Refactor swiotlb_create_debugfs
Date:   Thu, 22 Apr 2021 16:14:55 +0800
Message-Id: <20210422081508.3942748-4-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210422081508.3942748-1-tientzu@chromium.org>
References: <20210422081508.3942748-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split the debugfs creation to make the code reusable for supporting
different bounce buffer pools, e.g. restricted DMA pool.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 3f1adee35097..57a9adb920bf 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -660,18 +660,24 @@ EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
 #ifdef CONFIG_DEBUG_FS
 
-static int __init swiotlb_create_debugfs(void)
+static void swiotlb_create_debugfs(struct io_tlb_mem *mem, const char *name,
+				   struct dentry *node)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
-
 	if (!mem)
-		return 0;
-	mem->debugfs = debugfs_create_dir("swiotlb", NULL);
+		return;
+
+	mem->debugfs = debugfs_create_dir(name, node);
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
+}
+
+static int __init swiotlb_create_default_debugfs(void)
+{
+	swiotlb_create_debugfs(io_tlb_default_mem, "swiotlb", NULL);
+
 	return 0;
 }
 
-late_initcall(swiotlb_create_debugfs);
+late_initcall(swiotlb_create_default_debugfs);
 
 #endif
-- 
2.31.1.368.gbe11c130af-goog

