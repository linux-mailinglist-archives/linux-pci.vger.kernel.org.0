Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD2B3A452D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhFKPag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 11:30:36 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:46836 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhFKPac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 11:30:32 -0400
Received: by mail-pg1-f172.google.com with SMTP id n12so2727241pgs.13
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nk5KLnjJUZzmwtQpVnUAlLQfo+45PCj3pfGwn0Xh8Lc=;
        b=ZWUxrjtFrWfMiz2vkDC3jaU4HtvtATQivM2/a1WCbJcnmtmvKI0dai77VR4iYEO7wi
         qbyNf8h4nuDiw8nL5J1NWb9gMMiyGOXWgSIcxhIHjtKOTxqX7IkzBlm/uHswtyFUBs9r
         1dmPjPkxMqFDM4eWBrACbXxSEo8vyq9XlFtA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nk5KLnjJUZzmwtQpVnUAlLQfo+45PCj3pfGwn0Xh8Lc=;
        b=aWyC1m3IOw0Q3Trx2+hOfpg/toQXkyDhcJ98pY+1wdNKDarymcPBr9JLXbGQYdmoXf
         mTAdpcZ8XRYS6J3eUFYsJjOG0D4FcLSfGXq2d2v9WAAi8d0clTDDo1oX73iGBsNDeLXF
         vOPMb+asiSifkROtxGHvZ8LUoxHj+uaE3yLQG2mCkFONWuILYSI/RC5E2Sr4XY8VRfVj
         VmfspjrkOSzA7C4vz7YsFfBgLo6HNtsoImksxO5FMGPBYjnNObYRJdhf2GU7WDPOxt+2
         hR5yNEE+L/oR1aKOWZNg/LXbTprubbqkPWWF5eNv6IDwiztregc1pzn57EKxQ7n3XzJR
         Tb3w==
X-Gm-Message-State: AOAM532ZhgoentofZGq/h73+dldo8cwxLvoHDisUGj8wU+cqCFZN+gVm
        lmu0mVnHg/tSvUUfuh9dHhawZA==
X-Google-Smtp-Source: ABdhPJzVViGqCnvRmV8jjGxainZfFkO96cSEyNRWz3J/3hQzjle8DzEEYAlc9QxFMOZm5LzjKL8vSg==
X-Received: by 2002:a63:1210:: with SMTP id h16mr4191204pgl.189.1623425241610;
        Fri, 11 Jun 2021 08:27:21 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:33c8:8e01:1161:6797])
        by smtp.gmail.com with UTF8SMTPSA id a11sm5354193pjq.45.2021.06.11.08.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:27:20 -0700 (PDT)
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
Subject: [PATCH v9 01/14] swiotlb: Refactor swiotlb init functions
Date:   Fri, 11 Jun 2021 23:26:46 +0800
Message-Id: <20210611152659.2142983-2-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611152659.2142983-1-tientzu@chromium.org>
References: <20210611152659.2142983-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new function, swiotlb_init_io_tlb_mem, for the io_tlb_mem struct
initialization to make the code reusable.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 53 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca7d505d61c..1a1208c81e85 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -168,9 +168,32 @@ void __init swiotlb_update_mem_attributes(void)
 	memset(vaddr, 0, bytes);
 }
 
-int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
+static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
+				    unsigned long nslabs, bool late_alloc,
+				    bool memory_decrypted)
 {
+	void *vaddr = phys_to_virt(start);
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
+
+	mem->nslabs = nslabs;
+	mem->start = start;
+	mem->end = mem->start + bytes;
+	mem->index = 0;
+	mem->late_alloc = late_alloc;
+	spin_lock_init(&mem->lock);
+	for (i = 0; i < mem->nslabs; i++) {
+		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
+		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
+		mem->slots[i].alloc_size = 0;
+	}
+
+	if (memory_decrypted)
+		set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
+	memset(vaddr, 0, bytes);
+}
+
+int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
+{
 	struct io_tlb_mem *mem;
 	size_t alloc_size;
 
@@ -186,16 +209,8 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	if (!mem)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
-	mem->nslabs = nslabs;
-	mem->start = __pa(tlb);
-	mem->end = mem->start + bytes;
-	mem->index = 0;
-	spin_lock_init(&mem->lock);
-	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
-		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
-		mem->slots[i].alloc_size = 0;
-	}
+
+	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false, false);
 
 	io_tlb_default_mem = mem;
 	if (verbose)
@@ -282,7 +297,6 @@ swiotlb_late_init_with_default_size(size_t default_size)
 int
 swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 {
-	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
 	struct io_tlb_mem *mem;
 
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
@@ -297,20 +311,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	if (!mem)
 		return -ENOMEM;
 
-	mem->nslabs = nslabs;
-	mem->start = virt_to_phys(tlb);
-	mem->end = mem->start + bytes;
-	mem->index = 0;
-	mem->late_alloc = 1;
-	spin_lock_init(&mem->lock);
-	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
-		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
-		mem->slots[i].alloc_size = 0;
-	}
-
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	memset(tlb, 0, bytes);
+	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true, true);
 
 	io_tlb_default_mem = mem;
 	swiotlb_print_info();
-- 
2.32.0.272.g935e593368-goog

