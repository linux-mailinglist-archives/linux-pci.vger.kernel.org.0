Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4BB35096F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 23:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhCaV22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 17:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhCaV1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 17:27:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F40C061763
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 14:27:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f75so3637735yba.8
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LhQny/aeJmeAJ3bCETNM8gy3/qff2yzp1+GBUrzrBDs=;
        b=km1dlNMsZVD+nYKyhmf8suslG6lRpTXA9bXfPOZq3XJD2bh9lwyHlyugNqkc/9xIHZ
         pvZZvVE7uTiP4xcSdTYcIUDfgVzPvR8B7rp/SUuIegT/xhp5Kgp8M2Jfv/MMMGMErURD
         D9lFaSTH90mT4zzz7CkOxbEyPbFaLhhQWqZx9kshO8db8Eo6StC3w+wbFjJuHk4jG3HN
         ucAsImNaXJzMhnj+fyaph3WhubhiwK8ZKwoWXX0hwNzxpHCWqtnmqIC8+kn65eGYZQAL
         IxDudopx6hMfpUdyShz//HZdprJ0b8BJcZVh1a1jajI/rhbjlvcxdscLYnc6MfVzw/7Z
         xOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LhQny/aeJmeAJ3bCETNM8gy3/qff2yzp1+GBUrzrBDs=;
        b=I+NfKThn9zr8Ng/uGnmOs82ossfGfYh3z1MUvFsmWu82+dPeS2cd1aeX7dzToVlrhv
         PRMb03T7Om4tUxYFzrC9gIjaIZfb8QwK8c7TskiYTbiXw/38RBLlrjmZc4nL+XI2C2GG
         tpU+oCuO/rr+ShZlAGyT1X4dSRPts4GK2/mSopRifvCxbK3FUZJFV5eiRU6SEAMSLXP9
         nHv0N3EOr4K3cXl5P2YJEnRemu7GQdQhDTiPeDc0hyHcaPZfjHdRmIYJGgi19jHkVWsU
         xja9mNmhqDNBFuFJk/pl6RXbU5vnfLAuvK3F0PqQcvNnU7DcHgpEPIJIQDMpSm4km5Eg
         DsEw==
X-Gm-Message-State: AOAM530u4tRwpa4Wc22nDNKFvgc7ptJGEndlsKgWn0Z7GPu3wIlT8Ri8
        mbDqWmBHWw7PuK7sb5r/9iKTYjjzrxIjZR4MpYs=
X-Google-Smtp-Source: ABdhPJwLju6B+haVkuwTRD6OTE7Kj+Fskb9zJBbkaGFlIanyE03asSCx14sDc0Ys7LCvhLw3MkN686iAQEZQHDgH42E=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a25:38c6:: with SMTP id
 f189mr7492638yba.183.1617226063121; Wed, 31 Mar 2021 14:27:43 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:14 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 10/17] lkdtm: use function_nocfi
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

To ensure we take the actual address of a function in kernel text,
use function_nocfi. Otherwise, with CONFIG_CFI_CLANG, the compiler
replaces the address with a pointer to the CFI jump table, which is
actually in the module when compiled with CONFIG_LKDTM=m.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 109e8d4302c1..15d220ef35a5 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, vm_mmap,
+	if (copy_to_user((void __user *)user_addr, function_nocfi(vm_mmap),
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
-- 
2.31.0.291.g576ba9dcdaf-goog

