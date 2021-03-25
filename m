Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39686349CCB
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 00:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhCYXSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 19:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhCYXSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 19:18:16 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE56C06175F
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 16:18:12 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id g5so1050375uan.8
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Yk9NlOmGKofkdfMA6+3ywtQqOEAPVMOAz3hdr7uXvE=;
        b=vA7OWbbKWkumvZyucEZbcqeuCLfEdVpEWrKxOGx3P4tN9R3u/6w/09xaucaXo3fP1z
         MQIYpOTb4zLWU/hQWjL9CBjSTPJO+KxQfG7Dx96rt5gAiLXhhKoC7ABFmLukh4KXeZ9Z
         aRhWqpdYN7r23J9Vzze5A3lqpbSCfVHcu6YBrOLJtfWDQkdTihrZonOMBhhW48YWR/dn
         IhljM1ItzoydJs5ao4S1mTCZ7s+gfiMgil1ViPnShV6stP0PH7QJBHHaKatW8sJcx0wz
         u0NvJkbimko9Onpbq3gHaKn863Ymdx5cM9MeIfPQ4d7sEby86nkv+ILpbiaNaR5znvcq
         qbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Yk9NlOmGKofkdfMA6+3ywtQqOEAPVMOAz3hdr7uXvE=;
        b=TA5pej+au4IIAVcLn45K74oHDq34sYirwNk2RI9Nh4yW2o5kEKdVwHRfQUfqLdpRff
         f9AROG1CbK4+EBjcmwLvLseocs+XeTXbP89d3ULf8r/Ip5D9GjgthlLeVH9GMT+BuFek
         wWngYDe6dcc29GQ3KsdtBICy+NF09GPyTuB0NK4mcQBKUXzv9S25U+sdAHYnaTv88gWb
         MFtiaxGmANCIdy9dY1i7DssJPn4/Hz0HLLuvFrMvEwXfsXK39dVeCMLe05L+h2jHRpaZ
         6gMzQRkf9geaW4KjE00Of/UrQVpVLhQwCZlFL+XlnfiPla4I1w5U2bIvDGF4On0OqtSK
         C7+g==
X-Gm-Message-State: AOAM533elftNl8kIRQsmu5qrqS+pTYBr0AQBrZqEOWgLIFHID/3YsKuy
        mesyoaXGnjQVmAlvuT72xAz20otapzBK8urwCbyl9w==
X-Google-Smtp-Source: ABdhPJz3XLagVW8QroqFjxvACNVUH9zZ8ltjPZndhuIyfpInOl3OzeWY/yBVOo6wjOyV8x+RouyyGoOtWVCwXW8GueI=
X-Received: by 2002:ab0:b14:: with SMTP id b20mr6273790uak.52.1616714291094;
 Thu, 25 Mar 2021 16:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-4-samitolvanen@google.com> <20210324071357.GB2639075@infradead.org>
 <CABCJKufRHCb0sjr1tMGCoVMzV-5dKPPn-t8=+ihNFAgTr2k0DA@mail.gmail.com> <20210325101655.GB36570@C02TD0UTHF1T.local>
In-Reply-To: <20210325101655.GB36570@C02TD0UTHF1T.local>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 25 Mar 2021 16:17:59 -0700
Message-ID: <CABCJKuf+TxeDsy9B9DM2g-U7uwNu-yxSjARfPe_oeCY2fySvTA@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] mm: add generic __va_function and __pa_function macros
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Thu, Mar 25, 2021 at 3:17 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Mar 24, 2021 at 08:54:18AM -0700, Sami Tolvanen wrote:
> > On Wed, Mar 24, 2021 at 12:14 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Tue, Mar 23, 2021 at 01:39:32PM -0700, Sami Tolvanen wrote:
> > > > With CONFIG_CFI_CLANG, the compiler replaces function addresses
> > > > in instrumented C code with jump table addresses. This means that
> > > > __pa_symbol(function) returns the physical address of the jump table
> > > > entry instead of the actual function, which may not work as the jump
> > > > table code will immediately jump to a virtual address that may not be
> > > > mapped.
> > > >
> > > > To avoid this address space confusion, this change adds generic
> > > > definitions for __va_function and __pa_function, which architectures
> > > > that support CFI can override. The typical implementation of the
> > > > __va_function macro would use inline assembly to take the function
> > > > address, which avoids compiler instrumentation.
> > >
> > > I think these helper are sensible, but shouldn't they have somewhat
> > > less arcane names and proper documentation?
> >
> > Good point, I'll add comments in the next version. I thought
> > __pa_function would be a fairly straightforward replacement for
> > __pa_symbol, but I'm fine with renaming these. Any suggestions for
> > less arcane names?
>
> I think dropping 'nocfi' into the name would be clear enough. I think
> that given the usual fun with {symbol,module,virt}->phys conversions
> it's not worth having the __pa_* form, and we can leave the phys
> conversion to the caller that knows where the function lives.
>
> How about we just add `function_nocfi()` ?
>
> Callers can then do `__pa_symbol(function_nocfi(foo))` and similar.

Sounds reasonable. I'll drop __pa_function() and rename
__va_function() to function_nocfi() in the next version.

Sami
