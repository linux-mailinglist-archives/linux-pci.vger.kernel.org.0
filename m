Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9E234A444
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 10:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhCZJ1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 05:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCZJ1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 05:27:25 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4CFC0613AA
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 02:27:24 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id q12so2578653qvc.8
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NNlOJhf9wbzaVcR7TW78N7o1F0EzxSL4BjJh/DQlfYE=;
        b=iuEym6MLuDUoRCdXw+/mgPFlpgawcXXbRJlthqpVyRHECu1gzzqdarIJbU4Co8O8dm
         +F6JRXYS3/ctJqC5omZqQNsdVch6GyvCnKToQSgsH+OAynvgOhhUjyywtjYqByLYctXy
         sW1HO+lu7oh5ubZnpP/AJvTG6NzhfYi1cPA8LtXDkhIV+5x5g3dm04MOBOSnX29jUG7V
         Gwy0EyBk5uo5HMpGy6Z1xUoRTgQz8Nj1N69kLR0Ytcj1pyuWlIaM4vXWxh2j6eCOQl5t
         TxQd6WTePAV5za8r4pTMUaijNfM9smmpPoghiSL3/ks4xDSrit1yUcrs/JuYGNyTyPO9
         4flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NNlOJhf9wbzaVcR7TW78N7o1F0EzxSL4BjJh/DQlfYE=;
        b=Eybe4c+h7Ej/WbcQphnwfodRlSKIIkAb6ka9T9/+7IXv2/j1+3YpxwYgq/mXpHbcDP
         KzIEsc9d8wQGqzQVxZzTVR3RFQJDsChWeYj2cpTJgg8rHSkr1GW6XDq0uMsIms+WQt6x
         IBPjp0aEyJ6MJ1Gjgempw748CiQixSAu6hv3h0ehpsaEGfLo68/ny1xOgmxs6pRFxAxf
         maNzHzF0KNzjzTC34iB7BuTref8U6/2+MVB9wIA0jfLdyEDwlChagxxzrhyJ4LYUqiO4
         HAdkGoKrt36bvWNF0odcLzzrt7y+4wb5BQPO5GH/r2V6ZDvpPJEmCTPlnvE9UWGAjvej
         f2xQ==
X-Gm-Message-State: AOAM530yOKB/yRozHXDZ6bNiqa02L16z1Ql/8Z2jlrKOdeKmKSUf7lCG
        67++T1VLaD1BrlTj+rH9rWqaNT5DCHaPB6vcgAgV6A==
X-Google-Smtp-Source: ABdhPJzNOGFXKcQdtf0HjgZhGgGlGQJazS0heiA3DfCudK3yVva/yDmZQ8oe2tSV5f8pbJyGUh6xfXuwioOUoQwGcpg=
X-Received: by 2002:a0c:aa04:: with SMTP id d4mr12165321qvb.16.1616750843999;
 Fri, 26 Mar 2021 02:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck> <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com> <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com> <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com> <CAPv3WKcgZ9aEx7s6keWMssGefYH=rtdxSp5eiBVibtjY=sctpg@mail.gmail.com>
 <CA+kK7Ziz+k5iJjBT8BuUDCCfCB5eat+SUYXNV+fH3UN2DLRRXA@mail.gmail.com>
In-Reply-To: <CA+kK7Ziz+k5iJjBT8BuUDCCfCB5eat+SUYXNV+fH3UN2DLRRXA@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 26 Mar 2021 10:27:12 +0100
Message-ID: <CAPv3WKfivVPHV3Z5ksTe_aw4hMUZCosZENvqMafA8ws=6SHPqA@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Jon Masters <jcm@redhat.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

Thank you for your answer.

