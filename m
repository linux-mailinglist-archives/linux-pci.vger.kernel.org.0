Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B732706A9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 22:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgIRUQx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 16:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIRUPR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 16:15:17 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5DC0613D2
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:16 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o13so6095326qtl.6
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=H5U0Hz5E6z5ldjvQ4xJDZFkCK4qV/McKETGlhtu7sL8=;
        b=mPsAHQEXqvNlGarzu6iBRQPA6ECa8TLJT1//z5ygvSXXqueGgBTsUBMgdhH3MoF60t
         ZhVFIxUiDXEpZ89jhGqvkk+xwepAhB4h8zd+bjJyvbcb5izzUs/Tg/9RldZdUROXbjeI
         BxVX/BdnoiStlDzxH6+NO+6HwWWfNd4qZM0lZORWe65ACPTad8UErkxRWB5rEkhp08DZ
         0KGl75iSGd/JKl1QjNefLbTEyfWqmsoCEu++j8qCHyYi8XPRYhVdpn0nAEZ8fdky4y7y
         S1k0KQu3X95IfiUivguLiKYbpdCh3C48qnuiieKQ7b0xjFzd4Be04GxhMxIhkfZAaqOO
         4wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H5U0Hz5E6z5ldjvQ4xJDZFkCK4qV/McKETGlhtu7sL8=;
        b=faPUckABloQyR/740DxIdaDfmTrriRLyWbd6hUQ4g447fiYzDzgD2exp1WGm52M7Uh
         gwAWOnVY5vnrYhnbZVO3fiW75hoyMxjB2R0ePvEAV9Y19THXKXmhWygbKgB4SYdCZ8MF
         QyhBu+/cmJVGP5juCqyMQ/5QENRBwTHMNBFl9N/FP7YscODA/dnjZjahj+B5wSP1dm14
         wv96k5vbiixnVQ2WWo8o+DnkdjGDvRqy5F+4zt+GzumzpZOZw34CB1fPIR/bMNZCb57a
         MK1AH7CWqW2Oys3QoS4YOjrCXUpwjPjuv/Wa0kTUs1QCEdpmgr8JVyhnGQ74rh7udxuP
         bEwQ==
X-Gm-Message-State: AOAM533+qFpdijGhYNkQTIVtsKidoP1LSXtk2YjQ9q5shFnHJbLC/oHR
        lkBA+HZkb/7h4Ewzzz5xUD7UUzigxZsjh6lSH/c=
X-Google-Smtp-Source: ABdhPJw8z6vjGGaGGnrlRrziyohZvVfic1DZGt/qPzbkK2DflW6NVM+pA6gyTB+Ke9wzzcJbF1DtstV10V20omnh/NQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:47cc:: with SMTP id
 p12mr34218336qvw.25.1600460116095; Fri, 18 Sep 2020 13:15:16 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:22 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 16/30] kbuild: lto: remove duplicate dependencies from .mod files
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

With LTO, llvm-nm prints out symbols for each archive member
separately, which results in a lot of duplicate dependencies in the
.mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
consists of several compilation units, the output can exceed the
default xargs command size limit and split the dependency list to
multiple lines, which results in used symbols getting trimmed.

This change removes duplicate dependencies, which will reduce the
probability of this happening and makes .mod files smaller and
easier to read.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 541dbe791743..b417c697536e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -266,7 +266,7 @@ endef
 
 # List module undefined symbols (or empty line if not enabled)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
+cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
 else
 cmd_undef_syms = echo
 endif
-- 
2.28.0.681.g6f77f65b4e-goog

