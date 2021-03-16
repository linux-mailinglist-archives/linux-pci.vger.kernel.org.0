Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83A33DED9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 21:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhCPUej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhCPUeP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 16:34:15 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E0C06175F
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 13:34:05 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id f1so8824051vsl.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xrwjt/kZB1RxVC21J+b2Rv85znrbxBlQ2xQVtgXaL8Q=;
        b=po1Ywby6SU2VWLEUyZ5fNbrtGcCnRgD8+IOMID+GlXWQNN/3aWjrKopHkVgecJy3yJ
         khd4+NGMXkdhaRRLq7oIG7sqA93cOIbt85nnBMxjdoTTob9e2Am24an2yQVbG1o0V5H8
         7GVzuReTWAlfbF1CAQXu39fgGvH5SXGbKyaDGdlbOZBsDb8/16qHOkbAClu4ucjVnnpq
         puCa2KojBGupypPIcNHF88u0nBc0j5j5wmxJB5QqbuzbcGhuC3bdhL35d8XTmOmAH5Ze
         Rv/YonPUJZL/28fPFwgGqtGza8PZ38b3S3xCK35A47xteLDq+UaKkUNMlUmMa3ohiIUa
         It1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xrwjt/kZB1RxVC21J+b2Rv85znrbxBlQ2xQVtgXaL8Q=;
        b=qf0yfiKNo0Q7XUF9/6q+VEBow+S7hPT5VMEkK/SAlB2vQxKm5o1+13/iXIWzP6ZMTA
         1txh6OL52/qMPa3INRPkDSIourG+d0obi57FYiVDmjehsfeS7ndRT8QIpbr58x5iUyb4
         RoKYSOzrFExDhp4HeXMSwPoPT9UUWSGkQtPzX0eQ1pGGFH9ZyTS0egzYuTizn+V2j//w
         ZS7k5NbpiKJJb1eSgxJICLW4BIirD6cjHcBJFKC9Wd5eL6vJNd2c0NaxP2v0SH3U5WxD
         5U6IWUDiyLF6u1xLwg0y/HkgQjAR5taewxcAe14Csrnz5ZMhIMrzsD+CliocgAdadtw4
         6rRw==
X-Gm-Message-State: AOAM53065FDt/0//5LMUOxjgvWl11fJdcwBPbVAAw5HJ1s2CybyLKBo5
        uIzFIjBMETvOAQgrJeeVJbpM6ECpPUBJrBCB+rxByg==
X-Google-Smtp-Source: ABdhPJwadRPiAKyB9trsaH6fnnn3nCM/AdtJrbuHIQFIQoIMgPzfKSpazXNSL6neJgetXYxyVdUJ7AZv1KZY68p3ujw=
X-Received: by 2002:a67:2803:: with SMTP id o3mr1486279vso.36.1615926844137;
 Tue, 16 Mar 2021 13:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-8-samitolvanen@google.com> <202103111843.008B935F8@keescook>
In-Reply-To: <202103111843.008B935F8@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 16 Mar 2021 13:33:53 -0700
Message-ID: <CABCJKufMb_VFwXLkxjdvN6Y92v-Nc4Z+kThbi7SOkVgGhdFz+g@mail.gmail.com>
Subject: Re: [PATCH 07/17] kallsyms: cfi: strip hashes from static functions
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 6:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 11, 2021 at 04:49:09PM -0800, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG and ThinLTO, Clang appends a hash to the names
> > of all static functions not marked __used. This can break userspace
> > tools that don't expect the function name to change, so strip out the
> > hash from the output.
> >
> > Suggested-by: Jack Pham <jackp@codeaurora.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> (Is it possible we could end up with symbol name collisions? ... though
> I guess we would have had collisions before?)

Yes, these are static functions, so name collisions have always been possible.

Sami
