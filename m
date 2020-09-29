Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56827DACE
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 23:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgI2Vrq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 17:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgI2VrY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 17:47:24 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF09C0613D8
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:24 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dj20so3333658qvb.23
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SMR2/Zr7m9btCDRB/0Z/w2MTVhq/37ih+00xVpNqJoE=;
        b=BzhS1T0xYeEiySZIOFWUBMfKhfKV0HPZIieZxlx9n3aL+z4pvUMG5Ng4jF9unkKap/
         tO9mqZLwYCHnW4SoQoRDd9xj/JuUj2YsNmmiE2W6UZ9Itp3mKe8kS3gKBADOR/nGL3He
         otJNs3Mijsx+Zkiokc4jCGwVgbgADg7TCEk8/IVeBXOhMnE5Hczz4ADi7wiEyV9XxDnQ
         CBCO0JHTOoIbLsAtW5aT9bGD3uO2HiLFrmGsIOQJmaWMfyDYVuHD5zcosXBXFN0QKfe6
         OUelHGKeWMSnmfva0aiqsCtg7FoCJjy5OfR9BBUjYTviAyQA6MbK83k+CKxB+opxcmzD
         8gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SMR2/Zr7m9btCDRB/0Z/w2MTVhq/37ih+00xVpNqJoE=;
        b=OHrO6KomFqOIyKrua5EG1tkHm4dgRntL5El7f9/EVQSrP1+dmE2gfzMRw6L3YZ8nwb
         qJZOojQ50GegHE3njJhfkqGP+Vu0RFryoCjJdQpW3RKyUyw8WfKKq9iMVWUxg83modDp
         eL4pxJM/o2qGo6mIITQzEcT9XxXDiVyEK7NqQe+vMEoZsrnfoT5wx9o1/bt1vCUOOucY
         vmuI9LoSwoer4NV5hzxe459AYyUQxkoxDcjWIVSCooflLiVkU8z6KmH0BsszLYogC700
         jfYb2hmBB5RaCw0RDj1M7VBCd+sqfexcDY0GDbgILTPi54ziw14UIZ2pb04wuv2zo6xE
         fCzA==
X-Gm-Message-State: AOAM532bYPR6JYssYfB6fq9WdliR6HYc95QnZQR68bp8Z0iJPRfwjMXk
        5aOiujhG+U8N37SKJCegsnkBgSzFjJNEw8dG+b8=
X-Google-Smtp-Source: ABdhPJxBMrynxyAmEuZVv9LuIz06tIes1P0/ZQj3AQWscVUvE2zt/WDYQVICvMnTs++j9WIGBb/QMCUTkCn1lpeTKkM=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:9a4b:: with SMTP id
 q11mr6580741qvd.29.1601416043698; Tue, 29 Sep 2020 14:47:23 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:24 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-23-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 22/29] efi/libstub: disable LTO
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
index 296b18fbd7a2..0ea5aa52c7fa 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -35,6 +35,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
-- 
2.28.0.709.gb0816b6eb0-goog

