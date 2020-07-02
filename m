Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7189212B4B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgGBRbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgGBRbf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2020 13:31:35 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262FC08C5E0
        for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2020 10:31:34 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v8so29659684iox.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2020 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qS9aKixWg8M2HwkRwLxIhre1iwIBiL08luFNH178zko=;
        b=dlardQB2kRCLmJxUeHCCJ1I//DtST1JMzmk2zK2iYoauEZmj8YlzMayYjIs8nTaonS
         etg4Ag4rCqNDLBYKFt2YxlJ7IsVmzeOEMu7xoCYebrrw/y9piCzD7+NrUIKt0Q/3l1UT
         etQxxjV7IZ0iyC3qlWPNbBYh0mW28oml8cxYs6Kk3y4qDW/U1PsEGy5y3E8sFzC0EY0Q
         Qb4GgY6BdqGv5MT61oqVVem0THpeS3KdnPmEKSeTGFRLV6076ASt+Ts3Sc5XHNA177VE
         lj1Siv1c6nDNc06rawhTBbQpydFWRRhZsu2BedcpPsSsVW1t5HZRKlufOzdJzYGTbUak
         5Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qS9aKixWg8M2HwkRwLxIhre1iwIBiL08luFNH178zko=;
        b=dSO/gwftkVxyIt5MDWPVQgjVgYp6LUZGSiCpirGnAtE9A0/Pcn1yl0LRxOJSK1YidW
         7Iw8HycI28OoqYJj8FrtYOcVDnohL6T0lo14gf3oEd7kw+Imh0QeihKLX8uBWZHWX/az
         bM3gXsxUdopALVhZL0NL2BtcLMl/Os5SliP7AhM/cAKIP0K8Dz3x9JQysmb0nIh+Wyjm
         uGjleK0TXf4Zgy9LFmt6YOp8DBXITP/H/NuQSNBuPuxk3mx7l/oCDX9FI6Cs+YqoYq06
         obEHfE5HimuAoxWYLZqnQyNSOSaTojbwmBuyc7UkFaG1bCcp1o3H++JkVTLzMvaw0TIx
         JuTQ==
X-Gm-Message-State: AOAM530IJrX1eiz6fM5QxXIEEn6oD3msesZgaH9GdCVG6RTdqS510Smh
        79e9Ac0+vPqgR3NejOGIPOTjcdAabT7yRucPMCO/og==
X-Google-Smtp-Source: ABdhPJzLKR5y/4qxmdCN5zOuywjt8u2E+3dsyGdmjEwUOvRQTg/hQElVu0bbAUkE1Z5HPhVEQOaIOwv1coyY7vNqIl8=
X-Received: by 2002:a02:7f89:: with SMTP id r131mr34382094jac.98.1593711094007;
 Thu, 02 Jul 2020 10:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200702082143.25259-1-kishon@ti.com> <20200702055026-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200702055026-mutt-send-email-mst@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 2 Jul 2020 11:31:23 -0600
