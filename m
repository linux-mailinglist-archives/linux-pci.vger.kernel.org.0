Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D33E221365
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgGORPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 13:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgGORPQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 13:15:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DFC08C5E0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2020 10:15:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t6so2652104plo.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2020 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aYLcR+u3Q7QAoRz2AVyYCCVVYa+EVxieuJWSO0Q6Dtg=;
        b=CiAqJK6Yf33nCCk9NBQhOlJJB4SKzdxAlfOdZV+6D3tdWLqYglGUVbJd2vwySZKzfR
         kiJw4pGgfhBKdRYdHx5CIOJykfU8PR+m5pFhj+Xp0vBBlgJWtPaGN+5duNo9zWsfFxcw
         eCBLFRe/xshBxGgBfXCUST6KpVXVfQGb7C4kMfWqVcTIBECxyv8+zwzME89F6Xs1MyzS
         MPke4Lqy3b3W+ufVffVpNew8usA47n+//lNfxe0VEmDS5FWi/mZRf9kLx0XP5L748WXO
         +yt+STFs7zqToJV+XBKB0EDc16UB/5E6DdBnk3+nwPmDX3lp+ec1cGyNbFQ1zp9YZZIV
         p0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aYLcR+u3Q7QAoRz2AVyYCCVVYa+EVxieuJWSO0Q6Dtg=;
        b=SV6WnIGlE7+jYSofzefcx8Jbh6FwcngSqjRezqL0u5wC99YBHm/0URLwnJ5GOUvO8L
         X70oLY3FLQqv7+f4YHJyLcEG7IwfslO7QLzZwTcQvRmcoUsuHixJcZeWjeb7eRbXwdI/
         5ZBcbo49aH8sq/MrUWY/qgB0TIKRuA+SZlLSVPT0T5fkJ3gbjb/YvrQ64o52/6a9qKSr
         3M/Ok+ImcT5TJ0+zdayx1idH43Uayq19a8cxGCLbzToy+XJlTWVrl1Oi35aqiCrampUU
         SZ/fsqaGInzPx3Q7x/ggWzlNGjy+yn72c9Jappa8KSx3o8jcnJK1eCevUKGigd2e/SsE
         nI2Q==
X-Gm-Message-State: AOAM533NUMeqJgXtw+w2TAI8w/Dw4KVbc53lH6nI04adIgIbIakNGTTy
        VLyPDxAOvU9eDe3tQd6I8EZBEg==
X-Google-Smtp-Source: ABdhPJxR4JUPxaCFOFaKVD44GWmxbqkq9wdRYPBZr+hdrGwqSZmTDj3ddUwrYKn6CslRlKCDPKlyww==
X-Received: by 2002:a17:90a:6983:: with SMTP id s3mr638857pjj.55.1594833312949;
        Wed, 15 Jul 2020 10:15:12 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a2sm2780497pgf.53.2020.07.15.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 10:15:12 -0700 (PDT)
Date:   Wed, 15 Jul 2020 11:15:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 00/22] Enhance VHOST to enable SoC-to-SoC
 communication
Message-ID: <20200715171509.GA3185776@xps15>
References: <20200702082143.25259-1-kishon@ti.com>
 <20200702055026-mutt-send-email-mst@kernel.org>
 <603970f5-3289-cd53-82a9-aa62b292c552@redhat.com>
 <14c6cad7-9361-7fa4-e1c6-715ccc7e5f6b@ti.com>
 <59fd6a0b-8566-44b7-3dae-bb52b468219b@redhat.com>
 <ce9eb6a5-cd3a-a390-5684-525827b30f64@ti.com>
 <da2b671c-b05d-a57f-7bdf-8b1043a41240@redhat.com>
 <fee8a0fb-f862-03bd-5ede-8f105b6af529@ti.com>
 <b2178e1d-2f5c-e8a3-72fb-70f2f8d6aa45@redhat.com>
 <45a8a97c-2061-13ee-5da8-9877a4a3b8aa@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45a8a97c-2061-13ee-5da8-9877a4a3b8aa@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey Kishon,

