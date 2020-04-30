Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08D1BFE8C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgD3OkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727025AbgD3OkS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0EAC035495
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so2144780wmj.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JE1ADcc++3Vo3M85Nsq6iA6oMNESnLaCpD2Oim3Sh4w=;
        b=To4rDTgBB0L+90TpdlToDyTHhOTZj6qgWdXHCq8rL1YycyE+18LW7Zf89m+U1MgVk8
         +89saYtKLC3GQTyPik+jhwX+aQBQqrNZ4WAaBc81x5L7V2vIZ7XFNEV/ge8dD5ZI3D5c
         Ky1IsNUlR6HCYrPrzPKso3RM3HEViU0cFo2w3w0DZL/QuZLpSZOx9atlH5Jsmi0Ms8Vr
         u2AWoTd5OM4H1HJBzbAVpKLc8NupQiOKgBHwOjQ95DBXB8CytUigHuiBI45tM4iuk42Y
         bxPd271XeYNTljj1NAR5ciuWUHZ4qD6eBIS0O6tVRLdGsDXU0GOH+yzvHKWV4kkY+zxV
         HwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JE1ADcc++3Vo3M85Nsq6iA6oMNESnLaCpD2Oim3Sh4w=;
        b=FxSntaL1+JytW4ZXoE0lh48BVpMeUuzlRqi0rfEngKIWE8iA2T7IEQDqMVPx0ZAtiS
         nThE+E7NjYAJMo9Z/rSbZlS33ARhNGAG1rR8WMZ2WX8z++gU1ObhmwFlvguO+drDv4tK
         9bgELOMiTdPWAE1v2P0qwQca5D6BN9gvCgDjZE7JFRKXyu0ZuJp/A9A8uki4NVvSwi3P
         RKyp7QD4AW9srVnVfYbU6v4hP8jNGXlbUtIz/Eb5fTii1Bfm3//baGn3r74U99J128ky
         5av+Sx3oNz4agb9FtoVQCoKhhywu/qiHlClB2m4KaKglHsbf/P1iQHLvtr2mTWKMhYHi
         Ke0A==
X-Gm-Message-State: AGi0PuaIcDvFIeqZf48w7/+/FCkOI4juwV+AbEIZ93eu9rIWJ7ENj8YR
        Ztpk3nM0syHRDLC3k2VYoS3nFw==
X-Google-Smtp-Source: APiQypLUKpU9EiJvK1iecbIeHBOlrvMyuNzM5Gu2fzf4ff9woYknhWdO7VYVk5snGgyndqBMx/wwdg==
X-Received: by 2002:a1c:7d15:: with SMTP id y21mr3195383wmc.57.1588257616098;
        Thu, 30 Apr 2020 07:40:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:15 -0700 (PDT)
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
Subject: [PATCH v6 01/25] mm: Add a PASID field to mm_struct
Date:   Thu, 30 Apr 2020 16:34:00 +0200
Message-Id: <20200430143424.2787566-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some devices can tag their DMA requests with a 20-bit Process Address
Space ID (PASID), allowing them to access multiple address spaces. In
combination with recoverable I/O page faults (for example PCIe PRI),
PASID allows the IOMMU to share page tables with the MMU.

To make sure that a single PASID is allocated for each address space, as
required by Intel ENQCMD, store the PASID in the mm_struct. The IOMMU
driver is in charge of serializing modifications to the PASID field.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
For the field's validity I'm thinking invalid PASID = 0. In ioasid.h we
define INVALID_IOASID as ~0U, but I think we can now change it to 0,
since Intel is now also reserving PASID #0 for Transactions without
PASID and AMD IOMMU uses GIoV for this too.
---
 include/linux/mm_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4aba6c0c2ba80..8db6472758175 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -534,6 +534,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+#ifdef CONFIG_IOMMU_SUPPORT
+		/* Address space ID used by device DMA */
+		unsigned int pasid;
+#endif
 	} __randomize_layout;
 
 	/*
-- 
2.26.2

