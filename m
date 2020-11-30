Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4722C86F8
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 15:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgK3Okx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 09:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgK3Okw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 09:40:52 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE35BC0613CF;
        Mon, 30 Nov 2020 06:40:11 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f9so20044593ejw.4;
        Mon, 30 Nov 2020 06:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JM65qVWHe/D3jqo1oAErAS5mplJkY3vB0A9hWCwSLIE=;
        b=ZDxilJ5H+NWCTSRBaHN4e2Xxpg2H1Esz2x/qwj0fYu5/+xeOCXtAA7h2mlHlsKRV7/
         587biUBHiQgoefo71N0/WWnVTtLZ3fIQxrq1+00PyuLzP2rR74s++C0WOuhO+ydZ3yJM
         3AvAo4GkTK+7x1c9rPE83XLItVjfpreX4i80ARRSb0bxqasHpnza5JwIYcTByzbGL3bO
         7h8dbqXZe+vqE1QJyw6MovPcWwGTfe+BaksipSGERipBohK3Z1LduS3Jxkxx4IH+kPTN
         HYAL/AoPd0eBzlJEd5UhfmgVIZu7VDAn3L8YhJWU3NwT0d8+AJQbM05c/CMpnLrHRcxY
         pcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JM65qVWHe/D3jqo1oAErAS5mplJkY3vB0A9hWCwSLIE=;
        b=HN9m3nPZJoYZZFaUhZiScGXhZ5g77t+HIqIQAJadWVssbEg7FocZVHXcmhOhuHQZh6
         OiHQrT4tiuoQVC3Vmlvmoapy268UH2VRM01OSMhiTAIbpVt28uwrxN44oe+i/plfcNdf
         hh5JbS/uhQlCAmPXHkBjFFPRkA9L3ITyb8NCDeTnwfyuJfMF29AMj8zBVKLXNDridIsz
         6VI5k/fnd+F3CyJ8Xlxp3gNxO0q27wuRD9eqtz34CB2uuehIQm9GoCGhsNwr1CLeSFDX
         8ski0FM/rWdlVOnoZ2KwQOXJRbbVOS7O7+ejQz526BhX+Wc4NRof5RyRhb4KnfsdLew2
         8vBw==
X-Gm-Message-State: AOAM533952xm6sUtcPObG8XdVN053poTGaLT1UfqMzSnzOaDIEAnHrwf
        Gtx15QG/D1bQgv55qCZk91XdE32nyxn4RA0/Rs4=
X-Google-Smtp-Source: ABdhPJyIqGhQuQlbjzR2JMp0U09VtLQdJJJ4I6rmYABrKE6LgWcno98Gkte4VpRe3mOUxmmZrQnwFhGs41K62ga+yxI=
X-Received: by 2002:a17:906:a195:: with SMTP id s21mr21312326ejy.146.1606747210492;
 Mon, 30 Nov 2020 06:40:10 -0800 (PST)
MIME-Version: 1.0
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
 <20201128154849.3193-1-tom.ty89@gmail.com> <20201128154849.3193-2-tom.ty89@gmail.com>
 <5e62c383-22ea-6df6-5acc-5e9f381d4632@redhat.com> <CAGnHSEnetAJNqUEW-iuq7eVyU6VnP84cv9+OVL4C5Z2ZK_eM0A@mail.gmail.com>
 <186eb035-4bc4-ff72-ee41-aeb6d81888e3@redhat.com>
In-Reply-To: <186eb035-4bc4-ff72-ee41-aeb6d81888e3@redhat.com>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Mon, 30 Nov 2020 22:39:58 +0800
Message-ID: <CAGnHSEnrmRUe9ESfRSRt6EoBYN+7pcM+71zsRF2cH+NJQWAQrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb-storage: revert from scsi_add_host_with_dma() to scsi_add_host()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 30 Nov 2020 at 21:23, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/30/20 1:58 PM, Tom Yan wrote:
>
> IMHO the revert of the troublesome commit and the other/new changes really
> should be 2 separate commits. But I will let Alan and Greg have the final
> verdict on this.

They are not "other/new" changes. The same thing was done in the
earlier version of the problematic commits, before I was given the
idea that we can/should set dma_dev to the "chosen device". With the
dma_dev setting approach the exact same clamping will be applied twice
at different points so we don't have to invalidate the earlier one.
But now since we no longer do so, the two clamping are / can be
different, so we need to invalidate the earlier one when we are not
overriding the default max_sectors in each case.

>
> p.s. Why did you not send this patch-series to Alan Stern, the maintainer of
> the usb-storage driver?

Either I accidentally missed him or the list I copied from did that
already. Sorry.

>
> > Similar has been done in the equivalent
> > patch for the UAS driver (and the reason is stated there).
>
> In the UAS driver the code setting max-hw-sectors was already moved to its
> new place and another patch was added on top, so that is different.

If you are referring to the alloc/configure move in the problematic
commit, it was a trivial / code consistency change. It has nothing to
do with what I'm talking about. What I'm talking about is the
else-clause add in the first patch of the current series. I don't know
if you simply missed it or it just seemed much trivial to you, either
way it was "simple" there merely because the uas driver doesn't set
its own "default" max_sectors (and hence has no comment for it) but
use the one set in the SCSI layer. Most importantly, it's an
*adapation* that makes these patches change *nothing* from the current
behaviour but only switches back to scsi_add_host().

