Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629C33523CC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Apr 2021 01:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhDAXdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 19:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDAXcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 19:32:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB97C0613B9
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 16:32:35 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id u16so4211003pfh.20
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ygu6iZbbUsR2ZKi8zr0iQyDyVVNKo7dHAEFjMtj8SHY=;
        b=cVUYELPkwyakQO4gpJ1n7nG1A7rYRu+EIAysLbBiPdUejJzOzMX96EChrBRzMBh6zW
         x0dx0cW3zE0Wop2s4iCPSYOfpp1cHt4q/JDYejpAPuJ5EaZ0LDn1eQc/EZSSQ+JcI/Ep
         aSzshOkORkt5as8iBp+LK+0GHTFWu6E+X7Dt6fjBCwDhmMdVOEg0cYoWse5r7hWwupSI
         GIMWTyJUk2Pdk4jDTUiSZMOsvnGKcBr86YBHhdMz5J55XRKRhzQZzbLI8+1/ECst6qrD
         FS5MXyt1H5ODIdkNU7FRNKO5mEHgSlK1RJwyJk198zwyxxkaAm68PyCFKSZaJgsbK+DZ
         4xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ygu6iZbbUsR2ZKi8zr0iQyDyVVNKo7dHAEFjMtj8SHY=;
        b=YMHZgsXDmb5zzRVea9I3MlD5uLxMLFY/+oDLDS0iGVNC3BMzdOXTfgR8Q1zNwa2tul
         cfmcLOuh+U5mSuQdljlxxbWWCq2HuA1AZ7GFP4IXaLJcHkOsdXKc/opMBDYr6njOElFy
         N0TCdtAZX41oPqs14lavGAD6svRcYCftZkgnmlKQv+ZbYNHifLfupCw6OO9tZOGxl39v
         /vtQcS7CX4sfGcvK4234HBw/SRrrWM5Drk/mXSd7LXYJVASpDkxlCK+X1dL5PcSrlKl7
         YvwX1v+dT4KLDpuBOf1ANPDrTIrhLc4d8jJNuOZ+gdi55X9X0ofHSCtTZrZ0EqtCGEOc
         ejtg==
X-Gm-Message-State: AOAM532scu3TOGO7YyuaszDgbwb2gp6MyoImS9mJ34w5/Hz59KFq+mFB
        WcLseIt1zmQ0/o6VJJ8vVTVje0FyjFY6WqlJvDY=
X-Google-Smtp-Source: ABdhPJytGMUSgXoVFpBf4jaOpktUMQEi2HRt1jGw3DzlgyJAUXzE/JwtBHr7mViI1KpDfZlI/n45nehfSKBWCsiw8+4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:9008:b029:e6:f37a:2183 with
 SMTP id a8-20020a1709029008b02900e6f37a2183mr10163478plp.49.1617319955033;
 Thu, 01 Apr 2021 16:32:35 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:06 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 08/18] bpf: disable CFI in dispatcher functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BPF dispatcher functions are patched at runtime to perform direct
instead of indirect calls. Disable CFI for the dispatcher functions to
avoid conflicts.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3625f019767d..2f46f98479e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -650,7 +650,7 @@ struct bpf_dispatcher {
 	struct bpf_ksym ksym;
 };
 
-static __always_inline unsigned int bpf_dispatcher_nop_func(
+static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
 	unsigned int (*bpf_func)(const void *,
@@ -678,7 +678,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
-	noinline unsigned int bpf_dispatcher_##name##_func(		\
+	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
 		unsigned int (*bpf_func)(const void *,			\
-- 
2.31.0.208.g409f899ff0-goog

