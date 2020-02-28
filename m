Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C192174396
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 00:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgB1XvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 18:51:14 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37951 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XvO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 18:51:14 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so4330815ilq.5;
        Fri, 28 Feb 2020 15:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZOMhZvjkdqC09tY/ScTXZisrX0g/+T4ku/jItf4b0U=;
        b=Q67Ici//pAGvVef2MHDdSVqTdyryHI21yoH6h2B8WhfOSZs5NwuiBj5ouUgYVW3eq4
         C+dinnRc+Y4Hprlm1YMEnlOkOOurVriQl2w0pbqh9KHq7Qf4khRbcfGoiwFzjO5T0SMW
         u6RmyRRMvIlCLaKUw2wsYfvzA1TZTDAGIqNcJ+lYH8bd/AAcFNfRxiij7CTrpE4HpTwV
         6uNKr7tuciMTAf8QYxMCA65NM2M9eRl3PxqaSFfelJkGcWatjxRIAWlMRoInLg+FbGDn
         p2Lax15wovw+b+mlcAee4LaYkXw0x3LgBTSM8aH03nk3xqhStVuj6iKEsHAjlGnNqbI7
         h1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZOMhZvjkdqC09tY/ScTXZisrX0g/+T4ku/jItf4b0U=;
        b=RMVApmFNfaNaOMqgZtzBWJTnuC95nTkPFVtc8KxRtpE5twWDAl5IkaKhz/f6xPXKbn
         PzlAjO4TWARSWms9uIaZBg6yv2xFCIKOT8QRhAJNgOymNTgGqpb21+ApqSdor2yiunET
         s5z+Sxt5KLZQhLPudlyuYPIwowQDv6gxh9AcxHaF+s4yDUk/2K8uSfwDAwENeZGScUd9
         T+GJ4z+LDiIjL9scw4/Gn1lUOzT0Z3GiB2ZImB2rIkqK6FPJ4VTXdNLldKhClRtcmWS1
         Wl10ma24Z/3xmGqZb9/vrr0T0fMDIOozpU2u/ayI/qozCGRvRXOmhqnl75aHGSywlatO
         vwug==
X-Gm-Message-State: APjAAAUszqqVgA9g5czJaZR4gQU7KFv4Oe2qdh17cPV0yJ4DYncM1UOR
        myntkhwU9mFdDco+A7xPGDG9CYObLi57ZHiidJ4=
X-Google-Smtp-Source: APXvYqxAf2OKu5gwgxqiXrp1iS5BS/ePr66lA9hJ03QGLfhJBkXmrjtJGclUFBajnBAf4hE3l4Tk1w8E9uCyvCiECYs=
X-Received: by 2002:a92:3bd4:: with SMTP id n81mr6735002ilh.110.1582933873410;
 Fri, 28 Feb 2020 15:51:13 -0800 (PST)
MIME-Version: 1.0
References: <CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com>
 <20200222165556.GA207281@google.com>
In-Reply-To: <20200222165556.GA207281@google.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 28 Feb 2020 15:51:01 -0800
Message-ID: <CAEdQ38EzZfUJA-8zg-DgczYTwkxqFL-AThxu0_fC2V-GkXGi2Q@mail.gmail.com>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jay Estabrook <jay.estabrook@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 22, 2020 at 8:55 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Apr 16, 2018 at 07:33:57AM -0700, Matt Turner wrote:
> > Commit f75b99d5a77d63f20e07bd276d5a427808ac8ef6 (PCI: Enforce bus
> > address limits in resource allocation) broke Alpha systems using
> > CONFIG_ALPHA_NAUTILUS. Alpha is 64-bit, but Nautilus systems use a
> > 32-bit AMD 751/761 chipset. arch/alpha/kernel/sys_nautilus.c maps PCI
> > into the upper addresses just below 4GB.
> >
> > I can get a working kernel by ifdef'ing out the code in
> > drivers/pci/bus.c:pci_bus_alloc_resource. We can't tie
> > PCI_BUS_ADDR_T_64BIT to ALPHA_NAUTILUS without breaking generic
> > kernels.
> >
> > How can we get Nautilus working again?
>
> I don't see a resolution in this thread, so I assume this is still
> broken?  Anybody have any more ideas?

Indeed, still broken.

I can add Kconfig logic to unselect ARCH_DMA_ADDR_T_64BIT if
ALPHA_NAUTILUS, but then generic kernels won't work on Nautilus. It
doesn't look like we have any way of opting out of
ARCH_DMA_ADDR_T_64BIT at runtime, and doing enough plumbing to make
that work is not worth it for such niche hardware. Maybe removing
Nautilus from the generic kernel build is what I should do until such
a time that we really fix this?

Or maybe I could put a hack in pci.c that more or less undoes
d56dbf5bab8c on Nautilus. #if defined CONFIG_ARCH_DMA_ADDR_T_64BIT &&
!defined SYS_NAUTILUS.

Or maybe I just need to take a weekend and try to understand the PCI
code, instead of applying patches I don't understand and praying :)

Thoughts? Other suggestions?
