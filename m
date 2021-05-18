Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD43387287
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 08:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbhERGqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 02:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbhERGqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 02:46:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D90C061345
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:44:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so991449pjb.4
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I5cfiiuVy355q+pMGkQSgcYSZ5RdxJgoq0S/wr5t2jQ=;
        b=VCVUNM1MLDDCM1YEpGwmMdmzVg+pX5xmo6WpPBxB4HadDcwl/CwygcBJ5Z5xVX7EGU
         JOp+gYR2V8ugVsU2F+sXgC/jRu3mFZRgRkzZFN+5qA7YQg/e6fHR9WHgCovgX+k3cvqU
         Wun2WPZQV8InkeRjlR+5gd/zLl5l3irc9NkFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I5cfiiuVy355q+pMGkQSgcYSZ5RdxJgoq0S/wr5t2jQ=;
        b=Dm0WJcu+rpQSBULTh3i5Lm4nkPJ/Pw9Hzz6ZFdEQ40nVrDCdj6xNkBfbFxeSdmIAZT
         Htkk8QYAQU1ZV3JdcyAuUow+vIwmCQbg2CYVsoBg1YLUfj4QJt5AvftiaEfUbqGOCjbX
         nrDVd+M2jE6F10HEEbm7+KgHV8eEyGxuro/b12VAJYJAJNMNI6NTBMIS2of3IzSFaKFC
         ddwTXdL0UldJNEwtXegYh5mZoaCWcSWih7OqUdHho9xJ0p2WSeJPXaxv+eoyD/KOJJFu
         r7LMAR0Bi3AmKBppVakSRNfby3HX62bl4FL6Z1ZPlYYv7PtoRDPwGgn5xpgApHwbjLWw
         Ncgw==
X-Gm-Message-State: AOAM532N3Ei3PD7V1SUbqooVi9aSrkBC5qVeUc9a++doV7M6YRdZ0ABh
        GNjxW8/st404nm2AKJ0RPdhD7w==
X-Google-Smtp-Source: ABdhPJwzOAZEABY7sDXY0ei+QGCalaTIdclP5XZ2XQEkXIWtCph5uBf4dqlngGwrRv8DyOssDP/zXQ==
X-Received: by 2002:a17:90a:9312:: with SMTP id p18mr3499688pjo.171.1621320282285;
        Mon, 17 May 2021 23:44:42 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:f284:b819:54ca:c198])
        by smtp.gmail.com with UTF8SMTPSA id u23sm1635824pfn.106.2021.05.17.23.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 23:44:41 -0700 (PDT)
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
Subject: [PATCH v7 15/15] of: Add plumbing for restricted DMA pool
Date:   Tue, 18 May 2021 14:42:15 +0800
Message-Id: <20210518064215.2856977-16-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
References: <20210518064215.2856977-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If a device is not behind an IOMMU, we look up the device node and set
up the restricted DMA when the restricted-dma-pool is presented.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/of/address.c    | 25 +++++++++++++++++++++++++
 drivers/of/device.c     |  3 +++
 drivers/of/of_private.h |  5 +++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index aca94c348bd4..c562a9ff5f0b 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -8,6 +8,7 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -1112,6 +1113,30 @@ bool of_dma_is_coherent(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_dma_is_coherent);
 
+int of_dma_set_restricted_buffer(struct device *dev)
+{
+	struct device_node *node;
+	int count, i;
+
+	if (!dev->of_node)
+		return 0;
+
+	count = of_property_count_elems_of_size(dev->of_node, "memory-region",
+						sizeof(phandle));
+	for (i = 0; i < count; i++) {
+		node = of_parse_phandle(dev->of_node, "memory-region", i);
+		/* There might be multiple memory regions, but only one
+		 * restriced-dma-pool region is allowed.
+		 */
+		if (of_device_is_compatible(node, "restricted-dma-pool") &&
+		    of_device_is_available(node))
+			return of_reserved_mem_device_init_by_idx(
+				dev, dev->of_node, i);
+	}
+
+	return 0;
+}
+
 /**
  * of_mmio_is_nonposted - Check if device uses non-posted MMIO
  * @np:	device node
diff --git a/drivers/of/device.c b/drivers/of/device.c
index c5a9473a5fb1..d8d865223e51 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -165,6 +165,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
+	if (!iommu)
+		return of_dma_set_restricted_buffer(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index d717efbd637d..9fc874548528 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -163,12 +163,17 @@ struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map);
+int of_dma_set_restricted_buffer(struct device *dev);
 #else
 static inline int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
+static inline int of_dma_set_restricted_buffer(struct device *dev)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* _LINUX_OF_PRIVATE_H */
-- 
2.31.1.751.gd2f1c929bd-goog

