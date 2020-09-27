Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8527A47C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 01:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI0XcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 19:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI0XcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 19:32:23 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A26C0613CE;
        Sun, 27 Sep 2020 16:32:22 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z13so9176545iom.8;
        Sun, 27 Sep 2020 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZ6YU8QkqvXetA4BeWJq48mo0OJ9Oxz0crizVyRgPnQ=;
        b=LBfnpwp3MtO84n7rLN09lDdxgaQPgijIySJX9jjqBw9KF+omtpeDch6oBcawxzUGzs
         yX85kVxYB9ppBIhv3Pe7vxEvtWnD6wV5PvMNS8ofM0Y5ExRkegvqyKBqHk+KJLmRTaNZ
         gvyvTQILWZPfvMBiSZW6FCRgne+/XX1lJ3EL3Fi9U8G8TkLw2Sz/55XyABK9Z+rmz+ig
         LHnRDwU3nq0vU1/XHDiYuL/CvA98PKq6A7/h/Pp5qXeO3MRG1WLYmIHXIljDEacAA67a
         vLz6rw4USRScKtxncxlaNdz3GL5xZOMOHLCVceypITeAf2XTcXYvDWVkx/oIfj51Lwe8
         v8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZ6YU8QkqvXetA4BeWJq48mo0OJ9Oxz0crizVyRgPnQ=;
        b=r/8nys+/ZZA99iKf8tEHWCHTJN6taIkLFwsp2vqdidWeWoNDtqKXv7qTKkm0Xw1xkI
         YZ969q12P7/gk6rYV6dtAx1Y0sCza7e/QbC0cr8+RleNaR81s2BKxJG1fyIhkC4LxvSL
         XCNTqVoAfhOFWFRdXKvS6qacJ0+RzRFp6ZfVuxA07o2lrI72stgqcXD0FHzCbeNMxd3w
         c0vidHYEEhLDDGtrPIb/P2CNvtJKSjPGNyUByNS3uAD9TD2x5+k+b0W9njUTY/KnODrz
         wV/coPSdTMfLqIsCMOUHvv0cWShUnJ0nbuOoOWbYZc9kjBUEdUeI1KYIiLQ+/4A6Avp5
         r03A==
X-Gm-Message-State: AOAM532r4qq5RFkYfIZxnKok66yNXeIjJe7xW3dDBevQBZX6mlfgwkk+
        NPCv9IK6KqWf3DcokeJlPTyslvIoS+wgRGXVMX4=
X-Google-Smtp-Source: ABdhPJzc5IwJZV09KI9PTIqU3GAYgTusaIZZSB0Qp6/tVIkfZR6sanJs/6HxmjpQN3io4gLQcfBmDzgSFMghUZUlYxE=
X-Received: by 2002:a02:6623:: with SMTP id k35mr6811796jac.105.1601249541984;
 Sun, 27 Sep 2020 16:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOSf1CEv3v940FR_we70qCBME0qFXPizPT8EFbf3XyK2-fPDrw@mail.gmail.com>
 <20200925194335.GA2453596@bjorn-Precision-5520>
In-Reply-To: <20200925194335.GA2453596@bjorn-Precision-5520>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 28 Sep 2020 09:32:10 +1000
Message-ID: <CAOSf1CGwj=m+P_XFAOG-KUz8mYCe1axLtk9JPmG5harHE7oArQ@mail.gmail.com>
Subject: Re: [PATCH] rpadlpar_io:Add MODULE_DESCRIPTION entries to kernel modules
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 26, 2020 at 5:43 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Sep 24, 2020 at 04:41:39PM +1000, Oliver O'Halloran wrote:
> > On Thu, Sep 24, 2020 at 3:15 PM Mamatha Inamdar
> > <mamatha4@linux.vnet.ibm.com> wrote:
> > >
> > > This patch adds a brief MODULE_DESCRIPTION to rpadlpar_io kernel modules
> > > (descriptions taken from Kconfig file)
> > >
> > > Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> > > ---
> > >  drivers/pci/hotplug/rpadlpar_core.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> > > index f979b70..bac65ed 100644
> > > --- a/drivers/pci/hotplug/rpadlpar_core.c
> > > +++ b/drivers/pci/hotplug/rpadlpar_core.c
> > > @@ -478,3 +478,4 @@ static void __exit rpadlpar_io_exit(void)
> > >  module_init(rpadlpar_io_init);
> > >  module_exit(rpadlpar_io_exit);
> > >  MODULE_LICENSE("GPL");
> > > +MODULE_DESCRIPTION("RPA Dynamic Logical Partitioning driver for I/O slots");
> >
> > RPA as a spec was superseded by PAPR in the early 2000s. Can we rename
> > this already?
> >
> > The only potential problem I can see is scripts doing: modprobe
> > rpadlpar_io or similar
> >
> > However, we should be able to fix that with a module alias.
>
> Is MODULE_DESCRIPTION() connected with how modprobe works?

I don't think so. The description is just there as an FYI.

> If this patch just improves documentation, without breaking users of
> modprobe, I'm fine with it, even if it would be nice to rename to PAPR
> or something in the future.

Right, the change in this patch is just a documentation fix and
shouldn't cause any problems.

I was suggesting renaming the module itself since the term "RPA" is
only used in this hotplug driver and some of the corresponding PHB add
/ remove handling in arch/powerpc/platforms/pseries/. We can make that
change in a follow up though.

> But, please use "git log --oneline drivers/pci/hotplug/rpadlpar*" and
> match the style, and also look through the rest of drivers/pci/ to see
> if we should do the same thing to any other modules.
>
> Bjorn
