Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF733DF77
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhCPUqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhCPUoq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 16:44:46 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCDC061764
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 13:44:45 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id j12so16712476vsm.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLa3leTdMzh1rknpkLUWnm0PAOSso4HRgQA5K7IK6MM=;
        b=e+TXEaCKvma4VGpnwpOaaFkLknHBGuDmEKybhDxTF83sGcUnhvMjnyd4FKoakznEV3
         L+49y3mjg3y9zPjYOau5jDdMUzS1QeQc8EZHIuCnYCEvlu/U3MIphrqZ/uP5UmkwxxeL
         +/myGc8pDphpzzZ7FTh/9hJKxPT9p26Ia2eDhTGk6iETFEiye/52lqU41RoUHrn74DWh
         Z9MX2qar1Tdy5UlVzs8F5VgOHw+sA5zNyUhbhgEJg7yulcKmANZ/MdTHXU3HQZNR3/3z
         jprq7sQ3GQvcxl+Y7QEUl59VHWT5WD2/UpeliEvsAr6IQyyxoheHA9cHYYw051xuDx5U
         BC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLa3leTdMzh1rknpkLUWnm0PAOSso4HRgQA5K7IK6MM=;
        b=BnbgLJW0X2BGMej67E0EZPHsBIiGfgYX8pyHUbYxgOr1rExE9PtA/bQvdupG2lp9/k
         2+W62fRIvYmVImoqIkwKAUXquoSssy1WEZTaxmAs4i8U4MZdswf7ol6vS+pHPljWVSNf
         /WGlTVYWfAkr1HvvIBLvvBqbMgIhyVKLTVe4WlM7IF8R0H1ne9i8fJQ9WT/7S+3lJI6u
         uDI9Jn9eH4D6oLhzDPipU48KnTDZJ18ReHtwf19mhdsFd1EARkTB0Xjb4orBPSu5Nl2B
         EmMsl4HcwLKlrLlwAraikRHEmHlfh47H9XwFL1/H/F0ul5kkUnlgsjEE7bDQonJH5lTQ
         Kklg==
X-Gm-Message-State: AOAM531g47tC8WnFAdg4kkFaqAqQC8h4yBkqeoaVGz2kM2ou3iazupD/
        Vl9GV01TcGPBgtVXOFFCjt6bXjNZ3B3KnXWq1IEAMA==
X-Google-Smtp-Source: ABdhPJwQSd1vGWBZTCJlQRmCK62EXrLyrNMXIW37KTTCmpBtYEbzwPtXhGB1KcQUzWMwYntm7fopfaHU36IppUu0V+Q=
X-Received: by 2002:a67:db98:: with SMTP id f24mr1241866vsk.13.1615927484959;
 Tue, 16 Mar 2021 13:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-18-samitolvanen@google.com> <202103111851.69AA6E59@keescook>
In-Reply-To: <202103111851.69AA6E59@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 16 Mar 2021 13:44:33 -0700
Message-ID: <CABCJKucpFHC-9rvT7uNF+E-Jh20fz69zdO49_4p8G_Sb634qmw@mail.gmail.com>
Subject: Re: [PATCH 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
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

On Thu, Mar 11, 2021 at 6:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 11, 2021 at 04:49:19PM -0800, Sami Tolvanen wrote:
> > Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Random thought: the vDSO doesn't need special handling because it
> doesn't make any indirect calls, yes?

That might be true, but we also filter out CC_FLAGS_LTO for the vDSO,
which disables CFI as well.

Sami
