Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B224106F79
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfKVLPp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 06:15:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45382 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKVLPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 06:15:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id r24so5801118otk.12;
        Fri, 22 Nov 2019 03:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNKtVKyyjIN7C8LjAkItasX2zQVTgor2/9I8mXAyorg=;
        b=fCZm79oJVZkKo5JwWGeYhhF8pGwccbVhp5WC/Byqz+WEsWkxGMunQ7A5X4/A1Q3Pdd
         T+n5qEDRoeKXpwAp/dgCRhsvzXuMA9GSRMSv5CLEYOgkQy2F1glD9oW9V/ngiDMRY4/d
         PcgF5ssHOUGN2+cDPBg139T5AlRqLk65iUME/FwNNKLNCKlIn6MPo7410/bTl6z1oVBr
         tpBTCMimRzVbuLGw7DGMuqI0K0v9b+R4wf1QplrH9QykFBja4GV/7bkd4GTPFPBVnQ9j
         QFO12fDViDEot4PkdXi4zQGqbHXbVI+nG/08egbOiPlnxCVc3NiNb4pJkDvh6IcsKWdt
         2PdQ==
X-Gm-Message-State: APjAAAW0L4zA4Y5cSnxefVhevisnUs8O5rV3sW9eAPUiZZ6D5AgRXrsh
        xNsVrtzGfuPSLqafSXIYEu3fI7hBtoQ+BNXMf/U=
X-Google-Smtp-Source: APXvYqw6rx/VUVi1y7XpMTeo1Luu8jyyvaYJR9fSFz7IDXuJ6jQyoL6CF4Qr1VL30IGVHRJWFqxlQHiVA51h8tuH9ZI=
X-Received: by 2002:a9d:6b91:: with SMTP id b17mr10084485otq.189.1574421343635;
 Fri, 22 Nov 2019 03:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20191120002836.GA247344@google.com> <20191121181500.GA55996@google.com>
 <CAD8Lp47o6PqKnQYBba0o_8LSGhd3_APhVuXAVsJRT7TedeqXDg@mail.gmail.com>
In-Reply-To: <CAD8Lp47o6PqKnQYBba0o_8LSGhd3_APhVuXAVsJRT7TedeqXDg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 12:15:32 +0100
Message-ID: <CAJZ5v0hxa9OGF-w82ZkQ0n_p5VM7uOdKD_UrdGVoz0MAfeqy0w@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Daniel Drake <drake@endlessm.com>
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

On Fri, Nov 22, 2019 at 4:00 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Fri, Nov 22, 2019 at 2:15 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > I definitely was not understanding this correctly.  There is no path
> > for a D3cold -> D3hot transition.  Per spec (PCIe r5.0, sec 5.8), the
> > only legal exit from D3cold is to D0uninitialized.
>
> I'm also learning these details as we go.
>
> During runtime suspend, the ACPI _PS3 method (which does exist on this
> device) is called, then _PR3 resources are turned off, which (I think)
> means that the state should now be D3cold.

Correct.

> During runtime resume, the ACPI _PR0 resources are turned on, then
> ACPI _PS0 method is called (and does exist on this device), and my
> reading is that this should put the device in D0.

That should be something like D0uninitialized.

> But then when pci_update_current_state() is called, it reads pmcsr as
> 3 (D3hot). That's not what I would expect. I guess this means that
> this platform's _PR3/_PS3 do not actually allow us to put the device
> into D3cold,

That you can't really say.

Anyway, it is not guaranteed to do that.  For example, the power
resource(s) listed by _PR3 for the device may be referenced by
something else too which prevents them from being turned off.

> and/or the _PR0/_PS0 transition does not actually transition the device to D0.

Yes.

Which may be the case if the power resource(s) in _PR3 have not been
turned off really.

[To debug this a bit more, you can enable dynamic debug in
drivers/acpi/device_pm.c.]

> While there is some ACPI strangeness here, the D3hot vs D3cold thing
> is perhaps not the most relevant point. If I hack the code to avoid
> D3cold altogether, just trying to do D0->D3hot->D0, it fails in the
> same way.

OK, but then you don't really flip the power resource(s), so that only
means that _PS0 does not restore D0, but in general it only is valid
to execute _PS0 after _PS3 (if both are present which is the case
here), so this is not conclusive again.

> > I know you tried a debug patch to call pci_dev_wait(), and it didn't
> > work, but I'm not sure exactly where it was called.  I have these
> > patches on my pci/pm branch for v5.5:
> >
> >   bae26849372b ("PCI/PM: Move pci_dev_wait() definition earlier")
> >   395f121e6199 ("PCI/PM: Wait for device to become ready after power-on")
> >
> > The latter adds the wait just before we call
> > pci_raw_set_power_state().  If the device is responding with CRS
> > status, that should be the point where we'd see it.  If you have a
> > chance to try it, I'd be interested in the results.
>
> pci_dev_wait() doesn't have any effect no matter where you put it
> because we have yet to observe this device presenting a CRS-like
> condition. According to our earlier experiments, PCI_VENDOR_ID and
> PCI_COMMAND never return the ~0 value that would be needed for
> pci_dev_wait() to have any effect.
>
> I tried the branch anyway and it doesn't solve the issue.
>
> I haven't finished gathering all the logs you asked for, but I tried
> to summarize my current understanding at
> https://bugzilla.kernel.org/show_bug.cgi?id=205587 - hopefully that
> helps.

OK, thanks for that!
