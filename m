Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728604137F3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 19:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhIURGP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhIUREg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 13:04:36 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D469C061574;
        Tue, 21 Sep 2021 10:03:07 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id t200so8340333vkt.0;
        Tue, 21 Sep 2021 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uuqe2hWj8nt9M5nFN4rsPr21lyaB8JT5mXmkFcl2sY=;
        b=ANwl7h/Pol6U5mSvFg6+LKftwpHU/ca6ctZyAVlBvNEGJxfIGmiqN3oFAewJpfDEDi
         Ts8qKCVdbAKpbhW6oZQEc87hHvh10W1aZOXQWv7iWbR8Oduje2iXzV7U9RsHMJKy3Jpg
         2c7CoaJJw0QuGe/MGzLYnMbF9fUneMfRwRRQ7mQZBLkfTWSbj0fchyW5ATCkss+c5EUq
         sNyOm3tOtLcKEn2LZ++mTc3jKqwRo6Af+L3ASNDIx57lHCpS9Kle/sv2sE071b0qLO5+
         98l3fYKFCkaH09FIyiSG5Ujp1y3JhP3svW9Rd2M24ovMY0FgbiywMYbQiI4KpIG6jnW6
         8ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uuqe2hWj8nt9M5nFN4rsPr21lyaB8JT5mXmkFcl2sY=;
        b=b65WzcM1UV9NHkvwePT02qmGkBly1mvyBBqJdfQjKKfKDdCgMKN7FFsqGLchgaVVUF
         bSirppvYhxSr+P5FbCnvYPsYO1VfMa0ueiK3JUNNVkEd2sRfy/+GDXu3pkgFt3sgpIJr
         nJ6ONuukjm+2Jsh/U0zdNuYqHiZe0VOsvoU2+/mC4ItMGKqkkhM3cJyMScmoxMyupVxm
         A15sDbajgQ8F3CG7T0vTqTNBN+I1gscf6LYVkdNOv32OAeAa91VqtWJ8024PmEJ//nZW
         T21RYESb8SIcX/NttB+XaHTyT/gAYKTx+dJVQisuTBehJtRMGlz9uiRzPWTRmGHCBJXq
         KAOQ==
X-Gm-Message-State: AOAM533aDXmNP1T6o5NEJA3SZKHp4zgGxtga9WM7QVwFaNBNjiJjOK7W
        cxLqW8CTRa4IznoSVns/n3Zm5f2PHEO4vofIWgE=
X-Google-Smtp-Source: ABdhPJxFjG92qSIt8J08yxejH5pyEcCAIxfVvSBp1GjhBNwkM8jA1r4wdFdc0wAuiRMGDnpxcFJTyfWEmWD6on2OGHQ=
X-Received: by 2002:a1f:abc9:: with SMTP id u192mr2109898vke.17.1632243786397;
 Tue, 21 Sep 2021 10:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
 <20210822161005.22467-4-sergio.paracuellos@gmail.com> <YSip4/kMNOG4uYC3@kroah.com>
 <CAMhs-H_0ytYCoBLj9GJDjHSPPHLC6_oBsm-V9s4FjhE7NY8TCw@mail.gmail.com>
 <YTCWR7oyLWgTDbQe@kroah.com> <CAMhs-H8U-crQHFVQj6j4Y5qs-S2NaW9trH8twKH8AwDR+AAYgg@mail.gmail.com>
 <20210902110835.GB7614@alpha.franken.de> <CAMhs-H_1U=X25+q=wDnQ+FGbxXMx1vFpefEMJviFxOc7T0jwjA@mail.gmail.com>
 <YUn6BmP/4EvFmawz@kroah.com>
In-Reply-To: <YUn6BmP/4EvFmawz@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Sep 2021 19:02:55 +0200
Message-ID: <CAMhs-H8n0VrPsvP4KqRYZLkiJrXxQcmDgBAq__J+rmbnHFCxOA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] staging: mt7621-pci: set end limit for 'ioport_resource'
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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

On Tue, Sep 21, 2021 at 5:28 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 02, 2021 at 01:19:53PM +0200, Sergio Paracuellos wrote:
> > On Thu, Sep 2, 2021 at 1:08 PM Thomas Bogendoerfer
> > <tsbogend@alpha.franken.de> wrote:
> > >
> > > On Thu, Sep 02, 2021 at 12:15:12PM +0200, Sergio Paracuellos wrote:
> > > > On Thu, Sep 2, 2021 at 11:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sun, Aug 29, 2021 at 05:14:27PM +0200, Sergio Paracuellos wrote:
> > > > > > On Fri, Aug 27, 2021 at 11:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Sun, Aug 22, 2021 at 06:10:05PM +0200, Sergio Paracuellos wrote:
> > > > > > > > We have increase IO_SPACE_LIMIT for ralink platform to get PCI IO resources
> > > > > > > > properly handled using PCI core APIs. To align those changes with driver
> > > > > > > > code we have to set 'ioport_resource' end limit to IO_SPACE_LIMIT to avoid
> > > > > > > > errors.
> > > > > > > >
> > > > > > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > > > >
> > > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > >
> > > > > > Thanks. Since I am planning to move 'mt7621-pci' from staging to
> > > > > > 'drivers/pci/controller' and send v3 after the next merge window, I
> > > > > > prefer this patch to go through the staging tree. For the other two I
> > > > > > don't have any preference and it is ok for me to go through mips or
> > > > > > pci trees. So, Bjorn and Thomas is up to you if you are ok with the
> > > > > > changes.
> > > > >
> > > > > Yes, I would need acks for the other patches in the series if this is to
> > > > > come through the staging tree.
> > > >
> > > > Yes, I know it. Let's wait for Thomas and Bjorn preference for those
> > > > remaining two.
> > >
> > > I've sent my acked-by for the MIPS patch.
> >
> > Thanks!
>
> Ok, I took patches 1 and 3 in my tree now.  Please submit patch 2 to the
> PCI developers and maintainer, as that is up to them to take, not me.

Ok, thanks. I will resend the remaining patch if that is needed. Only
one concern here, only with those two patches applied the driver is
totally broken since it needs the remaining PATCH to make all the pci
subsystem work. Is this ok?

Best regards,
    Sergio Paracuellos
>
> thanks,
>
> greg k-h
