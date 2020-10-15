Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F528EF08
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 11:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbgJOJDJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbgJOJDF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 05:03:05 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82881C0613D2
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2020 02:03:04 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v19so2269748edx.9
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2020 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6z5xqfcq1Sp2BijtV/eJd8Vk7MAj53+3Nspgxz8YIY=;
        b=W9AXKgXQuRJ69P6P9RwOQBQdA3thwvZ4DuYZl/AnWv+6fsXJnE++gI/+k3F0gqygRL
         S7PWXqmqWlU1D/fpWW2bpxpyWdR2ZL5U/cky16o2xyurM+/xUg9Yn5zCh6zAsxU+4CEf
         UMnSk388/fBsDtGE3YVa/32CCpoIsGRCahY9xl1C3oPWaUuqzHbuPZZ/ffchzaTq1jis
         vtK9m6cz4WAdfPu9UvO2fzCoVhvAI5cr6I5jIITbOelcaEi1ScRBINYLW6fC5TPnLBRu
         7O+MbHrfK6Ls0F08T9uEIN+iPTfy/t4tIqubV5DfUVU+jxVWNTo5HEuuHeJ5YI7D7Yll
         +E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6z5xqfcq1Sp2BijtV/eJd8Vk7MAj53+3Nspgxz8YIY=;
        b=r9e+7ywN14y1a2E4+sX0naYQ7JKP0hHnuRsgcOl53G9BFg8kR/RKy4rmWYAWHoM/VP
         Sp4DYLm58l5KJHyyCWYrx6RkIaz4BRfcxLi6/WodenPEOdFfFq976KD+rGgxm6vkAv2l
         C6U2HntR+aVXWAE0YL7TCeMASH97BpWYk4y7WUn7lb8Y2A2SfB6COeODDgXj/LxzdZog
         MBArgL1YZ8dHpLrUvuGU/e1T/0CzbVSuBbJEK2FU9ORZJqaIpnU64GtAHGx9TkPXFE8P
         l5x6GWqYUR8DHBTf6Py2HG+80rhA5sKyJgvF1KGoTO5SQWD3HLDnDzeBHN5Ez+HSzNlS
         7OHQ==
X-Gm-Message-State: AOAM530cJxVaHAqU9cIuLmVEBhwMr8By9QKGFzmifETazXNKV1hyghPM
        P6/8mAXlZ7IwPm8A5N/msyS6Bw==
X-Google-Smtp-Source: ABdhPJyK8hd+j8uB3o5Q/Dz8Ch3k2aQc6UNBsyR0dpdZSVT9IFPmtHBVJTekYNLCX44gCo6pYyot4Q==
X-Received: by 2002:a50:abc3:: with SMTP id u61mr3257384edc.253.1602752583017;
        Thu, 15 Oct 2020 02:03:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm1103078ejt.105.2020.10.15.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 02:03:02 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        linux-pci@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 2/2] iommu: Add IOMMU_UNBIND_FAULT_PENDING flag
Date:   Thu, 15 Oct 2020 11:00:29 +0200
Message-Id: <20201015090028.1278108-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015090028.1278108-1-jean-philippe@linaro.org>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IOMMU drivers only need to flush their PRI queue when faults might be
pending. According to the PCIe spec (quoted below) this only happens
when using the "Stop Marker" method. Otherwise the function waits for
pending faults before signaling to the device driver that it can
unbind().

Add the IOMMU_UNBIND_FAULT_PENDING flags to unbind(), to tell the IOMMU
driver whether it's worth flushing the queue.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h     | 31 +++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c |  3 ++-
 drivers/iommu/iommu.c     |  5 ++++-
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 26c1358a2a37..fd9630b1240d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -163,6 +163,37 @@ enum iommu_dev_features {
 
 #define IOMMU_PASID_INVALID	(-1U)
 
+/*
+ * Indicate that a device stops using a PASID by issuing a Stop Marker Message.
+ * From PCIe 4.0r1.0, 10.4.1.2 Managing PASID TLP Prefix Usage:
+ *
+ * "To stop without using a Stop Marker Message, the Function shall:
+ *  1. Stop queueing new Page Request Messages for this PASID.
+ *  2. Finish transmitting any multi-page Page Request Messages for this PASID
+ *     (i.e. send the Page Request Message with the L bit Set).
+ *  3. Wait for PRG Response Messages associated any outstanding Page Request
+ *     Messages for the PASID.
+ *  4. Indicate that the PASID has stopped using a device specific mechanism.
+ *     This mechanism must indicate that a Stop Marker Message will not be
+ *     generated.
+ *  To stop with the use of a Stop Marker Message the Function shall:
+ * [1. and 2. are the same]
+ *  3. Internally mark all outstanding Page Request Messages for this PASID as
+ *     stale. PRG Response Messages associated with these requests will return
+ *     Page Request Allocation credits and PRG Index values but are otherwise
+ *     ignored.
+ *  4. Indicate that the PASID has stopped using a device specific mechanism.
+ *     This mechanism must indicate that a Stop Marker Message will be
+ *     generated.
+ *  5. Send a Stop Marker Message to indicate to the host that all subsequent
+ *     Page Request Messages for this PASID are for a new use of the PASID
+ *     value."
+ *
+ * If the device indicates that the Stop Marker Message will be generated, the
+ * device driver should set the IOMMU_UNBIND_FAULT_PENDING flag.
+ */
+#define IOMMU_UNBIND_FAULT_PENDING	(1UL << 0)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 700b05612af9..aa1fcb66fa95 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -680,7 +680,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid,
 			 * hard to be as defensive as we might like. */
 			intel_pasid_tear_down_entry(iommu, dev,
 						    svm->pasid, false);
-			intel_svm_drain_prq(dev, svm->pasid);
+			if (flags & IOMMU_UNBIND_FAULT_PENDING)
+				intel_svm_drain_prq(dev, svm->pasid);
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 741c463095a8..eede0592a2c0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2995,7 +2995,10 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
  *
  * Put reference to a bond between device and address space. The device should
  * not be issuing any more transaction for this PASID. All outstanding page
- * requests for this PASID must have been flushed to the IOMMU.
+ * requests for this PASID must have been completed, or flushed to the IOMMU. If
+ * they have not been completed, for example when using a Stop Marker Message to
+ * stop PASID in a PCIe device, then the caller must set the flag
+ * %IOMMU_UNBIND_FAULT_PENDING.
  *
  * Returns 0 on success, or an error value
  */
-- 
2.28.0

