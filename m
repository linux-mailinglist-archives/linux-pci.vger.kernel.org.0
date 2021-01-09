Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0132EFC27
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jan 2021 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbhAIA3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 19:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbhAIA3t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jan 2021 19:29:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DA2C0613C1
        for <linux-pci@vger.kernel.org>; Fri,  8 Jan 2021 16:29:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e2so6517219plt.12
        for <linux-pci@vger.kernel.org>; Fri, 08 Jan 2021 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eveSrO3foL1YR94SADi/xGNY6RU/HiTPaoR//1jI2bc=;
        b=cemTR8rQ+v7aAc1j8X9bSjTtMv/2eIij1J0jQdOW7eNBqbQFCd58aSYpax3rZVT2eY
         aoIsHA/4koMVUbI+TLf/cwAkcwY2XCmvpLcT//0ZhklFs+Yz+KCOHvj4iDKgepwwDCy2
         psVcFqYTpa0VlbUiLHsCrmO18jt6/WbjHzn9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eveSrO3foL1YR94SADi/xGNY6RU/HiTPaoR//1jI2bc=;
        b=eHIySPjwWDgY0aFmezfdcffQmpyOjVjTk+R7FkGB8KI9FuN/DsX300NRD+clJdHDo7
         /0qwtWaoF84aORfSW5ZF2hq3dZAqDJrhGWMoaxNFLRl8SDW2LpmgXqcNLKdttfcwSTGj
         Ws1/XlZNqL9qcY4Z4UTPQekI9COM1IKFNkIbPqrihVuiwPp8A4Ix6T8+/BLR6VF41h7T
         00XtrY6IKkAnUTr8WnndwZi1TDTFNTpTpVR/YCR8enQfveX0MsgVpl71010uOHRul/J8
         WJDaR0KsSciWeCEIfrxq/LU6qJn0As6nKFwiZlHytgFkRRwDE+nTMCZUurIcAVl2kFWN
         Wo1A==
X-Gm-Message-State: AOAM530jWtp8UkEsQjpLhsnzm07rPWJlpf3jAT5MBe4KnquEzuJPUJSR
        dbk3pnC21G35tWrbv6/h3HOqrw==
X-Google-Smtp-Source: ABdhPJxOK52D16pcAwbT6jFjbq8GC4r4IJlAOsTNR/onet1CRy5aKa4cGbW3hXo1Ls7QfN7irIfQYg==
X-Received: by 2002:a17:90a:db08:: with SMTP id g8mr6363172pjv.163.1610152148560;
        Fri, 08 Jan 2021 16:29:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p16sm9332768pju.47.2021.01.08.16.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 16:29:07 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-hardening@lists.openwall.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 00/16] Add support for Clang LTO
Date:   Fri,  8 Jan 2021 16:27:13 -0800
Message-Id: <161015202326.2511797.6087273163265436487.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
References: <20201211184633.3213045-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 11 Dec 2020 10:46:17 -0800, Sami Tolvanen wrote:
> This patch series adds support for building the kernel with Clang's
> Link Time Optimization (LTO). In addition to performance, the primary
> motivation for LTO is to allow Clang's Control-Flow Integrity (CFI)
> to be used in the kernel. Google has shipped millions of Pixel
> devices running three major kernel versions with LTO+CFI since 2018.
> 
> Most of the patches are build system changes for handling LLVM
> bitcode, which Clang produces with LTO instead of ELF object files,
> postponing ELF processing until a later stage, and ensuring initcall
> ordering.
> 
> [...]

Applied to kspp/lto/v5.11-rc2, thanks!

I'll let 0-day grind on this over the weekend and toss it in -next on
Monday if there aren't any objections.

[01/16] tracing: move function tracer options to Kconfig
        https://git.kernel.org/kees/c/3b15cdc15956
[02/16] kbuild: add support for Clang LTO
        https://git.kernel.org/kees/c/833174494976
[03/16] kbuild: lto: fix module versioning
        https://git.kernel.org/kees/c/6eb20c5338a0
[04/16] kbuild: lto: limit inlining
        https://git.kernel.org/kees/c/f6db4eff0691
[05/16] kbuild: lto: merge module sections
        https://git.kernel.org/kees/c/d03e46783689
[06/16] kbuild: lto: add a default list of used symbols
        https://git.kernel.org/kees/c/81bfbc27b122
[07/16] init: lto: ensure initcall ordering
        https://git.kernel.org/kees/c/7918ea64195d
[08/16] init: lto: fix PREL32 relocations
        https://git.kernel.org/kees/c/a51d9615ffb5
[09/16] PCI: Fix PREL32 relocations for LTO
        https://git.kernel.org/kees/c/dc83615370e7
[10/16] modpost: lto: strip .lto from module names
        https://git.kernel.org/kees/c/5c0312ef3ca0
[11/16] scripts/mod: disable LTO for empty.c
        https://git.kernel.org/kees/c/3d05432db312
[12/16] efi/libstub: disable LTO
        https://git.kernel.org/kees/c/b12eba00cb87
[13/16] drivers/misc/lkdtm: disable LTO for rodata.o
        https://git.kernel.org/kees/c/ed02e86f1752
[14/16] arm64: vdso: disable LTO
        https://git.kernel.org/kees/c/d73692f0f527
[15/16] arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
        https://git.kernel.org/kees/c/09b812ac146f
[16/16] arm64: allow LTO to be selected
        https://git.kernel.org/kees/c/1354b8946c46

-- 
Kees Cook

