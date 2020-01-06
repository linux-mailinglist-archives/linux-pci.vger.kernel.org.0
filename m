Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D591318D6
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAFTim (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:38:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45713 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTim (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 14:38:42 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so49785692ioi.12;
        Mon, 06 Jan 2020 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFL1fKtV0fgN9gDJ7Fm/iZJuC48WZ+DUJ81pq9R4fTw=;
        b=mONhGolss5xAIaSVNmY/VtF7D5t3S8CORW4oqNNOlfYgn5MTeWxb+LZk7OUDOsnZCM
         h1xxXcCHkBF33srP3ImNfNtizd73nSUUSVdWHlm8Xbp1+E6wNk3RtbzX89FCZS7quirv
         sJZOopIfH8wgaD9E/NOcbE506NbI2a8ahXftWesxADkmZafB14mueoO3dCrk2RH9BUhd
         0zByWiECq/Bm2Z4ApHV8SqQgJTpAkMCV6hEpE+NdO4ofoUkX3LFlUXiA6+cAGYKl4pJV
         +sURO4IlbLX1IOlGBz9sfzLm3MexQqtG82tuNUaTELBjnEK1RS/oLvclJNuxULf2u7wC
         me/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFL1fKtV0fgN9gDJ7Fm/iZJuC48WZ+DUJ81pq9R4fTw=;
        b=mO6l24VfgRVGjlsKEUbhjnemRmrAsUD1edUfucJ0lyxHSjIwHtbEcecmS/94HF9ml8
         kWY14wKUwBx/l/V9pklXYjxAuoMeYLBYOCw84A/pxLvz2jHEkRZt4pWfRvUjPtsVTdzN
         qcBtHe6FzunJ5ZSLfWh4ksf5VSnbUbwpf3IpE7NC/yMRTS3aKSk3xggP1tZgHWIrtfzj
         vepY2fePBlz7o8pJ/tZyLsJ64bOTCH4eE7ixvu1Jw+KKzn1xKp/FYqJc6GIpJtXn0pt9
         VNIhdpy3xeEHJp8+kqWktKomSgIWHyapzEpSUr4/tqUeGAnIido6D8CpcaVMNrog03ui
         oX9w==
X-Gm-Message-State: APjAAAXJfNte1RJB7+xaehhgrcxH6nWus4oiHGbJsaHDNnLI9g1pPxB2
        WQQ2wbFVr43prs+fOPyXQsxQkAdP1LGvPoqJGOAsSA==
X-Google-Smtp-Source: APXvYqxg3XNAVjsAlMB/h9I0hNtVDxbwwdFx6/0b6++YshopUpBVSxbIjnMZ6rec/szJ31LLeytI64XVk6J1N/pzpDM=
X-Received: by 2002:a05:6638:76f:: with SMTP id y15mr81509841jad.5.1578339521244;
 Mon, 06 Jan 2020 11:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20200104225052.27275-1-deepa.kernel@gmail.com> <20200106135455.GA104407@google.com>
In-Reply-To: <20200106135455.GA104407@google.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 6 Jan 2020 11:38:29 -0800
Message-ID: <CABeXuvownNp7ngp38vHzCgQfLA-tnH7FFT5pQQeHF3tLizmxcg@mail.gmail.com>
Subject: Re: [PATCH] pci: Warn if BME cannot be turned off during kexec
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mika.westerberg@linux.intel.com, alex.williamson@redhat.com,
        logang@deltatee.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 6, 2020 at 5:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Deepa,
>
> Thanks for the patches.  Since these two patches touch the same piece
> of code in pci_device_shutdown(), they conflict with each other.  I
> could resolve this myself, but maybe you could make them a series that
> applies cleanly together?

Sure, will make this a series.

> Can you also please edit the subject lines so they match the
> convention (use "git log --oneline drivers/pci/pci-driver.c" to see
> it).

Will do.

> On Sat, Jan 04, 2020 at 02:50:52PM -0800, Deepa Dinamani wrote:
> > BME not being off is a security risk, so for whatever
> > reason if we cannot disable it, print a warning.
>
> "BME" is not a common term in drivers/pci; can you use "Bus Master
> Enable" (to match the PCIe spec) or "PCI_COMMAND_MASTER" (to match the
> Linux code)?

Will do.

> Can you also explain why this is a security risk?  It looks like we
> disable bus mastering if the device is in D0-D3hot.  If the device is
> in D3cold, it's powered off, so we can't read/write config space.  But
> if it's in D3cold, the device is powered off, so it can't be a bus
> master either, so why would we warn about it?

I was mainly concerned about the PCI_UNKNOWN state here. Maybe we can
add a specific check for the unknown state if that is preferable.

> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > ---
> >  drivers/pci/pci-driver.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 0454ca0e4e3f..6c866a81f46c 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -491,8 +491,12 @@ static void pci_device_shutdown(struct device *dev)
> >        * If it is not a kexec reboot, firmware will hit the PCI
> >        * devices with big hammer and stop their DMA any way.
> >        */
> > -     if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> > -             pci_clear_master(pci_dev);
> > +     if (kexec_in_progress) {
> > +             if (likely(pci_dev->current_state <= PCI_D3hot))
>
> No need to use "likely" here unless you can measure a difference.  I
> doubt this is a performance path.
>
> > +                     pci_clear_master(pci_dev);
> > +             else
> > +                     dev_warn(dev, "Unable to turn off BME during kexec");
>
> How often and for what sort of devices would you expect this warning
> to be emitted?  If this is a common situation and the user can't do
> anything about it, the warnings will clutter the logs and train users
> to ignore them.

This is not a common situation. I think I have seen this only a couple
of times in my kexec experiments. I have not found any documentation
about if a device can go into an unknown power state and still be
harmful or not. But, if you need more testing, I could check the patch
into the Google datacenter code and sweep the logs to see if these get
printed at all.

-Deepa
