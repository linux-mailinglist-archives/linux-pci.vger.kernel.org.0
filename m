Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539A61E5A7A
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgE1INI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 04:13:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33050 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgE1INH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 04:13:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id z80so2344917qka.0
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2020 01:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cmlNyNcuLeMpnycrjLXMZuM9KXBh5snzZHvcQe+xUE=;
        b=oAyV4r8PHf5uymArx456PZVdxWxHhg6+Y12vpj6NL44YNG27tUCS2ev/n1mEyuY1iK
         4i4pCGSxK+uqAVwTR4VqxU4BCNjPDJhAXXuQy2iDp1vKJhKhzzNvxVDdQZADRf3CECse
         PUp7/CMANHm/4BvFlwOV4Dmhxuy6OfCpwrKS2JQOr5kFQMeSrpqdzfwN4/ik6XSiQ16h
         73iInYjqdWrysBfbu79UNTcMlb/k/Ri1E3z341BNDdhyVoLtYl51Gyj84b6B/BNf6L15
         FU6BJv769C4Xslt7rAThE0qKmfpElb2dVb86MtPx486Lg8xt59zUn+cApZmqpgW5FLzc
         thlw==
X-Gm-Message-State: AOAM532UuFQ2kGgrtOGE7sP5MpsOX7u+izbfE2ekm7/F5948q9Unal2p
        WZdrTaU0GGcx+oh/wlpv2WoMYsO6Ep4=
X-Google-Smtp-Source: ABdhPJw8W63gSgXG498M5ytfGTfldB0b0dIG5nn2ZuAY8gydbJUk9NfyWa39GY1jagdiLs9OtmsEVA==
X-Received: by 2002:a37:4897:: with SMTP id v145mr1635330qka.26.1590653585737;
        Thu, 28 May 2020 01:13:05 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id u7sm4178140qku.119.2020.05.28.01.13.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 01:13:05 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id l3so12524357qvo.7
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2020 01:13:05 -0700 (PDT)
X-Received: by 2002:a0c:efd1:: with SMTP id a17mr1015336qvt.108.1590653584846;
 Thu, 28 May 2020 01:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200524003529.598434ff@f31-4.lan> <20200527213136.GA265655@bjorn-Precision-5520>
 <MN2PR12MB448819B8491290B54E7FABC9F7B10@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448819B8491290B54E7FABC9F7B10@MN2PR12MB4488.namprd12.prod.outlook.com>
From:   Marcos Scriven <marcos@scriven.org>
Date:   Thu, 28 May 2020 09:12:53 +0100
X-Gmail-Original-Message-ID: <CAAri2Dqruwmu19o1V1b_=0-0RR+J_dgmxFi=izLej_m=XQ1VGw@mail.gmail.com>
Message-ID: <CAAri2Dqruwmu19o1V1b_=0-0RR+J_dgmxFi=izLej_m=XQ1VGw@mail.gmail.com>
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

