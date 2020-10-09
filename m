Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0158C288E68
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbgJIQPp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389834AbgJIQOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:14:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8FAC0613B6
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:14:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j10so9282112ybl.19
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ikrbNi1n+JHv/v6pgNeNHRRr1Bi+YQ52wR6bQ2Iekes=;
        b=tcYmIPBmAJ4LMMF7Goo8MPewpphHHyqOReS8Yzjkp758pdRkXSRJFwYPN4LJhRf5aA
         pN9Uh5BwkuYUqZQemLzTTRXc2IUbCtQKHNjN5mIcJ0Yo/YCauyC18trSfmUSzycFDhkQ
         Mw/NRr5iZqjHUGg7OFZdC6jshO1bqHZmLEAcRj1iPIhFpHCfYo3PJz5q+q/Uk+lDZyQS
         v2YSMSnN1TCWlH3GRIGFB5nX31muKzjkKWdKT2ld17JmgpAwOruVsIlTZw6HcTZPePYd
         us6oLH9w7WGbGMX1ZGw9yoahG1e8nob8rvJYyjTD8MyQlv2UIB6ZpCnVJZSKFxMRhVx5
         0KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ikrbNi1n+JHv/v6pgNeNHRRr1Bi+YQ52wR6bQ2Iekes=;
        b=YnG7+wTg2jlXsr+VJ74snusrT4Xv+hObjz4dml7xzNK0xueI3Ll7amTpzfX73YB2rD
         2mV9/cEr/GTm7CU6Or6Pylq7x6Nm9pnIRMQ30KPqOJ14nNLkdmCZ9Q9FLHwhxYhLu9ot
         mrHl8jSS5BT9NsYyzzPAb5SXVG+SoDb1v9M1blDjHgRA6TW8LE+I+l+c4PWebXIMiVrP
         mAt/zqkjN9xNUeDHhXmr78F5335OAPuh8F4LqZwAmPLfMEFElZG0Q1M3vl/OISHHWlab
         8O/ZEmjXghRSAXDT08A1BCPBgjaxVXeKEjV55QhfFqlu4TulVD9imKC1GUVyCtvyMf5L
         ZJHQ==
X-Gm-Message-State: AOAM531GWZ10WMzW7YNVaok4f8yiwSidIAegGGWeVX8NIYqDb5VVAAY8
        1/PdnDCH6/4cLpgOrnFTHH9y6Jj0H4G23dKn48s=
X-Google-Smtp-Source: ABdhPJxXVPk5t6WuDRtw2kDT1l/kkKrV5Ux4Ln/BVu0jbM2WltiZb9XyefgV8OgdP7tNsodZl6ZQz6Mkv7JwoOsKQcI=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:388d:: with SMTP id
 f135mr18426175yba.54.1602260070433; Fri, 09 Oct 2020 09:14:30 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:34 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-26-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 25/29] arm64: allow LTO_CLANG and THINLTO to be selected
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

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ad522b021f35..7016d193864f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -72,6 +72,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_THINLTO
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.28.0.1011.ga647a8990f-goog

