Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA842096E1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 01:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbgFXXGC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388094AbgFXXGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 19:06:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A9C061795
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 16:06:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so1807539plo.7
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 16:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shst53ZJE1d+vIhz2clceIGi2VB/auhmYdgL62EAsJA=;
        b=v4eMG/3rTtJikwtUeVEWC+d0Ch65aCTzn2lI4XytauNvCzrEjxfgA6aO+yV6VxXBx3
         mb6CDo0wNoFZ1v4nkYj+/6EWy37Ni5nLIOMzCNLEZ2dadozowAf9iZnCoXAn7+HLcyE9
         RoOT6e38CrOgiSMwqrLKdO8N7M+/LB2H0MPGEArcqToIp05l+M0z0UH0D4sz1uNsTgmt
         9mmpfTiacr3PdC/F4zU2Yb9SYNEeuuG0ifqnJKaNC2BdOBDaQw26XwaMnJ0wHebahY7x
         fvvlvTbNep+cdAWoA5BqhP7JrVtoCYLEUqHK25wchmImEauPU24++/TQpkcZFXvICfaj
         +O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shst53ZJE1d+vIhz2clceIGi2VB/auhmYdgL62EAsJA=;
        b=rDmY1BmXLB14ecNRf0HFb5q8c6fwoSt6iNNFyjat5nGushX/CFokBs4GBh9d8r5fiv
         FjNB8e1QFJDOToFl86Jcb5lShPjCHaK3fZ/gPjGAbFYaV7RQLptk/lNhAAr9J/7Nxfv6
         VtIZqNabqaxCXEVadgaf7ksChi0wbIYbtsq24oaOM+nIP216O7/gyfo9PdwEGZ7G/AXf
         YUiDfEiKdonFTU5qn4WI9WRlh/m/Z4U4M35M1SIqEsXx/3dum1qBti9GUP/hPHbpeZv5
         BjH8B1DpSeZQak8C4n+kM2zTWpaOXz3JiQU03xyh0jnOJCdSSCXOReAxCsVYlk/GBNIk
         13yQ==
X-Gm-Message-State: AOAM530NC63sFFGT8MAQhLal690yMx+0YdWqgq79wMfBKeJz4DPv+iY/
        YLI5F4ZpusMB7j/8pABg3KncUo4e3eKl9t6Z+OQLpQ==
X-Google-Smtp-Source: ABdhPJxZs7Ep0+V5E2sSAX0aVY+ZMKk8PTjnuF9HO3m5vxhQOU6AbFmmPJG+dflauBb0xhpYFgB/b9UTwA/KqW822v8=
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr30115455plm.179.1593039960944;
 Wed, 24 Jun 2020 16:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-18-samitolvanen@google.com> <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
 <20200624215231.GC120457@google.com>
In-Reply-To: <20200624215231.GC120457@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 16:05:48 -0700
Message-ID: <CAKwvOdnWfhU7n0VfoydC7epJPrj+ASZzyNRpBCNuvT_5E+=FcQ@mail.gmail.com>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 24, 2020 at 2:52 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Wed, Jun 24, 2020 at 01:58:57PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Filter out CC_FLAGS_LTO for the vDSO.
> >
> > Just curious about this patch (and the following one for x86's vdso),
> > do you happen to recall specifically what the issues with the vdso's
> > are?
>
> I recall the compiler optimizing away functions at some point, but as
> LTO is not really needed in the vDSO, it's just easiest to disable it
> there.

Sounds fishy; with extern linkage then I would think it's not safe to
eliminate functions.  Probably unnecessary for the initial
implementation, and something we can follow up on, but always good to
have an answer to the inevitable question "why?" in the commit
message.
-- 
Thanks,
~Nick Desaulniers
