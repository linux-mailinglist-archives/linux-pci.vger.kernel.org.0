Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AED25CAB6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 22:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgICUej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbgICUdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 16:33:01 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC6AC06123E
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 13:31:45 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z4so2487653pgv.13
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2NV0P0BZEhFeVXK5NU1s/CPB7b09hharJKRKaO0KUAA=;
        b=iQC3MXcnnX2MJeVDml9r32koVHGM9fCnhlqFyGQpI4kg6N+GAVi3eGpcReIyaQtftv
         +8hQOVada7+yAvDv+aDU/EX2lefZWBlI9dX0gvIJ8Kui/Wbd4nfao83zED/RIwUOKlUV
         gA5DFOuDkiclAAdzZ1/RROkyKMSuawdisMFROE1LrIYELe2IjMVIt9K4CTCeZdrJwu4h
         7qDCOjod/u5pLmt4qqLI/ZOb622Ix0toxovXCmz8FD3st43YIbEjbKdrQpK4ZVWgCZs1
         02Yx3hYWMaTbxLOVDZUON1042qKsUxlBQ0eLPqPtOoYsRyCMeWYMt5KLAQ1gBbndPuHD
         TPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2NV0P0BZEhFeVXK5NU1s/CPB7b09hharJKRKaO0KUAA=;
        b=GeLWNkVD5dTyl3XQaqndoO1XAN6mVaN7lCpTJbwwPnKOzp1QhUxOCuT0fgC+ogroo2
         TlWjRSHmpHWfodMNWutUhpCD7W5QQwxP6TusuPop8PYG2hw5wuKRqaizSRYdMH2986Tm
         Fl08B7Wwv2fr6QllQFr1L2iseMzCquEJkF+WHkMj10g9x9Cfim4VWjVOyJvKdr0UyNwv
         6oIoy4JCtAEo6XkCHGbgv6yer2zTyEPMMMlNKl8OGhDIE/NK9wswqWKQ8lHhIkCreT6h
         W0XLsatir36YeSpDCsspWuwJkhHgBLZGPdkjCMGxuGmWXRJF0waEel3TqqrqxHdhw5ws
         iLsA==
X-Gm-Message-State: AOAM533rtTm/qx8J0wsvY+7gB11azeZPMhFGFunBOPtCDvs3J5jnP/G1
        HDJGDCJlOlEAXUYTYwXBpyvItNXaeBBfFFW/CHg=
X-Google-Smtp-Source: ABdhPJxXEiK8iQgluE8U1P9eVcF55qIItGQI+hRRjVeMXkeZ98njIjZMcmdWbshQtzwoU58/viNSLC1erEh/riMVVr4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a62:e107:0:b029:13c:1611:658b with
 SMTP id q7-20020a62e1070000b029013c1611658bmr3713577pfh.8.1599165105298; Thu,
 03 Sep 2020 13:31:45 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:49 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-25-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 24/28] KVM: arm64: disable LTO for the nVHE directory
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We use objcopy to manipulate ELF binaries for the nvhe code,
which fails with LTO as the compiler produces LLVM bitcode
instead. Disable LTO for this code to allow objcopy to be used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index aef76487edc2..c903c8f31280 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -45,9 +45,9 @@ quiet_cmd_hypcopy = HYPCOPY $@
 		   --rename-section=.text=.hyp.text			\
 		   $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
+# Remove ftrace, LTO, and Shadow Call Stack CFLAGS.
 # This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_LTO) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.28.0.402.g5ffc5be6b7-goog

