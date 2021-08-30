Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DA43FB94C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbhH3Pxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbhH3Pxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 11:53:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087CEC061575;
        Mon, 30 Aug 2021 08:52:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc21so32163027ejc.7;
        Mon, 30 Aug 2021 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PH1GJR8SexO/UKBLmtFk69D6EteI0Vz3Y9qH+Bg02eQ=;
        b=vb5z/HhtPUclHouLpu5p8Ds97y10ykHwcW+PBhZGcjVpeg4nj/+bBsc0c4U8+K4Q9i
         XEiuxxuyxrx4rZgqWnUzKnrTjFIOSPSegqX/4gnW2hqjcfPYRil3mhFiyPUEVLGtCGOK
         WjPU+OUODFV+vcR2uAjZ/MlbFEdhu6AjSomLqWIh3Me/p8oeGnF0A29HdmQ0faU0YCRG
         fRG+ThgW+QgDIpYWtJ5Muq2l1wM6zAnoKhUV/G3aawS0433gyVkhsoaZVirYtKDtL2dy
         9IndTae+aqzxO+ft2rq5iOZJSWvIUQ1HzD6ifU7e/jYiWteXAnjocd/Ig3bxE6YPagRx
         XOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PH1GJR8SexO/UKBLmtFk69D6EteI0Vz3Y9qH+Bg02eQ=;
        b=uXqMfnhwhGYTqj/BpEckKen7bDWIgBfa/Qqx7PySy+onergxrVAmtu44h+riS++8/Y
         uoBvEVSNm3hgt4kkbiY0/bykTHUrpux5fA31XqRbpI8TuFm5ycbtXdKPLRi+G6DAezDC
         hkB7bo/kbMGh54v8Y01ZPpwf28B/rCxp5v8PwvKZdiopkQmVkfcaDKVGExkv8I4/lRWs
         G+zdtCAVhW5gsrjeR7nrdpE1Zt5RX15RYXa0XF9wCqvFFysoPLKh45sK5obSKF1CB7gf
         xGc5WNyJGf8i18HcNdWEI6JrkJjptzfY99SylSFMcIQZWqrT0UXiJGa+h3LnIbZjv2U4
         EXhQ==
X-Gm-Message-State: AOAM532LgKGo/wqSk1Kx2UmjGCOS//DSwQ92m8HiYBtZTFasHKM0Xo1F
        JD4wFuaBQEpYkuXLVOsySec=
X-Google-Smtp-Source: ABdhPJw9VzCBcePC+e+V22VC+MNoXy7oGDEupqmDnhVKiizEqkkqfrn2XNANKvjIPlvN6PQY6QZvdA==
X-Received: by 2002:a17:907:20d1:: with SMTP id qq17mr26329059ejb.439.1630338763366;
        Mon, 30 Aug 2021 08:52:43 -0700 (PDT)
Received: from localhost (host-79-37-188-60.retail.telecomitalia.it. [79.37.188.60])
        by smtp.gmail.com with ESMTPSA id j24sm7867334edj.56.2021.08.30.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:52:42 -0700 (PDT)
Date:   Mon, 30 Aug 2021 19:52:36 +0200
From:   Sergio =?utf-8?Q?Migu=C3=A9ns?= Iglesias <lonyelon@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, konrad.wilk@oracle.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        Sergio =?utf-8?Q?Migu=C3=A9ns?= Iglesias <sergio@lony.xyz>
Subject: Re: [PATCH] PCI: Fix general code style
Message-ID: <20210830175236.7d62its7nwqosuwk@archlap>
References: <20210804222832.1023161-1-sergio@lony.xyz>
 <20210825204356.GA3601025@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825204356.GA3601025@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I can not thank you enough for the amount of time you must have spent
writing this response. I will look into those things in the following
days for sure! ( I have already started looking into the "__ref" stuff)

Thanks again for this,
Sergio M. Iglesias.

On 21/08/25 03:43, Bjorn Helgaas wrote:
> On Thu, Aug 05, 2021 at 12:28:32AM +0200, Sergio Miguéns Iglesias wrote:
> > The code style for most files was fixed. This means that blank lines
> > were added when needed (normally after variable declarations), spaces
> > before tabs were removed, some code alignment issues were solved, block
> > comment style was fixed, every instance of "unsigned var" was replaced
> > with "unsigned int var"... Etc.
> > 
> > This commit does not change the logic of the code, it just fixes
> > aesthetic problems.
> 
> I generally *like* this, and it does fix some annoying things, but I
> think it's a little too much all at once.  If we're working in a file
> and doing actual bug fixes or new functionality, and we want to fix
> some typos or something at the end, that might be OK, but I think the
> churn in the git history outweighs the benefit of this huge patch.
> 
> So I would encourage you to use some of the PCI expertise you've
> gained by looking at all this code to work on something with a little
> more impact.  Here are a couple ideas:
> 
>   - There are only two uses of __ref and __refdata in drivers/pci/.
>     The fact that they're so rare makes me suspect that we don't need
>     them.  But I haven't investigated these to see.  Somebody could
>     check that out and remove them if we don't need them.  Be aware
>     that I will want a clear argument for why they're not needed :)
> 
>   - Coverity complains about several issues in drivers/pci/ [1].  Most
>     of the time these are false positives, but not always.  Sometimes
>     there's an actual bug, and sometimes there's a way to restructure
>     the code to avoid the warning (which usually means doing things
>     the same way they are done elsewhere).
> 
>   - "make C=2 drivers/pci/" (sparse checker, [2]) complains about a
>     few things.  Leave the pci_power_t ones alone for now, but there
>     are a couple other type issues that could be cleaned up.
> 
> [1] https://docs.google.com/spreadsheets/d/19eyNDou83JACzf44j0NRzEWysva6g44G2_Z9IEXGVNk/edit?usp=sharing
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/sparse.rst?id=v5.13
> 
> > Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
> > ---
> >  drivers/pci/access.c       | 22 +++++++++++++---------
> >  drivers/pci/bus.c          |  3 ++-
> >  drivers/pci/msi.c          | 12 +++++++-----
> >  drivers/pci/pci-acpi.c     |  3 ++-
> >  drivers/pci/pci-driver.c   | 19 +++++++++++++------
> >  drivers/pci/pci-sysfs.c    | 14 ++++++++++++--
> >  drivers/pci/pci.c          | 16 ++++++++++++----
> >  drivers/pci/proc.c         | 15 +++++++++++++++
> >  drivers/pci/quirks.c       | 35 ++++++++++++++++++++++++-----------
> >  drivers/pci/remove.c       |  1 +
> >  drivers/pci/rom.c          |  2 +-
> >  drivers/pci/setup-bus.c    |  5 ++++-
> >  drivers/pci/setup-irq.c    | 12 +++++++-----
> >  drivers/pci/setup-res.c    |  2 +-
> >  drivers/pci/slot.c         |  5 ++++-
> >  drivers/pci/syscall.c      |  5 +++--
> >  drivers/pci/xen-pcifront.c | 20 ++++++++++++--------
> >  17 files changed, 133 insertions(+), 58 deletions(-)