On Wed, Jul 08, 2020 at 06:43:45PM +0530, Kishon Vijay Abraham I wrote:
> Hi Jason,
> 
> On 7/8/2020 4:52 PM, Jason Wang wrote:
> > 
> > On 2020/7/7 下午10:45, Kishon Vijay Abraham I wrote:
> >> Hi Jason,
> >>
> >> On 7/7/2020 3:17 PM, Jason Wang wrote:
> >>> On 2020/7/6 下午5:32, Kishon Vijay Abraham I wrote:
> >>>> Hi Jason,
> >>>>
> >>>> On 7/3/2020 12:46 PM, Jason Wang wrote:
> >>>>> On 2020/7/2 下午9:35, Kishon Vijay Abraham I wrote:
> >>>>>> Hi Jason,
> >>>>>>
> >>>>>> On 7/2/2020 3:40 PM, Jason Wang wrote:
> >>>>>>> On 2020/7/2 下午5:51, Michael S. Tsirkin wrote:
> >>>>>>>> On Thu, Jul 02, 2020 at 01:51:21PM +0530, Kishon Vijay Abraham I wrote:
> >>>>>>>>> This series enhances Linux Vhost support to enable SoC-to-SoC
> >>>>>>>>> communication over MMIO. This series enables rpmsg communication between
> >>>>>>>>> two SoCs using both PCIe RC<->EP and HOST1-NTB-HOST2
> >>>>>>>>>
> >>>>>>>>> 1) Modify vhost to use standard Linux driver model
> >>>>>>>>> 2) Add support in vring to access virtqueue over MMIO
> >>>>>>>>> 3) Add vhost client driver for rpmsg
> >>>>>>>>> 4) Add PCIe RC driver (uses virtio) and PCIe EP driver (uses vhost) for
> >>>>>>>>>        rpmsg communication between two SoCs connected to each other
> >>>>>>>>> 5) Add NTB Virtio driver and NTB Vhost driver for rpmsg communication
> >>>>>>>>>        between two SoCs connected via NTB
> >>>>>>>>> 6) Add configfs to configure the components
> >>>>>>>>>
> >>>>>>>>> UseCase1 :
> >>>>>>>>>
> >>>>>>>>>      VHOST RPMSG                     VIRTIO RPMSG
> >>>>>>>>>           +                               +
> >>>>>>>>>           |                               |
> >>>>>>>>>           |                               |
> >>>>>>>>>           |                               |
> >>>>>>>>>           |                               |
> >>>>>>>>> +-----v------+                 +------v-------+
> >>>>>>>>> |   Linux    |                 |     Linux    |
> >>>>>>>>> |  Endpoint  |                 | Root Complex |
> >>>>>>>>> |            <----------------->              |
> >>>>>>>>> |            |                 |              |
> >>>>>>>>> |    SOC1    |                 |     SOC2     |
> >>>>>>>>> +------------+                 +--------------+
> >>>>>>>>>
> >>>>>>>>> UseCase 2:
> >>>>>>>>>
> >>>>>>>>>          VHOST RPMSG                                      VIRTIO RPMSG
> >>>>>>>>>               +                                                 +
> >>>>>>>>>               |                                                 |
> >>>>>>>>>               |                                                 |
> >>>>>>>>>               |                                                 |
> >>>>>>>>>               |                                                 |
> >>>>>>>>>        +------v------+                                   +------v------+
> >>>>>>>>>        |             |                                   |             |
> >>>>>>>>>        |    HOST1    |                                   |    HOST2    |
> >>>>>>>>>        |             |                                   |             |
> >>>>>>>>>        +------^------+                                   +------^------+
> >>>>>>>>>               |                                                 |
> >>>>>>>>>               |                                                 |
> >>>>>>>>> +---------------------------------------------------------------------+
> >>>>>>>>> |  +------v------+                                   +------v------+  |
> >>>>>>>>> |  |             |                                   |             |  |
> >>>>>>>>> |  |     EP      |                                   |     EP      |  |
> >>>>>>>>> |  | CONTROLLER1 |                                   | CONTROLLER2 |  |
> >>>>>>>>> |  |             <----------------------------------->             |  |
> >>>>>>>>> |  |             |                                   |             |  |
> >>>>>>>>> |  |             |                                   |             |  |
> >>>>>>>>> |  |             |  SoC With Multiple EP Instances   |             |  |
> >>>>>>>>> |  |             |  (Configured using NTB Function)  |             |  |
> >>>>>>>>> |  +-------------+                                   +-------------+  |
> >>>>>>>>> +---------------------------------------------------------------------+
> >>>>>>>>>
> >>>>>>>>> Software Layering:
> >>>>>>>>>
> >>>>>>>>> The high-level SW layering should look something like below. This series
> >>>>>>>>> adds support only for RPMSG VHOST, however something similar should be
> >>>>>>>>> done for net and scsi. With that any vhost device (PCI, NTB, Platform
> >>>>>>>>> device, user) can use any of the vhost client driver.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>         +----------------+  +-----------+  +------------+  +----------+
> >>>>>>>>>         |  RPMSG VHOST   |  | NET VHOST |  | SCSI VHOST |  |    X     |
> >>>>>>>>>         +-------^--------+  +-----^-----+  +-----^------+  +----^-----+
> >>>>>>>>>                 |                 |              |              |
> >>>>>>>>>                 |                 |              |              |
> >>>>>>>>>                 |                 |              |              |
> >>>>>>>>> +-----------v-----------------v--------------v--------------v----------+
> >>>>>>>>> |                            VHOST CORE                                |
> >>>>>>>>> +--------^---------------^--------------------^------------------^-----+
> >>>>>>>>>              |               |                    |                  |
> >>>>>>>>>              |               |                    |                  |
> >>>>>>>>>              |               |                    |                  |
> >>>>>>>>> +--------v-------+  +----v------+  +----------v----------+  +----v-----+
> >>>>>>>>> |  PCI EPF VHOST |  | NTB VHOST |  |PLATFORM DEVICE VHOST|  |    X     |
> >>>>>>>>> +----------------+  +-----------+  +---------------------+  +----------+
> >>>>>>>>>
> >>>>>>>>> This was initially proposed here [1]
> >>>>>>>>>
> >>>>>>>>> [1] ->
> >>>>>>>>> https://lore.kernel.org/r/2cf00ec4-1ed6-f66e-6897-006d1a5b6390@ti.com
> >>>>>>>> I find this very interesting. A huge patchset so will take a bit
> >>>>>>>> to review, but I certainly plan to do that. Thanks!
> >>>>>>> Yes, it would be better if there's a git branch for us to have a look.
> >>>>>> I've pushed the branch
> >>>>>> https://github.com/kishon/linux-wip.git vhost_rpmsg_pci_ntb_rfc
> >>>>> Thanks
> >>>>>
> >>>>>
> >>>>>>> Btw, I'm not sure I get the big picture, but I vaguely feel some of the
> >>>>>>> work is
> >>>>>>> duplicated with vDPA (e.g the epf transport or vhost bus).
> >>>>>> This is about connecting two different HW systems both running Linux and
> >>>>>> doesn't necessarily involve virtualization.
> >>>>> Right, this is something similar to VOP
> >>>>> (Documentation/misc-devices/mic/mic_overview.rst). The different is the
> >>>>> hardware I guess and VOP use userspace application to implement the device.
> >>>> I'd also like to point out, this series tries to have communication between
> >>>> two
> >>>> SoCs in vendor agnostic way. Since this series solves for 2 usecases (PCIe
> >>>> RC<->EP and NTB), for the NTB case it directly plugs into NTB framework and
> >>>> any
> >>>> of the HW in NTB below should be able to use a virtio-vhost communication
> >>>>
> >>>> #ls drivers/ntb/hw/
> >>>> amd  epf  idt  intel  mscc
> >>>>
> >>>> And similarly for the PCIe RC<->EP communication, this adds a generic endpoint
> >>>> function driver and hence any SoC that supports configurable PCIe endpoint can
> >>>> use virtio-vhost communication
> >>>>
> >>>> # ls drivers/pci/controller/dwc/*ep*
> >>>> drivers/pci/controller/dwc/pcie-designware-ep.c
> >>>> drivers/pci/controller/dwc/pcie-uniphier-ep.c
> >>>> drivers/pci/controller/dwc/pci-layerscape-ep.c
> >>>
> >>> Thanks for those backgrounds.
> >>>
> >>>
> >>>>>>     So there is no guest or host as in
> >>>>>> virtualization but two entirely different systems connected via PCIe cable,
> >>>>>> one
> >>>>>> acting as guest and one as host. So one system will provide virtio
> >>>>>> functionality reserving memory for virtqueues and the other provides vhost
> >>>>>> functionality providing a way to access the virtqueues in virtio memory.
> >>>>>> One is
> >>>>>> source and the other is sink and there is no intermediate entity. (vhost was
> >>>>>> probably intermediate entity in virtualization?)
> >>>>> (Not a native English speaker) but "vhost" could introduce some confusion for
> >>>>> me since it was use for implementing virtio backend for userspace drivers. I
> >>>>> guess "vringh" could be better.
> >>>> Initially I had named this vringh but later decided to choose vhost instead of
> >>>> vringh. vhost is still a virtio backend (not necessarily userspace) though it
> >>>> now resides in an entirely different system. Whatever virtio is for a frontend
> >>>> system, vhost can be that for a backend system. vring can be for accessing
> >>>> virtqueue and can be used either in frontend or backend.
> >>>
> >>> Ok.
> >>>
> >>>
> >>>>>>> Have you considered to implement these through vDPA?
> >>>>>> IIUC vDPA only provides an interface to userspace and an in-kernel rpmsg
> >>>>>> driver
> >>>>>> or vhost net driver is not provided.
> >>>>>>
> >>>>>> The HW connection looks something like https://pasteboard.co/JfMVVHC.jpg
> >>>>>> (usecase2 above),
> >>>>> I see.
> >>>>>
> >>>>>
> >>>>>>     all the boards run Linux. The middle board provides NTB
> >>>>>> functionality and board on either side provides virtio/vhost
> >>>>>> functionality and
> >>>>>> transfer data using rpmsg.
> >>>>> So I wonder whether it's worthwhile for a new bus. Can we use the existed
> >>>>> virtio-bus/drivers? It might work as, except for the epf transport, we can
> >>>>> introduce a epf "vhost" transport driver.
> >>>> IMHO we'll need two buses one for frontend and other for backend because the
> >>>> two components can then co-operate/interact with each other to provide a
> >>>> functionality. Though both will seemingly provide similar callbacks, they are
> >>>> both provide symmetrical or complimentary funcitonality and need not be
> >>>> same or
> >>>> identical.
> >>>>
> >>>> Having the same bus can also create sequencing issues.
> >>>>
> >>>> If you look at virtio_dev_probe() of virtio_bus
> >>>>
> >>>> device_features = dev->config->get_features(dev);
> >>>>
> >>>> Now if we use same bus for both front-end and back-end, both will try to
> >>>> get_features when there has been no set_features. Ideally vhost device should
> >>>> be initialized first with the set of features it supports. Vhost and virtio
> >>>> should use "status" and "features" complimentarily and not identically.
> >>>
> >>> Yes, but there's no need for doing status/features passthrough in epf vhost
> >>> drivers.b
> >>>
> >>>
> >>>> virtio device (or frontend) cannot be initialized before vhost device (or
> >>>> backend) gets initialized with data such as features. Similarly vhost
> >>>> (backend)
> >>>> cannot access virqueues or buffers before virtio (frontend) sets
> >>>> VIRTIO_CONFIG_S_DRIVER_OK whereas that requirement is not there for virtio as
> >>>> the physical memory for virtqueues are created by virtio (frontend).
> >>>
> >>> epf vhost drivers need to implement two devices: vhost(vringh) device and
> >>> virtio device (which is a mediated device). The vhost(vringh) device is doing
> >>> feature negotiation with the virtio device via RC/EP or NTB. The virtio device
> >>> is doing feature negotiation with local virtio drivers. If there're feature
> >>> mismatch, epf vhost drivers and do mediation between them.
> >> Here epf vhost should be initialized with a set of features for it to negotiate
> >> either as vhost device or virtio device no? Where should the initial feature
> >> set for epf vhost come from?
> > 
> > 
> > I think it can work as:
> > 
> > 1) Having an initial features (hard coded in the code) set X in epf vhost
> > 2) Using this X for both virtio device and vhost(vringh) device
> > 3) local virtio driver will negotiate with virtio device with feature set Y
> > 4) remote virtio driver will negotiate with vringh device with feature set Z
> > 5) mediate between feature Y and feature Z since both Y and Z are a subset of X
> > 
> > 
> 
> okay. I'm also thinking if we could have configfs for configuring this. Anyways
> we could find different approaches of configuring this.
> >>>
> >>>>> It will have virtqueues but only used for the communication between itself
> >>>>> and
> >>>>> uppter virtio driver. And it will have vringh queues which will be probe by
> >>>>> virtio epf transport drivers. And it needs to do datacopy between
> >>>>> virtqueue and
> >>>>> vringh queues.
> >>>>>
> >>>>> It works like:
> >>>>>
> >>>>> virtio drivers <- virtqueue/virtio-bus -> epf vhost drivers <- vringh
> >>>>> queue/epf>
> >>>>>
> >>>>> The advantages is that there's no need for writing new buses and drivers.
> >>>> I think this will work however there is an addtional copy between vringh queue
> >>>> and virtqueue,
> >>>
> >>> I think not? E.g in use case 1), if we stick to virtio bus, we will have:
> >>>
> >>> virtio-rpmsg (EP) <- virtio ring(1) -> epf vhost driver (EP) <- virtio ring(2)
> >>> -> virtio pci (RC) <-> virtio rpmsg (RC)
> >> IIUC epf vhost driver (EP) will access virtio ring(2) using vringh?
> > 
> > 
> > Yes.
> > 
> > 
> >> And virtio
> >> ring(2) is created by virtio pci (RC).
> > 
> > 
> > Yes.
> > 
> > 
> >>> What epf vhost driver did is to read from virtio ring(1) about the buffer len
> >>> and addr and them DMA to Linux(RC)?
> >> okay, I made some optimization here where vhost-rpmsg using a helper writes a
> >> buffer from rpmsg's upper layer directly to remote Linux (RC) as against here
> >> were it has to be first written to virtio ring (1).
> >>
> >> Thinking how this would look for NTB
> >> virtio-rpmsg (HOST1) <- virtio ring(1) -> NTB(HOST1) <-> NTB(HOST2)  <- virtio
> >> ring(2) -> virtio-rpmsg (HOST2)
> >>
> >> Here the NTB(HOST1) will access the virtio ring(2) using vringh?
> > 
> > 
> > Yes, I think so it needs to use vring to access virtio ring (1) as well.
> 
> NTB(HOST1) and virtio ring(1) will be in the same system. So it doesn't have to
> use vring. virtio ring(1) is by the virtio device the NTB(HOST1) creates.
> > 
> > 
> >>
> >> Do you also think this will work seamlessly with virtio_net.c, virtio_blk.c?
> > 
> > 
> > Yes.
> 
> okay, I haven't looked at this but the backend of virtio_blk should access an
> actual storage device no?
> > 
> > 
> >>
> >> I'd like to get clarity on two things in the approach you suggested, one is
> >> features (since epf vhost should ideally be transparent to any virtio driver)
> > 
> > 
> > We can have have an array of pre-defined features indexed by virtio device id
> > in the code.
> > 
> > 
> >> and the other is how certain inputs to virtio device such as number of buffers
> >> be determined.
> > 
> > 
> > We can start from hard coded the value like 256, or introduce some API for user
> > to change the value.
> > 
> > 
> >>
> >> Thanks again for your suggestions!
> > 
> > 
> > You're welcome.
> > 
> > Note that I just want to check whether or not we can reuse the virtio
> > bus/driver. It's something similar to what you proposed in Software Layering
> > but we just replace "vhost core" with "virtio bus" and move the vhost core
> > below epf/ntb/platform transport.
> 
> Got it. My initial design was based on my understanding of your comments [1].
> 
> I'll try to create something based on your proposed design here.

