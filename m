Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034371BFE8F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgD3OkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727025AbgD3OkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3AC035494
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so7234185wrs.6
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3wH0aoSV/mtrjd6WbnxDnR4aNKlRYU9rOFmne4VKHiA=;
        b=wzxgUuRvtaeqH2rptB4kU1orDwqZ/su+VoJfY7WhNM3Dxhz/3/4yyDvHQWb3akmY1r
         4c9PW6AwR89BsI+DdTekSxYgdTdSiuqszEocM/KzzCLLr47bgjZ6INnH1cyoiBep4mJE
         d5Em/ivfVrvcWRg9XYHw3ZiyYrdG/H66AKzz9aQlg71nEAhyQK0BxNYQuXb+ngZ+9a0l
         41rkZibVe4KLwjeGqxnqcTdvt1n/4YVjqQIkAWHBQfML8x3Fqa2b6mJDDduiZytUr/vt
         n/sR+BweXDnPmscA/YKzHwsPpGj6RhLqCMKQrlU7Bwq7dxBUbJ20hHD3g3lyXath2chD
         w7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3wH0aoSV/mtrjd6WbnxDnR4aNKlRYU9rOFmne4VKHiA=;
        b=So1e/22bYkc1JXFNVvjNE8ZRDcGIAP+2YyQII8DbKVfMBl1/D7PNhi28NDCi3X0AFR
         2lRKI/lomPh+3t9BaM8PzTSNfrjieX00vN5TEhJB+Wymejlv2lLXKqD83/TL4JcxhO4P
         aDRlQyQSwDp2FBhDcQYAjqduY5xNDN4V2yEyFC26RfNZ5odUzEjdA03r04IKksjGMPxE
         cXbucP9qdU/suM2kwwlbatm/4aQdJSqzRdBacXUmZXohB5b96SULyQdkCXKlgGz5WnIH
         FhC5b/AEMnSuu1m0QOmeMfilVbNJiVBVT+xE32bHnj64b4HTr76CffmasigBpVDojm/h
         IR0w==
X-Gm-Message-State: AGi0PuZLt8MsrLBd2WLed544awiznOVDLZ6FTLT4cq1Hbyjym4NVSv/4
        zkpg73GhcHkhIbg3cX09o/bNcQ==
X-Google-Smtp-Source: APiQypI7NbvRtxIEOi2s7pji0WKTrhhzHwfUqMB42Jvp40574wez+yk9ZJ8MhjZa5Fj1fB8Uk+iFnA==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr4288207wrq.368.1588257618514;
        Thu, 30 Apr 2020 07:40:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:17 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Date:   Thu, 30 Apr 2020 16:34:01 +0200
Message-Id: <20200430143424.2787566-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Let IOASID users take references to existing ioasids with ioasid_get().
ioasid_free() drops a reference and only frees the ioasid when its
reference number is zero. It returns whether the ioasid was freed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/ioasid.h | 10 ++++++++--
 drivers/iommu/ioasid.c | 30 +++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 6f000d7a0ddcd..609ba6f15b9e3 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -34,7 +34,8 @@ struct ioasid_allocator_ops {
 #if IS_ENABLED(CONFIG_IOASID)
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_free(ioasid_t ioasid);
+void ioasid_get(ioasid_t ioasid);
+bool ioasid_free(ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
@@ -48,10 +49,15 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 	return INVALID_IOASID;
 }
 
-static inline void ioasid_free(ioasid_t ioasid)
+static inline void ioasid_get(ioasid_t ioasid)
 {
 }
 
+static inline bool ioasid_free(ioasid_t ioasid)
+{
+	return false;
+}
+
 static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 				bool (*getter)(void *))
 {
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 0f8dd377aada3..46511ac53e0c8 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -15,6 +15,7 @@ struct ioasid_data {
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
+	refcount_t refs;
 };
 
 /*
@@ -314,6 +315,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
+	refcount_set(&data->refs, 1);
 
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
@@ -345,12 +347,33 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 }
 EXPORT_SYMBOL_GPL(ioasid_alloc);
 
+/**
+ * ioasid_get - obtain a reference to the IOASID
+ */
+void ioasid_get(ioasid_t ioasid)
+{
+	struct ioasid_data *ioasid_data;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+	if (ioasid_data)
+		refcount_inc(&ioasid_data->refs);
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_get);
+
 /**
  * ioasid_free - Free an IOASID
  * @ioasid: the ID to remove
+ *
+ * Put a reference to the IOASID, free it when the number of references drops to
+ * zero.
+ *
+ * Return: %true if the IOASID was freed, %false otherwise.
  */
-void ioasid_free(ioasid_t ioasid)
+bool ioasid_free(ioasid_t ioasid)
 {
+	bool free = false;
 	struct ioasid_data *ioasid_data;
 
 	spin_lock(&ioasid_allocator_lock);
@@ -360,6 +383,10 @@ void ioasid_free(ioasid_t ioasid)
 		goto exit_unlock;
 	}
 
+	free = refcount_dec_and_test(&ioasid_data->refs);
+	if (!free)
+		goto exit_unlock;
+
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
@@ -369,6 +396,7 @@ void ioasid_free(ioasid_t ioasid)
 
 exit_unlock:
 	spin_unlock(&ioasid_allocator_lock);
+	return free;
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
 
-- 
2.26.2

