Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF31A869F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391194AbgDNREd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391306AbgDNRE1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2F4C061A0C
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a81so14893170wmf.5
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pm90KHnx8uK8AXrbNapri8S3uUJ3F4SFKQZ/TEPP7D0=;
        b=H/49gtTyBTSYl8Y/NsAtw8/g2zInRHKwlAM06dE15HfIZYVeRpp26xgT3c6zafASzi
         7uDVin3Kh8IClWDwqrYvKeFnyEB6udiDwCzxx2XTV4flbL6HH0XG9E/oPAZMxmIEDG2M
         jnmEkxuf7GeDgwVmmZ4SS2Ai+L4FsU4qiAepIcf4xzuUgNOcUilebN8pD4B0N++nF8Vq
         Zp/DuX2F1sTJiHAzOXJwPFc6HbGiFHxiJnEcW/IlfA8fGtHRi7Np+xmoeh36HV8dpfll
         4HfN46I/PT6emJf6bvhw3gp7qf7nU5c8gXH7dohtjLBTfv8wGTTZmGm7nQ70C7xIRVtp
         OYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pm90KHnx8uK8AXrbNapri8S3uUJ3F4SFKQZ/TEPP7D0=;
        b=HJ5ow8FPTogK5GDk9qIHN33J6aEEGSedjeXPDJNf+HdRfuJEuVMiCeBBlTH5CKJmvd
         dN3pgr499wjJEq1LFD2K6lwiWJnej1Qioia877PASKcPysrH9u21KilWGSE4zZSVhRrZ
         0ChCRtiadyGK+cDeDa2aAqo3c7XIYo8Ni0zmOQQq5M28mTXiZD9r3Lyt2N7pO9ajzkxo
         /zdH55QM5tQSP+Eqiil/yeeRPBd6FzcdNxQCgb6F3rBY7UxbG6HO/mqKB54wAI9nDAKO
         /pbb6saaztE0aMGxGmYBnI7qkjT3+woriZKsAcmjjRz42WBgOI3phHMS8j5M9qT09mjB
         OyiQ==
X-Gm-Message-State: AGi0PuY9XwawnYBlv2EoGRx3fKdonGxJ2lO9EPgvWS0ydUGSm47hCY3p
        fhhMN0DuyDg9eIPd9fUQujl0jQ==
X-Google-Smtp-Source: APiQypJk/dl8CBfLNh5x7aucnzwvWIEs4TpxXFyGB0h6saUKXXv74fXgKyRLf7k//vQrLyri2cta5A==
X-Received: by 2002:a1c:998b:: with SMTP id b133mr767731wme.65.1586883865987;
        Tue, 14 Apr 2020 10:04:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:25 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v5 06/25] iommu/sva: Register page fault handler
Date:   Tue, 14 Apr 2020 19:02:34 +0200
Message-Id: <20200414170252.714402-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When enabling SVA, register the fault handler. Device driver will register
an I/O page fault queue before or after calling iommu_sva_enable. The
fault queue must be flushed before any io_mm is freed, to make sure that
its PASID isn't used in any fault queue, and can be reallocated.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig     |  1 +
 drivers/iommu/iommu-sva.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bf620bf48da03..411a7ee2ab12d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -106,6 +106,7 @@ config IOMMU_DMA
 config IOMMU_SVA
 	bool
 	select IOASID
+	select IOMMU_PAGE_FAULT
 	select IOMMU_API
 	select MMU_NOTIFIER
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b177d6cbf4fff..00d5e7e895e80 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -420,6 +420,12 @@ void iommu_sva_unbind_generic(struct iommu_sva *handle)
 	if (WARN_ON(!param))
 		return;
 
+	/*
+	 * Caller stopped the device from issuing PASIDs, now make sure they are
+	 * out of the fault queue.
+	 */
+	iopf_queue_flush_dev(handle->dev, bond->io_mm->pasid);
+
 	mutex_lock(&param->sva_lock);
 	mutex_lock(&iommu_sva_lock);
 	io_mm_detach(bond);
@@ -457,6 +463,10 @@ int iommu_sva_enable(struct device *dev, struct iommu_sva_param *sva_param)
 		goto err_unlock;
 	}
 
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		goto err_unlock;
+
 	dev->iommu->sva_param = new_param;
 	mutex_unlock(&param->sva_lock);
 	return 0;
@@ -494,6 +504,7 @@ int iommu_sva_disable(struct device *dev)
 		goto out_unlock;
 	}
 
+	iommu_unregister_device_fault_handler(dev);
 	kfree(param->sva_param);
 	param->sva_param = NULL;
 out_unlock:
-- 
2.26.0

