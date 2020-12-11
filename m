Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0B2D7ED8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 19:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389638AbgLKStO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 13:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394097AbgLKSsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 13:48:14 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13443C0619D7
        for <linux-pci@vger.kernel.org>; Fri, 11 Dec 2020 10:46:48 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id t14so5177107plr.15
        for <linux-pci@vger.kernel.org>; Fri, 11 Dec 2020 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=D6dzW9Nv9PxzQobvhFlQDWUjMujzTJKPO9b+q7PtBxA=;
        b=j80QiI4Ul6UgEkfC+jupmsvTxkEELd8wbgUjUZ6N8GZBz3X4UojppIFANKFCwEcr0b
         hjg7atDwt+r6dl376cixss8x61cmNs3p6kdE0NH0HxFb1RFB4vQfxhmnXPW46RXzb3jX
         w/C2Yv2wPOS6QjdjcS5NeKPbqbdp8shMph/o4hHfNZ5sJb5N3Ar0+qPkmusVLmg+5im/
         FXu/NZwu9TMocoPetDYE2QWKb90ZDlr4lbZ3N2VjoMkHvJaSPTfqO5DKNCfYjLKaMtOp
         PjFKT07Sh00XUoerVDLql1CWKexmWjEKEMlFf7a6DuR4Wtg99akEQhhQl7HctgCVr2eD
         quKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D6dzW9Nv9PxzQobvhFlQDWUjMujzTJKPO9b+q7PtBxA=;
        b=ZeIaonoLIU5OdgcKINbQKqfKhu4PqsLIKwVz+A6uBoRAB3ZwC3EP+Z64Nh6DJl1nDx
         ev6pgjjLr3RYBo42gx4/FS/ESrBheCVwF5b+znAI0XKamqhtFgTIuBux1AP+m9qNc6bu
         0tB55HKuYN5QZoh3GACZ34KzBUSyAMlHzdTTqsq3zatx8HYMiNPxUeRituFJQoJWXU/Z
         8jRMHsORVYbYZFFi0bw+2yo4yy5R/cdEcWvrlwB0jb7DmEjfKsj1Y2Q0bNfn5kl4xQSx
         sIeO2n5+FmRMull+UZGwYotXMv/3O7ts6u14z2e9lSod5H9fLEBhzMXZF/NsmlMVQTiV
         DuGA==
X-Gm-Message-State: AOAM530XbIwdhauq2UdBKdaLbMpvJittfl/FQCChB0FWztMKFWjSpmB4
        2wCYh3/LPRQuGjf4BNfQqNZ4kB11zF2WC7LgvJo=
X-Google-Smtp-Source: ABdhPJzTxDOAZu/cl6nSaAjpW3k/LNI+wnG91vRp8xhL+7QirY0I3Vi1skb6ONtaVKsVxERXnDfxMhqkc0oDgftg5yE=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:bb8c:b029:d9:261:5809 with
 SMTP id m12-20020a170902bb8cb02900d902615809mr3908181pls.29.1607712407508;
 Fri, 11 Dec 2020 10:46:47 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:23 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 06/16] kbuild: lto: add a default list of used symbols
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

With CONFIG_LTO_CLANG, LLVM bitcode has not yet been compiled into a
binary when the .mod files are generated, which means they don't yet
contain references to certain symbols that will be present in the final
binaries. This includes intrinsic functions, such as memcpy, memmove,
and memset [1], and stack protector symbols [2]. This change adds a
default symbol list to use with CONFIG_TRIM_UNUSED_KSYMS when Clang's
LTO is used.

[1] https://llvm.org/docs/LangRef.html#standard-c-c-library-intrinsics
[2] https://llvm.org/docs/LangRef.html#llvm-stackprotector-intrinsic

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 init/Kconfig                | 1 +
 scripts/lto-used-symbollist | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 scripts/lto-used-symbollist

diff --git a/init/Kconfig b/init/Kconfig
index 0872a5a2e759..e88c919c1bf1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2297,6 +2297,7 @@ config TRIM_UNUSED_KSYMS
 config UNUSED_KSYMS_WHITELIST
 	string "Whitelist of symbols to keep in ksymtab"
 	depends on TRIM_UNUSED_KSYMS
+	default "scripts/lto-used-symbollist" if LTO_CLANG
 	help
 	  By default, all unused exported symbols will be un-exported from the
 	  build when TRIM_UNUSED_KSYMS is selected.
diff --git a/scripts/lto-used-symbollist b/scripts/lto-used-symbollist
new file mode 100644
index 000000000000..38e7bb9ebaae
--- /dev/null
+++ b/scripts/lto-used-symbollist
@@ -0,0 +1,5 @@
+memcpy
+memmove
+memset
+__stack_chk_fail
+__stack_chk_guard
-- 
2.29.2.576.ga3fc446d84-goog

