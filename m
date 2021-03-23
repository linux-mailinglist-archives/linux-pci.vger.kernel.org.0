Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7B0346A15
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 21:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhCWUkd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhCWUkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 16:40:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CEEC0613DA
        for <linux-pci@vger.kernel.org>; Tue, 23 Mar 2021 13:40:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x10so3830194ybr.11
        for <linux-pci@vger.kernel.org>; Tue, 23 Mar 2021 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=obb/St0ECVpiVYPjl0tFmSeAu+nwHW6a+FyVf5Y93kL0zciJ7OpXo5pz5/5qK+sMFf
         HVCB7lPNLLCcgrreAMPMIq89DUCTawBOwNPUPSIBya5VRwan8cbfXQx100+5xN/Qkd+t
         DrRy/pbSThpGxZ1QzI4eyYQAJqKt5nt14oxKeAqxjwjAb66eROjyJZpq+iXVKnIt1UeO
         qE3Het9/jgbk33l/79gSOA0M2UKmfHun8/qcQ5XwaA/WAB2nFQGlLlfTzyIcIhj7o/5V
         IAm35WHoPPYpvmYzDW1CTc/YgvwTLIfoZ+x6jtjFf4U8j7x1w0Jt0fXDFRfY/dN/7g6Y
         zgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=p3r2mNBPJnCE1rB4arKDqgK4mxDS/6YPQp7yzvctaRpBsSLzlkXi5vAu3IDz6lN9bu
         FAnEoasf5h5cIuPew9ZXtVJhhKd7gGTi0mH2rIOihuPSgr4K6mpxzAiGynk5so7SAzF8
         rFCs47dEp4oeVUDymMMQiL0wXhJ97xqUC7B/Iu9KGFRdSSbgmx1V+ErqRWCo5ZTUNufJ
         +OlEvdD4nQ6RVxzUHdVVRn8VE5MJ6YSUsTkxZKH5N8aOjBQBZQsmH633LSux/JB1li05
         zEE5EScwbkkwnvsTSwWBQpD9AgwOCC7fNFu0LM8FcQZsH+VXKzZ+p2fhUjqouNOEpDmx
         IuPA==
X-Gm-Message-State: AOAM5312DybRSBpoluvXLHSEd+KB0rPWl8nXz0TLe3FqA2EKVeKJzOQc
        Eg/k4x01BIsdLzIXvOZrDLiXsmTIDUImENc+2X4=
X-Google-Smtp-Source: ABdhPJy06lzastyLa7rjZrqrKe8Kw6vypE8VYVF9BzE0zOiJRLohmqAfcSnsVJk7XWpS4yGsr/w/V3cRXxwJCIzEtGs=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:e008:: with SMTP id
 x8mr147121ybg.90.1616531999835; Tue, 23 Mar 2021 13:39:59 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:35 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 06/17] kthread: use WARN_ON_FUNCTION_MISMATCH
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

With CONFIG_CFI_CLANG, a callback function passed to
__kthread_queue_delayed_work from a module points to a jump table
entry defined in the module instead of the one used in the core
kernel, which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != ktead_delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973c5740..a1972eba2917 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -963,7 +963,8 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
 
-	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function,
+				  kthread_delayed_work_timer_fn);
 
 	/*
 	 * If @delay is 0, queue @dwork->work immediately.  This is for
-- 
2.31.0.291.g576ba9dcdaf-goog

