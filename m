Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48560288E0E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbgJIQOT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389712AbgJIQOI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:14:08 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA8C0613DF
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:13:54 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v190so4697448qki.21
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xL7tn5bk8rd7QhzERnW5XDCxrWNQLuaGbP7lLdALs6Y=;
        b=OqvMiRbTLr7vQGkxZV+PzeN6OVnsvLKpKhipsC6rP2jdI7Y08eG9SJBUZ2mgdSJMkz
         x9QYY+hyJILnVTzv1B5ofQttFgWo7nBVjEgzundXt0DKJFBiSX7gz99ELfNKZbc2BUdu
         GQMlCWP+SMb3Czho/JwY5yFAdN3ZemagwBRj9FsPu58e2Af0yK9l4pesMcwC48QrH+Tx
         dQRg1+j/gMRSCddCjO1H4ILpvwOtSODFimUgDlcNLZ9DVwxxTNXijF18Aa3WiggyxUrV
         V/7JINREru8rAbs/3tG8GRSCPMpt5bAArAPyPhPEspa0qrdfHyj8Ao7YvCGIThXpmbGh
         raVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xL7tn5bk8rd7QhzERnW5XDCxrWNQLuaGbP7lLdALs6Y=;
        b=lUNikRqIVoieq2NmawYdhSR6yMTftBx9wMiLP2Kv75AVmsCJy9ioWGXhuvoMZ8Lale
         Op7Yr8ibBGaHY9yiuITy0XrIdDxOjAkdq6BP2IxJJ0NEMz1C36hEe6Q+B2iM012PJ5OQ
         KdCKYLEM8KkHVNxcoIRxZ5dmlxScqgNJiYvCx8CZJU9FbiBBoQmT/ugzk9iizQZRvAjY
         8yu95Pz6AqorU1Fzmz7AtCmsLmdtneZVpIoT/oA278Dc+EdLaJyxo8TGvdzmDJgHiPWj
         zeejlON/J8PEbZuWsmbKSd/tA1856JtwilOLLUhgp2Xn7TisaWqwceqqfqrrf+AnV5hN
         5L+g==
X-Gm-Message-State: AOAM530HnTqZg9OjYRpEAFQdAHjRVcHsMPvM6ObAQ0WKqOy5d3BPuOIp
        x3mylmsYVQ+/b1dGeC42A2Uf99fwsZR6ymW3iWU=
X-Google-Smtp-Source: ABdhPJzJNs9VefAdVXIx8sE3q7uXvK82feETKtZCmngvw33KH61VeZxl20uF5X/PWOLcLy230cxOgVWyuUcI+4L/D/I=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5747:: with SMTP id
 q7mr1648297qvx.0.1602260033580; Fri, 09 Oct 2020 09:13:53 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:15 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 06/29] x86, build: use objtool mcount
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

