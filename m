Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA481D8833
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 21:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgERT0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 15:26:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42694 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgERT0f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2020 15:26:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so9103110qts.9
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2020 12:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxhAgJKcmMGf/dYe9BKv+LN/NGheOLTAGsSwuZ+XdTU=;
        b=TgQ9uugY19j83oLX5TifjtH0qBqNVenoiCx4lbxadh2zZW82yOymAWtt+SbMPHzGLn
         0ZKyVvzNvBDmC3LQ63IGyq37v+bdkgyku81/Pk4PulWld/PR+gSb/9rFUlBXDWr67765
         6HTBFvDa7NyRjFTMlXFayK9MCRgZ0idc1yHJdUrpgPx3tJ4I24T8+vU+TbIziJEbe7B4
         e8ACGihPydivdTXh5rougjXG2fhAaOr2x8AQUYkx5ehwFH4q+PjqlpLa738iNpNkQZ58
         NAr/onqof5QI5JL69uw8jk6iWHy3AuwafsFlRgS+gdZrLRrJuhyJPAKpIhnyZL1ZYmde
         6HQw==
X-Gm-Message-State: AOAM532BGZpBVp0b5eYTcSYvaKoKTo2nhEx0qvwCS9FCdGpYlHfJp7JP
        DlPnn2x8MBP2Q8v3ahOt4VIwfhtriS4=
X-Google-Smtp-Source: ABdhPJxo5tGaVYmxv9HJLlCCETck4jLakxYxjbFNf/6SzxJktFOI3LbO8lwpBu1r/D3AXIug+nwXEA==
X-Received: by 2002:ac8:6edc:: with SMTP id f28mr18214676qtv.222.1589829993599;
        Mon, 18 May 2020 12:26:33 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id g144sm8950513qke.18.2020.05.18.12.26.32
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 12:26:33 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id m44so9102996qtm.8
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2020 12:26:32 -0700 (PDT)
X-Received: by 2002:ac8:4650:: with SMTP id f16mr18149870qto.168.1589829992522;
 Mon, 18 May 2020 12:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4zmt1RA@mail.gmail.com>
 <20200518161730.GA933080@bjorn-Precision-5520>
In-Reply-To: <20200518161730.GA933080@bjorn-Precision-5520>
From:   Marcos Scriven <marcos@scriven.org>
Date:   Mon, 18 May 2020 20:26:21 +0100
X-Gmail-Original-Message-ID: <CAAri2DrvcnMzaO_cCk53xnzA+_ABbxBk_r3LVBCFSQ+U+eQgEg@mail.gmail.com>
Message-ID: <CAAri2DrvcnMzaO_cCk53xnzA+_ABbxBk_r3LVBCFSQ+U+eQgEg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Matisse HD Audio and USB Controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 May 2020 at 17:17, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Alex]
>
> On Sat, May 16, 2020 at 02:37:23PM +0100, Marcos Scriven wrote:
> > This patch fixes an FLR bug on the following two devices:
> >
> > AMD Matisse HD Audio Controller 0x1487
> > AMD Matisse USB 3.0 Host Controller 0x149c
> >
> > As there was already such a quirk for an Intel network device, I have
> > renamed that method and updated the comments, trying to make it
> > clearer what the specific original devices that were affected are
> > (based on the commit message this was original done:
> > https://git.thm.de/mhnn55/eco32-linux-ba/commit/f65fd1aa4f9881d5540192d11f7b8ed2fec936db).
> >
> > I have ordered them by hex product ID.
> >
> > I have verified this works on a X570 I AORUS PRO WIFI (rev. 1.0) motherboard.
>
> If we avoid FLR, is there another method used to reset these devices
> between attachments to different VMs?  Does the lack of FLR mean we
> can leak information between VMs?
>
> Would additional delay after the FLR work around this, e.g., something
> like 51ba09452d11 ("PCI: Delay after FLR of Intel DC P3700 NVMe")?
>

Thanks for looking at this patch Bjorn.

To take your three points:

1. Certainly I can see those devices able to be passed back and forth
between host and guest multiple times, once this patch is applied.

2. I don't know the answer to that question; would appreciate guidance
on how to determine this. Do you mean perhaps some buffered data in
the USB controller, for instance?

3. I have not tried an additional delay. This is the logs I see when
the error is occurring:

[ 2423.556570] vfio-pci 0000:0c:00.3: not ready 1023ms after FLR; waiting
[ 2425.604526] vfio-pci 0000:0c:00.3: not ready 2047ms after FLR; waiting
[ 2428.804509] vfio-pci 0000:0c:00.3: not ready 4095ms after FLR; waiting
[ 2433.924409] vfio-pci 0000:0c:00.3: not ready 8191ms after FLR; waiting
[ 2443.140721] vfio-pci 0000:0c:00.3: not ready 16383ms after FLR; waiting
[ 2461.571944] vfio-pci 0000:0c:00.3: not ready 32767ms after FLR; waiting
[ 2496.387544] vfio-pci 0000:0c:00.3: not ready 65535ms after FLR; giving up

What makes this bug especially bad is the host never recovers, and
eventually hangs or crashes.

For reference, the delay example you're talking about is:

static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
{
if (!pcie_has_flr(dev))
return -ENOTTY;

if (probe)
return 0;

pcie_flr(dev);

msleep(250);

return 0;
}

I don't know if it would work, but I will try it out and report back.

Marcos


> > From 651176ab164ae51e37d5bb86f5948da558744930 Mon Sep 17 00:00:00 2001
> > From: Marcos Scriven <marcos@scriven.org>
> > Date: Sat, 16 May 2020 14:23:26 +0100
> > Subject: [PATCH] PCI: Avoid FLR for:
> >
> >     AMD Matisse HD Audio Controller 0x1487
> >     AMD Matisse USB 3.0 Host Controller 0x149c
> >
> > These devices advertise a Function Level Reset (FLR) capability, but hang
> > when an FLR is triggered.
> >
> > To reproduce the problem, attach the device to a VM, then detach and try to
> > attach again.
> >
> > Add a quirk to prevent the use of FLR on these devices.
> >
> > Signed-off-by: Marcos Scriven <marcos@scriven.org>
> > ---
> >  drivers/pci/quirks.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 28c9a2409c50..ff310f0cac22 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5129,13 +5129,23 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
> >  }
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
> >
> > -/* FLR may cause some 82579 devices to hang */
> > -static void quirk_intel_no_flr(struct pci_dev *dev)
> > +/*
> > + * FLR may cause the following to devices to hang:
> > + *
> > + * AMD Starship/Matisse HD Audio Controller 0x1487
> > + * AMD Matisse USB 3.0 Host Controller 0x149c
> > + * Intel 82579LM Gigabit Ethernet Controller 0x1502
> > + * Intel 82579V Gigabit Ethernet Controller 0x1503
> > + *
> > + */
> > +static void quirk_no_flr(struct pci_dev *dev)
> >  {
> >      dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
> >  }
> > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
> > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> >
> >  static void quirk_no_ext_tags(struct pci_dev *pdev)
> >  {
> > --
> > 2.25.1
