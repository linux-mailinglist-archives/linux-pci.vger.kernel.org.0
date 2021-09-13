Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96E5409D74
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhIMTxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbhIMTxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 15:53:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D3BC061574
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 12:51:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so23476439lfu.5
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxvUYX6CB3TPUGmS7/jpbE8VMgExYcmzVlWcGHNrPMo=;
        b=IN/N1k7/0uf237nbjPVVzTVJSgFN3bYd99A9aKFIa+jtt3IMsGJBP6PGYvX1MYdSOD
         Civ/GgKm3CjDaxnbSQDJxmnw//gK3twKZDeiTEe9al8sr846qp1Sw9kfisxCaORn4y/l
         BKkBR51JKLXBSO2qGB/Td3zGyCHB78Az8LPRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxvUYX6CB3TPUGmS7/jpbE8VMgExYcmzVlWcGHNrPMo=;
        b=QHmDjaDGKTLPj1DPCE0TbREjXt2GA4mFr+BLhwRXAyT6L5Z6bXEORhxgzGqlst02wR
         UJANWSnkz4GARJbXwQjsMNavA8EBUfLRtYKlPQp2MY1NgUVx77E9fgKCIwldACnu9U+6
         KejwvdRXTd5a+tmHEoyuBr9nNQzdXuoLOOygb7NAHpXHT0ClVaOuWfCf568mGTvExgOx
         ITjCWsEsomuyAeB2s5aX7fIxXUsSTkR2kV2TR4Us2nCXI8aR0Mms8J09BptbcKFxHc9e
         Lr1Go+GAnI6E2lALAlRDNtYw9sYMGtsFQEkULZlrcnx43kk0pFrWgZc7piWLH3um/ZjG
         +O4g==
X-Gm-Message-State: AOAM530pA2xxujWqWGA46wKOxz22gcQAN11MnqxXhcjyUOTVUUvD8tZU
        zE/nTZrhwONYUE1YS6zADt/6u3QlXQyqyIZcF0k=
X-Google-Smtp-Source: ABdhPJxYJNFZn3REemLvEyL9i4h9qqrqUFSXrxi83HSQMjOaXj8qB7snTeO7TffLARPbPgpDYD3MGQ==
X-Received: by 2002:a05:6512:3f13:: with SMTP id y19mr9783390lfa.211.1631562707600;
        Mon, 13 Sep 2021 12:51:47 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id a13sm1087679ljn.120.2021.09.13.12.51.46
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 12:51:47 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id k13so23479985lfv.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 12:51:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr10374035lfv.655.1631562706727;
 Mon, 13 Sep 2021 12:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk> <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
In-Reply-To: <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 12:51:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUJe9rsM5kbmq7jLZc2E6N6XhYaeW9-zJgWaDC-wDiuw@mail.gmail.com>
Message-ID: <CAHk-=wgUJe9rsM5kbmq7jLZc2E6N6XhYaeW9-zJgWaDC-wDiuw@mail.gmail.com>
Subject: Re: Linux 5.15-rc1
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 12:00 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> With an older kernel you may experience the stall when accessing the vpd
> attribute of this device in sysfs.

Honestly, that old behavior seems to be the *much* better behavior.

A synchronous stall at boot time is truly annoying, and a pain to deal
with (and debug).

That pci_vpd_read() function is clearly NOT designed to deal with
boot-time callers in the first place, so I think that commit is simply
wrong.

And yes, I see that "128ms timeout". If it was _one_ timeout, that
would be one thing,. But it looks like it's repeated over and over.

Not acceptable at boot time. Not at all.

Bjorn. Please revert. Or I can do it.

            Linus
