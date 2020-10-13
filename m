Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4CA28C640
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 02:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgJMAe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 20:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgJMAdl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 20:33:41 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426EFC0613D7
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:33:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id j185so2440238qkf.7
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NB4DqWz6+fIfMXcokXEeMggmgfFph8OJ/Hk6TSxy9cU=;
        b=H1F377i8eGQAU/5A0yi1yr0c33hGgdU8XEV9saDmRDeYR0tkVsNxEXUclpv1KfQaU0
         /n56cozTapbGtfIzzZr2zkFu0QiAzdA/2U4pijKUqmCNtwJLZOHMOhyYpo/RVj3+a9up
         uw03RRjDJUEA07AI3ycjej51uqULrxQxMDVvJUyMWGW9h09GHasuDmPYx3/m4etV9s4F
         /8ifejQyz9wBUEc+H89uj/k7/XI3IN0cqCEm+8nY+wRoA6LNkaf8a9R7Z2OdYi/ddy5V
         vh/iycwgiqqL8SNRUxcnX4VZEMdDFUCQ+T9Ak4gRDlRzIex36WiXpUQpVsXw+Sm3BVXa
         op1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NB4DqWz6+fIfMXcokXEeMggmgfFph8OJ/Hk6TSxy9cU=;
        b=OdazqfrwWpZduxd1ZYSiCj0QZJqEMJYSANkPDuPdVBtQxMzTU8qJeCV3u2GWoWFCER
         IT0ZF3FAYXTqX5JvAMZmuwpqyI/MLXrig1ZEEuG//P5ZWAMw4SgO6CgxfT6IEsksFIu8
         qOboB68Wg0MS8P4vi/EqVics+JDLR/8O7/Tkez/nmx1S7SOea7MwkfsZvw+5A94WIDix
         T7ZQ0WfXDJMAVRlFkfETDHHWx9v8brYJskCVrFMr2XVckvXxaWgq5laVS9EtJbURp2JN
         Vs1OfYEviJ3kJM0oNbSH9oL9kMmgoLt/1FwxSRj7zs3xTYz2xo3eUMHWufuacTvmjh23
         ooiQ==
X-Gm-Message-State: AOAM530zZd7EysZu5oJ9GCCzd6j0Ua8EIanlgutw5DIU6tLKczQQT662
        b08bluOdhktQPOyQHxNxdDEMK/wHDHPFU/nj3zI=
X-Google-Smtp-Source: ABdhPJwqkp+cAjUgpQ/a4zy6+yRRoWJAx7zl3+DhKe/ksIEW9MuPzDjzs69jj4tiiYYaOThbc4htLgXeM88lIlTIveg=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:59cf:: with SMTP id
 el15mr14045430qvb.17.1602549181397; Mon, 12 Oct 2020 17:33:01 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:32:03 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-26-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 25/25] x86, build: allow LTO_CLANG and THINLTO to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

Pass code model and stack alignment to the linker as these are
not stored in LLVM bitcode, and allow both CONFIG_LTO_CLANG and
CONFIG_THINLTO to be selected.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig  | 2 ++
 arch/x86/Makefile | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6d67646153bc..c579d7000b67 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -92,6 +92,8 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+	select ARCH_SUPPORTS_LTO_CLANG		if X86_64
+	select ARCH_SUPPORTS_THINLTO		if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 154259f18b8b..774a7debb27c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -173,6 +173,11 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
 endif
 
+ifdef CONFIG_LTO_CLANG
+KBUILD_LDFLAGS	+= -plugin-opt=-code-model=kernel \
+		   -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
+endif
+
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
-- 
2.28.0.1011.ga647a8990f-goog

