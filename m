Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468B0179EBD
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 05:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgCEExl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 23:53:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33662 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCEExl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 23:53:41 -0500
Received: by mail-io1-f66.google.com with SMTP id r15so5084453iog.0;
        Wed, 04 Mar 2020 20:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ijl3mOJKjXQOlvfNdI9J8WHV9omrENAd5cs2bOM6kiw=;
        b=Md4ocL49tyh2taM4R+ydAETsDonhCdHdH91uX9e4oi/Smwy1T1bHdZtXo7pzLeKUlE
         ATgUMwec8xfNgs5wZ9tS84sDUDhEToc97J4DZerin2iZrSMMAhcxvbF/9ENyfBsNsafY
         yz94ZWfU7TIs8zo9/UBF6u5ojhc8bdHjSnD0e+FdhwM3Osjj3y3414ubipw/nhkrYbBI
         MMcTqCF21Ez4VEwoCYUC80WTIWDvErT+VcgO4lzV+XTvsr9PkEzOXASMarW3Rh9XIqAv
         5pcFUzaSqJ6l25COcDCNqZdTAAu27JXSDDhWQhHCzoxrM74HmRDTlNXnOTitQprHYfMO
         Ie8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ijl3mOJKjXQOlvfNdI9J8WHV9omrENAd5cs2bOM6kiw=;
        b=uoZmVe0WOw+JmWeZKwGT+dBUeiU2UDZdKupMm8h/iZ9TCSceR4BPWawyuY/EmRZO/F
         CupSmGEPGtzuKKBtD+0psKmoBAxITeQ4d2qWDK4DGY3DkhGWFLIt0aYdexOOdukXju6e
         k5ERDtv3tUBshA9+faammOEkVe/m9nDCp3/PET42zA616GseEMCJOhjT2EuQj522G+oz
         x3sJEQHHbJ4ZTUhRpmuANQdfSiXQGZ9IlvHtPrc7aSa/che8ZVvxEZKic2VvkG95qEA1
         nSoAZwRt3ZMI0gXVyGDXRMNLX/0yty75aV4vxqzuQy6hv7of8wOwTo7fjdKZ390Hs0Wd
         X9ig==
X-Gm-Message-State: ANhLgQ3ZbqKp+NkXiSysTcM85Cd6rJvQuCuxz0nukzwIEcYeolQK7wrJ
        1Wh0svEYZersm7gg/kOG9uvnYOuE87GZRRkjFCc=
X-Google-Smtp-Source: ADFU+vuq6eqf96IMDiQ869G5MxukNh9n60xtQc2dcMWAjz+WKZ9cLXTJ3kImJCw+Y0lBl/Xjt5lf4D8rfuGWtJI2Xwo=
X-Received: by 2002:a02:cc84:: with SMTP id s4mr5976154jap.5.1583384020211;
 Wed, 04 Mar 2020 20:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20191225192118.283637-1-kasong@redhat.com> <20200222165631.GA213225@google.com>
 <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com>
 <CABeXuvqm1iUGt1GWC9eujuoaACdPiZ2X=3LjKJ5JXKZcXD_z_g@mail.gmail.com>
 <CABeXuvonZpwWfcUef4PeihTJkgH2ZC_RCKuLR3rH3Re4hx36Aw@mail.gmail.com> <20200305035329.GD4433@MiWiFi-R3L-srv>
In-Reply-To: <20200305035329.GD4433@MiWiFi-R3L-srv>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 4 Mar 2020 20:53:29 -0800
Message-ID: <CABeXuvogFGv8-i4jsJYN5ya0hjf35EXLkmPqYWayDUvXaBKidA@mail.gmail.com>
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

On Wed, Mar 4, 2020 at 7:53 PM Baoquan He <bhe@redhat.com> wrote:
>
> +Joerg to CC.
>
> On 03/03/20 at 01:01pm, Deepa Dinamani wrote:
> > I looked at this some more. Looks like we do not clear irqs when we do
> > a kexec reboot. And, the bootup code maintains the same table for the
> > kexec-ed kernel. I'm looking at the following code in
>
> I guess you are talking about kdump reboot here, right? Kexec and kdump
> boot take the similar mechanism, but differ a little.

Right I meant kdump kernel here. And, clearly the is_kdump_kernel() case below.

>
> > intel_irq_remapping.c:
> >
> >         if (ir_pre_enabled(iommu)) {
> >                 if (!is_kdump_kernel()) {
> >                         pr_warn("IRQ remapping was enabled on %s but
> > we are not in kdump mode\n",
> >                                 iommu->name);
> >                         clear_ir_pre_enabled(iommu);
> >                         iommu_disable_irq_remapping(iommu);
> >                 } else if (iommu_load_old_irte(iommu))
>
> Here, it's for kdump kernel to copy old ir table from 1st kernel.

Correct.

> >                         pr_err("Failed to copy IR table for %s from
> > previous kernel\n",
> >                                iommu->name);
> >                 else
> >                         pr_info("Copied IR table for %s from previous kernel\n",
> >                                 iommu->name);
> >         }
> >
> > Would cleaning the interrupts(like in the non kdump path above) just
> > before shutdown help here? This should clear the interrupts enabled
> > for all the devices in the current kernel. So when kdump kernel
> > starts, it starts clean. This should probably help block out the
> > interrupts from a device that does not have a driver.
>
> I think stopping those devices out of control from continue sending
> interrupts is a good idea. While not sure if only clearing the interrupt
> will be enough. Those devices which will be initialized by their driver
> will brake, but devices which drivers are not loaded into kdump kernel
> may continue acting. Even though interrupts are cleaning at this time,
> the on-flight DMA could continue triggerring interrupt since the ir
> table and iopage table are rebuilt.

This should be handled by the IOMMU, right? And, hence you are getting
UR. This seems like the correct execution flow to me.

Anyway, you could just test this theory by removing the
is_kdump_kernel() check above and see if it solves your problem.
Obviously, check the VT-d spec to figure out the exact sequence to
turn off the IR.

Note that the device that is causing the problem here is a legit
device. We want to have interrupts from devices we don't know about
blocked anyway because we can have compromised firmware/ devices that
could cause a DoS attack. So blocking the unwanted interrupts seems
like the right thing to do here.

-Deepa
