Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CC5270676
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIRUP7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 16:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIRUPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 16:15:45 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE305C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:44 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s141so5584098qka.13
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vY4wvL91lX+XoPJtjETBJ0Jod2fr7hSe9gEwviH1PQg=;
        b=qivt17C4c3k3DwY8yxkDax/XSYLbBnJNnBYPw2ZM9Gn/ZE0fIpcsHSVm+mQlhKjakH
         ACLHPBDSrN9QhIs+2oMundPSpouSZPRbj9HW414qGcxUL8RP/Qw81qBg3hFyQmOJVd70
         36vk+fW3SMvGQBxWNMXr5dCR/MCgbY301VpVmDNnr0VCgN2sZLUw+BrVWaduLhzw5SZv
         rv8S8puJ+RnceNDh0B4fMoiQfngBeVpOdbwRVQ/hhKlaWSqX5BsgHyNznIZZ8LnydZBh
         YrVXnwczP2gFi6vqoYxTjLvwOSb3+MWNcxlFSbiyja8iKC/0zZ8liDgrrBt8Hk4cr/64
         UQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vY4wvL91lX+XoPJtjETBJ0Jod2fr7hSe9gEwviH1PQg=;
        b=D23lRQ4Wf13PqQeurhm9KzZ9qavRCvWA32219DhWo89Y0ed2BZrPSZHUJSZz17SpVr
         UN+fEtgzV/z7jKcoBrCBs+LgxxvCzC0cQhiwWgxObVCZiSxoH8IedJ8I2A2TZYqNAzJA
         1IZzatqeIRnohAMuaWc7SG3nrdp5K7byokT61BDhwNTQRgmkq6tCma+Sox8+IByVyN94
         S69gUFBTN5cwNjWrZTPLVRpeN0Sge+HbMN0LzSq7f8oHbJ5FAiqGgfg6q2N6Ny44SzUd
         ZCB9dKaKn9/twpWduToHsby0EGu5Qdk74fRv9v16jEbQFNxMUJ2jTbI10l9Jrx7Vb8VF
         STOA==
X-Gm-Message-State: AOAM533fzgqWdInJK+Dc4DBZBVB7QGzD9yVNjsG+/oXB397XmL+cYibz
        dKQ8C/7vuOrtOBPb/5Ph5WF5i3JHvxun93B1DmQ=
X-Google-Smtp-Source: ABdhPJxx/ZB+iAIYYGWthfZ5MCRw4ljJiAxyhQbM9fSoZJcW8J3//Xuvzi/v3xFDYUKOn6kD1n3mDEB16b4Qbpmiyyg=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:55ec:: with SMTP id
 bu12mr35584454qvb.0.1600460143930; Fri, 18 Sep 2020 13:15:43 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:33 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-28-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 27/30] arm64: allow LTO_CLANG and THINLTO to be selected
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
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
2.28.0.681.g6f77f65b4e-goog

