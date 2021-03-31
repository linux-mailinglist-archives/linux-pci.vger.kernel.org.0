Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCAB35096A
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhCaV2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 17:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhCaV1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 17:27:37 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE2BC06174A
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 14:27:36 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 130so2369006qkm.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w0Ob8x2IVOI0uzzuSsD4k6M727ovkcvMuqyZX5oqc8o=;
        b=nI+ENEyWz/rNq3xP8nhiHUSZWps3bzcuJMrVtvPjR+rwBVB/lrPv3BQxv4E6KMlKot
         N2LsEQni14VlVAHF8qnHU7viK/ziWMDnF+LjsDhRC5aIyL3jNfHcFkfBZOz7gp9DHK/O
         0JRF/cYTuekKimF/7nWHkbZejho/mozDnjz14/sUDrLrCY52H9gqZiseo5bvX4tsLE3n
         UInjiRYKcOH12CVIEai20isk8gmvkqMy8DVUqR4KnBFv6jve3oIB8g21fppaRejyMB3V
         etjDn4nUdij5fV9SBqoW9glwdBH2VxhLNg9QBaiZB4SRwbU9iQX2g4S5jS1L/Ej7xHUS
         tYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w0Ob8x2IVOI0uzzuSsD4k6M727ovkcvMuqyZX5oqc8o=;
        b=N4fgAjzIuo7I0/PeHtjvDThBAISc6T27JZ/kxKT8YUF65yMBllQHz3RkUWOV85KcdH
         wVBncSlKgWr0hpDyLow2lqCd3FTbhKUtxDJAwa6DeDM2gtnDQ1j6IcQn1l5iyTNBsANP
         7gVgBhlSyKKFGqfBEvkk6faZd5n8TwSM/RNPQ/Brq8E7OZ4MMFzGurWEsk2/UKYtiIOW
         iuFMe+AxGKAm5wP0E3coTZr6w2ljvCImgwQ3Nn4xJCyzHhzkwqMpaBcDCE5lzIfZIKZ+
         GqrCcsMbZnPKe/4e4z/230GUejxuj0WSuDPqbKRqmHuq1Zn1uAotzVMlqtC45xwugxfp
         cYLw==
X-Gm-Message-State: AOAM533FkWgmXg14dGuKWe8eH6DVcpSqL6uNtZW7NUMDDaVbPCWyCS1T
        8IDHdNfccsYYYWrNTS3qRGxufg0+Ob9SpsGGyBk=
X-Google-Smtp-Source: ABdhPJxyRXN3znqnAe5t9dUQhGAL9s70gMe95fSLJFpd13x9D/1BXHdz4usqL4E5etbu055EIK7g6ge4pYkRTaLFmpw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a0c:cb0c:: with SMTP id
 o12mr5070670qvk.54.1617226055502; Wed, 31 Mar 2021 14:27:35 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:10 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 06/17] kthread: use WARN_ON_FUNCTION_MISMATCH
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
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
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
Reviewed-by: Kees Cook <keescook@chromium.org>
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

