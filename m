Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF999350974
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 23:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhCaV2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 17:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhCaV1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 17:27:53 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12C9C061760
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 14:27:52 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g18so2361260qki.15
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qCxq1N1gA7TwxAMFKmL7hLg9EO4lnSukatZLoaD+FFE=;
        b=KeQedqCHSppeGUQMSB3qvddKepeNQHx1p1/VSfzMSylvv0LONVB89TrLW3prq8oZLd
         GBGSMaPvGJnxYeqpyXqf46YXoIA4BadxdCS+/OCujIT/cSSW4RH6HuseJGcAaYs/B2h0
         VPCq2Yot/QxDNIrN078Op8TpVyvUgNLnqtUsZWFs4jkRLeq3QIubrq+hsNm8jw0/sNbu
         x6ydT94rlxQyzBBmMXhSg1nR2cT5jJEpSyTDeTKaFhRS7JORrsdmSYdEe1cmftX7I5J0
         WBiVyhSq+sZPQBRPdqZ0g2ebTLAodY/JCdgVHrXBLyUi190r5xfaOS+yUqmC2AQgYhO3
         ejSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qCxq1N1gA7TwxAMFKmL7hLg9EO4lnSukatZLoaD+FFE=;
        b=oqwkb5tspXyi110gesqDJE8m+ABAtCKCec8hK5NbbqrBgkUIT8Wb+Ck6BVuJ02yflL
         AlAC8TdEmhlo/4xJElqTxmvJaEHDJONbNyqwDDWh/cj9WC/O0OCW8GclM/MOAD2a1gBk
         kKvZ22MPcYHf66MYR0Mxsfc+6aXso4Gqqw9FpJFyJkbz9UfKs2U4tLtlVayvO5UXwJ4L
         QqhJGEm7W47qif656BAXAeSHqIUqe2YQMaB5IRckT/Byg7oz0H/XaG1w614V6MK7jGqJ
         2pKR6CDpVVUZAAesOt9TN9kvAIY7XdLuw6Q2aH0qV+2f8v5OhkuucADOJhuwvauCk778
         kwsQ==
X-Gm-Message-State: AOAM5313mu3wdaFoZRUllh0JG3Yj91XGydZ/7t9KltMR4kL9UshdysAE
        8tYRfdV1wu5yg/mgk1e8ziJGVLa8mp8ogVyM6OA=
X-Google-Smtp-Source: ABdhPJx7XX2KOGLVRiBBOLjdMcWGg8SbFNRL+HOjMTa79TjDOvRh955y/RHVoyp83P6xuYihqrO7IRPK/3G0aLsMx0w=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:b04:: with SMTP id
 u4mr5243055qvj.0.1617226071830; Wed, 31 Mar 2021 14:27:51 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:18 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 14/17] arm64: add __nocfi to functions that jump to a
 physical address
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Disable CFI checking for functions that switch to linear mapping and
make an indirect call to a physical address, since the compiler only
understands virtual addresses and the CFI check for such indirect calls
would always fail.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/kernel/cpu-reset.h        | 8 ++++----
 arch/arm64/kernel/cpufeature.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 386b96400a57..d3cef9133539 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -119,7 +119,7 @@ static inline void cpu_install_idmap(void)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index f3adc574f969..9a7b1262ef17 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -13,10 +13,10 @@
 void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 	unsigned long arg0, unsigned long arg1, unsigned long arg2);
 
-static inline void __noreturn cpu_soft_restart(unsigned long entry,
-					       unsigned long arg0,
-					       unsigned long arg1,
-					       unsigned long arg2)
+static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
+						       unsigned long arg0,
+						       unsigned long arg1,
+						       unsigned long arg2)
 {
 	typeof(__cpu_soft_restart) *restart;
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ac616c59ae92..1cd7877deada 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1446,7 +1446,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static void
+static void __nocfi
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-- 
2.31.0.291.g576ba9dcdaf-goog

