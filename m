Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3722F25CB0F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgICUfy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbgICUcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 16:32:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4CEC06121A
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 13:31:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p138so4010469yba.12
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=v4aEDtr6bLZLPmR/ra6D5NVXgPqHTR+q2+p+53rP8YU=;
        b=d3WTta769MJh+Bo0VzFx1dIubRn1F3/0OsgdvpRIABs/0F8aoQ0QxN6GC6ogiN8YAt
         1n2fy7ycG6neE8i4JP6mcoL5+gOWppxCnH2U8kbhGmk3Ke0U/7qP7lute7a6H0uDoYhQ
         dWVIqp9Xjw2Q1WEklB8eqrGPTTy0VYDaAb7Vj5vkDxGtzwmgFWOj15UwJBAbJ05tl1sN
         Q4rZl0DzGVRAuAw5PJyrACjWBxr1NbGCE0oN5TR+pUi+Dq3TH5paoF63RYX5l7QEOrpB
         +a+BflxQgXchm/xsTBNIInkXUZW2NMgvFiHC7w8tScjlytwkaK3yal7TbaDvFzX+VZKt
         2LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v4aEDtr6bLZLPmR/ra6D5NVXgPqHTR+q2+p+53rP8YU=;
        b=V87bZJ5DdKJ61xW8k+rVn8ExVlrjzhcMMz1g6/wAHGXquupu//QXpDwu1wXqhW65d9
         Rp5dp0A83twCt3G51vILcI2mN5/8sE9w/m8JTYAeiNtbWuTSms/7jSjzALeOt/kZIvnH
         8DSLreK7bsCziwyyPzEMo0059rorHq0TUZ9OXezVxOwXaErl8ezGIYd2RTRU2UTdxU0Q
         M75NENH4D9CERzLuUuK54Q5xtmflBmQlNItX9tQzGERiLq5MiNFz9KjFcVMdecTrm3YI
         DLDr0HwtLFFdoF9u/ZL5UXwUx6N7sllCNS8K0pypXY7Q+mpPQscMlxSR7dHQUW2pe3KU
         a8dA==
X-Gm-Message-State: AOAM5318nybkyRaTQdeGSpTNGsZox/Z5hBAinNDO5Thjv4GvdXdCndBW
        hqEorGhDec6EaCpQ23OkJoI44AwL5HSGOOQ96sg=
X-Google-Smtp-Source: ABdhPJxLcteMiXx6yxIAtF7C6LDsd43v+S+v/BljrbTvv0EuuMtNnvGzhvJa2qGTBh5Tw0uOlOWuvZqeImKd2fr7SwI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:a366:: with SMTP id
 d93mr5081717ybi.415.1599165079173; Thu, 03 Sep 2020 13:31:19 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:37 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 12/28] kbuild: lto: limit inlining
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

This change limits function inlining across translation unit boundaries
in order to reduce the binary size with LTO. The -import-instr-limit
flag defines a size limit, as the number of LLVM IR instructions, for
importing functions from other TUs, defaulting to 100.

Based on testing with arm64 defconfig, we found that a limit of 5 is a
reasonable compromise between performance and binary size, reducing the
size of a stripped vmlinux by 11%.

Suggested-by: George Burgess IV <gbiv@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 2752be67b460..c69e07bd506a 100644
--- a/Makefile
+++ b/Makefile
@@ -917,6 +917,10 @@ else
 CC_FLAGS_LTO_CLANG := -flto
 endif
 CC_FLAGS_LTO_CLANG += -fvisibility=default
+
+# Limit inlining across translation units to reduce binary size
+LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
+KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
 endif
 
 ifdef CONFIG_LTO
-- 
2.28.0.402.g5ffc5be6b7-goog

