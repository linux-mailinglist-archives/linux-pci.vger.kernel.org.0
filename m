Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA46E28EA15
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 03:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgJOBaT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 21:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732269AbgJOB3j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 21:29:39 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA66C00216B
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 17:13:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d24so1445698lfa.8
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 17:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LURiEnBAw2K4z9zIAiaFYTyrr5u9bQTopZRlsHwZQ30=;
        b=PgKjpNgrHeicAl8QzyJWoTs5A6rmp6R8Pmum8VjneOxNanE02C3iR0xMHPEKXRSwiA
         hgbPuEmU4Y/KvHEeIBgVzlegtYfQL/e1IYCy/LveXiVHXjGwp6JSkRsgM1KwAIfKJcKw
         xjiOyeSTmvlceona3bncz+d4u8W6hA+58+IV74pozmLNmVEOzj6zHtFH6BbvMPGb1Q1N
         SCAyW7rDspMISGiSvIfRrqTnMCItj6RGBKiMdjZQs84SXB/tH/0v/+6ZNBKtXVi4giBx
         5O+k8MWQSqRdXTBoaXJdV4Sbx9ykfhv8CIwDyMJZ5tK/7VE1ZpxXSBqDafewuTLQ+EfB
         Zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LURiEnBAw2K4z9zIAiaFYTyrr5u9bQTopZRlsHwZQ30=;
        b=i296DKxP3KhOKMpUvT82FZmDf/I293CcXh8BOBZYCKCUiNRRqCFs3Nrf0rE6UH+yP2
         EQJrsQDjQ6fhN+vhTfoLGpQ5LEBnIn6mj5QP95+Vhyyeyx5nCtBmVfDYlrtdj3p9VgLT
         vXywWfxkTaRxxNiFAfgIHBNJK95yfgoHA0MuQ+PplFRBTbihHj/LV2rNGQdRQ9E36XPP
         3POm8gUmIfPpGC0Rr8jBSH7cJhRuNxkOyek8BLuJ+/YZyyxVFQNxrtUXKHIoFqSebu0+
         B07wGuMk3slKqwnXSElZfvXS6DZaqflsaqXodzk5fay7GNns9o1Z7cj3bOtwVFmKgTti
         MXyg==
X-Gm-Message-State: AOAM5339JeEc5ESQj5uqrCg31bQbUCMlDLZow+JNjJbrhdD6T7SYarfo
        As9eH47ZmBtXcany/g71OsmL+/t5J5Gjf33K1uitng==
X-Google-Smtp-Source: ABdhPJzXFIHFpKtLKeaohPSTTFSTn1moPmFA2URXdVrEpwDK24AygeIW08WWsjsl1A8u32KKXSdaLbgxjj+v3FNFXjU=
X-Received: by 2002:a05:6512:52f:: with SMTP id o15mr141586lfc.381.1602720794371;
 Wed, 14 Oct 2020 17:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com> <20201013003203.4168817-17-samitolvanen@google.com>
In-Reply-To: <20201013003203.4168817-17-samitolvanen@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 15 Oct 2020 02:12:47 +0200
Message-ID: <CAG48ez26uiRBKS06_DQXB_GSmNjJjRiT+YA6pgLBGYCbVi2NNg@mail.gmail.com>
Subject: Re: [PATCH v6 16/25] init: lto: fix PREL32 relocations
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        linux-pci@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 13, 2020 at 2:34 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> With LTO, the compiler can rename static functions to avoid global
> naming collisions. As initcall functions are typically static,
> renaming can break references to them in inline assembly. This
> change adds a global stub with a stable name for each initcall to
> fix the issue when PREL32 relocations are used.

While I understand that this may be necessary for now, are there any
plans to fix this in the compiler in the future? There was a thread
about this issue at
<http://lists.llvm.org/pipermail/llvm-dev/2016-April/thread.html#98047>,
and possible solutions were discussed there, but it looks like that
fizzled out...
