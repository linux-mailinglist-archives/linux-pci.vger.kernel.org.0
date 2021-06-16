Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7298D3A9026
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 05:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhFPD4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 23:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhFPD4n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 23:56:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23F9C0617A8
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 20:54:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c15so347862pls.13
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 20:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4psftO+uH/TVnoki1qOI27Xe5kV3FYGMoE+zQAlSb7o=;
        b=Li4AEy2JF5gPy9ukpQUJjDPB8rq/Zch13XpWyeO7bHztoc5ctZfpP5asNBSNDWCRJ9
         ebBl8RVKocmQh3z5hITYqIYweSnFDje1ai0AgaL9yWsFuJH6pOsddoNur+1F3lLEmeDF
         LM382R5+plRtaFQ3A0pI0SFPAyiAdN6Elek1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4psftO+uH/TVnoki1qOI27Xe5kV3FYGMoE+zQAlSb7o=;
        b=Opy6+TXt5zSNvgEgMW5a61jX2SP7f9Mu0JFKPCY6XpgXJqWK1dwyGCMphKKWoFgg4d
         BBuoRCz7szpmOnbRRZDaC4WpRenlZr17uKPboVOwQHiU3HoGHKf0mTaGzXZyA43fXXSg
         pdSbw3VL26OLMnlx13/dVbkcwOveTlLRAHtTZHyiNlZROTdd4WSrZPtAreVczN/1BMwa
         KL32cH171hWox+eM71lYt8ADoUsgq3Wfsr163SlDV7TQYKS2btxI9AdRnMMm5HKjRxTC
         mhlvEKFnglcCGU8O/CuRmIVWu1xPwF4k9FNJ60q+vLtz9iZ26fPI+1YqyD+ucYK2AXt9
         fTcQ==
X-Gm-Message-State: AOAM531cTqpwtF58sQMBqBTaOTJ9xLnDgiJWgdw+qqzn4xPc9I9btRi4
        zKf6WLrL4gq3DfN6Ew9Vf4UjMw==
X-Google-Smtp-Source: ABdhPJxIA/TwmqjYIYiJDhgzfrw1oBecMGqUYPCqotzqYdZPBQm2bHhvFmGRXaCctCumXjdHnaXVuA==
X-Received: by 2002:a17:902:d645:b029:11d:d075:cf43 with SMTP id y5-20020a170902d645b029011dd075cf43mr4991840plh.14.1623815676876;
        Tue, 15 Jun 2021 20:54:36 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:3d52:f252:7393:1992])
        by smtp.gmail.com with UTF8SMTPSA id bv3sm3688867pjb.1.2021.06.15.20.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 20:54:36 -0700 (PDT)
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
Subject: [PATCH v11 12/12] of: Add plumbing for restricted DMA pool
Date:   Wed, 16 Jun 2021 11:52:40 +0800
Message-Id: <20210616035240.840463-13-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616035240.840463-1-tientzu@chromium.org>
References: <20210616035240.840463-1-tientzu@chromium.org>
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
index 73ddf2540f3f..cdf700fba5c4 100644
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
@@ -1022,6 +1023,38 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
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
index 6cb86de404f1..e68316836a7a 100644
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
index d9e6a324de0a..25cebbed5f02 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -161,12 +161,18 @@ struct bus_dma_region;
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
 
 #endif /* _LINUX_OF_PRIVATE_H */
-- 
2.32.0.272.g935e593368-goog

