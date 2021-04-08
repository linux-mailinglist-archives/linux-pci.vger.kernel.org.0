Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FB6358C88
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 20:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhDHSax (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 14:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhDHSaT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 14:30:19 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A12CC0613BC
        for <linux-pci@vger.kernel.org>; Thu,  8 Apr 2021 11:29:13 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id v22so1624429qtk.11
        for <linux-pci@vger.kernel.org>; Thu, 08 Apr 2021 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aJ78CQ4sSObE7h7fKH9+1A4v2ZQnllJDRyYlzc3oTAI=;
        b=MHjorWaA9cqvjCV1vLFpiSODDJWp3DQrVr2AHYq3txbWEysIHt9DUSzoMYUvoFyANG
         E2C705jG2SEZGcLkMefsBeVjl3wLzBqgwpD053sTrvgwghJfmLhARQ/Y9cAOH4zTIRgg
         Gx1r77cLJDEb9EOhk+dsk/h50X+ReYAXEPVNzcfFL5m5rUHdBidHwgD67eM3rDMgIwa+
         mVr2AN3P4KLVWVDm23HpWWvGdT4AwMifN6Qxcedd+js8rkQe2M3PR+szlpqn3xw98X3j
         tyShTpdkqo9lSd6l7hHO0TlARnATWf7l1D7Ome4WRCmkgOycQrmmZ+SFbWSvpnm8v6Ov
         qLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aJ78CQ4sSObE7h7fKH9+1A4v2ZQnllJDRyYlzc3oTAI=;
        b=iX7+g/jGSAXX/ObRnCxWGrTflBGOFvtcfKb2yhobhRKk9geRm2UJKolspIi1/2wTkp
         moVlT5tzekZsiCU2LaLFxds7IBXGCIKrq+d6/mbWGgXMdfmfTz1vQNQ0M9UaS+YAdPs0
         2kgqIU6k7jxu4OGQlC9drlZJjYHIPI5YK3k16RRtnk6hCOfudaHKFfuywQGQuxYa1o8g
         C563QMMzvYBaNupG8YB8YgK0VmOEbN9Kz25u8evt/77bL67GzUks2kiK104yJKOAiiWT
         e2ELL9LWTuq7LRu2AKHI4ho+5WMcxLE/Hbx3H3o0/fojbi3CavtLYznhALOSU8Av4pJY
         MNIg==
X-Gm-Message-State: AOAM5302avbzucZCrp1na0f/1gUA8VkwLUX5DcdMvaTu8Q3NJhLfRyHK
        KaqQ13jgxkrT3v+ckhRukxc6F7GqpHaOAWaIF60=
X-Google-Smtp-Source: ABdhPJzwVTQdAK5UkhD1PnR2Qb9dWptcs9iybmVqXLD+eWKEqS2UHPDLF0diVVB2LF9LH4/E2DAQ5mXPMjPNEy9u9ic=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e3d0:: with SMTP id
 e16mr9980885qvl.1.1617906552307; Thu, 08 Apr 2021 11:29:12 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:39 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 14/18] arm64: add __nocfi to functions that jump to a
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
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
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
Tested-by: Nathan Chancellor <nathan@kernel.org>
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
index 0b2e0d7b13ec..c2f94a5206e0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1445,7 +1445,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static void
+static void __nocfi
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-- 
2.31.1.295.g9ea45b61b8-goog

