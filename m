Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037C6340B31
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhCRRLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhCRRLe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:11:34 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FDDC06175F
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:34 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id k10so27592070qte.17
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hHyY7qre9OXEm5PJ4BWXLYwsH5KdHQkHk/skTedwvAs=;
        b=Lde7CebUF+4MxFHwi/QJePFqufNlE/xCS5gC7b6UYbWiT83z2QpxmEMFBH6B9+0bKu
         RhxhEy/0hJzTcT6jiCO9gz0BR3b9RfC3YFtEhlWvSsaiN8+yZEftdB2vRtJbab9pJGnz
         hhwyh3gK1jRpm2AHlwxPUp8zEWKcK6N0fKUecc4oGnZfI3XAfmpaFwlV/7CfzGpeoEIu
         goWoD51rPTb8RPqdYHUhm0haB65coJQBNiJsljlUPOYKHXrHl36/fcEE89f3gqz2makA
         D8Y9Fop2eU0OGiHWOJqP9vl/G1TmJkyHQj6G615Ry5DyKmRyqFjqOyQp9kAArmMMqUR1
         awKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hHyY7qre9OXEm5PJ4BWXLYwsH5KdHQkHk/skTedwvAs=;
        b=I7lQ6r0gDNigcAIiRg/JAy6tbka6xlHZB+n+3r8WixuFNj6eNxCl9DNgSyDL8wFCB4
         ZXdL/vFj1vaicv9x0uiU4zbbHpMjuZ/Jydgdv0WmVmz52o8zaJI21PM/FtyTLjFjNNvB
         ZxKE7XLOYuGB7st39rCOnGLreNuLCI09o4VvKoYCEqNmdKG6dBBHljjA4MtorhHz5MPi
         bCRg0S92I1RJL3WMUsGNY+fjpXnhmEDBLVEKCIonGX9AaLogjly7itVyMyNWTKihNtz+
         ShWtvyma919mO6y4Ir4ZI+a0PUaM4vxzjVzjgLUuNSRgYrnE5Fen0uDUrEzSQ9Itr5Xq
         b8xg==
X-Gm-Message-State: AOAM5328n/g80mdz+FKaijDqwp2i0Ryrl7HIhii2ItW1fv7J0WpZRDic
        z4jojgb++p0fJCO7DOG+Phl6Q27/HBU5w/ABfJk=
X-Google-Smtp-Source: ABdhPJxE/giZ7AfYJ0TH9vEAyheMLl0QRNdj9iBaMv7F1HWLJlNkEqoVklDlggjrilm1xsf++JBcogV4/Smdr50eqyk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1484:: with SMTP id
 bn4mr5338692qvb.8.1616087493471; Thu, 18 Mar 2021 10:11:33 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:02 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 08/17] bpf: disable CFI in dispatcher functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
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

