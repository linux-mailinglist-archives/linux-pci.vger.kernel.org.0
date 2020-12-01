Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9B2CAEC2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 22:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgLAVix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 16:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbgLAViw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 16:38:52 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA48C08C5F2
        for <linux-pci@vger.kernel.org>; Tue,  1 Dec 2020 13:37:23 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id r124so2464086qkd.8
        for <linux-pci@vger.kernel.org>; Tue, 01 Dec 2020 13:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IWPxRCPjFejanLxpgRG3fapg45p9YOPZWT66lZNPqfI=;
        b=YDu+NEbK+WVQ3hPM5go5aRizvBPWGGUzdvz8JEp/EAM6XiJoc9pJY3o1c2yVOjp89i
         bM5tOhFBbqEU2HQ2OR1Oz9/GYaHkOiYtWb5Q/Up3jv4DGF65KdvTcqz6rms02w5eohLl
         bSgLnGHcyC3YR0xGck//SCcspRfKindzzlyNPE4Y9xXTCXxQ4vUqhJqdcirb9QLh5+ns
         ApAi4cfhdsSK/ZIzIp7xZ4Eh09o6zM62jKDTDmzug7/qSo6JjgobotZDPriqLtM88GHc
         /m6WRULzENBGmq+MzEixv/Y7a6Pjdo782dcWw/2FdAhHAKNAMhOCFWjGtsnxviZBNnlf
         h74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWPxRCPjFejanLxpgRG3fapg45p9YOPZWT66lZNPqfI=;
        b=G78/vQ2+rLuGtX7PKmoN9TvGFe0JHsFzVAYXCaHn2jBvdD9IqnSy5LPcfdMQrwqhDN
         CNQ89Iq/eGi3JJwioIaHOaQpg74gFYw+RkglVoCrEmbmUPg3Ab9+/3T/lE1jb3777neZ
         wxOjvYYPMt8QADQhyuhDh9WKxlflWtZyqFyzWa+qNY6wEmKDmMVimYAysAZgcC8BmG6o
         098qpPfyrRk9QM0smfGNjjkj5FBtHjvQyVfox+Ju8H25OuBvErlYqH2l5Zz5rIygfKpV
         X9MpYOQVfjpo1XWsPYSQmMYtcROyWimwXm1PvD0qMU4kilW8fJLPYV05AMbJMb1x/nR7
         r9Mg==
X-Gm-Message-State: AOAM533/wzidK4btk2TkiK0pQo9dJpAmZR8NZg4K6WPTSep1jcyJXHnE
        nz1J/RUFVhI3PSSHvj+dRLVWKronkOpxBIwEj44=
X-Google-Smtp-Source: ABdhPJzl3kQyAlKR1pr/4OX/xbphbD6nNLxnI7REpTqaNoxBrsxlLak2ddu4/JEFd5wju+8eNvtcAAOR8w+vlfUWVUM=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b508:: with SMTP id
 d8mr5050639qve.8.1606858642454; Tue, 01 Dec 2020 13:37:22 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:36:56 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 05/16] kbuild: lto: merge module sections
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

LLD always splits sections with LTO, which increases module sizes. This
change adds linker script rules to merge the split sections in the final
module.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/module.lds.S | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 69b9b71a6a47..18d5b8423635 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -23,6 +23,30 @@ SECTIONS {
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
+
+	__patchable_function_entries : { *(__patchable_function_entries) }
+
+	/*
+	 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
+	 * -ffunction-sections, which increases the size of the final module.
+	 * Merge the split sections in the final binary.
+	 */
+	.bss : {
+		*(.bss .bss.[0-9a-zA-Z_]*)
+		*(.bss..L*)
+	}
+
+	.data : {
+		*(.data .data.[0-9a-zA-Z_]*)
+		*(.data..L*)
+	}
+
+	.rodata : {
+		*(.rodata .rodata.[0-9a-zA-Z_]*)
+		*(.rodata..L*)
+	}
+
+	.text : { *(.text .text.[0-9a-zA-Z_]*) }
 }
 
 /* bring in arch-specific sections */
-- 
2.29.2.576.ga3fc446d84-goog

