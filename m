Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31B7285679
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 03:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJGBrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 21:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJGBrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 21:47:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0A7C061755;
        Tue,  6 Oct 2020 18:47:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n6so658961ioc.12;
        Tue, 06 Oct 2020 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Q9bSmskWSEkb9gd9wms6mpxggsv5bcsjx2/k1X765I=;
        b=ou4pOjTXlapUdIXJIJdGYGjfsLyiC/GDbq31d7UEU4ayikIQkDv8xsrzNBimSiQvRD
         hyj4uIqxBJbbfFUzV9mNGYK6Irh+77wP+oSkeVtxdGrZsBqBMXwmqVJKIZIOdaf7+1QJ
         Hy839G7LOS20O+F292EwGXIXRc2zQm+pORwba/k/bE0kCoSgTOoRmImcCd3UCtcU3ept
         pFNZ+OFMCwDEvNcOUIRYqg4SG2F+0RTDpWczShOlDY4KO8oQMJvCQV2VoHf07gyeh2hw
         P5JL5fdoFvr8ZLLR1FtP+IZTvg+Ul2z3aFcti/Y2p3Ju6fnkm74+cwTT9X1bxG1vKEoj
         NMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Q9bSmskWSEkb9gd9wms6mpxggsv5bcsjx2/k1X765I=;
        b=cHEg9XBW+s8eqP/yZDu6Zh/i2uUfGs6e4TgsbsIb/76ra/G+Z7SQJMkZHUVmiKE0xn
         CtyxmG8f4B52nM+Mt3cZBe7tgsba/JY6TvDjBX7s5U6zsleburv+muvukhCefuq+t9O/
         NaIH2h5hXpwfHVMTHasEmnElHbPYCNiu+TB5TMpYzNvzLlXJBF5h0fAjLn9+smudOgGO
         8qtYA/K7izws7I3bDDPVtKsME/d5syByZO5h4fqGct3ySEFKuDrbMKz0B2QKnAdeWLvS
         K73Pg9sPEQmaVU0opV+p9gV9dmaCfhs7drtueoxqqyeBen5SW3V0a0LWoAncKnlAQ0E5
         bgdA==
X-Gm-Message-State: AOAM530fSUDqebzQ3ZQlSM0G3aCEz92zzdUCVHgKcozoK29N4vpWhFZS
        abCOlFZqQAcJ4P/jkjn1bIpymzzNXdZCQ8R5dbE=
X-Google-Smtp-Source: ABdhPJzujMbko+gE4wSgDhZfWwRJP9QqOAvVvhXxZfo/MT29qGeeAZDLhXX/kdhSjuk+OF6zh7B8J+mN87oT00y8/8Q=
X-Received: by 2002:a02:c914:: with SMTP id t20mr921216jao.117.1602035271378;
 Tue, 06 Oct 2020 18:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200909112850.hbtgkvwqy2rlixst@pali> <20201006222222.GA3221382@bjorn-Precision-5520>
In-Reply-To: <20201006222222.GA3221382@bjorn-Precision-5520>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 7 Oct 2020 12:47:40 +1100
Message-ID: <CAOSf1CHss03DBSDO4PmTtMp0tCEu5kScn704ZEwLKGXQzBfqaA@mail.gmail.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 7, 2020 at 10:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> I'm not really a fan of this because pci_sysfs_init() is a bit of a
> hack to begin with, and this makes it even more complicated.
>
> It's not obvious from the code why we need pci_sysfs_init(), but
> Yinghai hinted [1] that we need to create sysfs after assigning
> resources.  I experimented by removing pci_sysfs_init() and skipping
> the ROM BAR sizing.  In that case, we create sysfs files in
> pci_bus_add_device() and later assign space for the ROM BAR, so we
> fail to create the "rom" sysfs file.
>
> The current solution to that is to delay the sysfs files until
> pci_sysfs_init(), a late_initcall(), which runs after resource
> assignments.  But I think it would be better if we could create the
> sysfs file when we assign the BAR.  Then we could get rid of the
> late_initcall() and that implicit ordering requirement.

You could probably fix that by using an attribute_group to control
whether the attribute shows up in sysfs or not. The .is_visible() for
the group can look at the current state of the device and hide the rom
attribute if the BAR isn't assigned or doesn't exist. That way we
don't need to care when the actual assignment occurs.

> But I haven't tried to code it up, so it's probably more complicated
> than this.  I guess ideally we would assign all the resources before
> pci_bus_add_device().  If we could do that, we could just remove
> pci_sysfs_init() and everything would just work, but I think that's a
> HUGE can of worms.

I was under the impression the whole point of pci_bus_add_device() was
to handle any initialisation that needed to be done after resources
were assigned. Is the ROM BAR being potentially unassigned an x86ism
or is there some bigger point I'm missing?

Oliver
