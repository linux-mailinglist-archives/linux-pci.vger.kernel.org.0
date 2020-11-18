Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6082B8780
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 23:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgKRWIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 17:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgKRWHn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 17:07:43 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD91C061A48
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 14:07:41 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id b20so2196296pgh.17
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 14:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OmvLBVHrXYJgk90zzJ7qPiL6Oqy/f8wdr2oL1+M7ruk=;
        b=OOlRBBd15lFDmzj+eQqhl6JOtOXoAglrgb4iMn+oJHxK0ENZkBjJjpLRPk8q5A7SFY
         ZxOzbIi6eI8fOpXWY6S1PtuFb9wg3TX+Bl/FrS4kXMHRbAe+z1Spr6ZgEqWyaJ5aKKGh
         CYZOPt70DGmhjLkIIlNFkUn5wAZcqd9p24/TP07dxXRKEgV6/xSmfaZiGowvpnrChr3h
         oRO+CqR4Ru8/QzOnLXn22YARn7ZtJna8chF9gED7FTMLvJ5bG1fnbkKMtM2vVSGmCzM9
         01mn+DFFeos8A/Ej3OQuxmZxuUaqeCTk5sVd6ATqwCmTjVTPWyZ/EVXTwx/DNAKAAf5i
         Lm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OmvLBVHrXYJgk90zzJ7qPiL6Oqy/f8wdr2oL1+M7ruk=;
        b=og/FzBoDlHqgMydZaHtrC5ryA44mk3Y83fuKwTkDcJvy7TPbnuDJOoGUdZxXhu9QBq
         uvbP5oUdDBfAXeCx1haC4kllhmY2BJHCLFG+CamjJp5lXMhMEoSGF0x/0qreEj20ubNR
         8mS8eCYb9Y7rvN0e6oJbvPJdWJRum8jRKIke25FmhauByz07santdOtgaKcCPVaLd0nU
         uJk5TgtGs4yZbSFEs07gaD76AlG4HV1TTiFSAxV2q49WKX9gc75QcIJnvurFr1QFm2q5
         ahxyp0B4xBhpvEiKzLg+oGRoidpKyKPxDE9WogYFsXsbDxAiaDnm5pJypXmjVUB0JNd6
         AShQ==
X-Gm-Message-State: AOAM531/N9+0d7M1/681BcfmKQXoP9w1gRgKwR2jz+GvCfPxKF8IJwL8
        WlQ2WFcsh484X+U9Jic5HamXlX8jP+IJ0hAnIeg=
X-Google-Smtp-Source: ABdhPJzDNOiTYuvtSCpROfZDlglre2puYkkaLcBNYl9GE1qztV2AAXOG3khM8OqSsFXToIMyXQUc4gcbg+Ue1s/szjs=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a63:550d:: with SMTP id
 j13mr10510189pgb.365.1605737261156; Wed, 18 Nov 2020 14:07:41 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:18 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 04/17] kbuild: lto: limit inlining
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
index f27c0da5d05a..bee378f9fd50 100644
--- a/Makefile
+++ b/Makefile
@@ -901,6 +901,9 @@ else
 CC_FLAGS_LTO	+= -flto
 endif
 CC_FLAGS_LTO	+= -fvisibility=default
+
+# Limit inlining across translation units to reduce binary size
+KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 endif
 
 ifdef CONFIG_LTO
-- 
2.29.2.299.gdc1121823c-goog

