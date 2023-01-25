Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA50B67B524
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjAYOyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 09:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbjAYOyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 09:54:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6FC4ABDA;
        Wed, 25 Jan 2023 06:54:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4513861507;
        Wed, 25 Jan 2023 14:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C046C4339E;
        Wed, 25 Jan 2023 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674658474;
        bh=OfPsqjCdfFGmgTfZWF16Hureluoun8bR802TAkI8y0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YpDWd2c/L3Fg7tEV/kyHX50qE4tOoMfiaX0Ql1NqzkeZqn0++BDMVCV/9Gg62QbJ0
         qVX1PKCM3QXMo4Nfr9yNGvjAQsKmGoq2Q8gT8tl7JuaADcwHjh4VVszqKhGmrAf9Ce
         9bk+MAhbg53vhg6MAQFFqd2oo6xagxjYszFdJxj5E0EGj83qELXSToc/O8Q9tcY+x7
         h0BmX9vUIZLgE0EjX80u9IhmRv/S8kxMUa6fOVJFNSojqWGUHmscOKkdjG51Kwnn0X
         GFDDkgF6f1rYmQHE5QHKOuTI5Y9khWNCWEhTsq38JC+tPBbVtNaxJvloTF03Ci7P6e
         sVZtvclFz2E8w==
Received: by mail-vk1-f182.google.com with SMTP id bs10so834735vkb.3;
        Wed, 25 Jan 2023 06:54:34 -0800 (PST)
X-Gm-Message-State: AFqh2kpyUBI9Sa0Hm3ETlUVBl+PxJZT9qdMuhk5wuvFuq79pp+hdmykg
        ADpo6oT39SDz8NGriYNR3pWpAyUxQ4mHCHSrtA==
X-Google-Smtp-Source: AMrXdXsGnF21V74TEUY0OqpSRYqnRbaeqnTLdr1tTSTaPicCis6dSTocq4eqS+YQxRC+ADr9ygRwEn3I7glaWEetrn4=
X-Received: by 2002:a1f:a002:0:b0:3d5:d30f:81c2 with SMTP id
 j2-20020a1fa002000000b003d5d30f81c2mr4144648vke.14.1674658473582; Wed, 25 Jan
 2023 06:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com> <Y862WTT03/JxXUG8@kroah.com>
 <Y9EBSmOoE5+83jS5@axis.com> <Y9EgrKT3hDyx+ULy@kroah.com>
In-Reply-To: <Y9EgrKT3hDyx+ULy@kroah.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Jan 2023 08:54:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLGworC4beavkWSk9Uf=qFUR1RtsKBezH2xvop83C15NQ@mail.gmail.com>
Message-ID: <CAL_JsqLGworC4beavkWSk9Uf=qFUR1RtsKBezH2xvop83C15NQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Lee Jones <lee@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 25, 2023 at 6:29 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 25, 2023 at 11:15:38AM +0100, Vincent Whitchurch wrote:
> > On Mon, Jan 23, 2023 at 05:31:21PM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Jan 23, 2023 at 03:32:55PM +0000, Lee Jones wrote:
> > > > On Mon, 23 Jan 2023, Vincent Whitchurch wrote:
> > > >
> > > > > Add a PCI driver which registers all child nodes specified in the
> > > > > devicetree.  It will allow platform devices to be used on virtual
> > > > > systems which already support PCI and devicetree, such as UML with
> > > > > virt-pci.
> > > > >
> > > > > The driver has no id_table by default; user space needs to provide one
> > > > > using the new_id mechanism in sysfs.
> > > >
> > > > This feels wrong for several reasons.
> > > >
> > > > Firstly, I think Greg (Cc:ed) will have something to say about this.
> > >
> > > Yes, this isn't ok.  Please write a real driver for the hardware under
> > > control here, and that would NOT be a MFD driver (hint, if you want to
> > > split up a PCI device into different drivers, use the aux bus code, that
> > > is what it is there for.)
> >
> > I hope it's clear from my other replies in this thread that the entire
> > purpose of this driver is to allow arbitrary platform devices to be used
> > via a PCI device in virtual environments like User Mode Linux in order
> > to test existing platform drivers using mocked hardware.
>
> That still feels wrong, why is PCI involved here at all?
>
> Don't abuse platform devices like this please, mock up a platform device
> framework instead if you want to test them that way, don't think that
> adding a platform device "below" a PCI device is somehow allowed at all.

My question as well. However, that's only for Vincent's usecase. The
other ones I'm aware of are definitely non-discoverable MMIO devices
behind a PCI device.

It is perfectly valid in DT to have the same device either directly on
an MMIO bus or behind some other MMIO capable bus. So what bus type
should they all be?

> > Given this "hardware", it's not clear what a "real driver" would do
> > differently.
>
> Again, you can not have a platform device below a PCI device, that's not
> what a platform device is for at all.
>
> > The auxiliary bus cannot be used since it naturally does
> > not support platform devices.
>
> The aux bus can support any type of bus (it's there to be used as you
> want, it's just that people are currently using it for PCI devices right
> now).
>
> > A hard coded list of sub-devices cannot be used since arbitrary
> > platform devices with arbitrary devicetree properties need to be
> > supported.
>
> Then make a new bus type and again, do not abuse platform devices.

How about of_platform_bus[1]?

At this point, it would be easier to create a new bus type for
whatever it is you think *should* be a platform device and move those
to the new bus leaving platform_bus as the DT/ACPI devices bus.

> > I could move this driver to drivers/bus/ and pitch it as a
> > "PCI<->platform bridge for testing in virtual environments", if that
> > makes more sense.
>
> Again, nope, a platform device is NOT ever a child of a PCI device.
> That's just not how PCI works at all.
>
> Would you do the attempt to do this for USB?  (hint, no.)  So why is PCI
> somehow special here?

Actually, yes. It is limited since USB cannot tunnel MMIO accesses
(though I suppose USB4 PCIe tunneling can?), but we do have some
platform drivers which don't do MMIO.

Suppose I have an FTDI chip with GPIOs on it and I want to do GPIO
LEDs, keys, bitbanged I2C, etc. Those would use the leds-gpio,
gpio-keys, i2c-gpio platform drivers.

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eca3930163ba8884060ce9d9ff5ef0d9b7c7b00f
