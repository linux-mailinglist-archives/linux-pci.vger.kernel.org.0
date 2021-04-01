Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C173523BE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Apr 2021 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhDAXcu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 19:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDAXc3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 19:32:29 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D54C0613A8
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 16:32:29 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c7so4787167qka.6
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PVR0PDKMcdICThtHzZ05IpjfNpdCKYkDS1ZQgOORGog=;
        b=tM0gdLvYYrIGSQ3UU73+aYUTVKUNIBmfBmMOkqL3kVYculPRqLzgjOxKi8RSH39BMa
         jniLnYQk3/+tuCi/WvnaKTWlkCsW1fENUR+FZ5btuwg0G2PF2KxdXxmwadid13ZqOvDZ
         rnAbh16KswUlnaQJtOdiTw8jRv8opl7cYS0NURIXgAwstF9yjXbgfTteqYONzG6n+08t
         qKrhi560aPcoh7IRXPd/rOy6M0hLASHhaPpvZ1DvsZiV91yOvz7u4r2xHuiyO7s4WLQK
         1hCLqtc2RshinGwJtiZyyBClSa2dPX4j5ksIjHJxzt9tSnvJryiiPqFrpiL8tPgxVSFr
         cCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PVR0PDKMcdICThtHzZ05IpjfNpdCKYkDS1ZQgOORGog=;
        b=WzlN7OcymPBP1IpUxy1W7XNO3j2REXSE/82pVntcfZ4BOfaPdTd+Urxpns1VLhNQSF
         vARI5VVJFqBCemVSED2E9KWeRVYFSZd/S7q6j/i38MOT77wzA04HPqASahF3xM3R8LGk
         HGqKO/PkF1u1ME7jhXiO8D8BKVwunTcz78R+/pAwFBzxkmQ3Ay7SkGEY2lYNmHxMOpQ8
         B4tDVGr6Q9MOjHxuBFN3aN6PU20njAVbSMXZcPk83hmWpRsNuAnPklIGxalflDN5ln4D
         FsBOEIVQeIWywqOjZqLQsVQu/BzklIlU/uGgMULEySnoWT5OP39ZznhspnpJt2VHwWQG
         ZZ2Q==
X-Gm-Message-State: AOAM532Qvt7Z9WzgM0SS3ZoM5A3Ipl4MrfbFD1Y5dvp75g4d981MLaPo
        LnrTuc0Us1lvoz3avaVvuxJifbTAftXjK0A+Cac=
X-Google-Smtp-Source: ABdhPJz/GEAYNwZ86yFSuRvcWhakddiQDxgrF7XbdSdZeXfnn4teMz+Kc34ztrNSurf8c3YQYZvgWvRkfDCwo1+2V3U=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:d7d2:: with SMTP id
 g18mr10283542qvj.42.1617319948605; Thu, 01 Apr 2021 16:32:28 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:03 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 05/18] workqueue: use WARN_ON_FUNCTION_MISMATCH
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

With CONFIG_CFI_CLANG, a callback function passed to
__queue_delayed_work from a module points to a jump table entry
defined in the module instead of the one used in the core kernel,
which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da252e8..03fe07d2f39f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1630,7 +1630,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function, delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.31.0.208.g409f899ff0-goog

