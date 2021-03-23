Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F130346A19
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 21:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhCWUkf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhCWUkF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 16:40:05 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E822C0613DA
        for <linux-pci@vger.kernel.org>; Tue, 23 Mar 2021 13:40:04 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a11so1974603qtd.4
        for <linux-pci@vger.kernel.org>; Tue, 23 Mar 2021 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hHyY7qre9OXEm5PJ4BWXLYwsH5KdHQkHk/skTedwvAs=;
        b=XrXpk80QpW18uEoFzgTskAcjmvDwp4KkI6czCZLCI2LllpcLlxdrxTo1ItDmNHN8O3
         bTKrEPYdAX8nqjUwEIjMGeZsRGCVSfDL1H2a3iHP2ngOiAKHMzDoZoN0zJI6U4uE7k4F
         VmweQXHEF/+JfAZFlAnZ8tr59hnNtlg0Zu2hks4+H3cinnrhxWtfOBc/gs/UrtgKxOLm
         BhVL1pP08EBbqj7+0X2iUTjwgv413Vz8hEc3BGPp0zOsqaAbAJtmiERhqTuyjM44Skll
         xAU/PM/Gg5Aoxn2Inc/k5V8U3wmSxVTzMEVnRHN2lA+v/IcNPy7/8t7fb9X4R/xp1aHQ
         xZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hHyY7qre9OXEm5PJ4BWXLYwsH5KdHQkHk/skTedwvAs=;
        b=S9FXQRD+ywSJ7C9AHG1n1XQXkHTh2NEbtipa8STusAaB8qbjJ9BuSYowAKl4j7O1El
         N0VL0tXB1ZPmWLCZYKiG/Ni6X+lB2jS/RY0EWPlMajGHutYE5jjZAo0K+RC6cBa/rIcd
         HOK8SHZN5xFDo0pLyVqDAcKQdIKTPmZ7CIGaGK/kxeLnml6BVW4raFNKOm1kSiTFex88
         EKVu5St93zLXGvnAXXtluKglp+BOhGz55iHmfkrGtO8yv6/qVaXNwma/fIizYdMB23b5
         +FpAkEMwe/0OSI3wqSxIwl+XbEL67K7Fz343EFKg66uVfBLTVx8qFHV6lTToMhcKRE67
         2x5g==
X-Gm-Message-State: AOAM533ttuk7vBhXM89au7ujNhfL6bgg6Eb4PSg07/kj1vmNjVErHwVM
        eoNiMEDh964DzYASl144QkRB569fWdBLBf0EF9M=
X-Google-Smtp-Source: ABdhPJzK5aKSbLwoPjOa/fZ+4wQdl/i/PHvrBqs1DnRZn9DH8KD/9yfcQQbrZv/qBxwpr5GT4qC2fq5WQsc1rIzUeMY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:ad4:542b:: with SMTP id
 g11mr7093888qvt.47.1616532003425; Tue, 23 Mar 2021 13:40:03 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:37 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 08/17] bpf: disable CFI in dispatcher functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
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
index cccaef1088ea..9acdca574527 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -635,7 +635,7 @@ struct bpf_dispatcher {
 	struct bpf_ksym ksym;
 };
 
-static __always_inline unsigned int bpf_dispatcher_nop_func(
+static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
 	unsigned int (*bpf_func)(const void *,
@@ -663,7 +663,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
-	noinline unsigned int bpf_dispatcher_##name##_func(		\
+	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
 		unsigned int (*bpf_func)(const void *,			\
-- 
2.31.0.291.g576ba9dcdaf-goog

