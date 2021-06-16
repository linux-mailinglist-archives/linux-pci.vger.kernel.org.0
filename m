Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A195C3A91DB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 08:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhFPGYc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 02:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhFPGYc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 02:24:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E80C06175F
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 23:22:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x10so594770plg.3
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 23:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U6ZYMbmpZtiKwFDcQ7JFrtewUpbfgXD5Ls9ZoD2Zrzg=;
        b=PJvHRcLLv4fhlWeXvSfKMQcWBxKOg+Fvvldtj3Y2Rwy0NG+fV8esg1TcKHxfLuji8x
         fALYR4BBGda9gTcNxGVF5jiXo1hdqXLQ9/EojERkZznhsp+lq9qt4VGs9UqStorOUfPe
         QcYH5iC4/YfxuhCJrGU8L8Q0LpoEXtWiU0umg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6ZYMbmpZtiKwFDcQ7JFrtewUpbfgXD5Ls9ZoD2Zrzg=;
        b=pfZ9jdwhPjYLK/95zaKCnJfJz1TmA8+bRIAN6+4XbFeEvQpEbMBRgokjAsnMw3KB6T
         bu2jCnEReq3rRmwnmEZW7sTT/vK/Mcw++sCF///8lcWp9uM118h66UV7IT9kn/1t5f/t
         ryyF2Ff/emvqus+g/CWmgum5wNgTksYhhUxFQ0uiHzaLtV0fNnQxawTeV4K/6DQWt/nc
         xdlhOfqrrWGThRa5n0Ve0JNf0os4zc325YV5dexgHJyG+tUtPqeztpUD9MYqmSDfW8BI
         3qnKX+Zn4yEKfQb1bNvJeP5BTm+0iGuQpyi0ydR+/81WCDROg/LygvmmSxsVgMMVJEkq
         v5jA==
X-Gm-Message-State: AOAM530micZ0Do1YIjQi51biDMJzProhT+vAusVFn4S0nZolie4w0zuQ
        LMDK401ulA0DenA+sHkjDjZOBw==
X-Google-Smtp-Source: ABdhPJyVyel5b3yfzmvkqrYXS5Eq1yNF15/6agY067MF9HfP0+RZa2tjHWPks9M0csBX136+z0kj6g==
X-Received: by 2002:a17:902:860b:b029:103:b23b:f1c3 with SMTP id f11-20020a170902860bb0290103b23bf1c3mr7842702plo.34.1623824546376;
        Tue, 15 Jun 2021 23:22:26 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:3d52:f252:7393:1992])
        by smtp.gmail.com with UTF8SMTPSA id 21sm1024194pfy.92.2021.06.15.23.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 23:22:26 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v12 02/12] swiotlb: Refactor swiotlb_create_debugfs
Date:   Wed, 16 Jun 2021 14:21:47 +0800
Message-Id: <20210616062157.953777-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616062157.953777-1-tientzu@chromium.org>
References: <20210616062157.953777-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split the debugfs creation to make the code reusable for supporting
different bounce buffer pools.

Signed-off-by: Claire Chang <tientzu@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 3ba0f08a39a1..af416bcd1914 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -670,19 +670,26 @@ bool is_swiotlb_active(void)
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
 #ifdef CONFIG_DEBUG_FS
+static struct dentry *debugfs_dir;
 
-static int __init swiotlb_create_debugfs(void)
+static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
-
-	if (!mem)
-		return 0;
-	mem->debugfs = debugfs_create_dir("swiotlb", NULL);
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
+}
+
+static int __init swiotlb_create_default_debugfs(void)
+{
+	struct io_tlb_mem *mem = io_tlb_default_mem;
+
+	debugfs_dir = debugfs_create_dir("swiotlb", NULL);
+	if (mem) {
+		mem->debugfs = debugfs_dir;
+		swiotlb_create_debugfs_files(mem);
+	}
 	return 0;
 }
 
-late_initcall(swiotlb_create_debugfs);
+late_initcall(swiotlb_create_default_debugfs);
 
 #endif
-- 
2.32.0.272.g935e593368-goog

