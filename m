Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB022C8491
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 14:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgK3M7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 07:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3M7k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 07:59:40 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C7C0613D2;
        Mon, 30 Nov 2020 04:59:00 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id k26so14047273oiw.0;
        Mon, 30 Nov 2020 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vg3n+IuU9ZcsoQzQk8Ka2pVBr6m3bE+iD+eMp/f0Hxc=;
        b=Alnzhb53QFrmqVeWrFNGe8xNSkczZlMYgnBL/68PDBtKDAzwKfcN/xKeYozvQiw5IX
         cC33RXYBPpm+47zktxK3ld5msXcyZ5a6YLzAYwi+MVvlwOyGkgm1nrJav0x9D/dUn+oh
         3zdt/22zqVEZr3hzjcRhgQnG7iDsuUlm68mIPoffOvOqAOp7HaJRrj/5EZRpURRx1jR/
         dzG2623f+QgI0kNsK59gcZfxzhjY1cdPo/YqPo4eefxpLvt8+8a9CufPmBpH6KRiqi8t
         vMjVzvOg78YnpKzr01ozVMKpV787LCmtkFBlc+bK9zSP9YiDJQePls55Fk778X3QyMdy
         Y7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vg3n+IuU9ZcsoQzQk8Ka2pVBr6m3bE+iD+eMp/f0Hxc=;
        b=tODq2lCP0AdUN4ujRqCAP2CWv/788ueKtAgFp7QxkOBNy3331JePg+XxBLf97X2UyF
         Pq5UsNY3ElrA9kIUn7R3Ov3ralji93w3z6PXi2aldBfVaTgGTJdIeS46M6nP3UynLwyp
         h2S7obd2RLR5xV1YX+u9JG7d5ObGbK6XEYiMy5cyD2GcaoLMp19fIHOvRf3P8qy37Ye+
         Ij/RCytzZ1INrAREPkr8npe14qHvG2IrlXZ7aN7aByfUFLEfhphUWlf/+YXeiilAD/Gx
         lq48R+ci7n7SzUEj0MAhuZ5WDkamolWggWaDgppTLvhRaO7jNJvAB2fzA+vO9RT3brqx
         UrfQ==
X-Gm-Message-State: AOAM533+6sfhQm4LTMTSE8IWx0VKzeG4OqJkOkGG91NWnWL1edY3YJHA
        JKFIdyVYGZ6r3B5HgBzuLYwsiFubsiRIkzEEqVTrHwJDzhc=
X-Google-Smtp-Source: ABdhPJwW29HEak126mFBUZd6dRADJRwuru3DSw5EfJHuM61YKVyzYzTpRLoDYi1MUUfFUPReCzDIOzcgKKTw28/4sgY=
X-Received: by 2002:aca:4847:: with SMTP id v68mr9342704oia.164.1606741139454;
 Mon, 30 Nov 2020 04:58:59 -0800 (PST)
MIME-Version: 1.0
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
 <20201128154849.3193-1-tom.ty89@gmail.com> <20201128154849.3193-2-tom.ty89@gmail.com>
 <5e62c383-22ea-6df6-5acc-5e9f381d4632@redhat.com>
In-Reply-To: <5e62c383-22ea-6df6-5acc-5e9f381d4632@redhat.com>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Mon, 30 Nov 2020 20:58:37 +0800
Message-ID: <CAGnHSEnetAJNqUEW-iuq7eVyU6VnP84cv9+OVL4C5Z2ZK_eM0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb-storage: revert from scsi_add_host_with_dma() to scsi_add_host()
To:     Hans de Goede <hdegoede@redhat.com>
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

It's merely a moving of comment moving for/and a no-behavioral-change
adaptation for the reversion. Similar has been done in the equivalent
patch for the UAS driver (and the reason is stated there).

