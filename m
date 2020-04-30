Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1161BFE9B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgD3Ok1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727915AbgD3Ok0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F93C035494
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so2145336wmj.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oH09lE6EyF+7ddnT7acJ3k+jJHyiqaDtNA7hzb2+sc4=;
        b=DcrvGlQp3aypCcqoN+dkF/d0nkxcpxpMBKeHygdxhq6pA3zd8XZM4QH4aGcjJ/4Tht
         9Tqg6MvR7s2TeMD2dsMqnAePywvLPYenkSK2kqY1aeQ5SP9/rKss1+vPSjAOTqdrBVzC
         3Hk3sNXrPCV4FacRXsy5+JDyySaQuCd99SZEr2yUC/DEQ+NMzYMOHy2AFCct+xzP/4sC
         h8tNesK9eh+4jAyMW+Myo5oIfE7BWYBL5NXT4aV3gr63yJiHIm1CQMdWqcy+2LlMGvC5
         0q2zH9+Bx3SJDZIJOYsGForK5bwlhaFFDJLuGWuknwxC3tkJTHPS6KG3KsC4W4x0HmYe
         /uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oH09lE6EyF+7ddnT7acJ3k+jJHyiqaDtNA7hzb2+sc4=;
        b=Y55VgMALdCXHV76lLixZexu713F6D0hZn88j6ti5bUk7QYIPgWIqoZxLZXA5UUcr+x
         2Nqlblfx/YVptI8LPxGw0Mo2JXlPbsmFEejjW6JoxrbN3Av+oyFcyM1t2sAEM9zxhhsf
         oIsxFQhDEplLD8nFlP5soJcpw+TFYiO206O6jb20BIr7UOPocAGzuBwsTnVo7owl4IG/
         hZz9PNcUQ/6VjHA0EC1ZKjB6Z7ezC8YxZR4OI1sgu0HPmsiURU2YqQQWaN6J24KMX5ZL
         Aegkee5n23RaILQtx7qSodBgw0G/AhvdowdM6yuHDNuYmUl+h2uzLpCGj1y6SHjM8l+3
         IVAg==
X-Gm-Message-State: AGi0PuZqqEKwrEnYtc0Q/yefTzet01SJ9oX+UukPQ6P75RNdlIJZGGt4
        wSs4Lm4lthd0zSe49mu7qcz6Og==
X-Google-Smtp-Source: APiQypK39c6e8iviTZ8YwC7ivNBAH/kpcwBHJCtUr7sjyJdgvl1DlUReTsvBACR1UGiEnN8Ql6GmcA==
X-Received: by 2002:a1c:e302:: with SMTP id a2mr3256603wmh.96.1588257625192;
        Thu, 30 Apr 2020 07:40:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:24 -0700 (PDT)
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
Subject: [PATCH v6 06/25] arm64: mm: Add asid_gen_match() helper
Date:   Thu, 30 Apr 2020 16:34:05 +0200
Message-Id: <20200430143424.2787566-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a macro to check if an ASID is from the current generation, since a
subsequent patch will introduce a third user for this test.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/mm/context.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 9b26f9a88724f..d702d60e64dab 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -92,6 +92,9 @@ static void set_reserved_asid_bits(void)
 		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
 }
 
+#define asid_gen_match(asid) \
+	(!(((asid) ^ atomic64_read(&asid_generation)) >> asid_bits))
+
 static void flush_context(void)
 {
 	int i;
@@ -220,8 +223,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	 *   because atomic RmWs are totally ordered for a given location.
 	 */
 	old_active_asid = atomic64_read(&per_cpu(active_asids, cpu));
-	if (old_active_asid &&
-	    !((asid ^ atomic64_read(&asid_generation)) >> asid_bits) &&
+	if (old_active_asid && asid_gen_match(asid) &&
 	    atomic64_cmpxchg_relaxed(&per_cpu(active_asids, cpu),
 				     old_active_asid, asid))
 		goto switch_mm_fastpath;
@@ -229,7 +231,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
-	if ((asid ^ atomic64_read(&asid_generation)) >> asid_bits) {
+	if (!asid_gen_match(asid)) {
 		asid = new_context(mm);
 		atomic64_set(&mm->context.id, asid);
 	}
-- 
2.26.2

