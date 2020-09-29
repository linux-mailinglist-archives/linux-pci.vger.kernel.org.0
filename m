Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F1F27DA9F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 23:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgI2VrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 17:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgI2VrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 17:47:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC42C0613D1
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:07 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g1so4054940qtc.22
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IM6BeG4IsHqc2HlM1gNMjcO8xaf7Yq/XvaXPBJbuDVo=;
        b=F5fLd2SvpIplzncJLEztecG168LHlQrKNcKbedbFnUU8oPz2VYylmT9Mh1BQwGQWwd
         S0ZS2iRSNCDZBTJiH2iAxeyOVS4P1+Y10BtSKnYCQAn6a+GjpckK3VpZwEkV50DY8ZSy
         3HLQoiSBVf3cPG9keb+CQtet28xkKUxeLTCuy2y7Dp3C3nWOnMUiuc+XwrAW3YxiGWPq
         /2KbafujJwZBb7QLVML/Va4ooU9T1eIfCSgSGwKdUGZ9zKWbuQx17Dqr2BMzsCAl+lkL
         2CXyKcwhMnQZ7Jtse4QiNQ1zu7zDv2w3iAfRblAKfxEK4yCv2tM6mqw1dSGrb7v5pBfo
         dJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IM6BeG4IsHqc2HlM1gNMjcO8xaf7Yq/XvaXPBJbuDVo=;
        b=FglN9NqQLDu8UGyAGa1gt/AKNtrCPPrr+2I9Fmc/QV4CSTGNTCT89Cqz/JlYLu18Ze
         wS+qU2vAN8iX/2Fye9f2Yu81mLJ8wFZxDD+SRw/bToShOVObF/Yps1RKKqIMB/iouwG+
         9+Z09dgjNNrvsEOYTr9EPJkQuVx7kx5AAX4ZLLAXyNvwB1sMa7T2tp1ZkXGw0Ce5adIY
         SNZ9t4thF+8kjw5HY0/gDXJ1kvWnpBVVdRcJxrQbQxig5006TrezZPr2F7VKIKZN2ZAc
         AVqw46RAvFtHF1w2JsLU0oM+WFC83+xL2eH1fSLhW+0Ja82ZGXfOWYqwHddBO3zWdtap
         KjfQ==
X-Gm-Message-State: AOAM530DwXQ3UvAnR+gZhW+paTwxR9QW4Dwjxq1ELijtF16GSsFU188k
        h5Dj3Vy3Z1PsOTzInOX1W17/DG9se2m/I+JOw80=
X-Google-Smtp-Source: ABdhPJwNKfL9Sa5Ulz2e3Crqy4KfEW60CIVw40VTunkPV2+OV55f90wO4GzRLD40XF/w621iqWtNnOlUAz7CC7ffa0E=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5565:: with SMTP id
 w5mr6385766qvy.24.1601416026659; Tue, 29 Sep 2020 14:47:06 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:17 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 15/29] kbuild: lto: merge module sections
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

LLD always splits sections with LTO, which increases module sizes. This
change adds linker script rules to merge the split sections in the final
module.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/module.lds.S | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 69b9b71a6a47..037120173a22 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -25,5 +25,33 @@ SECTIONS {
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
 }
 
+#ifdef CONFIG_LTO_CLANG
+/*
+ * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
+ * -ffunction-sections, which increases the size of the final module.
+ * Merge the split sections in the final binary.
+ */
+SECTIONS {
+	__patchable_function_entries : { *(__patchable_function_entries) }
+
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
+}
+#endif
+
 /* bring in arch-specific sections */
 #include <asm/module.lds.h>
-- 
2.28.0.709.gb0816b6eb0-goog

