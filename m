Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC1A28EC8C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 07:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgJOFFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 01:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgJOFFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 01:05:23 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C2C061755;
        Wed, 14 Oct 2020 22:05:23 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l24so1705447edj.8;
        Wed, 14 Oct 2020 22:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fPpNsUG0FMeX/jjNHsy+0sQoSc0Pn32Jaz3fp/OxYo=;
        b=iCYT9pfTsWDokaXhJVkvDYYVAkeFn8AEGUS3MwZtLZPwjsOkNrOKvOUtdn/rtuHOZO
         0rltPTRY+YQLX46tWJT8i96TdjtyDWrrfksngSY1/Dn6XRh5r+j30Dgf9G9dAHesMpVc
         hzm/zr32ggyvy9m7+HWZLhIV/eiV+C2xL87CPp17jSMIMVpkkm2nNzAbSLy0x4bSyOFk
         miBscFjIJB1fH27XXJyx+hFxFLPc8MACXbqn5Ju594G6XqNIHT6pk8vbw6Dxa3pQPYhw
         QIm0eCGQgsaPIxHsa9L5NjWUhBfRiuoIlT7Dijqj08vwnbzxjyPlTWYTtQvInUZYD6YC
         6okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fPpNsUG0FMeX/jjNHsy+0sQoSc0Pn32Jaz3fp/OxYo=;
        b=Gu2zah3Hge1BaVIpuKOcwU6zwdFhDXTpddAIuUqzwQ6LDxXq3xGJbZFBAVg6YMVwjt
         6AwsoXtKm2Zlk6yjqLFyKCCS8WCqWQoOQKPy+rHWjc1YOoND4Wwn4smFeeeb9LJ44gfx
         14C6QAcpe5Q4W47hU36Y6TXU2b1bmebKCrpYbpstpf3UMgFTxqCVbQKZlGMz8HYmc86l
         mazb+ED7gVCvWDWvQq2MDBbQ+XuceCm55lUASBx+GvSFquzSVl9js3dmVmsptDv95BzD
         PG+Y1waqi5HXZiCeQtTBnomIBkHx5bkSR0jvgcCzmhRuMklPO3kFTj1L1KV8iTua++Ys
         ldzg==
X-Gm-Message-State: AOAM5327FosqTfXJSEglt8dGcfb8cZunXFSOhFj5hIIu4GDImiEkXtZW
        R2tfbIE7TSar1eDLZqu6Cae4eDJpSQRNhQoqEDE=
X-Google-Smtp-Source: ABdhPJztQBIuoSs8Iub23GgZCUAZcgJGAM10pjR6rYmq1MBOGrF4Tw3za470KScZykX48mapeRG/H/d2wZTflWvdhbY=
X-Received: by 2002:a05:6402:a42:: with SMTP id bt2mr2383913edb.193.1602738322132;
 Wed, 14 Oct 2020 22:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d97541df3b44822e0d085ffa058e9e7c0ba05214.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAKF3qh3nnLaKUAbBdhdXwzknasTWmLFTjB7gz65vjzpHP4Y46Q@mail.gmail.com>
 <17e142b8-b19a-0ec7-833b-7a4ac2e76d0d@linux.intel.com> <CAKF3qh1fiqqRGvUB2Jxm8tM6Q06GntquGxzmcKe1vapONSPREA@mail.gmail.com>
 <b84ae5fd-d1db-9378-7e2e-937b660d2e9a@linux.intel.com>