On Mon, 30 Nov 2020 at 17:50, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/28/20 4:48 PM, Tom Yan wrote:
> > While the change only seemed to have caused issue on uas drives, we
> > probably want to avoid it in the usb-storage driver as well, until
> > we are sure it is the right thing to do.
> >
> > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>
> This seems to do a whole lot more then just dropping back from
>  scsi_add_host_with_dma() to scsi_add_host(). This has way more
> lines then the orginal commit.
>
> IMHO it would be best to just revert commit 0154012f8018bba4d9971d1007c12ffd48539ddb
> and then submit these changes as a separate patch (which would be
> 5.11 material then).
>
> That separate patch could then also have a proper commit message
> explaining the other changes you are making, which is also not
> unimportant.
>
> Regards,
>
> Hans
>
>
>
>
> > ---
> >  drivers/usb/storage/scsiglue.c | 40 +++++++++++++++++-----------------
> >  drivers/usb/storage/usb.c      |  3 +--
> >  2 files changed, 21 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> > index 560efd1479ba..6539bae1c188 100644
> > --- a/drivers/usb/storage/scsiglue.c
> > +++ b/drivers/usb/storage/scsiglue.c
> > @@ -92,7 +92,7 @@ static int slave_alloc (struct scsi_device *sdev)
> >  static int slave_configure(struct scsi_device *sdev)
> >  {
> >       struct us_data *us = host_to_us(sdev->host);
> > -     struct device *dev = sdev->host->dma_dev;
> > +     struct device *dev = us->pusb_dev->bus->sysdev;
> >
> >       /*
> >        * Many devices have trouble transferring more than 32KB at a time,
> > @@ -120,6 +120,25 @@ static int slave_configure(struct scsi_device *sdev)
> >                * better throughput on most devices.
> >                */
> >               blk_queue_max_hw_sectors(sdev->request_queue, 2048);
> > +     } else {
> > +             /*
> > +              * Limit the total size of a transfer to 120 KB.
> > +              *
> > +              * Some devices are known to choke with anything larger. It seems like
> > +              * the problem stems from the fact that original IDE controllers had
> > +              * only an 8-bit register to hold the number of sectors in one transfer
> > +              * and even those couldn't handle a full 256 sectors.
> > +              *
> > +              * Because we want to make sure we interoperate with as many devices as
> > +              * possible, we will maintain a 240 sector transfer size limit for USB
> > +              * Mass Storage devices.
> > +              *
> > +              * Tests show that other operating have similar limits with Microsoft
> > +              * Windows 7 limiting transfers to 128 sectors for both USB2 and USB3
> > +              * and Apple Mac OS X 10.11 limiting transfers to 256 sectors for USB2
> > +              * and 2048 for USB3 devices.
> > +              */
> > +             blk_queue_max_hw_sectors(sdev->request_queue, 240);
> >       }
> >
> >       /*
> > @@ -627,25 +646,6 @@ static const struct scsi_host_template usb_stor_host_template = {
> >       .sg_tablesize =                 SG_MAX_SEGMENTS,
> >
> >
> > -     /*
> > -      * Limit the total size of a transfer to 120 KB.
> > -      *
> > -      * Some devices are known to choke with anything larger. It seems like
> > -      * the problem stems from the fact that original IDE controllers had
> > -      * only an 8-bit register to hold the number of sectors in one transfer
> > -      * and even those couldn't handle a full 256 sectors.
> > -      *
> > -      * Because we want to make sure we interoperate with as many devices as
> > -      * possible, we will maintain a 240 sector transfer size limit for USB
> > -      * Mass Storage devices.
> > -      *
> > -      * Tests show that other operating have similar limits with Microsoft
> > -      * Windows 7 limiting transfers to 128 sectors for both USB2 and USB3
> > -      * and Apple Mac OS X 10.11 limiting transfers to 256 sectors for USB2
> > -      * and 2048 for USB3 devices.
> > -      */
> > -     .max_sectors =                  240,
> > -
> >       /* emulated HBA */
> >       .emulated =                     1,
> >
> > diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
> > index c2ef367cf257..f177da4ff1bc 100644
> > --- a/drivers/usb/storage/usb.c
> > +++ b/drivers/usb/storage/usb.c
> > @@ -1050,8 +1050,7 @@ int usb_stor_probe2(struct us_data *us)
> >       usb_autopm_get_interface_no_resume(us->pusb_intf);
> >       snprintf(us->scsi_name, sizeof(us->scsi_name), "usb-storage %s",
> >                                       dev_name(dev));
> > -     result = scsi_add_host_with_dma(us_to_host(us), dev,
> > -                                     us->pusb_dev->bus->sysdev);
> > +     result = scsi_add_host(us_to_host(us), dev);
> >       if (result) {
> >               dev_warn(dev,
> >                               "Unable to add the scsi host\n");
> >
>
