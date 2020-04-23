Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21A31B6339
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 20:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgDWSWl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgDWSWl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2020 14:22:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EE0C09B042
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2020 11:22:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u6so7234503ljl.6
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2020 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LscwPz73Lt0pgGTl+o/FebA5dRZodM4/3xJx4XGRFWs=;
        b=ZgjkI/0hqXjrYL+1zMORXDCbPO/cbFMR+PA+1RlleHhrFArqqZqVDrF2naxr2O/nZ8
         8DcrKKqA2CocQV8SGpC3aPyDpPzeFJT3QtO/W+6TFqOD/cqopRZBQi+Y/GW8PBeaNBp0
         IcU9neWFV5iGS7i3ZNxhsiHXnEpr7As01GU3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LscwPz73Lt0pgGTl+o/FebA5dRZodM4/3xJx4XGRFWs=;
        b=Zhj+a7zGL4Y/LfRYlLYqK5xyeXz71Y/RUc1lECbmdhJwLvyHQ0IMNej9+MoPCVH40x
         UKuIeErf8gZZJUd7oiug+rA2N1Sis4uw8lY2HAUFdrjzaOXhKVYA+f3zA27FGvSuWMbg
         FffkrIuB17mc9s6dLNig+Erg5ZJvMaOw8AcP/s6uqGuRKi4YfblPUsy6cBcet5qyIelS
         zRCP6gBUJ2ubHEqlwx82XLW20wMMG/ntxJkqk56VvK8rFQWCezWHKFToGBS4ppr/y8jZ
         /LBtvM0klq7VgknzAg6hO2HDjKhF34eO0h+2/LQ/ouvclidqt0UteCP8ujIJRr3c2wwi
         yS+w==
X-Gm-Message-State: AGi0Pub9LZt+9QhafwXG9EFv/9+Te3Zd94mDj8zOp4HfaloH8cw7xL31
        9b91c4NzOs86hR/WfQIsPSaVtLnWfeQ=
X-Google-Smtp-Source: APiQypKnAAQYGhGrFz48zeOopYojBHMvUwrLy4v9y4dF1FMDGz6HjI3JlOJ4RRgkmQM0yXGhU63DLw==
X-Received: by 2002:a2e:b4c2:: with SMTP id r2mr3229313ljm.143.1587666157475;
        Thu, 23 Apr 2020 11:22:37 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z13sm2449808ljn.77.2020.04.23.11.22.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 11:22:36 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id r17so5561000lff.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2020 11:22:36 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr3320601lfd.10.1587666155908;
 Thu, 23 Apr 2020 11:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200423173955.GA193359@google.com>
In-Reply-To: <20200423173955.GA193359@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Apr 2020 11:22:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7f3HJxmhP_SKQoFwuSx-OQgvp41pbgJN7TtspQj=RUA@mail.gmail.com>
Message-ID: <CAHk-=wj7f3HJxmhP_SKQoFwuSx-OQgvp41pbgJN7TtspQj=RUA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v5.7
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 23, 2020 at 10:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   - Workaround Apex TPU class code issue that prevents resource
>     assignment (Bjorn Helgaas)

Hmm.

I have no objections to that patch, but I do wonder if it might not be
better to try to actually assign the resource at enable_resource time?

Put another way: if I read the situation correctly, what happened is
that the hardware is broken and doesn't have the proper class code,
and so the resource is not initially assigned at all. But then the
driver matches on the device ID, and tries to use the device, and then
we get into trouble at pci_enable_resources().

But is there any reason we don't just at least try to do
pci_assign_resource() at that point? Yeah, because we didn't do it at
bus scanning, maybe there's no room for it, but that's what we do for
the PCI ROM resources (which I think we also don't claim by default)
when drivers ask to map them.

The pci/rom.c code does

        /* assign the ROM an address if it doesn't have one */
        if (res->parent == NULL && pci_assign_resource(pdev, PCI_ROM_RESOURCE))
                return NULL;

could we perhaps do the same in enable_resource?

Your patch is obviously much better for an -rc kernel, so this is more
of a longer-term "wouldn't it be less fragile to ..." query.

Alternatively, maybe we should do resource assignment even for
PCI_CLASS_NOT_DEFINED?

                     Linus
