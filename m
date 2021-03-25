Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F18349B79
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 22:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCYVNO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 17:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230465AbhCYVMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 17:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616706772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GWG62i2UZUo8ua5XusiVhjktb0103ycitfGwTI3taRk=;
        b=A9lYkoEtwQcwoseFf7xdJmPlsflGbzkz26xEdVlvsfU+YoPmqILUIdEOY4j3MqV7qUOb2t
        jlWb40OUAMhOKDICo78JxTZN+RvRcrdqMZUw6hRqxgDC7L157Y5vTu31Kl69PjtkLmU0jk
        KEKHQgW4GtNpHYoZ3NXutQyH5/J4i9Q=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-7cLdjJrXPniWOeAkd-fYXg-1; Thu, 25 Mar 2021 17:12:48 -0400
X-MC-Unique: 7cLdjJrXPniWOeAkd-fYXg-1
Received: by mail-ua1-f72.google.com with SMTP id q20so1887616uam.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 14:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWG62i2UZUo8ua5XusiVhjktb0103ycitfGwTI3taRk=;
        b=qP0ctW+L7S3a++heJV4N6tgzFW9Bf2TRAXgixltPiBx8sksVBW3MZo+pi82wi9K9gg
         M5WvCcxJi1I2W+UR2xcUGSG1hhuAxbhg+BbVDbgM8//gTIHm/HtXlLnmLRxAXe6kpnZA
         lxqdWuq3Q9cf+27PaDb4jWhW6fnU6LU1FyRNBwrj1Yh5OTDsFkChon4UCsfwX7ecrPjS
         4lHFtmNvgmxIyWx2gSxeNt6veQuKLYilrHYTiBe4Ra1HAfgwbwMAUV32wtbmDD8LTJT0
         Gpe/ZOlGcKO/sOUEqgJ97fbEUI5/+2uuU+AO+jDqQTTRBaPDO7JuebZJkl/7RaHaPbE8
         DlJA==
X-Gm-Message-State: AOAM5335/U4UxqIQzGHZc6miFRChND9AHNXC7pnXoMhoRC1ZvE74LCM4
        ZJ2nLJvj6OvLEm+C8yGLnr2Tq3VfY8PTe0kwrNp9bk5DgPim64FscdJZy07tz1EBGJ+ZvBDv2M5
        BqU72+IgH1/kyHf0xzF1xvRPq2ggXzgITWfLp
X-Received: by 2002:ab0:608e:: with SMTP id i14mr6348285ual.92.1616706767531;
        Thu, 25 Mar 2021 14:12:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXoT6sMJKhKxYG0uLG8tKxKgRpQ7swSQHje5erIKKsFPTkJAOwmC6qs9temFDCaKGJDlppAY5zSQRdXdZzN/c=
X-Received: by 2002:ab0:608e:: with SMTP id i14mr6348271ual.92.1616706767335;
 Thu, 25 Mar 2021 14:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck> <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com> <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com> <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com> <CAPv3WKcgZ9aEx7s6keWMssGefYH=rtdxSp5eiBVibtjY=sctpg@mail.gmail.com>
In-Reply-To: <CAPv3WKcgZ9aEx7s6keWMssGefYH=rtdxSp5eiBVibtjY=sctpg@mail.gmail.com>
From:   Jon Masters <jcm@redhat.com>
Date:   Thu, 25 Mar 2021 17:12:36 -0400
Message-ID: <CA+kK7Ziz+k5iJjBT8BuUDCCfCB5eat+SUYXNV+fH3UN2DLRRXA@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>, vidyas@nvidia.com,
        Thierry Reding <treding@nvidia.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Eric Brower <ebrower@nvidia.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marcin,

Many thanks for your thoughtful, heartfelt response, and I don't
disagree with your sentiments.

The truth is that we have a messy situation. As a collective community
of people who are passionate about the success of Arm in general
purpose systems, I know many who would share my personal feeling that
this is all beyond very unfortunate. That other architecture has
working, robust, PCI IP that adheres to standards (more or less)
correctly. There is no reason we can't either. But it takes a
collective industry wide effort, alongside leadership from Arm (and
others) to push things forward. I'm very impressed with where
SystemReady is headed and there are great people behind making that
happen. So I have faith that things will improve. Now is a good time
to unite as an industry behind improving both the status quo (quirks)
and future IP so that it is properly compliant. My opinion is that now
is not a good moment to rework entirely how we do PCI enumeration to
use an alternative scheme.

Please see the below for more.

On Thu, Mar 25, 2021 at 4:45 PM Marcin Wojtas <mw@semihalf.com> wrote:

> So what we have after 4 years:
> * Direct convincing of IP vendors still being a plan.

Things need to improve here. I've *expressed* as much to certain folks
around the industry. I'm not afraid to get more vocal. There is too
much IP out there even now that is doing inexcusably non-compliant
things. When I would talk to these vendors they didn't seem to take
standards compliance seriously (to any standard) because they're used
to making some BSP for some platform and nobody has stood thoroughly
over them to the point of extreme discomfort so that they change their
approach. It is now past time that we stand over these folks and get
them to change. I am not afraid to get much more intense here in my
approach and I would hope that others who feel similarly about
standardization would also choose to engage with extreme vigor.
Extreme vigor. It must become an extreme embarrassment for any of them
to continue to have any IP that claims to be "PCI" which is....not
PCI.

> * Reverting the original approach towards MCFG quirks.
> * Double-standards in action as displayed by 2 cases above.

The truth is we've had an inconsistent approach. But an understandable
one. It's painful to take quirks. I am grateful that the maintainers
are willing to consider this approach now in order to get to where we
want to be, but I completely understand the hesitance in the past.
Along with the above, we all need to do all we can to ensure that
quirks are an absolute last resort. It's one thing to have a corner
case issue that couldn't be tested pre-silicon, but there is *no
excuse* in 2021 to ever tape out another chip that hasn't had at least
a basic level of ECAM testing (and obviously it should be much more).
Emulation time should catch the vast majority of bugs as real PCIe
devices are used against a design using speed bridges and the like.
There's no excuse not to test. And frankly it boggles my mind that
anyone would think that was a prudent way to do business. You can have
every distro "just work" by doing it right, or you can have years of
pain by doing it wrong. And too many still think the BSP hack it up
model is the way to go. We ought to be dealing predominantly with the
long tail of stuff that is using obviously busted IP that was already
baked. We can use quirks for that. But then they need to go away and
be replaced with real ECAM that works on future platforms.

> I'm sorry for my bitter tone, but I think this time could and should
> have been spent better - I doubt it managed to push us in any
> significant way towards wide fully-standard compliant PCIE IP
> adoption.

Truthfully there will be some parts of the Arm story that will be
unpleasant footnotes in the historical telling. How we haven't moved
the third party IP vendors faster is a significant one. I think we
have a chance to finally change that now that Arm is gaining traction.
I am very sad that some of the early comers who tried to do the right
thing had to deal with the state of third party IP at the time.

Jon.

