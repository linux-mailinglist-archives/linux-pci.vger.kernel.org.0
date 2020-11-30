Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DDA2C8D85
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 19:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbgK3S6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 13:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3S6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 13:58:35 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF174C0613CF;
        Mon, 30 Nov 2020 10:57:54 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so23851631ejj.5;
        Mon, 30 Nov 2020 10:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8n76AgB/s3s8UBJCFU8wC3PDZsO7yuSxlQ/9v49C7/w=;
        b=NlsZlvDhvOGhSfcEJmF1RqoOqtL7bT3n8CwOdE339BhpWVOqEYkiFwVokoj7L85wfR
         BG5ZjffMBvrRHe5Z78LfIQjqdYWRltLgRF05t8syrKIJ1aJD4dcejNKwcS52qePtzwqI
         tpdkeGr+m8k8vbM+/DWlHZG32GP6mNRxaH99jLz0VbTzOdHgYJ4uALD7m4VBrLgUakqD
         t71SL95G6rF1kKdJoRrPQ8R8SweEDC75iewUx/8tgGptlUr4KWQOtDpphN8vjpyUboIp
         VENekoejpi9BFy+u7qhkY07afcancT3liymzg1ryqo293m/0a7J9Hhl0NwrakASIkVp3
         9KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8n76AgB/s3s8UBJCFU8wC3PDZsO7yuSxlQ/9v49C7/w=;
        b=jhQhFKShSgB8cVCzd+y58Np14/45HT1igBdSWG+ldFj9qIZHWlDbgTzHx4oXEB8JLP
         jJ8ObzK3sbga5zqgQm47faLIOD3T9kJYfzUZdiEXfDtMB3jYj38zXG8syfHVfGhHkx6N
         h5kJTXysO0GR4oObyrWo/YKARISELLNNHObzXDJWdlf7UvbbfvOxBs+ZlWzOCkNWZd51
         +wXW6LxSMLwH+JNmWYTv9gdNbd0xKXPrdX+1yvzPWafGmPutAMpYTqafsNs839Kq0QtE
         uUNGw3CK/XES7K5oTXqQrIpHLEajrd6GjshnbCtB9HVE0RYkpi0kBX+LnnLn+boZ+XE2
         71vA==
X-Gm-Message-State: AOAM531DQjQ/pnUKi8WiemvrSPH1gv3BdeKA3hfRUTbK4XJ/bGMlQUi7
        9bqh+5z2gB91P1B0xzZzd4UKT8rSfZEw9edXlQY=
X-Google-Smtp-Source: ABdhPJxzJSEtoaVbLjezZO5sixjTkeCh6wk1BuQlHJQsCpP13Gn1TeIWY/VZM/8ErlCV0FbNvZCSFXMKGVSXSb/KL8M=
X-Received: by 2002:a17:906:e212:: with SMTP id gf18mr2744779ejb.551.1606762673708;
 Mon, 30 Nov 2020 10:57:53 -0800 (PST)
MIME-Version: 1.0
References: <09992cec-65e4-2757-aae6-8fb02a42f961@redhat.com>
 <20201128154849.3193-1-tom.ty89@gmail.com> <20201128154849.3193-2-tom.ty89@gmail.com>
 <5e62c383-22ea-6df6-5acc-5e9f381d4632@redhat.com> <CAGnHSEnetAJNqUEW-iuq7eVyU6VnP84cv9+OVL4C5Z2ZK_eM0A@mail.gmail.com>
 <186eb035-4bc4-ff72-ee41-aeb6d81888e3@redhat.com> <X8T0E2qvF2cgADl+@kroah.com>
 <dd557c38-a919-5e5e-ab3b-17a235f17139@redhat.com> <20201130172004.GA966032@rowland.harvard.edu>
 <abb0a79d-63a0-6f3d-4812-f828283cd47c@redhat.com>
In-Reply-To: <abb0a79d-63a0-6f3d-4812-f828283cd47c@redhat.com>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Tue, 1 Dec 2020 02:57:41 +0800
Message-ID: <CAGnHSEk1GixNK71CJMymwLE=MyedjCkiG5Ubq1=O_wFxBBM0GQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb-storage: revert from scsi_add_host_with_dma() to scsi_add_host()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-usb <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This maybe? https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/scsi_lib.c?h=v5.10-rc6#n1816

