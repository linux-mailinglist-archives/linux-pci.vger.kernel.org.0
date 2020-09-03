Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D590E25CD12
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgICWDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgICWDo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2020 18:03:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE373C061247
        for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2020 15:03:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q21so4224022edv.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2020 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVIO+W41RwcDMaSobjfrJM37v+XlNEpsXghdOpMJtkI=;
        b=KSOF4MSbX4S87IQK+in03uGEn+ytQl9cZGyW6vDNozCbdjEAgInLMiYQKelxpagMl5
         df9b/zV8SpGeA2iaUig0Q+MwFtCPZ28+WIKxq9eXlq/Wqd7GExFDfcGlLp8y1mAoy6te
         zS6jijDRaye7xBQSACfoereqL7Lz3JDY21FkaYI+Fw7k67Kt0rdnapLXNgJhXsHyhm7Y
         hlEeZ4lRpKgWRNSwYIyS0ZNPVsv/wZ3NStKIflMJS4q4+n12JbEG9GPG0Q5FVCgUqH5k
         1+abDI3c1WFNhWHsCv2v/A8XJ1YBYFMlewBw3NbKj1gZ1Og8okZuumffy5glY7Vb2XSt
         +iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVIO+W41RwcDMaSobjfrJM37v+XlNEpsXghdOpMJtkI=;
        b=jnOQrTuUvlERjsrtApWHVtHw71PiPGW/ZQ0o3X7Itt7TK3RLG8q8Nogs3D+AKAareA
         xRPB7Kl2a1nad6TccZDFmbCR2JHTycP8l+hktDUePODpxWCyHrrwInTqTyipKhXiL2Dg
         J7D5W6D0Mq8JenhNzHpEI0Xa9nSp1N4AaIuxGEquJMV7uI78BNhvGrFCBaypupn2o64R
         odcgzXwrj820mvEiitVt7jESuePvW/1p6yovu9JofKxNZoIqfukxX79tEp3JWGSNLQbn
         NeP9q9K2vOINY/tebieT06hYg6bQh17bK4EF4oHD3c9p6uTLGisgrCXP7BQVKCklfcyv
         zzTw==
X-Gm-Message-State: AOAM531OeFjYMzrQ5l/cgdtQYFBLAKt/ZzoW9tjKiz9+srECTwbs13zw
        DU4MoFhN/Y2pEAvIiHkZ+xfuyampOjOSKJQN5tDbxg==
X-Google-Smtp-Source: ABdhPJz8wZUegnpJXZZBut1xff7mQk50TpWZj/RnJoIZEh3bEYGVn9VJa+mmP5IBGCFzg96FVhHvLJwNs9ID1NpA3wM=
X-Received: by 2002:a50:e004:: with SMTP id e4mr5429575edl.114.1599170621796;
 Thu, 03 Sep 2020 15:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <20200903203053.3411268-6-samitolvanen@google.com>
 <202009031450.31C71DB@keescook>
In-Reply-To: <202009031450.31C71DB@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 3 Sep 2020 15:03:30 -0700
Message-ID: <CABCJKueF1RbpOKHsA8yS_yMujzHi8dzAVz8APwpMJyMTTGhmDA@mail.gmail.com>
Subject: Re: [PATCH v2 05/28] objtool: Add a pass for generating __mcount_loc
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 3, 2020 at 2:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Sep 03, 2020 at 01:30:30PM -0700, Sami Tolvanen wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Add the --mcount option for generating __mcount_loc sections
> > needed for dynamic ftrace. Using this pass requires the kernel to
> > be compiled with -mfentry and CC_USING_NOP_MCOUNT to be defined
> > in Makefile.
> >
> > Link: https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
>
> Hmm, I'm not sure why this hasn't gotten picked up yet. Is this expected
> to go through -tip or something else?

Note that I picked up this patch from Peter's original email, to which
I included a link in the commit message, but it wasn't officially
submitted as a patch. However, the previous discussion seems to have
died, so I included the patch in this series, as it cleanly solves the
problem of whitelisting non-call references to __fentry__. I was
hoping for Peter and Steven to comment on how they prefer to proceed
here.

Sami
