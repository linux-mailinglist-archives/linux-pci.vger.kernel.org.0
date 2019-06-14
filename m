Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3A46830
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfFNTgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 15:36:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38805 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNTgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 15:36:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so3698744wrs.5;
        Fri, 14 Jun 2019 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iuen4us4qwoV5tqtyFbIwEnmTYf7b4xea2g4tH0SWx8=;
        b=IAvJg8ETPBRJWFF/CGdbBAN8iyvgesw76DdfQRPlXss/RPtBIBuZhkJDiEW8DK2UMc
         OIwzjcMDGDtv7bFu86LRsy1jRy+fBurVJq1EdPU3m79G0+cU/wIujLwzNFr0kzjxKDcm
         ZayMCIIn1xqCRQ/SHsWj93ob6tAojWpoJma83UpFn9WmYv26W6nRECIiCeQ/g0cVDakV
         fQmTFt3znCEOGuFYOSWzlyasP5KWQ0oPB3p7ibde5NlXatrCcoSmWjXM6Fo7dJbmLhCV
         dA3126kW+XtzrUmACoqbo1PjUx3A/Me7lTRrgSEZ0ysSh5+dJDfQsUDGIoGYSHTYQqee
         HCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iuen4us4qwoV5tqtyFbIwEnmTYf7b4xea2g4tH0SWx8=;
        b=NGKLyEs8bJzrP6UECQApLvGbCTOP4hFo9dZMQgZ81XLc+LMcHvheLcMv6/S1gSXASZ
         NQ1k5RvEhNdSl9v6ZC+Gn4Tzi76wFNL1MOKm28C0T73V1baXfimODWApHmq+xhs80GK0
         dTnO7ZQyUOgI/dg5Am2wbDlDPaKvgC5owYJEj3XZdbEghCOFHK+GIKBcTVL1x4DrTC1+
         weaNoXhJt/RzMcURu11hn0hA+vmD7hZPY5z2z4CN4I08pXijgUIoHFzIyYsDIQkhCn9C
         hEWWgsx2ZpwqI8FnPBbR2jcrZvidGap91QaYJgvGHuLbTZVEgVNV0KeLeHLmQhQ/DYiW
         LeNA==
X-Gm-Message-State: APjAAAWQhkca6s58rjODV3K4OXlLoobRmR8AcdoJ6+6PguEYbXvDKm2t
        aLhGs1U9Kl+9E35iWNzeajAoO5/R9hNSN1sr6Io=
X-Google-Smtp-Source: APXvYqzJyCR5WhUhz5HRAU2NajqT2EChTOtU9SC51qWgHHh2VgjMJakSG3j7zJQj+J0sE/Lje+oCGhTch8AZWAzJei4=
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr66636492wrw.306.1560540979110;
 Fri, 14 Jun 2019 12:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190610074456.2761-1-drake@endlessm.com> <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de> <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
In-Reply-To: <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Fri, 14 Jun 2019 13:36:07 -0600
Message-ID: <CAOSXXT4Ba_6xRUyaQBxpq+zdG9_itXDhFJ5EFZPv3CQuJZKHzg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
To:     Daniel Drake <drake@endlessm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-ide@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 8:26 PM Daniel Drake <drake@endlessm.com> wrote:
> On Thu, Jun 13, 2019 at 4:54 PM Christoph Hellwig <hch@lst.de> wrote:
> >  b) reset handling, including the PCI device removal as the last
> >     escalation step
>
> Apparently can't be supported, but it's not clear that this actually
> matters for a home PC...
>
> https://marc.info/?l=linux-ide&m=147733119300691&w=2
> "The driver seems to already comprehend instances where the
> device does not support nvme_reset_subsystem() requests."
>
> https://marc.info/?l=linux-ide&m=147734288604783&w=2
> "Talking with Keith, subsystem-resets are a feature of enterprise-class
> NVMe devices.  I think those features are out of scope for the class
> of devices that will find themselves in a platform with this
> configuration, same for hot-plug."

NVMe Subsystem resets are not the same thing as conventional PCI
resets. We still have use for the latter in client space.

Even if you wish to forgo the standard features and management
capabilities, you're still having to deal with legacy IRQ, which has
IOPs at a fraction of the hardware's true capabilities when using MSI.
I do not believe that is what users want out of their purchased
hardware, so your best option is still to set to AHCI mode for Linux
for this reason alone, and vendors should be providing this option in
BIOS.
