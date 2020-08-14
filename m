Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7D724469F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 10:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgHNIxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 04:53:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41700 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHNIxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2020 04:53:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id v22so6424058qtq.8
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2020 01:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxxLsPZozTLX3ObZXi0EdS+EhzoX/NcH97R45uZV6+0=;
        b=W/L+wYfbRjxgK0NdR3uNDO7Vx/oR/l1IVo/dXrMvbbCf5RxI61Dtq4+Vu2XYiuRi++
         x3fdH6vJks7XbPZSMRtJs+1CcEo9WTW00ig1D2CdiVtWfKWYTJUo3xfd5V+CFICtpA69
         yq1914bvWZy9pOK1ySomOQM6VlD1i2O7kEeYPIQQUJpcdTGD4tISylYix3SDA0mgGv+G
         P53aRIefoBx6m1IaOq7Cd2BKRERZDOjmJHfQ80FtbKy22ApczzfHaFhNMFaJdi2iUdm0
         0nyPLNm+ykxjOQNBKIpYkz6TmWDyPHmlfCf2JhuynGRfq5DijOrr+mc70yf+ptz/GZds
         lBbg==
X-Gm-Message-State: AOAM531g64lx+thgvOpOo6cWx9mOqGKn0ky0gq9xIEHkJaIKqFjjPaFE
        oVr47/5MhcOAkAmcRR7lliBTjxmQttd8PQ==
X-Google-Smtp-Source: ABdhPJyL2QbMhbJ3t7cmmxB/u+IkiJ6tDrEgzuzq4TFYfIy/JHMfbUGOXUmdtYcmfk3866Z2uVew1A==
X-Received: by 2002:ac8:7341:: with SMTP id q1mr1080475qtp.8.1597395187452;
        Fri, 14 Aug 2020 01:53:07 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id z24sm7642246qki.57.2020.08.14.01.53.06
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 01:53:07 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id d14so7692034qke.13
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2020 01:53:06 -0700 (PDT)
X-Received: by 2002:a05:620a:5f8:: with SMTP id z24mr1106540qkg.372.1597395186493;
 Fri, 14 Aug 2020 01:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAAri2DpQnrGH5bnjC==W+HmnD4XMh8gcp9u-_LQ=K-jtrdHwAg@mail.gmail.com>
 <20200713221451.GA285058@bjorn-Precision-5520> <MN2PR12MB448830959FDA665230B94FCBF7600@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448830959FDA665230B94FCBF7600@MN2PR12MB4488.namprd12.prod.outlook.com>
