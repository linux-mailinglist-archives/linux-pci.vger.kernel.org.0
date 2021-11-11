Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB644DDD5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 23:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhKKWYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 17:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhKKWYs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 17:24:48 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7BFC061766
        for <linux-pci@vger.kernel.org>; Thu, 11 Nov 2021 14:21:58 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 188so6345086pgb.7
        for <linux-pci@vger.kernel.org>; Thu, 11 Nov 2021 14:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BKlKVSWYn1I0Z87pY4nl686M+hJNylVprtBUShQPP8=;
        b=fpvZ8M2Kcj7XZIaeWf50Li9FO87nKUAQZnJoqpm3sU45tValVLIT4Rxw9xs9PruFV6
         o/5JOonKlKHWq6zqE30kt8IDDEf1Hx2iNyO0lVLWiBDLmlE8VrXe1Mch15Bj3PZmzlLA
         ONnVfGcBJ46rWBDrQ5SVSjWlRrwSx9/2o5xSqfEGypWDaTiayD4ctGXWYEB5QehIzekd
         PB1+PcF7FaFc+5qaEvO9YxFs/F3EUJqjqtH7j58xnoeG5phNNCvUDYsGbMkOyRF9BJUJ
         8EtR3O95+FZjv8hfdWHLmnJB+mwLzxmJQBpqHUXpiqfEjD9B57ACruicPMuIUkh7mRb/
         w5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BKlKVSWYn1I0Z87pY4nl686M+hJNylVprtBUShQPP8=;
        b=RXmwDUzIYB6G8vpUwj6nTjA991YwbpOoIipMtVu72IuMipHpEAdsTh7+C9J1yehSVW
         Laz5aiyUNoPJ6znW9cOrOJrQ2KCRJovB3QzvEYkqQwCwlo7U951GyVyeCf+whj2CMfkH
         UckKezrVtjJE/eVNLFGwbTqG9K2KSN0DaOX9itfrRZSRFkRHfoc4zhnuqKV4lfFy8/Ro
         65BhhZ07eyWOjMeXHL7pEOgaRbADUC492bZDkWg6GW2Zvmzi9PJ9guxwQ26OOQ13R+AU
         x2VbHC1UucVQwzmmjOvoVMSARLabthZoxm2uNjqghEi7mOyRBFLkEgG18Qc0rTjbm1dl
         hvJA==
X-Gm-Message-State: AOAM533ErsH08uXA/nzpeWxri83jejtTbxaD9OAk54EKLxvKZMofdPXW
        f4zTpHnTNjMskSFQv0YGCY1bKWFQGRSVTxUivpljgg==
X-Google-Smtp-Source: ABdhPJx7XXxBnZsNRpwtzXuzTfOJXFSovmVOHEAknpHPnTjHlWJwEv+RbIQvGnjckVbmUTZIzwnmLX+3KSNqGekIISY=
X-Received: by 2002:a63:81c8:: with SMTP id t191mr6900205pgd.192.1636669318174;
 Thu, 11 Nov 2021 14:21:58 -0800 (PST)
MIME-Version: 1.0
References: <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
 <20211110184106.GA1251058@bhelgaas> <87sfw3969l.wl-maz@kernel.org>
 <8cc64c3b-b0c0-fb41-9836-2e5e6a4459d1@xenosoft.de> <87r1bn88rt.wl-maz@kernel.org>
 <f40294c6-a088-af53-eeea-4dfbd255c5c9@xenosoft.de> <87pmr7803l.wl-maz@kernel.org>
In-Reply-To: <87pmr7803l.wl-maz@kernel.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 11 Nov 2021 14:21:46 -0800
Message-ID: <CAOesGMgHfsFKWOXNOMghO3Xqj2y8M5XA8GjVV5ciOT0A4b+wdg@mail.gmail.com>
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
To:     Marc Zyngier <maz@kernel.org>
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Matthew Leaman <matthew@a-eon.biz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <info@xenosoft.de>,
        Jens Axboe <axboe@kernel.dk>, damien.lemoal@opensource.wdc.com,
        kw@linux.com, Arnd Bergmann <arnd@arndb.de>, robert@swiecki.net,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 2:20 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 11 Nov 2021 07:47:08 +0000,
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> >
> > On 11 November 2021 at 08:13 am, Marc Zyngier wrote:
> > > On Thu, 11 Nov 2021 05:24:52 +0000,
> > > Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> > >> Hello Marc,
> > >>
> > >> Here you are:
> > >> https://forum.hyperion-entertainment.com/viewtopic.php?p=54406#p54406
> > > This is not what I asked. I need the actual source file, or at the
> > > very least the compiled object (the /sys/firmware/fdt file, for
> > > example). Not an interpretation that I can't feed to the kernel.
> > >
> > > Without this, I can't debug your problem.
> > >
> > >> We are very happy to have the patch for reverting the bad commit
> > >> because we want to test the new PASEMI i2c driver with support for the
> > >> Apple M1 [1] on our Nemo boards.
> > > You can revert the patch on your own. At this stage, we're not blindly
> > > reverting things in the tree, but instead trying to understand what
> > > is happening on your particular system.
> > >
> > > Thanks,
> > >
> > >     M.
> > >
> > I added a download link for the fdt file to the post [1]. Please read
> > also Darren's comments in this post.
>
> Thanks for that. The DT looks absolutely bonkers, no wonder that
> things break with something like that.
>
> But Darren's comments made me jump a bit, and I quote them here for
> everyone to see:
>
> <quote>
> [...]
>
> The dtb passed by the CFE firmware has a number of issues, which up till
> now have been fixed by use of patches applied to the mainline kernel.
> This occasionally causes problems with changes made to mainline.
>
> [...]
> </quote>
>
> Am I right in understanding that the upstream kernel does not support
> the machine out of the box, and that you actually have to apply out of
> tree patches to make it work? That these patches have to do with the
> IRQ routing?

To my knowledge that has never been needed -- that the base platform
support is all there.

This is an old platform, and just like with the power macs, the
devicetree is indeed supplied from firmware, and as such not easily
patchable like with ARM platforms.

Last time this was an issue (to my memory) was when they enabled
automatic little endian switching in the boot path, that caused some
issues with a (bad) phandle pointer that had gone undiscovered for 10+
years.

> If so, I wonder why upstream should revert a patch to work on a system
> that isn't supported upstream the first place. I will still try and
> come up with a solution for you. But asking for the revert of a patch
> on these grounds is not, IMHO, acceptable. Also, please provide these
> patches on the list so that I can help you to some extend (and I mean
> *on the list*, not on a random forum that collects my information).

Early fixups of DT is the way to go here, if needed -- we do it on
some other platforms. That can happen in-kernel, and keep the new
functionality. For that we'd need to figure out what's actually wrong
with the DT as such right now.



-Olof
