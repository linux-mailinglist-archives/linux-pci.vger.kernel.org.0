Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615BC27F647
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbgI3XtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 19:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbgI3XtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 19:49:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E51C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 16:49:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so3054097ljp.13
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 16:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1K6GZ5cts7m5+dPoKFk/BNjOtI5JoHWgjjAufBHq48Y=;
        b=tRyeEN3nhgw2RRiORdqa8mpKabxwtR2R8hUhmoETiBpNETmt2SnVpE5e0nP7yROGy9
         tMHSmwiXfQxTXWC44UEShc2AgHdCjJS5UaQCxQi9+e7M5Ga5b0iOtCt7qjgRkMxxBPfH
         3rJCakAOPi3yqMGC+Dp6OUPQBUNmhzbPk0YHNp7nTvYw5jQZX8GU1fAh4CfMPrViGxmb
         kzUaTEpstRZnM9P6CEIfcsWNvfaEdZVwRQWg1L2EvrHPobqfO0VfvBAf/oyFuTzlyW4Z
         DrqR/BYHu+yofs46Dxey5ewEqwVuVeyADzoGUH208xPIe160j3zc+ebPnE3YNFuxcUhv
         c8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1K6GZ5cts7m5+dPoKFk/BNjOtI5JoHWgjjAufBHq48Y=;
        b=GsTM8Y1HVjSgIjNx5+IVvHhfbV5AH+DaI3j2cfFKuRMxwD9z0d6/2CN7oliWbabYeC
         eLeQdFs/AXBRw9+iVjcFMoUUpIFq3ibOvO1bVye6UoKUPip7EfFJafvW+xB68G+fw1TM
         lS++/+aNtwLEsxwfEXidiUKdz66hwDNOMeTSPASMvd5WV7WxUu0jYVbETeuXkDq1pQBP
         7xtD5pTVXZpB0yVP/Nz8gSkn0ItNPeSlIwRu0ERXfTeP89/gzPCyyG6uKruzevMuZ7w4
         sZPp5gwZgvBd5RgFBPqxR3ECDvL7bqa6kYtEK2Qb2LSBKUkYlswA+ItWyd55WVPDwhkq
         Y1ew==
X-Gm-Message-State: AOAM532+QrEM4M6Z07KlEZ7KQkgq/5FDuNPB9E4kKt0YdQx2E8cMmBpY
        CjR/W+nMuiS54Lf8hVQSDqLJh17o/0G7X92u
X-Google-Smtp-Source: ABdhPJxf7ZY83Qyw/h83m+REyH2P0HviHDKEwswK3B/J5Q6hMpcTf1FtPONgOIKku3H2miUH7CQbUg==
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr1585556ljg.98.1601509738794;
        Wed, 30 Sep 2020 16:48:58 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id q18sm346450lfr.138.2020.09.30.16.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:48:58 -0700 (PDT)
Date:   Thu, 1 Oct 2020 01:48:57 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Android Kernel Team <kernel-team@android.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] of: address: Work around missing device_type property
 in pcie nodes
Message-ID: <20200930234857.g2gxdablzaewvwfq@oden.dyn.berto.se>
References: <CAL_Jsq+xBKbYXWipwmZ=ZidorsMUFDw2NpUyxobx4FCTn+8Hmg@mail.gmail.com>
 <20200930225154.GA2631019@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930225154.GA2631019@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 2020-09-30 17:51:54 -0500, Bjorn Helgaas wrote:
> On Wed, Sep 30, 2020 at 03:34:10PM -0500, Rob Herring wrote:
> > On Wed, Sep 30, 2020 at 12:37 PM Niklas Söderlund
> > <niklas.soderlund@ragnatech.se> wrote:
> > >
> > > Hi Marc,
> > >
> > > On 2020-09-30 18:23:21 +0100, Marc Zyngier wrote:
> > > > Hi Niklas,
> > > >
> > > > [+ Samuel]
> > > >
> > > > On 2020-09-30 17:27, Niklas Söderlund wrote:
> > > > > Hi Marc,
> > > > >
> > > > > I'm afraid this commit breaks booting my rk3399 device.
> > > > >
> > > > > I bisected the problem to this patch merged as [1]. I'm testing on a
> > > > > Scarlet device and I'm using the unmodified upstream
> > > > > rk3399-gru-scarlet-inx.dtb for my tests.
> > > > >
> > > > > The problem I'm experience is a black screen after the bootloader and
> > > > > the device is none responsive over the network. I have no serial console
> > > > > to this device so I'm afraid I can't tell you if there is anything
> > > > > useful on to aid debugging there.
> > > > >
> > > > > If I try to test one commit earlier [2] the system boots as expected and
> > > > > everything works as it did for me in v5.8 and earlier. I have worked
> > > > > little with this device and have no clue about what is really on the PCI
> > > > > buss. But running from [2] I have this info about PCI if it's helpful,
> > > > > please ask if somethings missing.
> > > >
> > > > Please see the thread at [1]. The problem was reported a few weeks back
> > > > by Samuel, and I was expecting Rob and Lorenzo to push a fix for this.
> > >
> > > Thanks for providing a solution.
> > >
> > > >
> > > > Rob, Lorenzo, any update on this?
> > 
> > The fix is in Bjorn's tree[1].
> > 
> > Bjorn, going to send this to Linus before v5.9 is out?
> 
> Definitely, thanks for the reminder.  I'm assuming the fix in question
> is https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=e338eecf3fe79054e8a31b8c39a1234b5acfdabe

That patch solves my boot problem.

Cherry-picked and tested directly on-top of v5.9-rc7 (which fails to 
boot without the patch in question).

> 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=for-linus

-- 
Regards,
Niklas Söderlund
