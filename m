Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13686288E45
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbgJIQPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389766AbgJIQOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:14:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA28C0613A9
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:14:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n13so9316923ybk.9
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ljsItlz/aE0P1FDke8OIPGTsfsgvR6SCQ5aAaAr+FuY=;
        b=rDHTl2DOvEF5lAI8/1xgnH7ewQP7v+fy6WFg1GImMEetNzxgNOGQtQTgFVZA7nJz4m
         E/V9TlOXQo2zsXvADw6ZjNHpbyo0GyLXq/UcXFopFQ5iYAVttrLb5kwsOMZlNj6d3mq2
         v2Z69HCANswfC9sVB06+DLebakWFduI4MBn43M/w9uUpWzAIbBGEejEK5mHvIYhz912n
         egyvp5xLTL8ReK004BgDAz4wuj45irBJ5zvwJmj0uVsXV1gk7BqZvJNpws7d45/nZF1s
         sv/UzaMr8Prok4UlE5mODVRqtzkXlZAlSECInu3Rk5zSafDWjBxTBOhp32r/igI3DisM
         FvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ljsItlz/aE0P1FDke8OIPGTsfsgvR6SCQ5aAaAr+FuY=;
        b=rqs/qpLSL8c3XqtI+LMYxgvkYUoYtU/Xk1yjf36kEBWRSR/BqDrQMgVjEtlYZc1BWR
         d8HxAPiPcpjX3CbHyAQTcWP6HQgfOBz9SQFiJ0apYpEtEaFLvpAs0i0T1iHL8mcYhjbn
         3FbSa2AAFKxPapSGh/Vz9UMYxpyJ4aZU22uLw7Vuh7tBHN5xZ90USmKvifH86osSMD+y
         tPg4LuaNBYS3vM5Uhm3KjPlhSHLr/30TyFMaMSLo1QUvKBXjGK+YmQlHaSAknw2I01NZ
         K1VuJ2nTt0NOM73P641e27o1N3O7VpJJFXO4uMO+S8YMi+V7iHRQ8gr8G0z2389pQCgH
         i8Ww==
X-Gm-Message-State: AOAM533P1ur0w16j3bhCg6Gx/UdOzmAP4N6YZHR1uUMINzLcSV2Hmzcj
        SrGbxyJQOGEYwe9zFYyz1Gu+S7RmOJQM8eU1swE=
X-Google-Smtp-Source: ABdhPJy32BlRlXtKX3ZecjjCx8sYUdqfwZnP6p3172X1KprlyJNmmCaj7qPqSsBQi7a3XNa21VFXuJCMRei9tPIgOic=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:aaae:: with SMTP id
 t43mr18851419ybi.404.1602260052989; Fri, 09 Oct 2020 09:14:12 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:25 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 16/29] init: lto: fix PREL32 relocations
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

With LTO, the compiler can rename static functions to avoid global
naming collisions. As initcall functions are typically static,
renaming can break references to them in inline assembly. This
change adds a global stub with a stable name for each initcall to
fix the issue when PREL32 relocations are used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/init.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index af638cd6dd52..cea63f7e7705 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -209,26 +209,49 @@ extern bool initcall_debug;
  */
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init.." #__iid
+
+/*
+ * With LTO, the compiler can rename static functions to avoid
+ * global naming collisions. We use a global stub function for
+ * initcalls to create a stable symbol name whose address can be
+ * taken in inline assembly when PREL32 relocations are used.
+ */
+#define __initcall_stub(fn, __iid, id)				\
+	__initcall_name(initstub, __iid, id)
+
+#define __define_initcall_stub(__stub, fn)			\
+	int __init __stub(void);				\
+	int __init __stub(void)					\
+	{ 							\
+		return fn();					\
+	}							\
+	__ADDRESSABLE(__stub)
 #else
 #define __initcall_section(__sec, __iid)			\
 	#__sec ".init"
+
+#define __initcall_stub(fn, __iid, id)	fn
+
+#define __define_initcall_stub(__stub, fn)			\
+	__ADDRESSABLE(fn)
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-#define ____define_initcall(fn, __name, __sec)			\
-	__ADDRESSABLE(fn)					\
+#define ____define_initcall(fn, __stub, __name, __sec)		\
+	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
 	    __stringify(__name) ":			\n"	\
-	    ".long	" #fn " - .			\n"	\
+	    ".long	" __stringify(__stub) " - .	\n"	\
 	    ".previous					\n");
 #else
-#define ____define_initcall(fn, __name, __sec)			\
+#define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
 #endif
 
 #define __unique_initcall(fn, id, __sec, __iid)			\
 	____define_initcall(fn,					\
+		__initcall_stub(fn, __iid, id),			\
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-- 
2.28.0.1011.ga647a8990f-goog

