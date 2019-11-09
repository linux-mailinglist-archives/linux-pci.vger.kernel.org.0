Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CFEF604B
	for <lists+linux-pci@lfdr.de>; Sat,  9 Nov 2019 17:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfKIQiO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Nov 2019 11:38:14 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40750 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfKIQiO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Nov 2019 11:38:14 -0500
Received: by mail-il1-f194.google.com with SMTP id d83so7957917ilk.7
        for <linux-pci@vger.kernel.org>; Sat, 09 Nov 2019 08:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxoV9IMtdhTS/mEMSWUWhbowDm+u8Sv/9Z0oeSl6BrA=;
        b=BJhIKJrg1cAz9/9zT2ePr6CZWTPcElsKmYTc10xXaLa7jGWd6dHlkOfLixKD60yuCi
         1p2ZVQnHmSQ7hCDdQtOCruTepiQhcCZQt7tAsXsJpKJIfw6cUKi5Xp7fUa6FQyTTz3Gk
         M16Beik877oSdn0ZUsrjzWg+qbgNGAi2PUTR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxoV9IMtdhTS/mEMSWUWhbowDm+u8Sv/9Z0oeSl6BrA=;
        b=VCnlhj99VvRyy8U7i1nfPh7ppZ9jcMt9ImtFCUV5z80j+wDy8VN8DvIhSKOa7yHFxc
         i1v9nwsAb1xhgS7c1qIcPw/pdmEWp2ZrpRfbAmOx/RR2qC596cJwYHjjaB1k3R52Q8qH
         9NTl0TdLxMnXBJdRcs7vgBE9fI30QNm1M/Lmwn4IzCmM5OpXWPlP5Q0yzhVHJmn1T17h
         MRyyO/gpGH16aygM380uQVKwcLiCjV2xbQcqBsDX9ywv9QhKgwi7DNMOWOdJtZz77S75
         TeyD2B1dSRhW6OoUFTJHgsqBwRA5gbXlhiHJzfaSCfZ8OtWVvIzkKgpGPW3m95VouQBr
         mPRQ==
X-Gm-Message-State: APjAAAXul1CZv2Nv1VMXF9sxkWh6Squg1bgmi6zQ+LN/EiPSIlxIBHZu
        8src1cPZMqKuHuccJHDpH2/WS8vIF6Q=
X-Google-Smtp-Source: APXvYqx4KGqODWWtAkYI2Xq3VumO/iGYFdRwCG34k6gw5suerznPCZQMypYfMcOlGfPqoab4SifozA==
X-Received: by 2002:a92:ba09:: with SMTP id o9mr19895141ili.6.1573317493635;
        Sat, 09 Nov 2019 08:38:13 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id f8sm1244851ilf.36.2019.11.09.08.38.12
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2019 08:38:12 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id i13so8360873ioj.5
        for <linux-pci@vger.kernel.org>; Sat, 09 Nov 2019 08:38:12 -0800 (PST)
X-Received: by 2002:a02:ad14:: with SMTP id s20mr9027678jan.132.1573317491623;
 Sat, 09 Nov 2019 08:38:11 -0800 (PST)
MIME-Version: 1.0
References: <CAMdYzYoTwjKz4EN8PtD5pZfu3+SX+68JL+dfvmCrSnLL=K6Few@mail.gmail.com>
 <CAMdYzYqQpVrA9DpN5GRc2RqvsShSamw2EBJDxwng1aE3sfpfdg@mail.gmail.com>
In-Reply-To: <CAMdYzYqQpVrA9DpN5GRc2RqvsShSamw2EBJDxwng1aE3sfpfdg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 9 Nov 2019 08:37:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XXrSsnr08bbY_Lv39tdNSUOyDDSVj_3+701eYNpFRhWQ@mail.gmail.com>
Message-ID: <CAD=FV=XXrSsnr08bbY_Lv39tdNSUOyDDSVj_3+701eYNpFRhWQ@mail.gmail.com>
Subject: Re: [BUG] rk3399-rockpro64 pcie synchronous external abort
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Nov 8, 2019 at 5:09 PM Peter Geis <pgwipeout@gmail.com> wrote:
>
> Good Evening,
>
> I'm not sure, but I believe the pcie address space built into the
> rk3399 is not large enough to accommodate the pcie addresses the card
> requires.
> I've been trying to figure out if it's possible to use system ram
> instead, but so far I haven't been successful.
> Also, the ram layout for the rk3399 is odd considering the TRM, if
> anyone has any insights in to that, I'd be grateful.
>
> On Mon, Nov 4, 2019 at 1:55 PM Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > Good Morning,
> >
> > I'm attempting to debug an issue with the rockpro64 pcie port.
> > It would appear that the port does not like various cards, including
> > cards of the same make that randomly work or do not work, such as
> > Intel i340 based NICs.
> > I'm experiencing it with a GTX645 gpu.
> >
> > This seems to be a long running issue, referenced both at [0], and [1].
> > There was an attempt to rectify it, by adding a delay between training
> > and probing [2], but that doesn't seem to be the issue here.
> > It appears that when we probe further into the card, such as devfn >
> > 1, we trigger the bug.
> > I've added a print statement that prints the devfn, address, and size
> > information, which you can see below.
> >
> > I've attempted setting the available number of lanes to 1 as well, to
> > no difference.
> >
> > If anyone could point me in the right direction as to where to
> > continue debugging, I'd greatly appreciate it.

I don't have tons of knowledge here, but your thread happened to fly
by my Inbox and it reminded me of issues we faced during the bringup
of rk3399-gru-kevin where our WiFi driver would kill the whole system
in random / hard to debug ways.

If I remember, the problem was that the rk3399 PCIe behaved very badly
when you try to access the bus is in certain power save modes.  I
think that traditional x86-based controllers just return 0xff in the
same state, but rk3399 gives some sorts of asynchronous bus errors.

IIRC our problem was fixed with:

https://crrev.com/c/402092 - FROMLIST: mwifiex: fix corner case power save issue

...that's about all the knowledge I have around this area, but
possibly it could point you in the right direction?

-Doug
