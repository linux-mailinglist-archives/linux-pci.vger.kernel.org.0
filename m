Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1C378051
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhEJJxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 05:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhEJJxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 05:53:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38379C061343
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 02:51:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n16so8860504plf.7
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTHCFxssIveqpuArSgW3Qj3cZNx2ZZwG3aJYd2ZEd8Y=;
        b=SU2CBBmY8DtSQd0TNZ7943oJOHoK8+TBS5VGCwhcrloaivVlt1fQYEyAF2Dc62+eQt
         UT9wdd13n+8GJAVW0U5UJTACdpxx/KKTBexY7stqKf1PPvqGXsqREXZG7XFlnC1R91bt
         2OsKvp8oZwX6m5c1ltX1+1ihIJktkKBoMRuaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTHCFxssIveqpuArSgW3Qj3cZNx2ZZwG3aJYd2ZEd8Y=;
        b=XJgjsXbbpSQebn8cmug0JOCm8xabau8FtTm5n4rCdEvOqLC9U1ZldR7IhYFDpYjAoL
         kgJsaSt5R44oIjqIyqtEuryjsiV6gb27+AfihK30gMXQYW9nEyEnABAeLQpyCHeBFFoT
         GkwPSuOw729SNAPjOlCEGvetoun7GLgqtDJZ4YFovSM/NXTlh0SvVcPQ3XUw4HOpzQc8
         apvK/nV5esebomJ5njU+efrgt7XABF2ZoMeQfVYiytVbsjA9PPqP/1yBAh9UIIl4xeyi
         ZQpl/pDM8uW8qd4FSad2ndsse67ze87ziRwYAwDrgrASgAGnsQ39OIILv4HqNK1odZqw
         q5HA==
X-Gm-Message-State: AOAM532HtJLjxqkLh/379rO3z3XPNdQCYyHqHs01MixzzxtY4ed5ENUe
        buAog+Cb+CSLPMsICaWj8YZCUg==
X-Google-Smtp-Source: ABdhPJyDFzChlNem0OEVDyj1b5MdL1myWQlCxWzTZ5O8kSwg2MCCOlZ4L1D63xzDiO05ddNXDCzncQ==
X-Received: by 2002:a17:90a:d78c:: with SMTP id z12mr39367495pju.106.1620640317770;
        Mon, 10 May 2021 02:51:57 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:a524:abe8:94e3:5601])
        by smtp.gmail.com with UTF8SMTPSA id l127sm10665077pfd.128.2021.05.10.02.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 02:51:57 -0700 (PDT)
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
Subject: [PATCH v6 09/15] swiotlb: Move alloc_size to find_slots
Date:   Mon, 10 May 2021 17:50:20 +0800
Message-Id: <20210510095026.3477496-10-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210510095026.3477496-1-tientzu@chromium.org>
References: <20210510095026.3477496-1-tientzu@chromium.org>
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
index 3f1ad080a4bc..ef04d8f7708f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -482,8 +482,11 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
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
@@ -538,11 +541,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
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
2.31.1.607.g51e8a6a459-goog

