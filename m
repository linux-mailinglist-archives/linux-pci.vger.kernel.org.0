Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA053BD7E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 19:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbiFBRoW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiFBRoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 13:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6D3E2A3074
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654191859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6UqmnV8PYOKktTtr/SW/qXHBXvWDrNhaPzVkWUdV24=;
        b=M8FAGE/DbPxFQOSWKWNgTEQ8Mrrhaws8U/Ekq9BMZNrJjR7d0uKdc5lWDjDE4g0iEs3uCk
        z59VlSunPd1odmJ7YszMKteMJ+Cv3YPVwIAzU4C8n/e8ZSIH6qoS7mt0SkrJlDcxzQVORr
        SU+qMvYqeusCt1P5FYehFytWFk4ryk4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-3tN6SNg8NyqAZNEDTBOgVw-1; Thu, 02 Jun 2022 13:44:15 -0400
X-MC-Unique: 3tN6SNg8NyqAZNEDTBOgVw-1
Received: by mail-il1-f197.google.com with SMTP id s15-20020a056e02216f00b002d3d5e41565so3517662ilv.10
        for <linux-pci@vger.kernel.org>; Thu, 02 Jun 2022 10:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/6UqmnV8PYOKktTtr/SW/qXHBXvWDrNhaPzVkWUdV24=;
        b=zeEswjoeMVpKGSj7SM/FCxjeknjUF3YCWWf1xDU0brcnN0LJFEMujeNrdfMajvgLd3
         Kn+yaUAF9DQDfjS5PBNUN0eO6I7cCKaN0lpx+mWNBvF4SdAouOUuk/k+l/4vHPC8/YUp
         AzkGycZ9vSlrIBPq2sT5b7smgEN+DHNZ+sJfQwLfVIqjG02wt8VHY6DnQPncyxW4u5x8
         yHM7n5144XoOjzhWqjvoCtjhxQkgTVsdZiVKJLIH0bA/VptF7CCjIn87Mgd89BTNtBON
         Z05paoo3RKnNm8X1KR2r2h9kSWIZx1Hb1gRrxytHv7okBKhLa3WoN4d/Ul2z9mDm2H8U
         xr1w==
X-Gm-Message-State: AOAM5327qcUme9GV+xtdYhXd7bbo+JzGV0TSJ4uQUHoDhOM952+D242Z
        oUiX8PhhyDcf1MdLTViS4oZ3gCUXKwWTo0wR6mqTZzUw24h79xC0CDDtzZNsjciPvEtUcGkFrpq
        rCT58x8egiObHwRimFx/A
X-Received: by 2002:a05:6e02:1c06:b0:2d1:b240:736f with SMTP id l6-20020a056e021c0600b002d1b240736fmr3856106ilh.133.1654191854856;
        Thu, 02 Jun 2022 10:44:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYAFRuSriDG5abcuJrli+rZhU6ZkEVhwGfBS9otADEOeHJzJ3vpm/0IW18EoJuFTedtaEjWA==
X-Received: by 2002:a05:6e02:1c06:b0:2d1:b240:736f with SMTP id l6-20020a056e021c0600b002d1b240736fmr3856088ilh.133.1654191854447;
        Thu, 02 Jun 2022 10:44:14 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id v6-20020a02cba6000000b0033173a25c73sm177383jap.87.2022.06.02.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 10:44:13 -0700 (PDT)
Date:   Thu, 2 Jun 2022 11:44:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 8/8] vfio/pci: Add the support for PCI D3cold state
Message-ID: <20220602114412.55d1e2c8.alex.williamson@redhat.com>
In-Reply-To: <088c7896-d888-556e-59d7-a21c05c6d808@nvidia.com>
References: <20220425092615.10133-1-abhsahu@nvidia.com>
        <20220425092615.10133-9-abhsahu@nvidia.com>
        <20220504134551.70d71bf0.alex.williamson@redhat.com>
        <9e44e9cc-a500-ab0d-4785-5ae26874b3eb@nvidia.com>
        <20220509154844.79e4915b.alex.williamson@redhat.com>
        <68463d9b-98ee-b9ec-1a3e-1375e50a2ad2@nvidia.com>
        <42518bd5-da8b-554f-2612-80278b527bf5@nvidia.com>
        <20220530122546.GZ1343366@nvidia.com>
        <c73d537b-a653-bf79-68cd-ddc8f0f62a25@nvidia.com>
        <20220531194304.GN1343366@nvidia.com>
        <20220531165209.1c18854f.alex.williamson@redhat.com>
        <00b6e380-ecf4-1eaf-f950-2c418bdb6cac@nvidia.com>
        <20220601102151.75445f6a.alex.williamson@redhat.com>
        <088c7896-d888-556e-59d7-a21c05c6d808@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2 Jun 2022 17:22:03 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> On 6/1/2022 9:51 PM, Alex Williamson wrote:
