Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B836D27EE50
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgI3QF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbgI3QFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 12:05:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063DFC061755
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 09:05:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o8so3601072ejb.10
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nf8e6hIaPbRqntvQjCiPI17gKDQL3g6MdR3siKHn30=;
        b=FdREMa9YQ4gNRdQHURf/x/R8SmYVJ5gIkH9KpmlqeEAlOLeXAhaYjSC7VB4Y8/uoLl
         NpSU9flOBZMB2LnlrWowvIpCnct6WksL48hJ6hEvbeije9viNCjBJLNglsVPmK17McTE
         bQR932o1ftCv5I/jccydLYq37ELOk8HLaS5waUMw2Sl4+mDrlXBlbynVNtazEd8rcTZn
         oCfVkT2gQBFoWgRMv35xCS9XqXQ6DAZwYypy9P5mdyuszGukdvxnnn/AnzhUUV4OJTG3
         jalYoYIzQjQOW6W2UeOKJ1wH4ANi3gdiXC8IiXeG+7KUsH9D9cVc5b9Ynx38GiIxo6v5
         fQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nf8e6hIaPbRqntvQjCiPI17gKDQL3g6MdR3siKHn30=;
        b=I1WzNjPcu3nj1zClLVk1te9zYiUicnxlx1KqAzQD26D4vUi99zp50hbMFOG5y94LrM
         S0GC9jqAIvNQp/vrdF2gNJi3S7zS+V7R6YvcUMpeRP4juIA8UI+qC/iRKmNzqqIV6Glz
         oxEGWZ5qOyfgNThnf2/GR6deirARPs4F2FJQ04yXkxeOTrQSf7/zHmbHQlMprBXarxBa
         BvurvfiHW81WUDBbWCqr18vSxsfMq02+1PIgRKPFkI+Mm8j48CK+zo5U1WiYrQnFJmno
         O+4Xe4BLzD+AbAz52n4EHfbaPJhDwGhLQMiIneKkSFEirAc5Yv4qrvJwfab+3qjDFG1P
         f6pQ==
X-Gm-Message-State: AOAM532n7Cpd1L5joJeHkEUoiFzsP5X9q1K4PsPQbB0AAiiBoVPjAhPw
        uUCxjOvFqYxDrX9RhbvC1QC/GuO4g59SUD1Itblj9Q==
X-Google-Smtp-Source: ABdhPJzYVdbm3fjbvWcAsssxdkKlp1Qf8hBl3VmZLS0706h18aYEVSeaUqFy3XkT6TY1fv56XT82VdDVYI9SZJ5H+mA=
X-Received: by 2002:a17:906:a256:: with SMTP id bi22mr3464394ejb.375.1601481949457;
 Wed, 30 Sep 2020 09:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
 <20200929214631.3516445-7-samitolvanen@google.com> <20200929201257.1570aadd@oasis.local.home>
In-Reply-To: <20200929201257.1570aadd@oasis.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 30 Sep 2020 09:05:38 -0700
Message-ID: <CABCJKud3S7pn8Ap3AkNRUUC4v8nMwOzM2_EwEB6+NFzDp5gppA@mail.gmail.com>
Subject: Re: [PATCH v4 06/29] tracing: move function tracer options to Kconfig
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 5:13 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 29 Sep 2020 14:46:08 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > +++ b/kernel/trace/Kconfig
> > @@ -595,6 +595,22 @@ config FTRACE_MCOUNT_RECORD
> >       depends on DYNAMIC_FTRACE
> >       depends on HAVE_FTRACE_MCOUNT_RECORD
> >
> > +config FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> > +     bool
> > +     depends on FTRACE_MCOUNT_RECORD
> > +
> > +config FTRACE_MCOUNT_USE_CC
> > +     def_bool y
> > +     depends on $(cc-option,-mrecord-mcount)
>
> Does the above get executed at every build? Or does a make *config need
> to be done? If someone were to pass a .config to someone else that had
> a compiler that didn't support this, would it be changed if the person
> just did a make?

Yes, it's updated if you copy a .config and just run make. For
example, here's what happens when I create a config with gcc and then
build it with Clang:

$ make defconfig
...
$ ./scripts/config -e FUNCTION_TRACER -e DYNAMIC_FTRACE
$ make olddefconfig
...
$ grep MCOUNT_USE .config
CONFIG_FTRACE_MCOUNT_USE_CC=y
$ make CC=clang
scripts/kconfig/conf  --syncconfig Kconfig
...
^C
$ grep MCOUNT_USE .config
CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=y

Sami