On Wed, 27 May 2020 at 22:42, Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Wednesday, May 27, 2020 5:32 PM
> > To: Kevin Buettner <kevinb@redhat.com>
> > Cc: linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; Alex
> > Williamson <alex.williamson@redhat.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
> >
> > [+cc Alex D, Christian -- do you guys have any contacts or insight into why we
> > suddenly have three new AMD devices that advertise FLR support but it
> > doesn't work?  Are we doing something wrong in Linux, or are these devices
> > defective?
>
> +Nehal who handles our USB drivers.
>
> Nehal any ideas about FLR or whether it should be advertised?
>
> Alex
>

I had read somewhere that the IO die in the Ryzen/Threadripper
packages are identical to the ones used in the motherboard chipsets.

Since the latter do reset ok, it would seem a BIOS update of the AGESA
may potentially fix the issue.

Unfortunately, it's not something motherboard manufacturer's customer
support people know how to deal with or pass back up the chain to AMD
engineers. Actual use of this feature seems to be fairly niche.

After I added the workaround for the USB and audio controllers on the
3rd-gen Ryzen, I tried contacting Kim Phillips (who I found as a
kernel committer to x86/cpu/amd), but haven't heard back.

It would be wonderful to know if this can potentially be fixed in CPU
firmware, and whether there's any likelihood of it actually being
distributed by motherboard manufacturers.

Marcos



> >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fr%2F20200524003529.598434ff%40f31-
> > 4.lan&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Ccb77b56b
> > 62ae47f60f8808d802855759%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> > 7C0%7C637262119015438912&amp;sdata=3z%2Btn%2Bv2pvUl3X0Tzk%2BLoi
> > Mk06dLZCmgUOrsGf3kLpY%3D&amp;reserved=0
> >   AMD Starship USB 3.0 host controller
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fr%2FCAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4z
> > mt1RA%40mail.gmail.com&amp;data=02%7C01%7Calexander.deucher%40a
> > md.com%7Ccb77b56b62ae47f60f8808d802855759%7C3dd8961fe4884e608e11
> > a82d994e183d%7C0%7C0%7C637262119015438912&amp;sdata=69GsHB0HCp
> > 6x0xW0tA%2FrAln0Vy0Yc9I8QSHowebdIxI%3D&amp;reserved=0
> >   AMD Matisse HD Audio & USB 3.0 host controller ]
> >
> > On Sun, May 24, 2020 at 12:35:29AM -0700, Kevin Buettner wrote:
> > > This commit adds an entry to the quirk_no_flr table for the AMD
> > > Starship USB 3.0 host controller.
> > >
> > > Tested on a Micro-Star International Co., Ltd. MS-7C59/Creator TRX40
> > > motherboard with an AMD Ryzen Threadripper 3970X.
> > >
> > > Without this patch, when attempting to assign (pass through) an AMD
> > > Starship USB 3.0 host controller to a guest OS, the system becomes
> > > increasingly unresponsive over the course of several minutes,
> > > eventually requiring a hard reset.
> > >
> > > Shortly after attempting to start the guest, I see these messages:
> > >
> > > May 23 22:59:46 mesquite kernel: vfio-pci 0000:05:00.3: not ready
> > > 1023ms after FLR; waiting May 23 22:59:48 mesquite kernel: vfio-pci
> > > 0000:05:00.3: not ready 2047ms after FLR; waiting May 23 22:59:51
> > > mesquite kernel: vfio-pci 0000:05:00.3: not ready 4095ms after FLR;
> > > waiting May 23 22:59:56 mesquite kernel: vfio-pci 0000:05:00.3: not
> > > ready 8191ms after FLR; waiting
> > >
> > > And then eventually:
> > >
> > > May 23 23:01:00 mesquite kernel: vfio-pci 0000:05:00.3: not ready
> > > 65535ms after FLR; giving up May 23 23:01:05 mesquite kernel: INFO:
> > > NMI handler (perf_event_nmi_handler) took too long to run: 0.000 msecs
> > > May 23 23:01:06 mesquite kernel: perf: interrupt took too long (642744
> > > > 2500), lowering kernel.perf_event_max_sample_rate to 1000 May 23
> > > 23:01:07 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler)
> > > took too long to run: 82.270 msecs May 23 23:01:08 mesquite kernel: INFO:
> > NMI handler (perf_event_nmi_handler) took too long to run: 680.608 msecs
> > May 23 23:01:08 mesquite kernel: INFO: NMI handler
> > (perf_event_nmi_handler) took too long to run: 100.952 msecs ...
> > >  kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
> > > [qemu-system-x86:7487] May 23 23:01:25 mesquite kernel: watchdog:
> > BUG:
> > > soft lockup - CPU#3 stuck for 22s! [qemu-system-x86:7487]
> > >
> > > The above log snippets were obtained using the aforementioned hardware
> > > running Fedora 32 w/ kernel package kernel-5.6.13-300.fc32.x86_64.  My
> > > fix was applied to a local copy of the F32 kernel package, then
> > > rebuilt, etc.
> > >
> > > With this patch in place, the host kernel doesn't exhibit these
> > > problems.  The guest OS (also Fedora 32) starts up and works as
> > > expected with the passed-through USB host controller.
> > >
> > > Signed-off-by: Kevin Buettner <kevinb@redhat.com>
> >
> > Applied to pci/virtualization for v5.8, thanks!
> >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > 43a0c2ce635e..b1db58d00d2b 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5133,6 +5133,7 @@
> > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,
> > quirk_intel_qat_vf_cap);
> > >   * FLR may cause the following to devices to hang:
> > >   *
> > >   * AMD Starship/Matisse HD Audio Controller 0x1487
> > > + * AMD Starship USB 3.0 Host Controller 0x148c
> > >   * AMD Matisse USB 3.0 Host Controller 0x149c
> > >   * Intel 82579LM Gigabit Ethernet Controller 0x1502
> > >   * Intel 82579V Gigabit Ethernet Controller 0x1503 @@ -5143,6 +5144,7
> > > @@ static void quirk_no_flr(struct pci_dev *dev)
> > >     dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;  }
> > > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c,
> > quirk_no_flr);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c,
> > quirk_no_flr);
> > > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502,
> > quirk_no_flr);
> > > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503,
> > quirk_no_flr);
> > >
