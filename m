Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B53524D5F8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 15:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgHUNQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgHUNQM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 09:16:12 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050BC061385
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:12 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so1383513edk.6
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGfR6v3AK9RiKFWmVUt4OX8zldgtD7R209TqBrFRf6A=;
        b=NpM+QAeAtDS+vuHr/qsAxLGz0RzOZbBpb7eNNFUK3Kan9Wha3FSnGrRgODlSfxTHji
         jqPHivHK0RsfnSvZINhMJVXV5ePliRbvAny/XW+puDQKC9eSaVAT90nZ237E34X+jPYz
         kqcNeVfjnEsJ8Zd/HJrDBnyrln9AFE9kVmyfgvbVnVxLMTT6NChJuydDWP2g8r/bs627
         o/8F+GSTZ5LbFww31m11upQpAqghI7vnm3FSwkHTJlg1f7RR+pI4bBJ3Zi1Je66cAb+E
         K1wzyw+hhAwliNdzhiHjWsJXWyJbMOjB6LnZIj4Kyg9JvalM3Q+LR0JUdr19byex8jUC
         RJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGfR6v3AK9RiKFWmVUt4OX8zldgtD7R209TqBrFRf6A=;
        b=E988IGIHEUsIOcHMvyByBHgtrbn8NrPA2SAVku5oN1nltq9jKGvajzaaBtgAgYaPol
         67HDldfD6aJLykKXhKfE0mY37AdZPV2Ck0fA5NeqMXakQ8eBwo1RVLHNJEZixrzpuZe+
         SM/V0xj9MhN6q+ge+jqVmu+ZOG6xWtEN8onOOltvrDyRhMs+qxJyysnYVH06ngXAaU7r
         Xx5zNE7Hy1qw30+srW9CMOvdy4PMr+vDOvfRGT/VlJ8Yuoj1L6bcQMorC3h2ZKwiGNDH
         ubazVmZTM3wgUHBh4cVmrQxX+ho1eyL8nba141+3FIY5EyRHlI1qEC2q9B2bQh/RiULn
         C8Gw==
X-Gm-Message-State: AOAM5320ibHgofNUg9bDM/PjnDuhtDqZZMM/5G6e+AEP0KqSW2gTgnGh
        irA1RcbRMfdO71bqnoJ+0XwlrQ==
X-Google-Smtp-Source: ABdhPJxokcQ0IuXysG4c3tg0Qxks3XmbNzQjbGHqNkBr899EEr9X26aBW5gNkvYxSfGRWPA0z+/VaA==
X-Received: by 2002:a05:6402:b1c:: with SMTP id bm28mr2790782edb.116.1598015768219;
        Fri, 21 Aug 2020 06:16:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:16:07 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 1/6] iommu/virtio: Move to drivers/iommu/virtio/
Date:   Fri, 21 Aug 2020 15:15:35 +0200
Message-Id: <20200821131540.2801801-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before adding new files to the virtio-iommu driver, move it to its own
subfolder, similarly to other IOMMU drivers.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Makefile                    | 3 +--
 drivers/iommu/virtio/Makefile             | 2 ++
 drivers/iommu/{ => virtio}/virtio-iommu.c | 0
 MAINTAINERS                               | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/virtio/Makefile
 rename drivers/iommu/{ => virtio}/virtio-iommu.c (100%)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 11f1771104f3..fc7523042512 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += amd/ intel/ arm/
+obj-y += amd/ intel/ arm/ virtio/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
@@ -26,4 +26,3 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
-obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
new file mode 100644
index 000000000000..279368fcc074
--- /dev/null
+++ b/drivers/iommu/virtio/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio/virtio-iommu.c
similarity index 100%
rename from drivers/iommu/virtio-iommu.c
rename to drivers/iommu/virtio/virtio-iommu.c
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..3602b223c9b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18451,7 +18451,7 @@ VIRTIO IOMMU DRIVER
 M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
-F:	drivers/iommu/virtio-iommu.c
+F:	drivers/iommu/virtio/
 F:	include/uapi/linux/virtio_iommu.h
 
 VIRTIO MEM DRIVER
-- 
2.28.0

