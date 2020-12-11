Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD52D7EA8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 19:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436850AbgLKStd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 13:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389233AbgLKSsw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 13:48:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45147C0610F2
        for <linux-pci@vger.kernel.org>; Fri, 11 Dec 2020 10:47:04 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m203so11802083ybf.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Dec 2020 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=D9wH7plBpsyKB7z0MJo6lESfcO9at50jK7OVp+0NdAo=;
        b=o9YQ2WaCNG8K0/fs9UJt8tjJkZt2V+zu8nGyyzGv31aRlZwzdERkcEEzcsjJzK7Khh
         Fk/jL/s8l2hJliwPNQGXJKzeEfZAhZNL3N7YQubgkjL3MBt3ZaOHRNJKHKyKgl7rzP3r
         CbLCHOiTVvpx23P8dNWk0S8pTKQys5/iAUXEqkbZkIdXP67EvijrZ7suaxN5SM1AiGUg
         Czctp/iCgtSTfOnV6MNPNWCT9Gw6yx2WXcKk+pz2gFHpPVleQlFs2WHsbthps4QXwlxm
         5FQuFyoHqaAxpIDOc7NISukhUKz44T2F+pYRZntubJg1eb5X5qyK7NUJ7/Bfmj3XKKx9
         8T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D9wH7plBpsyKB7z0MJo6lESfcO9at50jK7OVp+0NdAo=;
        b=Wl3DlyO1SHY15Pw5slTL6d93UP9xC8bUsznLpz172Oj9OI4NmpkbfC1cZ7TWQfcHrS
         dewZS3eDwgj+rR2gBQlsh3Mknru6n+JfbdtoLCWhTor/hY0wORk9ILM3sTMJha+8hAwj
         /logESBK1C2o+7BD3LHvBUR7FuQOd6e8NivPxxFYj+u9oKh1J9cD7A2jt7fTTgQfxohg
         I2PwNb9ZuyvtiFIgrjW9ZWlMlmOuVhjap7iaKfJCwIdVxHievE9GYXtIPXy0DP45f262
         o/Hu2RS46YsfPOH2fWEOeAwSagJxNpA3FODs7i4HcCNsq2ooIli/e7NHlTlrsNLa8/zg
         4E4Q==
X-Gm-Message-State: AOAM533SiOOQk3W+ubhtEhpdLH5VhUXNFZI5QVjG6+tH057SBcHpBeM2
        HgrHE7/5cUQM4eM6HW2J4Oe7jWv7BaBwQCy+8z4=
X-Google-Smtp-Source: ABdhPJznzuiVO4idqxJMtdzoCHbXvL/GitFw7UhsVnJ6x3E9oWq6Kdg+IUkD+jO4kIRIFWgi1U7nyXaq6VyburgAblw=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:6405:: with SMTP id
 y5mr12176868ybb.328.1607712423523; Fri, 11 Dec 2020 10:47:03 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:31 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 14/16] arm64: vdso: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
point in using link-time optimization for the small amount of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index d65f52264aba..50fe49fb4d95 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -30,7 +30,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
+				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.29.2.576.ga3fc446d84-goog

