Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129022CAEE3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 22:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgLAVjb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 16:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389969AbgLAVj3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 16:39:29 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3846CC09425F
        for <linux-pci@vger.kernel.org>; Tue,  1 Dec 2020 13:37:43 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id d30so2216799qvf.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Dec 2020 13:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aPTc8wYkBIIZS9XLhaJqPHrVGew/rHRzWtLqs6SwnEk=;
        b=vXHUajvUgn40LQCYOvZPKvqCWjM82atINdDHUGd5EhIZaxvZWNECR6Puf1wV/Xm1fz
         RZFUluVJoen54/2OkeSIKDLooJAqo6nO6jmid/KnIY+pQsB0jUK1FLQCjzUfvDCGjqfW
         5DsweDMH7mPM+webX4KoPPbT06j0wd8ib/BAqCtFcLiXN9fRxFfzVzezsrV61oCpnhyb
         7uduG6UItD7EnvVpEffELx2wbLPqlD3Oqd6UlZIDNGhgDg+wEFbzFvokQCivtnRsGs7N
         92Et/EOjPux1Tii1bL3i8/gTtmbaMJpflMTGhVRAPssOG6ib3nwdVtng5zkY0hoNy4H7
         BGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aPTc8wYkBIIZS9XLhaJqPHrVGew/rHRzWtLqs6SwnEk=;
        b=UaSj3NOpCHbgEQYQ31ojhhrCfiJE9PsDf3Q3V5OP767GHn9XDTBOu9tHWVMMf199wU
         TmVxoofDjNJDv8LQt5V2wJBNYhU+wjpbDmqA8yV5GP3QBd/eYaMarzciTBhRmm3CpeK4
         4C8n9DP78NFHOi/8GphR9W+oCkkWgeQtSYvTAFx2AQrQprHPUye0SYKRCyaMeGMrfs/Z
         Y109pfDBMj3ZbkmTzhfNjy2fRVVmR8UYU925V2GM5P8tL8EBMmc/Y7HUutWiG/axHC4q
         o18x/tkE41pAZccp9hWnJxANYgRIHDXqIPG+efOvqL8PVzXu6RVR8Tw/09yl5EVFAgGy
         IAng==
X-Gm-Message-State: AOAM530Sb3ilRZ/QWw+mwjgtvRs7tgHdYQBFlqTIvgjA7CTOeDGVCAy1
        prXMql8JkwKCYE1KHOLfy3HlzbBObA1UVfmwWUU=
X-Google-Smtp-Source: ABdhPJx2UMQKvzPc9YbjuAcaOdZsXhK7RlcIM2M9pkfdRpnDBi+U9k28DqELenlSlo2tvxUYIND8c9jWK0Acmjv4ppQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5685:: with SMTP id
 bc5mr5091015qvb.48.1606858662372; Tue, 01 Dec 2020 13:37:42 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:37:04 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 13/16] drivers/misc/lkdtm: disable LTO for rodata.o
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Disable LTO for rodata.o to allow objcopy to be used to
manipulate sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..dd4c936d4d73 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -13,6 +13,7 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.29.2.576.ga3fc446d84-goog

