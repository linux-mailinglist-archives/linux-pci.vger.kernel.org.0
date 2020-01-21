Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A964144003
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2020 15:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgAUOz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jan 2020 09:55:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33478 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgAUOz0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jan 2020 09:55:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so3181175otp.0;
        Tue, 21 Jan 2020 06:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JgWyHFx4DXLB+RWjYOGV034XoPPQDPd6XzHn420fcvE=;
        b=nAZN5wPUP+AM+Rsbi2j/IPM4Ti4Q/3O8/f6MxlJMP3Yb02sCkRkprGqNiK0WIh/I1X
         Dj6ztcpmxIXxZfs+084Ps5TkXrLyDnhQZaFBs/vnssqV5cNJ3RE/bWKr6YoZvGSFat/c
         /4wi//wO0ZVLqCNIZ5V25i4IZzyRgdJ4sgUCqmhk7t57vd88MzlQIcy6jD9FESqIWP/v
         oudgj3KMqSnEpGbXGRVmTntv6Wnn2+17GBXr25HGYsRCFVpfF+r9V2iL8QOjSW3vFPcL
         0liFM4dxwpkOp8jZpEL19y/d/or42DmQUtB7pa0PPIuWwM/UXrbDAI4+I2px+5jNcdW/
         gvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JgWyHFx4DXLB+RWjYOGV034XoPPQDPd6XzHn420fcvE=;
        b=Sffy+fS+S47pJzRgW6WtkG0x0fgajx7kS3Cmfe3+P/HvudweekOGTL2RoKdNa852xo
         npodCoCK63Aq6R+95+VlN2jLgHB5blrLrW629O/snvs7Dv1dUFAtLgR3uYm36g4DVkz9
         jRVQ7iTyotHgsTRu2NnGS8qLmEsNEjDm2ezAWinjTeV9PUHljhjrX5ar/UYdrQehXumV
         oDr/NvthGW3hkKXqrDYmWIZzyioaI631JDDC5Vam+w4zyrDQH4O1kjQe3JEjhXWHv2mT
         Z7RWqfBFrKTGU1uqcgaDECMKd3MrcA0WBxaRaZsX1gbEm5GfTXHoc23Wf9jWqN+l1ExG
         WYbQ==
X-Gm-Message-State: APjAAAXhCDm6G/zCD+DnEIC5moAXGwnI3iIYHxPlS/xFIYLoCl+WR+4n
        dPWOceJbp2ZApATQf24bU4O4T47JH56pww==
X-Google-Smtp-Source: APXvYqyW6VsneCoGztSNubvE+lqcPqWo8gAIXD7mqMafuwj939/LThcO2TLsSXfwTjkBwSrYxC0IOA==
X-Received: by 2002:a05:6830:1e11:: with SMTP id s17mr3804210otr.343.1579618524452;
        Tue, 21 Jan 2020 06:55:24 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id i2sm13491855oth.39.2020.01.21.06.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:55:23 -0800 (PST)
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
To:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jan Vesely <jano.vesely@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200120023326.GA149019@google.com>
 <b9764896-102c-84cb-32ea-c2a122b6f0db@gmail.com>
 <8409fd7ad6b83da75c914a71accf522953a460a0.camel@pengutronix.de>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <a93f9610-3e78-147d-34b1-d2f7adc31efe@gmail.com>
Date:   Tue, 21 Jan 2020 08:55:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <8409fd7ad6b83da75c914a71accf522953a460a0.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/21/20 5:10 AM, Lucas Stach wrote:
> On Mo, 2020-01-20 at 10:01 -0600, Alex G. wrote:
>>
>> On 1/19/20 8:33 PM, Bjorn Helgaas wrote:
>>> [+cc NVMe, GPU driver folks]
>>>
>>> On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
>>>> I think we have a problem with link bandwidth change notifications
>>>> (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
>>>>
>>>> Here's a recent bug report where Jan reported "_tons_" of these
>>>> notifications on an nvme device:
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=206197
>>>>
>>>> There was similar discussion involving GPU drivers at
>>>> https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
>>>>
>>>> The current solution is the CONFIG_PCIE_BW config option, which
>>>> disables the messages completely.  That option defaults to "off" (no
>>>> messages), but even so, I think it's a little problematic.
>>>>
>>>> Users are not really in a position to figure out whether it's safe to
>>>> enable.  All they can do is experiment and see whether it works with
>>>> their current mix of devices and drivers.
>>>>
>>>> I don't think it's currently useful for distros because it's a
>>>> compile-time switch, and distros cannot predict what system configs
>>>> will be used, so I don't think they can enable it.
>>>>
>>>> Does anybody have proposals for making it smarter about distinguishing
>>>> real problems from intentional power management, or maybe interfaces
>>>> drivers could use to tell us when we should ignore bandwidth changes?
>>>
>>> NVMe, GPU folks, do your drivers or devices change PCIe link
>>> speed/width for power saving or other reasons?  When CONFIG_PCIE_BW=y,
>>> the PCI core interprets changes like that as problems that need to be
>>> reported.
>>>
>>> If drivers do change link speed/width, can you point me to where
>>> that's done?  Would it be feasible to add some sort of PCI core
>>> interface so the driver could say "ignore" or "pay attention to"
>>> subsequent link changes?
>>>
>>> Or maybe there would even be a way to move the link change itself into
>>> the PCI core, so the core would be aware of what's going on?
>>
>> Funny thing is, I was going to suggest an in-kernel API for this.
>>     * Driver requests lower link speed 'X'
>>     * Link management interrupt fires
>>     * If link speed is at or above 'X' then do not report it.
>> I think an "ignore" flag would defeat the purpose of having link
>> bandwidth reporting in the first place. If some drivers set it, and
>> others don't, then it would be inconsistent enough to not be useful.
>>
>> A second suggestion is, if there is a way to ratelimit these messages on
>> a per-downstream port basis.
> 
> Both AMD and Nvidia GPUs have embedded controllers, which are
> responsible for the power management. IIRC those controllers can
> autonomously initiate PCIe link speed changes depending on measured bus
> load. So there is no way for the driver to signal the requested bus
> speed to the PCIe core.
> 
> I guess for the GPU usecase the best we can do is to have the driver
> opt-out of the link bandwidth notifications, as the driver knows that
> there is some autonomous entity on the endpoint mucking with the link
> parameters.

I'm confused. Are you saying that the autonomous mechanism is causing a 
link bandwidth notification?

Alex
