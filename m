Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2B33AABE3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 08:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhFQG3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 02:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhFQG3L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jun 2021 02:29:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF84C061760
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 23:27:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v13so2372089ple.9
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 23:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KErEGZ0FKTYEit+r+b5b30lp04bWxqVkd7eLPHLFOPc=;
        b=fWSZPQqtkEFc0v1lsfv1E5zaTAKfy+POYliVtKgvQfSwPyhV1IIZne42xoVDVcWoKr
         GePyvrrQbPaghpGzJim6vL3T/YbInWmx2tOKWDB+LuhBVuMSYPGVTD5OuyMs4PtPNYYl
         8ImV7jol1DIg81iCYe8vTZsXuU1yA24ivydu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KErEGZ0FKTYEit+r+b5b30lp04bWxqVkd7eLPHLFOPc=;
        b=hCRO0ThHkJysEBE9TDzCkGmoSk0/OkuUp7E57X6cSqtwm3tN0TEpo7gDIxrPuee3FS
         OABRNWFmAqsdxhrM0P+S9iimdY4GZgGXrxdfV6R6jtJJRpfy2IQru7xEkXtZARba/S6q
         GXpwYC+7/qtoUoi13WVQ593rj0v1LmFpxKGAg2/XuSxw3xy/DLWJHoP02fGZmY72cLh9
         90OxVAWN7KBM3QxXEEdm78z3vh7ICdYdMspP0yv9EloNc6BxjanwXIezGtCK2OW3OPu/
         JEs7GaaAgM7aUy7WZ1azbKkOcWp1ZiFYwHoGcopEaf9BqDHwPwdZC4rOthPLNMV/9xM4
         hmEw==
X-Gm-Message-State: AOAM532ZVRasMBkM+y5xRLDCXjKFB1jxtH8DtqpDuuENIWPhANrm4ZkS
        3jHcQ2mCtqePknAH/YVUUEOAHg==
X-Google-Smtp-Source: ABdhPJwO+NycHbE4HtdqaCFDvde6JNjarbiAoIdD19GqTdP0e6NuKJYjpDc9SPpkCJD5g3bxI6kSOA==
X-Received: by 2002:a17:902:9004:b029:f0:b40d:38d with SMTP id a4-20020a1709029004b02900f0b40d038dmr3065888plp.85.1623911223159;
        Wed, 16 Jun 2021 23:27:03 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:e349:a6ae:d3d0:1621])
        by smtp.gmail.com with UTF8SMTPSA id o16sm553563pjq.34.2021.06.16.23.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 23:27:02 -0700 (PDT)
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
Subject: [PATCH v13 02/12] swiotlb: Refactor swiotlb_create_debugfs
Date:   Thu, 17 Jun 2021 14:26:25 +0800
Message-Id: <20210617062635.1660944-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210617062635.1660944-1-tientzu@chromium.org>
References: <20210617062635.1660944-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split the debugfs creation to make the code reusable for supporting
different bounce buffer pools.

Signed-off-by: Claire Chang <tientzu@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Stefano Stabellini <sstabellini@kernel.org>
Tested-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 47bb2a766798..2dba659a1e73 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -671,19 +671,26 @@ bool is_swiotlb_active(void)
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
2.32.0.288.g62a8d224e6-goog

