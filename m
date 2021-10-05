Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C464223EC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhJEKxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 06:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhJEKxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 06:53:51 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BA2C06161C;
        Tue,  5 Oct 2021 03:52:01 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id d18so496537vsh.1;
        Tue, 05 Oct 2021 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+QFrqKGB0j7m6S9frhdYXSVQB6nI+oRzUWTBQ56AKc=;
        b=hMo4pH7KAtaYW32hFVQn45VdK9FTXqt401Oc6ycqrAQRCl/6RuW4UhuwGhUeSZGpc1
         R5BgZaiR6pOSwItCz1GvRGSbDQQexiFeAwpqewreiF1bahsdFfpl6rhDqrYQ5NKRF8b2
         BfHY1aOuyNRXJmsjoVp3+7SMrwnfnHffNg2Gdv7cRumKfvQ1WYpVtNtGmFeaU8EsLN2T
         WAoH2IKu2RpO3qhKXG4gV8qcbTvCMnabDt89+bH4Qr+auP5GeNxkdaXewpTpLAm68Wna
         ccPeIX6H5W5N+Am5PUWfUvzPbXcTcKCYBpRR7ebNPnir9QkLEVhfVSUyI0YpOA47Dj3F
         eTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+QFrqKGB0j7m6S9frhdYXSVQB6nI+oRzUWTBQ56AKc=;
        b=fv9nN1R4F94hbOQ00DXk10fwO3hfUgmf2iw4czr0nxAja4d/zAohYFRIdn6L5jdYNE
         5JA/QEP73ih4KjOpE+B2zAWy34LBa44ItsYFb5bCziMKrqxAAjPDT5VRn+ZY8go7ua4B
         uQC/RIsvRy+43ZbcUdjUnHzyFkSDrOj7r6HeEkAHzNTKHhMDT7E6bKXFdoqyx9uf7QR0
         nX0mwj72w0PtL6FhYOKz2hqu9xcSpLv3myxcldQb9qZzi10m3dq2XW8Y9d5aW1I1K5hg
         J2V73kbctKDTf0EwZd9M2Hf/1vyC/gCsBB8o03oRGW2Z0pk+3rOGDEM/BfZ9YK2+7f9W
         SnrQ==
X-Gm-Message-State: AOAM530mAgxU2NvPG9lQGmkekrVPvY8pY0hU6gvqgBGYrTtier4eko+f
        xfhVsamkTc1I+ksnEPdS9+bQhd8AwvjqlCWPQns=
X-Google-Smtp-Source: ABdhPJwtV82P/rZoW/OgbX6bsC8jyoZ2nArcMJsVFUQINMfUERam1ukL/4J8XK4rPbjDxOEP0HGWPscydS36Ux35YHw=
X-Received: by 2002:a67:f618:: with SMTP id k24mr17736934vso.48.1633431120157;
 Tue, 05 Oct 2021 03:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <CAMhs-H9p4xmPO2F_byk4DQncTGZayW1HwAzrPn_W0eEW5UUn9A@mail.gmail.com> <YVwqpCbYzxUWm5LJ@kroah.com>
In-Reply-To: <YVwqpCbYzxUWm5LJ@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 5 Oct 2021 12:51:48 +0200
Message-ID: <CAMhs-H-YDg=q6sJhhawkqkfdLCj=EhcX8G-1WGH4K928ToLYLw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] MIPS: ralink: fix PCI IO resources
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 5, 2021 at 12:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 03, 2021 at 06:21:21PM +0200, Sergio Paracuellos wrote:
> > Hi Greg,
> >
> > On Sat, Sep 25, 2021 at 10:32 PM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > >
> > > MIPs ralink need a special tratement regarding the way it handles PCI IO
> > > resources. On MIPS I/O ports are memory mapped, so we access them using normal
> > > load/store instructions. MIPS 'plat_mem_setup()' function does a call to
> > > 'set_io_port_base(KSEG1)'. There, variable 'mips_io_port_base'
> > > is set then using this address which is a virtual address to which all
> > > ports are being mapped. Ralink I/O space has a mapping of bus address
> > > equal to the window into the mmio space, with an offset of IO start range
> > > cpu address. This means that to have this working we need:
> > > - linux port numbers in the range 0-0xffff.
> > > - pci port numbers in the range 0-0xffff.
> > > - io_offset being zero.
> > >
> > > These means at the end to have bus address 0 mapped to IO range cpu address.
> > > We need a way of properly set 'mips_io_port_base' with a virtually mapped
> > > value of the IO cpu address.
> > >
> > > This series do the following approach:
> > > 1) Revert two bad commit from a previous attempt of make this work [0].
> > > 2) Set PCI_IOBASE to mips 'mips_io_port_base'.
> > > 3) Allow architecture dependent 'pci_remap_iospace'.
> > > 4) Implement 'pci_remap_iospace' for MIPS.
> > > 5) Be sure IOBASE address for IO window is set with correct value.
> > >
> > > More context about this series appoach in this mail thread [1].
> > >
> > > Patches related with reverts are from this merge cycle so they are only
> > > added to the staging git tree. So to have all stuff together I'd like to
> > > get everybody Ack's to get all of this series through staging tree if
> > > possible :).
> > >
> > > Thanks in advance for your time.
> > >
> > > Changes in v3:
> > >  - Collect Arnd's Acked-by for the patches.
> > >  - Be sure IO resource start address is zero and WARN_ONCE if it is not
> > >    on MIPS pci_remap_iospace() patch. Also make use of 'resource_size'
> > >    instead of do the logic explicitly again.
> >
> > I think nothing is missing to get this added through the staging tree.
>
> Great, thanks for sticking with this, will go queue it up now.

Thanks!

Best regards,
    Sergio Paracuellos

>
> greg k-h
