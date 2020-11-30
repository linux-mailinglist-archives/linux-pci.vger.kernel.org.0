Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2B2C8E12
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 20:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgK3TbE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 14:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgK3TbC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 14:31:02 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CE4C0613CF;
        Mon, 30 Nov 2020 11:30:21 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b2so5650893edy.13;
        Mon, 30 Nov 2020 11:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xoXFQV4BbsJg4GJL1tP5zyqti0Izs4JfnX3eGx9ZII=;
        b=Zq/11mTsid9DPdmqdQG1vEPB/JR5gwKhrJ7fFDHNFQwgBcFxbAW6WYdibvzYydHwO8
         MfEUk11ihrmuCgdTH/dZC5mVM0ZsGyO+pzFT/b7NUvsDugim216B9tOs7QLuYswp5PL6
         b9sLzcQhxgIffQf2RuqUeCvVaSOWPdvnSpNqnOgzj1zidcZ7ed7uAEJ+96TK1F6onaRF
         yqgcKrKTgbsP1X0ZStUhe8jWdKAIbunVarBap9X3FlS1q7sGccn1JUGGUIcv4d4qTruK
         vwO98mSkLeHHT076RRRRovst7MnzBkgSy8tpGt9SdHnp0pPLW6SEX2yx098Wlz5rPWVp
         FqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xoXFQV4BbsJg4GJL1tP5zyqti0Izs4JfnX3eGx9ZII=;
        b=QY8c97rHO/7sTpS2IuLBNM1Pd7xxZdXjz2vX8FSoNuVxA5ZFqCtGts4wiUCpcpZLcX
         0hbl66JLlY4WZ4tDRsd/vNSftMsyXbuW3aUmNZgexUpMLa9P20jEYyBNVoC0TSqqFr3B
         WZlhytX7CA7PB5PBRQ7uIlgOUl/l1oOaTfMthtyVef8ZczlxHLnNq6TZAHnYSegKaPkt
         bvTybXCKbzLqDLh6jG09csSYcHZsKfDRxiu58pq0uGCea8Oo4Nh0PjDNwze4VXiVxIn+
         gdWXCG7PmaRiivD2TWNK/s/+N/T3eOKUwQLaOTuknb1vt7pxl0P8i5pHfcKW9A/faW4u
         DOXg==
X-Gm-Message-State: AOAM532VswOklm5Oe1XvuzSwzpjX1i+WTfUYPBZWCmAG/e5CmHjkVs1h
        QEdGPrwJIF8ZtwBTAnbbrfp7o5LE8Z4QVV7O09k=
X-Google-Smtp-Source: ABdhPJzezmVM/nS96Muqp5B7lDWviRp/y1V8xtOI7nar908PFGFkWpkcuNGt9jlx4Ufw4MPV5xQZpSFfBP0jcrTEzi4=
X-Received: by 2002:aa7:c713:: with SMTP id i19mr23481998edq.296.1606764619981;
 Mon, 30 Nov 2020 11:30:19 -0800 (PST)
MIME-Version: 1.0
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
 <20201128154849.3193-1-tom.ty89@gmail.com> <62e0d5ea-e665-b913-5482-a75db0ac1368@redhat.com>
In-Reply-To: <62e0d5ea-e665-b913-5482-a75db0ac1368@redhat.com>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Tue, 1 Dec 2020 03:30:07 +0800
Message-ID: <CAGnHSE=sS7tvttuTwE_s+QbCUVCfhmHnuXQp1g1AkZ=JEoxmQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] uas: revert from scsi_add_host_with_dma() to scsi_add_host()
To:     Hans de Goede <hdegoede@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hmm, I wonder if I/we wrongly assumed that the dma_dev used for the
hw_max_sectors clamping in __scsi_init_queue() is wrong.

So instead of adding a fallback else-clause here or using "sysdev" as
dma_dev like in the current upstream code, maybe we should actually do
a three-way min: the "changed" hw_max_sectors, dma_max_mapping_size of
dma_dev("dev") and dma_max_mapping_size of sysdev...?

On Mon, 30 Nov 2020 at 17:48, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/28/20 4:48 PM, Tom Yan wrote:
> > Apparently the former (with the chosen dma_dev) may cause problem in certain
> > case (e.g. where thunderbolt dock and intel iommu are involved). The error
> > observed was:
> >
> > XHCI swiotlb buffer is full / DMAR: Device bounce map failed
> >
> > For now we retain the clamp for hw_max_sectors against the dma_max_mapping_size.
> > Since the device/size for the clamp that is applied when the scsi request queue
> > is initialized/allocated is different than the one used here, we invalidate the
> > early clamping by making a fallback blk_queue_max_hw_sectors() call.
> >
> > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>
> I can confirm that this fixes the network performance on a Lenovo Thunderbolt
> dock generation 2, which uses an USB attach NIC.
>
> With this patch added on top of 5.10-rc5 scp performance to another machine
> on the local gbit LAN goes back from the regressed 1 MB/s to its original 100MB/s
> as it should be:
>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
> > ---
> >  drivers/usb/storage/uas.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
> > index c8a577309e8f..5db1325cea20 100644
> > --- a/drivers/usb/storage/uas.c
> > +++ b/drivers/usb/storage/uas.c
> > @@ -843,18 +843,21 @@ static int uas_slave_alloc(struct scsi_device *sdev)
> >  static int uas_slave_configure(struct scsi_device *sdev)
> >  {
> >       struct uas_dev_info *devinfo = sdev->hostdata;
> > -     struct device *dev = sdev->host->dma_dev;
> > +     struct usb_device *udev = devinfo->udev;
> >
> >       if (devinfo->flags & US_FL_MAX_SECTORS_64)
> >               blk_queue_max_hw_sectors(sdev->request_queue, 64);
> >       else if (devinfo->flags & US_FL_MAX_SECTORS_240)
> >               blk_queue_max_hw_sectors(sdev->request_queue, 240);
> > -     else if (devinfo->udev->speed >= USB_SPEED_SUPER)
> > +     else if (udev->speed >= USB_SPEED_SUPER)
> >               blk_queue_max_hw_sectors(sdev->request_queue, 2048);
> > +     else
> > +             blk_queue_max_hw_sectors(sdev->request_queue,
> > +                                      SCSI_DEFAULT_MAX_SECTORS);
> >
> >       blk_queue_max_hw_sectors(sdev->request_queue,
> >               min_t(size_t, queue_max_hw_sectors(sdev->request_queue),
> > -                   dma_max_mapping_size(dev) >> SECTOR_SHIFT));
> > +                   dma_max_mapping_size(udev->bus->sysdev) >> SECTOR_SHIFT));
> >
> >       if (devinfo->flags & US_FL_NO_REPORT_OPCODES)
> >               sdev->no_report_opcodes = 1;
> > @@ -1040,7 +1043,7 @@ static int uas_probe(struct usb_interface *intf, const struct usb_device_id *id)
> >       shost->can_queue = devinfo->qdepth - 2;
> >
> >       usb_set_intfdata(intf, shost);
> > -     result = scsi_add_host_with_dma(shost, &intf->dev, udev->bus->sysdev);
> > +     result = scsi_add_host(shost, &intf->dev);
> >       if (result)
> >               goto free_streams;
> >
> >
>