Based on the above conversation it seems like I should wait for another revision
of this set before reviewing the RPMSG part.  Please confirm that my
understanding is correct.

Thanks,
Mathieu

> 
> Regards
> Kishon
> 
> [1] ->
> https://lore.kernel.org/linux-pci/59982499-0fc1-2e39-9ff9-993fb4dd7dcc@redhat.com/
> > 
> > Thanks
> > 
> > 
> >>
> >> Regards
> >> Kishon
> >>
> >>>
> >>>> in some cases adds latency because of forwarding interrupts
> >>>> between vhost and virtio driver, vhost drivers providing features (which means
> >>>> it has to be aware of which virtio driver will be connected).
> >>>> virtio drivers (front end) generally access the buffers from it's local memory
> >>>> but when in backend it can access over MMIO (like PCI EPF or NTB) or
> >>>> userspace.
> >>>>> Does this make sense?
> >>>> Two copies in my opinion is an issue but lets get others opinions as well.
> >>>
> >>> Sure.
> >>>
> >>>
> >>>> Thanks for your suggestions!
> >>>
> >>> You're welcome.
> >>>
> >>> Thanks
> >>>
> >>>
> >>>> Regards
> >>>> Kishon
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>
> >>>>>> Thanks
> >>>>>> Kishon
> >>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>
> >>>>>>>>> Kishon Vijay Abraham I (22):
> >>>>>>>>>       vhost: Make _feature_ bits a property of vhost device
> >>>>>>>>>       vhost: Introduce standard Linux driver model in VHOST
> >>>>>>>>>       vhost: Add ops for the VHOST driver to configure VHOST device
> >>>>>>>>>       vringh: Add helpers to access vring in MMIO
> >>>>>>>>>       vhost: Add MMIO helpers for operations on vhost virtqueue
> >>>>>>>>>       vhost: Introduce configfs entry for configuring VHOST
> >>>>>>>>>       virtio_pci: Use request_threaded_irq() instead of request_irq()
> >>>>>>>>>       rpmsg: virtio_rpmsg_bus: Disable receive virtqueue callback when
> >>>>>>>>>         reading messages
> >>>>>>>>>       rpmsg: Introduce configfs entry for configuring rpmsg
> >>>>>>>>>       rpmsg: virtio_rpmsg_bus: Add Address Service Notification support
> >>>>>>>>>       rpmsg: virtio_rpmsg_bus: Move generic rpmsg structure to
> >>>>>>>>>         rpmsg_internal.h
> >>>>>>>>>       virtio: Add ops to allocate and free buffer
> >>>>>>>>>       rpmsg: virtio_rpmsg_bus: Use virtio_alloc_buffer() and
> >>>>>>>>>         virtio_free_buffer()
> >>>>>>>>>       rpmsg: Add VHOST based remote processor messaging bus
> >>>>>>>>>       samples/rpmsg: Setup delayed work to send message
> >>>>>>>>>       samples/rpmsg: Wait for address to be bound to rpdev for sending
> >>>>>>>>>         message
> >>>>>>>>>       rpmsg.txt: Add Documentation to configure rpmsg using configfs
> >>>>>>>>>       virtio_pci: Add VIRTIO driver for VHOST on Configurable PCIe
> >>>>>>>>> Endpoint
> >>>>>>>>>         device
> >>>>>>>>>       PCI: endpoint: Add EP function driver to provide VHOST interface
> >>>>>>>>>       NTB: Add a new NTB client driver to implement VIRTIO functionality
> >>>>>>>>>       NTB: Add a new NTB client driver to implement VHOST functionality
> >>>>>>>>>       NTB: Describe the ntb_virtio and ntb_vhost client in the
> >>>>>>>>> documentation
> >>>>>>>>>
> >>>>>>>>>      Documentation/driver-api/ntb.rst              |   11 +
> >>>>>>>>>      Documentation/rpmsg.txt                       |   56 +
> >>>>>>>>>      drivers/ntb/Kconfig                           |   18 +
> >>>>>>>>>      drivers/ntb/Makefile                          |    2 +
> >>>>>>>>>      drivers/ntb/ntb_vhost.c                       |  776 +++++++++++
> >>>>>>>>>      drivers/ntb/ntb_virtio.c                      |  853 ++++++++++++
> >>>>>>>>>      drivers/ntb/ntb_virtio.h                      |   56 +
> >>>>>>>>>      drivers/pci/endpoint/functions/Kconfig        |   11 +
> >>>>>>>>>      drivers/pci/endpoint/functions/Makefile       |    1 +
> >>>>>>>>>      .../pci/endpoint/functions/pci-epf-vhost.c    | 1144
> >>>>>>>>> ++++++++++++++++
> >>>>>>>>>      drivers/rpmsg/Kconfig                         |   10 +
> >>>>>>>>>      drivers/rpmsg/Makefile                        |    3 +-
> >>>>>>>>>      drivers/rpmsg/rpmsg_cfs.c                     |  394 ++++++
> >>>>>>>>>      drivers/rpmsg/rpmsg_core.c                    |    7 +
> >>>>>>>>>      drivers/rpmsg/rpmsg_internal.h                |  136 ++
> >>>>>>>>>      drivers/rpmsg/vhost_rpmsg_bus.c               | 1151
> >>>>>>>>> +++++++++++++++++
> >>>>>>>>>      drivers/rpmsg/virtio_rpmsg_bus.c              |  184 ++-
> >>>>>>>>>      drivers/vhost/Kconfig                         |    1 +
> >>>>>>>>>      drivers/vhost/Makefile                        |    2 +-
> >>>>>>>>>      drivers/vhost/net.c                           |   10 +-
> >>>>>>>>>      drivers/vhost/scsi.c                          |   24 +-
> >>>>>>>>>      drivers/vhost/test.c                          |   17 +-
> >>>>>>>>>      drivers/vhost/vdpa.c                          |    2 +-
> >>>>>>>>>      drivers/vhost/vhost.c                         |  730 ++++++++++-
> >>>>>>>>>      drivers/vhost/vhost_cfs.c                     |  341 +++++
> >>>>>>>>>      drivers/vhost/vringh.c                        |  332 +++++
> >>>>>>>>>      drivers/vhost/vsock.c                         |   20 +-
> >>>>>>>>>      drivers/virtio/Kconfig                        |    9 +
> >>>>>>>>>      drivers/virtio/Makefile                       |    1 +
> >>>>>>>>>      drivers/virtio/virtio_pci_common.c            |   25 +-
> >>>>>>>>>      drivers/virtio/virtio_pci_epf.c               |  670 ++++++++++
> >>>>>>>>>      include/linux/mod_devicetable.h               |    6 +
> >>>>>>>>>      include/linux/rpmsg.h                         |    6 +
> >>>>>>>>>      {drivers/vhost => include/linux}/vhost.h      |  132 +-
> >>>>>>>>>      include/linux/virtio.h                        |    3 +
> >>>>>>>>>      include/linux/virtio_config.h                 |   42 +
> >>>>>>>>>      include/linux/vringh.h                        |   46 +
> >>>>>>>>>      samples/rpmsg/rpmsg_client_sample.c           |   32 +-
> >>>>>>>>>      tools/virtio/virtio_test.c                    |    2 +-
> >>>>>>>>>      39 files changed, 7083 insertions(+), 183 deletions(-)
> >>>>>>>>>      create mode 100644 drivers/ntb/ntb_vhost.c
> >>>>>>>>>      create mode 100644 drivers/ntb/ntb_virtio.c
> >>>>>>>>>      create mode 100644 drivers/ntb/ntb_virtio.h
> >>>>>>>>>      create mode 100644 drivers/pci/endpoint/functions/pci-epf-vhost.c
> >>>>>>>>>      create mode 100644 drivers/rpmsg/rpmsg_cfs.c
> >>>>>>>>>      create mode 100644 drivers/rpmsg/vhost_rpmsg_bus.c
> >>>>>>>>>      create mode 100644 drivers/vhost/vhost_cfs.c
> >>>>>>>>>      create mode 100644 drivers/virtio/virtio_pci_epf.c
> >>>>>>>>>      rename {drivers/vhost => include/linux}/vhost.h (66%)
> >>>>>>>>>
> >>>>>>>>> -- 
> >>>>>>>>> 2.17.1
> >>>>>>>>>
> > 
