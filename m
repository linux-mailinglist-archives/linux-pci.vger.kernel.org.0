Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF95C288E49
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbgJIQPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389828AbgJIQOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:14:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA764C0613BB
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:14:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z3so3504299yba.21
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eOx9MhffeJ9wDXWdE5ocpTXQ8u7ymKHm7bpeM0Lggio=;
        b=Plxh6rO8fZsaoEQYUiFTv8Gctd0ORGzpZ7B+rZvfUdc7hYRYEfwwGuB/jOOB4N8mRZ
         iAAD+kQylOB8+xnUsPp1FuxiMJFvWDb9+nHFjKZSUxLvWnE/9FbEqxjRwOpDx5ONEslI
         8qXKafYcstPuDgNqimTWoairPVZO2J3rswrWaBPN8Qj/9SVTW+SDOPJ/1LdMPf3bODQ3
         tIT8O2Z6HcQ4IP/C1bLPAj4juZIAgQDUFSX0gtccixqyP1Lwa6S3qb2MSbgtHQfAoxEv
         QRJywRQXLDBTL6z66phNxnXE5ujjd1RTPx5601HvsGfueNCH/Cf7DS82U8ob3oCEPZMJ
         O6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eOx9MhffeJ9wDXWdE5ocpTXQ8u7ymKHm7bpeM0Lggio=;
        b=qX6RiFh4xWV8SIbRsmHbgRRLRlESG4Tas4kN2/G/e7J9vZsMKt4bfXdN5x3d4uy85S
         r18MQylQAwsnp7fX9BgS3iQw7ZlP6EJeLot38qvUpGXqJa2YbNvK/GBtIH+vw8Qx5xKh
         2mBeOgPhU8OcUG8Q3T5ClJAr+70GWX37gsXVHI2nJr5FBeniuRDpOipNzFeKZIjYGfi2
         OprcbGlZYBAAtzv0AKvSemoqeBkyBKOO4UhFoTTKcPR9wzmsun/MQZXKCQHYDj7R/C25
         ocNTZaQqQQHKhryLqgSt6Pp+OB0fPcFUqrjJi9KR8tBK6wi+Lzokw42O1g+O5SZAw4R4
         su/g==
X-Gm-Message-State: AOAM531kW0PWxM6s+Vr1RPEciQZYzq626uE6ZaXLVt+PTvS7qyGOpCEh
        I8xqWxW9IOyNM39TapilidJ0j7wKlXVLxMncJlA=
X-Google-Smtp-Source: ABdhPJxyS0XHBxv62ZqOUe+ZCIUsnixCIBFhk+Syvlgu7UF8/267koanykdI+IOKX/T5PRLdfssp5bIj1Kz2wguq10U=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:8209:: with SMTP id
 q9mr19033461ybk.353.1602260072154; Fri, 09 Oct 2020 09:14:32 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:35 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-27-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 26/29] x86/asm: annotate indirect jumps
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Running objtool --vmlinux --duplicate on vmlinux.o produces a few
warnings about indirect jumps with retpoline:

  vmlinux.o: warning: objtool: wakeup_long64()+0x61: indirect jump
  found in RETPOLINE build
  ...

This change adds ANNOTATE_RETPOLINE_SAFE annotations to the jumps
in assembly code to stop the warnings.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/acpi/wakeup_64.S  | 2 ++
 arch/x86/platform/pvh/head.S      | 2 ++
 arch/x86/power/hibernate_asm_64.S | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index c8daa92f38dc..041e79c4e195 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -7,6 +7,7 @@
 #include <asm/msr.h>
 #include <asm/asm-offsets.h>
 #include <asm/frame.h>
+#include <asm/nospec-branch.h>
 
 # Copyright 2003 Pavel Machek <pavel@suse.cz
 
@@ -39,6 +40,7 @@ SYM_FUNC_START(wakeup_long64)
 	movq	saved_rbp, %rbp
 
 	movq	saved_rip, %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 SYM_FUNC_END(wakeup_long64)
 
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 43b4d864817e..640b79cc64b8 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -15,6 +15,7 @@
 #include <asm/asm.h>
 #include <asm/boot.h>
 #include <asm/processor-flags.h>
+#include <asm/nospec-branch.h>
 #include <asm/msr.h>
 #include <xen/interface/elfnote.h>
 
@@ -105,6 +106,7 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi
 	mov $_pa(startup_64), %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp *%rax
 
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 7918b8415f13..715509d94fa3 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -21,6 +21,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
 #include <asm/frame.h>
+#include <asm/nospec-branch.h>
 
 SYM_FUNC_START(swsusp_arch_suspend)
 	movq	$saved_context, %rax
@@ -66,6 +67,7 @@ SYM_CODE_START(restore_image)
 
 	/* jump to relocated restore code */
 	movq	relocated_restore_code(%rip), %rcx
+	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%rcx
 SYM_CODE_END(restore_image)
 
@@ -97,6 +99,7 @@ SYM_CODE_START(core_restore_code)
 
 .Ldone:
 	/* jump to the restore_registers address from the image header */
+	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%r8
 SYM_CODE_END(core_restore_code)
 
-- 
2.28.0.1011.ga647a8990f-goog

