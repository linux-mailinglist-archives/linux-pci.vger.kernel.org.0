Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F923A7FB8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhFONbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 09:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhFONbO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 09:31:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4DFC0617AF
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 06:29:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u18so7842108plc.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTiG8Mo/Nik+wIMq7cgtIy70t0SMnfIMs1UdiPtMcT8=;
        b=eMMTD49WILvEJwNkbyXll1fUBPjpxlVSOhGaqL9TwmPYonPep8XftjIi5HAggU5srI
         CLNpua3pQ7CwLVSW3dv0uDNKq24FS4175dYppaWlWO3XqF6T9hZPazFJ1he0aV5H6ErX
         dgTORgnp7aFTod/O8rpuewIUUw+E6SucoIApk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTiG8Mo/Nik+wIMq7cgtIy70t0SMnfIMs1UdiPtMcT8=;
        b=BPeWderWFJJ16mDzz8XyAuR6ZlbmOQn4XvQnz45VRvdhUwp5SYKadNR/1fZb7lK/OP
         vZXuHbjwBMloEFu0TcAZZ/xHVhoApbG8OxdtOUZTvP894HGLxg+VoWL4cDZgPFb6u3nL
         /IUfkortguH/Wzc8JdexJtLpoJiuO44wHP7KtWtwkN1+vy2lSMgpxS2e8c22PDGECcfg
         9u1U+Lf55KMTF9br1+iTIsyc8rE1xqV1GPx++WNHuFMFJStRVQQiIJ1Xc6JGROb8yo8T
         HYP7HcLfdxbTRFNnL2Jh1bMZy9n7wx1eNUtvXoGUmWpn7NJws6rboMXh8fO6ntXHtUsc
         oKfA==
X-Gm-Message-State: AOAM531XwIGqRsYq+vCCaPt/XXMoBTVLVN3fz0RxeTidkBO27CBVb1PD
        gt05qwNs6OsB8WAXTEZtJLzsMg==
X-Google-Smtp-Source: ABdhPJzXEtYDRC2fz4fUhVok40FY/FvrMnNmlVHfb+TKFwVcW+8fDTaQF2I0RwRDZ7J7BoI70NFDeg==
X-Received: by 2002:a17:902:e289:b029:10c:97e9:2c74 with SMTP id o9-20020a170902e289b029010c97e92c74mr4206776plc.34.1623763748216;
        Tue, 15 Jun 2021 06:29:08 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:1846:5274:e444:139e])
        by smtp.gmail.com with UTF8SMTPSA id w27sm16447396pfq.117.2021.06.15.06.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:29:07 -0700 (PDT)
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
Subject: [PATCH v10 12/12] of: Add plumbing for restricted DMA pool
Date:   Tue, 15 Jun 2021 21:27:11 +0800
Message-Id: <20210615132711.553451-13-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210615132711.553451-1-tientzu@chromium.org>
References: <20210615132711.553451-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If a device is not behind an IOMMU, we look up the device node and set
up the restricted DMA when the restricted-dma-pool is presented.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/of/address.c    | 33 +++++++++++++++++++++++++++++++++
 drivers/of/device.c     |  3 +++
 drivers/of/of_private.h |  6 ++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 3b2acca7e363..c8066d95ff0e 100644
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
@@ -1001,6 +1002,38 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 	of_node_put(node);
 	return ret;
 }
+
+int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
+{
+	struct device_node *node, *of_node = dev->of_node;
+	int count, i;
+
+	count = of_property_count_elems_of_size(of_node, "memory-region",
+						sizeof(u32));
+	/*
+	 * If dev->of_node doesn't exist or doesn't contain memory-region, try
+	 * the OF node having DMA configuration.
+	 */
+	if (count <= 0) {
+		of_node = np;
+		count = of_property_count_elems_of_size(
+			of_node, "memory-region", sizeof(u32));
+	}
+
+	for (i = 0; i < count; i++) {
+		node = of_parse_phandle(of_node, "memory-region", i);
+		/*
+		 * There might be multiple memory regions, but only one
+		 * restricted-dma-pool region is allowed.
+		 */
+		if (of_device_is_compatible(node, "restricted-dma-pool") &&
+		    of_device_is_available(node))
+			return of_reserved_mem_device_init_by_idx(dev, of_node,
+								  i);
+	}
+
+	return 0;
+}
 #endif /* CONFIG_HAS_DMA */
 
 /**
diff --git a/drivers/of/device.c b/drivers/of/device.c
index c5a9473a5fb1..2defdca418ec 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -165,6 +165,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
+	if (!iommu)
+		return of_dma_set_restricted_buffer(dev, np);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 631489f7f8c0..376462798f7e 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -163,12 +163,18 @@ struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map);
+int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
 #else
 static inline int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
+static inline int of_dma_set_restricted_buffer(struct device *dev,
+					       struct device_node *np)
+{
+	return -ENODEV;
+}
 #endif
 
 void fdt_init_reserved_mem(void);
-- 
2.32.0.272.g935e593368-goog

