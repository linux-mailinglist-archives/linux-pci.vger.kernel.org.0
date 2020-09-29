Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7252E27DB03
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 23:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgI2Vs5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 17:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgI2Vrp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 17:47:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A8C0613E1
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:29 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b54so4060331qtk.17
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DIPWfuOfjnS0FLqqhnzrIZ4jlncEeE+o+vZP3RuRCL0=;
        b=jeIjKmg7IRS+l/ui8Q+LF8nOaIvlsjsr5dJcnvSqyimVjw+fgPn/vAjJUtO4XmZBa6
         Xd0TPg2PXsxw8JWRlXMof9WtQxCvHX0ajUKKZHY+h9ZrQj/vHt4kd3uCJRU76eVTlT3l
         qvq/mdBiAQCfz0NkdrERe4By8JjkFVxXJhBvXJYakKcsE9Q3uXpA4c2ihpOBil6Arsgm
         /XRIkE6YivpM0yPirN/ctrfV5AzOopT2G8KpjaFwIzwdIty+tJ9NNd0YLGlPN6mpQHOt
         PZmo5ltSZAvrWwfyVtCxNb3oLaXN5GzVBEfApucjE1oqsSv0iOxejixTaxe7xLdJuwWh
         mCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DIPWfuOfjnS0FLqqhnzrIZ4jlncEeE+o+vZP3RuRCL0=;
        b=mwehH0T+tqpg5IbDRl3ERRU9q5fPqtv1jQih1xwa6Z98lpSkS3IsCqjNkZGZ4ypVD+
         9uJJngQ0VIfkkd7qeiI/n6b1/d6OKLinIG/TRHxLqio/TGARD1QoJqCNn+ZhH7shIdEq
         ZO5zaUdHIry/4H+tfH2L0S6a8cObcEB9P0bMB2SbgmNbcHzNPmzK3QQQ4bwcjtMiivqr
         Eq9YzcWwoCTPiOaU7UMkPvZXnmwwkuYgd2/LBC0k1HmpHa5fL0usieyyDY4Tlzy2MsQn
         RAJzXpAuz2fhNE9GR8plSaBCXdcTZhi4XNzizBvF/o8ZBtJmEo+8kjneNXYAAHzOR4Ti
         f9bg==
X-Gm-Message-State: AOAM530nJi9DWUWJAxt5YljUJ7KcQut8Fi+ah4zl/KnE/zUS95rMpS9m
        x9/QW9fV3MVzab0/RMu1ibP0v8yia106XTdgUxc=
X-Google-Smtp-Source: ABdhPJxh9cX/NQWJyeaf5NLdRHxlNrjwWH6kgp9BcYdpdAAl3zdkTlK7VGeQKrVU7UdbXnmP9NjmecTJ1e08yzk/vjU=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b308:: with SMTP id
 s8mr6728794qve.16.1601416048309; Tue, 29 Sep 2020 14:47:28 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:26 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-25-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 24/29] arm64: vdso: disable LTO
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

Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
point in using link-time optimization for the small about of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index e836e300440f..aa47070a3ccf 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -30,7 +30,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
+				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.28.0.709.gb0816b6eb0-goog