> > On Wed, 1 Jun 2022 15:19:07 +0530
> > Abhishek Sahu <abhsahu@nvidia.com> wrote:
> >  =20
> >> On 6/1/2022 4:22 AM, Alex Williamson wrote: =20
> >>> On Tue, 31 May 2022 16:43:04 -0300
> >>> Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>    =20
> >>>> On Tue, May 31, 2022 at 05:44:11PM +0530, Abhishek Sahu wrote:   =20
> >>>>> On 5/30/2022 5:55 PM, Jason Gunthorpe wrote:     =20
> >>>>>> On Mon, May 30, 2022 at 04:45:59PM +0530, Abhishek Sahu wrote:
> >>>>>>      =20
> >>>>>>>  1. In real use case, config or any other ioctl should not come a=
long
> >>>>>>>     with VFIO_DEVICE_FEATURE_POWER_MANAGEMENT ioctl request.
> >>>>>>> =20
> >>>>>>>  2. Maintain some 'access_count' which will be incremented when we
> >>>>>>>     do any config space access or ioctl.     =20
> >>>>>>
> >>>>>> Please don't open code locks - if you need a lock then write a pro=
per
> >>>>>> lock. You can use the 'try' variants to bail out in cases where th=
at
> >>>>>> is appropriate.
> >>>>>>
> >>>>>> Jason     =20
> >>>>>
> >>>>>  Thanks Jason for providing your inputs.
> >>>>>
> >>>>>  In that case, should I introduce new rw_semaphore (For example
> >>>>>  power_lock) and move =E2=80=98platform_pm_engaged=E2=80=99 under =
=E2=80=98power_lock=E2=80=99 ?     =20
> >>>>
> >>>> Possibly, this is better than an atomic at least
> >>>>   =20
> >>>>>  1. At the beginning of config space access or ioctl, we can take t=
he
> >>>>>     lock
> >>>>> =20
> >>>>>      down_read(&vdev->power_lock);     =20
> >>>>
> >>>> You can also do down_read_trylock() here and bail out as you were
> >>>> suggesting with the atomic.
> >>>>
> >>>> trylock doesn't have lock odering rules because it can't sleep so it
> >>>> gives a bit more flexability when designing the lock ordering.
> >>>>
> >>>> Though userspace has to be able to tolerate the failure, or never ma=
ke
> >>>> the request.
> >>>>   =20
> >>
> >>  Thanks Alex and Jason for providing your inputs.
> >>
> >>  Using down_read_trylock() along with Alex suggestion seems fine.
> >>  In real use case, config space access should not happen when the
> >>  device is in low power state so returning error should not
> >>  cause any issue in this case.
> >> =20
> >>>>>          down_write(&vdev->power_lock);
> >>>>>          ...
> >>>>>          switch (vfio_pm.low_power_state) {
> >>>>>          case VFIO_DEVICE_LOW_POWER_STATE_ENTER:
> >>>>>                  ...
> >>>>>                          vfio_pci_zap_and_down_write_memory_lock(vd=
ev);
> >>>>>                          vdev->power_state_d3 =3D true;
> >>>>>                          up_write(&vdev->memory_lock);
> >>>>>
> >>>>>          ...
> >>>>>          up_write(&vdev->power_lock);     =20
> >>>>
> >>>> And something checks the power lock before allowing the memor to be
> >>>> re-enabled?
> >>>>   =20
> >>>>>  4.  For ioctl access, as mentioned previously I need to add two
> >>>>>      callbacks functions (one for start and one for end) in the str=
uct
> >>>>>      vfio_device_ops and call the same at start and end of ioctl fr=
om
> >>>>>      vfio_device_fops_unl_ioctl().     =20
> >>>>
> >>>> Not sure I followed this..   =20
> >>>
> >>> I'm kinda lost here too.   =20
> >>
> >>
> >>  I have summarized the things below
> >>
> >>  1. In the current patch (v3 8/8), if config space access or ioctl was
> >>     being made by the user when the device is already in low power sta=
te,
> >>     then it was waking the device. This wake up was happening with
> >>     pm_runtime_resume_and_get() API in vfio_pci_config_rw() and
> >>     vfio_device_fops_unl_ioctl() (with patch v3 7/8 in this patch seri=
es).
> >>
> >>  2. Now, it has been decided to return error instead of waking the
> >>     device if the device is already in low power state.
> >>
> >>  3. Initially I thought to add following code in config space path
> >>     (and similar in ioctl)
> >>
> >>         vfio_pci_config_rw() {
> >>             ...
> >>             down_read(&vdev->memory_lock);
> >>             if (vdev->platform_pm_engaged)
> >>             {
> >>                 up_read(&vdev->memory_lock);
> >>                 return -EIO;
> >>             }
> >>             ...
> >>         }
> >>
> >>      And then there was a possibility that the physical config happens
> >>      when the device in D3cold in case of race condition.
> >>
> >>  4.  So, I wanted to add some mechanism so that the low power entry
> >>      ioctl will be serialized with other ioctl or config space. With t=
his
> >>      if low power entry gets scheduled first then config/other ioctls =
will
> >>      get failure, otherwise low power entry will wait.
> >>
> >>  5.  For serializing this access, I need to ensure that lock is held
> >>      throughout the operation. For config space I can add the code in
> >>      vfio_pci_config_rw(). But for ioctls, I was not sure what is the =
best
> >>      way since few ioctls (VFIO_DEVICE_FEATURE_MIGRATION,
> >>      VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE etc.) are being handled in t=
he
> >>      vfio core layer itself.
> >>
> >>  The memory_lock and the variables to track low power in specific to
> >>  vfio-pci so I need some mechanism by which I add low power check for
> >>  each ioctl. For serialization, I need to call function implemented in
> >>  vfio-pci before vfio core layer makes the actual ioctl to grab the
> >>  locks. Similarly, I need to release the lock once vfio core layer
> >>  finished the actual ioctl. I have mentioned about this problem in the
> >>  above point (point 4 in my earlier mail).
> >> =20
> >>> A couple replies back there was some concern
> >>> about race scenarios with multiple user threads accessing the device.
> >>> The ones concerning non-deterministic behavior if a user is
> >>> concurrently changing power state and performing other accesses are a
> >>> non-issue, imo.     =20
> >>
> >>  What does non-deterministic behavior here mean.
> >>  Is it for user side that user will see different result
> >>  (failure or success) during race condition or in the kernel side
> >>  (as explained in point 3 above where physical config access
> >>  happens when the device in D3cold) ? My concern here is for later
> >>  part where this config space access in D3cold can cause fatal error
> >>  on the system side as we have seen for memory disablement. =20
> >=20
> > Yes, our only concern should be to prevent such an access.  The user
> > seeing non-deterministic behavior, such as during concurrent power
> > control and config space access, all combinations of success/failure
> > are possible, is par for the course when we decide to block accesses
> > across the life of the low power state.
> >   =20
> >>> I think our goal is only to expand the current
> >>> memory_lock to block accesses, including config space, while the devi=
ce
> >>> is in low power, or some approximation bounded by the entry/exit ioct=
l.
> >>>
> >>> I think the remaining issues is how to do that relative to the fact
> >>> that config space access can change the memory enable state and would
> >>> therefore need to upgrade the memory_lock read-lock to a write-lock.
> >>> For that I think we can simply drop the read-lock, acquire the
> >>> write-lock, and re-test the low power state.  If it has changed, that
> >>> suggests the user has again raced changing power state with another
> >>> access and we can simply drop the lock and return -EIO.
> >>>    =20
> >>
> >>  Yes. This looks better option. So, just to confirm, I can take the
> >>  memory_lock read-lock at the starting of vfio_pci_config_rw() and
> >>  release it just before returning from vfio_pci_config_rw() and
> >>  for memory related config access, we will release this lock and
> >>  re-aquiring again write version of this. Once memory write happens,
> >>  then we can downgrade this write lock to read lock ? =20
> >=20
> > We only need to lock for the device access, so if you've finished that
> > access after acquiring the write-lock, there'd be no point to then
> > downgrade that to a read-lock.  The access should be finished by that
> > point.
> > =20
>=20
>  I was planning to take memory_lock read-lock at the beginning of
>  vfio_pci_config_rw() and release the same just before returning from
>  this function. If I don't downgrade it back to read-lock, then the
>  release in the end will be called for the lock which has not taken.
>  Also, user can specify count to any number of bytes and then the
>  vfio_config_do_rw() will be invoked multiple times and then in
>  the second call, it will be without lock.

Ok, yes, I can imagine how it might result in a cleaner exit path to do
a downgrade_write().

> >>  Also, what about IOCTLs. How can I take and release memory_lock for
> >>  ioctl. is it okay to go with Patch 7 where we call
> >>  pm_runtime_resume_and_get() before each ioctl or we need to do the
> >>  same low power check for ioctl also ?
> >>  In Later case, I am not sure how should I do the implementation so
> >>  that all other ioctl are covered from vfio core layer itself. =20
> >=20
> > Some ioctls clearly cannot occur while the device is in low power, such
> > as resets and interrupt control, but even less obvious things like
> > getting region info require device access.  Migration also provides a
> > channel to device access.  Do we want to manage a list of ioctls that
> > are allowed in low power, or do we only want to allow the ioctl to exit
> > low power?
> >  =20
>=20
>  In previous version of this patch, you mentioned that maintaining the
>  safe ioctl list will be tough to maintain. So, currently we wanted to
>  allow the ioctl for low power exit.

Yes, I'm still conflicted in how that would work.
=20
> > I'm also still curious how we're going to handle devices that cannot
> > return to low power such as the self-refresh mode on the GPU.  We can
> > potentially prevent any wake-ups from the vfio device interface, but
> > that doesn't preclude a wake-up via an external lspci.  I think we need
> > to understand how we're going to handle such devices before we can
> > really complete the design.  AIUI, we cannot disable the self-refresh
> > sleep mode without imposing unreasonable latency and memory
> > requirements on the guest and we cannot retrigger the self-refresh
> > low-power mode without non-trivial device specific code.  Thanks,
> >=20
> > Alex
> >  =20
>=20
>  I am working on adding support to notify guest through virtual PME
>  whenever there is any wake-up triggered by the host and the guest has
>  already put the device into runtime suspended state. This virtual PME
>  will be similar to physical PME. Normally, if PCI device need power
>  management transition, then it sends PME event which will be
>  ultimately handled by host OS. In virtual PME case, if host need power
>  management transition, then it sends event to guest and then guest OS
>  handles these virtual PME events. Following is summary:
>=20
>  1. Add the support for one more event like VFIO_PCI_ERR_IRQ_INDEX
>     named VFIO_PCI_PME_IRQ_INDEX and add the required code for this
>     virtual PME event.
>=20
>  2. From the guest side, when the PME_IRQ is enabled then we will
>     set event_fd for PME.
>=20
>  3. In the vfio driver, the PME support bits are already
>     virtualized and currently set to 0. We can set PME capability support
>     for D3cold so that in guest, it looks like
>=20
>      Capabilities: [60] Power Management version 3
>      Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>             PME(D0-,D1-,D2-,D3hot-,D3cold+)
>=20
>  4. From the guest side, it can do PME enable (PME_En bit in Power
>     Management Control/Status Register) which will be again virtualized.
>=20
>  5. When host gets request for resuming the device other than from
>     low power ioctl, then device pm usage count will be incremented, the
>     PME status (PME_Status bit in Power Management Control/Status Registe=
r)
>     will be set and then we can do the event_fd signal.
>=20
>  6. In the PCIe, the PME events will be handled by root port. For
>     using low power D3cold feature, it is required to create virtual root
>     port in hypervisor side and when hypervisor receives this PME event,
>     then it can send virtual interrupt to root port.
>=20
>  7. If we take example of Linux kernel, then pcie_pme_irq() will
>     handle this and then do the runtime resume on the guest side. Also, it
>     will clear the PME status bit here. Then guest can put the device
>     again into suspended state.
>=20
>  8. I did prototype changes in QEMU for above logic and was getting wake-=
up
>     in the guest whenever I do lspci on the host side.
>=20
>  9. Since currently only nvidia GPU has this limitation to require
>     driver interaction each time before going into D3cold so we can allow
>     the reentry for other device. We can have nvidia vendor (along with
>     VGA/3D controller class code). In future, if any other device also has
>     similar requirement then we can update this list. For other device
>     host can put the device into D3cold in case of any wake-up.
>=20
>  10. In the vfio driver, we can put all these restriction for
>      enabling PME and return error if user tries to make low power entry
>      ioctl without enabling the PME related things.
>=20
>  11. The virtual PME can help in handling physical PME also for all
>      the devices. The PME logic is not dependent upon nvidia GPU
>      restriction. If virtual PME is enabled by hypervisor, then when
>      physical PME wakes the device, then it will resume on the guest side
>      also.

So if host accesses through things like lspci are going to wake the
device and we can't prevent that, and the solution to that is to notify
the guest to put the device back to low power, then it seems a lot less
important to try to prevent the user from waking the device through
random accesses.  In that context, maybe we do simply wrap all accesses
with pm_runtime_get/put() put calls, which eliminates the problem of
maintaining a list of safe ioctls in low power.

I'd probably argue that whether to allow the kernel to put the device
back to low power directly is a policy decision and should therefore be
directed by userspace.  For example the low power entry ioctl would
have a flag to indicate the desired behavior and QEMU might have an
on/off/[auto] vfio-pci device option which allows configuration of that
behavior.  The default auto policy might direct for automatic low-power
re-entry except for NVIDIA VGA/3D class codes and other devices we
discover that need it.  This lets us have an immediate workaround for
devices requiring guest support without a new kernel.

This PME notification to the guest is really something that needs to be
part of the base specification for user managed low power access due to
these sorts of design decisions.  Thanks,

Alex

