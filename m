Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5AB2B8756
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 23:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgKRWID (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 17:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgKRWIC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 17:08:02 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB33C061A48
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 14:08:01 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id n12so2655959qta.9
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4XuhSBro4JmbEzc1ahwEF0ocfPBDRGYBwGKNTvA6UGE=;
        b=sYNH5IySg/OAzl6C1030j5KrdvL/TknJ66ncYZZ0VJfRnkJWabJqF72HyVEtrFqsuV
         xHZDm78BMKoevfVrShC34UAWPm7inA3f5NPp/T5mwxJWNUaUEmUhisnupmkn6fu/2Gwc
         kjHvUXUV8ClEbbYTv/sJSHv6xAYf/ZgciW+HWWd1Obttcn34VOfLfUiaEuwE1mBQcIyI
         J7VEKckt5CvBwsRjuSRuQDHCbWNKrS0m4sNytF7pqSs/Xbr+4gRn0wdtIjpFJpzvj09z
         m7KNcyrQeKkKkgoq4NE1+LYU1VECryxaLniuQ5P+UABuyCF4PafQeFexbMmZ21dv9FUI
         l/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4XuhSBro4JmbEzc1ahwEF0ocfPBDRGYBwGKNTvA6UGE=;
        b=m4biCmIfDe1+yt9kYGe+mzw29/+LzXpJjJrmxVijlKNmK4mDW07s79DF4uIO79N4rZ
         zwC6xGi8K6Twdv3TZG+9CG/WcwPQ8KOFDttpUO56HeVWf1Il+/kDaxtk2IDarulnwcLO
         68wfBBdWzR7MtPH2L/f0KjN7Ww1kwGhDBNghadYOGPjbFDupelgcNkY3Idqs5S3ynWpz
         NBi39Z93OSMUnCNwITWBPNF9w6O6x7GsLadWhQJu5riyc15V4xqZOrwlyouqrpRuyZoy
         fyaVSjTQSsxh26mRTDO0g8cqprjEElF+IV51C3Uu/MJ90NfDTrMUZoMgVC5fvFsA9nfg
         ZVEA==
X-Gm-Message-State: AOAM532BzyR2+F43S53wDj3xWkAApDIuQVTI8SvIbwgw6kC6h6sotcff
        POsCSuTdlJEfyCu8jw4KkLLibu/pEHcgd77TMY4=
X-Google-Smtp-Source: ABdhPJz+m+xG4KrpgdWsllrU16+uPERUb2CyF3GRyM+22sZfjEXDruR1i7vglehue0hFGlNRVCYfCWncFBgvChpJLaQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e790:: with SMTP id
 x16mr7088555qvn.21.1605737280219; Wed, 18 Nov 2020 14:08:00 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:26 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 12/17] efi/libstub: disable LTO
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

With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
files. Since LTO is not really needed here and the Makefile assumes we
produce an object file, disable LTO for libstub.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 8a94388e38b3..c23466e05e60 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -38,6 +38,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
-- 
2.29.2.299.gdc1121823c-goog

