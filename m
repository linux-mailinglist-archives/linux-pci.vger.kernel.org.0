Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA6928C5D2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 02:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgJMAcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 20:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgJMAcQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 20:32:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA01EC0613D2
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:32:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so17166855ybs.8
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oNoCiComLTOHVg2bP6STufgWA9yaYfJ6ObCLDl+jrho=;
        b=iWb8IMXO138pO3VxQeiLtRHBFKLEZX34wfy/I5tnQOY8tAz+5KN10zF+c5wKc0NGf9
         V81W5t0kz8+T12z9fdWu+sNnGkAeOhHE8X9D+RroweYzMnASv3Hwpkndl/8bioQpHZUz
         mX+LtD994yaPGz2JhGYYCZ77UH77NBl51OSJVt2PNtGh/uJ/Id01J2GrYmku+3i3+EME
         0RSLPnMFIoJMJWfen1rEiGkUdPfD4MN+VkmyC3f7ZHxJqifMISzpW0Ypub7BPOfBxhkE
         v+NEFC6Ds2T1GWHGqFR6HDQWg9+W5tlsLsaS1VukIHrqKwvMN5C/M7+MuFGvKKyjBneT
         I2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oNoCiComLTOHVg2bP6STufgWA9yaYfJ6ObCLDl+jrho=;
        b=Kwww7loeT0q5ifvKe5r8PALtANhWKpwQGHG1KfFlOSXBtCS81QPvGIyXUj8nvr5uYR
         XkJUYN2GWuc3EEakGYkrsvOJxCbaK7YeMDItBJg8Gne9Lv7HgwMh2qaSJSbmxsN4RDGA
         PbRrttetmIkEoZcyjQ5HRdj+YUeQF4efISG69xZj1NWOW2S6xecRSSaRcKUvFkW7/f1J
         hPvploiTyT1VDBoMhD/LD4i+KoUIHCR4Z+SzEPKUBJ4ooeMxDARbPv1/zuVKKI8OriBa
         6YzCI/QIZl5cXseKimClHhpLcxdg9PfTDgNotyRCI6PCFTWzjL9zaMq5HL14WGHuNJxX
         QLFA==
X-Gm-Message-State: AOAM531IZyMJctq9nu+6UK7EYXoJIu140LvFKtSCNajNCHkGx6iRiusV
        /qBaiJhIW2wCvfcNEhJl2fFILCqZXXAHgQXqeA8=
X-Google-Smtp-Source: ABdhPJwwb1BOagS9KB2HJy67TJEwj+dNfREWLJyGXBWcLbfd0WCh9RIc4B6fwHPAmc6V1LYLv5oY+bdj39+DqlbHxJM=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:a4e1:: with SMTP id
 g88mr11556641ybi.267.1602549135037; Mon, 12 Oct 2020 17:32:15 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:43 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 05/25] tracing: add support for objtool mcount
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

This change adds build support for using objtool to generate
__mcount_loc sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile               | 12 ++++++++++--
 kernel/trace/Kconfig   | 13 +++++++++++++
 scripts/Makefile.build |  3 +++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 129001b38357..fda1f8a0b1c7 100644
--- a/Makefile
+++ b/Makefile
@@ -850,6 +850,9 @@ ifdef CONFIG_FTRACE_MCOUNT_USE_CC
     endif
   endif
 endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
+  CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+endif
 ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
   ifdef CONFIG_HAVE_C_RECORDMCOUNT
     BUILD_C_RECORDMCOUNT := y
@@ -1209,11 +1212,16 @@ uapi-asm-generic:
 PHONY += prepare-objtool prepare-resolve_btfids
 prepare-objtool: $(objtool_target)
 ifeq ($(SKIP_STACK_VALIDATION),1)
+objtool-lib-prompt := "please install libelf-dev, libelf-devel or elfutils-libelf-devel"
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
+	@echo "error: Cannot generate __mcount_loc for CONFIG_DYNAMIC_FTRACE=y, $(objtool-lib-prompt)" >&2
+	@false
+endif
 ifdef CONFIG_UNWINDER_ORC
-	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, $(objtool-lib-prompt)" >&2
 	@false
 else
-	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, $(objtool-lib-prompt)" >&2
 endif
 endif
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 927ad004888a..89263210ab26 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -51,6 +51,11 @@ config HAVE_NOP_MCOUNT
 	help
 	  Arch supports the gcc options -pg with -mrecord-mcount and -nop-mcount
 
+config HAVE_OBJTOOL_MCOUNT
+	bool
+	help
+	  Arch supports objtool --mcount
+
 config HAVE_C_RECORDMCOUNT
 	bool
 	help
@@ -605,10 +610,18 @@ config FTRACE_MCOUNT_USE_CC
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	depends on FTRACE_MCOUNT_RECORD
 
+config FTRACE_MCOUNT_USE_OBJTOOL
+	def_bool y
+	depends on HAVE_OBJTOOL_MCOUNT
+	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
+	depends on !FTRACE_MCOUNT_USE_CC
+	depends on FTRACE_MCOUNT_RECORD
+
 config FTRACE_MCOUNT_USE_RECORDMCOUNT
 	def_bool y
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	depends on !FTRACE_MCOUNT_USE_CC
+	depends on !FTRACE_MCOUNT_USE_OBJTOOL
 	depends on FTRACE_MCOUNT_RECORD
 
 config TRACING_MAP
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a4634aae1506..cd4294435fef 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -228,6 +228,9 @@ endif
 ifdef CONFIG_X86_SMAP
   objtool_args += --uaccess
 endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
+  objtool_args += --mcount
+endif
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
-- 
2.28.0.1011.ga647a8990f-goog

