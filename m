Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D642E28C64D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 02:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgJMAed (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 20:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbgJMAdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 20:33:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB871C0613BF
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:32:59 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id w78so13147985pfc.15
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s78GraQfKANUm9dTCmVzo29Dpzl6ui3oK0KuklmHT+M=;
        b=UStis3hbnwPX4GBdlrEziRJNAuXpozGmmfM1jjzsAsE8VSqd0cbY6odMaz39IA0Ojw
         whXL6/eJ7EeqBedFDwaT3w5Q+1TV0rdJwA3Y3y9puXLwfjf7F0qnCIboZUysC1WDMVid
         4Nj43Y1l6hIv3BvqtYvKlA+3y+Qx5yGdBGC7iek7d9zIgRpsjTFpfGg7cM3b7K4jNPc3
         C+tUthfv3AI4pSRMqj3k+jNvTZwQ0NPU9oBd39SNZPMR7BGOFp7+kKDm9ZAbYc3IAGak
         ZWMXtsvozkuOgmM9rpB2qjGh1x8II7JaobE2C/HaxwERoWZW6ZWfuMc4skxi/3WZYGIY
         484A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s78GraQfKANUm9dTCmVzo29Dpzl6ui3oK0KuklmHT+M=;
        b=Gr+iW9Maqho+BxNk5O5vUsq2t9rD0mLbZozyvF84Kpeu+KjYmSozS8HF1DDHi5Jgs8
         DEsCyJcxglB3UoN9ehEbII7CeaJDzHq96jO73THcoqmcLnBGiFO/fmPLqZVW0Mo8a/rK
         vqRYz3ARFQ5Mny+yqTzTMqvoje9mgdUmgIkA8IACzcIAt0u0lR8waclobxY4+p1ByMbp
         5wr6oTWe/ARmq0LbuPnMdvkgA6HeINJnKHM2uAVhqlLbvTbDTpmPobrqUAcRPN9X+rzB
         d0X9iK/Q1y6dIdmJ9b9vI4Ksjj7V87Rc055jPbaCzyY3qn3IB8KDfANuQ1mE+G3WIw6c
         KHcw==
X-Gm-Message-State: AOAM531uP85Yz48iP+VFqN8c2bbIxc5ODDRgjt0eybEqscjJvlySvzZS
        09fmWTOuoQcw0CBDYNKNZnPKGFp8hPIu9s5wKxE=
X-Google-Smtp-Source: ABdhPJys+9GAtwDLSAFaJoF/SaTJzh0YT4ITojDPzI8BvdeCNUSIWeGX02fenqn9RcJYa4C5XTo/mbLq+dmrOimZhu8=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:b40a:b029:d4:e1c7:db59 with
 SMTP id x10-20020a170902b40ab02900d4e1c7db59mr157311plr.85.1602549179447;
 Mon, 12 Oct 2020 17:32:59 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:32:02 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-25-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 24/25] x86, cpu: disable LTO for cpu.c
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

