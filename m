Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76295377FE5
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 11:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhEJJwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 05:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhEJJwC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 05:52:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47142C061761
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 02:50:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lp4so9445240pjb.1
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzceaTJbUUoQMRiby9lwQqwtKo4y5qZbVn1w31ybRrg=;
        b=bOYHl1lk+9c5fpkjvJLlW2V+ZW1HWQZ8+GqQWpRXOyRwXl5gJ0b79YDClCoBfBBm4i
         Lg3ZY42RA3b3XCB5qgKa30diM6DGWie5c/Bp8lBvVatzuKYQ+cRSVyrR3Vn43XQ38Fby
         6vdAkHilxAu/KAE1HFPNhr6sG764ExUW8d2uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzceaTJbUUoQMRiby9lwQqwtKo4y5qZbVn1w31ybRrg=;
        b=CROeC7LkNkL7CKAVtS4MNmPLOSMPahU3iuEoVKJyM2v9gIVJqmhx8DdK+PKw+Du64/
         gnL2UXSFFto85FAGGZHfDNpWZGt9F5myhWO23J6dGxf+km1lBwcOOZguFCaEHhrsN20i
         6chIPxuvy5sYEIvRKpMJAOtxAeQJxCf2UvswWa95dFhjavpYnYDLwmDik773M3kwT5Za
         gV03tyVZVVPACrwxEAMXiIiYuISSXV7aeRI0utWJFklUWJfeOvCkxLa7w7Cf705/dD2P
         VUzCWkQOoIHowV33/NxBX9wlrVCu6jQeD8TAoh1IqSsA3Cv2CTvsmlrgGGZjeUrGIl9r
         qk2w==
X-Gm-Message-State: AOAM533mA0XClVy792MQ+iVePj6q09KxExw3d6V8AWK/Sp5YBgHUuBxD
        Wfv5IuE1RfykrywVge3ACmQvvA==
X-Google-Smtp-Source: ABdhPJxwy0teVP8y0d4KrEbfmPne0jX/g2pgdK0Y1sxb/62SuqcTyQ5c51wqp1akhS8ac/pL7Mr0nw==
X-Received: by 2002:a17:90a:bf0c:: with SMTP id c12mr25754828pjs.206.1620640256876;
        Mon, 10 May 2021 02:50:56 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:a524:abe8:94e3:5601])
        by smtp.gmail.com with UTF8SMTPSA id 14sm10615255pfv.33.2021.05.10.02.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 02:50:56 -0700 (PDT)
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
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Subject: [PATCH v6 02/15] swiotlb: Refactor swiotlb_create_debugfs
Date:   Mon, 10 May 2021 17:50:13 +0800
Message-Id: <20210510095026.3477496-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210510095026.3477496-1-tientzu@chromium.org>
References: <20210510095026.3477496-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split the debugfs creation to make the code reusable for supporting
different bounce buffer pools, e.g. restricted DMA pool.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d3232fc19385..858475bd6923 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -64,6 +64,7 @@
 enum swiotlb_force swiotlb_force;
 
 struct io_tlb_mem *io_tlb_default_mem;
+static struct dentry *debugfs_dir;
 
 /*
  * Max segment that we can provide which (if pages are contingous) will
@@ -662,18 +663,27 @@ EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
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
+	struct io_tlb_mem *mem = io_tlb_default_mem;
+
+	swiotlb_create_debugfs(mem, "swiotlb", NULL);
+	debugfs_dir = mem->debugfs;
+
 	return 0;
 }
 
-late_initcall(swiotlb_create_debugfs);
+late_initcall(swiotlb_create_default_debugfs);
 
 #endif
-- 
2.31.1.607.g51e8a6a459-goog

