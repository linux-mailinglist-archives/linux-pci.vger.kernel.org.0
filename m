Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB5387238
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 08:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbhERGod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 02:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbhERGoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 02:44:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEADFC06175F
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:43:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h20so4537762plr.4
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=um8C1f1vzKtWMFhzfAaBUmj42oNwrbNCekMrLvRdk1U=;
        b=Nz40zJd0pKEYV/k8IK4lTQTRDZOUiOUwbA1Arvy6QUQBlPK9z/7NLsKlNL3/1e+jPn
         Rvsno7nzSv10lOGgseQXJjtNssSPkX7wvn5b3le+v615CbL79fsk9Hc2gr53iJRIIsL9
         joN4AoOubYBk2J2DPKHOuv42MtUoFxjdy1UIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=um8C1f1vzKtWMFhzfAaBUmj42oNwrbNCekMrLvRdk1U=;
        b=mvhncXnJr3PXK+EhP1mhpU/xZkBRQHm2VNwKVz5baKC5OniMfOQ13RWJb6F3uDq0vU
         Zm39/dc7DH2crlIxStEjDVelrerbJ031NXymhl3xnh4W2IEcEH0CIcBOBvF0HQwHrRrX
         VKdMF7sK5hKvdXUnyw/PkF6oP+eMeaAmRlPSVnifSqHsJ9fNoNKMt34hse8kVE4Rj3sF
         Q2fioaZDc0bYsNv7H4xffj3+cLHWU1iMxrPyGV7Di9ijSqVZ/QH6xVj363WyD02YyJxz
         2SWjGT6uXQ7ZKzPQS9XgH6B37IOzX6j/MWNjLTI9a6EDDE4EbAtEFr2v8+b32yD5wLRg
         PvyA==
X-Gm-Message-State: AOAM530jhtrfYbgkMhWSiM3ZgDuDgbui1+PKXNxjkik5yJfBEtS1ZK5R
        IzojhpVsOjvuyK8yNSD4r1HRXA==
X-Google-Smtp-Source: ABdhPJzOUb2or4i3Atyb+wUWqF92M1zBsVH9PXp2RXUL88l16TO6O0yu3WeWl6JLm0exg/RwsGT9VA==
X-Received: by 2002:a17:90a:f987:: with SMTP id cq7mr1872645pjb.30.1621320194605;
        Mon, 17 May 2021 23:43:14 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:f284:b819:54ca:c198])
        by smtp.gmail.com with UTF8SMTPSA id k10sm4407807pfu.175.2021.05.17.23.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 23:43:14 -0700 (PDT)
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
Subject: [PATCH v7 05/15] swiotlb: Add a new get_io_tlb_mem getter
Date:   Tue, 18 May 2021 14:42:05 +0800
Message-Id: <20210518064215.2856977-6-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
References: <20210518064215.2856977-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new getter, get_io_tlb_mem, to help select the io_tlb_mem struct.
The restricted DMA pool is preferred if available.

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
2.31.1.751.gd2f1c929bd-goog

