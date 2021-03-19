Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F0342199
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 17:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCSQRa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 12:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhCSQR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 12:17:26 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C06C061761
        for <linux-pci@vger.kernel.org>; Fri, 19 Mar 2021 09:17:26 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id e5so3791709vse.4
        for <linux-pci@vger.kernel.org>; Fri, 19 Mar 2021 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rt1xbgAbnwLYYjFpykXaHRDqBSAXyYdKNm2t1F1L7JI=;
        b=ogcJzaM3vfh24d6Al8bx+0Ztgu6erlK61zGnd6i9OYYJSH5cyaY+E6owFsQf5SMksz
         2SqY+8Zlx2zXuFQ2igs6wHd4jsY+rG8ubwzzCQfH0nBbdFjAAkQzeSP2QV+sfuDb7u2N
         3kkhe4gjLmP06beUsI0bKk0xj3Inr9z17AQ2IX200PoZ+UOmmYCM57qCkEIMaK7ARkya
         O5yESSQScUScma+nL3OJwttJg9bJSxt/FXvEFByc24AYNDYICi0NCf4i7d9tnbEK6gZk
         yhExuLXPXld4TNYY8ZNxF7XNkTdx0D4+kePDp+I8lQReJeEyTkamYIT2PPfuas1xf5Ey
         g0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rt1xbgAbnwLYYjFpykXaHRDqBSAXyYdKNm2t1F1L7JI=;
        b=NpLdoRGBnkkaFwQnaz4uNcwm5dTC3ovjK18PhXm7gWciFquFoFctHFcL8o3i/iVHlc
         ojWkwC6DTLhdkVM2KaLYoDJD1q6dkXRl/eZJ6HVh+1QJvJyHPN5aln+Ncvjl3woaDyjL
         5JVwIRy7ELVftSaOliD68xeIVe1jK6C7++Lvc3hYpChp9J32Q2H7lUEPwoVDP5dtR86E
         mi71okGXXLz079iT2VaY9qYFT0s3ksGrxW/Y2csonhZY2I+li3fSbZZyxu9+oSiU36ce
         vNJUKb0FzWAxyQlYC6XCyXSBMlAfap8yUQ9kYpQawKiAwPjuKF98o/xVC00wl0BGVeTk
         hjfw==
X-Gm-Message-State: AOAM531+gJV/R9BQHgzbWFo+MeVnwlvb9EOUc3iBPsGd1+osm2BirkWb
        ZON39/0sL+xEbc8I3oc5IueiPKy6PvozQ1OeP/vy0g==
X-Google-Smtp-Source: ABdhPJw/sKF7iBW/KvkyGt5OC+722c1f7HkWufJpz/iIWy7f6/foyV9HotQx8W5rT++ceDlCVYoayDD6dEG1LSfx1Ao=
X-Received: by 2002:a67:b447:: with SMTP id c7mr3324630vsm.54.1616170645439;
 Fri, 19 Mar 2021 09:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-2-samitolvanen@google.com> <YFPUNlOomp173o5B@hirez.programming.kicks-ass.net>
 <CABCJKufkQay5Fk5mZspn4PY2+mBC0CqC5t9QGkKafX4vUQv6Lg@mail.gmail.com>
 <YFSYkyNFb34N8Ile@hirez.programming.kicks-ass.net> <20210319135229.GJ2696@paulmck-ThinkPad-P72>
In-Reply-To: <20210319135229.GJ2696@paulmck-ThinkPad-P72>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 19 Mar 2021 09:17:14 -0700
Message-ID: <CABCJKud=aJUSgWG==qqKi-+cKRCtRp4qLNgdDqoYKL+S9X7q4A@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] add support for Clang CFI
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 19, 2021 at 6:52 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Mar 19, 2021 at 01:26:59PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 18, 2021 at 04:48:43PM -0700, Sami Tolvanen wrote:
> > > On Thu, Mar 18, 2021 at 3:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, Mar 18, 2021 at 10:10:55AM -0700, Sami Tolvanen wrote:
> > > > > +static void update_shadow(struct module *mod, unsigned long base_addr,
> > > > > +             update_shadow_fn fn)
> > > > > +{
> > > > > +     struct cfi_shadow *prev;
> > > > > +     struct cfi_shadow *next;
> > > > > +     unsigned long min_addr, max_addr;
> > > > > +
> > > > > +     next = vmalloc(SHADOW_SIZE);
> > > > > +
> > > > > +     mutex_lock(&shadow_update_lock);
> > > > > +     prev = rcu_dereference_protected(cfi_shadow,
> > > > > +                                      mutex_is_locked(&shadow_update_lock));
> > > > > +
> > > > > +     if (next) {
> > > > > +             next->base = base_addr >> PAGE_SHIFT;
> > > > > +             prepare_next_shadow(prev, next);
> > > > > +
> > > > > +             min_addr = (unsigned long)mod->core_layout.base;
> > > > > +             max_addr = min_addr + mod->core_layout.text_size;
> > > > > +             fn(next, mod, min_addr & PAGE_MASK, max_addr & PAGE_MASK);
> > > > > +
> > > > > +             set_memory_ro((unsigned long)next, SHADOW_PAGES);
> > > > > +     }
> > > > > +
> > > > > +     rcu_assign_pointer(cfi_shadow, next);
> > > > > +     mutex_unlock(&shadow_update_lock);
> > > > > +     synchronize_rcu_expedited();
> > > >
> > > > expedited is BAD(tm), why is it required and why doesn't it have a
> > > > comment?
> > >
> > > Ah, this uses synchronize_rcu_expedited() because we have a case where
> > > synchronize_rcu() hangs here with a specific SoC family after the
> > > vendor's cpu_pm driver powers down CPU cores.
> >
> > Broken vendor drivers seem like an exceedingly poor reason for this.
>
> The vendor is supposed to make sure that RCU sees the CPU cores as either
> deep idle or offline before powering them down.  My guess is that the
> CPU is powered down, but RCU (and probably much else in the system)
> thinks that the CPU is still up and running.  So I bet that you are
> seeing other issues as well.
>
> I take it that the IPIs from synchronize_rcu_expedited() have the effect
> of momentarily powering up those CPUs?

I suspect you're correct. I'll change this to use synchronize_rcu() in v3.

Sami
