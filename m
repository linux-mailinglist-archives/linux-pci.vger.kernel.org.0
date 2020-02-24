Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3016AEB9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBXSYj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34518 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgBXSYi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id z15so3239632wrl.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ke1+5YSOcxDNzSzBBGnaN+kOVlCxvSlETx/6pQryQw=;
        b=hQ7R/j32SLrNiw6cB+MKzedjV5jb7wC2uDlPXljxSGn/Mm+e8K6vJRpSEh03PvC4u9
         6SWVO6jkqy8f1MhFEXuwvn5CVzySq1eAR0OMIHnH231Ilx59ro788ZXbVKhAb08vEu3x
         2DRDRX3reoEDjA1nXPvHdhi3NlMMHALRilHOP4FbegQ6bDl+MXF72BSCvs01Iga0ey/V
         lRA5BpuJcyT4Bo+4XEn4NxJCsLV3waRxK/XqqsUDdfn1vY0NKse5RC5ThKKbEOiOSL6S
         WBTlf6zQcjBQmTv4KAcSJKa3LHmn9N03VuV6CMiAjWvmhiZgf7OibmnfYlq8z45tqDXq
         +QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ke1+5YSOcxDNzSzBBGnaN+kOVlCxvSlETx/6pQryQw=;
        b=hng9PeRc5tp/jSaCmZkyKsgXaF+iftCAIzwcJBMRw1lmRayWyh8/X7BNXZY0qmWqoC
         wwx+V60KOaiOGBtEomqivshuZeZRQgWenEwJof+EVqUs4aCWUP/sgLMDGYmi6cWuj/Vx
         aYqkt9nEfAX9TiqYB542DenD6pqyoFxyK7+ILmzFOWbpwfN1cEsKiDhGbD7u90ujIoXO
         xPwPKa+xsRWpTEa00j34Cqs/qDCwem84ba6N+GE7ejCsdAlU5/0nDTHgtfsjVAcT8UX6
         5k4du8QaN2A7VaGons6EdZVZCgmdhMdoHBviAIkFhk5LKZR48tegRXXpn+acaQdu5RZF
         xbSA==
X-Gm-Message-State: APjAAAVvQPPlN454TNM3futXwKLAF76XO2dwUp+yE8kO+T2H+aZW1rkL
        LpFoH6pCQEhe7T7mF7VWch5PwQ==
X-Google-Smtp-Source: APXvYqxKuED5BtGA+H9sncjVVYaPSWdkOdWHekAifEqs9Cn+ZBcftrmVm7FgSaad06EVLWBinDxKzg==
X-Received: by 2002:adf:df83:: with SMTP id z3mr67641748wrl.389.1582568676229;
        Mon, 24 Feb 2020 10:24:36 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:35 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v4 06/26] iommu/sva: Register page fault handler
Date:   Mon, 24 Feb 2020 19:23:41 +0100
Message-Id: <20200224182401.353359-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

When enabling SVA, register the fault handler. Device driver will register
an I/O page fault queue before or after calling iommu_sva_enable. The
fault queue must be flushed before any io_mm is freed, to make sure that
its PASID isn't used in any fault queue, and can be reallocated. Add
iopf_queue_flush() calls in a few strategic locations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig     |  1 +
 drivers/iommu/iommu-sva.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e4a42e1708b4..211684e785ea 100644
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
index bfd0c477f290..494ca0824e4b 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -366,6 +366,8 @@ static void io_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 			dev_WARN(dev, "possible leak of PASID %u",
 				 io_mm->pasid);
 
+		iopf_queue_flush_dev(dev, io_mm->pasid);
+
 		/* unbind() frees the bond, we just detach it */
 		io_mm_detach_locked(bond);
 	}
@@ -442,11 +444,20 @@ static void iommu_sva_unbind_locked(struct iommu_bond *bond)
 
 void iommu_sva_unbind_generic(struct iommu_sva *handle)
 {
+	int pasid;
 	struct iommu_param *param = handle->dev->iommu_param;
 
 	if (WARN_ON(!param))
 		return;
 
+	/*
+	 * Caller stopped the device from issuing PASIDs, now make sure they are
+	 * out of the fault queue.
+	 */
+	pasid = iommu_sva_get_pasid_generic(handle);
+	if (pasid != IOMMU_PASID_INVALID)
+		iopf_queue_flush_dev(handle->dev, pasid);
+
 	mutex_lock(&param->sva_lock);
 	mutex_lock(&iommu_sva_lock);
 	iommu_sva_unbind_locked(to_iommu_bond(handle));
@@ -484,6 +495,10 @@ int iommu_sva_enable(struct device *dev, struct iommu_sva_param *sva_param)
 		goto err_unlock;
 	}
 
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		goto err_unlock;
+
 	dev->iommu_param->sva_param = new_param;
 	mutex_unlock(&param->sva_lock);
 	return 0;
@@ -521,6 +536,7 @@ int iommu_sva_disable(struct device *dev)
 		goto out_unlock;
 	}
 
+	iommu_unregister_device_fault_handler(dev);
 	kfree(param->sva_param);
 	param->sva_param = NULL;
 out_unlock:
-- 
2.25.0