From:   Marcos Scriven <marcos@scriven.org>
Date:   Fri, 14 Aug 2020 09:52:55 +0100
X-Gmail-Original-Message-ID: <CAAri2Dq2L0MOPeocRE5fF7qzgGbCCi_gYS+CU7mU=EqVe0Y3iw@mail.gmail.com>
Message-ID: <CAAri2Dq2L0MOPeocRE5fF7qzgGbCCi_gYS+CU7mU=EqVe0Y3iw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Kevin Buettner <kevinb@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 13 Jul 2020 at 23:48, Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [AMD Public Use]
>
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Monday, July 13, 2020 6:15 PM
> > To: Marcos Scriven <marcos@scriven.org>
> > Cc: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Kevin Buettner
> > <kevinb@redhat.com>; linux-pci@vger.kernel.org; Bjorn Helgaas
> > <bhelgaas@google.com>; Alex Williamson <alex.williamson@redhat.com>;
> > Koenig, Christian <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
> >
> > On Mon, Jul 13, 2020 at 01:44:44PM +0100, Marcos Scriven wrote:
> > > On Thu, 25 Jun 2020 at 11:22, Marcos Scriven <marcos@scriven.org> wrote:
> > > > On Tue, 9 Jun 2020 at 12:47, Shah, Nehal-bakulchandra
> > > > <nehal-bakulchandra.shah@amd.com> wrote:
> > > > > On 6/8/2020 11:17 PM, Marcos Scriven wrote:
> > > > > > On Thu, 28 May 2020 at 09:12, Marcos Scriven
> > > > > > <marcos@scriven.org>
> > > > wrote:
> > > > > >> On Wed, 27 May 2020 at 22:42, Deucher, Alexander
> > > > > >> <Alexander.Deucher@amd.com> wrote:
> > > > > >>>> -----Original Message-----
> > > > > >>>> From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > >>>>
> > > > > >>>> [+cc Alex D, Christian -- do you guys have any contacts or
> > > > > >>>> insight
> > > > into why we
> > > > > >>>> suddenly have three new AMD devices that advertise FLR
> > > > > >>>> support but
> > > > it
> > > > > >>>> doesn't work?  Are we doing something wrong in Linux, or are
> > > > > >>>> these
> > > > devices
> > > > > >>>> defective?
> > > > > >>> +Nehal who handles our USB drivers.
> > > > > >>>
> > > > > >>> Nehal any ideas about FLR or whether it should be advertised?
> > > > > >>>
> > > > > Sorry for the delay. We are looking into this with BIOS team. I
> > > > > shall
> > > > revert soon on this.
> > > >
> > > > Sorry to keep pestering about this, but wondering if there's any
> > > > movement on this?
> > > >
> > > > Is it something that's likely to be fixed and actually rolled out by
> > > > motherboard manufacturers?
> > > >
> > > > There's been some grumblings in the community about adding
> > > > workarounds rather than fixing, so it would be good to pass on
> > expectations here.
> > >
> > > Any word on this please? Would be keen to know if the BIOS can be
> > > fixed, and this workaround can eventually be dropped.
> >
> > Just to clarify what the possible outcomes are:
> >
> >   1) If these AMD devices are defective, but future ones are fixed, we
> >   keep the quirk.
> >
> >   2) If these AMD devices are defective *and* future ones are also
> >   defective, we keep the quirk and keep adding device IDs to it.
> >
> >   3) If the BIOS is defective, we keep the quirk.  If anybody cares
> >   about FLR enough, they can make the quirk smart enough to identify
> >   fixed BIOS versions and enable FLR.
> >
> >   4) If Linux is defective, we can fix Linux and drop the quirk.
> >
> > The ideal outcome would be 4), but we don't have any indication that Linux is
> > doing something wrong.
> >
> > What we're really trying to avoid is 2) because that means new devices will
> > break Linux until somebody figures out the problem again, updates the quirk,
> > and gets the update into distro kernels.
> >
> > In case 3), we don't drop the quirk because that forces people to upgrade
> > their BIOS, and most people will not.  We can't drop the quirk, reintroduce
> > the problem on old BIOSes, and hide behind the excuse of "you need to
> > upgrade the BIOS."  That wastes the user's time and our time.
> >
>
> Understood.  Just trying to find the right people internally to understand what has been validated and productized with respect to FLR on various peripherals.
>
> Alex
>

Hi Alex

Sorry to keep bugging - wondering if you'd had any success finding the
people internally to look at this?

My main personal concern is that I faced some criticism from users in
submitting the quirk, as people felt that took the pressure off AMD to
fix.

Thanks

Marcos

> > > > > >>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > >>>>> index 43a0c2ce635e..b1db58d00d2b 100644
> > > > > >>>>> --- a/drivers/pci/quirks.c
> > > > > >>>>> +++ b/drivers/pci/quirks.c
> > > > > >>>>> @@ -5133,6 +5133,7 @@
> > > > > >>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,
> > > > > >>>> quirk_intel_qat_vf_cap);
> > > > > >>>>>   * FLR may cause the following to devices to hang:
> > > > > >>>>>   *
> > > > > >>>>>   * AMD Starship/Matisse HD Audio Controller 0x1487
> > > > > >>>>> + * AMD Starship USB 3.0 Host Controller 0x148c
> > > > > >>>>>   * AMD Matisse USB 3.0 Host Controller 0x149c
> > > > > >>>>>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
> > > > > >>>>>   * Intel 82579V Gigabit Ethernet Controller 0x1503 @@
> > > > > >>>>> -5143,6
> > > > +5144,7
> > > > > >>>>> @@ static void quirk_no_flr(struct pci_dev *dev)
> > > > > >>>>>     dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;  }
> > > > > >>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487,
> > > > > >>>>> quirk_no_flr);
> > > > > >>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c,
> > > > > >>>> quirk_no_flr);
> > > > > >>>>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c,
> > > > > >>>> quirk_no_flr);
> > > > > >>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502,
> > > > > >>>> quirk_no_flr);
> > > > > >>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503,
> > > > > >>>> quirk_no_flr);
> > > > >
> > > > > Regard
> > > > >
> > > > > Nehal Shah
> > > > >
> > > >
