Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C763382D5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 01:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhCLAuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 19:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhCLAtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 19:49:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACAEC061764
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 16:49:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l10so27943654ybt.6
        for <linux-pci@vger.kernel.org>; Thu, 11 Mar 2021 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eVg8vl10pGhZATEe8NsVYg7Kd17QQeycMW9hWkCSduA=;
        b=kyQtb3I3rc9TSuC2cxTz2C1YlBmrkTQV5dwi1pvkgdcdyUXvJ8NWwVWkySMOppsl0r
         7Ebi3bJggo2awzyTl8v2jnzGO3eNbmLHFVfQGjuXi7DmeXR1FRQPGoRuEcglDDxoraSq
         2RYyGTmHP98Lkg1gSS523QqU4SVdR50sSJi6HjFNxxLertF6R8pGeM5oC77VlTRL12e9
         ZojwblBpPRXYgf9wG6uQqW0mDgZJz9+gH73Sis/QFPI9uu38/0LPoMXbGXlvL7l+gzp2
         LM1k2aKG0YLfpIinhXuCnKfgq//yuI/16rGczqLlynMz+OAkgOXVxySEUyZxwpsgOZ5g
         WRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eVg8vl10pGhZATEe8NsVYg7Kd17QQeycMW9hWkCSduA=;
        b=mqgrPAuB3NmmWXwIIDXIEus7PfRYKsKU8dHJtOB0GFuj+SpxTV+WYFfnFH3VkydQr0
         nren/CboBRQfW22JLk8Y6Vpz1YWByJE7oyB6LipTuoTj8Eqn3AizoycLQ6nYqeCGHt7W
         qfxECyewPTONYANbVH+iKMxBNAgfPH4JSY5SE1LHrl6ZfcnjxR4g0AVHnKZCD6l1jMsB
         jMG6LsM3A4xWFM0pI3qbEs/rv2bKb5IlVFSJNtVZdQOeJ65288yxFo7ZI9hAocSsjUBQ
         laN0bgf8B6ZINI407WrdPUSEyzBouZWxD8ILD87RgcGzii5kyQdz3uyXomMVfsKH6MBm
         w3NA==
X-Gm-Message-State: AOAM533YmTGt+XKy9BVn+umw+ktFJMzrn9sbKzWxSc3Es1BS7SMufxof
        PrhEGLWlhcjnbGGYwKisvbHySqJWa0BWpGhOIM4=
X-Google-Smtp-Source: ABdhPJyZsq8vD5R6s7oQubStKKH2K4yfXhgsnX0oBymukjYIwpGAmV9Sz9M36DvLDxSjeX5HhrB6Lytsz5f3Ik6Kfz4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:a25:d296:: with SMTP id
 j144mr15661072ybg.33.1615510187789; Thu, 11 Mar 2021 16:49:47 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:16 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 14/17] arm64: add __nocfi to functions that jump to a physical address
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/kernel/cpu-reset.h        | 8 ++++----
 arch/arm64/kernel/cpufeature.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 519d535532be..27f3797baa2e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -136,7 +136,7 @@ static inline void cpu_install_idmap(void)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index dfba8cf921e5..a05bda363272 100644
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
index 7ec1c2ccdc0b..473212ff4d70 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1443,7 +1443,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static void
+static void __nocfi
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-- 
2.31.0.rc2.261.g7f71774620-goog

