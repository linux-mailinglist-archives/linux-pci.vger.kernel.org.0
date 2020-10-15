Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B704528EF06
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbgJOJDD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 05:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388636AbgJOJDB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 05:03:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7698C0613D2
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2020 02:03:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id t25so2446018ejd.13
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2020 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3Jqalpf0P5zErHtqk4l6C16sl+wqSCxxuGIVGQs7DQ=;
        b=mr1fJQxpFk6abhFRMQtgpsgRIQwMBR0j7QGlRlhj7KuzeWmJXU0YbdwETZLcnmq+9J
         lX5tzFr26YXz+yCzdPD6gtShQO0epQctYygRlnqtbdAgPRH8xfeAzwyQlCoe1hpYpRhc
         xwphAD4uJCzd4cGQ9hB74QqliOtQ4Dy33Ekxq5HL+w8+cXhQna7Krm+UnUXseQr3T5nZ
         Q9GQCPSXjkNDB4KiLJteBzG5Q7d7aONk/oIVn5iY78oX+F0saxAuvq+7/MqKH8US4DNJ
         MLB4yYSQepenvMw4TLWdd6eJh2iPKDdmg3iM9wSgX0XPJTl02z0qzfIgeJiRo1E0htjz
         jmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3Jqalpf0P5zErHtqk4l6C16sl+wqSCxxuGIVGQs7DQ=;
        b=ZlUimIF28eKe+iEEgCH0YWE8V6VzxOLtSBEffVeGY2f1VNZ6EiTUV/pqtwDhK6uahR
         vyj/Zxl49CoHAQLDNp0OiVx2HszKBewSSmB99oEsQBjaqBLC79esrjh3KPl8sGRMHeMW
         o1ZAs3hNfz+e7UUDpNaYIXqnvsHPQ54wciJBMF9VXXiuueTKTZxWsaPQzYPhs+FSS+20
         9USUt+23wnvWaUnb2+0bDGW4CpEG6Vf/rabgdrsviMyC5wrAFfa6XrQV+GVG2cN0VS1R
         KNpvx4bocbOMgKDHBas4egMzNp97TDDeab80U1uG5idJ1a1Fy2r7jaU26y7cUxyWOSIS
         74bw==
X-Gm-Message-State: AOAM532610uY2PfD6WuZ87Avq4QSw7W4MeOxgB88JSiFYN6boa5zBY+5
        lOrd3Q9sHHPx/Oq2aGZEamf2CQ==
X-Google-Smtp-Source: ABdhPJxvp3P0VbmCOj0Sd9J3gE3rGotPaup8wTuhiDlW0LHaF7KYjyTBGnMO/Laaf51govZhXOzDLw==
X-Received: by 2002:a17:906:340b:: with SMTP id c11mr3325221ejb.213.1602752579395;
        Thu, 15 Oct 2020 02:02:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d12sm1103078ejt.105.2020.10.15.02.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 02:02:58 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        linux-pci@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 1/2] iommu: Add flags to sva_unbind()
Date:   Thu, 15 Oct 2020 11:00:28 +0200
Message-Id: <20201015090028.1278108-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015090028.1278108-1-jean-philippe@linaro.org>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide a way for device drivers to tell IOMMU drivers about the device
state and the cleanup work to be done, when unbinding. No functional
change.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/intel-iommu.h | 2 +-
 include/linux/iommu.h       | 7 ++++---
 drivers/iommu/intel/svm.c   | 7 ++++---
 drivers/iommu/iommu.c       | 5 +++--
 drivers/misc/uacce/uacce.c  | 4 ++--
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fbf5b3e7707e..5b66b23d591d 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -747,7 +747,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
 struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
 				 void *drvdata);
-void intel_svm_unbind(struct iommu_sva *handle);
+void intel_svm_unbind(struct iommu_sva *handle, unsigned long flags);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b95a6f8db6ff..26c1358a2a37 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -285,7 +285,7 @@ struct iommu_ops {
 
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
 				      void *drvdata);
-	void (*sva_unbind)(struct iommu_sva *handle);
+	void (*sva_unbind)(struct iommu_sva *handle, unsigned long flags);
 	u32 (*sva_get_pasid)(struct iommu_sva *handle);
 
 	int (*page_response)(struct device *dev,
@@ -636,7 +636,7 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm,
 					void *drvdata);
-void iommu_sva_unbind_device(struct iommu_sva *handle);
+void iommu_sva_unbind_device(struct iommu_sva *handle, unsigned long flags);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 
 #else /* CONFIG_IOMMU_API */
@@ -1026,7 +1026,8 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	return NULL;
 }
 
-static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
+static inline void iommu_sva_unbind_device(struct iommu_sva *handle,
+					   unsigned long flags)
 {
 }
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f1861fa3d0e4..700b05612af9 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -651,7 +651,8 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 }
 
 /* Caller must hold pasid_mutex */
-static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
+static int intel_svm_unbind_mm(struct device *dev, u32 pasid,
+			       unsigned long flags)
 {
 	struct intel_svm_dev *sdev;
 	struct intel_iommu *iommu;
@@ -1091,13 +1092,13 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 	return sva;
 }
 
-void intel_svm_unbind(struct iommu_sva *sva)
+void intel_svm_unbind(struct iommu_sva *sva, unsigned long flags)
 {
 	struct intel_svm_dev *sdev;
 
 	mutex_lock(&pasid_mutex);
 	sdev = to_intel_svm_dev(sva);
-	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
+	intel_svm_unbind_mm(sdev->dev, sdev->pasid, flags);
 	mutex_unlock(&pasid_mutex);
 }
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c470f451a32..741c463095a8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2991,6 +2991,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
 /**
  * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
  * @handle: the handle returned by iommu_sva_bind_device()
+ * @flags: IOMMU_UNBIND_* flags
  *
  * Put reference to a bond between device and address space. The device should
  * not be issuing any more transaction for this PASID. All outstanding page
@@ -2998,7 +2999,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
  *
  * Returns 0 on success, or an error value
  */
-void iommu_sva_unbind_device(struct iommu_sva *handle)
+void iommu_sva_unbind_device(struct iommu_sva *handle, unsigned long flags)
 {
 	struct iommu_group *group;
 	struct device *dev = handle->dev;
@@ -3012,7 +3013,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		return;
 
 	mutex_lock(&group->mutex);
-	ops->sva_unbind(handle);
+	ops->sva_unbind(handle, flags);
 	mutex_unlock(&group->mutex);
 
 	iommu_group_put(group);
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 56dd98ab5a81..0800566a6656 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -105,7 +105,7 @@ static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 
 	pasid = iommu_sva_get_pasid(handle);
 	if (pasid == IOMMU_PASID_INVALID) {
-		iommu_sva_unbind_device(handle);
+		iommu_sva_unbind_device(handle, 0);
 		return -ENODEV;
 	}
 
@@ -118,7 +118,7 @@ static void uacce_unbind_queue(struct uacce_queue *q)
 {
 	if (!q->handle)
 		return;
-	iommu_sva_unbind_device(q->handle);
+	iommu_sva_unbind_device(q->handle, 0);
 	q->handle = NULL;
 }
 
-- 
2.28.0

