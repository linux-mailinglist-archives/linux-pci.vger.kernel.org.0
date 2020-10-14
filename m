Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA328EA77
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 03:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgJOBth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 21:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbgJOBth (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 21:49:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1DC08E88F
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 16:24:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id p15so1180722ljj.8
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 16:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1p4V+7SeMLHnh08qcMlfbDl3wtxivqtmtup/MyvFDY=;
        b=WE7IFwP9IhL8DE1zZKJle/ZGrNF6+L4elBdskKUHhzr6aRc+x7wWJi20JSldqtkJ7Z
         j/7BB6dyuTbU5p9PSE8H3XtV1HRU//Yqj6FJa8U+jMWDY41ES81W1cB++Kto9YrI/Q9M
         lg7UOj5OnYiqZbnuwDy16M4Ygj4NgVILO1Me3MLBRFSsQxX9nkWQCeKpS7ipOCfd1Eqg
         M0MC2h3UVNaHCnV0m7sBQfkfVwxLkCsUo4Uff8EHxKLN05AZsmdIMReoJfBYKlL6Kg3q
         +7i9vZUIztJLnoCIPO/bJoqUuwmFkJ1IK4411mBF4oyBnjITBziC24r05hMyonx/2eTu
         eLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1p4V+7SeMLHnh08qcMlfbDl3wtxivqtmtup/MyvFDY=;
        b=FUVHTo4BSPtoHnqPf0kUdTNHyTmtUtLvPqv27ELsDGay8OshxOQe+X6U/RlZo3niYm
         hhadnBZCK0DEczKVihWDbVap9QQm0Pqq7tRgOe7EuDyEW8vhbxScZoyNADLSYDxTiUpB
         /alCWK0DdY1igKRMTcCu0ini7ahDeL1NEgIIpgfbEL5wFcaqBURV89wUSzGjuZHj+ko6
         0vE6mQdPJBiTEMFEOSEHwkuPj2IJkOJLDPQtFjJdTRcf+OHzK+Gc2FKn3/qt0SL0FPOo
         YsWhNo6EkRzfsUDvjwBAT5vywNjWVkFUr13dP+5Irx0V8LFkGSIkxUDL3GWUAXWRM4LM
         /2+w==
X-Gm-Message-State: AOAM533/DnwkGIeLSKBKXEpH0bNThqt/c3jkMrONf7gK/FLG43C3UPyw
        cO7kzpCHOc4CXcwAEVRPpMy99OaeJke1X0Ufynt4zQ==
X-Google-Smtp-Source: ABdhPJydMCD+XHL2TSxEVaZRxaszslycs2dTV+hsdRxTeju9rh0yCfYdZANr/pfddpUzM3d5IpL0YBG2d5o1ouutlCY=
X-Received: by 2002:a2e:e1a:: with SMTP id 26mr156295ljo.377.1602717848016;
 Wed, 14 Oct 2020 16:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com> <20201013003203.4168817-23-samitolvanen@google.com>
In-Reply-To: <20201013003203.4168817-23-samitolvanen@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 15 Oct 2020 01:23:41 +0200
Message-ID: <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
To:     Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+objtool folks

On Tue, Oct 13, 2020 at 2:35 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> Running objtool --vmlinux --duplicate on vmlinux.o produces a few
> warnings about indirect jumps with retpoline:
>
>   vmlinux.o: warning: objtool: wakeup_long64()+0x61: indirect jump
>   found in RETPOLINE build
>   ...
>
> This change adds ANNOTATE_RETPOLINE_SAFE annotations to the jumps
> in assembly code to stop the warnings.

In other words, this patch deals with the fact that
OBJECT_FILES_NON_STANDARD stops being effective for object files that
are linked into the main kernel when LTO is on, right?
All the files you're touching here are supposed to be excluded from
objtool warnings at the moment:

$ grep OBJECT_FILES_NON_STANDARD arch/x86/kernel/acpi/Makefile
OBJECT_FILES_NON_STANDARD_wakeup_$(BITS).o := y
$ grep OBJECT_FILES_NON_STANDARD arch/x86/platform/pvh/Makefile
OBJECT_FILES_NON_STANDARD_head.o := y
$ grep OBJECT_FILES_NON_STANDARD arch/x86/power/Makefile
OBJECT_FILES_NON_STANDARD_hibernate_asm_$(BITS).o := y

It would probably be good to keep LTO and non-LTO builds in sync about
which files are subjected to objtool checks. So either you should be
removing the OBJECT_FILES_NON_STANDARD annotations for anything that
is linked into the main kernel (which would be a nice cleanup, if that
is possible), or alternatively ensure that code from these files is
excluded from objtool checks even with LTO (that'd probably be messy
and a bad idea?).

Grepping for other files marked as OBJECT_FILES_NON_STANDARD that
might be included in the main kernel on x86, I also see stuff like:

    5 arch/x86/crypto/Makefile                            5
OBJECT_FILES_NON_STANDARD := y
   10 arch/x86/kernel/Makefile                           39
OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o          := y
   12 arch/x86/kvm/Makefile                               7
OBJECT_FILES_NON_STANDARD_vmenter.o := y

for which I think the same thing applies.
