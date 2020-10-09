Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F04288E3A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbgJIQOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 12:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389781AbgJIQOX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 12:14:23 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAE7C0613DD
        for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2020 09:14:23 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g24so7129662pfo.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2020 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BiHYmAAiH626N89XqxkZXfyE7gUyoYuU5gV65m3nGjQ=;
        b=kWaosZKlpyaPhHKVgAB5jaN7Z/L5GLVvlb4+fdv2ch+ej3HpYqzh6uZcdm3+Tvoykg
         6omGVQqiCVxWzoz/gV2RtiawIlWAzwAOAuDWw0klxLvDAp9C8MllbAFa/+mLP6BcvQ6Q
         1JGIssCdJM4GgwAf9G0Zx3c0le6touIF258LA0TedygIS2yHumz44INySxDCNXx7yHIK
         60P3ikRwg9bDNGtZtGkEoyU1tNL/E5ndf++JFwH856D/hSDeXzqinxxFRqXy0QAm3BSb
         k4Ywf7UqYk+GgIXWciDnanYQ1EPbCUEpP8hpqyk2cG836ip23OzwDZz83/Buo4laq19m
         uH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BiHYmAAiH626N89XqxkZXfyE7gUyoYuU5gV65m3nGjQ=;
        b=cv9orNsejWSZAVmqVSKZ9r0npYvjIJGcgZG0y3XvkjHCqaXexfytr3QS4fTvbumM6t
         S/VGoJFrIOP8VvqY5M3ZojCGUyqzf2k2aPB8om9EtPx0nOiFdYxn4MAHHLlkg5UKUkPr
         NxoLwHfrxvmfOSMCk6mStQ6xMKiCdl7inC45SreYi+qr5ePfrvI59qefdJk6ZVbMgho4
         SHg32qVT95MTVJUI2/QD8iK0Go7BPSF9vR4fznkByBqkip5ZfZ2Nhww3GH+0JkYtiKtn
         X6w/x2ztLmUTFmRwbo0jBzLBTX8RHDsyU8rFCot29jKZMyhmpomRhs/ePY7XY2QAzWyW
         bHSw==
X-Gm-Message-State: AOAM532A4b7QxAsPUCmuuPsnOW19+SshVmkcWhWmjQVPJ5MFod2citEM
        n+oGSrU5ZFuo1I0MTcogTp5JEa6tyXrtA05N5yw=
X-Google-Smtp-Source: ABdhPJyHPiE5GePYAvaEya8u/0CvrCAAGbNDB2zBtM4hELH+YYZewJMzkdHOHE7lBNk0pBM71xtMSBAsdjBdBJfED8o=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:7c0c:: with SMTP id
 v12mr5366318pjf.71.1602260062781; Fri, 09 Oct 2020 09:14:22 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:30 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 21/29] drivers/misc/lkdtm: disable LTO for rodata.o
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

Disable LTO for rodata.o to allow objcopy to be used to
manipulate sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..dd4c936d4d73 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -13,6 +13,7 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.28.0.1011.ga647a8990f-goog

