Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8298288E73
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389754AbgJIQPw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389761AbgJIQOT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:14:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2673C0613D6
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:14:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r2so9407173yba.7
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KGusc3+RBCNZzwrkW+3708RrOouUa5FTnw8PnBTY3Ig=;
        b=T3uphKT5yiHzmre9bkTK6EvjVmGfnhT7ZFFnV4sLcrb7aMVmDOpxZyPoKPeEcaNKtw
         bLwWcg0u4RVu56DBE1l/EFAJo/HHanmlaklCdVV/xwdWBpRNFhzn+X3/LxWAUfbhp/U/
         GNlO7yw6b8BkEnALpByL0X9MzDTLW7NBXjJemt4oO0kn7GZ7tQAc2izO8jd84Mn+pfZ9
         Q8VycjN+4DsNFujjU1a5crzy/UM0hIFVYyz+EvyZkDNQQ+Ssi6Zd8LRvcNgb7ixFU1dN
         ctSt5By/Q4V+U/wi5Rp7dpEjeliEfwZMggEzSUoN5urCLveVN2ERv75kNnLo9GLtwhM6
         5wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KGusc3+RBCNZzwrkW+3708RrOouUa5FTnw8PnBTY3Ig=;
        b=JQmB+VyQSfEOOF7OL/Ysi9JGvcJ/agY8TWhsdMTmELCFfB2ssjqSpNhh0nF/E3N7Wk
         ENXvKGMwyFjC0DmnfsCdtvEGsq0akevGxSDUMJx7Ceq16ujcoXGOam28GWOu7qhWA/Za
         7V37QjaHMjs+klnHsP/F6PAZenTYGI41h+5aV/wmU0rfmuyulRWwnfvw02cnK5t4K267
         Feb6Lzz4nEjg9zltZEsF6W3PAJEdqqT0o9KIrNIN6lEY5SWthckO7w20o1rcT8HAYHZR
         N+9rK7fZWpH5y23bJmxpfxwKLgkGBcKHCbQIh0S3i4+p75ibUkGkygEKqQrcbMk6cFqF
         hLAw==
X-Gm-Message-State: AOAM531DAr5WUUIDs8iaymUJIWBZIx5jhEGXYw3eq0l/WVlKjTNHUAJk
        1F07ofrxFxA2F3BqNhcWPL0a4o8OYNMTAPBNbck=
X-Google-Smtp-Source: ABdhPJyXF5PEn5u0UASyOtBGN61NWqU4GwvxlOzGlhXJZtvZt0XNABboerQ6XEYrKTpOJFOpPCSvjnoA42FIJ7VzrPg=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:cd05:: with SMTP id
 d5mr18037401ybf.212.1602260058814; Fri, 09 Oct 2020 09:14:18 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:28 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 19/29] scripts/mod: disable LTO for empty.c
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

With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
files. As empty.o is used for probing target properties, disable LTO
for it to produce an object file instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/mod/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 78071681d924..c9e38ad937fd 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
+CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
-- 
2.28.0.1011.ga647a8990f-goog

