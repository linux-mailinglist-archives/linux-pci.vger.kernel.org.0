Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9EA28EA8E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 03:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbgJOB7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 21:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgJOB7K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 21:59:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB02C061755;
        Wed, 14 Oct 2020 18:59:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ce10so1288970ejc.5;
        Wed, 14 Oct 2020 18:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHnR2XfJq/JDBqhwl8GNoJlKoubVCNL1H1SylztTjPw=;
        b=ShVHc4AwsRGiPeMu67vv5weHKu3y/0tppIJlNm0AOv0DgzzHlKUXIGpVqE878pG3ns
         ZzqVvdMOgn3nkntRoKS9kG+HsuRIxHJ52Odakz9dXNvQOnGN7rQcrDcMoL41a2CimkU4
         kJF2LOuy8HJovBD1K1gQa81kWYeJveTxgbpxwcjABt7tAIOQxLxI+Doq5jLKq0NZ85PX
         HDPNbNKr0RjT95tdPAfV5yD1+g3S3tLbEMn2kRrGclKwrsjrtFB3VqeGY5LawtoDl3Bt
         vSclr5Jt5PPqVlZtMEloy14KWpTvZapc5cRbDwOY5elFseqrjYQ8jou4gt7/ggdoTxLP
         /IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHnR2XfJq/JDBqhwl8GNoJlKoubVCNL1H1SylztTjPw=;
        b=PVus1TeQEyJVU8xgqVYtdTa7NC94qh24toEYwXY4V1uPqiLsKAzPxQqieS8biNLOPT
         veXguiT4SIHuOhyGjjLvhWyp4URncNBMw3jpwDPEgyrM+Se3q20xHlQT26updHXVh9rW
         VV6bwAhhedEXvycPIFPCs9rP70lPB2peyk61LosknQloPc7hJm6W5+i/tnEv7TZd4/vB
         KoVT/VJq1R78EXZ86jt9qaH1RJrbQdFaWEUYaCe8jCgfGPHsQ4yVPKihbfyh2lKzUSkL
         TTSH8K3QtgeS7RqHNn5AeJK5u5lekxVPjodmSS7khP3D2l69RzRKPGG0k/2J4ENDvL6x
         KkpQ==
X-Gm-Message-State: AOAM5335XqZ1cGtrDactBp0d39qLTbmxzAzG2J517peGddd8OrrNx0Kd
        Kk8nUZgbkjIBHcZyVc4bKWGCJ+pKIw3kQ58BTtg=
X-Google-Smtp-Source: ABdhPJzMp6uWxPGZrCA4WnvSGL7juT8lkuub+71iSInGAwSJs0sFGvMBWIA63HE8lAip74i+paqY/NcE/jyv8LodZdg=
X-Received: by 2002:a17:906:6dc6:: with SMTP id j6mr2135978ejt.354.1602727148383;
 Wed, 14 Oct 2020 18:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d97541df3b44822e0d085ffa058e9e7c0ba05214.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAKF3qh3nnLaKUAbBdhdXwzknasTWmLFTjB7gz65vjzpHP4Y46Q@mail.gmail.com> <17e142b8-b19a-0ec7-833b-7a4ac2e76d0d@linux.intel.com>
In-Reply-To: <17e142b8-b19a-0ec7-833b-7a4ac2e76d0d@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Thu, 15 Oct 2020 09:58:56 +0800
Message-ID: <CAKF3qh1fiqqRGvUB2Jxm8tM6Q06GntquGxzmcKe1vapONSPREA@mail.gmail.com>
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

