Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9313B340B2D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhCRRLl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhCRRL3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:11:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7723FC061760
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:29 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j4so22984022pgs.18
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=liAOU1cNxrOdNR8Mq2wdteZcuX/4GGjEvmX6VRt8SJpT8g5c/zhTtCrqOcNoXot7R8
         p1HymEJCx3U3MjDN37R8LlebJ9vtc4QS37r5hp/DGkgrykkjdb6C0qRALyJRp89Eas+i
         1jen8r3xd9zt0zZr9UzvlAfpmAxoBZYbpK/OgNk6ZT++341DfmQovKhP11YgxnbvZlFr
         X2tspDFVyGouwBpmAV27otQ74JTSYb7fKQKADR7cZWYj2chJWJ1DBwJw5EPogGOtdPZa
         AwlGuQfVzacKapISpv2yS7Uq+JqnRv+I7YVKuASx+mIC9EZrru5DgEP2qNx7a2dWt6C4
         aL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=WmproW9wgrxXypoCUYewChw6vV1aZBK6VEmorcca/V4jEFm/kjoC21KphHERklXCqE
         MUPqmbnlsoZVISEItjvNfCozawwKlbXCQNMSmPt20rwfybdrq5/ojmSbXMN7A1VdWZn/
         471HAg4zsjWxjHN1A0jMpZwxpj8n9m7LrbvXvh2t31U3kjLh1rD7x6qqi1+bAtAL+Frz
         znc1v6X5SKFMrIwrNxaSsAQTnIqLBWHM+OasGZQg0BesqaasCwh6mIpUcquqxxtAoPUA
         NeUqt3cFFJN/tD7VCD0zA4+vMoA3JJtjpIus9E3E+727ZMVflimNyrYvtRRYcVt2bI3U
         DNcw==
X-Gm-Message-State: AOAM533Ch8sL+qSPIKzbATfKFze4fcDYG/2Y5G4TJLp+BDmrF3pBFBCt
        4wO9hDMcLk0Z5TTC6JlGvSfnfPEYfuDenl4ZHNs=
X-Google-Smtp-Source: ABdhPJxKWbdiJmcD8GxmltL5n/GfUdjB9vzaW7o7vy1vsfJ4+SqraPewncqhBQztkA9cts228yKyAQm40viIg6HomOI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:b311:: with SMTP id
 d17mr5522830pjr.228.1616087488845; Thu, 18 Mar 2021 10:11:28 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:00 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 06/17] kthread: use WARN_ON_FUNCTION_MISMATCH
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

