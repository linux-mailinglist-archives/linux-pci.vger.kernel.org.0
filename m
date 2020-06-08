Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CBE1F1E77
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 19:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgFHRrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 13:47:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46653 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgFHRre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2020 13:47:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id g18so15343910qtu.13
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2020 10:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgbubwHWZd8K/46uInXGlgN692oJ5eIRW0kcFODJ03M=;
        b=KxZPpmMZrxV4OV9Jl+IstagkxlXCFHJlc4700LL4+jcSn7oc+tEKOnRL1skuAuGMCE
         tAexPMCnWZn4XkD+v8z9SfWzxXo5tp3ccbezxuuIGsF+UvXZgoSSsKUrOzqi2YL68c8m
         qfTFigCJLzMe4hoOlVqBlKFDk/KuqFPmb8U/mnlDGdmN2wdkSGMwN5L98aOl1bwN+0EO
         8ARQzhRiTEbzGph8TqYs0cCEtWTOIBFa565TgEG/W+5FhroTs0py7+ba5aOy9a8bnkJC
         uapcy+wKCEkopGtzyagvmOPC38Q3nVfZrOMqeFNUwfvUSyuA5Q7Fp/zuk9LnCzD74Hhd
         Uc5w==
X-Gm-Message-State: AOAM5324DnK1gIuEsgH0aGJgfK/El5DlvHVtIRTSkIntuvFKrtHd0uG5
        1iDc3qGjd1aqmYk5fFTu3UYJzesDxck=
X-Google-Smtp-Source: ABdhPJyspAwTR0pZoSTAcKmCx0oJQOVzHmsGQsDeZRMQU3vLnILV70p1ouZEkbx8mtuUwU45ggGRdg==
X-Received: by 2002:ac8:fa7:: with SMTP id b36mr25145853qtk.100.1591638452423;
        Mon, 08 Jun 2020 10:47:32 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id 63sm7553344qkm.82.2020.06.08.10.47.30
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 10:47:30 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id q14so15371268qtr.9
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2020 10:47:30 -0700 (PDT)
X-Received: by 2002:ac8:1844:: with SMTP id n4mr23891947qtk.142.1591638449851;
 Mon, 08 Jun 2020 10:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200524003529.598434ff@f31-4.lan> <20200527213136.GA265655@bjorn-Precision-5520>
 <MN2PR12MB448819B8491290B54E7FABC9F7B10@MN2PR12MB4488.namprd12.prod.outlook.com>
 <CAAri2Dqruwmu19o1V1b_=0-0RR+J_dgmxFi=izLej_m=XQ1VGw@mail.gmail.com>
