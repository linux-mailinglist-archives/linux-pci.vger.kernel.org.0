Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7AC28C5F5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 02:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgJMAcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 20:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgJMAcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 20:32:19 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EB7C0613D5
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:32:17 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x24so13743394pfi.18
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 17:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xL7tn5bk8rd7QhzERnW5XDCxrWNQLuaGbP7lLdALs6Y=;
        b=IdXB04m+VIhq9Ywfk+Q6SdQxAtxltKDIhWNIfo+jhdLwgrlbdcpJkCD1dg60k4KicG
         1IgqLYFzJP4YEVrqWrx9pldSCsrIUIQZ+WBgBNy02BbQgKQE7dyYmjEiSSvKFbyI2xXj
         TV/V2tWK25kaN3vgAN5S+M0sENDBoc3aH1FQDGeTof6qqw+rbjH3bLU8q4fusukkB6D6
         mAux60p4YIG3jSjYIx2pWv96v7XCJ9hy4Ka8a16xDIx9CMpYSDwuHtmOn9Zpz0sBYoxo
         n76+DpbDHdACleamKfcxERH+Pqgb3G4b5AAOxxW5ydqXddcuIHi5FDSPpeBjiqI6FIaq
         F5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xL7tn5bk8rd7QhzERnW5XDCxrWNQLuaGbP7lLdALs6Y=;
        b=h67As2cpB7ymH4jgEcF7LD7WsTK8MKGN3XbTWfRkZ9sHlUQcJLtuYUdfetIjpoJ1Fm
         Z01vKmLv2NMFzKjj6af27D6UPcndKVDcCMfpWLh9NaBzwUmsPxR+cZXh3R4JkOUj90gJ
         lg52/ylKcp/QfK8+EK2Iq//3/0fOP4DZwWTgKbMy9otLIKGuVZouw3SZD8GBMbaKB1+J
         K6w9BZYy/L8cyhFJXTrC+pq/LtN5jip3AUNvMOBMsLWN/w1aTPkCiUUGwN4hbA/LtRog
         FMGEeBXkyeVRWYPy2H3a6DRhndNqdjtmQGsQQ9lE2Rob861Mp40qri42f5OOFovmH2xb
         ZQXw==
X-Gm-Message-State: AOAM531HGJUf+6bnTMzltNJo9RGBrhze5V0KwahrmF8z0dUuRNbvUfzt
        P45k+JZbAEMuVNsL6CXZsXfOCla9oi+yOPoVn5o=
X-Google-Smtp-Source: ABdhPJzmHD4XCersd5eY8ZPVkbKw3ea3PfM0fSiP3AGN8FM08tkamilxzFI74ZhTfsYbcW37PW4YYLWgNBpJiUusVu4=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:aa7:9a87:0:b029:156:5806:b478 with
 SMTP id w7-20020aa79a870000b02901565806b478mr3079925pfi.8.1602549137181; Mon,
 12 Oct 2020 17:32:17 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:44 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 06/25] x86, build: use objtool mcount
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

Select HAVE_OBJTOOL_MCOUNT if STACK_VALIDATION is selected to use
objtool to generate __mcount_loc sections for dynamic ftrace with
Clang and gcc <5 (later versions of gcc use -mrecord-mcount).

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e832fd520b5..6d67646153bc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -163,6 +163,7 @@ config X86
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
 	select HAVE_C_RECORDMCOUNT
+	select HAVE_OBJTOOL_MCOUNT		if STACK_VALIDATION
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
-- 
2.28.0.1011.ga647a8990f-goog