czw., 25 mar 2021 o 22:12 Jon Masters <jcm@redhat.com> napisa=C5=82(a):
>
> Hi Marcin,
>
> Many thanks for your thoughtful, heartfelt response, and I don't
> disagree with your sentiments.
>
> The truth is that we have a messy situation. As a collective community
> of people who are passionate about the success of Arm in general
> purpose systems, I know many who would share my personal feeling that
> this is all beyond very unfortunate. That other architecture has
> working, robust, PCI IP that adheres to standards (more or less)
> correctly. There is no reason we can't either. But it takes a
> collective industry wide effort, alongside leadership from Arm (and
> others) to push things forward. I'm very impressed with where
> SystemReady is headed and there are great people behind making that
> happen. So I have faith that things will improve. Now is a good time
> to unite as an industry behind improving both the status quo (quirks)
> and future IP so that it is properly compliant. My opinion is that now
> is not a good moment to rework entirely how we do PCI enumeration to
> use an alternative scheme.
>
> Please see the below for more.
>
> On Thu, Mar 25, 2021 at 4:45 PM Marcin Wojtas <mw@semihalf.com> wrote:
>
> > So what we have after 4 years:
> > * Direct convincing of IP vendors still being a plan.
>
> Things need to improve here. I've *expressed* as much to certain folks
> around the industry. I'm not afraid to get more vocal. There is too
> much IP out there even now that is doing inexcusably non-compliant
> things. When I would talk to these vendors they didn't seem to take
> standards compliance seriously (to any standard) because they're used
> to making some BSP for some platform and nobody has stood thoroughly
> over them to the point of extreme discomfort so that they change their
> approach. It is now past time that we stand over these folks and get
> them to change. I am not afraid to get much more intense here in my
> approach and I would hope that others who feel similarly about
> standardization would also choose to engage with extreme vigor.
> Extreme vigor. It must become an extreme embarrassment for any of them
> to continue to have any IP that claims to be "PCI" which is....not
> PCI.
>
> > * Reverting the original approach towards MCFG quirks.
> > * Double-standards in action as displayed by 2 cases above.
>
> The truth is we've had an inconsistent approach. But an understandable
> one. It's painful to take quirks. I am grateful that the maintainers
> are willing to consider this approach now in order to get to where we
> want to be, but I completely understand the hesitance in the past.
> Along with the above, we all need to do all we can to ensure that
> quirks are an absolute last resort. It's one thing to have a corner
> case issue that couldn't be tested pre-silicon, but there is *no
> excuse* in 2021 to ever tape out another chip that hasn't had at least
> a basic level of ECAM testing (and obviously it should be much more).
> Emulation time should catch the vast majority of bugs as real PCIe
> devices are used against a design using speed bridges and the like.
> There's no excuse not to test. And frankly it boggles my mind that
> anyone would think that was a prudent way to do business. You can have
> every distro "just work" by doing it right, or you can have years of
> pain by doing it wrong. And too many still think the BSP hack it up
> model is the way to go. We ought to be dealing predominantly with the
> long tail of stuff that is using obviously busted IP that was already
> baked. We can use quirks for that. But then they need to go away and
> be replaced with real ECAM that works on future platforms.
>
> > I'm sorry for my bitter tone, but I think this time could and should
> > have been spent better - I doubt it managed to push us in any
> > significant way towards wide fully-standard compliant PCIE IP
> > adoption.
>
> Truthfully there will be some parts of the Arm story that will be
> unpleasant footnotes in the historical telling. How we haven't moved
> the third party IP vendors faster is a significant one. I think we
> have a chance to finally change that now that Arm is gaining traction.
> I am very sad that some of the early comers who tried to do the right
> thing had to deal with the state of third party IP at the time.
>

There will be for sure a time for a post-mortem analysis on
appropriate levels. IMO main problems were inconsistent approach (e.g.
mentioned quirk exceptions) and lack of coordinated efforts with
sufficient pushing the vendors. You are perfectly aware about the dark
embedded/everything-custom-in-BSP times of armv7. And this mentality
was initially inherited when switching to 64-bits, whose remains we
can sometimes still observe in DT-world. This has significantly
changed during the 5 years, with a huge drive from community - it is
more and more common to use a board with a fixed firmware version and
install various distros/BSD's/ESXI or even Windows10 in a civilized
way. SystemReady can accellerate that, and this is what I really count
on.

I only wanted to stress out, that there should be some bridge between
what we want and what is possible, with the users also in mind, who
should not be blamed for vendors' decisions. In 2017 the bar was
raised to the server-grade levels for all devices, however there was
no existing arm64 system (even server) that would fully comply to it.
IMO in day0 (and later) the slash was too hard for embedded systems -
in a perfect world ARM (possibly with some partner) should have
created a reference design with pure ECAM, GICv3, SMMU, etc. and say
'look up to this golden standard, within X years you either align to
it, or you will be left without mainline Linux support'. Unfortunately
the time passed and we are in a similar place in terms of HW.

Fortunately there's been an impressive leap forward in the software
support - I'd like to express huge thanks to all people making huge,
often voluntary, effort and contribution to have such a great, more
and more developed arm64 ecosystem. Let's help them and all potential
users to enjoy the platforms that can already 'just work' and
push/blame/punish the vendors instead.

Best regards,
Marcin
