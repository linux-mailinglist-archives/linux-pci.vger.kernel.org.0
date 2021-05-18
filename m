Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D6538727C
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 08:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346815AbhERGpk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346811AbhERGpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 02:45:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315BC06138E
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:44:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c17so6684731pfn.6
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XERRPmZD9LZ8NlvTKf69Ki0Z3JOqJsfzsMjeGM/hmyc=;
        b=oT5AI3WxhLeqEGvrMWNth5ilokIoDf3aUpAY7upThFXBQOnHIqoXsdqVxmKsJ2ibAV
         p2tS4tJqThBqZvPuEA86u4i7tHwUvgMMmS6jwMmWzqazAKGD8hQRrm4uJZAQme8fQgO7
         xMpoBHann0anuHkotadEJq5SA2Uh6yM8s5FoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XERRPmZD9LZ8NlvTKf69Ki0Z3JOqJsfzsMjeGM/hmyc=;
        b=VkCFRdqE/+bKtwEu4PemVJ3FX3SSdR8grqp4by42ZtLyoZ0qrRz0Stny8dNYAy2C8r
         iwSDrKEU1yBx5x0tW7aMD4LJQkvS/itwmNcCirMJ+jWrgqac3akXIrahxUoyNUec9jZV
         z63hsfo/wv5WcE3hBTGWf6i6hxArsqhXVVN79DUV9YEt2AxVsY58wXSusYT2bOZnB0z3
         DA8jFNlQrPTlPWeS75bGl4DnHXVoPx5O4TwYE2UeD8g90n+BNj24xbW9iXbriELsXhgZ
         4jtTNVhXXUkda771mciOdlKSQg4Zgr7cmKAgUBY2AhPqLuP0BrjiJuHqTeqTqZKTtkPp
         +UHA==
X-Gm-Message-State: AOAM532imaj4MILvl2diqd2p/ByBLbqEB+XyjgQFRfAS4yB52I4Avu0+
        iZxbg/cdGg5O0AsJVp5R4VOM2g==
X-Google-Smtp-Source: ABdhPJyi8T1bUdRh2weFxzn5qV51jHdwUH18sdVlzVJRpz5+Czvdmvjaq4flIajQeG3jnSiA7cCp7w==
X-Received: by 2002:a05:6a00:15d4:b029:2de:a538:c857 with SMTP id o20-20020a056a0015d4b02902dea538c857mr438129pfu.51.1621320256584;
        Mon, 17 May 2021 23:44:16 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:f284:b819:54ca:c198])
        by smtp.gmail.com with UTF8SMTPSA id a7sm11612338pfg.76.2021.05.17.23.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 23:44:16 -0700 (PDT)
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
Subject: [PATCH v7 12/15] swiotlb: Add restricted DMA alloc/free support.
Date:   Tue, 18 May 2021 14:42:12 +0800
Message-Id: <20210518064215.2856977-13-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
References: <20210518064215.2856977-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the functions, swiotlb_{alloc,free} to support the memory allocation
from restricted DMA pool.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h |  4 ++++
 kernel/dma/swiotlb.c    | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 0c5a18d9cf89..e8cf49bd90c5 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -134,6 +134,10 @@ unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+struct page *swiotlb_alloc(struct device *dev, size_t size);
+bool swiotlb_free(struct device *dev, struct page *page, size_t size);
+#endif /* CONFIG_DMA_RESTRICTED_POOL */
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cef856d23194..d3fa4669229b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -457,8 +457,9 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 
 	index = wrap = wrap_index(mem, ALIGN(mem->index, stride));
 	do {
-		if ((slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
-		    (orig_addr & iotlb_align_mask)) {
+		if (orig_addr &&
+		    (slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
+			    (orig_addr & iotlb_align_mask)) {
 			index = wrap_index(mem, index + 1);
 			continue;
 		}
@@ -704,6 +705,36 @@ late_initcall(swiotlb_create_default_debugfs);
 #endif
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
+struct page *swiotlb_alloc(struct device *dev, size_t size)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	phys_addr_t tlb_addr;
+	int index;
+
+	if (!mem)
+		return NULL;
+
+	index = find_slots(dev, 0, size);
+	if (index == -1)
+		return NULL;
+
+	tlb_addr = slot_addr(mem->start, index);
+
+	return pfn_to_page(PFN_DOWN(tlb_addr));
+}
+
+bool swiotlb_free(struct device *dev, struct page *page, size_t size)
+{
+	phys_addr_t tlb_addr = page_to_phys(page);
+
+	if (!is_swiotlb_buffer(dev, tlb_addr))
+		return false;
+
+	release_slots(dev, tlb_addr);
+
+	return true;
+}
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-- 
2.31.1.751.gd2f1c929bd-goog