Message-ID: <CANLsYky4ZrgYGZUyg4iVwbM3TQk5dvOSBwPFER8qofixjn4vyA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] Enhance VHOST to enable SoC-to-SoC communication
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2 Jul 2020 at 03:51, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 02, 2020 at 01:51:21PM +0530, Kishon Vijay Abraham I wrote:
> > This series enhances Linux Vhost support to enable SoC-to-SoC
> > communication over MMIO. This series enables rpmsg communication between
> > two SoCs using both PCIe RC<->EP and HOST1-NTB-HOST2
> >
> > 1) Modify vhost to use standard Linux driver model
> > 2) Add support in vring to access virtqueue over MMIO
> > 3) Add vhost client driver for rpmsg
> > 4) Add PCIe RC driver (uses virtio) and PCIe EP driver (uses vhost) for
> >    rpmsg communication between two SoCs connected to each other
> > 5) Add NTB Virtio driver and NTB Vhost driver for rpmsg communication
> >    between two SoCs connected via NTB
> > 6) Add configfs to configure the components
> >
> > UseCase1 :
> >
> >  VHOST RPMSG                     VIRTIO RPMSG
> >       +                               +
> >       |                               |
> >       |                               |
> >       |                               |
> >       |                               |
> > +-----v------+                 +------v-------+
> > |   Linux    |                 |     Linux    |
> > |  Endpoint  |                 | Root Complex |
> > |            <----------------->              |
> > |            |                 |              |
> > |    SOC1    |                 |     SOC2     |
> > +------------+                 +--------------+
> >
> > UseCase 2:
> >
> >      VHOST RPMSG                                      VIRTIO RPMSG
> >           +                                                 +
> >           |                                                 |
> >           |                                                 |
> >           |                                                 |
> >           |                                                 |
> >    +------v------+                                   +------v------+
> >    |             |                                   |             |
> >    |    HOST1    |                                   |    HOST2    |
> >    |             |                                   |             |
> >    +------^------+                                   +------^------+
> >           |                                                 |
> >           |                                                 |
> > +---------------------------------------------------------------------+
> > |  +------v------+                                   +------v------+  |
> > |  |             |                                   |             |  |
> > |  |     EP      |                                   |     EP      |  |
> > |  | CONTROLLER1 |                                   | CONTROLLER2 |  |
> > |  |             <----------------------------------->             |  |
> > |  |             |                                   |             |  |
> > |  |             |                                   |             |  |
> > |  |             |  SoC With Multiple EP Instances   |             |  |
> > |  |             |  (Configured using NTB Function)  |             |  |
> > |  +-------------+                                   +-------------+  |
> > +---------------------------------------------------------------------+
> >
> > Software Layering:
> >
> > The high-level SW layering should look something like below. This series
> > adds support only for RPMSG VHOST, however something similar should be
> > done for net and scsi. With that any vhost device (PCI, NTB, Platform
> > device, user) can use any of the vhost client driver.
> >
> >
> >     +----------------+  +-----------+  +------------+  +----------+
> >     |  RPMSG VHOST   |  | NET VHOST |  | SCSI VHOST |  |    X     |
> >     +-------^--------+  +-----^-----+  +-----^------+  +----^-----+
> >             |                 |              |              |
> >             |                 |              |              |
> >             |                 |              |              |
> > +-----------v-----------------v--------------v--------------v----------+
> > |                            VHOST CORE                                |
> > +--------^---------------^--------------------^------------------^-----+
> >          |               |                    |                  |
> >          |               |                    |                  |
> >          |               |                    |                  |
> > +--------v-------+  +----v------+  +----------v----------+  +----v-----+
> > |  PCI EPF VHOST |  | NTB VHOST |  |PLATFORM DEVICE VHOST|  |    X     |
> > +----------------+  +-----------+  +---------------------+  +----------+
> >
> > This was initially proposed here [1]
> >
> > [1] -> https://lore.kernel.org/r/2cf00ec4-1ed6-f66e-6897-006d1a5b6390@ti.com
>
>
> I find this very interesting. A huge patchset so will take a bit
> to review, but I certainly plan to do that. Thanks!

Same here - it will take time.  This patchset is sizable and sits
behind a few others that are equally big.