In-Reply-To: <CAAri2Dqruwmu19o1V1b_=0-0RR+J_dgmxFi=izLej_m=XQ1VGw@mail.gmail.com>
From:   Marcos Scriven <marcos@scriven.org>
Date:   Mon, 8 Jun 2020 18:47:18 +0100
X-Gmail-Original-Message-ID: <CAAri2Dqm6vGySEFjUYKcED5fJcN2Gr38Cj-02ab5ONuz6r88jw@mail.gmail.com>
Message-ID: <CAAri2Dqm6vGySEFjUYKcED5fJcN2Gr38Cj-02ab5ONuz6r88jw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kevin Buettner <kevinb@redhat.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 May 2020 at 09:12, Marcos Scriven <marcos@scriven.org> wrote:
>
> On Wed, 27 May 2020 at 22:42, Deucher, Alexander
> <Alexander.Deucher@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Wednesday, May 27, 2020 5:32 PM
> > > To: Kevin Buettner <kevinb@redhat.com>
> > > Cc: linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; Alex
> > > Williamson <alex.williamson@redhat.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>
> > > Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
> > >
> > > [+cc Alex D, Christian -- do you guys have any contacts or insight into why we
> > > suddenly have three new AMD devices that advertise FLR support but it
> > > doesn't work?  Are we doing something wrong in Linux, or are these devices
> > > defective?
> >
> > +Nehal who handles our USB drivers.
> >
> > Nehal any ideas about FLR or whether it should be advertised?
> >
> > Alex
> >
>
> I had read somewhere that the IO die in the Ryzen/Threadripper
> packages are identical to the ones used in the motherboard chipsets.
>
> Since the latter do reset ok, it would seem a BIOS update of the AGESA
> may potentially fix the issue.
>
> Unfortunately, it's not something motherboard manufacturer's customer
> support people know how to deal with or pass back up the chain to AMD
> engineers. Actual use of this feature seems to be fairly niche.
>
> After I added the workaround for the USB and audio controllers on the
> 3rd-gen Ryzen, I tried contacting Kim Phillips (who I found as a
> kernel committer to x86/cpu/amd), but haven't heard back.
>
> It would be wonderful to know if this can potentially be fixed in CPU
> firmware, and whether there's any likelihood of it actually being
> distributed by motherboard manufacturers.
>
> Marcos
>
>
>

Dear Alex/Nehal

I wonder if you're able to comment please on whether FLR should be advertised?

Is there any chance this could be fixed at the bios/AGESA level, and
effectively rolled out?

Thanks

Marcos

> > >
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > > kernel.org%2Fr%2F20200524003529.598434ff%40f31-
> > > 4.lan&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Ccb77b56b
> > > 62ae47f60f8808d802855759%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> > > 7C0%7C637262119015438912&amp;sdata=3z%2Btn%2Bv2pvUl3X0Tzk%2BLoi
> > > Mk06dLZCmgUOrsGf3kLpY%3D&amp;reserved=0
> > >   AMD Starship USB 3.0 host controller
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > > kernel.org%2Fr%2FCAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4z
> > > mt1RA%40mail.gmail.com&amp;data=02%7C01%7Calexander.deucher%40a
> > > md.com%7Ccb77b56b62ae47f60f8808d802855759%7C3dd8961fe4884e608e11
> > > a82d994e183d%7C0%7C0%7C637262119015438912&amp;sdata=69GsHB0HCp
> > > 6x0xW0tA%2FrAln0Vy0Yc9I8QSHowebdIxI%3D&amp;reserved=0
> > >   AMD Matisse HD Audio & USB 3.0 host controller ]
> > >
> > > On Sun, May 24, 2020 at 12:35:29AM -0700, Kevin Buettner wrote:
> > > > This commit adds an entry to the quirk_no_flr table for the AMD
> > > > Starship USB 3.0 host controller.
> > > >
> > > > Tested on a Micro-Star International Co., Ltd. MS-7C59/Creator TRX40
> > > > motherboard with an AMD Ryzen Threadripper 3970X.
> > > >
> > > > Without this patch, when attempting to assign (pass through) an AMD
> > > > Starship USB 3.0 host controller to a guest OS, the system becomes
> > > > increasingly unresponsive over the course of several minutes,
> > > > eventually requiring a hard reset.
> > > >
> > > > Shortly after attempting to start the guest, I see these messages:
> > > >
> > > > May 23 22:59:46 mesquite kernel: vfio-pci 0000:05:00.3: not ready
> > > > 1023ms after FLR; waiting May 23 22:59:48 mesquite kernel: vfio-pci
> > > > 0000:05:00.3: not ready 2047ms after FLR; waiting May 23 22:59:51
> > > > mesquite kernel: vfio-pci 0000:05:00.3: not ready 4095ms after FLR;
> > > > waiting May 23 22:59:56 mesquite kernel: vfio-pci 0000:05:00.3: not
> > > > ready 8191ms after FLR; waiting
> > > >
> > > > And then eventually:
> > > >
> > > > May 23 23:01:00 mesquite kernel: vfio-pci 0000:05:00.3: not ready
> > > > 65535ms after FLR; giving up May 23 23:01:05 mesquite kernel: INFO:
> > > > NMI handler (perf_event_nmi_handler) took too long to run: 0.000 msecs
> > > > May 23 23:01:06 mesquite kernel: perf: interrupt took too long (642744
> > > > > 2500), lowering kernel.perf_event_max_sample_rate to 1000 May 23
> > > > 23:01:07 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler)
> > > > took too long to run: 82.270 msecs May 23 23:01:08 mesquite kernel: INFO:
> > > NMI handler (perf_event_nmi_handler) took too long to run: 680.608 msecs
> > > May 23 23:01:08 mesquite kernel: INFO: NMI handler
> > > (perf_event_nmi_handler) took too long to run: 100.952 msecs ...
> > > >  kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
> > > > [qemu-system-x86:7487] May 23 23:01:25 mesquite kernel: watchdog:
> > > BUG:
> > > > soft lockup - CPU#3 stuck for 22s! [qemu-system-x86:7487]
> > > >
> > > > The above log snippets were obtained using the aforementioned hardware
> > > > running Fedora 32 w/ kernel package kernel-5.6.13-300.fc32.x86_64.  My
> > > > fix was applied to a local copy of the F32 kernel package, then
> > > > rebuilt, etc.
> > > >
> > > > With this patch in place, the host kernel doesn't exhibit these
> > > > problems.  The guest OS (also Fedora 32) starts up and works as
> > > > expected with the passed-through USB host controller.
> > > >
> > > > Signed-off-by: Kevin Buettner <kevinb@redhat.com>
> > >
> > > Applied to pci/virtualization for v5.8, thanks!
> > >
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > > 43a0c2ce635e..b1db58d00d2b 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -5133,6 +5133,7 @@
> > > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,
> > > quirk_intel_qat_vf_cap);
> > > >   * FLR may cause the following to devices to hang:
> > > >   *
> > > >   * AMD Starship/Matisse HD Audio Controller 0x1487
> > > > + * AMD Starship USB 3.0 Host Controller 0x148c
> > > >   * AMD Matisse USB 3.0 Host Controller 0x149c
> > > >   * Intel 82579LM Gigabit Ethernet Controller 0x1502
> > > >   * Intel 82579V Gigabit Ethernet Controller 0x1503 @@ -5143,6 +5144,7
> > > > @@ static void quirk_no_flr(struct pci_dev *dev)
> > > >     dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;  }
> > > > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> > > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c,
> > > quirk_no_flr);
> > > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c,
> > > quirk_no_flr);
> > > > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502,
> > > quirk_no_flr);
> > > > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503,
> > > quirk_no_flr);
> > > >
