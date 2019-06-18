Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7732049BB1
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 10:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfFRIGq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 04:06:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44145 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRIGq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 04:06:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so14131356qtk.11
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2019 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZZFVzMIsw2Aj7pTRgo/2FmyBTRVVD/iyukGOksnFh0=;
        b=fcNF1ZRJ00IZY2gkoExFv8g2IKGSRXmFWQ4kTALcYGFNqqrUcKhlhXbw8Wd2QTjXwk
         k0hHLA/17QImguQYtA/TR2zp8TsxK3sPCIr3yQuqpD9mq50ZkjZPvKLgFOrIMK6ZEiI4
         u1OmH0w4FyBtbebTkCgfeMwZ9ZX7PA4I5L4kmyGKXDS5eMQgGpa0ooVT+xz0yuGMCoAh
         UbMqePAObC4vq75Y6QCm+kjZBSoADK4p2BHz+xHfR4n54L5ervkhl9RH+LlT8voGN1B8
         z8VJbv+sXx489sBAwwPxj4lSN42gPDjGhD0ljE8FjIWBSLw7VWjq7EfZZjnsO7wTKkM1
         mm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZZFVzMIsw2Aj7pTRgo/2FmyBTRVVD/iyukGOksnFh0=;
        b=NwiyOFzbZtTQqfL4S3cu+ujLoyH+QjajNyPUasf54MkXOGKswf7pVil++qmBuXgcLP
         /2sbIIkikaI0489o1WCwUosjcT0pWAbmAwb1sAzOb2rg1MP+XOwjgetVWobCzPtBU2SW
         9kHmHU6+/ygw4wDccZGldF42cREUnJ+GLbR/z6fEPSGNOjBeapc6H0CTQIv8dVptmE5r
         gj7ZatmqAv0DSJfjS5JOAEzernNZCWHjw1YKDK3BD0eXWkO+lM9X4rRdFs83qQkaUY5I
         4K+ZMS78dCZsGhf2I924C2Fgdx3L3HW5bCS/6Q9B8a0a0Wn9i2sStg/OiN+fjKnUhyqH
         FomA==
X-Gm-Message-State: APjAAAWpXnMU3VpWCgd5oHsUb5/qyyoHgULvJzAn5xUwLzk+StkmvpZb
        qZyga7x5Cc0w/KjS1tTMtLZRrZruh/5Zqd7wG2SGag==
X-Google-Smtp-Source: APXvYqylBOZvcoG7IqfNWowr8Rr/SUDXGkVrsTHhfIANPkwzO7H1s0HZeyIAAJeNkKds08HWL2fXX9sFjtf5aII0HaU=
X-Received: by 2002:aed:2358:: with SMTP id i24mr10041411qtc.239.1560845204774;
 Tue, 18 Jun 2019 01:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190610074456.2761-1-drake@endlessm.com> <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de> <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
 <06c38b3e-603b-5bae-4959-9965ab40db62@suse.de>
In-Reply-To: <06c38b3e-603b-5bae-4959-9965ab40db62@suse.de>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 18 Jun 2019 16:06:33 +0800
Message-ID: <CAD8Lp44rqGh3nmUOFhwq+SSxpJGuWvLFJ8sKtM0q1GeY0j4v9A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Keith Busch <keith.busch@gmail.com>,
        Keith Busch <kbusch@kernel.org>, linux-ide@vger.kernel.org,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 3:46 PM Hannes Reinecke <hare@suse.de> wrote:
> On 6/14/19 4:26 AM, Daniel Drake wrote:
> > On Thu, Jun 13, 2019 at 4:54 PM Christoph Hellwig <hch@lst.de> wrote:
> >> So until we get very clear and good documentation from Intel on that
> >> I don't think any form of upstream support will fly.  And given that
> >> Dan who submitted the original patch can't even talk about this thing
> >> any more and apparently got a gag order doesn't really give me confidence
> >> any of this will ever work.
> >
> > I realise the architecture here seems badly thought out, and the lack
> > of a decent spec makes the situation worse, but I'd encourage you to
> > reconsider this from the perspectives of:
> >  - Are the patches really more ugly than the underlying architecture?
> >  - We strive to make Linux work well on common platforms and sometimes
> > have to accept that hardware vendors do questionable things & do not
> > fully cooperate
> >  - It works out of the box on Windows
> >
> Actually, there _is_ a register description:
>
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf
>
> Look for section 15: Intel RST for PCIe Storage.
>
> That gives you a reasonable description of the various registers etc.

Thanks for your email! I also spotted it for the first time earlier today.

Section 15 there (D24:F0) describes a special/hidden PCI device which
I can't figure out how to access from Linux (I believe it would be at
D18:F0 in the cases where the 300 PCH is integrated into the SoC, as
it is on the Whiskey Lake platform I have here). That's probably not
important because if even if we had access all the values are probably
read-only, as the BIOS will lock them all down during early boot, as
is documented. But the docs give some interesting insights into the
design.

Section 15.2 is potentially more relevant, as it describes registers
within the AHCI BAR and we do have access to that. Some of these
registers are already used by the current code to determine the
presence of remapped devices. It might be nice to use Device Memory
BAR Length (DMBL_1) but I can't figure out what is meant by "A 1 in
the bit location indicates the corresponding lower memory BAR bit for
the PCIe SSD device is a Read/Write (RW) bit." The value is 0x3fff on
the platform I have here.

We can probably also use these registers for MSI support. I started to
experiment, doesn't quite work but I'll keep poking. The doc suggests
there is a single MSI-X vector for the AHCI SATA device, and AHCI
MSI-X Starting Vector (AMXV) has value 0x140 on this platform. No idea
how to interpret that value. From experimentation, the AHCI SATA disk
generates interrupts on vector 0.

Then there are multiple vectors for the remapped NVMe devices. Device
MSI-X Configuration (DMXC_L_1) is set up to assign vectors 1 to 19 to
NVMe on this platform. But it says "This field is only valid when
DMXC.ID indicates interrupt delivery using MSI-X" but what/where is
DMXC.ID? So far I can get NVMe-related interrupts on vector 1 but
apparently not enough of them, the driver hangs during probe.

I've nearly finished refreshing & extending Dan Williams' patches and
will send them for more discussion soon.

Daniel
