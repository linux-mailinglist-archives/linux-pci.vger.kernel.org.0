Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A212E3FCF31
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 23:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhHaVhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 17:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhHaVhy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Aug 2021 17:37:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E4CC061575;
        Tue, 31 Aug 2021 14:36:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x11so2156105ejv.0;
        Tue, 31 Aug 2021 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0s57yEPWIRYy3pbGuid3H+I/WMFFbO84Xddobf8YM8=;
        b=kd8b2WcrBzk7/Yrg1Tvoo3KTg85013xt+LM/RuDGQg+iDbHtzh+ed8uUSmnpmuqRHH
         VM2/biUhEt7Tosjnxx1de7ByaxM6DKmP/bvxF87nt64OWAVz+Yvt3Vr5KTkrq+omU/bl
         kVcsxOoo3LS0AdpRxFNr3acSgwlIFJfuWKecYaD+L4TmN9QKUV4cDUVa9kZLkEWAe91h
         y1BHrrl/tiQy8hjLjVRUMxCdg0lBpMZh4CrnGUYYnXppYVHfDjhLKq0X9rIhjgH6XtoC
         lhDaLApT+eXhzXgf50oObk2CHqXXoa4e0Z14mjjwRdx0iJfM70mp2xX59iYO/gmFS9UV
         mkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0s57yEPWIRYy3pbGuid3H+I/WMFFbO84Xddobf8YM8=;
        b=BVxY3fh85bTcf9Kn/RTAK+KExY5EMk7T07cNKdk3ugqLn3IqEfvQmL1B07mJgsH0qZ
         HjKPqfn9JgrOq/RTmcGMTZtYYYGpFR4k1nXYVbrU3uUAjYU/SCytyhfHvDOSdTrql0MB
         iMBFRGyRAevALRR9/qeI/VNgrDo+niXZ4K4Omww3AhfhjRUM1yGjfT7/U1mVLLpxf3eR
         jrj5LWQse9P7LX9IppqzIPrBJa/HMPCZdiiHavX7IyGQXInJHSnHROwfBVLLl9n4i7xE
         qXF0Nm9v2zwt35LaZvj4j+Gp6EafsITY/FfVJTHHxja7NHowaYcVLx5gXZnxABzii6XT
         SKZQ==
X-Gm-Message-State: AOAM532kRqD3tf91VjBN7bj/uvyVcAcr1RYEOs2IdfDl1+x1OTjyTGPb
        zIdMPDghG2aP6Vd9picxna37pbRFjfIPn1h/KDE=
X-Google-Smtp-Source: ABdhPJy8PDjiHg8O3o8VownBhsJlLoGswKsLm9xkEqWkqI1ERj635kk2hoZ6DY3OwXdn1XRxh1SAh/FfFmQI8ND6Jy4=
X-Received: by 2002:a17:906:1289:: with SMTP id k9mr32633983ejb.2.1630445817011;
 Tue, 31 Aug 2021 14:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210825102636.52757-4-21cnbao@gmail.com> <20210829145552.GA11556@xsang-OptiPlex-9020>
 <CAGsJ_4yYwjuWsEeK3CvnOhc10mbBNYWXqxqp+mR5587R2FD3gQ@mail.gmail.com> <1132a536516f15ab6b338ab868ec3705@kernel.org>
In-Reply-To: <1132a536516f15ab6b338ab868ec3705@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 1 Sep 2021 09:36:45 +1200
Message-ID: <CAGsJ_4y45TyWibu0cOLbopO_k3RbwxQe0C2yp8v4=fF7etMOTg@mail.gmail.com>
Subject: Re: [PCI/MSI] a4fc4cf388: dmesg.genirq:Flags_mismatch_irq##(mei_me)vs.#(xhci_hcd)
To:     Marc Zyngier <maz@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan.Cameron@huawei.com, bilbao@vt.edu,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        leon@kernel.org, linux-pci@vger.kernel.org,
        Linuxarm <linuxarm@huawei.com>, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 31, 2021 at 8:08 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-08-31 02:21, Barry Song wrote:
