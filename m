Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10E20973B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 01:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbgFXXkG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 19:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbgFXXkF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 19:40:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD67C0613ED
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 16:40:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u128so2282384pgu.13
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OXwCzf5B5Vnc4rPGARP7edsvVNysUhYzQGqjGFLfJUg=;
        b=eJvh37nNRJoXUBuIREWky64c/2Zy+QfsGiyybHo4/AY79kM2WK5DCWQ2SFWNIlhRqR
         uvyBfk+MP4VctCsNpVpZcmoQSq5Bq2w+lQM6xBkh25apGFZZlExegOU/Xa4ZzLv1+QGo
         2SZwCYjmMFcvWre4jkB8JFSvGQLtaMZLbShuOQoeq/pW5jRL7ENSqIcZKBium29PAxHa
         SUKoF/TCC6EPkmXpV56a4eqzpU85/8BnY0vmWySOQ6P4JhiJF+3GTW6JN67+OxEwI6FO
         083DgLg4vlRvZAYijlbkUJhYrikRhcAUh0cGmqJe8b/JYcwRofo02mXuHf66C14NJXzV
         SJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OXwCzf5B5Vnc4rPGARP7edsvVNysUhYzQGqjGFLfJUg=;
        b=TnOR7V+cWcvmWDv8LqBQhtzlcVU2PIMjwOHuc7xkL2IClFtnyYHRDSKaYJ2KWv+nUV
         ivUOK/oRgshp02LkV2fWcCsFZwpptHd0HWJEdUDQyx8wXmBtqABifioGOUlPlZG6qLTS
         nw6W1yEuCwuU1+7PFHgEM/qZfbbCSgjp3hSiNYXe0Fh2dn9X482lFHrvJMnEynxVzbb5
         XyUq5EsXiD1aueF0QKlqSOVzvsSArtIar6KKpSxoOhpEjNze9J33L7LczAEDUdO6xB4u
         wqiecA+s+nUVsGJKVBWLN5DQ48z+fLg9PMdNrpGpu6AZN/8OfgBbNaaoOFmOrSgoS6q2
         lnMw==
X-Gm-Message-State: AOAM5331zF5XCBU0Osw2ENQGaFohAsTGGE418pmMUuFesBI2hRIYGtR8
        mgE2DuxIagBTWikgYGo6qaYMig==
X-Google-Smtp-Source: ABdhPJzXlVXz0ute8/7RtpY4QOpyoQzqmeZeuFCeuHxJTgdZ5uUxN+EFgHwfWmPsVtpJN+LSHdwUaA==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr33592532pfa.124.1593042004835;
        Wed, 24 Jun 2020 16:40:04 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id mu17sm6845223pjb.53.2020.06.24.16.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:40:04 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:39:59 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
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
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
Message-ID: <20200624233959.GB94769@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-18-samitolvanen@google.com>
 <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
 <20200624215231.GC120457@google.com>
 <CAKwvOdnWfhU7n0VfoydC7epJPrj+ASZzyNRpBCNuvT_5E+=FcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnWfhU7n0VfoydC7epJPrj+ASZzyNRpBCNuvT_5E+=FcQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 24, 2020 at 04:05:48PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 24, 2020 at 2:52 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 01:58:57PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > > >
> > > > Filter out CC_FLAGS_LTO for the vDSO.
> > >
> > > Just curious about this patch (and the following one for x86's vdso),
> > > do you happen to recall specifically what the issues with the vdso's
> > > are?
> >
> > I recall the compiler optimizing away functions at some point, but as
> > LTO is not really needed in the vDSO, it's just easiest to disable it
> > there.
> 
> Sounds fishy; with extern linkage then I would think it's not safe to
> eliminate functions.  Probably unnecessary for the initial
> implementation, and something we can follow up on, but always good to
> have an answer to the inevitable question "why?" in the commit
> message.

Sure. I can test this again with the current toolchain to see if there
are still problems.

Sami
