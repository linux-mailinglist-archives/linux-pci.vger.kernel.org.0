Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE5207D69
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406574AbgFXUeE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406568AbgFXUda (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 16:33:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F3C061799
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:29 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s75so2510621qka.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0gnBAHJLx9lqO/s+HwJkcFCIJr1VhaUKeKhoSxpNVYo=;
        b=BZIaPVfK4mM5FaEgiOXOWzMHkzLTbGkEfiJOtrAEFVfi2gebzUCHiY5apTLMtfHkTM
         l75+dKXwrfuQQVQD2stOWlndadQB1Zc6NUYn/q6QeMRTQnSqWTMGKUHewmR4G35OHvGp
         b5/SiArvL0S+A3ZHxVqs+VYlHjtrFUCuNx8i9CZCiQNeqcMm9dSVbAn39gIUe0DUghnD
         /f5TKe7Xx1FfkMjgZr3OsJkbEjKTvqcrDihZLf9/s8waWGOostMsdN7liEE23xBIKS3z
         6Rz9E3efblWhUua9EUcgFt56u58fIXV0W2fm5zALG7kNoivW4ApgaZxGRBArCosaw+co
         NR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0gnBAHJLx9lqO/s+HwJkcFCIJr1VhaUKeKhoSxpNVYo=;
        b=hpHvr+ywWEVC1FzKqTTTJyhR5YCqRjc0Zvv3Fg2Ujpr7OXNrStxRoXfC2hKAROfyK9
         3WJgy+QF6D7nHIVSEjFCoU64MWzwleWaMNRrfqCEGADIawVLi0330wOrnMA7Y48OzEeC
         GQwRxfnyf4B7w59IMF82h8IdCymmTZqzt8G7Q2MuifhmfJlwI1IeH+dDHJiJNt6poHaw
         Pll72XOTH0S85UAfWyMy6yrTxBPT7jdojpRGCZaDyAc2hChQeZY6CDoKVlEvpWhaNhHf
         yXDxu5oxo+rTQ3MkZhDPRVF+Q+tl0yoHQCEmnx8RGcw/A88HPYB8nQly/Qy5h60/jEj+
         namw==
X-Gm-Message-State: AOAM530JGO0ByiTw/7ecZZepp+Mjw4KMrpBuzlqjfoZ1UiH2IBU/yORJ
        BSIiwuQGJnHQbUrmDVpsjXxsupp9yfq/tkNNCbg=
X-Google-Smtp-Source: ABdhPJxTPJmHGzX5Q2m0yR96w4zaIPYDqCpLQon4kItXV3AD16e4+1m+5QFH8jaic4yItHA3V16FC+0hhVHCKPD3doc=
X-Received: by 2002:a0c:ec4b:: with SMTP id n11mr33232031qvq.103.1593030808901;
 Wed, 24 Jun 2020 13:33:28 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:55 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 17/22] arm64: vdso: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Filter out CC_FLAGS_LTO for the vDSO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 556d424c6f52..cfad4c296ca1 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -29,8 +29,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
-KBUILD_CFLAGS			+= $(DISABLE_LTO)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
+				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.27.0.212.ge8ba1cc988-goog

