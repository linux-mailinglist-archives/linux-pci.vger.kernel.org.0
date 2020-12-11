Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4172D7ECE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 19:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436859AbgLKStn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 13:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406378AbgLKSs4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 13:48:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9755FC07E5C1
        for <linux-pci@vger.kernel.org>; Fri, 11 Dec 2020 10:47:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c9so11767781ybs.8
        for <linux-pci@vger.kernel.org>; Fri, 11 Dec 2020 10:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aVrOLfHwyYehNryqhGtvwSuHF6d3RoXEKFD3yMxv9WQ=;
        b=crCjjtbF0LFHKaU166OM2hJGeHx2ZHgEPciM6YDUtvwCc0Wk4S0mHDEftwdDa0NcAd
         jVAeZYS/m2qVwB/wLayUO/zJ7OQ9GjKp3zIKQxrh85/izPBL52cGu+wOe5xhEuDbMihD
         jtqoSCSPAiWs1YHR/KQXLgIREQJzaCse6S5YKqzfvzE3xM9PHb8XFuHpON0Lx2wF5dvI
         jdDA/FurnwgxMiNVD8vMMoJgmDP/60Ko/cbUmNw+NN3ZiXIXUK+gSk6MdZLTk5pwRNWm
         GbcOKP0kdz3TCy88sneI6VUHEzRwj4dCnx7ptdr9FonuwDoHCGtCu9MNXQ48V8VaX9gP
         pMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aVrOLfHwyYehNryqhGtvwSuHF6d3RoXEKFD3yMxv9WQ=;
        b=nt/s3UuzST9LfBq+xSumhQzHc1nTcOMVv7GpUGOIwhE3baiLXI1LU7arnyxywDaTwS
         rC8GP2hCleP0mR9psqHs2LegcyDs/IhUga9snqvqXptzVgTjLm1ainfxD8Sc9K1MLWUM
         GgW59zlBm81P7ffwmdjrZ9m0xM7nJb+pkrwB068qmdBrUgnOyMKqjg+pRmeL/d1ha4jR
         QYH9rF0+MoqLjkgENZotEigxAscPczfflRjzYISNgNMZSGDfYFHEuDWz03uiQ+7ceEwa
         amHNnvzOzWYHV1HL/CggDbloRaXZ64FteaeZ2eOwCVrnZQjFhGhWpo2eejIzNc52P35y
         47MQ==
X-Gm-Message-State: AOAM530wGOakdo5ZafyvuM8W/l1I+C42FrybEBFXw/RdQprTNxZJeIW8
        xOCsC9Bhg/t3mdQHhyrRl/eTikMDyZwe7EvXAZY=
X-Google-Smtp-Source: ABdhPJwNZuID1jcIf8cIxU0Ww5TlvyKdStjDCRvIBB9uhldEdK3D2TeNkVuM9PMADcBOExwezp45jHxla8E+Sk+8d04=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:9a48:: with SMTP id
 r8mr18569721ybo.294.1607712427760; Fri, 11 Dec 2020 10:47:07 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:33 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 16/16] arm64: allow LTO to be selected
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

Allow CONFIG_LTO_CLANG to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cf7eaaa0fb2f..59abe44845f3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -73,6 +73,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
+	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.29.2.576.ga3fc446d84-goog

