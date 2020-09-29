Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA127DAB0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 23:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgI2Vrd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 17:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgI2VrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 17:47:07 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B1FC0613DA
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:05 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g1so4054869qtc.22
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3CV3/71SvI9Aae4EB6SuVg1gWevq6V3dKGQQ0SLCSxM=;
        b=VsL4ntl5+hY0sK9YbHIOCU/8xkMTUwfbSaQJDJE3/xjI5F6RvBhZ95rjnSx9qzKP19
         c8dtjWQ9X1ycYC5cQdhz1pOUlwobIqAkhxQS/79ifUywIFe8vgvwUcWjLeboFlrrbcYK
         f+yGk+07cGJpo17CclConQX5GRnPs77eYx1X4Y/VF+Ljh28bTgeQSAfYO28SLdB3x+Y9
         NGL1RCxovqI1uJnDovNqoqdjqzucm59FJTBc3enczCyNqTlCQDgreBEoQ6ZIkYl4frgU
         j3XEkn1c1qgjUZRuJJnggDEhbR6LNJUg+9sOgKjHf5cebOSVhsYP16Et9tjoyV5Q4Nqx
         WMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3CV3/71SvI9Aae4EB6SuVg1gWevq6V3dKGQQ0SLCSxM=;
        b=XoViAgC71g4aMDvqT+Nj6uh8wbQ1HlqYFmNhBloOntMQ2CTqeRIViM+myOt1p36O8l
         ZTEqsRNNJEjZ3l3+XIQifrOslyUS6J+QedZZB2jRT9ga5OaFau64s4nSAqA69kG7kQ8g
         2r/7lMDlCNyt+1kyoYfyXXNQIhQmQj+VeFUkr5qii0cjUK9R3MvEtnYtGg9K2SH21zAw
         659EUI2LjHMWwDDg1/pf4NcajhfHGahBsZO+isY4Joc5kjF50C3/qtGltboh87mUWVl5
         emg/GMbjtpR5cn31Vhpcx3dzb+SDfKZyWxljvxCyMZMCjeHz39KFxzrFor8sxVw/F3TB
         WCQA==
X-Gm-Message-State: AOAM530CMND9BP3I8OUVQw18H0X4ylfvJOxYe+eSNxJkhRuuwDWZBwKL
        wEU7YW8xl1jYPHXZ44i/l5HXQ7SuAzysO54HYz8=
X-Google-Smtp-Source: ABdhPJw1rbXd3Wm2I/qDL+pij6pWpBrSY8S/UcyV+ktSoutrbImixV21BdVnAU852tswQtkkdWHRxrar/pvIuY7K2Z8=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:58c7:: with SMTP id
 dh7mr6716071qvb.20.1601416024173; Tue, 29 Sep 2020 14:47:04 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:16 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 14/29] kbuild: lto: limit inlining
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
index 23cdb475c445..d6510ee99ffc 100644
--- a/Makefile
+++ b/Makefile
@@ -894,6 +894,9 @@ else
 CC_FLAGS_LTO	+= -flto
 endif
 CC_FLAGS_LTO	+= -fvisibility=default
+
+# Limit inlining across translation units to reduce binary size
+KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 endif
 
 ifdef CONFIG_LTO
-- 
2.28.0.709.gb0816b6eb0-goog

