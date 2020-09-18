Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D851F270683
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIRUQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 16:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIRUPf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 16:15:35 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3CFC0613D4
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:34 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 6so5569119qko.8
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Aq4KaYtXPvsIFu2w9Cb9+vNMYXxmfrCDkI2ZzAJ/U8w=;
        b=YYDR5W+pWvCCMlsLuxLz2kP7xV+uq2FmsovV4iGNvno67WC358C4PSNmTbdGHW6cZy
         Xr2bfek6oOyIlLCqqcmz58AwsnwR59RRO+p9vcpDdt33YhN8IrJ/O6OhGAnZkSzVXUBi
         juaZEaotR1IoDS52HcVfmR1tV9lf6hMZtKDYu+gLSSBc5p2YM9N18q2UMIgXTdzr3uIq
         Fm8Rp3KBn78V9C/U0MxUKT6AZU9wjegUqE9FD6bezlPI8xyTBnsPinaduX3IiPx/NQx9
         CiLebwGjfIl4ZFQ0mM3lJvlbPYemZFWx56rfr5kUCzWThPFDwAshAHrFrPtMZk+I/w6c
         LAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Aq4KaYtXPvsIFu2w9Cb9+vNMYXxmfrCDkI2ZzAJ/U8w=;
        b=RYUqyGZpxnztupqakaH8XCSOD29loCT2EsJFcvs+AqeUyycu9n/sKotteKECkveSO1
         mRgyiLwS4pTTnI7NKsJV9v4L8+J0NHwK9tSjfyVARs+SFiqcUMHea7EsA/5EKTyBA5lP
         pVgxasaUa+Yhd2HcZrrFYpv2a+ikG6L+Qu55Awm9E97v0myQM+OB4TgfV3Vc/hZYdYn/
         P0rNKSswZsFPm78lRLjLFpmEFqbRwAda2ZXS0dobAiA4GhpCBUZUg/Acjb4KO/n11I6c
         cJqbCN9hdSSdw+2SsZJtVCIqoNKJ4+1AKSHvNs50aHXkj99aw7BlPBnqfWaxz1qr49h3
         eMkQ==
X-Gm-Message-State: AOAM5323bZBT6Dj7TQL718c/8BEH7JqBhVyM4Pwi3QFkifz2SAsnhWGg
        RNwsCl093y5jWgt8JbwNwzXuhApmwyYsNO5Htm0=
X-Google-Smtp-Source: ABdhPJzXb8qZ74hw7N+WHo8RG9mWCgQryKG+Dq+aV9VBYLvnlICCRjFkSfcNOp4lq06uZySFvKcVSM3OKhDJkRKVbys=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4d87:: with SMTP id
 cv7mr19182556qvb.49.1600460134116; Fri, 18 Sep 2020 13:15:34 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:29 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-24-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 23/30] drivers/misc/lkdtm: disable LTO for rodata.o
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
2.28.0.681.g6f77f65b4e-goog

