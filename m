Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4480D24D5FB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgHUNQZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgHUNQQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 09:16:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE6C061387
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:13 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l23so1369466edv.11
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnnlDaJISLBh3tlC6QY64TitbeK2bzvjOXLypqqoQOw=;
        b=Evc7JHiQsscTCCzRJuF4RGxVPF/TfJEQoNFtq/F7l4VJCPfkB8ZnzeHE1jSsjrZ5r7
         5C5idkHzraOBGbOnKZ34LNp9EprEIaOlttQSmNnVriYiMTyEn0rEcuYChBq7/TbDjIa9
         h9y8+WSyeAHbE/U5TdEhnhnBK3VaWQsOiKiNRvRwvjKBbSoZrDHgc/ZU3yHnRDYGsqwM
         dcz4chm8cEyq8yr22YRPHjEUeukQaL7QYjLiVubrUsFr+Z3R6l5PdO1A8jIMu+4qOmwq
         DC8C2F+j/g3CwmANZ24gMXCH2L7IB0mQp2b8fBSq4UKvRyEOgAylfTesVJgJHr38GfK+
         JKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnnlDaJISLBh3tlC6QY64TitbeK2bzvjOXLypqqoQOw=;
        b=LqxzW4oEMI+zwnVUaan/Ufgw5OX8DjWL7TqePmxIH9mE91StDDGb1ySDXSWMq4br5C
         VpymzQKfFLP7s7mSkrJxO+jBLkOfBmGW64Sox5JFldpHafKKfOiIrZyxycS0RQ4N+ZNj
         B9KPmijJPyZf9dtWlCuzMDnTw3RMdRbH8TfaQ3jTcvTQI8zSTZVj1i6zWrf+UhvopYdf
         hH6fPy89ebmK0/YjIptLsMxFXRh1+CNX8VImGWRGqCj6AUW7sr69DRmDGW7svQXiUgfM
         Gv71Al+QcloaV1QMmrIuetH9jRO+DilJ84FugIJvxqfS+QUZZ7u0SOWYp6Bmk9vnsFgH
         tqfQ==
X-Gm-Message-State: AOAM531qJFrLPe8Thn2mkWPbEx76Eu4tkwe4moMzJdfHk0OrcNKvnkfb
        7F/b5G9Z+q8zGrebrLfe2s/gUA==
X-Google-Smtp-Source: ABdhPJxLTyEDp1sdq7LgF1huRP9DNgLTxWOLZlImVJP3z0/PYSRni9H4ifVAEYm5/PMqx1CpjBujwg==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr2827173edr.128.1598015770571;
        Fri, 21 Aug 2020 06:16:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:16:10 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 3/6] PCI: Add DMA configuration for virtual platforms
Date:   Fri, 21 Aug 2020 15:15:37 +0200
Message-Id: <20200821131540.2801801-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hardware platforms usually describe the IOMMU topology using either
device-tree pointers or vendor-specific ACPI tables.  For virtual
platforms that don't provide a device-tree, the virtio-iommu device
contains a description of the endpoints it manages.  That information
allows us to probe endpoints after the IOMMU is probed (possibly as late
as userspace modprobe), provided it is discovered early enough.

Add a hook to pci_dma_configure(), which returns -EPROBE_DEFER if the
endpoint is managed by a vIOMMU that will be loaded later, or 0 in any
other case to avoid disturbing the normal DMA configuration methods.
When CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS isn't selected, the call to
virt_dma_configure() is compiled out.

As long as the information is consistent, platforms can provide both a
device-tree and a built-in topology, and the IOMMU infrastructure is
able to deal with multiple DMA configuration methods.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 449466f71040..dbe9d33606b0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -19,6 +19,7 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/virt_iommu.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -1605,6 +1606,10 @@ static int pci_dma_configure(struct device *dev)
 	struct device *bridge;
 	int ret = 0;
 
+	ret = virt_dma_configure(dev);
+	if (ret)
+		return ret;
+
 	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
-- 
2.28.0

