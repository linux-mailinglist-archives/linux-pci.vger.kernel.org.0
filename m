Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF35E288E4D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389869AbgJIQPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389868AbgJIQPL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:15:11 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9CC0610D0
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:14:36 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 135so7120070pfu.9
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s78GraQfKANUm9dTCmVzo29Dpzl6ui3oK0KuklmHT+M=;
        b=RzNTfPVYG6SI0avI+P425NcI9i8AuKh/Cl957fx8fHhzs5RqhtvTqjehKiJwWbgXzy
         Ut5C1DcliLqQ7eBHuYD2eARb+htm8HZMRcdjOvp9NNGn4mNvqg0iBQ6KDTzK3SzCI/Ck
         ew2832EE5/Csfrndf18x6wLZPdWlZEhk4iKRPcQGgrfXg3mRAuukQoAwCHLabR1+4M6g
         meKHJ7cZKth80rKvdaInliqwayqLZinRcdmYOes8g6yEPhfbWOeJqmCgiqX18se7Af/K
         ryRm6EO2IXl5IsWLnIm6FiXwA7s8mJObCejAMbR/yt+sefiZYk3GwsKgwR63hHzTDcIK
         szJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s78GraQfKANUm9dTCmVzo29Dpzl6ui3oK0KuklmHT+M=;
        b=VGbEuvOhTKshosY7cjhRfs6vgl4Buj2eQndkx5ZHJ1yFnzgeAk27SaV8uRNvdXp2SN
         mWKuyqSoI67uRl7COTeG/gnIeXV+ts+zzOaWQwO2Fz4D/QJXcxKdTBBpMGnCC2ef1Cl2
         Nv3mRALLkuZCApR71EdHUk+BZMo1qYq99bY9yF94oPREDTgf2S7YIG0BP7RTUE9r1l9H
         IdQM+oNxtqS8JkcNoKRoPT742DGED8f1HWLlJfCTQaWtLOcFM5QQXtyKJbQtDk9TOVet
         hSuLA0TI/ak2B5IwFsycjckfIrPldMdC+WzaS/7I3M7RG2TBxt0xOecfCgU5kF4ayjOg
         ZuJA==
X-Gm-Message-State: AOAM533ZjeLrl5p5Hisg6yi8Ymu2gzilm0RTzwGNiec5xiZJhVCVLg6B
        YlKSXpDIxwiyipfAjrBP3EVZvcyJ6v5jZTHGB3Y=
X-Google-Smtp-Source: ABdhPJwN3bIx6ear1i57RoG4zimPIt9+fBvTb2OARJUm8GO/EtKrElZNowbDc+vg8xMIIlLqC25fSoWhS1nT0X0YRr4=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a63:c017:: with SMTP id
 h23mr760549pgg.420.1602260076066; Fri, 09 Oct 2020 09:14:36 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:37 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-29-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 28/29] x86, cpu: disable LTO for cpu.c
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

Clang incorrectly inlines functions with differing stack protector
attributes, which breaks __restore_processor_state() that relies on
stack protector being disabled. This change disables LTO for cpu.c
to work aroung the bug.

Link: https://bugs.llvm.org/show_bug.cgi?id=47479
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/power/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 6907b523e856..5f711a441623 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -5,5 +5,9 @@ OBJECT_FILES_NON_STANDARD_hibernate_asm_$(BITS).o := y
 # itself be stack-protected
 CFLAGS_cpu.o	:= -fno-stack-protector
 
+# Clang may incorrectly inline functions with stack protector enabled into
+# __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
+CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
+
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
-- 
2.28.0.1011.ga647a8990f-goog

