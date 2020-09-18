Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D01E27068C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 22:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIRUQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 16:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgIRUPb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 16:15:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51941C0613E1
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u35so854361ybd.13
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8lEX8dhcXccIUepNU1SEoCt6plyxV6wLvpdFoemo79Y=;
        b=bUS9jAgi/132eC2JXmXVaOGX5cLLbckvGufmxI44RyqSyijqoxymHFZKHTY4QKqUWn
         JZzyyQQyPOeyAB7WnMYxNQTmxtjglzkhrl8ulRLEEbjVlwVzF7diBx2otZU49x2IXBy2
         co+YT2lrE8KpeesfRNW8cKsLLM86m2CFK0eSmAsAPXufo+5rYg3FA9kBPohZ1NgV0EaA
         LnZfw6PALKKAclvHbVHc9MptSA4aLLvKdW6gApRLHVah/9fPGksyPaQZL+IPWMQyzoOB
         rrqLl29+OU1RGaoeD9FR2Vyb0aLYQDqH9OpyYwmNpW2e2QBA+p1vmSjIEg0en7V4iK0R
         OhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8lEX8dhcXccIUepNU1SEoCt6plyxV6wLvpdFoemo79Y=;
        b=g3txr9Yh63UUSFXw58lPJY4nOjW7mNqY7plKrfPkF/jL9i8MsNswRH7I0+3mkR87L0
         /w748pjciQD63LjfZCAOLbGH4oBWMrh1wtWEihKQe1rhgxGyqUBIQm+s4SQyzeY697IF
         zZch59/NqUZhlwHZMXyF4XthYn6cS+5S+VtoTtrhi+JYPhtEUXdIbCfKtpn4Mqk8v31t
         Sif1qV5UMh0uxqfFmKW8H+ObN3EFWUv7ISahgcXvLxoz6fSuMaPwrpt6GyqfebdGBe4n
         1leYYaSCwbyZ8Kb/oFvHVW5lE/cCO5S4QQMzGDUiHjWu1nft24T54KDJf29ss1787kUa
         0jlw==
X-Gm-Message-State: AOAM531V7gMxD9cxTzKpAOsu3mfDmUpBe852M2vtftsXm3YZV+WIjPMJ
        1WdasPY+zIFMMJjoe0ISApNWwVHsLcyiwQuQIeM=
X-Google-Smtp-Source: ABdhPJxvjx1bmj7Cp0aVz2H1UJR3LkO2WNClVAnJIbW9tZ58+17Ee06aPFUwJNBWfpBxBWpNmGts9z7gqVsMYgq1pT4=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:cf13:: with SMTP id
 f19mr8568269ybg.386.1600460126530; Fri, 18 Sep 2020 13:15:26 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:26 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 20/30] modpost: lto: strip .lto from module names
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

With LTO, everything is compiled into LLVM bitcode, so we have to link
each module into native code before modpost. Kbuild uses the .lto.o
suffix for these files, which also ends up in module information. This
change strips the unnecessary .lto suffix from the module name.

Suggested-by: Bill Wendling <morbo@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/mod/modpost.c    | 16 +++++++---------
 scripts/mod/modpost.h    |  9 +++++++++
 scripts/mod/sumversion.c |  6 +++++-
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 69341b36f271..5a329df55cc3 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -17,7 +17,6 @@
 #include <ctype.h>
 #include <string.h>
 #include <limits.h>
-#include <stdbool.h>
 #include <errno.h>
 #include "modpost.h"
 #include "../../include/linux/license.h"
@@ -80,14 +79,6 @@ modpost_log(enum loglevel loglevel, const char *fmt, ...)
 		exit(1);
 }
 
-static inline bool strends(const char *str, const char *postfix)
-{
-	if (strlen(str) < strlen(postfix))
-		return false;
-
-	return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
-}
-
 void *do_nofail(void *ptr, const char *expr)
 {
 	if (!ptr)
@@ -1984,6 +1975,10 @@ static char *remove_dot(char *s)
 		size_t m = strspn(s + n + 1, "0123456789");
 		if (m && (s[n + m] == '.' || s[n + m] == 0))
 			s[n] = 0;
+
+		/* strip trailing .lto */
+		if (strends(s, ".lto"))
+			s[strlen(s) - 4] = '\0';
 	}
 	return s;
 }
@@ -2007,6 +2002,9 @@ static void read_symbols(const char *modname)
 		/* strip trailing .o */
 		tmp = NOFAIL(strdup(modname));
 		tmp[strlen(tmp) - 2] = '\0';
+		/* strip trailing .lto */
+		if (strends(tmp, ".lto"))
+			tmp[strlen(tmp) - 4] = '\0';
 		mod = new_module(tmp);
 		free(tmp);
 	}
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 3aa052722233..fab30d201f9e 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -2,6 +2,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -180,6 +181,14 @@ static inline unsigned int get_secindex(const struct elf_info *info,
 	return info->symtab_shndx_start[sym - info->symtab_start];
 }
 
+static inline bool strends(const char *str, const char *postfix)
+{
+	if (strlen(str) < strlen(postfix))
+		return false;
+
+	return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
+}
+
 /* file2alias.c */
 extern unsigned int cross_build;
 void handle_moddevtable(struct module *mod, struct elf_info *info,
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index d587f40f1117..760e6baa7eda 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -391,10 +391,14 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
 	struct md4_ctx md;
 	char *fname;
 	char filelist[PATH_MAX + 1];
+	int postfix_len = 1;
+
+	if (strends(modname, ".lto.o"))
+		postfix_len = 5;
 
 	/* objects for a module are listed in the first line of *.mod file. */
 	snprintf(filelist, sizeof(filelist), "%.*smod",
-		 (int)strlen(modname) - 1, modname);
+		 (int)strlen(modname) - postfix_len, modname);
 
 	buf = read_text_file(filelist);
 
-- 
2.28.0.681.g6f77f65b4e-goog

