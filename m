Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06801DAF0C
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 11:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgETJlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 05:41:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33684 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETJlR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 05:41:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id z80so2940553qka.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 02:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XY8cfRDtjcst/FqKtRLj6GiNnXzamwiRPLbeQkh4rE=;
        b=fDBpE3ddtwMionwu8CAYdtO5kL/HnCdDVSONWEHvrcZSB0emzS2mE49/DprNIHAprA
         5U/TCiM6u7qnR/LVv9/S3kX7G3gD1fSTYeMKVpu9q/ASBMHjhhc5kfEwQjVqXxYNX8GB
         CLSJLZKl+xggrYJoedMDGRiDxq4uy5z/a/wn3WsqEU+0pdG8x9zanaeAJGvh3k6ShSS5
         0n7OXL7Uqqhdld4eAdeBlImP9MeTqeC4/veZgrCQeJ8mTxwvTcmJCjgbKyjFB+/m9yCN
         ai/6s0B15/uei3+KN1+0uVghYW+wmVy4rWBNKqk3RfnuMy/2O5IRYeXBAwaKY8xup18c
         bQ2g==
X-Gm-Message-State: AOAM532bc6EvqMyCkdnbvQ3U4mx0o9oAZgpEHQie6wsesmb+jIYQx5gH
        wsUeLhev639Fo/RTpPkmwf2aGNFGmyo=
X-Google-Smtp-Source: ABdhPJwdae8c7KCPFT3+wAaA86jLvqUcOB5nFpOkBniDiIs7H/MyR1Bo+5NW6cXL/3GaklswYOc+Zg==
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr3685676qkg.314.1589967675218;
        Wed, 20 May 2020 02:41:15 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id v44sm1839400qtk.79.2020.05.20.02.41.14
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 02:41:14 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id t25so2047752qtc.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 02:41:14 -0700 (PDT)
X-Received: by 2002:ac8:44ba:: with SMTP id a26mr4271755qto.323.1589967674428;
 Wed, 20 May 2020 02:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4zmt1RA@mail.gmail.com>
 <20200518161730.GA933080@bjorn-Precision-5520> <CAAri2DrvcnMzaO_cCk53xnzA+_ABbxBk_r3LVBCFSQ+U+eQgEg@mail.gmail.com>