>
> >
> > Kishon Vijay Abraham I (22):
> >   vhost: Make _feature_ bits a property of vhost device
> >   vhost: Introduce standard Linux driver model in VHOST
> >   vhost: Add ops for the VHOST driver to configure VHOST device
> >   vringh: Add helpers to access vring in MMIO
> >   vhost: Add MMIO helpers for operations on vhost virtqueue
> >   vhost: Introduce configfs entry for configuring VHOST
> >   virtio_pci: Use request_threaded_irq() instead of request_irq()
> >   rpmsg: virtio_rpmsg_bus: Disable receive virtqueue callback when
> >     reading messages
> >   rpmsg: Introduce configfs entry for configuring rpmsg
> >   rpmsg: virtio_rpmsg_bus: Add Address Service Notification support
> >   rpmsg: virtio_rpmsg_bus: Move generic rpmsg structure to
> >     rpmsg_internal.h
> >   virtio: Add ops to allocate and free buffer
> >   rpmsg: virtio_rpmsg_bus: Use virtio_alloc_buffer() and
> >     virtio_free_buffer()
> >   rpmsg: Add VHOST based remote processor messaging bus
> >   samples/rpmsg: Setup delayed work to send message
> >   samples/rpmsg: Wait for address to be bound to rpdev for sending
> >     message
> >   rpmsg.txt: Add Documentation to configure rpmsg using configfs
> >   virtio_pci: Add VIRTIO driver for VHOST on Configurable PCIe Endpoint
> >     device
> >   PCI: endpoint: Add EP function driver to provide VHOST interface
> >   NTB: Add a new NTB client driver to implement VIRTIO functionality
> >   NTB: Add a new NTB client driver to implement VHOST functionality
> >   NTB: Describe the ntb_virtio and ntb_vhost client in the documentation
> >
> >  Documentation/driver-api/ntb.rst              |   11 +
> >  Documentation/rpmsg.txt                       |   56 +
> >  drivers/ntb/Kconfig                           |   18 +
> >  drivers/ntb/Makefile                          |    2 +
> >  drivers/ntb/ntb_vhost.c                       |  776 +++++++++++
> >  drivers/ntb/ntb_virtio.c                      |  853 ++++++++++++
> >  drivers/ntb/ntb_virtio.h                      |   56 +
> >  drivers/pci/endpoint/functions/Kconfig        |   11 +
> >  drivers/pci/endpoint/functions/Makefile       |    1 +
> >  .../pci/endpoint/functions/pci-epf-vhost.c    | 1144 ++++++++++++++++
> >  drivers/rpmsg/Kconfig                         |   10 +
> >  drivers/rpmsg/Makefile                        |    3 +-
> >  drivers/rpmsg/rpmsg_cfs.c                     |  394 ++++++
> >  drivers/rpmsg/rpmsg_core.c                    |    7 +
> >  drivers/rpmsg/rpmsg_internal.h                |  136 ++
> >  drivers/rpmsg/vhost_rpmsg_bus.c               | 1151 +++++++++++++++++
> >  drivers/rpmsg/virtio_rpmsg_bus.c              |  184 ++-
> >  drivers/vhost/Kconfig                         |    1 +
> >  drivers/vhost/Makefile                        |    2 +-
> >  drivers/vhost/net.c                           |   10 +-
> >  drivers/vhost/scsi.c                          |   24 +-
> >  drivers/vhost/test.c                          |   17 +-
> >  drivers/vhost/vdpa.c                          |    2 +-
> >  drivers/vhost/vhost.c                         |  730 ++++++++++-
> >  drivers/vhost/vhost_cfs.c                     |  341 +++++
> >  drivers/vhost/vringh.c                        |  332 +++++
> >  drivers/vhost/vsock.c                         |   20 +-
> >  drivers/virtio/Kconfig                        |    9 +
> >  drivers/virtio/Makefile                       |    1 +
> >  drivers/virtio/virtio_pci_common.c            |   25 +-
> >  drivers/virtio/virtio_pci_epf.c               |  670 ++++++++++
> >  include/linux/mod_devicetable.h               |    6 +
> >  include/linux/rpmsg.h                         |    6 +
> >  {drivers/vhost => include/linux}/vhost.h      |  132 +-
> >  include/linux/virtio.h                        |    3 +
> >  include/linux/virtio_config.h                 |   42 +
> >  include/linux/vringh.h                        |   46 +
> >  samples/rpmsg/rpmsg_client_sample.c           |   32 +-
> >  tools/virtio/virtio_test.c                    |    2 +-
> >  39 files changed, 7083 insertions(+), 183 deletions(-)
> >  create mode 100644 drivers/ntb/ntb_vhost.c
> >  create mode 100644 drivers/ntb/ntb_virtio.c
> >  create mode 100644 drivers/ntb/ntb_virtio.h
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vhost.c
> >  create mode 100644 drivers/rpmsg/rpmsg_cfs.c
> >  create mode 100644 drivers/rpmsg/vhost_rpmsg_bus.c
> >  create mode 100644 drivers/vhost/vhost_cfs.c
> >  create mode 100644 drivers/virtio/virtio_pci_epf.c
> >  rename {drivers/vhost => include/linux}/vhost.h (66%)
> >
> > --
> > 2.17.1
> >
>
