Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD12358C76
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 20:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhDHSaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhDHS3m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 14:29:42 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59845C0613AB
        for <linux-pci@vger.kernel.org>; Thu,  8 Apr 2021 11:29:07 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id n21so1107357qtv.4
        for <linux-pci@vger.kernel.org>; Thu, 08 Apr 2021 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=14TYqH2ENqdx8tNGRNzk0x7BZIkRzbFF1Zb7Ap7y+mI=;
        b=HDvQ9PZApNfeAjnQLOW7KC9doRTIh6okNpM8589lZY+2eOjicKiTemkQkvkyQMeHdD
         oqBdomzQim+Gc97Fo+BScRDN/uYqxgD94hjnqyI+Uxo6rwKvcBXyVFo4/USMTXuzbxwk
         qg2hcRhzTn5P5aEl930+pnBiPB30eV6s3TB09qmkRDcTFIGeB4pMhNIe5+wTPuDDOlcm
         +CsRwIfaZFuSDD/U/wY75ESfG0GXmriI+0igXnIBdZIT0MPydBKVBLHEllZ6c/kE8ezI
         2tbcU79LOWmnoiR/ReElL1+zVMaTX1hVUMai/MSNPX90NgepS5kimMBjIqCGhriW2448
         Bj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=14TYqH2ENqdx8tNGRNzk0x7BZIkRzbFF1Zb7Ap7y+mI=;
        b=HRWUz/OeI92uewlGkevl1xbYaP7KqFk/8qhSLDMLSXjpVdKKwm3fIT8S77pF+Fzvei
         HDwZAh0xYZAMWOl0B///F3lsPvG3iv8YkZ6+XSH8FWTH89c2e0eCY+9FqNzB/4cia8XB
         Bp9ismrSp3ut+VzKrFZSwC6yq0bxSQhVAKH2suiTgEMqru0V5GHe6XkUUPRt+LoK0Zs5
         IphniKCrM/GhUcg5NCghy9leJ0aU9xfULKSKEUgHFfcwBq+5j77NVLyKNFtULSuzXrPp
         C2ZtL8CtdyY/LULaHBJ/HnQj5P7Bx0P9PFak30d7Qi/voqIZ+WSVYHBJvPD5gsoAzoyU
         Ygrw==
X-Gm-Message-State: AOAM5329870XiqHym/aGwYsWNiCvijv1jy6Q7q1/3qPDSvO4rP2R4nPL
        EzVdVt9teBinHjKL10lidhWjyDAKSxKmOBXaH8s=
X-Google-Smtp-Source: ABdhPJy2qIWEO5Ik0U4r4KHaXOyxsSt8UhM0F/UOsH1W4SX+8Ypg74UJD6u6iBTGlhqMo2VQnRoSFME0VEY+S6wlQTM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a0c:f605:: with SMTP id
 r5mr10061255qvm.48.1617906546551; Thu, 08 Apr 2021 11:29:06 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:36 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 11/18] psci: use function_nocfi for cpu_resume
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function pointers with
jump table addresses, which results in __pa_symbol returning the
physical address of the jump table entry. As the jump table contains
an immediate jump to an EL1 virtual address, this typically won't
work as intended. Use function_nocfi to get the actual address of
cpu_resume.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/firmware/psci/psci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5fc429cae3f..64344e84bd63 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -325,8 +325,9 @@ static int __init psci_features(u32 psci_func_id)
 static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
+	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
 
-	return psci_ops.cpu_suspend(power_state, __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
 }
 
 int psci_cpu_suspend_enter(u32 state)
@@ -344,8 +345,10 @@ int psci_cpu_suspend_enter(u32 state)
 
 static int psci_system_suspend(unsigned long unused)
 {
+	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+			      pa_cpu_resume, 0, 0);
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
-- 
2.31.1.295.g9ea45b61b8-goog

