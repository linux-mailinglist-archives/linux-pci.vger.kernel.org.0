Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226021086DE
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 04:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfKYDpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Nov 2019 22:45:55 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37888 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKYDpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Nov 2019 22:45:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id e2so11527006qkn.5
        for <linux-pci@vger.kernel.org>; Sun, 24 Nov 2019 19:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AF12oMOhXfc9Px1qgEFgcsznioBCGPRgpR5oqy4G2B8=;
        b=ohus8ZaLy91n7yWY7CAuSCod5PdiGyEijWDibZCHmn3LOpJ9bd5ykpBgoHswudwAMV
         gq33eHfeRPzhxptnRGsj4SyLJiGffu62hDBY4OYXyixy+zwjYsIKc1SN6O5oD0EdBPEJ
         c2TnSIJgNWlnoWybsfNWn4AlpT2IH9Sro+CQ7UixGBR0J2oagC9VzBcSHeJVyR/ahXCc
         g/+0vwqi9pfSD3hjT0Qvy99IoVl3OgWZ7sdJ1y69efz1CW8ffWqCoDk/iEOQB14ewR7o
         VxDwWQP0leejBXfuhyOR/jFx28HwlsIuWccknS6alrPj4TWJgnAgIaEBdCl/hNe2tVxs
         kiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AF12oMOhXfc9Px1qgEFgcsznioBCGPRgpR5oqy4G2B8=;
        b=AIOLDkd0hVeWWI2MSwpfJqa413bw6tPvYN7bg+79K0qYvtDZI4lBP37yE0IyBcZtjx
         NDtwPGAMdWuWAC6KBUylDuF43MZW/6kYym3YnwoYFhv8ox3ti+zEUlKedRrlcf1LAG2t
         znE7LTrEOQHSQbvB/Gn7PErQROALcJksM+nXfY95mc2NLQwumrtr/U0q7H3PDcJcgmMY
         r2sIE7N18qrPJBS/KQJ7DHe3I3EhH0blIjPkn4ljU1VRyxfmypWiP8F1+bwU3gexs51C
         7TrBb+FzMjE++aRSBAVRkWuQScSIOXwqBrMq0bf/xgG5TAeoaWy6Vc9xdGMXecuUJ6tK
         4eOg==
X-Gm-Message-State: APjAAAUGytVII9hCfqGYMI9XXkyPnm5+7Ml67RjHxTSRLVWtdk2nphio
        8neZQX49QbM4tSPis9xdxu5PSSeorIFg44His4T5OQ==
X-Google-Smtp-Source: APXvYqw5y5nchP1cUDHKO4br6F+MHXkoNQBfCnCnCKjuQEozW0/9xvEHfwNtOzn9mPXU/ki1lahN3/hMDEkoX868dtM=
X-Received: by 2002:a05:620a:12c3:: with SMTP id e3mr24217720qkl.14.1574653553789;
 Sun, 24 Nov 2019 19:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20191120002836.GA247344@google.com> <20191121181500.GA55996@google.com>
 <CAD8Lp47o6PqKnQYBba0o_8LSGhd3_APhVuXAVsJRT7TedeqXDg@mail.gmail.com> <CAJZ5v0hxa9OGF-w82ZkQ0n_p5VM7uOdKD_UrdGVoz0MAfeqy0w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hxa9OGF-w82ZkQ0n_p5VM7uOdKD_UrdGVoz0MAfeqy0w@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 25 Nov 2019 11:45:42 +0800
Message-ID: <CAD8Lp47kV-C_wf02=s-KKKgB6EVsjNVET9kqYuxfdHFDWbAShw@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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

On Fri, Nov 22, 2019 at 7:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > But then when pci_update_current_state() is called, it reads pmcsr as
> > 3 (D3hot). That's not what I would expect. I guess this means that
> > this platform's _PR3/_PS3 do not actually allow us to put the device
> > into D3cold,
>
> That you can't really say.
>
> Anyway, it is not guaranteed to do that.  For example, the power
> resource(s) listed by _PR3 for the device may be referenced by
> something else too which prevents them from being turned off.
>
> > and/or the _PR0/_PS0 transition does not actually transition the device to D0.
>
> Yes.
>
> Which may be the case if the power resource(s) in _PR3 have not been
> turned off really.
>
> [To debug this a bit more, you can enable dynamic debug in
> drivers/acpi/device_pm.c.]

We checked in an earlier thread before I figured out the timing detail
- these power resources are being turned off at this point.

> > While there is some ACPI strangeness here, the D3hot vs D3cold thing
> > is perhaps not the most relevant point. If I hack the code to avoid
> > D3cold altogether, just trying to do D0->D3hot->D0, it fails in the
> > same way.
>
> OK, but then you don't really flip the power resource(s), so that only
> means that _PS0 does not restore D0, but in general it only is valid
> to execute _PS0 after _PS3 (if both are present which is the case
> here), so this is not conclusive again.

_PS0 is called after _PS3 in the above case.

My feeling is that on this platform, we are not actually entering
D3cold at any point. Linux appears to be powering off the specified
ACPI power domains, but after turning them back on and executing _PS0
to move to D0initialized, the pmcsr still reporting D3 state seems
highly suspicious to me.

Also, I just experimented adding a pmscr register read to the end of
pci_set_power_state() , after pci_platform_power_transition() has been
called. If the power was truly cut and we're in D3cold then I would
expect this to fail. However the register read succeeds and returns
the same value 0x103.

During resume, Linux seems to have accurately detected this failure to
transition to D3cold in pci_update_current_state() by reading pmcsr
and setting dev->current_state to D3hot accordingly. We then deal with
what looks like a D3hot->D0 transition, which suffers the same failure
as seen when I force Linux to avoid D3cold and actually do a "real"
D0->D3hot->D0 cycle.

Presumably on a platform where D3cold actually works, after the device
has then been moved to D0uninitialized via ACPI _PS0 and _PR0,
pci_update_current_state() would then read pmcsr and update
dev->current_state to have value D0?

So in terms of the review comment questioning if the function name
quirk_d3_delay() and accompanying message "extending delay after
power-on from D3 to %d msec\n" is good (or whether it should say D3hot
or D3cold), maybe it should say D3hot. Plus a comment noting that
D3cold doesn't actually seem to be fully cold on this platform, so
we're actually dealing with a D3hot -> D0 transition?

Daniel
