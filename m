Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926632706A3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 22:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRUQq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 16:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIRUP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 16:15:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3BC0613DC
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i199so6609541ybg.22
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 13:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=o2DL67IOGBCnkKLJVmvx6mUhLGuExASqR4QZ4OZyxOY=;
        b=BCRPev+rE/eCdhTRad14OxKPRC759YffFhBrw/j99zRl+XMk2SeRH2Ro57Q+fpYAoY
         41dQCr5nRdN1nuAqPl79eRYF7Et/K4hrYua59TnFUm5Qft7hifOftA32AELoX+E867b9
         2jVvQFpvTUQ2M35PWVTe002iSNw0bKhWwMU3J5xh89MftQHJTF8aTjqfy5S8odXPfmkR
         B2V75MstoeJ9GqBepGfubW5/qhE+jhI/WYG/r7dM4O293zVEla547bOEPQpSKmz7YdJU
         wGZC1Jet9cEIKlifpza3a2tLHND8kbzGrtrT3REGXctWnfeV7IsjeRGJP72+hJcsyY8w
         zCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o2DL67IOGBCnkKLJVmvx6mUhLGuExASqR4QZ4OZyxOY=;
        b=uBWVeH9Gt0w+sNJpZE0UdZfNqFh0u7+Je7ai+x3ULCmqmGUtKj8gBz9Ry0wQ/+61gt
         bwmkqhKeyrjAf0V3aBrt7vhy0no4csVJ3tVbgU049ywBv+RLaAwHwYyqgz2LfTX+QZP+
         XLzylkgKvRXXdzKrVTpZ3YgQvIVwf1CB/hsqCuMTIJle1nYue6AB/WPI/otwRMXGv/60
         S/1N7+NmC81G0rOX+5VObVXRWaqGQVLM3u/PztZbuwZpbtRQNZiLMt6Zve57g03DZR4H
         P2UCSVd/p7jMXV3NgXNJf1Yg4Ng9oViazjnE5qCcMoSNzhE5udh0sJyZvScy/nbFUdUu
         otVg==
X-Gm-Message-State: AOAM530Msj2/9jqz64qUs87jjJVv2t5aVXFtXwp6ruoysun0yOUWhQVx
        sK5/FAZqLAOIC2+IYwLA/KSrQh+RFaao9yzn6Mw=
X-Google-Smtp-Source: ABdhPJwrzpZNvpYit1QmzfPWE8TC9Luw0JQEd0AJRVJCA8aClr3KtmTNrVIGHe8CNeT/kpakU/IVCxd5qz42yc0kkDA=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:887:: with SMTP id
 129mr35650576ybi.513.1600460151944; Fri, 18 Sep 2020 13:15:51 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:36 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-31-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 30/30] x86, build: allow LTO_CLANG and THINLTO to be selected
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

Pass code model and stack alignment to the linker as these are
not stored in LLVM bitcode, and allow both CONFIG_LTO_CLANG and
CONFIG_THINLTO to be selected.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig  | 2 ++
 arch/x86/Makefile | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6de2e5c0bdba..0a49008c2363 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -92,6 +92,8 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+	select ARCH_SUPPORTS_LTO_CLANG		if X86_64
+	select ARCH_SUPPORTS_THINLTO		if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4346ffb2e39f..49e3b8674eb5 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -173,6 +173,11 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
 endif
 
+ifdef CONFIG_LTO_CLANG
+KBUILD_LDFLAGS	+= -plugin-opt=-code-model=kernel \
+		   -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
+endif
+
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
-- 
2.28.0.681.g6f77f65b4e-goog

