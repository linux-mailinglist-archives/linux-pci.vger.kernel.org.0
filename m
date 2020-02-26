Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BF916F548
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 02:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgBZBuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 20:50:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45749 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgBZBuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 20:50:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so1379313oic.12;
        Tue, 25 Feb 2020 17:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cqjVr4P+Kx7Aj0MCYX2B2K5foMc1YDAf0XaQUo+UPj8=;
        b=Ys08B7oWFaFdnsF2tjs1E8DXz/R8UVOepAP9umNe6VG+0iVDrT5Y1WU8bm/j8GPNj6
         Q7ncfNMqRlnnO4BJ898zRVlKvZlqt/iiYbIMiusw0SXGs9A78RSNFSgDjVXpLkgAnwDz
         SKuy03nSWTEKODmuAcPJOv+SvzqykOr/3AQUyye1dlygIIiLlk+iaVGLWCPvUXXBFs7u
         ifXGFt0GW/fjLQNxpHaAMkU/VXEdLpawuWfJzuQeptRUqSzvFFuHQ3l4MpiMDRR0uF88
         2T98DpkTn+WIVN0kYiq6cP5votSL1h4k8uFlmC+9BhJH70qZa+WYOrPZNPBvoOwG6BAW
         R2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cqjVr4P+Kx7Aj0MCYX2B2K5foMc1YDAf0XaQUo+UPj8=;
        b=UGzy36QxBMqFnSaS6EyLy03CRMBpIyGue1wRCgW1rKGEwYvnX7gb+GRL4NJlmEH6k9
         9+m3irxDbshgljKpyeBmjeUPpkBrQIMqn6SdEN0x4E7nLR7IOH07hblyBmMjq3p/CjnN
         Kt8XRoSK8IV5ti+ZTmTIGH6KruH3iBj9W8kXZBW+EN3kQCOs892m4Q/tHvkEpiiT+G7G
         1tnpVipYaRwNnVpIBKgCAAtWD853S06w0qKbi8GOLRCxxpvE3h0MMPZipLvBYVj1eoWo
         GgkUN5HXoNi4ypzQo7NOLjiVXCbft0/6eqWo5l2sAvPbzBlKoUg/hlefBRO/2BFxMPEi
         zmLw==
X-Gm-Message-State: APjAAAUuwFZe3vZgoOvhRW7qe9QB4Yi/NmiiO2IlJcb0G47E/tJx4CXM
        hIUGR2w2OU1IHkRqfSuhUZ9uQg265Rw3A5OTx18=
X-Google-Smtp-Source: APXvYqx9ngvk5zaaTxYTSAXW3RGwtiSiitUZiFsDdNmmPRSAOUsWONg6Z69Hut3CUOvRLoiMn7yuFNQNCK8yjqNBFks=
X-Received: by 2002:aca:4a84:: with SMTP id x126mr1248671oia.99.1582681814732;
 Tue, 25 Feb 2020 17:50:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:74d9:0:0:0:0:0 with HTTP; Tue, 25 Feb 2020 17:50:14
 -0800 (PST)
In-Reply-To: <20200226011310.GA2116625@rani.riverdale.lan>
References: <20191029170250.GA43972@google.com> <20200222165617.GA207731@google.com>
 <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com> <20200226011310.GA2116625@rani.riverdale.lan>
From:   "Michael ." <keltoiboy@gmail.com>
Date:   Wed, 26 Feb 2020 12:50:14 +1100
Message-ID: <CAFjuqNg_NW7hcssWmMTtt=ioY143qn76ooT7GRhxEEe9ZVCqeQ@mail.gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>,
        Philip Langdale <philipl@overt.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Through our own testing it hasn't worked on any of the regular Linux
releases (both Deb and RPM varieties, and I think someone tested Arch
or Slackware as well) after 2.6.32 .

On 26/02/2020, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> On Tue, Feb 25, 2020 at 04:03:32PM +0100, Ulf Hansson wrote:
>> On Sat, 22 Feb 2020 at 17:56, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >
>> > On Tue, Oct 29, 2019 at 12:02:50PM -0500, Bjorn Helgaas wrote:
>> > > [+cc Ulf, Philip, Pierre, Maxim, linux-mmc; see [1] for beginning of
>> > > thread, [2] for problem report and the patch Michael tested]
>> > >
>> > > On Tue, Oct 29, 2019 at 07:58:27PM +1100, Michael . wrote:
>> > > > Bjorn and Dominik.
>> > > > I am happy to let you know the patch did the trick, it compiled
>> > > > well
>> > > > on 5.4-rc4 and my friends in the CC list have tested the modified
>> > > > kernel and confirmed that both slots are now working as they
>> > > > should.
>> > > > As a group of dedicated Toughbook users and Linux users please
>> > > > accept
>> > > > our thanks your efforts and assistance is greatly appreciated.
>> > > >
>> > > > Now that we know this patch works what kernel do you think it will
>> > > > be
>> > > > released in? Will it make 5.4 or will it be put into 5.5
>> > > > development
>> > > > for further testing?
>> > >
>> > > That patch was not intended to be a fix; it was just to test my guess
>> > > that the quirk might be related.
>> > >
>> > > Removing the quirk solved the problem *you're* seeing, but the quirk
>> > > was added in the first place to solve some other problem, and if we
>> > > simply remove the quirk, we may reintroduce the original problem.
>> > >
>> > > So we have to look at the history and figure out some way to solve
>> > > both problems.  I cc'd some people who might have insight.  Here are
>> > > some commits that look relevant:
>> > >
>> > >   5ae70296c85f ("mmc: Disabler for Ricoh MMC controller")
>> > >   03cd8f7ebe0c ("ricoh_mmc: port from driver to pci quirk")
>> > >
>> > >
>> > > [1]
>> > > https://lore.kernel.org/r/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
>> > > [2] https://lore.kernel.org/r/20191021160952.GA229204@google.com/
>> >
>> > I guess this problem is still unfixed?  I hate the fact that we broke
>> > something that used to work.
>> >
>> > Maybe we need some sort of DMI check in ricoh_mmc_fixup_rl5c476() so
>> > we skip it for Toughbooks?  Or maybe we limit the quirk to the
>> > machines where it was originally needed?
>>
>> Both options seems reasonable to me. Do you have time to put together a
>> patch?
>>
>> Kind regards
>> Uffe
>
> The quirk is controlled by MMC_RICOH_MMC configuration option. At least
> as a short-term fix a bit better than patching the kernel, building one
> with that config option disabled should have the same effect.
>
> From the commit messages, the quirk was required to support MMC (as
> opposed to SD) cards in the SD slot. I would assume this will be an
> issue with the chip in any machine as the commit indicates that the
> hardware in the chip detects MMC cards and doesn't expose them through
> the SDHCI function.
>
> It looks like the quirk was only enabled by default in 2015, at least
> upstream [1], though in Debian it was enabled in May 2010 going by their
> git repo, maybe in 2.6.32-16.
>
> [1] commit ba2f73250e4a ("mmc: Enable Ricoh MMC quirk by default")
>
