Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC21D9E6D
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgESSBu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgESSBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:01:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA772C08C5C3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s8so379422wrt.9
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wblWsf3gxbDp6PSj/ehcYDd+oP1x7SYe4Bh2SWvMsGw=;
        b=SVXeb2Ob4Qkst7O5mL6UJ2iL9TD8FeQw9vSwN576mogif6BcdDk/DVx3V2M7dI6n21
         cDlB4PgyVw/zWEvawRrLAkk8d7OsM7cAfcUCgb++qPIGOWWFGKIqdCOmLwUmcPpIc1DM
         nP4/NYwjGzU0cZQa1VFg9eXlqA5QFsvshmZ8mLhFDLun84zEb+yVsdQt288r7v2A6o14
         TEfy1o2q/7e8nwZFntyVfD0p19BG2lWIz/U0rwseBJSSfNFTvIJaoIbYbNDXz+jUT31H
         RPGF0E7utbNt/zM+SiQI1i5jIw+y8XFEsPo89fPClJIpEvylAxB4p0fHyzmt/juXQ9nx
         X/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wblWsf3gxbDp6PSj/ehcYDd+oP1x7SYe4Bh2SWvMsGw=;
        b=TZyeo0XY+syR2EIS9yNpn4daOeA1CgP/EYllpucfiv5iR9sHA26AwX6cuUOEbfHjZt
         GHwXgktVm+SJgMpqsjJDzPkxz5k6fRsm5zgM4fZDoxsPX7imLErPHgGCqTW3JlfU3eaG
         btW76vqayJpeeZ8EOnZIqRSNyalQPS0Lp5EV6BoNiJ9zmZLUup3Gmgk4lPGZemO/D3di
         h6+7nlJNPnwUVBQuUIyRgAHNS/OgFbb2/no+L3tbRRZaqKMF9NvAj4xtK8wSgdwDZBEN
         Qnr4a8dt/+gbht0xF/YCZC9c8kwJW5kaUkNZwEvdX/TjKAiFttDQGoTWFQpMqGfWAixi
         NV3A==
X-Gm-Message-State: AOAM531GF/v/Zy47nO83u9z4IUiCX7yzmosHXRxY0WOGMCZYT5BCq1jT
        SxVZ3wlJbZ/RwlcstULz67gYgw==
X-Google-Smtp-Source: ABdhPJwQ7epxyLS6UnZ7f06nlDOMCJUnPMBSTjmWHDJI9x8Mwvumsd4wHmMVikP6f8C+lMs+dd9rLA==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr107787wrt.286.1589911307392;
        Tue, 19 May 2020 11:01:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:01:46 -0700 (PDT)
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
Subject: [PATCH v7 05/24] arm64: mm: Add asid_gen_match() helper
Date:   Tue, 19 May 2020 19:54:43 +0200
Message-Id: <20200519175502.2504091-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
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
index 9b26f9a88724..d702d60e64da 100644
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

