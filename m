Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE482D7E8D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 19:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391009AbgLKSsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 13:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392345AbgLKSsF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 13:48:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0CFC0611CD
        for <linux-pci@vger.kernel.org>; Fri, 11 Dec 2020 10:46:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t187so9572472ybf.10
        for <linux-pci@vger.kernel.org>; Fri, 11 Dec 2020 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6mEKvNeY3wq0rs7jAFLZaZQm6yt6Fm86WJ405HnCM0w=;
        b=F3+ZlsJ4J/cRnUap6emR8N4b+Xouboife2S7UkAulyFopMjE2taVk9b7ehRGq4lP6n
         TWsU42g66xrNtUHSwJP7KHpC9+dzh6DjSzVNB4ihF3HNbGrWLATePQMHxzMsDj13lrQP
         azC/S2KiPkBzTIoYgS+nAssox204PVtPACYv3/zBjhusnbk5UjStmi3SxWetk5Rg2kzv
         z8nqf6A2Nm0mG//A4/l4+LYdtA+F++wU6dqyimvIcOKEyC4WJMPShNvMtY4e0/LfP4ix
         QdZ5G0gBeKAaM4Af5u8Kd8vvAtx6eHRH3G4aF6b+OJSo0XA9zUkdzMJPMR2eih4tOekj
         Yqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6mEKvNeY3wq0rs7jAFLZaZQm6yt6Fm86WJ405HnCM0w=;
        b=GnVzS/mz4vij8ImPkPI2DH5onk9UUwzYB5lI6WurEk3L5wqf+xnuOEiaRKLWKwSbc+
         3q+yW4Oz5Aqm09hdaO9piBy/6yAQYM6ODEqYOc149Y3qaXsVNPnxDOx9VuxKPxH1GRLJ
         yn6hALTWSyM2jAa+ek4T7wUOGiycKk1AbB5gTzKrlc4SmiZiujvpkp+MxEIq48qqotVo
         S3V1KXuYklOKsBv2QkM9evInV4MuZEodfxCIp+6R+ULlDw1Bs0/C6iT8cjOLjaF3envz
         2Q25VuBwQ3EwCq4h79Jg9Y1NFphyNl1m/yDje57Q+qaWTeuii2F0NsriPHlqoM4SSp0u
         2Rdw==
X-Gm-Message-State: AOAM530RYUUzbNIHPgXSF1ivc7bYzOMWgvq9Xg17TpccYwri/3eGF+Bz
        zWrnv9Jnerl8z/xXhEVfwcR8DiH721qXx6dcoEo=
X-Google-Smtp-Source: ABdhPJztdLpOmb8z2bOpx13eLpmFbg1IRTYkNtur403j5lUtJlMBrXobhq6mew9nU+bYggfLn4Aj28+KN30Fe9rq1PM=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:7d04:: with SMTP id
 y4mr20471824ybc.110.1607712403064; Fri, 11 Dec 2020 10:46:43 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:21 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 04/16] kbuild: lto: limit inlining
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

This change limits function inlining across translation unit boundaries
in order to reduce the binary size with LTO. The -import-instr-limit
flag defines a size limit, as the number of LLVM IR instructions, for
importing functions from other TUs, defaulting to 100.

Based on testing with arm64 defconfig, we found that a limit of 5 is a
reasonable compromise between performance and binary size, reducing the
size of a stripped vmlinux by 11%.

Suggested-by: George Burgess IV <gbiv@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index a07e3909e5d0..84c60f38ee3e 100644
--- a/Makefile
+++ b/Makefile
@@ -901,6 +901,9 @@ else
 CC_FLAGS_LTO	+= -flto
 endif
 CC_FLAGS_LTO	+= -fvisibility=hidden
+
+# Limit inlining across translation units to reduce binary size
+KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 endif
 
 ifdef CONFIG_LTO
-- 
2.29.2.576.ga3fc446d84-goog

