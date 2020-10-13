Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8422B28C653
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 02:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgJMAej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 20:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJMAdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 20:33:39 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C578C0613AF
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:32:51 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id s8so11703482qvv.18
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IWlwO4V8zfIKj2VoQVJSOpIzEd6XIOwNzizfhzYsm+I=;
        b=kWr9Y/fqtR1gjXlZbCdcFUO5y9KCbBO6doGSE6eV/R4SdmCC/fG0VIYwLLj+OKBwVo
         t88hxunzWeAhsqD6nX4pMH3NXEN3LQTEHYiul8l16k+sa2iBaYnnGR+mH9hNA4iikAmL
         fqVb25yRhuLsNSg7v5YJjN/fVyXPqCbeWKnvoXYnl9WCtRWuKoabyI01wNyG9w6/b7UM
         4pHEaQubfMyOEQT05Qht8Nh3XzDQC3RyvotMkxtCaBQJVlkntTJDfU68nv0YNejU3LJ8
         DLC87sAOS1Egq4SGIijIlfkUP3DDU2E/gTaUdoloBdFbRBoomS8YvmW0JUlEF9bGUTbb
         DK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWlwO4V8zfIKj2VoQVJSOpIzEd6XIOwNzizfhzYsm+I=;
        b=VDzLkwtoivSg3P1x3z3Siv6Or/GEBKOw94MSCg04a/Ve2rP2qVt3XzMh8v2yoTH/F6
         KQuFwVzef5MZhDS4Yk2mVY/HH73GKb0txvN/Cn2ll0rvnHumr0fNmQe92vmCy4b0uSyC
         aORX5O4d6WrwtNCR/2wx5C5oRB9lMJXSIm2k/4wDvtcqYhFbrVlvaS7/fOdewc8a9KeH
         8kSsFDXbNMiJlkpxyhoNC10FgjshgEjHHhiykOgQBnHNEtd/qkGlButKqyaAhmRNXOVd
         EJiHa1sOAvWuSP00EHY1VXfIK9ppF8xB8mRyRnGhwD+AuDOFyZlvsWrOKHqM7I7Xo6AJ
         q2qg==
X-Gm-Message-State: AOAM530F2SPYg6n7CLieJfpifOu3/hjR0ikh0f0mNYa89czdfVvDTLjB
        xlvVsE9WN9YhtIOIZbT6P+q1VNsRf9FUL4MUGtI=
X-Google-Smtp-Source: ABdhPJxmlU/A1sroaipRnUbPqUCXYyj5EeYMFDk9TnoZTSUFb4GItjuig8hO655sUorVd0VW8HG+pUfRKD2TGlP3Uv4=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4f46:: with SMTP id
 eu6mr28230471qvb.9.1602549170292; Mon, 12 Oct 2020 17:32:50 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:58 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 20/25] efi/libstub: disable LTO
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

With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
files. Since LTO is not really needed here and the Makefile assumes we
produce an object file, disable LTO for libstub.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0c911e391d75..e927876f3a05 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -36,6 +36,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
-- 
2.28.0.1011.ga647a8990f-goog

