Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2789D3F86E6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbhHZMCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 08:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242147AbhHZMCI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 08:02:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4151C60EBA;
        Thu, 26 Aug 2021 12:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629979281;
        bh=O99YQ+TsybHzsga5F3D+tnXvUZcw1ANvaDzlHxFeSBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uu3ex+pPv7Hr8a23oL6UmINhYFVLjCSrg0mHaQId9fTLk5tm9DDPxsVoqZa6hWsk9
         z9RIqBU3x1eQBYtAzAhnLRkYaqAibOBBVpefjLPqxO3ly04tCUyzmdN4jsydAd648w
         bavC8sjpwjuckvLdX8R08FvqCW3/aGV4w59u6PyjJXCeh2zfISbBWGY29zgW4wT22z
         X19FbZpmjnVUZAOSYq/bfWz4EiydUNCJ0COsgjvfjr2gOGQ6DXjEdoSvJw0Pa2XpsM
         0y1xLzwm7qwv19p+PrsT4YLAkZctNfwKLVPiJ9Cb9XbkzymJ040SKVxkRP6Qw9e2kH
         DQuqwelYNv4Kg==
Received: by mail-ed1-f42.google.com with SMTP id b7so4302768edu.3;
        Thu, 26 Aug 2021 05:01:21 -0700 (PDT)
X-Gm-Message-State: AOAM533uDzGQ3Bw33SGdwlv8mtX22Ja0ENdgzpodnQVkjC9rK0MWmYbD
        PdcgezNdedmwrj9XrAsmF5trZCkWiOa/vp2xpw==
X-Google-Smtp-Source: ABdhPJwB+G4XAaWoEo5Rz8zYLWc8aNyl+hXqJx+b5eopNgdxsY8IpYedFtIkujyQXyBA3LH5TRqoGw6KOBgwFxGwQC0=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr3926073edt.194.1629979279871;
 Thu, 26 Aug 2021 05:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210825083425.32740-1-yajun.deng@linux.dev> <CAL_JsqJ4731w_0rYCSBC_Mma-rn4nUUbKnSwhymGZyh8E7xoWg@mail.gmail.com>
 <63e1e9ea1e4b74b56aeafcc6695ecfa8@linux.dev>
In-Reply-To: <63e1e9ea1e4b74b56aeafcc6695ecfa8@linux.dev>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Aug 2021 07:01:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+rRFJUO3SVLdkQV62dQPymPigiikM05Xipgfbvg_oeqw@mail.gmail.com>
Message-ID: <CAL_Jsq+rRFJUO3SVLdkQV62dQPymPigiikM05Xipgfbvg_oeqw@mail.gmail.com>
Subject: Re: [PATCH linux-next] PCI: Fix the order in unregister path
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 10:57 PM <yajun.deng@linux.dev> wrote:
>
> August 25, 2021 9:55 PM, "Rob Herring" <robh@kernel.org> wrote:
>
> > On Wed, Aug 25, 2021 at 3:34 AM Yajun Deng <yajun.deng@linux.dev> wrote:
> >
> >> device_del() should be called first and then called put_device() in
> >> unregister path, becase if that the final reference count, the device
> >> will be cleaned up via device_release() above. So use device_unregister()
> >> instead.
> >>
> >> Fixes: 9885440b16b8 (PCI: Fix pci_host_bridge struct device release/free handling)
> >> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >> ---
> >> drivers/pci/probe.c | 4 +---
> >> 1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > NAK.
> >
> > The current code is correct. Go read the comments for device_add/device_del.
>
> But the device_unregister() is only contains device_del() and put_device(). It just put
> device_del() before put_device().

And that is the wrong order as we want to undo what the code above
did. The put_device here is for the get_device we did. The put_device
in device_unregister is for the get_device that device_register did
(on success only).

Logically, it is wrong too to call unregister if register failed. That
would be like doing this:

p = malloc(1);
if (!p)
  free(p);

Rob
