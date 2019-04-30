Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5CD10255
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 00:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfD3WZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 18:25:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35741 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfD3WZr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Apr 2019 18:25:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id g24so8851808otq.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2019 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZmBG3hM4lGU6ZmXmSmggSOXpEizpcpagPEE7Vhmbuvs=;
        b=oefuz6OnRRxk8/mLQrXe07mu7tqQkeBedTZ2WiHugxjObG+KoJLqG9xkKKJgGuLx9A
         IjhB+nR8q5tGG1e1wd5ogRlqNAKvr9Nn59vrrHCM5YFM3X8OWThLAEKBsWXqgtdBFaPS
         9BAYNcoJ21xdnceaUmFwkit60XJJ3YioEEVPzoj9Rezrl8xQxH/h0Mz9YHFtQ3gsq3Ik
         K3g2NGXpRRGgHmEG7WCgvpAUfJXsrnmwbZKYCMYa3Hy32Qb8SK9oQSwxahwvbPfmNSMN
         H7cUOj+g9C/p+ikMDEA336PQDwJoX8USUwgrgjF6Zocmuee8a8CpqbXFAf8y3F9eA84v
         o9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZmBG3hM4lGU6ZmXmSmggSOXpEizpcpagPEE7Vhmbuvs=;
        b=TXY/loWJhB8bzmEqi4MYJS23YFwJ+ipeULjKMWaDqWUrjkieAmjc7dOkUalbX0/Omy
         uZulQMyM0M6nmU9BDIEMV0GCMUgwRlHLknwVRk87hVOk7NpxwTpbyRGNCpMatM/NcpIt
         /2pRWaOOEbl51WVeB4JFCk6hFnBWjVmF7bl3E0WH5e0JnNmXQRf4UHJ76G/Ggj7iCdvl
         MdWptR1urmpvWZgWM+fvDlWJcp3tQ5yZ7Yk7EHL6KvGqdgy0lrtC8f3O6r7iuXA3VrAf
         13UFpxqy84kp83bZRIgQTXZk9oAuHAQVvv+1Z3ptiIJcIGjgOuSqtdkVDMUJb0PORHnJ
         NoUA==
X-Gm-Message-State: APjAAAVmFjDjoINM77yehh8BFw3awnk+Lf3Ch18/5SMzrSxbvQOAKOpG
        7KmKGV19SiPhFLVdq1kB0G1+Sg==
X-Google-Smtp-Source: APXvYqz1gCRDHfb1sDmOtyctdeSQ9SceBv6EjONrVNfjJC0L/rdUvcgkuDj3iKUf2l3hH9D78aWeQQ==
X-Received: by 2002:a9d:5d0b:: with SMTP id b11mr4169059oti.80.1556663146354;
        Tue, 30 Apr 2019 15:25:46 -0700 (PDT)
Received: from Fredericks-MacBook-Pro.local ([2600:1700:18a0:11d0:99ba:d92:93c8:8fb9])
        by smtp.gmail.com with ESMTPSA id h8sm15482635oti.64.2019.04.30.15.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:25:45 -0700 (PDT)
Subject: Re: [PATCH 1/4] PCI: Replace dev_*() printk wrappers with pci_*()
 printk wrappers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-2-fred@fredlawl.com>
 <20190429000258.GK14616@google.com> <20190429005222.GO14616@google.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <d68b1e74-dc52-28dc-0e14-de17594f39ca@fredlawl.com>
Date:   Tue, 30 Apr 2019 17:26:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.14
MIME-Version: 1.0
In-Reply-To: <20190429005222.GO14616@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

Bjorn Helgaas wrote on 4/28/19 7:52 PM:
> On Sun, Apr 28, 2019 at 07:02:58PM -0500, Bjorn Helgaas wrote:
>> On Sat, Apr 27, 2019 at 02:13:01PM -0500, fred@fredlawl.com wrote:
>>> From: Frederick Lawler <fred@fredlawl.com>
>>>
>>> Replace remaining instances of dev_*() printk wrappers with pci_*()
>>> printk wrappers. No functional change intended.
>>>
>>> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
>>> ---
>>>   drivers/pci/pcie/aer.c        | 13 ++++++-------
>>>   drivers/pci/pcie/aer_inject.c |  4 ++--
>>>   drivers/pci/pcie/dpc.c        | 27 ++++++++++++---------------
>>>   3 files changed, 20 insertions(+), 24 deletions(-)
> 
>>>   	aer_enable_rootport(rpc);
>>> -	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
>>> +	pci_info(pdev, "AER enabled with IRQ %d\n", dev->irq);
>>
>> And this, and many others below.  *This* patch should only convert
>>
>>    - pci_printk(KERN_DEBUG, pdev, ...)
>>    + pci_info(pdev, ...)
>>
>> and
>>
>>    - dev_printk(KERN_DEBUG, pcie_dev, ...)
>>    + dev_info(pcie_dev, ...)
> 
> Just to clarify, I do *want* both changes, just in separate patches.
> So we'd have
> 
>    1) Convert KERN_DEBUG uses to pci_info() for pci_dev usage and to
>       dev_info() for pcie_device usage.  I think pciehp is probably an
>       exception to this; this patch shouldn't touch ctrl_dbg().
> 
>    2) Convert "dev_info(pcie_device)" to "pci_info(pci_dev)".  It might
>       be worth doing this in separate patches for each service.  If we
>       decide they're simple enough to combine, that's trivial for me to
>       do.  It's a little more hassle to split things up afterwards.
> 
>       In pciehp, if you do this in the ctrl_*() definitions, it will
>       make the patch much smaller.
> 
>    3) In pciehp, ctrl_dbg() could probably be changed to use pci_dbg()
>       so we'd use the standard kernel dynamic debug stuff instead of
>       having the pciehp-specific module parameter.
> 
> Thanks a lot for working on all this.  I think it will make the user
> experience significantly simpler.
> 
> Bjorn
> 

Will do, thanks!

Frederick Lawler

