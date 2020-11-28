Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF92C6E3A
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 02:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgK1Bki (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Nov 2020 20:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbgK1Bhw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2020 20:37:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98044C0613D1;
        Fri, 27 Nov 2020 17:25:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a15so7473839edy.1;
        Fri, 27 Nov 2020 17:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0RRFLb72xXLsAeIn8Hmd4l+IGJ3LWkUeoLHTLTXgdI=;
        b=C4ew964K47mK/xZZwDm49IHgvywyguRSUMzrqWp7vfzykfohrW7kLWaQAjSJ9Hi/HD
         t/7Imdd695+PuBDIArTZbl4eNMuHd+HKAX1dDmlCM44EqsJXwbP2zug+tRxeqt9UzWfE
         OBZxHvhEW9pvpXvUDuy2fnob5KuvxCfP7f7ETYfD31WF4OufPaqHhCeeUqfvjsx7ticz
         lsPRF8weENKbRv1FMsgxRCid+40s10GUvAOwWc7+sVGXVA5KjdHsI3xi2B7gTEcbz3xD
         c5wi4nxfF6vk+Y0Dfmk6VhhrMj6QQhwPl4OJaF8vIN044VTashjeNe0JF+PIarNq+wQk
         +PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0RRFLb72xXLsAeIn8Hmd4l+IGJ3LWkUeoLHTLTXgdI=;
        b=DVFe/9hS7wu78HBRVgEopDThsXdMfTtCnkliQd9BavayI4RJOhzHkGtBr9ixISxATP
         NudT7zlEApxVnvozORptfRTtTHLHUKAWq8EQ4NYHjXZ5Rf2RhXrZ7DzaIg7tl96r2NSc
         RMPs8WVJg045mm6sEheRWyB6/QWWVwxIGYzx1ntIWo8Lm6upkOFPVGnGC4g/0GvpKmTL
         jMm9zJ7aZWpvxMMMb/wwLjgSc5+EJiBg3FJ2i7la9fooGBnOXDEU2I/bP8VMhRdmf2sZ
         Yqn1G2EpourmUGa2ansgZbe2GicJfGYB2NnI3M3TDHWI7E73QzpBh9mw7FnatLKI6QRm
         JQGQ==
X-Gm-Message-State: AOAM531FDn5H/ozdpiFjKoE2zxGUeRbgfqwxfS6cE5gJszh8+qpNZHLR
        44e8DCozK47KQX/R9yuc62ukczrqR82rjD3GTdI=
X-Google-Smtp-Source: ABdhPJyYxBUrTocc5qlFHOYJp5Fn0LIQ9Z3sUC4D0giBNDtBijZVDYWJ4XN+lmsT1riNFl7ZjW8iFIh9QPfjV9Ns5jg=
X-Received: by 2002:aa7:d717:: with SMTP id t23mr10743820edq.286.1606526716252;
 Fri, 27 Nov 2020 17:25:16 -0800 (PST)
MIME-Version: 1.0
References: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com>
 <be031d15-201f-0e5c-8b0f-be030077141f@redhat.com> <20201124102715.GA16983@lst.de>
 <fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com> <8a52e868-0ca1-55b7-5ad2-ddb0cbb5e45d@redhat.com>
 <20201127161900.GA10986@lst.de> <fded04e2-f2e9-de92-ab1f-5aa088904e90@redhat.com>
In-Reply-To: <fded04e2-f2e9-de92-ab1f-5aa088904e90@redhat.com>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Sat, 28 Nov 2020 09:25:03 +0800
Message-ID: <CAGnHSEmyrw=r56ocLCkia+sYT0tmcCScZitBi=G+DY=gRBy+sg@mail.gmail.com>
Subject: Re: 5.10 regression caused by: "uas: fix sdev->host->dma_dev": many
 XHCI swiotlb buffer is full / DMAR: Device bounce map failed errors on
 thunderbolt connected XHCI controller
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Should we still be clamping max_sectors to dma_max_mapping_size(dev)
(for now)? with dev being us->pusb_dev->bus->sysdev and
devinfo->udev->bus->sysdev respectively (i.e. revert only
scsi_add_host_with_dma() to scsi_add_host())?

On Sat, 28 Nov 2020 at 02:12, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/27/20 5:19 PM, Christoph Hellwig wrote:
> > On Fri, Nov 27, 2020 at 01:32:16PM +0100, Hans de Goede wrote:
> >> I ran some more tests, I can confirm that reverting:
> >>
> >> 5df7ef7d32fe "uas: bump hw_max_sectors to 2048 blocks for SS or faster drives"
> >> 558033c2828f "uas: fix sdev->host->dma_dev"
> >>
> >> Makes the problem go away while running a 5.10 kernel. I also tried doubling
> >> the swiotlb size by adding: swiotlb=65536 to the kernel commandline but that
> >> does not help.
> >>
> >> Some more observations:
> >>
> >> 1. The usb-storage driver does not cause this issue, even though it has a
> >> very similar change.
> >>
> >> 2. The problem does not happen until I plug an UAS decvice into the dock.
> >>
> >> 3. The problem continues to happen even after I unplug the UAS device and
> >> rmmod the uas module
> >>
> >> 3. made me take a bit closer look to the troublesome commit, it passes:
> >> udev->bus->sysdev, which I assume is the XHCI controller itself as device
> >> to scsi_add_host_with_dma, which in turn seems to cause permanent changes
> >> to the dma settings for the XHCI controller. I'm not all that familiar with
> >> the DMA APIs but I'm getting the feeling that passing the actual XHCI-controller's
> >> device as dma-device to scsi_add_host_with_dma is simply the wrong thing to
> >> do; and that the intended effects (honor XHCI dma limits, but do not cause
> >> any changes the XHCI dma settings) should be achieved differently.
> >>
> >> Note that if this is indeed wrong, the matching usb-storage change should
> >> likely also be dropped.
> >
> > One problem in this area is that the clamping of the DMA size through
> > dma_max_mapping_size mentioned in the commit log doesn't work when
> > swiotlb is called from intel-iommu. I think we need to wire up those
> > calls there as well.
>
> Ok, but that does not sound like a quick last minute fix for 5.10, so maybe
> for 5.10 we should just revert the uas and usb-storage changes which trigger
> this problem and then retry those for 5.11 ?
>
> Regards,
>
> Hans
>
