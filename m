Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2261B25CAA5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 22:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgICUeS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbgICUdI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 16:33:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFC9C06123F
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 13:31:48 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c190so2698094pfa.10
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cZOWhnp892SUnLhqC+1TPlOe8BVqsfDWwTFGwwryYEw=;
        b=WYxR9JOXeqHMLp90nNI8/6ltDzhvsuYjv6d1zFqp8zsjL+qJYufybBNzAbPMTkNNZl
         D7MpSi0LlP6FuYPjz4u35DCi8t432jxAgU18y16gIeH1WYnR8Oge5r65aJHFkr+O6ap5
         7Jb4/kJwsklpayP8Ru/q1xJFOJRx54JFuZjQSOGJapmUtPdOP08d8KZWkeRlM2D1Swzv
         SnITw4E+gwFNoLz9DvBEQEulPAjlW7Re+DfF/dU1eZIdgljsqQSczq8cMfTFPUsSyciF
         mvuZnj+9HqmA+LFzkWAsNTdETxPd/fZaNFdn6zEOPF2B4+IaWN0xMyzjF9d7hiT6GQ2b
         54pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cZOWhnp892SUnLhqC+1TPlOe8BVqsfDWwTFGwwryYEw=;
        b=IZYqQvpejU1U79I1RHdC1M8T+Al2sHYfUsYINxj4iycKmn21DDPMcsuVX2S7n8q8eM
         Z3VimmHBsTim3kYpi2uiVzd2f66kjQtVM9KBd9rQJFSdspwygXwJx76XvlkydNR7hXlh
         MtLGsSgcJAeoNGU6Cm+ignR7sw+jkKKMV9PvxooQHvFf4cnmsQuYD31k7KF1nKsFTHAZ
         lZS2MYcpayCvxnzoifBekVpvpOjWFsTSTTXlYouCeCtJTMvjRS7fKpqEJk0sZVBeURZR
         S46T/3/QdKCsYZBZbUxk3y7I8Sh0Ys9j9X39svTh7rL7f1LiN0U8vlJjaPoOnTL2L1dc
         0+DQ==
X-Gm-Message-State: AOAM5330tENBM9NQBcUNtOWRDZcZqxBDi7+/cBt+vqbXtDV18ITjJuCc
        s91DTFn51uhtXXK4+8wEgHSY0ZhHOiJV8Fj2mOk=
X-Google-Smtp-Source: ABdhPJwa626CxZJt6X6ejRxk7e3J2MLsFDDgC11k4AQQkijvXAVNZFdD5YlGgxxeK9SEt/5A/DqexW+VRmPulFH2V5w=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:4595:: with SMTP id
 hd21mr720735pjb.0.1599165107467; Thu, 03 Sep 2020 13:31:47 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:50 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-26-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 25/28] arm64: allow LTO_CLANG and THINLTO to be selected
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

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..2699fc5d332e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -72,6 +72,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_THINLTO
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.28.0.402.g5ffc5be6b7-goog

