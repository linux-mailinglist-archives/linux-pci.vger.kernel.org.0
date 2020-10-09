Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC06288E42
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389846AbgJIQO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389777AbgJIQOV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:14:21 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC93C0613D9
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:14:21 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 139so7106256qkl.11
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IWlwO4V8zfIKj2VoQVJSOpIzEd6XIOwNzizfhzYsm+I=;
        b=icGF2o4BoUC5H7jDfDcqIeIDmztt1DX3EBV4AR9CIZel1UdghtV62q3fzjA81E5ME4
         x9g3yQfuIaLSgx21c6ABnIjUmaI4VqxjY4B5WnUXRoUb92nAtC/XbQPpxdBRAKJqH+qH
         jcvBMX8XEpz4rNBFWhnnnRs6RxEEg7NtFbXbUMhmEcBsm9ep+5oJx3BqoMUfqRJe9eh+
         HQV2rljyVTcunwoXwynW5GLctChORkFUDmM1/j1sk+6+WxF8Dg5/LcVdGd37dGhF+GtO
         M9aoDBKTtmJg2M/huHN2yYE2hfJUvsC+WO6y4SzBmnETs4aTNvX9A0N+1ApFOCsrkyFd
         VCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWlwO4V8zfIKj2VoQVJSOpIzEd6XIOwNzizfhzYsm+I=;
        b=LSTDmszXArxlBh3IgJU0vrOnxVkn+/StAfxy7ePnRmQPunWkW47tSlKQC5322xHSLa
         UpGLot28lo/4Tsizhabmvfr5xSFnp3Y6grw9SdbaodSRzhr2XaEwzBebozsgl8ZRCnlN
         poNH3K2aET9x8AZ6JRo+p0Zpeokus1OS4wqW4C1w4OipviyoHD0cd3ZItuabXwQ1VJ5m
         ZghXU6EW2ud+aEv7ds+LnZhcq7OfPbHg5DkAIJ+bMy9GEPUpXXZQmhniJhVX8VETIzUd
         U5u+Pdz+CDbq76qVWqExaM5EVrFVRja6rH2gbGqMOPhlKMhbiBmr5RyIsy5eRufIyOyP
         aBDA==
X-Gm-Message-State: AOAM5312wDQY3uBc+U3iHee70ovncVcrZWgzD3fi3Iz6oSkmpc5DBROq
        Yo/FTPbiCz+MdNWZXE+ZatSum8uCkXhW96InlRE=
X-Google-Smtp-Source: ABdhPJxEWHAvyNkdIDlQRKJ2smQRYfbTU12bNHGd7NqYEmxH7inHJ1sIHSNvQnTIBhdfm/bIQe6W23Fz9FB7iOfrFU0=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:43e5:: with SMTP id
 f5mr13905635qvu.12.1602260060762; Fri, 09 Oct 2020 09:14:20 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:29 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 20/29] efi/libstub: disable LTO
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

