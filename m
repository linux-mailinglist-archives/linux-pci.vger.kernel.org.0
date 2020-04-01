Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B687819B7DF
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 23:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbgDAVqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 17:46:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38209 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAVqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 17:46:01 -0400
Received: by mail-io1-f67.google.com with SMTP id m15so1399508iob.5;
        Wed, 01 Apr 2020 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZRP/qYqZmgljQcfk8fAkDPQTdyvwm2pYv6AmDbYhUGk=;
        b=suhRyftI4Gy2+MJ5rv8FN7pgMkGUoVLRr0bhwfI3ndzfflSjv40r3BE67H1Bx7tuhk
         LMuand/y2Jva21avY4uWsdiM9RGKaM9/v7PXf7viRs0TWya+LHhUtFVsMMU4KphBiSpy
         u/BMCsxsWqXRYpOnJehhRpCv+ggyuKhrbaJ1qUo3VcU3ei+tKhCnGdCgQ0eAVmkpet0T
         5ghiMx58Jiy46KPH5VHYzwxqzcTAnrYskQ9wno1YdLGq8hr6Ye//Usp+9VJEcuAnLrx6
         CeH1CEYeXYYFRet+PEHsilePNaXzzPW3sy/LRikThjyrUSCXxS5uxKePUvlijCcF8Yoo
         PN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZRP/qYqZmgljQcfk8fAkDPQTdyvwm2pYv6AmDbYhUGk=;
        b=Kl8nTXyTPqy7RmavsgGcMMFyoCwlya6qcGaEkjkVR6by3tnQQ6HW3aNgQpvuW8Yy+a
         6fzFSOTiLxAlkc2jR0mS/yMVWXWf32qJng0iS7XgzNZY4hcpNFwaISBoWobocPRh36t/
         vww+NBe3+BZWr0F+anl9ojTlq8rVgx6fxTuUnnnxDBc7KP+VgQAmoWdPnmrRxNBttM7V
         kIlCgXs/J6SSDOA26z40qoiL4j+kSGtAxPFrP9ikz+tGXuXZGqJ63j/NacIMyy8xowxH
         cGeFp9lDZZ80XtoJH3WbhfB3z1v2fYCZSZOHjCrL0YpzODWH2qSCoD03MjJxEZ+6sOWJ
         aZQw==
X-Gm-Message-State: AGi0PuYKrGsHQkG1aNtKoxYG3o9p+imOSWv/zbF/oi5Ir8fqtEHPVHhM
        dHTAmnyKSHkkYRWfcQLz5ySAl5pvdcnyZuTh/Sk=
X-Google-Smtp-Source: APiQypIcnWZ+BXfbx3Tsbys7IrzHOzSrxnEk+DQptn0nlGqJUaEIQZPOvazNZ/xsnGPeaPujqeyfpO0tVSsQwP14Kbc=
X-Received: by 2002:a02:a619:: with SMTP id c25mr290529jam.15.1585777560430;
 Wed, 01 Apr 2020 14:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200328215123.GA130140@google.com> <97b916ad6ad03f39ccdf5b62fe7d7b9e10190708.camel@intel.com>
In-Reply-To: <97b916ad6ad03f39ccdf5b62fe7d7b9e10190708.camel@intel.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Wed, 1 Apr 2020 16:45:49 -0500
Message-ID: <CABhMZUWZOc8n0mU4wL7VX88w936HGaLJHFYVEpRdSUKqhbsdrw@mail.gmail.com>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 12:43 PM Derrick, Jonathan
<jonathan.derrick@intel.com> wrote:
> On Sat, 2020-03-28 at 16:51 -0500, Bjorn Helgaas wrote:
> > On Fri, Feb 07, 2020 at 04:59:58PM -0700, Jon Derrick wrote:
> > > This set adds an emulation driver for PCIe Hotplug. There may be platforms with
> > > specific configurations that can support hotplug but don't provide the logical
> > > slot hotplug hardware. For instance, the platform may use an
> > > electrically-tolerant interposer between the slot and the device.
> > > ...

> > There's a lot of good work in here, and I don't claim to understand
> > the use case and all the benefits.
> I've received more info that the customer use case is an AIC that
> breaks out 1-4 M.2 cards which have been made hotplug tolerant.
>
> > But it seems like quite a lot of additional code and complexity in an
> > area that's already pretty subtle, so I'm not yet convinced that it's
> > all worthwhile.
> >
> > It seems like this would rely on Data Link Layer Link Active
> > Reporting.  Is that something we could add to pciehp as a generic
> > feature without making a separate driver for it?  I haven't looked at
> > this for a while, but I would assume that if we find out that a link
> > went down, pciehp could/should be smart enough to notice that even if
> > it didn't come via the usual pciehp Slot Status path.
> I had a plan to do V2 by intercepting bus_ops rather than indirecting
> slot_ops in pciehp. That should touch /a lot/ less code.

I assume this is something like pci_bus_set_ops() or
pci_bus_set_aer_ops()?  Probably touches less code, but I'm not really
a fan of either of those current situations because they make things
magical -- there's a lot of stuff going on behind the curtain, and it
makes another thing to consider when we evaluate every pciehp change.

> The problem I saw with adding DLLLA as a primary signal in pciehp is
> that most of the pciehp boilerplate relies on valid Slot register
> logic. I don't know how reliable pciehp will be if there's no backing
> slot register logic, emulated or real. Consider how many slot
> capability reads are in hpc.
>
> I could add a non-slot flag check to each of those callers, but it
> might be worse than the emulation alternative.

I see what you mean -- there are quite a few reads of PCI_EXP_SLTSTA.
I'm not 100% sure all of those really need to exist.  I would expect
that we'd read it once in the ISR and then operate on that value.  So
maybe there's some middle ground of restructuring to remove some of
those reads and making the remaining few more generic.

All that being said, I'm also sympathetic to Christoph's concern about
cluttering pciehp to deal with non-standard topologies.  At some point
if you need to do non-standard things you may have to write and
maintain your own drivers.  I don't know where that point is yet.

Bjorn
