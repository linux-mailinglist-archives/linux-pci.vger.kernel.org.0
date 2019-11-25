Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A07A108F00
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 14:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYNhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 08:37:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39168 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKYNhy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 08:37:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id w24so12586455otk.6;
        Mon, 25 Nov 2019 05:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7I8z2XIpJjId5ryuiZ7tTW11CMQe8kAhWaZCPRxJpjc=;
        b=XpzTWRcUwhIRkjg3TVIMV9FXdyzKu7/2K9oZ/TfWc7ZI7MzEobDf5qa2t5kHpNMj32
         glLLIRgQCQ2GTFZlV5aIpyN6mjjjkqBuMYkhwt5HwfHlt5pVtaHy5zrctDRYByXGNJ7a
         hgvmlQClLa+k+cQEvlZXB9WKhT7GYZoM70Aning2k4pXlC+Axt91No1idEEmbBlHl6XX
         VmIpZ8sh62JGftJQzB3e4vU40S8sR2xgiJQaSdpUeuuL8IY17yyAJUSpNshhiVOBHIp/
         jGbINFoGy9t98GGX+S1r5z+yUKnV6H2heLd9xhaDOoHBJ+m23sz2V2G6rTc8S6IvgJst
         xy+A==
X-Gm-Message-State: APjAAAXS9Ew5mf3XlivOcVt9m41QD/XSftDhiwpbPdfiAqIPIVjvXeDx
        XT3OY97EThHR+rq16vpFs9sMuVcnR2jqTvwGYok=
X-Google-Smtp-Source: APXvYqyxR7cIli33WmFNqWgI7Fy0UCyvtp7aViv6RX+2MxAwqt0IK8X/TAZsk1zjr4pG0MDcemycbDywOsbqbcBfSgY=
X-Received: by 2002:a05:6830:232a:: with SMTP id q10mr20788376otg.262.1574689073565;
 Mon, 25 Nov 2019 05:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20191120002836.GA247344@google.com> <20191121181500.GA55996@google.com>
 <CAD8Lp47o6PqKnQYBba0o_8LSGhd3_APhVuXAVsJRT7TedeqXDg@mail.gmail.com>
 <CAJZ5v0hxa9OGF-w82ZkQ0n_p5VM7uOdKD_UrdGVoz0MAfeqy0w@mail.gmail.com> <CAD8Lp47kV-C_wf02=s-KKKgB6EVsjNVET9kqYuxfdHFDWbAShw@mail.gmail.com>
In-Reply-To: <CAD8Lp47kV-C_wf02=s-KKKgB6EVsjNVET9kqYuxfdHFDWbAShw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Nov 2019 14:37:42 +0100
Message-ID: <CAJZ5v0hieeb+UQ8CnO+z53KQz6YxLifL+GXkuNjHUM1b5zCE3A@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Daniel Drake <drake@endlessm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 25, 2019 at 4:45 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Fri, Nov 22, 2019 at 7:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > But then when pci_update_current_state() is called, it reads pmcsr as
> > > 3 (D3hot). That's not what I would expect. I guess this means that
> > > this platform's _PR3/_PS3 do not actually allow us to put the device
> > > into D3cold,
> >
> > That you can't really say.
> >
> > Anyway, it is not guaranteed to do that.  For example, the power
> > resource(s) listed by _PR3 for the device may be referenced by
> > something else too which prevents them from being turned off.
> >
> > > and/or the _PR0/_PS0 transition does not actually transition the device to D0.
> >
> > Yes.
> >
> > Which may be the case if the power resource(s) in _PR3 have not been
> > turned off really.
> >
> > [To debug this a bit more, you can enable dynamic debug in
> > drivers/acpi/device_pm.c.]
>
> We checked in an earlier thread before I figured out the timing detail
> - these power resources are being turned off at this point.
>
> > > While there is some ACPI strangeness here, the D3hot vs D3cold thing
> > > is perhaps not the most relevant point. If I hack the code to avoid
> > > D3cold altogether, just trying to do D0->D3hot->D0, it fails in the
> > > same way.
> >
> > OK, but then you don't really flip the power resource(s), so that only
> > means that _PS0 does not restore D0, but in general it only is valid
> > to execute _PS0 after _PS3 (if both are present which is the case
> > here), so this is not conclusive again.
>
> _PS0 is called after _PS3 in the above case.
>
> My feeling is that on this platform, we are not actually entering
> D3cold at any point. Linux appears to be powering off the specified
> ACPI power domains, but after turning them back on and executing _PS0
> to move to D0initialized, the pmcsr still reporting D3 state seems
> highly suspicious to me.

Well, it very well may just mean that the device didn't have enough
time to get to D0 before reading its PMCSR and it reports a
(internally) cached value.

> Also, I just experimented adding a pmscr register read to the end of
> pci_set_power_state() , after pci_platform_power_transition() has been
> called. If the power was truly cut and we're in D3cold then I would
> expect this to fail. However the register read succeeds and returns
> the same value 0x103.

Yes, that is more conclusive.  [In theory it may still not have enough
time to complete the transition before the read, so you can add a
reasonable delay in there and retest, but I don't really expect that
to make any difference. :-)]

> During resume, Linux seems to have accurately detected this failure to
> transition to D3cold in pci_update_current_state() by reading pmcsr
> and setting dev->current_state to D3hot accordingly. We then deal with
> what looks like a D3hot->D0 transition, which suffers the same failure
> as seen when I force Linux to avoid D3cold and actually do a "real"
> D0->D3hot->D0 cycle.
>
> Presumably on a platform where D3cold actually works, after the device
> has then been moved to D0uninitialized via ACPI _PS0 and _PR0,
> pci_update_current_state() would then read pmcsr and update
> dev->current_state to have value D0?

Yes, that'd be the expected behavior in that case.

> So in terms of the review comment questioning if the function name
> quirk_d3_delay() and accompanying message "extending delay after
> power-on from D3 to %d msec\n" is good (or whether it should say D3hot
> or D3cold), maybe it should say D3hot.

That would be more accurate in my view.

> Plus a comment noting that D3cold doesn't actually seem to be fully cold on this platform, so
> we're actually dealing with a D3hot -> D0 transition?

Sounds reasonable to me.

Thanks!
