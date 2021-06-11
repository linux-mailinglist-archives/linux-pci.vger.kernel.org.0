Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6E63A4550
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhFKPbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 11:31:32 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:41814 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhFKPbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 11:31:22 -0400
Received: by mail-pf1-f181.google.com with SMTP id x73so4726988pfc.8
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmASqPhRufrL8xgJ1lr0aYPEW2vwCzgwqGTzlcTpKYs=;
        b=VEX8i0DIIoAo+ElXJJaiZoSDgtnFLF/I1TK84grpmdSi4SdYlXjC9TQ850lntV+P5S
         831kSO2v3dGqaOBGzqf/letn3Nd8SFR1zZSHZzcvG9QoeKAD5MpmBTmIAKv31z3N4Dib
         pBY3Kg/UV3b1u2uzwExihRDf6okRk8gDOvA7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmASqPhRufrL8xgJ1lr0aYPEW2vwCzgwqGTzlcTpKYs=;
        b=EfFT/eoR0VRL+Yu3eIOY8N4zw7FU420NbS8GE7a8aAODkF3MX8wC55kFLMFaVjhHTi
         6wNBYx2C32Q78gONtNNtoKsHX75AhYdU2IIULhEJNEAaC8u/RAwzh7QSsJg57hXoAv0L
         YmJwh9SS8GW/rZbI7dGRflXh4Fx+hWjKmCu0cmyPwqRZxYXea9X/Sq5owDpgeGYJFBHQ
         uhX1S57LAglk0rQ2b3JEaPP30uY8O6XfJK5Sq6I+hqjKrToGsD1KBBveUDo+K1f+cKre
         RwNVa23wrLzUrTi/RY73Qxl/KKSnF3uotlpvNrjBPLuteaOkzIvFDqCB9Ua2yaburX+q
         EGiw==
X-Gm-Message-State: AOAM533YyOyK0aGiM8JPcpOi+RsNK5j66mJ4aS+dNQA4MDny6OeHv34b
        hHrA+S//nSBvQqr8jfd0ZaxhbA==
X-Google-Smtp-Source: ABdhPJxcN6GQyaDPIchNmU5M9fts7obcNJdbHA864T6brE5WTlPTfm/9dx+UosM5tapLbm55ICy5Kg==
X-Received: by 2002:a62:7b4c:0:b029:2e9:cec2:e252 with SMTP id w73-20020a627b4c0000b02902e9cec2e252mr8677730pfc.56.1623425304239;
        Fri, 11 Jun 2021 08:28:24 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:33c8:8e01:1161:6797])
        by smtp.gmail.com with UTF8SMTPSA id u24sm5764598pfm.156.2021.06.11.08.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:28:23 -0700 (PDT)
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
Subject: [PATCH v9 08/14] swiotlb: Move alloc_size to find_slots
Date:   Fri, 11 Jun 2021 23:26:53 +0800
Message-Id: <20210611152659.2142983-9-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611152659.2142983-1-tientzu@chromium.org>
References: <20210611152659.2142983-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the maintenance of alloc_size to find_slots for better code
reusability later.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e5ccc198d0a7..364c6c822063 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -486,8 +486,11 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 	return -1;
 
 found:
-	for (i = index; i < index + nslots; i++)
+	for (i = index; i < index + nslots; i++) {
 		mem->slots[i].list = 0;
+		mem->slots[i].alloc_size =
+			alloc_size - ((i - index) << IO_TLB_SHIFT);
+	}
 	for (i = index - 1;
 	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
 	     mem->slots[i].list; i--)
@@ -542,11 +545,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * This is needed when we sync the memory.  Then we sync the buffer if
 	 * needed.
 	 */
-	for (i = 0; i < nr_slots(alloc_size + offset); i++) {
+	for (i = 0; i < nr_slots(alloc_size + offset); i++)
 		mem->slots[index + i].orig_addr = slot_addr(orig_addr, i);
-		mem->slots[index + i].alloc_size =
-			alloc_size - (i << IO_TLB_SHIFT);
-	}
 	tlb_addr = slot_addr(mem->start, index) + offset;
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-- 
2.32.0.272.g935e593368-goog

