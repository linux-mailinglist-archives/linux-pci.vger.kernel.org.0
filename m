Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7995C25CAD4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 22:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgICUff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgICUcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 16:32:12 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5D7C0619D1
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 13:31:24 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c5so2915081qtd.12
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cFYZU8yCmBPQlyxKhbN3fBJPGbsM547TbMqCUcHgNNs=;
        b=f2KZmcgYz5Ysbx7BF62rI5UJWOS12FN6N90Amy8wNR+g9fWhhBQkZa5CaKf0dS8brC
         6Ro6z+jEQSCS3MWX0kosxP4fsqH2/+671H0FR2hgia8WGh2l9J0fRbxn4fS9LBIOcqsn
         cfg+hzRqGFg//tgcGlbiaDXIBOoDoqEGBJdWHQyzr3ofan4aBNcv3L8cSwT1RQT4lXSp
         Mo1JKD3ynQ9gHpI/aTI54CwV746sFqsVOEhvOjmNc4OgLhewoJ13I5Y1xKy5epce9McN
         +zMfVllNIuAdNq+xsrw+qbjhr6JPUJISf6N/sMIEsTKdrYvLhzy1RmEG8RGpVVXx5zt0
         mdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cFYZU8yCmBPQlyxKhbN3fBJPGbsM547TbMqCUcHgNNs=;
        b=tZu0YRa7x/bawwOSCvzPm7iBJcj7NYgMd5m2r/ez7Jm2vqK/X2ohvwuHdVzekgJ+et
         /Llru5TtQVzuSnOjxs6cs3mExUHkmHSjwpVdyEWX+67lu2WbD1LSHBnR7S5fG8dWh1mS
         Ec+oG0F1Yr0NfyTLOfG76NgkskrdLm3SXnIc+ez4qGM2z5jh6PcnbSLE0wrBqk36XgMu
         UfmBrP74YyEAEEA9x/WoW9NYyXT8KWcc2/QPUFraXXeJ1I5NYXfKs6VqVjh5FRVLH7XH
         zMlXL1UgBto3hswDyYW3RA9dApvEkVtwkkl2JnGItbFF0eCWTnbX3R5KLoJCITXqLNn3
         7++Q==
X-Gm-Message-State: AOAM5303MYv4/BqUnn63UuaghTYXGMEjKhY3UjHr8JBzYjyC2jcSCo7B
        X7bAmmI6rHQ+TPN77u82qXjx0lryP8tnlgmKBSk=
X-Google-Smtp-Source: ABdhPJyzhYZs0Vph1w8I/Ma5DB61AQsRFG4mGPB5xTJWndGiIvzc18vAFQNXB2O/jZWPV1Ikufh2xpTXWWNkBkMFMaI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:ba8e:: with SMTP id
 x14mr4773039qvf.23.1599165083400; Thu, 03 Sep 2020 13:31:23 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:39 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 14/28] kbuild: lto: remove duplicate dependencies from .mod files
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
Sender: linux-pci-owner@vger.kernel.org
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
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index b8f1f0d65a73..3bb36b4b853c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -286,7 +286,7 @@ endef
 
 # List module undefined symbols (or empty line if not enabled)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
+cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
 else
 cmd_undef_syms = echo
 endif
-- 
2.28.0.402.g5ffc5be6b7-goog