In-Reply-To: <b84ae5fd-d1db-9378-7e2e-937b660d2e9a@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Thu, 15 Oct 2020 13:05:10 +0800
Message-ID: <CAKF3qh107RGykkHCXhCzfq+A6COQWri8svsUfukF9PySHW-qQA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 15, 2020 at 11:04 AM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 10/14/20 6:58 PM, Ethan Zhao wrote:
> > On Thu, Oct 15, 2020 at 1:06 AM Kuppuswamy, Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 10/14/20 8:07 AM, Ethan Zhao wrote:
> >>> On Wed, Oct 14, 2020 at 5:00 PM Kuppuswamy Sathyanarayanan
> >>> <sathyanarayanan.nkuppuswamy@gmail.com> wrote:
> >>>>
> >>>> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> >>>> merged fatal and non-fatal error recovery paths, and also made
> >>>> recovery code depend on hotplug handler for "remove affected
> >>>> device + rescan" support. But this change also complicated the
> >>>> error recovery path and which in turn led to the following
> >>>> issues.
> >>>>
> >>>> 1. We depend on hotplug handler for removing the affected
> >>>> devices/drivers on DLLSC LINK down event (on DPC event
> >>>> trigger) and DPC handler for handling the error recovery. Since
> >>>> both handlers operate on same set of affected devices, it leads
> >>>> to race condition, which in turn leads to  NULL pointer
> >>>> exceptions or error recovery failures.You can find more details
> >>>> about this issue in following link.
> >>>>
> >>>> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/T/#t
> >>>>
> >>>> 2. For non-hotplug capable devices fatal (DPC) error recovery
> >>>> is currently broken. Current fatal error recovery implementation
> >>>> relies on PCIe hotplug (pciehp) handler for detaching and
> >>>> re-enumerating the affected devices/drivers. So when dealing with
> >>>> non-hotplug capable devices, recovery code does not restore the state
> >>>> of the affected devices correctly. You can find more details about
> >>>> this issue in the following links.
> >>>>
> >>>> https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
> >>>> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
> >>>> https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
> >>>>
> >>>> In order to fix the above two issues, we should stop relying on hotplug
> >>>     Yes, it doesn't rely on hotplug handler to remove and rescan the device,
> >>> but it couldn't prevent hotplug drivers from doing another replicated
> >>> removal/rescanning.
> >>> it doesn't make sense to leave another useless removal/rescanning there.
> >>> Maybe that's why these two paths were merged to one and made it rely on
> >>> hotplug.
> >> No, as per PCIe spec, hotplug and DPC has no functional dependency. Hence
> >> depending on it to handle some of its recovery function is in-correct and
> >> would lead to issues in non-hotplug capable platforms (which is true
> >> currently).
> >>>
>
> >   pci_lock_rescan_remove() is global lock for PCIe, the mal-functional
> >   device's port holds this lock, it prevents the whole system from doing
> >   hot-plug operation.
> It does not prevent the hotplug operation, but it might delay it. Since both
> DPC and hotplug operates on same set of devices, it must be synchronized.
 Think about a large system with some PCI domains, every domain has some
 ports and devices attached. why DPC and hotplug *must* operate on the
 same set of devices from different domains ? if it must be synchronized, why
 make the hotplug handlers threadable ?

> >   Though pciehp is not so hot/scalable and performance critical, but there
> >   is per cpu thread to handle hot-plug operation. synchronize all threads
> >   make them walk backwards for scalability.
> DPC events does not happen in high frequency. So I don't think we should
 It's holding global lock, once malfunction happens to one device and
it's driver,
the whole system, everyone holds it, would be blocked to work.
> worry about the performance here. Even hotplug handler will hold this lock
> when adding/removing the devices. So adding/removing devices is a serialized
You don't worry about performance, but if there is a requirement needs
more scalable
and reliable hotplug, the effect will be much harder. what to do then ? choose
another OS ?
To be honest, I don't like the global lock/ pci_lock_rescan_remove().

BTW, I didn't try the FATAL errors brute force injection on your
patch, duplicated
removal will work naturally because it was removed ?

Thanks,
Ethan
> operation.
> >
>
> >>
> >>>> --
> >>>> 2.17.1
> >>>>
> >>
> >> --
> >> Sathyanarayanan Kuppuswamy
> >> Linux Kernel Developer
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
