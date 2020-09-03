Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8B25CA88
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 22:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgICUdN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgICUc4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 16:32:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73CC061A0E
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 13:31:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 129so4022396ybn.15
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gZC6Tdrs+v21YOKu6+arkvfjaZ3DhZrnypdcQEca1D0=;
        b=foQd1ccGGkpo+boEYd5oWFvOEqUFsLOsw7HcQjk7CIRbm5LCTNdOl5wa0EML7/VvYr
         hSLaVdQouhjHuUbPo9f+4M/xtC0IJ15IspdRTNtqyRPgMX042InznCYV0QaqUuGWaZhX
         yr7qh5/zqONdjl6THb/gM+tHALShdMZci7V3798taH3nzPLYknSe4WOZdF55ISWlVC3u
         oLyB9I0hC5kzOIAog1H5BSrk+Esklfb706f6Xf7yzVXsjl9ZpU6T7CFpRH7UhCjFZzfF
         BO8x4gbp7vwKwvsRhpfOm93Ook2I3FtazoTsJN46AzCHKk4H0tMI+BnAuZN4NELK8Mrk
         NY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gZC6Tdrs+v21YOKu6+arkvfjaZ3DhZrnypdcQEca1D0=;
        b=LQ87oA0mqL+Z43poF1+kkuNUECPDX6UUiNjt5GOrs+B3dZ1FYkyPXEQqrAM1BUDuxR
         AhsnRFvyGBmnnmbk5dp/8qFwK+RmRFVtx7QHe3RaAIRyWWfAv893a73BN7RXFQ08XilY
         sCEYYmSjbc1Hojpnbn8tfXStn37U3aQsJe7k/Kvy0Ny75wl/YOF5rCPk/BOptBGYnajK
         GESarNq5aeGMvm3Q5xwB+cHBJ1jdKXTU4iE3V/cpdvZtkR3M7IEZPCORQSTlr/Z0CIaH
         p+yxTJe2DKgaIdlE84qIyEAmtPsHQ0OhPU5VRjWxiuCmKz/YcsxzAaB9cb7JGhAhDnoq
         eOEw==
X-Gm-Message-State: AOAM531M7NWews8qo+kznU9WSqwTJfxf07Z7MF/bUN5VIZgd9yltwu1K
        krWtviWlpoqE4ik/vaTl1Qg03XOIDW8JqzxFKpY=
X-Google-Smtp-Source: ABdhPJyXSwgng3rbQFnr3rvYfakxH4HxONln41kDPV0y/dTw4tzhlXUtl0E/eHCkBgnTPRrKKknIT40to5VxsCjgMHM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:d84e:: with SMTP id
 p75mr5687011ybg.94.1599165100560; Thu, 03 Sep 2020 13:31:40 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:47 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-23-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 22/28] arm64: export CC_USING_PATCHABLE_FUNCTION_ENTRY
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
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since arm64 does not use -pg in CC_FLAGS_FTRACE with
DYNAMIC_FTRACE_WITH_REGS, skip running recordmcount by
exporting CC_USING_PATCHABLE_FUNCTION_ENTRY.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 130569f90c54..eeaf3c2e0971 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -127,6 +127,7 @@ endif
 ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+  export CC_USING_PATCHABLE_FUNCTION_ENTRY := 1
 endif
 
 # Default value
-- 
2.28.0.402.g5ffc5be6b7-goog

