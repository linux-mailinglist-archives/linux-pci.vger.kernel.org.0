Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAFF28F440
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 16:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgJOODN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 10:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgJOODN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 10:03:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE4C061755;
        Thu, 15 Oct 2020 07:03:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so3743469ejd.13;
        Thu, 15 Oct 2020 07:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bG4cxtJPKg/dYogx9AfPFutW3uBcYHkHh3Gef7cyoJw=;
        b=vWDZgGWAg4ucxgg8GNz4pRV78XmTazCJJbZEWqjFvtpRooS/CLDEL+5OkLaghlh+N2
         PQpObxY+3lTfPL9gmZyPa/Qtp5Dkvlit7IbWecFLJ49HJolr+pAbz4eXVQTwvNQAyPjV
         yMrA7ibPNzPvj/3iXfOE6V+gHYCTfPhaAjpViWKj6izlhPsEK0NvhxdNmxsuRO9MQG4+
         wtPjuJ76EJrfkRYQYqsVb+VaUd9YCXS+kjwo025Sjh5ECpyleY/6OLs5nYk7MPGoxEOB
         DKncNh/m4RdO+tGtQWbiwQKl/Pj8+t3SOhKUdN4rqqH/dxlmAbm/5z4MKtfh44neUffT
         T68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bG4cxtJPKg/dYogx9AfPFutW3uBcYHkHh3Gef7cyoJw=;
        b=Q+BozmW3/SAlI8XmGYXb4aZuIS/L0mIZg2ahBjb3IazFehr5VGmG+VBHEn/tPMr8NW
         Tihz4xYHRS1BtyeOqjGuuNJ1NVTF0YkTKng+6bke+5EXr795dMGMImPvs+1bDD91Jyli
         nt9jlKwM33bygAsZwQ4V6bkQptKOAyy4E/mGwTw/z+tSkz/aZsU9AQ16Lf2yh9nO6omY
         7Eyd5goUPgt2+ooULGPqRZpNSXd72uz122w9B08IphzruX0Q6kCvfqXINkaDACRNmbEI
         7WITVfM7j0z7k/u7mQi72eVE0dp5Avt2PlMiojPFhGmV1dOlJFB6IuSTty+VJkuCK7cC
         yOMQ==
X-Gm-Message-State: AOAM532oibHxpuULspfaBlsxSxPKTf6bm1H8D3BLEPq1zf/TEMsZIQMp
        ydXj1FfoPNA1HNB98RP5BVAqWc+2SFuRoYTby1s=
X-Google-Smtp-Source: ABdhPJy8W/zMvXoXel4TxtKKFrzyqF1WxDRG1ms6VjQOOVqPllwTb666hPg7+GFhiwBNl8SElq2lXV/KfDSUHw38POU=
X-Received: by 2002:a17:906:2bc5:: with SMTP id n5mr4548468ejg.476.1602770591615;
 Thu, 15 Oct 2020 07:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d97541df3b44822e0d085ffa058e9e7c0ba05214.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAKF3qh3nnLaKUAbBdhdXwzknasTWmLFTjB7gz65vjzpHP4Y46Q@mail.gmail.com>
 <17e142b8-b19a-0ec7-833b-7a4ac2e76d0d@linux.intel.com> <CAKF3qh1fiqqRGvUB2Jxm8tM6Q06GntquGxzmcKe1vapONSPREA@mail.gmail.com>
 <b84ae5fd-d1db-9378-7e2e-937b660d2e9a@linux.intel.com> <CAKF3qh107RGykkHCXhCzfq+A6COQWri8svsUfukF9PySHW-qQA@mail.gmail.com>
 <eb94df0b-4cb9-eb49-576a-87ac43fcfdfb@linux.intel.com>
In-Reply-To: <eb94df0b-4cb9-eb49-576a-87ac43fcfdfb@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Thu, 15 Oct 2020 22:03:00 +0800
Message-ID: <CAKF3qh3skCfHLZ5-y93KXeG7GcmJsekVvEO5DpoB-+t-qEW_qQ@mail.gmail.com>
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

