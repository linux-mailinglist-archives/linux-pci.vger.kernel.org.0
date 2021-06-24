Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7A3B349B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhFXRU4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhFXRUr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 13:20:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65552C061766
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 10:18:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q192so5743783pfc.7
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IsTJoDNngEMlkAn/n6JPF2A0qmwgdP70DkZ0WXOjNOY=;
        b=YxZMzszw+nsXLPhGNhV2myye4gK/wRHBlmjreXJlWAVzJm0ZFytYlX9Rhu7tXDdANy
         XP1z9XjdXqim9N+/fnHAr0XwqqNu+9bp2809pZLHqN7ql8Lr5NEoIcZuY3dcG8iAoXf+
         A/rp72coTwhCjbCFAAXwSsCuz5cEkE50kotnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IsTJoDNngEMlkAn/n6JPF2A0qmwgdP70DkZ0WXOjNOY=;
        b=s3e+GvWgC+l3IM+TSbAW7B48sSy0hAMu2jHObEX/4hwRqQ/2qdERqRRyUfAiPd30pO
         pztOfnQJWTzYoWUG33YSv8ukiG9doJtrBIZz50xOtt5vbzP/y6iL7KdtUBWydfoYp9Gt
         T2qSXUwrbwrupOpb2pTxsvlhPYTZa6kB33O2ptabJi7rg8Sc/w1u1PxRo43Ynq5Ki/kx
         vO887c4xiLdFGcK5vk9v49Q3XwznHfgFeByOE6k6hS7fKuFb+ndKGipR0EoICAAehXP1
         PuQj83VDLoK9VbrrsF1y1GAIHwz9z3E0vBpJd6GjaovuK04rX2M1LqM+Gwf1Ag8yMipf
         Vrjw==
X-Gm-Message-State: AOAM533FR43qN0uQUYJfZ/LikoZgJZNbiHkwVohX9syN18w+ptBZuGQe
        qjqjInN2LR5OmzGCXVAwherehQ==
X-Google-Smtp-Source: ABdhPJwajpWmjQoylie1eDc67SDX5JHn0tkLIkBmw0/8N+zayKuUy7HrB9/qTrgy2P3lRFk7RypkmA==
X-Received: by 2002:a63:ee11:: with SMTP id e17mr5579673pgi.323.1624555106903;
        Thu, 24 Jun 2021 10:18:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:fd74:62bc:19e3:a43b])
        by smtp.gmail.com with ESMTPSA id z9sm3365960pfa.2.2021.06.24.10.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:18:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, bhelgaas@google.com
Cc:     john.garry@huawei.com, robdclark@chromium.org,
        quic_c_gdjako@quicinc.com, saravanak@google.com,
        rajatja@google.com, saiprakash.ranjan@codeaurora.org,
        vbadigan@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iommu: Add per-domain strictness and combine with the global default
Date:   Thu, 24 Jun 2021 10:17:57 -0700
Message-Id: <20210624101557.v2.1.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210624171759.4125094-1-dianders@chromium.org>
References: <20210624171759.4125094-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Strictness has the semantic of being a per-domain property. This is
why iommu_get_dma_strict() takes a "struct iommu_domain" as a
parameter. Let's add knowledge to the "struct iommu_domain" so we can
know whether we'd like each domain to be strict.

In this patch nothing sets the per-domain strictness, it just paves
the way for future patches to do so.

Prior to this patch we could only affect strictness at a global
level. We'll still honor the global strictness level if it has been
explicitly set and it's stricter than the one requested per-domain.

NOTE: it's even more obvious that iommu_set_dma_strict() and
iommu_get_dma_strict() are non-symmetric after this change. However,
they have always been asymmetric by design [0].

The function iommu_get_dma_strict() should now make it super obvious
where strictness comes from and who overides who. Though the function
changed a bunch to make the logic clearer, the only two new rules
should be:
* Devices can force strictness for themselves, overriding the cmdline
  "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
* Devices can request non-strictness for themselves, assuming there
  was no cmdline "iommu.strict=1" or a call to
  iommu_set_dma_strict(true).

[0] https://lore.kernel.org/r/a023af85-5060-0a3c-4648-b00f8b8c0430@arm.com/

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch clearly will cause conflicts if John Garry's patches [1]
land before it. It shouldn't be too hard to rebase,
though. Essentially with John's patches it'll be impossible for what's
called `cmdline_dma_strict` in my patch to be "default". It'll
probably make sense to rearrange the logic/names a bit though just to
make things clearer.

