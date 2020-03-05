Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC8179FC4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 07:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgCEGHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 01:07:11 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37055 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgCEGHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2020 01:07:11 -0500
Received: by mail-il1-f195.google.com with SMTP id a6so4033789ilc.4;
        Wed, 04 Mar 2020 22:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JM+ymBtB23jWt4sfUg5MQFutpMp62S4P16xrVlgqOis=;
        b=WHBb5sJKYb2k/0/vunyclRnGZlRtx5R94rwqcuJ5s+jnTIF0KVle1NGm7yQKzyygLJ
         J3L45LIc0f0xGux9ZKwHotDlkYfarw/H1iuHIcDruxed2K6BfAmSemK76OHitCu6RAfB
         lsMk4JbpUGZXdjV3o0MuDZzXfLfiqHG/OtUnklTJU2xKDe+MtyPjyb11145CU6D6TYYM
         Q1A5eIEVGtEsBcPIp4eIqWQBojOhVW4pvJH2iMHMVh8pUIha8A1+IXnrpvy1yU/XegYy
         msaBo+Gpu564Z1/7tTZPhQVhWNStJXBdPprEwhnUt7Yr9PzcXxsdndTckNJYryXlBcDK
         qaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JM+ymBtB23jWt4sfUg5MQFutpMp62S4P16xrVlgqOis=;
        b=iGRerJPrilPsVo9gZNYkPrPEjYXCB8wo5YkAzR9EgNtPeDZqyQcySwvU8iQmPOINkw
         0zSCdiiqzKbR/OcKf8nxxs44YTty08v3UA5C9VK3HEkAD63EOWtx7wN1DVX8THbe2pZx
         LYkaAPwULQDOMOVYP/A/mZlE/M0C0xFxcUNDjJS63/0w7OiYoeI3IJMQMcUSAatxWxad
         2dNCiU8C38j/ucjiVjH1KAlb0Yq6Wa3DWFsA8txEtKMFYm6KLNrx3Tvfz/WURrDAiWCC
         CyopMdhmbtaJHjEjOtpH7Jv+bfSciMW4k2iKID0o+PGEVvSOKXqHaoQ8zfOAEU1gEJGu
         adPw==
X-Gm-Message-State: ANhLgQ1lMhgh7Mje8ZPCH0xZMcvPiBhFKHr5XMaCaxgy/qM1zdA+af5S
        izODiSt/GhMwHce3ykd+KEwDjwcuTAv0iFQqh78=
X-Google-Smtp-Source: ADFU+vsDoKo1QxnK3q1eCpUxaItHC7KhhteG/IlUOH5+jITUVIhTXJPg4CSqeuxLBwGFNmax5uW6bCuDTkuUjHvYYag=
X-Received: by 2002:a92:c848:: with SMTP id b8mr6226142ilq.153.1583388428722;
 Wed, 04 Mar 2020 22:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20191225192118.283637-1-kasong@redhat.com> <20200222165631.GA213225@google.com>
 <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com>
 <CABeXuvqm1iUGt1GWC9eujuoaACdPiZ2X=3LjKJ5JXKZcXD_z_g@mail.gmail.com>
 <CABeXuvonZpwWfcUef4PeihTJkgH2ZC_RCKuLR3rH3Re4hx36Aw@mail.gmail.com>
 <20200305035329.GD4433@MiWiFi-R3L-srv> <CABeXuvogFGv8-i4jsJYN5ya0hjf35EXLkmPqYWayDUvXaBKidA@mail.gmail.com>
In-Reply-To: <CABeXuvogFGv8-i4jsJYN5ya0hjf35EXLkmPqYWayDUvXaBKidA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 4 Mar 2020 22:06:58 -0800
Message-ID: <CABeXuvog9KEJQ41Kox8T60fAZ4owip-3bB8XAsndFWF1-udwPQ@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Baoquan He <bhe@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Randy Wright <rwright@hpe.com>, Dave Young <dyoung@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>, jroedel@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 4, 2020 at 8:53 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Wed, Mar 4, 2020 at 7:53 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > +Joerg to CC.
> >
> > On 03/03/20 at 01:01pm, Deepa Dinamani wrote:
> > > I looked at this some more. Looks like we do not clear irqs when we do
> > > a kexec reboot. And, the bootup code maintains the same table for the
> > > kexec-ed kernel. I'm looking at the following code in
> >
> > I guess you are talking about kdump reboot here, right? Kexec and kdump
> > boot take the similar mechanism, but differ a little.
>
> Right I meant kdump kernel here. And, clearly the is_kdump_kernel() case below.
>
> >
> > > intel_irq_remapping.c:
> > >
> > >         if (ir_pre_enabled(iommu)) {
> > >                 if (!is_kdump_kernel()) {
> > >                         pr_warn("IRQ remapping was enabled on %s but
> > > we are not in kdump mode\n",
> > >                                 iommu->name);
> > >                         clear_ir_pre_enabled(iommu);
> > >                         iommu_disable_irq_remapping(iommu);
> > >                 } else if (iommu_load_old_irte(iommu))
> >
> > Here, it's for kdump kernel to copy old ir table from 1st kernel.
>
> Correct.
>
> > >                         pr_err("Failed to copy IR table for %s from
> > > previous kernel\n",
> > >                                iommu->name);
> > >                 else
> > >                         pr_info("Copied IR table for %s from previous kernel\n",
> > >                                 iommu->name);
> > >         }
> > >
> > > Would cleaning the interrupts(like in the non kdump path above) just
> > > before shutdown help here? This should clear the interrupts enabled
> > > for all the devices in the current kernel. So when kdump kernel
> > > starts, it starts clean. This should probably help block out the
> > > interrupts from a device that does not have a driver.
> >
> > I think stopping those devices out of control from continue sending
> > interrupts is a good idea. While not sure if only clearing the interrupt
> > will be enough. Those devices which will be initialized by their driver
> > will brake, but devices which drivers are not loaded into kdump kernel
> > may continue acting. Even though interrupts are cleaning at this time,
> > the on-flight DMA could continue triggerring interrupt since the ir
> > table and iopage table are rebuilt.
>
> This should be handled by the IOMMU, right? And, hence you are getting
> UR. This seems like the correct execution flow to me.

One small correction, I meant the IOMMU and BME here.