On Thu, Oct 15, 2020 at 1:53 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 10/14/20 10:05 PM, Ethan Zhao wrote:
> > On Thu, Oct 15, 2020 at 11:04 AM Kuppuswamy, Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 10/14/20 6:58 PM, Ethan Zhao wrote:
> >>> On Thu, Oct 15, 2020 at 1:06 AM Kuppuswamy, Sathyanarayanan
> >>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 10/14/20 8:07 AM, Ethan Zhao wrote:
> >>>>> On Wed, Oct 14, 2020 at 5:00 PM Kuppuswamy Sathyanarayanan
> >>>>> <sathyanarayanan.nkuppuswamy@gmail.com> wrote:
> >>>>>>
> >>>>>> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> >>>>>> merged fatal and non-fatal error recovery paths, and also made
> >>>>>> recovery code depend on hotplug handler for "remove affected
> >>>>>> device + rescan" support. But this change also complicated the
> >>>>>> error recovery path and which in turn led to the following
> >>>>>> issues.
> >>>>>>
> >>>>>> 1. We depend on hotplug handler for removing the affected
> >>>>>> devices/drivers on DLLSC LINK down event (on DPC event
> >>>>>> trigger) and DPC handler for handling the error recovery. Since
> >>>>>> both handlers operate on same set of affected devices, it leads
> >>>>>> to race condition, which in turn leads to  NULL pointer
> >>>>>> exceptions or error recovery failures.You can find more details
> >>>>>> about this issue in following link.
> >>>>>>
> >>>>>> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/T/#t
> >>>>>>
> >>>>>> 2. For non-hotplug capable devices fatal (DPC) error recovery
> >>>>>> is currently broken. Current fatal error recovery implementation
> >>>>>> relies on PCIe hotplug (pciehp) handler for detaching and
> >>>>>> re-enumerating the affected devices/drivers. So when dealing with
> >>>>>> non-hotplug capable devices, recovery code does not restore the state
> >>>>>> of the affected devices correctly. You can find more details about
> >>>>>> this issue in the following links.
> >>>>>>
> >>>>>> https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
> >>>>>> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
> >>>>>> https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
> >>>>>>
> >>>>>> In order to fix the above two issues, we should stop relying on hotplug
> >>>>>      Yes, it doesn't rely on hotplug handler to remove and rescan the device,
> >>>>> but it couldn't prevent hotplug drivers from doing another replicated
> >>>>> removal/rescanning.
> >>>>> it doesn't make sense to leave another useless removal/rescanning there.
> >>>>> Maybe that's why these two paths were merged to one and made it rely on
> >>>>> hotplug.
> >>>> No, as per PCIe spec, hotplug and DPC has no functional dependency. Hence
> >>>> depending on it to handle some of its recovery function is in-correct and
> >>>> would lead to issues in non-hotplug capable platforms (which is true
> >>>> currently).
> >>>>>
> >>
>
> >
> >>>    Though pciehp is not so hot/scalable and performance critical, but there
> >>>    is per cpu thread to handle hot-plug operation. synchronize all threads
> >>>    make them walk backwards for scalability.
> >> DPC events does not happen in high frequency. So I don't think we should
> >   It's holding global lock, once malfunction happens to one device and
> > it's driver,
> > the whole system, everyone holds it, would be blocked to work.
> >> worry about the performance here. Even hotplug handler will hold this lock
> >> when adding/removing the devices. So adding/removing devices is a serialized
> > You don't worry about performance, but if there is a requirement needs
> > more scalable
> > and reliable hotplug, the effect will be much harder. what to do then ? choose
> > another OS ?
> As I have mentioned, all device creation/removal in PCI core code is already
> protected by this lock (including hotplug code).  So the multidomain performance
> impact you mentioned should exist even now. All I am doing is, using the
> same lock for protecting device removal/rescan in error recovery code.
>
> drivers/pci/xen-pcifront.c:477: pci_lock_rescan_remove();
> drivers/pci/xen-pcifront.c:567: pci_lock_rescan_remove();
> drivers/pci/xen-pcifront.c:1064:                pci_lock_rescan_remove();
> drivers/pci/hotplug/rpaphp_core.c:498:          pci_lock_rescan_remove();
> drivers/pci/hotplug/rpaphp_core.c:520:  pci_lock_rescan_remove();
> drivers/pci/hotplug/s390_pci_hpc.c:70:  pci_lock_rescan_remove();
> drivers/pci/hotplug/shpchp_pci.c:31:    pci_lock_rescan_remove();
> drivers/pci/hotplug/shpchp_pci.c:73:    pci_lock_rescan_remove();
> drivers/pci/hotplug/pciehp_pci.c:39:    pci_lock_rescan_remove();
> drivers/pci/hotplug/pciehp_pci.c:96:    pci_lock_rescan_remove();
> drivers/pci/hotplug/acpiphp_glue.c:762:         pci_lock_rescan_remove();
> drivers/pci/hotplug/acpiphp_glue.c:787: pci_lock_rescan_remove();
> drivers/pci/hotplug/acpiphp_glue.c:975: pci_lock_rescan_remove();
> drivers/pci/hotplug/acpiphp_glue.c:1026:        pci_lock_rescan_remove();
> drivers/pci/hotplug/cpqphp_pci.c:75:    pci_lock_rescan_remove();
> drivers/pci/hotplug/cpqphp_pci.c:120:   pci_lock_rescan_remove();
> drivers/pci/hotplug/rpadlpar_core.c:361:        pci_lock_rescan_remove();
> drivers/pci/hotplug/pnv_php.c:513:                      pci_lock_rescan_remove();
> drivers/pci/hotplug/pnv_php.c:582:      pci_lock_rescan_remove();
> drivers/pci/hotplug/ibmphp_core.c:668:  pci_lock_rescan_remove();
> drivers/pci/hotplug/ibmphp_core.c:738:  pci_lock_rescan_remove();
> drivers/pci/hotplug/cpci_hotplug_pci.c:245:     pci_lock_rescan_remove();
> drivers/pci/hotplug/cpci_hotplug_pci.c:298:     pci_lock_rescan_remove();
> drivers/pci/controller/pci-hyperv.c:1866:       pci_lock_rescan_remove();
> drivers/pci/controller/pci-hyperv.c:2135:               pci_lock_rescan_remove();
> drivers/pci/controller/pci-hyperv.c:2313:               pci_lock_rescan_remove();
> drivers/pci/controller/pci-hyperv.c:3300:               pci_lock_rescan_remove();
> drivers/pci/controller/pci-host-common.c:91:    pci_lock_rescan_remove();
> drivers/pci/remove.c:123:       pci_lock_rescan_remove();
> drivers/pci/pci-sysfs.c:410:            pci_lock_rescan_remove();
> drivers/pci/pci-sysfs.c:444:            pci_lock_rescan_remove();
> drivers/pci/pci-sysfs.c:479:            pci_lock_rescan_remove();
> drivers/pci/probe.c:3231:void pci_lock_rescan_remove(void)
> drivers/pci/probe.c:3235:EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
The existing fact isn't a good justification to use it and make things worse,
vice versa ---use it in more places and "fix" something.
The same logic as PCIe spec doesn't mention DPC should rely on hotplug,
but it doesn't mean that's correct or incorrect.

Thanks,
 Ethan
>
> > To be honest, I don't like the global lock/ pci_lock_rescan_remove().
> >
> > BTW, I didn't try the FATAL errors brute force injection on your
> > patch, duplicated
> > removal will work naturally because it was removed ?
> >
> > Thanks,
> > Ethan
> >> operation.
> >>>
> >>
> >>>>
> >>>>>> --
> >>>>>> 2.17.1
> >>>>>>
> >>>>
> >>>> --
> >>>> Sathyanarayanan Kuppuswamy
> >>>> Linux Kernel Developer
> >>
> >> --
> >> Sathyanarayanan Kuppuswamy
> >> Linux Kernel Developer
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
