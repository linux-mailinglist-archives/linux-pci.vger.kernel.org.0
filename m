Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C8229F19
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGVSP2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgGVSP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2020 14:15:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBC4C0619E2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2020 11:15:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dm19so2331627edb.13
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2020 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SReuFYVGjLRX5r5xj5YpIfyUC4xzq9ishSeECc8oc0=;
        b=NuIYTIiKaQc1CsD0KXBC5Yhe7GX8yMqprWzzn8wTzzFy0PzxzGczcaGqdeb4YKryxx
         gDGjWE4EW1L+rsFD2ozcBAmUlUjqvHcfmeZTjicgfj/G2zjx+4h3skQn3dcUWxhf/HGA
         34blS1DVtvnecxc1FIU189JqspE7/zPXYiT+P+DU7dpREkeZiHpbse3hobDGVMvtNzbD
         KrJtaaqMOlcqXc8kDvP2uFSCHPNCwCqMldtmcSw2My/VgU3ZZIe/FRFIcNJ7iFkbw6cy
         utbf98JYdXdwWcsEetVbf/K56+HhaYsRX5rkPaO+4MJKlgRMduJzLaAbfn7bk7LRFtsA
         Fi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SReuFYVGjLRX5r5xj5YpIfyUC4xzq9ishSeECc8oc0=;
        b=KSx8xnG8nlcMBlpgKoMGtQOFZx5Jzx+72HJn2yqa3ekgsixMJyZLre/Uyh0U97oElz
         VQ2gmYRQKBaUtbi/OjYw+O4nWYdldBpMwO6QTPEFNRdPiHyg3Q1q0NUwCgevgR09MI5Y
         Ss+t+NJQ+w774FdzS69BhvmjmMoyz7NmWv/FPENRvaWTTzN/eNNttG5FKwALNmyjYrZp
         SGRqb41V0m3Ybftlc0P88RR6Dmwt7eWNwRMXvV6uNOI5Gxb0n1VSMH12zJiiKTyXXpQd
         Gsypk4yMHPE4Kb0ecieNu6iikRpB35q03R+sZED8DEn4krsdc60SZuRoQeMKRv+VKu/O
         Z71w==
X-Gm-Message-State: AOAM531ZfhflsAZ53NLvLLl7VQt1Wb2Wz/1Qz9wVRTviDBYegEuti9ah
        tXnJMsxO4vu8lp6ZhNoPxwxlmLf7iBETqqIvMRZKLw==
X-Google-Smtp-Source: ABdhPJxrA+hjx0Q1mNxWSy2JCrzqouCMw/jbe01R8hqj3aXOsgJE0QWv/Xu+8L2SG1RhOKQ8MRvH9R8RbRpmUUnfeh4=
X-Received: by 2002:a50:931e:: with SMTP id m30mr677030eda.341.1595441726019;
 Wed, 22 Jul 2020 11:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-12-samitolvanen@google.com> <20200717202620.GA768846@bjorn-Precision-5520>
In-Reply-To: <20200717202620.GA768846@bjorn-Precision-5520>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 22 Jul 2020 11:15:14 -0700
Message-ID: <CABCJKudTCwt3J19u8Em493a3Z9J2SD+imtVZTpz5cPv7Wza5iQ@mail.gmail.com>
Subject: Re: [PATCH 11/22] pci: lto: fix PREL32 relocations
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
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
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, Jul 17, 2020 at 1:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> OK by me, but please update the subject to match convention:
>
>   PCI: Fix PREL32 relocations for LTO
>
> and include a hint in the commit log about what LTO is.  At least
> expand the initialism once.  Googling for "LTO" isn't very useful.
>
>   With Clang's Link Time Optimization (LTO), the compiler ... ?

Sure, I'll change this in the next version. Thanks for taking a look!

Sami
