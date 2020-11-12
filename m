Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414FC2B006E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 08:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKLHlX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 02:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLHlW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 02:41:22 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ACFC0613D4
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 23:41:20 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id s25so6306139ejy.6
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 23:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UiYOPA+todw5FSFUa/N69IHTNLq+VUCrue/SB0bJg/A=;
        b=iXkHxl/KTwiYtIzWODt2NpaKfdreQ7vbQd+RrrP07g0JhEskZhMDntX4YNs3t/vzhX
         GNsFrEIjFQW3bRENNmktVX1xSrwU4myia3WnLIDi1uzKKR+99hL1u0GuCQqCMtnxIZnp
         uQHNq38rfqK4uyYEXp961BSydOCzbnF0TQUNxqWIgWjk318x6OZEAGThItuxUa2PnULu
         uTB2smsAaTtZLa/YXwqgVNg5LmzcIFnSmwNcPZfmeORFynwjtZqMt6msDrIYMX6Le89i
         UH1VRAuXBB5SrpUyfB6E3sGUcJm0//azRL031eKiTg7OhEF67bmaEWtFHsevbSUbkc/5
         ylUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiYOPA+todw5FSFUa/N69IHTNLq+VUCrue/SB0bJg/A=;
        b=SXfvQz0KhN9x6g7WjVXW4aw0n1P4BStgrxV7IlyW13TdGz4pIGmFBZLFIkggV9t4/V
         lwJGA7iuuhp0l+GsYIdc6aYu29OXxXJzifR5D2in1Y1uoHiys46GhA/U3kaYwr1oj5Le
         hr9Gq102dtwKEYzQBpoTMEx0VOywUNTKHa00Pusy5l6VWFydPrPwgkDnJKe1uvw6qbYG
         vb+gQb1f132IU+7tY1eqQzdvnQktFkC67FxQB03CRvyQapLz//7KD7/nLoUK6nj+0EQL
         0jm+a/mrqXI7p+v3vS5JB5dmswD4eGWB6jyjZUWlGvJOXqQQu2cJR59+ZtnwqtJhg1Cg
         KD1Q==
X-Gm-Message-State: AOAM531ODoXW57Znt5OFA3sc2TxdqIze0Q2pzxL2RqPf6a6eF4cEBPQv
        EVOUkh62/0L64vj253lK5YlXj+Kj3KkOII+vYUYFShErhUfyocRM
X-Google-Smtp-Source: ABdhPJxNmFb32Z+wy2z/IRtkQ6+v1uY6F8imdWZ/dAI6ENRdYGHLp9PCAR2rHQG2SZah6PjsrQRk318kHLkd8Wad9v8=
X-Received: by 2002:a17:906:c41:: with SMTP id t1mr29515457ejf.19.1605166879512;
 Wed, 11 Nov 2020 23:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de> <87mtzxkus5.fsf@nanos.tec.linutronix.de>
 <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de> <87v9ec9rk3.fsf@codeaurora.org>
 <87imab4slq.fsf@codeaurora.org> <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
 <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com>
 <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com>
 <0b58872b4f27dbf5aad2a39f5ec4a066e080d806.camel@seibold.net> <875z6b3v22.fsf@codeaurora.org>
In-Reply-To: <875z6b3v22.fsf@codeaurora.org>
From:   wi nk <wink@technolu.st>
Date:   Thu, 12 Nov 2020 08:41:08 +0100
Message-ID: <CAHUdJJVK1vH2_9YkCQ99n5mak3oGN09422gG0APkWwcy=ZDQ-Q@mail.gmail.com>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Stefani Seibold <stefani@seibold.net>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        Devin Bayer <dev@doubly.so>, ath11k@lists.infradead.org,
        Thomas Krause <thomaskrause@posteo.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12, 2020 at 8:15 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Stefani Seibold <stefani@seibold.net> writes:
>
> > Am Donnerstag, den 12.11.2020, 02:10 +0100 schrieb wi nk:
> >> I've yet to see any instability after 45 minutes of exercising it, I
> >> do see a couple of messages that came out of the driver:
> >>
> >> [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
> >> [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
> >>
> >> then when it associates:
> >>
> >> [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
> >> [   16.722636] wlp85s0: authenticated
> >> [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
> >> [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
> >> (capab=0x411 status=0 aid=8)
> >> [   16.738443] wlp85s0: associated
> >> [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes
> >> ready
> >>
> >> The adapter is achieving around 500 mbps on my gigabit connection, my
> >> 2018 mbp sees around 650, so it's doing pretty well so far.
> >>
> >> Stefani - when you applied the patch that Kalle shared, which branch
> >> did you apply it to?  I applied it to ath11k-qca6390-bringup and when
> >> I revert 7fef431be9c9 there is a small merge conflict I needed to
> >> resolve.  I wonder if either the starting branch, or your chosen
> >> resolution are related to the instability you see (or I'm just lucky
> >> so far! :)).
> >>
> >
> > I used the vanilla kernel tree
> > https://git.kernel.org/torvalds/t/linux-5.10-rc2.tar.gz. On top of this
> > i applied the
> >
> > RFT-ath11k-pci-support-platforms-with-one-MSI-vector.patch
> >
> > and reverted the patch 7fef431be9c9
>
> I did also my testing on v5.10-rc2 and I recommend to use that as the
> baseline when debuggin these ath11k problems. It helps to compare the
> results if everyone have the same baseline.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Absolutely, I'll rebuild to 5.10 later today and apply the same series
of patches and report back.  I'll also test out the patch on both
versions from Carl to fix resuming.  It stands to reason that we may
be seeing another regression between Stefani (5.10) and myself (5.9
bringup branch) as I don't see any disconnections or instability once
the interface is online.
