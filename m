Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7569C288E58
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbgJIQPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389845AbgJIQOy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:14:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5254EC0613AE
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:14:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x1so9538602ybi.4
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zm1uzmyUH/ec78UqO7SuMlzRHKM3BG4k+fqmwwznAmg=;
        b=GrQmnCLFUBaiVCsxG+ZjkTiTKAEhcgJzQFl56MgTLq8OusnCa4bNYdjWzig23zPrnl
         +im7f6+CPpBNHzIFXIJLOZcbW4i0CqLoe8s+12RVeCjtt+HO9D9Fmp+O75+bZf2mDiJ2
         /Sdf7HcvK80M7NGzoz4kRytQKC5iEXY2PGakFdQKhcL+z9fCcZ8Ykqq7GsQcpzIDx15k
         9etE83hAgqhL7En54OpSg8MznvaXv/L4GRvX1UCC+uCk3jv6tzVeSDQl1PLkAX8W1gfk
         LEMSPi1GNobCqjW4dHBWslVgjybeY2q8RDcnHKubTb3w6/WlHs1OcJttkCjOO4Qogko1
         U5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zm1uzmyUH/ec78UqO7SuMlzRHKM3BG4k+fqmwwznAmg=;
        b=gP+t1T1wvvMTlKfL1isWz5R4lgsKzL4H7QYBP+3EeQ1OANayTYfN3ZcWfoAWl/VUBz
         1hpXgImFv5vpeEo9uwmg5ep4XwDsUsVNtlXD8JY+nHVPfkjUi1o783nFeCLaaWKdOH/3
         oRe8BpNi7UyBUeBsW5TfzxKbtOrJJwsbMCjvOxYioTNvDAfAouONqapHqarLcPTp6vM8
         H0Yw+GjmT75gOSXnrUTlTjHA7glkmAX8f7ewxH+RPWrpgIf1lrgDwjdG3+04PWOW3ZN8
         NUcIJ8f1sr5RDlyGcHL72tKUd29b0fk/0yl/TG8ro/O0EZzcTUHu9mugb8yIG5hgn0YL
         C3gQ==
X-Gm-Message-State: AOAM530xyiabLi6URY1KOj5pi1g3tcxjUEEjOKrnkk1qkGrgISz9SLJj
        kl3RFafLCp+J9dByXxob42/8zzxX9qoRcWKFgfk=
X-Google-Smtp-Source: ABdhPJxS1cYLvTIq9AbU/WliPWkh+GMQ6EsM5q7afR6k6pEppCcn0hGMMeepAaLb0PMYcn/yVr6LGbihlfCH0HkjlAs=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a5b:486:: with SMTP id
 n6mr9292236ybp.229.1602260068556; Fri, 09 Oct 2020 09:14:28 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:33 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-25-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 24/29] arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
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

DYNAMIC_FTRACE_WITH_REGS uses -fpatchable-function-entry, which makes
running recordmcount unnecessary as there are no mcount calls in object
files, and __mcount_loc doesn't need to be generated.

While there's normally no harm in running recordmcount even when it's
not strictly needed, this won't work with LTO as we have LLVM bitcode
instead of ELF objects.

This change selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY, which
disables recordmcount when patchable function entries are used instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..ad522b021f35 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -155,6 +155,8 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
 		if $(cc-option,-fpatchable-function-entry=2)
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
+		if DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
-- 
2.28.0.1011.ga647a8990f-goog

