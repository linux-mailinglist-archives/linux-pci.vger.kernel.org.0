Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E45358C57
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhDHS3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 14:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhDHS3K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 14:29:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C6C0613E2
        for <linux-pci@vger.kernel.org>; Thu,  8 Apr 2021 11:28:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i6so2883045ybk.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Apr 2021 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LAbK6LGasIRIE7Lniqz15wrZXmrTUww5+Blou7CAxY4=;
        b=QALHFILqs4GT9aNrYaVc5cwsS2O3moVbeFoKzOyeEX5T8gKLkqRck/QOpiZz8Xgy6u
         GHtVNUofOR12IrpxyVNLzh3Fm3luiteO+R0LhFXlpqeRo+tjHTcvyNfsF9MHRpthossc
         Wg97cyUbCitctKczgbE5+WCVvBcaK6Cgpj4Wc+rVPe/2DaGB2rUJAG0m1VBSG7Fh/M1m
         roMFGI/64bI4JmKbBL1CkGn8Jk3OiOz0zV6tR0qNGANde5gC5dqklluOdFXuiL4Z0XAd
         tWewvUx6Wqo2mymkJ68/Ko5qbJi4ovkyw6hG9G2+2lVCKJZ+ew7I+xyb8aUSlHCu3d9X
         9k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LAbK6LGasIRIE7Lniqz15wrZXmrTUww5+Blou7CAxY4=;
        b=J85GNkM7e0zvE+PZSdrhAOXBhOFDhmHyhQ3okn8bqMF2ViRHPOeTogwf5/RvgxTDtN
         PRL2IQ5mOY/IruJjBuZbk+p5knoGhmbreHHZqR0HavfW7vl0fPTP3SwKHdvWZmPDw4+w
         nTeSxeJN6xnvNnTc0m8R6jGlMKll4MnHRM7nSEYoJa37x7Adj2u/l1g4BwNosR/ljgUp
         kENGZHtNj18poKhjU9WDwCkZSTGE0NHAAzGjfOJUIMXTsbc5boen+aNTT2iHxKGLvD1D
         f+ZkVfBFFDQzRENLq+il8EiOvNJn2TA3cDLYp4ieO4NvvtS5TVxiBK024iirjiCPcGV4
         nLbw==
X-Gm-Message-State: AOAM533uA+McjfIpJRPrG9FfTAzScc5zQKsvrME0AC6VIADS+XUD0Mx+
        9oDD1SdfFXsYXh2ZL/2t0d+8cQVrUOcJ3WonyvM=
X-Google-Smtp-Source: ABdhPJw87AxiqrYpD69IN1mX1v9G5eaNQRMwJPV7w2K9v99iKIA1elCFwP6HzCX6OhW3J4LcJzLgOKik1/QfdcH3TF0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a25:f608:: with SMTP id
 t8mr14077162ybd.496.1617906535437; Thu, 08 Apr 2021 11:28:55 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:30 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 05/18] workqueue: use WARN_ON_FUNCTION_MISMATCH
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
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 79f2319543ce..b19d759e55a5 100644
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
2.31.1.295.g9ea45b61b8-goog

