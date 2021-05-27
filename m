Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840F3392E9B
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhE0NBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbhE0NBN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 09:01:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5B3C061574
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 05:59:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so2296401pjb.2
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n2YnMeaa21fO8GV3DprpFoE7sFhCpYEOshpAHonnB4Q=;
        b=CWN//86M7pfZwpqjk6Pz1G7HqyEoQV2evBjGZ2yUSjg4QlRX/avwG27ptvNDpwyHCw
         +v7KXNRKRgPheqlBZeQIo496WAVDVK7ga9R6f5STmR5c/U2eiCxGBrlIMJe+YfycLoea
         t6vNAhsA0F2FaNz1gwrhV3oLti0cIUc2nP7Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2YnMeaa21fO8GV3DprpFoE7sFhCpYEOshpAHonnB4Q=;
        b=ACMqtFqftktwCDpuaJ6I28lyqVhsyKD/auVm1gL9bT52F5PJgFc4shsiFLhddR/VKU
         VZuTupbE652am6u0ZLd+3eGJiWrl+GN8G0zVhYM1NDTKf7uzziuf0UOJZw3+Rahhaz7w
         cB+nkHAW+bUgO4PakxQuKv7cU4+Nlt3qrsGtTXhkjKwD+9ZmoI5WvrMPN260CspQFzN0
         /A5XGiBqqRrroFDDuntMEwIGAqkWkHTnyu+aAIVhE3OY30tVJW3CIGxDCdlql1sd++xu
         CLA2IsgXD2XlLcZJDlClcOxHJk+6dMaOH2TK3W52qDzvUpmJc0nm3z7Sm8GfU5lB3m+z
         3SKw==
X-Gm-Message-State: AOAM5320WUjsTGia4irXYBacsjcxcRHghbajOyNEG8JWpVZZluHF0TGT
        RGnXABPtLymvuh5C7ibhtomrZA==
X-Google-Smtp-Source: ABdhPJy5Kn+yvqLcXzfzyvGlttPOTv6zxSUWOgHVrqd8CjcCzdgLfUd5wPMKRSdGsOL4+oXiuJ5KrA==
X-Received: by 2002:a17:90a:46cc:: with SMTP id x12mr9547674pjg.52.1622120379071;
        Thu, 27 May 2021 05:59:39 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:a93:378d:9a9e:3b70])
        by smtp.gmail.com with UTF8SMTPSA id o2sm1885997pfu.80.2021.05.27.05.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 05:59:38 -0700 (PDT)
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
Subject: [PATCH v8 05/15] swiotlb: Add a new get_io_tlb_mem getter
Date:   Thu, 27 May 2021 20:58:35 +0800
Message-Id: <20210527125845.1852284-6-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527125845.1852284-1-tientzu@chromium.org>
References: <20210527125845.1852284-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new getter, get_io_tlb_mem, to help select the io_tlb_mem struct.
The restricted DMA pool is preferred if available.

The reason it was done this way instead of assigning the active pool to
dev->dma_io_tlb_mem was because directly using dev->dma_io_tlb_mem might
cause memory allocation issues for existing devices. The pool can't
support atomic coherent allocation so swiotlb_alloc needs to distinguish
it from the default swiotlb pool.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 03ad6e3b4056..b469f04cca26 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_SWIOTLB_H
 #define __LINUX_SWIOTLB_H
 
+#include <linux/device.h>
 #include <linux/dma-direction.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -102,6 +103,16 @@ struct io_tlb_mem {
 };
 extern struct io_tlb_mem *io_tlb_default_mem;
 
+static inline struct io_tlb_mem *get_io_tlb_mem(struct device *dev)
+{
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+	if (dev && dev->dma_io_tlb_mem)
+		return dev->dma_io_tlb_mem;
+#endif /* CONFIG_DMA_RESTRICTED_POOL */
+
+	return io_tlb_default_mem;
+}
+
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = io_tlb_default_mem;
-- 
2.31.1.818.g46aad6cb9e-goog