UAS:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/storage/uas.c?h=v5.10-rc6#n918
BOT (AFAICT):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/hosts.c?h=v5.10-rc6#n466

It would explain why the issue is only triggered with UAS drives.

The questions (from me) are:
1. From the scsi layer POV (as per what __scsi_init_queue() does),
what/which should we use as dma_dev?
2. Do we really need to set dma_boundary in the UAS host template (to
PAGE_SIZE - 1)?
3. Kind of the same question as #1: when we clamp hw_max_sectors to
dma max mapping size, should the size actually be "the smaller one
among dev and sysdev"? Or is one of the two sizes *always* the smaller
one?


On Tue, 1 Dec 2020 at 02:19, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/30/20 6:20 PM, Alan Stern wrote:
> > On Mon, Nov 30, 2020 at 02:36:38PM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 11/30/20 2:30 PM, Greg KH wrote:
> >>> On Mon, Nov 30, 2020 at 02:23:48PM +0100, Hans de Goede wrote:
> >>>> Hi,
> >>>>
> >>>> On 11/30/20 1:58 PM, Tom Yan wrote:
> >>>>> It's merely a moving of comment moving for/and a no-behavioral-change
> >>>>> adaptation for the reversion.>
> >>>>
> >>>> IMHO the revert of the troublesome commit and the other/new changes really
> >>>> should be 2 separate commits. But I will let Alan and Greg have the final
> >>>> verdict on this.
> >>>
> >>> I would prefer to just revert the commits and not do anything
> >>> different/special here so late in the release cycle.
> >>>
> >>> So, if Alan agrees, I'll be glad to do them on my end, I just need the
> >>> commit ids for them.
> >>
> >> The troublesome commit are (in reverse, so revert, order):
> >>
> >> 5df7ef7d32fe ("uas: bump hw_max_sectors to 2048 blocks for SS or faster drives")
> >> 558033c2828f ("uas: fix sdev->host->dma_dev")
> >> 0154012f8018 ("usb-storage: fix sdev->host->dma_dev")
> >>
> >> Alan, the reason for reverting these is that using scsi_add_host_with_dma() as the
> >> last 2 patches do, with the dmadev argument of that call pointing to the device
> >> for the XHCI controller is causing changes to the DMA settings of the XHCI controller
> >> itself which is causing regressions in 5.10, see this email thread:
> >>
> >> https://lore.kernel.org/linux-usb/fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com/T/#t
> >
> > It's hard to go wrong with reverting, so it's okay with me.
> >
> > Still, Hans, have you checked out the difference between the
> > scsi_add_host() and scsi_add_host_with_dma() calls?  It's just a matter
> > of using dev vs. sysdev.  In particular, have you checked to see what
> > those two devices are on your system?
>
> Its not just dev vs sysdev, its iface->dev vs bus->sysdev, and I assume
> that the latter is actually the XHCI controller.
>
> my vote goes to reverting to avoid the regression for 5.10, esp. since
> this is a clean revert of 3 patches with nothing depending / building
> on top of the reverted commits.
>
> Then for 5.11 we can retry to introduce similar changes. I would be happy
> to try a new patch-set for 5.11.
>
> > It seems likely that if one of those calls messes up some DMA settings,
> > the other one does too -- just maybe not settings that matter much.
>
> I'm not very familiar with all the DMA mapping / mask code, but AFAIK making
> changes to the DMA settings of a child will not influence the parent.
>
> Where as when passing bus->sysdev, then changes are made to a device
> which is shared with other devices on the bus, which is why we see
> a regression in an USB NIC driver being triggered by the UAS driver
> binding to a device (on the same bus).
>
> At least that is my interpretation of this. I bisected the regression
> and that pointed at the UAS DMA change and reverting it fixes things,
> confirming that I did not make any mistakes during the bisect.
>
> Regards,
>
> Hans
>