In-Reply-To: <CAAri2DrvcnMzaO_cCk53xnzA+_ABbxBk_r3LVBCFSQ+U+eQgEg@mail.gmail.com>
From:   Marcos Scriven <marcos@scriven.org>
Date:   Wed, 20 May 2020 10:41:03 +0100
X-Gmail-Original-Message-ID: <CAAri2DoF-6A3qcag4etdWh3vQQUGqzfebw6syeU8HFeph5tWQw@mail.gmail.com>
Message-ID: <CAAri2DoF-6A3qcag4etdWh3vQQUGqzfebw6syeU8HFeph5tWQw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Matisse HD Audio and USB Controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 May 2020 at 20:26, Marcos Scriven <marcos@scriven.org> wrote:
>
> On Mon, 18 May 2020 at 17:17, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Alex]
> >
> > On Sat, May 16, 2020 at 02:37:23PM +0100, Marcos Scriven wrote:
> > > This patch fixes an FLR bug on the following two devices:
> > >
> > > AMD Matisse HD Audio Controller 0x1487
> > > AMD Matisse USB 3.0 Host Controller 0x149c
> > >
> > > As there was already such a quirk for an Intel network device, I have
> > > renamed that method and updated the comments, trying to make it
> > > clearer what the specific original devices that were affected are
> > > (based on the commit message this was original done:
> > > https://git.thm.de/mhnn55/eco32-linux-ba/commit/f65fd1aa4f9881d5540192d11f7b8ed2fec936db).
> > >
> > > I have ordered them by hex product ID.
> > >
> > > I have verified this works on a X570 I AORUS PRO WIFI (rev. 1.0) motherboard.
> >
> > If we avoid FLR, is there another method used to reset these devices
> > between attachments to different VMs?  Does the lack of FLR mean we
> > can leak information between VMs?
> >
> > Would additional delay after the FLR work around this, e.g., something
> > like 51ba09452d11 ("PCI: Delay after FLR of Intel DC P3700 NVMe")?
> >
>
> Thanks for looking at this patch Bjorn.
>
> To take your three points:
>
> 1. Certainly I can see those devices able to be passed back and forth
> between host and guest multiple times, once this patch is applied.
>
> 2. I don't know the answer to that question; would appreciate guidance
> on how to determine this. Do you mean perhaps some buffered data in
> the USB controller, for instance?
>
> 3. I have not tried an additional delay. This is the logs I see when
> the error is occurring:
>
> [ 2423.556570] vfio-pci 0000:0c:00.3: not ready 1023ms after FLR; waiting
> [ 2425.604526] vfio-pci 0000:0c:00.3: not ready 2047ms after FLR; waiting
> [ 2428.804509] vfio-pci 0000:0c:00.3: not ready 4095ms after FLR; waiting
> [ 2433.924409] vfio-pci 0000:0c:00.3: not ready 8191ms after FLR; waiting
> [ 2443.140721] vfio-pci 0000:0c:00.3: not ready 16383ms after FLR; waiting
> [ 2461.571944] vfio-pci 0000:0c:00.3: not ready 32767ms after FLR; waiting
> [ 2496.387544] vfio-pci 0000:0c:00.3: not ready 65535ms after FLR; giving up
>
> What makes this bug especially bad is the host never recovers, and
> eventually hangs or crashes.
>
> For reference, the delay example you're talking about is:
>
> static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
> {
> if (!pcie_has_flr(dev))
> return -ENOTTY;
>
> if (probe)
> return 0;
>
> pcie_flr(dev);
>
> msleep(250);
>
> return 0;
> }
>
> I don't know if it would work, but I will try it out and report back.
>
> Marcos
>
>

Bjorn/Alex

I have just tried the alternate approach of adding a 250ms delay to
the function level reset - this unfortunately results in the same
broken behaviour, with the host itself never recovering.

[   76.905410] vfio-pci 0000:0d:00.3: not ready 1023ms after FLR; waiting
[   79.018014] vfio-pci 0000:0d:00.3: not ready 2047ms after FLR; waiting
[   82.089390] vfio-pci 0000:0d:00.3: not ready 4095ms after FLR; waiting
[   87.209416] vfio-pci 0000:0d:00.3: not ready 8191ms after FLR; waiting
[   96.425440] vfio-pci 0000:0d:00.3: not ready 16383ms after FLR; waiting
[  114.615491] vfio-pci 0000:0d:00.3: not ready 32767ms after FLR; waiting
[  149.417712] vfio-pci 0000:0d:00.3: not ready 65535ms after FLR; giving up

I also tried a full second, to no avail.

What would be the next step in proceeding with the original patch please?

How can I allay your concerns on data leaking between VMs?

Thanks for your help with the patch.

Marcos

> > > From 651176ab164ae51e37d5bb86f5948da558744930 Mon Sep 17 00:00:00 2001
> > > From: Marcos Scriven <marcos@scriven.org>
> > > Date: Sat, 16 May 2020 14:23:26 +0100
> > > Subject: [PATCH] PCI: Avoid FLR for:
> > >
> > >     AMD Matisse HD Audio Controller 0x1487
> > >     AMD Matisse USB 3.0 Host Controller 0x149c
> > >
> > > These devices advertise a Function Level Reset (FLR) capability, but hang
> > > when an FLR is triggered.
> > >
> > > To reproduce the problem, attach the device to a VM, then detach and try to
> > > attach again.
> > >
> > > Add a quirk to prevent the use of FLR on these devices.
> > >
> > > Signed-off-by: Marcos Scriven <marcos@scriven.org>
> > > ---
> > >  drivers/pci/quirks.c | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 28c9a2409c50..ff310f0cac22 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5129,13 +5129,23 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
> > >  }
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
> > >
> > > -/* FLR may cause some 82579 devices to hang */
> > > -static void quirk_intel_no_flr(struct pci_dev *dev)
> > > +/*
> > > + * FLR may cause the following to devices to hang:
> > > + *
> > > + * AMD Starship/Matisse HD Audio Controller 0x1487
> > > + * AMD Matisse USB 3.0 Host Controller 0x149c
> > > + * Intel 82579LM Gigabit Ethernet Controller 0x1502
> > > + * Intel 82579V Gigabit Ethernet Controller 0x1503
> > > + *
> > > + */
> > > +static void quirk_no_flr(struct pci_dev *dev)
> > >  {
> > >      dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
> > >  }
> > > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
> > > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> > >
> > >  static void quirk_no_ext_tags(struct pci_dev *pdev)
> > >  {
> > > --
> > > 2.25.1