>
> Regards,
>
> Hans
>
>
> >
> > On Mon, 30 Nov 2020 at 17:50, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 11/28/20 4:48 PM, Tom Yan wrote:
> >>> While the change only seemed to have caused issue on uas drives, we
> >>> probably want to avoid it in the usb-storage driver as well, until
> >>> we are sure it is the right thing to do.
> >>>
> >>> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> >>
> >> This seems to do a whole lot more then just dropping back from
> >>  scsi_add_host_with_dma() to scsi_add_host(). This has way more
> >> lines then the orginal commit.
> >>
> >> IMHO it would be best to just revert commit 0154012f8018bba4d9971d1007c12ffd48539ddb
> >> and then submit these changes as a separate patch (which would be
> >> 5.11 material then).
> >>
> >> That separate patch could then also have a proper commit message
> >> explaining the other changes you are making, which is also not
> >> unimportant.
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >>
> >>
> >>> ---
> >>>  drivers/usb/storage/scsiglue.c | 40 +++++++++++++++++-----------------
> >>>  drivers/usb/storage/usb.c      |  3 +--
> >>>  2 files changed, 21 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> >>> index 560efd1479ba..6539bae1c188 100644
> >>> --- a/drivers/usb/storage/scsiglue.c
> >>> +++ b/drivers/usb/storage/scsiglue.c
> >>> @@ -92,7 +92,7 @@ static int slave_alloc (struct scsi_device *sdev)
> >>>  static int slave_configure(struct scsi_device *sdev)
> >>>  {
> >>>       struct us_data *us = host_to_us(sdev->host);
> >>> -     struct device *dev = sdev->host->dma_dev;
> >>> +     struct device *dev = us->pusb_dev->bus->sysdev;
> >>>
> >>>       /*
> >>>        * Many devices have trouble transferring more than 32KB at a time,
> >>> @@ -120,6 +120,25 @@ static int slave_configure(struct scsi_device *sdev)
> >>>                * better throughput on most devices.
> >>>                */
> >>>               blk_queue_max_hw_sectors(sdev->request_queue, 2048);
> >>> +     } else {
> >>> +             /*
> >>> +              * Limit the total size of a transfer to 120 KB.
> >>> +              *
> >>> +              * Some devices are known to choke with anything larger. It seems like
> >>> +              * the problem stems from the fact that original IDE controllers had
> >>> +              * only an 8-bit register to hold the number of sectors in one transfer
> >>> +              * and even those couldn't handle a full 256 sectors.
> >>> +              *
> >>> +              * Because we want to make sure we interoperate with as many devices as
> >>> +              * possible, we will maintain a 240 sector transfer size limit for USB
> >>> +              * Mass Storage devices.
> >>> +              *
> >>> +              * Tests show that other operating have similar limits with Microsoft
> >>> +              * Windows 7 limiting transfers to 128 sectors for both USB2 and USB3
> >>> +              * and Apple Mac OS X 10.11 limiting transfers to 256 sectors for USB2
> >>> +              * and 2048 for USB3 devices.
> >>> +              */
> >>> +             blk_queue_max_hw_sectors(sdev->request_queue, 240);
> >>>       }
> >>>
> >>>       /*
> >>> @@ -627,25 +646,6 @@ static const struct scsi_host_template usb_stor_host_template = {
> >>>       .sg_tablesize =                 SG_MAX_SEGMENTS,
> >>>
> >>>
> >>> -     /*
> >>> -      * Limit the total size of a transfer to 120 KB.
> >>> -      *
> >>> -      * Some devices are known to choke with anything larger. It seems like
> >>> -      * the problem stems from the fact that original IDE controllers had
> >>> -      * only an 8-bit register to hold the number of sectors in one transfer
> >>> -      * and even those couldn't handle a full 256 sectors.
> >>> -      *
> >>> -      * Because we want to make sure we interoperate with as many devices as
> >>> -      * possible, we will maintain a 240 sector transfer size limit for USB
> >>> -      * Mass Storage devices.
> >>> -      *
> >>> -      * Tests show that other operating have similar limits with Microsoft
> >>> -      * Windows 7 limiting transfers to 128 sectors for both USB2 and USB3
> >>> -      * and Apple Mac OS X 10.11 limiting transfers to 256 sectors for USB2
> >>> -      * and 2048 for USB3 devices.
> >>> -      */
> >>> -     .max_sectors =                  240,
> >>> -
> >>>       /* emulated HBA */
> >>>       .emulated =                     1,
> >>>
> >>> diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
> >>> index c2ef367cf257..f177da4ff1bc 100644
> >>> --- a/drivers/usb/storage/usb.c
> >>> +++ b/drivers/usb/storage/usb.c
> >>> @@ -1050,8 +1050,7 @@ int usb_stor_probe2(struct us_data *us)
> >>>       usb_autopm_get_interface_no_resume(us->pusb_intf);
> >>>       snprintf(us->scsi_name, sizeof(us->scsi_name), "usb-storage %s",
> >>>                                       dev_name(dev));
> >>> -     result = scsi_add_host_with_dma(us_to_host(us), dev,
> >>> -                                     us->pusb_dev->bus->sysdev);
> >>> +     result = scsi_add_host(us_to_host(us), dev);
> >>>       if (result) {
> >>>               dev_warn(dev,
> >>>                               "Unable to add the scsi host\n");
> >>>
> >>
> >
>