> > On Mon, Aug 30, 2021 at 2:38 AM kernel test robot
> > <oliver.sang@intel.com> wrote:
> >>
> >>
> >>
> >> Greeting,
> >>
> >> FYI, we noticed the following commit (built with gcc-9):
> >>
> >> commit: a4fc4cf388319ea957ffbdab5073bdd267de9082 ("[PATCH v3 3/3]
> >> PCI/MSI: remove msi_attrib.default_irq in msi_desc")
> >> url:
> >> https://github.com/0day-ci/linux/commits/Barry-Song/PCI-MSI-Clarify-the-IRQ-sysfs-ABI-for-PCI-devices/20210825-183018
> >> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> >> 6e764bcd1cf72a2846c0e53d3975a09b242c04c9
> >>
> >> in testcase: kernel-selftests
> >> version: kernel-selftests-x86_64-ebaa603b-1_20210825
> >> with following parameters:
> >>
> >>         group: pidfd
> >>         ucode: 0xe2
> >>
> >> test-description: The kernel contains a set of "self tests" under the
> >> tools/testing/selftests/ directory. These are intended to be small
> >> unit tests to exercise individual code paths in the kernel.
> >> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >>
> >>
> >> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
> >> with 32G memory
> >>
> >> caused below changes (please refer to attached dmesg/kmsg for entire
> >> log/backtrace):
> >>
> >>
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kernel test robot <oliver.sang@intel.com>
> >>
> >>
> >>
> >> [  179.602028][   T34] genirq: Flags mismatch irq 16. 00002000
> >> (mei_me) vs. 00000000 (xhci_hcd)
> >> [  179.614073][   T34] CPU: 2 PID: 34 Comm: kworker/u8:2 Not tainted
> >> 5.14.0-rc7-00014-ga4fc4cf38831 #1
> >> [  179.623225][   T34] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT,
> >> BIOS 1.8.1 12/05/2017
> >> [  179.631432][   T34] Workqueue: events_unbound async_run_entry_fn
> >> [  179.637543][   T34] Call Trace:
> >> [  179.640789][   T34]  dump_stack_lvl+0x45/0x59
> >> [  179.645253][   T34]  __setup_irq.cold+0x50/0xd4
> >> [  179.649893][   T34]  ? mei_me_pg_exit_sync+0x480/0x480 [mei_me]
> >> [  179.655923][   T34]  request_threaded_irq+0x10c/0x180
> >> [  179.661073][   T34]  ? mei_me_irq_quick_handler+0x240/0x240
> >> [mei_me]
> >> [  179.667528][   T34]  mei_me_probe+0x131/0x300 [mei_me]
> >> [  179.672767][   T34]  local_pci_probe+0x42/0x80
> >> [  179.677313][   T34]  pci_device_probe+0x107/0x1c0
> >> [  179.682118][   T34]  really_probe+0xb6/0x380
> >> [  179.687094][   T34]  __driver_probe_device+0xfe/0x180
> >> [  179.692242][   T34]  driver_probe_device+0x1e/0xc0
> >> [  179.697133][   T34]  __driver_attach_async_helper+0x2b/0x80
> >> [  179.702802][   T34]  async_run_entry_fn+0x30/0x140
> >> [  179.707693][   T34]  process_one_work+0x274/0x5c0
> >> [  179.712503][   T34]  worker_thread+0x50/0x3c0
> >> [  179.716959][   T34]  ? process_one_work+0x5c0/0x5c0
> >> [  179.721936][   T34]  kthread+0x14f/0x180
> >> [  179.725958][   T34]  ? set_kthread_struct+0x40/0x40
> >> [  179.730935][   T34]  ret_from_fork+0x22/0x30
> >> [  179.735699][   T34] mei_me 0000:00:16.0: request_threaded_irq
> >> failure. irq = 16
> >> [  179.743125][   T34] mei_me 0000:00:16.0: initialization failed.
> >> [  179.749399][   T34] mei_me: probe of 0000:00:16.0 failed with error
> >> -16
> >>
> >>
> >
> > it seems there is a direct reference to pdev->irq.
> > Hi Oliver, would you try if the below patch can fix the problem:
> >
> > diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> > index c3393b383e59..a45a2d4257a6 100644
> > --- a/drivers/misc/mei/pci-me.c
> > +++ b/drivers/misc/mei/pci-me.c
> > @@ -216,7 +216,7 @@ static int mei_me_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >
> >         pci_enable_msi(pdev);
> >
> > -       hw->irq = pdev->irq;
> > +       hw->irq = pci_irq_vector(pdev, 0);
> >
> >          /* request and enable interrupt */
> >         irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT :
> > IRQF_SHARED;
> >
>
> Ah! one victim, 3000 to go! :D
>

yep.

> That's exactly the kind of stuff I was mentioning when we
> discussed this patch. Exposing the MSI vector as the INTx
> IRQ has led to all sorts of broken drivers.

I guess drivers should depend on int pci_irq_vector(struct pci_dev
*dev, unsigned int nr)
rather than hardcodely use pdev->irq.

pci_irq_vector() supports all cases(intx, msi, msi-x)

>
>          M.
> --
> Jazz is not dead. It just smells funny...

Thanks
barry