On Thu, Oct 15, 2020 at 1:06 AM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 10/14/20 8:07 AM, Ethan Zhao wrote:
> > On Wed, Oct 14, 2020 at 5:00 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.nkuppuswamy@gmail.com> wrote:
> >>
> >> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> >> merged fatal and non-fatal error recovery paths, and also made
> >> recovery code depend on hotplug handler for "remove affected
> >> device + rescan" support. But this change also complicated the
> >> error recovery path and which in turn led to the following
> >> issues.
> >>
> >> 1. We depend on hotplug handler for removing the affected
> >> devices/drivers on DLLSC LINK down event (on DPC event
> >> trigger) and DPC handler for handling the error recovery. Since
> >> both handlers operate on same set of affected devices, it leads
> >> to race condition, which in turn leads to  NULL pointer
> >> exceptions or error recovery failures.You can find more details
> >> about this issue in following link.
> >>
> >> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/T/#t
> >>
> >> 2. For non-hotplug capable devices fatal (DPC) error recovery
> >> is currently broken. Current fatal error recovery implementation
> >> relies on PCIe hotplug (pciehp) handler for detaching and
> >> re-enumerating the affected devices/drivers. So when dealing with
> >> non-hotplug capable devices, recovery code does not restore the state
> >> of the affected devices correctly. You can find more details about
> >> this issue in the following links.
> >>
> >> https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
> >> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
> >> https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
> >>
> >> In order to fix the above two issues, we should stop relying on hotplug
> >    Yes, it doesn't rely on hotplug handler to remove and rescan the device,
> > but it couldn't prevent hotplug drivers from doing another replicated
> > removal/rescanning.
> > it doesn't make sense to leave another useless removal/rescanning there.
> > Maybe that's why these two paths were merged to one and made it rely on
> > hotplug.
> No, as per PCIe spec, hotplug and DPC has no functional dependency. Hence
> depending on it to handle some of its recovery function is in-correct and
> would lead to issues in non-hotplug capable platforms (which is true
> currently).
> >
>
> >> +       else
> >> +               udev = dev->bus->self;
> >> +
> >> +       parent = udev->subordinate;
> >> +       pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> >> +
> >> +        pci_lock_rescan_remove();
> >     Though here you have lock, but hotplug will do another
> > 'pci_stop_and_remove_bus_device()'
> >     without merging it with the hotplug driver, you have no way to
> > remove the replicated actions in
> >    hotplug handler.
> No, the core operation (remove/add device) is syncronzied and done in
> only one thread. Please check the following flow. Even in hotplug
 pci_lock_rescan_remove() is global lock for PCIe, the mal-functional
 device's port holds this lock, it prevents the whole system from doing
 hot-plug operation.
 Though pciehp is not so hot/scalable and performance critical, but there
 is per cpu thread to handle hot-plug operation. synchronize all threads
 make them walk backwards for scalability.

> handler, before removing the device, it attempts to hold pci_lock_rescan_remove()
> lock. So holding the same lock in DPC handler will syncronize the DPC/hotplug
> handlers. Also if one of the thread (DPC or hotplug) removes/adds the affected devices,
> other thread will not repeat the same action (since the device is already removed/added).
>
> ->pciehp_ist()
>    ->pciehp_handle_presence_or_link_change()
>      ->pciehp_disable_slot()
>        ->__pciehp_disable_slot()
>          ->remove_board()
>            ->pciehp_unconfigure_device()
>              ->pci_lock_rescan_remove()
> >
> >
> >    Thanks,
> >    Ethan
> >> +        pci_dev_get(dev);
> >> +        list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
> >> +                                        bus_list) {
> >> +               pci_stop_and_remove_bus_device(pdev);
> >> +       }
> >> +
> >> +       result = reset_link(udev);
> >> +
> >> +       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> >> +               /*
> >> +                * If the error is reported by a bridge, we think this error
> >> +                * is related to the downstream link of the bridge, so we
> >> +                * do error recovery on all subordinates of the bridge instead
> >> +                * of the bridge and clear the error status of the bridge.
> >> +                */
> >> +               pci_aer_clear_fatal_status(dev);
> >> +               if (pcie_aer_is_native(dev))
> >> +                       pcie_clear_device_status(dev);
> >> +       }
> >> +
> >> +       if (result == PCI_ERS_RESULT_RECOVERED) {
> >> +               if (pcie_wait_for_link(udev, true))
> >     And another  pci_rescan_bus() like in the hotplug handler.
> As I have mentioned before, holding the same lock should make them synchronized
> and not repeat the underlying functionality of pci_rescan_bus() in both threads
> at the same time.
   Yes, it blocked them all.

Thanks,
Ethan
> >> +                       pci_rescan_bus(udev->bus);
> >> +               pci_info(dev, "Device recovery from fatal error successful\n");
> >> +        } else {
> >> +               pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> >> +               pci_info(dev, "Device recovery from fatal error failed\n");
>
> >> --
> >> 2.17.1
> >>
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
