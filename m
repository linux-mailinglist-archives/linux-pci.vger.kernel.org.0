Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED21A869E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391370AbgDNREb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391330AbgDNRE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E62C061A0F
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so13826754wmj.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCsqjS+Tnwu1hr3WMvNuD+P9uXkPM0pVKS2lTlLCiJU=;
        b=po6t4my3Go9g7beq4oi5gBqHe0K8I8gLjjolwSf6g7Inuex/2pKCElDmTw05chnprB
         VpcDmTm9mJndKQ44OUnWiFNGWAnRefKxTsOEpgZkGH6fmib0dAJkrwdNZzEReQlfHRLw
         zmHfO/enRYNLngF50Q/ItNGZfOVNZOP1Wjn1Tm/UzlvI3Aq2ub4XSW6+HyraLp5KrRtN
         gUQ66eIR/V7LC06nJlZF2rLHNx0sFnWE5LcK9o3Z9V83oIkL5irCCS39MKos1xZK1qWT
         MZY9xrqkkCHiVCztI/hzFS5XxD5U/SGIE/6AMMBqlAMbF3wtNCRxo5V2z/5fM3LcFagm
         S0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCsqjS+Tnwu1hr3WMvNuD+P9uXkPM0pVKS2lTlLCiJU=;
        b=XHOsP7iWe6yk/mQj5SBJyEMlvBOmn1x/kDHpmgsTVbaIwNVyvG+MgnUfbAf71M2GP8
         ye4SlP1JR4GayAh8Dgv31+76qr+EkE8QNNoUjxq1qSQDD9JP5i21LxG+pylxVPlgPacN
         hjYMSSnYWp7Cg8ec/MEjpzmDRjeElV/iyx6HTruCBy7/CEEhIAas9KuEoeujPOphcxRm
         vMBsX/bXdjtqMu2qWhPXoRZ91Suhu8c/ArInNx9T8xzCMB6xe0tUhks/wMrkBh+OOB4W
         MNRjfXQ7cfYbN9EE/SFdapxI4RhbK6aqxpSn7fk4Y5qQ3sqhEo7+NgRyqa4Y45q5oTNA
         qrIg==
X-Gm-Message-State: AGi0PuYNgSNk4PCknooDFeAd6CquVeSGnKP1BHCFrsDa2+ARdkRLZa8/
        Bj4LdTujAk1DAMnu9+VP3DZa9g==
X-Google-Smtp-Source: APiQypItrJFyYm1dKZ3R07kVZC02nj/EnEUI4s9HX58/CnIZwkPk4I7z7a9PSJbV36nuH4swD5HWaA==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr814694wmy.30.1586883867167;
        Tue, 14 Apr 2020 10:04:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:26 -0700 (PDT)
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
Subject: [PATCH v5 07/25] arm64: mm: Add asid_gen_match() helper
Date:   Tue, 14 Apr 2020 19:02:35 +0200
Message-Id: <20200414170252.714402-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
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
v4->v5: new
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
2.26.0

