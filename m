Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0BD340B55
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhCRRMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhCRRLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:11:38 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24574C061761
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 71so19411807pfu.8
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xIKsEDWi8EL1j5NSYc2uWQA3l5Y2NiXXcLT9TovNhRQ=;
        b=uKxyyo5NDdB1QUbA3EnMvjuX1onU20iICbKJ9iP/dqRqzhm0bGPXUszw7wf3GKl1Cw
         8b6zGQsOgdMHwwqtEMHY8K9uQWWo8Csl7Ij0z216FvJg68YI42t5LQuRc707PLWEIS0l
         v6mINbfwZQaRHIuEtuhd/w+jw1MkLwDSlSn0PFx/6d0jgHgbFlLEe2zIRvzuxqfIFbB4
         81s6Y5tTsyTXg3PP3MbUj5QPEwCUc2bn0HIlVMkvO4B9tOKV53UBjXaLwrQa+a/fwExd
         ndjASAw4BiPpZ/v3XOZOyYf+t4si7VDIT+/WYNd+6rtyQwfJBQtMCpJMP/HwM/sR2oXZ
         1fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xIKsEDWi8EL1j5NSYc2uWQA3l5Y2NiXXcLT9TovNhRQ=;
        b=XaYWhGyOgk5rBer8dFWB4gqgxuoVN+tPPIIzXJ9bDAXZxVRS02hSYFAu5D0w8EqPyH
         UKaYGTtpD7qpvoh182Vhik4bRoQ3j+o8HMwEdjEu5WE1VxpQz87r0zrUxsAJ7J4lt05r
         EBRyg9b6fZQnE1/UChzSBarIRyTKz0DBGuSmw6YiylNiAByV44a0fhvLx7Nfk7ANhQEv
         NRzotqkIm1ExoPy8T6GTlqAcJxTOuYk06CgItw8w/XRagfCoJ23lrwjlv6wTIFTzdYl5
         6WdSpd0Oqz1vXkCqHF/Lud4cPusCEoVl2F4OH9tchSgFsCZ6jUhd/8uzPM/OyqvY4Z+8
         6hag==
X-Gm-Message-State: AOAM532xdu6pwb/R2EbdCkuhxLwo8EfuJf5BOvBrWcD7n2lWWCFoftAG
        94wFkK8pp3WwTkFmK1WsWxq1nvb6qQgPAgKmo58=
X-Google-Smtp-Source: ABdhPJwtUxlgXUjHfalHssJK6ozLwDkIUZpLb/yIsL/9erTHZ+0BV/50LNkOYs0FUF9Eq2xmyoDCO5T7tob2m1K9T6U=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a62:e90c:0:b029:203:90f:6f34 with
 SMTP id j12-20020a62e90c0000b0290203090f6f34mr5021966pfh.29.1616087497587;
 Thu, 18 Mar 2021 10:11:37 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:04 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 10/17] lkdtm: use __va_function
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

To ensure we take the actual address of a function in kernel text, use
__va_function. Otherwise, with CONFIG_CFI_CLANG, the compiler replaces
the address with a pointer to the CFI jump table, which is actually in
the module when compiled with CONFIG_LKDTM=m.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 109e8d4302c1..d173d6175c87 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, vm_mmap,
+	if (copy_to_user((void __user *)user_addr, __va_function(vm_mmap),
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
-- 
2.31.0.291.g576ba9dcdaf-goog

