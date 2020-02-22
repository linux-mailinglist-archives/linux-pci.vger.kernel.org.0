Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C016912C
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2020 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBVSOP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Feb 2020 13:14:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36636 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgBVSOP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Feb 2020 13:14:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so5049164oic.3;
        Sat, 22 Feb 2020 10:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wMQ3G8kaOVH0ihUQElGiW0JuHb2R8FaxxPppamq/tQA=;
        b=aDIueX7pw6x8YMKhYRmjDRoA6YurfllH+G6jkwW8LnR8ID1BIcNSV0w7tXNuROkVfG
         pM1Z9S37VGRz+XlzCJvJv5IvmOW0QALqb74XAaz/47e8NGnhgsMCpp/gRDpbPpNQaCNn
         v5tX7/EYx1cuxCwkpsnmgol52Fd1HHT9+LuLWZKwHwYjwjl4kSYtKsziWb+cl/gfdHk3
         XKQN09ZDJYc1xyWdYPy1ilYdhTx96BWSLd9SNY/oGUILQZJkMC+iS2hVRTYPhFR6UbS2
         V7iysw2fIAjXj+3vb+uXTUg8Nq+OWOJ5fNQNdCFlaEN+rxqnIwFiWnRo87nWry93aXDF
         BBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wMQ3G8kaOVH0ihUQElGiW0JuHb2R8FaxxPppamq/tQA=;
        b=gaxd5LczH+WBiWyvEEgYPoDTU/HKT64V3wVLvJMyZ2+PS8LySd3oP4Usxpqvv+7Ko7
         p05OUVYVjXmxBIxPWo5X5VWOjUY9y8wkeokGyLO/kz3zeFRzmN2i9T05wv9+SoUz2dKV
         hZcmmGZUgfOH0/f0pRW+wT2/D5LA/ZDJ4xpk6wgn1ybPc7Bshsoc9yd5DwADu3oEzbr/
         T3LW0uyqnYCpybmJzhOG5Izq3n1V9sT6WJsW8Qu+k46AGgY6HcOvG5Vq1StPgsJf0LtN
         rjrUnLoz5SgbfVz/eZF7Mbn9NSG1JvvrWn5bx5otxiCRWnirMzb9OSdvkawChWCmr5iH
         0gJg==
X-Gm-Message-State: APjAAAXkfn65cHCdyI6jgEAAaYtaiWsplxq1DoMbSg2UUEDjWnr0aax/
        MJVT/huQ8Fm7joC4fvBPV77esev79QiKCOhOr+k=
X-Google-Smtp-Source: APXvYqxOt3rVvt54mdXIMY9NZ8D8uyKW+3kYbeVDIOUY7JrcrRf0N2Y4L5AOoI2DUCemeM2HW+ZB6QgmaeOFg9ApASY=
X-Received: by 2002:aca:c401:: with SMTP id u1mr6991120oif.62.1582395254316;
 Sat, 22 Feb 2020 10:14:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:12e:0:0:0:0:0 with HTTP; Sat, 22 Feb 2020 10:14:13 -0800 (PST)
In-Reply-To: <20200222165617.GA207731@google.com>
References: <20191029170250.GA43972@google.com> <20200222165617.GA207731@google.com>
From:   "Michael ." <keltoiboy@gmail.com>
Date:   Sun, 23 Feb 2020 05:14:13 +1100
Message-ID: <CAFjuqNgOO89nVhju1R3m0q_P+y97vr+xo6--0yy34P63LFBY-g@mail.gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philip Langdale <philipl@overt.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, yes this is still unfixed.
I'm sorry that I haven't been able to pursue this but the weather in
Australia has been horrendous since October last year. Your proposals
sound good but are way beyond my knowledge and skill level to
implement. I, and my friends, are happy to help in any way we can.
Cheers.
Michael.

P.S. I apologise for the double reply

On 23/02/2020, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Oct 29, 2019 at 12:02:50PM -0500, Bjorn Helgaas wrote:
>> [+cc Ulf, Philip, Pierre, Maxim, linux-mmc; see [1] for beginning of
>> thread, [2] for problem report and the patch Michael tested]
>>
>> On Tue, Oct 29, 2019 at 07:58:27PM +1100, Michael . wrote:
>> > Bjorn and Dominik.
>> > I am happy to let you know the patch did the trick, it compiled well
>> > on 5.4-rc4 and my friends in the CC list have tested the modified
>> > kernel and confirmed that both slots are now working as they should.
>> > As a group of dedicated Toughbook users and Linux users please accept
>> > our thanks your efforts and assistance is greatly appreciated.
>> >
>> > Now that we know this patch works what kernel do you think it will be
>> > released in? Will it make 5.4 or will it be put into 5.5 development
>> > for further testing?
>>
>> That patch was not intended to be a fix; it was just to test my guess
>> that the quirk might be related.
>>
>> Removing the quirk solved the problem *you're* seeing, but the quirk
>> was added in the first place to solve some other problem, and if we
>> simply remove the quirk, we may reintroduce the original problem.
>>
>> So we have to look at the history and figure out some way to solve
>> both problems.  I cc'd some people who might have insight.  Here are
>> some commits that look relevant:
>>
>>   5ae70296c85f ("mmc: Disabler for Ricoh MMC controller")
>>   03cd8f7ebe0c ("ricoh_mmc: port from driver to pci quirk")
>>
>>
>> [1]
>> https://lore.kernel.org/r/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
>> [2] https://lore.kernel.org/r/20191021160952.GA229204@google.com/
>
> I guess this problem is still unfixed?  I hate the fact that we broke
> something that used to work.
>
> Maybe we need some sort of DMI check in ricoh_mmc_fixup_rl5c476() so
> we skip it for Toughbooks?  Or maybe we limit the quirk to the
> machines where it was originally needed?
>
> Bjorn
>
