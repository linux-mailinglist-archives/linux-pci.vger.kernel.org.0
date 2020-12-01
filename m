Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4256B2CAEDF
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 22:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389895AbgLAVj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 16:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389847AbgLAVj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 16:39:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CF8C09425B
        for <linux-pci@vger.kernel.org>; Tue,  1 Dec 2020 13:37:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e142so4033219ybf.16
        for <linux-pci@vger.kernel.org>; Tue, 01 Dec 2020 13:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2x/zjVn7tqzzMwlgW94lOF/53GHge2qEfxVssZKSVKU=;
        b=N2hjZ+w1m+tzNKULGFriHMyI0W/WLxUEDGY1DnBMXxPtD5xhjPfovZ1l0CpNo2iRQO
         +tTomPyUoponyE1362CelbbrDZwWrvZ66ad2D/JxuGm1GX6gaUseX8hQbfi3OUGkhp0H
         9SmgV/+6Q7Bt3K0LuNqv/RrzRFY59diqYwZBhEZG9fnh7VFPaEUCT6hXis0JB7dm8/Jq
         tWSPkyod8RuoKjamef9WjpoKLdp1BdmoMZ4kk/XBfD1LF2w8eoyA6CMmckQwNxU7jj5H
         YD9zFativ+Sd8bT4A5VYcPCPPXLEbmnubfljTsMu/1a5ZsRn5Qy9mkUKuq9Y0tLJtllx
         jchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2x/zjVn7tqzzMwlgW94lOF/53GHge2qEfxVssZKSVKU=;
        b=sT45soYepgnGh/Clgt+xnINFWtvHe33viGgS5TD84Pf+kQl9dcJSWfVFvC+59USfYY
         Ilb22RDjawQS4Rm3+c7M7JbXVvhEOT1Ga7ucUe/E0Ohb1VQPsz+WEO5bowfrKuQShBuV
         /4W9DsEt1VGzwpTWbUzaAQOmTWzBRIixcDW3yk8jlbiRZUeKo2kTEx95L41c1fhW/B68
         ClO+N/A2jvEaGh8DBkdRknA/H1AajElT8mERC1kFFLV5BpV5mJnklxdA5Fp46Pm4zoAm
         V6AxbXsRHNPiQyJ93kpaqqwlK8MIKcCfiFXOl9rzCyVrs92Zv4PxIv0Kp+054wQO3Gfz
         xK6Q==
X-Gm-Message-State: AOAM531Fun30Jh7eKbpin/aFsvsNhY43lSAaT7WiRe6mlL2oyrcBAwT7
        kHPvB2aTcXUjBTxe28Cyfj+9PNyaRbNlSX5dq1c=
X-Google-Smtp-Source: ABdhPJxHcUCj2mucLF7aE1IOS9CUSMZkQ+YtaXx/Kwh7BPBYbWWQuO91AIxxkwqaFlZSB+yJbXqZO28tnCnqith2Mko=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:c106:: with SMTP id
 r6mr7621086ybf.519.1606858660290; Tue, 01 Dec 2020 13:37:40 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:37:03 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 12/16] efi/libstub: disable LTO
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
2.29.2.576.ga3fc446d84-goog