[1] https://lore.kernel.org/r/1624016058-189713-1-git-send-email-john.garry@huawei.com/

Changes in v2:
- No longer based on changes adding strictness to "struct device"
- Updated kernel-parameters docs.

 .../admin-guide/kernel-parameters.txt         |  5 ++-
 drivers/iommu/iommu.c                         | 43 +++++++++++++++----
 include/linux/iommu.h                         |  7 +++
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..7675fd79f9a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1995,9 +1995,12 @@
 			  throughput at the cost of reduced device isolation.
 			  Will fall back to strict mode if not supported by
 			  the relevant IOMMU driver.
-			1 - Strict mode (default).
+			1 - Strict mode.
 			  DMA unmap operations invalidate IOMMU hardware TLBs
 			  synchronously.
+			NOTE: if "iommu.strict" is not specified in the command
+			line then it's up to the system to try to determine the
+			proper strictness.
 
 	iommu.passthrough=
 			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..7943d2105b2f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,7 +29,8 @@ static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
 static unsigned int iommu_def_domain_type __read_mostly;
-static bool iommu_dma_strict __read_mostly = true;
+static enum iommu_strictness cmdline_dma_strict __read_mostly;
+static enum iommu_strictness driver_dma_strict __read_mostly;
 static u32 iommu_cmd_line __read_mostly;
 
 struct iommu_group {
@@ -69,7 +70,6 @@ static const char * const iommu_group_resv_type_string[] = {
 };
 
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
-#define IOMMU_CMD_LINE_STRICT		BIT(1)
 
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
@@ -334,27 +334,52 @@ static int __init iommu_set_def_domain_type(char *str)
 }
 early_param("iommu.passthrough", iommu_set_def_domain_type);
 
+static inline enum iommu_strictness bool_to_strictness(bool strict)
+{
+	return strict ? IOMMU_STRICT : IOMMU_NOT_STRICT;
+}
+
 static int __init iommu_dma_setup(char *str)
 {
-	int ret = kstrtobool(str, &iommu_dma_strict);
+	bool strict;
+	int ret = kstrtobool(str, &strict);
 
 	if (!ret)
-		iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
+		cmdline_dma_strict = bool_to_strictness(strict);
 	return ret;
 }
 early_param("iommu.strict", iommu_dma_setup);
 
 void iommu_set_dma_strict(bool strict)
 {
-	if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
-		iommu_dma_strict = strict;
+	/*
+	 * Valid transitions:
+	 * - DEFAULT -> NON_STRICT
+	 * - DEFAULT -> STRICT
+	 * - NON_STRICT -> STRICT
+	 *
+	 * Everything else is ignored.
+	 */
+	if (driver_dma_strict != IOMMU_STRICT)
+		driver_dma_strict = bool_to_strictness(strict);
 }
 
 bool iommu_get_dma_strict(struct iommu_domain *domain)
 {
-	/* only allow lazy flushing for DMA domains */
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		return iommu_dma_strict;
+	/* Non-DMA domains or anyone forcing it to strict makes it strict */
+	if (domain->type != IOMMU_DOMAIN_DMA ||
+	    cmdline_dma_strict == IOMMU_STRICT ||
+	    driver_dma_strict == IOMMU_STRICT ||
+	    domain->strictness == IOMMU_STRICT)
+		return true;
+
+	/* Anyone requesting non-strict (if no forces) makes it non-strict */
+	if (cmdline_dma_strict == IOMMU_NOT_STRICT ||
+	    driver_dma_strict == IOMMU_NOT_STRICT ||
+	    domain->strictness == IOMMU_NOT_STRICT)
+		return false;
+
+	/* Nobody said anything, so it's strict by default */
 	return true;
 }
 EXPORT_SYMBOL_GPL(iommu_get_dma_strict);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..2e172059c931 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -79,8 +79,15 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API)
 
+enum iommu_strictness {
+	IOMMU_DEFAULT_STRICTNESS = 0,	/* zero-init ends up at default */
+	IOMMU_NOT_STRICT,
+	IOMMU_STRICT,
+};
+
 struct iommu_domain {
 	unsigned type;
+	enum iommu_strictness strictness;
 	const struct iommu_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
-- 
2.32.0.93.g670b81a890-goog

