Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4D387256
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 08:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbhERGpI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 02:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbhERGpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 02:45:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D19C061573
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:43:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 27so5019118pgy.3
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOejb1pLptOBLwtr8s3muQhGJxeYmn24mhC6x3aimXI=;
        b=bJvp0zIiInSN5ZWaIMe8e5K+HNR7ISq4UEo1mLZbEgC1ZXykjzDgXCamzybxChCCYg
         Q5AzY3unCvHW5q2CcyLhQX/6v1MGhmSqONQXoQ4kX2g8toPd8iXpQU2fcNShC0z5alp0
         825yXIYKzFDJuPxiZomIf8Ob1ZeTDy0i8cMNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOejb1pLptOBLwtr8s3muQhGJxeYmn24mhC6x3aimXI=;
        b=PeS6sao4+akFN0cRpcg/fL8QRb3DdY4wFU6MLhQJfRkidBCpCxv2vHVYAnyzZTT9+p
         NCf61oT6Tq7FQyn5Jj0kJoLCa35I+Ys28jLpK84E5kuRzAru2JQacLHlGiojdh1PfUDO
         wZohRRJvDAWnc47TSrZKimkKNo5cyOnMgyWeRwKM3QbQheAI4/0NmLXNoCCxZl9o+v0Q
         izDQhk1/SdCu30+5V14pCPtGBz95WqTr+iI/NCUU/I320JmWkvKLG8KwVNyvuBgv5JWe
         A5YWZgPGHh4/uf0MLO2Sv16uVKqZkc+D+a9SOv+KSQeQzCQJtqtT4nbG2knVj21XQPFB
         2UMg==
X-Gm-Message-State: AOAM533b3Qnr8LzMEvYW/vR7mApb/Oabm1HI/mjI7IpjG+7gf7sDmBpe
        2I/DCxJqJg9KtIKfn9+rw9Az8A==
X-Google-Smtp-Source: ABdhPJzNkJJAn2T0mZyFQDA+s/wRVj8jNsrTpysmpN0l8T2c67G6jzizBg6Ue6FXBk8PrqmSh8meVg==
X-Received: by 2002:a63:4b5b:: with SMTP id k27mr3656248pgl.368.1621320230160;
        Mon, 17 May 2021 23:43:50 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:f284:b819:54ca:c198])
        by smtp.gmail.com with UTF8SMTPSA id r28sm8094082pgm.53.2021.05.17.23.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 23:43:49 -0700 (PDT)
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
Subject: [PATCH v7 09/15] swiotlb: Move alloc_size to find_slots
Date:   Tue, 18 May 2021 14:42:09 +0800
Message-Id: <20210518064215.2856977-10-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
References: <20210518064215.2856977-1-tientzu@chromium.org>
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
index 95f482c4408c..2ec6711071de 100644
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
2.31.1.751.gd2f1c929bd-goog

