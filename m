Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176C82BB67C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 21:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgKTUTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 15:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgKTUTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Nov 2020 15:19:45 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C5C061A04
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2020 12:19:43 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id y78so5693965vsy.6
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2020 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7acuhIcf2aj+2HfwBkYRj3S/5vwbxxWC1CPfVW74VbQ=;
        b=gyFkFQiGUkXaUSAApDExFsLoGANoyNJrTgq+Uj6paRE46wRNgi6CKDFwmTfHlKvQPj
         Er7YyuPh/Vm7IE8fo7s0qFaQ+J1KSSTh2gKBxnB1wIcKxIDjY6KSardWaLK7oDrc8y2c
         4kdFdNabC+L2Mjs5rrPZnanoVf79hAu3cru/VeNYnxmuOucQz4Zphk15Gez73fSD2CqD
         AQbMyvtkwotDifRaGV6FeXKSexUu1NjZCba58CUErs2OOa74uTI7jGSLqvFrp+lsC6E+
         Ms7cuIiIpj16zzxU5/wxq9BhB8eXHmGgvUZLrwYiI37n7bXiBngkjjGfqQuKlN1BFLWq
         HIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7acuhIcf2aj+2HfwBkYRj3S/5vwbxxWC1CPfVW74VbQ=;
        b=hL49QXvEvu8qHjAsHbVXhIOyBjc5i6UKPuKEvSR/59T57ef9v73ZChCG1OmHQQpAXL
         VvWc/fB6IpRlMrT4RdwIl6i0Pn64Y6yxXBkfrZnELknUxxCAGJHbbG0S/l29WD4JePo3
         GaFE0wo9RSOPMCjaIjBe2az/iUnq5qdzLVTmlTYxICEYRHE5Xg24h6E7TU9DKydVKC8J
         GTsufWneuPxkEKnTF5UWrlPCpEIEKMsZemWH/auLMqHc9V0uuv+ZRC2YFzQvb6qWE4KU
         slDHwTN8mTg86BUqGjNwi4j/pMyQVgiTsFmGTj4Wqw2KQI7/jkXN1OGJjwxWO8ssJBPQ
         n14Q==
X-Gm-Message-State: AOAM531rLGwu5XYKPSjh30LVpK0B7/1bgagwEeidR+xnX40UMeVEGR1k
        qIJJQBboJJRMU+h3JtLqvaPAMSpj/Vx4BqnGgDJlyw==
X-Google-Smtp-Source: ABdhPJxFgydZX2L5XAnYwSfeznScyETG/9FyvzzmXojnDnWISYdoy1l6/FMv24FHnaLHqIodrvwFJpF/G3jjdZFT5xQ=
X-Received: by 2002:a67:7107:: with SMTP id m7mr15151234vsc.17.1605903582865;
 Fri, 20 Nov 2020 12:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <CAKwvOd=5PhCTZ-yHr08gPYNEsGEjZa=rDY0-unhkhofjXhqwLQ@mail.gmail.com> <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com>
In-Reply-To: <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 20 Nov 2020 12:19:31 -0800
Message-ID: <CAKwvOdmpBNx9iSguGXivjJ03FaN5rgv2oaXZUQxYPdRccQmdyQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 20, 2020 at 2:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 19 Nov 2020 at 00:42, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Thanks for continuing to drive this series Sami.  For the series,
> >
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I did virtualized boot tests with the series applied to aarch64
> > defconfig without CONFIG_LTO, with CONFIG_LTO_CLANG, and a third time
> > with CONFIG_THINLTO.  If you make changes to the series in follow ups,
> > please drop my tested by tag from the modified patches and I'll help
> > re-test.  Some minor feedback on the Kconfig change, but I'll post it
> > off of that patch.
> >
>
> When you say 'virtualized" do you mean QEMU on x86? Or actual
> virtualization on an AArch64 KVM host?

aarch64 guest on x86_64 host.  If you have additional configurations
that are important to you, additional testing help would be
appreciated.

>
> The distinction is important here, given the potential impact of LTO
> on things that QEMU simply does not model when it runs in TCG mode on
> a foreign host architecture.

-- 
Thanks,
~Nick Desaulniers
