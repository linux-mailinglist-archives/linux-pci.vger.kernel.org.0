Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F14142F21
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 17:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATQB6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jan 2020 11:01:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37086 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATQB6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2020 11:01:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so186153otn.4;
        Mon, 20 Jan 2020 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VXdi8XklB6KyAj015BObAUcQ6g4YJPJLnITnsX5a8ww=;
        b=csVC36cU6dcTDf2Zl1DPXDbginAQmvFKepoEmSrz6AHr8li3hWipvvR0nBOgjUZSg4
         4ho5z/o5q+gaikMgVTg32uC1Hk7fChYR9Ca5syroXzzPdy4g05HrGojpKPM7mTulLNzF
         pXUUBhPE9CZgMeQcKAROPeFaw7brFGpZC2rrqJq90hqNZMuo6fX/KgJ4/STv3jTT/bSv
         NBv3WeEf7kFm1cFhCk9TLVoHNc1YGCYzrzlGfvDTTWkf5HUl9GI7FAp0uqm4cPVadAgp
         kKVHoYca8ghw58V8GDrEMc+BYi71RqtmazId7n5ufUOxdBXEVyZEaYGfgkovtB3r3clS
         9A9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VXdi8XklB6KyAj015BObAUcQ6g4YJPJLnITnsX5a8ww=;
        b=XiPoEfZFK1qZkdBIxDc9zJFfbsGEaQeyxdUNAPdWJcd6mYtyR7cpq1WoTzXWiLQJNf
         DpNT9MzByOAxvpy7IHYHARrb/3piFsvrkoDbSj1pLW/yDXPXRtpv9tT3ROC9uZ/dKA+y
         IsqqN6Jp2wQjttqmsFLue9sMzAc3QCwLVva6JAMyhFefud0NZlo3+GmCSaNZYtk7hr9o
         P1tW6+KjiVxmVnCIIh/+J6mwccu785XXD7JoLPn1GEyvH6vzr6k6SM9eIYU/G7XOBQ8D
         kHYteuF9X8SyYTwiqeWf26umvu4vjfvdGRS9Xlv5KV1Bzw+H/Nu8YzaGlNjom8+Dtutv
         Q8xg==
X-Gm-Message-State: APjAAAVDyHIXriS7X0UDbmXibqkz4clmDS8q1hVtO0tGBhHkE6qlYWNr
        VA4JNH2uR3xNZAR8znr3rLgmDooBXH/P3w==
X-Google-Smtp-Source: APXvYqwZI2TtC6m78G1th5QuelHiX6MJaJl849WvXQmag61gkQFFV9MuJxO8eAbcdIz9CZuKtD1OYg==
X-Received: by 2002:a05:6830:11d2:: with SMTP id v18mr53623otq.151.1579536116813;
        Mon, 20 Jan 2020 08:01:56 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id c10sm12409405otl.77.2020.01.20.08.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 08:01:56 -0800 (PST)
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
To:     Bjorn Helgaas <helgaas@kernel.org>,
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
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <b9764896-102c-84cb-32ea-c2a122b6f0db@gmail.com>
Date:   Mon, 20 Jan 2020 10:01:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120023326.GA149019@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/19/20 8:33 PM, Bjorn Helgaas wrote:
> [+cc NVMe, GPU driver folks]
> 
> On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
>> I think we have a problem with link bandwidth change notifications
>> (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
>>
>> Here's a recent bug report where Jan reported "_tons_" of these
>> notifications on an nvme device:
>> https://bugzilla.kernel.org/show_bug.cgi?id=206197
>>
>> There was similar discussion involving GPU drivers at
>> https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
>>
>> The current solution is the CONFIG_PCIE_BW config option, which
>> disables the messages completely.  That option defaults to "off" (no
>> messages), but even so, I think it's a little problematic.
>>
>> Users are not really in a position to figure out whether it's safe to
>> enable.  All they can do is experiment and see whether it works with
>> their current mix of devices and drivers.
>>
>> I don't think it's currently useful for distros because it's a
>> compile-time switch, and distros cannot predict what system configs
>> will be used, so I don't think they can enable it.
>>
>> Does anybody have proposals for making it smarter about distinguishing
>> real problems from intentional power management, or maybe interfaces
>> drivers could use to tell us when we should ignore bandwidth changes?
> 
> NVMe, GPU folks, do your drivers or devices change PCIe link
> speed/width for power saving or other reasons?  When CONFIG_PCIE_BW=y,
> the PCI core interprets changes like that as problems that need to be
> reported.
> 
> If drivers do change link speed/width, can you point me to where
> that's done?  Would it be feasible to add some sort of PCI core
> interface so the driver could say "ignore" or "pay attention to"
> subsequent link changes?
> 
> Or maybe there would even be a way to move the link change itself into
> the PCI core, so the core would be aware of what's going on?

Funny thing is, I was going to suggest an in-kernel API for this.
   * Driver requests lower link speed 'X'
   * Link management interrupt fires
   * If link speed is at or above 'X' then do not report it.
I think an "ignore" flag would defeat the purpose of having link 
bandwidth reporting in the first place. If some drivers set it, and 
others don't, then it would be inconsistent enough to not be useful.

A second suggestion is, if there is a way to ratelimit these messages on 
a per-downstream port basis.

Alex
