Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D782D288E2B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbgJIQOf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389687AbgJIQOK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:14:10 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022B8C0613DA
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:14:10 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y77so7084120qkb.8
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s6lKkOY6jDvHdKU5rddxnOybuTgb4UG6S62YgATiqsw=;
        b=pMlxmld3pCeN4EpXaJz0+y9pU3tNLKwKdw/i9b8CDTyxgJE8DiSfW29Yqq7JBGxWIB
         FizISS0KYQroQZpoFLdIyyXd3nJXztABchxusIHIWy/a5hTlIHu+GvXT0Dak2hzrkUjJ
         WdDihkdOX7Ym7zuj99eoOSHPUk9jyMbUiHTUVR+LB37RzS0xzmdJSExSzfdwPOTpRQqs
         Hko41qQefXDStXJ0wnIio/QOEBPHRUJpHfbdMUnPtDf8nIFrJGJsMuFTr7Ijuy+Rnr8w
         5Kje5MABXGYr93PTUo2dudN83/OT7+B9FnRT3xVgpuwDBOzLWU7bGc3luRAI6rm+jvP4
         I/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s6lKkOY6jDvHdKU5rddxnOybuTgb4UG6S62YgATiqsw=;
        b=LgQHSTenN0LbRE5+rvVIN/WHjCs3swlHEa+2mgyqODIQNgZK0w2WT0HwmiBmiZkLq0
         kCgw7AHVHobImvyqphdzL1EaSkdkjrx5tvkjeToLVClaUg68UQosH8hIuWg67fvqJ6l7
         Bu+qC1U1NwbbI7MJlPZdfWvlnpCuDwDz36ccdqz9Kc28Rw+bVo9OxN4cQ8sLVa8hNZl0
         KfMSBQOpFjeqaSSL1Yw0UGBROAHOCEOeznd86oeyaxPaUoLAsvNOVRbUrPTgyk40yHow
         HV56iHPaPDykgeljQQZSqlSZcKU2l97XDpEJjXRiRF1zYKCtpL8mNz4MJ9cq5SQyKkxp
         dmhA==
X-Gm-Message-State: AOAM532HILIB99HrXJ3E3bnIH10fxU5WsLmoc1POeKP1Vpkg22Q5AyNm
        HWOZiqP7Ow18p2O66bFpKcf2ByosZZ8cTlaZrTI=
X-Google-Smtp-Source: ABdhPJwtu7GyWiP77sMt8wQ3XooLL+aqopqPfkXu+lzFDvHaNiLmrCamv63yyVSFJX0judiLUpHLdy/ZvBz6DQjk6sY=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:52c6:: with SMTP id
 p6mr12101699qvs.38.1602260049095; Fri, 09 Oct 2020 09:14:09 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:23 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 14/29] kbuild: lto: remove duplicate dependencies from .mod files
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
index ab0ddf4884fd..96d6c9e18901 100644
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
2.28.0.1011.ga647a8990f-goog

