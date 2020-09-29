Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B278A27DAFD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 23:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgI2Vsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgI2Vrq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 17:47:46 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D218C0613A7
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:36 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id o28so3653324qkm.23
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=19TlqdLHcWDTmI9u6TYfXzttwjA+Dmg1Ug41aa4j6uk=;
        b=Imh3zKnlf2nNedw1LEfjqkhMgHeK71AVCBTejoYYCUi6PprkQk88VjzniR9FHbE1XH
         A/II2EqGYTLeEsZmDBTUvx/jf+f+d3tAzBZHwlmB+xrtw4+Z2cxN48VSSgTsz6Lj1ySD
         au/YMsmvn17ksVH6myXy9K4BV+sk2zN+Jafs8YeXGbiW03h8j+LFgn5hDUVmYV3j8Dwy
         l5E/DW5nnZBvg1KomyJxVSBEJYPTHNIcVL8vsj7kyNFLz2DfWMaRIUqUjSw2EGwIoKgP
         4DyUsfcM0sMb+V2Mle0bHYnakGr+xwU5kaLeprG/fr2kotBwhV+W2FpWkSGvxSxGnZ4G
         GCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=19TlqdLHcWDTmI9u6TYfXzttwjA+Dmg1Ug41aa4j6uk=;
        b=ClVGXFk+Fo+k8v2eoxnsqyjo1ml9OgNn9aFJZNDn/UMPEEgVpkKtQX8INYkHp3WOwa
         +2Vy4EjesAwE6NcoY6GXIXNDCu8zdJUGhORJCPTETMewMav9ccZoUyIf7XMVUAOVhbCI
         StqtIopMdax+Hcv8YtyNCxbwce+9a8Lotx/VeZlHvt4mbKideDMSjrNxoCXBAaJZObpC
         aUL+MSY7ZC0DI1L+Ta4/p+gaNTlqsxuWAolcOi/iQtfxUfCIp/yKcfc7XIUBJp7BJubu
         QWb6PDtbFJULQ9Joyy+pqTy66+FRfvcHH/7tm5BIDKqgqYswQdxCYy52mvbtfWgy7B4m
         Py8Q==
X-Gm-Message-State: AOAM531ijaljc75XW0upL3sNMVzvmfDkFQXs03OfwyqKyZiYJXyDfdJ8
        FlN4+vn0WFsY2v7lDNaTfv41guZDhpogBk5w8jo=
X-Google-Smtp-Source: ABdhPJwlpWalcJXzE9B3fP2Zu3YiL4EE4FmSmcZUIR72EOxrhafPHlFtIMBSkfJpTgmFk8E2fcAes0b129xUXc5bjus=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4594:: with SMTP id
 x20mr6549973qvu.4.1601416055400; Tue, 29 Sep 2020 14:47:35 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:29 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-28-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 27/29] x86, vdso: disable LTO only for vDSO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

Disable LTO for the vDSO. Note that while we could use Clang's LTO
for the 64-bit vDSO, it won't add noticeable benefit for the small
amount of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index ecc27018ae13..9b742f21d2db 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -90,7 +90,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -148,6 +148,7 @@ KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.28.0.709.gb0816b6eb0-goog

