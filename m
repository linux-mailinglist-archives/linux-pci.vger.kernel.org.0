Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267603FB894
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhH3O5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 10:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhH3O5C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 10:57:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CFF560E90;
        Mon, 30 Aug 2021 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630335368;
        bh=pRLIow2bOne8zY9MmBi2l3flpVgazhDViJowLgZg0lg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H3CaWCJvRgHAHIshKvBsqQ33imfBflTIsjfytsqSg2chdx5VvdQTuENne2jHDlDjg
         GN3xgZa5SpJYshTu2MZpCjhVQmNMiiykmAXgvKM8DwNjTBtOukUtTBgyqssU49JhsN
         TyU/uwLiF7ev0CEaC+cAticxpTXi41OA5hcYqnk8M7ApshMXmuGNnuLkg0MK0Fi2gN
         Jtj2M4V7XuYXrnADy9gPzzKu0RDofUdVWVX8/sJ2YrWrV2z/ErA1rljAqwsTwpbbpu
         4S1nludJ5zP5VykTn/AbbBT9zsPMvZ0wBgNQfmppp2Nzs/mPSSTMUqKQqgAoJfybWo
         zEd99bPN7XyOw==
Received: by mail-ed1-f48.google.com with SMTP id g21so22061205edw.4;
        Mon, 30 Aug 2021 07:56:08 -0700 (PDT)
X-Gm-Message-State: AOAM530ACpd20wLXuVP6GTDmKwESNldPKsjZlFWcHGLZEoUlZg36Cb/0
        O10TnIPorv8+4ANGADZoBivH3D9ViYAVoQb+KA==
X-Google-Smtp-Source: ABdhPJxokTq2aAaklRnJkPvbh83JaHPms31ufMUIF1QhZ0YzE3zlCUXE9CvjIfCwd3EH9dvxOdOfMX28MiS3gTVJZqc=
X-Received: by 2002:a50:9b52:: with SMTP id a18mr24290884edj.165.1630335367017;
 Mon, 30 Aug 2021 07:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210825083425.32740-1-yajun.deng@linux.dev> <CAL_JsqJ4731w_0rYCSBC_Mma-rn4nUUbKnSwhymGZyh8E7xoWg@mail.gmail.com>
 <63e1e9ea1e4b74b56aeafcc6695ecfa8@linux.dev> <CAL_Jsq+rRFJUO3SVLdkQV62dQPymPigiikM05Xipgfbvg_oeqw@mail.gmail.com>
 <d6cbd8d362ae84dde2ccde6698be0d3c@linux.dev>
In-Reply-To: <d6cbd8d362ae84dde2ccde6698be0d3c@linux.dev>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Aug 2021 09:55:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKNOFhfs3=xpsLZRTaNKEnGPTKU58mDJU7AfuAwMdLrmw@mail.gmail.com>
Message-ID: <CAL_JsqKNOFhfs3=xpsLZRTaNKEnGPTKU58mDJU7AfuAwMdLrmw@mail.gmail.com>
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

On Thu, Aug 26, 2021 at 9:39 PM <yajun.deng@linux.dev> wrote:
>
> August 26, 2021 8:01 PM, "Rob Herring" <robh@kernel.org> wrote:
>
> > On Wed, Aug 25, 2021 at 10:57 PM <yajun.deng@linux.dev> wrote:
> >
> >> August 25, 2021 9:55 PM, "Rob Herring" <robh@kernel.org> wrote:
> >>
> >> On Wed, Aug 25, 2021 at 3:34 AM Yajun Deng <yajun.deng@linux.dev> wrote:
> >>
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
> >>
> >> NAK.
> >>
> >> The current code is correct. Go read the comments for device_add/device_del.
> >>
> >> But the device_unregister() is only contains device_del() and put_device(). It just put
> >> device_del() before put_device().
> >
> > And that is the wrong order as we want to undo what the code above
> > did. The put_device here is for the get_device we did. The put_device
> > in device_unregister is for the get_device that device_register did
> > (on success only).
> >
> > Logically, it is wrong too to call unregister if register failed. That
> > would be like doing this:

You are right that the register and unregister are different devices.
However, your change is still wrong. The device_register is actually
irrelevant.

> >
> > p = malloc(1);
> > if (!p)
> > free(p);
> >
> This is the raw code:
>         err = device_register(&bus->dev);
>         if (err)
>                 goto unregister;
> unregister:
>         put_device(&bridge->dev);
>         device_del(&bridge->dev);

The pertinent parts are this:

err = device_add(&bridge->dev);  // which calls get_device() itself,
so there's the first ref
if (err) {
    put_device(&bridge->dev);
    goto free;
}
bus->bridge = get_device(&bridge->dev);  // This is the 2nd ref which
the PCI core holds
...
unregister:
    put_device(&bridge->dev);  // This is the put for the get_device
just above here.
    device_del(&bridge->dev);  // Then this does the 2nd put.

The get_device and put_device are paired, and the device_add and
device_del are paired.

As I said earlier, go read the kerneldoc for device_add. For your
convenience, here's the important part:

device_add:
 * Rule of thumb is: if device_add() succeeds, you should call
 * device_del() when you want to get rid of it. If device_add() has
 * *not* succeeded, use *only* put_device() to drop the reference
 * count.

device_del:
 * NOTE: this should be called manually _iff_ device_add() was
 * also called manually.


Rob
