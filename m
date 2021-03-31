Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D711350970
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 23:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhCaV23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 17:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhCaV1t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 17:27:49 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDC8C061762
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 14:27:48 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c7so2369236qka.6
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RWJ9aQhTl20nw/R5RXPJl7NDj1C/UnL5LrldsenTslw=;
        b=OI2BXN7KaQv0FSebUTwCneDYkgM3EAclc0LW8tfWF13e9tAHbT6S7IOhSWAvQZLEnM
         JINs3HBpLvp6Qvodp3XPXwpa2AY4B6TKaD777pUzRWtoTAYeD1ocUHZu2HycU4zx1Kmv
         TNPKwT23uSIbpB+4L8uGbr3k4clT4tWUBKmb6FlOF1Rr6P3NPk9yRjsBi/8/WqNqXQ91
         l8FNow8wvarKsgb5E8LUZNePMtfEnTyG4gLYP5Kv+xRbrPTbyVM2AH1BrU969hKl7202
         it/AECGlU/1SsjxKqzkPukkeE7jMpt1aJJc+o2/Ob3guLAV3RI2sN0Iy2pgsPxnRnjo4
         2KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RWJ9aQhTl20nw/R5RXPJl7NDj1C/UnL5LrldsenTslw=;
        b=LKLHvUUYeWYmf3C1oftNI6ARUry28JbXnfDbBA3fAgSikYVzuoeL77pH7JfuTZDVOi
         8HrxZNCTaVN5bNHYiT2pV0770yKZKZ5PqJd40WCPD/mwGaO0/nzsbS71kdBek6LR7AOM
         tP4N0MCd8rQMVFyrdLMi1Rl8NFr+roirZIxhmnJj26Ln7HfUlYjQWFC0jpkfqz0jD4Y6
         xDMbZFPZ1Y92+O5B4gYAlmnJUN9yNZ5ZqTwjJYIxDQ6u4I2Tbjlc+LMJdu6NoCa+fuki
         Efl0AWSauSDhxVMKemw4gA57gjGNhFtSSvtkD/lI+cPgNGjYmLbRDv+mPxyZM/4pMgRU
         f1ZQ==
X-Gm-Message-State: AOAM531D+TXM1oUegRzzAV/8EEzPkn1hi+QdiMdgN6somvH1uuiFVkbT
        FW7l6cj55+8SWRWN7A0Hs28rzK9O6qGIPESelbw=
X-Google-Smtp-Source: ABdhPJwgeYfpiU4TaL+sNYk8JQhgUoPaRCwg5+9HCoLujfPlRhTT1jZ0jK2Sqbbps882JdAhQwjOAlmdak1l08CL8Lw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b410:: with SMTP id
 u16mr5255799qve.8.1617226067444; Wed, 31 Mar 2021 14:27:47 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:16 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 12/17] arm64: implement function_nocfi
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

With CONFIG_CFI_CLANG, the compiler replaces function addresses in
instrumented C code with jump table addresses. This change implements
the function_nocfi() macro, which returns the actual function address
instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/memory.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0aabc3be9a75..b55410afd3d1 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -321,6 +321,21 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x) ({						\
+	void *addr;							\
+	asm("adrp %0, " __stringify(x) "\n\t"				\
+	    "add  %0, %0, :lo12:" __stringify(x) : "=r" (addr));	\
+	addr;								\
+})
+#endif
+
 /*
  *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(x)	indicates whether a virtual address is valid
-- 
2.31.0.291.g576ba9dcdaf-goog

