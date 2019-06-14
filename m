Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA28451D6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 04:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfFNC03 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 22:26:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44603 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfFNC03 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 22:26:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so781516qtk.11
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2019 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LiOoADs+Q5z91q0BFH/hfKvDUqqapbQTXU8ncMrf99M=;
        b=uwiadcDhl26vPElVBSbZDabFb3ZE6S7BS3NtKXxz0gAL1w+mU3B7XGSP0TKRChf0QG
         qLjNLOYx2KLU4BUePq77d6nrIgFcJseoHDifbiVYZs43K3eHQPof84CQE2INw+fom/Sk
         AlZ7ILsFm4ODQYGhvDzyFyVfGVVtU3sQXtsHDzzNFSgX2xo4mskrrz9X5tBUXMVSwj2B
         JNyD1EEUdegFKa+egn7rxCq/8vxTTN1KnDj757mUOZW/XqjcW3DWLhpKs7Uay6xJYdee
         8XqL+l7Sm9kvlRNvI+HlZDyxmDjMwR2EQ3tje8e/zilP2LnIOZpuKaI1Lpq7EHo8WZjv
         f+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LiOoADs+Q5z91q0BFH/hfKvDUqqapbQTXU8ncMrf99M=;
        b=QEeDAf9qLdNBIC1HZN25Rdr2mz5ROh9iyiAZauRaKJC4cq0JlQSloq0xp/sjq45AqI
         veasLnzB3fH5Pm2/GQTCDK3V0eqczL6IjZOFny99wkqejPVqsUMTtyxuy88+/qHyxwuM
         pkLHu9Lb3J5H6sIX4YDm5bzZz0GmV2EuqTJjLQaAsUWt5xabhwJfQRgAqCgRhkiObesO
         YnZuhb2uCtC/CffevTrhPM872+kfmWVlmjBsEav5eivKkPG7VLcPcm3kavgfb0zDVkLP
         YrAXMAjaNQT/kdnl7x/cRgYDQfZRBI5q80neaNeyAztb9NI4nBdo7rVmbpXOXfaCg4iD
         KdbA==
X-Gm-Message-State: APjAAAVYPzW/NUxlPvqC/7XIp4ddERVP4Z/rLWUBdek0siu9fc+8lRnM
        J5JOxQlAzOSMeBpiDauBAwyTSW3yaIjWtd6Uyqzr/A==
X-Google-Smtp-Source: APXvYqzqe1/DHk1BGLZnH3KdvGW6KQDBwyXvUptRc8CEGriCukr0xUjYBj6CZBI0TGOmAn3teIaCliw6A0KIzqukAz8=
X-Received: by 2002:aed:21f0:: with SMTP id m45mr64329935qtc.391.1560479187623;
 Thu, 13 Jun 2019 19:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190610074456.2761-1-drake@endlessm.com> <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com> <20190613085402.GC13442@lst.de>
In-Reply-To: <20190613085402.GC13442@lst.de>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 14 Jun 2019 10:26:15 +0800
Message-ID: <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@gmail.com>,
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

On Thu, Jun 13, 2019 at 4:54 PM Christoph Hellwig <hch@lst.de> wrote:
> So until we get very clear and good documentation from Intel on that
> I don't think any form of upstream support will fly.  And given that
> Dan who submitted the original patch can't even talk about this thing
> any more and apparently got a gag order doesn't really give me confidence
> any of this will ever work.

I realise the architecture here seems badly thought out, and the lack
of a decent spec makes the situation worse, but I'd encourage you to
reconsider this from the perspectives of:
 - Are the patches really more ugly than the underlying architecture?
 - We strive to make Linux work well on common platforms and sometimes
have to accept that hardware vendors do questionable things & do not
fully cooperate
 - It works out of the box on Windows

As you said years ago:
https://marc.info/?l=linux-ide&m=147923593001525&w=2
"It seems devices supporting this "slow down the devices and make life
hell for the OS" mode are getting more common, so we'll have to do
something about it."

The frequency of apperance of this configuration appears poised to
grow even more significantly at this point. There appears to be a
significant increase in consumer laptops in development that have NVMe
disk as the only storage device, and come with the BIOS option on by
default. When these reach point of sale, expect to see a whole bunch
more Linux users who struggle with this. We also have indication that
vendors are unwilling to deal with the logistics headache of having
different BIOS settings for Linux, so the lack of support here is
potentially going to stop those vendors from shipping Linux at all.

Even with a spec I don't imagine that we can meet the feature parity
of having the real NVMe PCI device available. Can we just accept the
compromises & start by focusing on the simple case of a consumer
home/family PC?

>  a) quirks on the PCI ID

Intel stated unequivocally that the PCI config space is not available.
So this isn't going to happen, spec or not.
https://marc.info/?l=linux-ide&m=147734288604783&w=2

If we run into a case where we absolutely need quirks, we could
examine doing that on the disk identification data available over the
NVMe protocol (e.g. vendor & model name).

>  b) reset handling, including the PCI device removal as the last
>     escalation step

Apparently can't be supported, but it's not clear that this actually
matters for a home PC...

https://marc.info/?l=linux-ide&m=147733119300691&w=2
"The driver seems to already comprehend instances where the
device does not support nvme_reset_subsystem() requests."

https://marc.info/?l=linux-ide&m=147734288604783&w=2
"Talking with Keith, subsystem-resets are a feature of enterprise-class
NVMe devices.  I think those features are out of scope for the class
of devices that will find themselves in a platform with this
configuration, same for hot-plug."

>  c) SR-IOV VFs and their management

This seems like a server/virtualization topic. I don't see any issues
in not supporting this in the context of a consumer PC.
It seems reasonable to expect people interested in this to be required
to read the kernel logs (to see the message) and proceed with changing
the BIOS setting.

>  d) power management

If there is a way to control the NVMe device power separately from the
AHCI device that would of course be nice, but this seems secondary to
the larger problem of users not being able to access their storage
device.

I'm hopeful that after years of waiting for the situation to improve
without any positive developments, we can find a way to go with the
code we have now, and if we do get a spec from Intel at any point,
make any relevant code improvments when that happens.

I'll work on refreshing Dan's patches & clarifying the knowledge we
have within there, plus the limitations.

Thanks,
Daniel
