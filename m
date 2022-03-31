Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF44EDF33
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 18:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbiCaQ7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiCaQ7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 12:59:33 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C632325DB;
        Thu, 31 Mar 2022 09:57:45 -0700 (PDT)
Message-ID: <b43c542a-0cc6-0f60-3f7b-b16078984c4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648745862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtRqqJsGZabTr8ykV3o87td1KdWyzGvuSkxqwUlvOV0=;
        b=TyiTmwAP7X1MRB16PXjj8l3f6KYq0MhJKsdt6gT4Ek1tYBPWA56Q0SERovHBl2K4ssOANq
        NjgiyDegx6nNsXqqkz3G0pdqVnV+zVi3uh1Snlr01HvrHVRzwHpVijFNThCUjDu7Jw2ssV
        79LisqoCftc4kqElqmLqN0x6Hx1eP3g=
Date:   Thu, 31 Mar 2022 10:57:40 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/3] driver core: Support asynchronous driver shutdown
Content-Language: en-US
To:     Oliver O'Halloran <oohall@gmail.com>,
        Tanjore Suresh <tansuresh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>
References: <20220328230008.3587975-1-tansuresh@google.com>
 <20220328230008.3587975-2-tansuresh@google.com>
 <CAOSf1CHnaKrSH0XwKMBuUmMAuc2q6MaHaZPqVoUia9MYqMjgGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <CAOSf1CHnaKrSH0XwKMBuUmMAuc2q6MaHaZPqVoUia9MYqMjgGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/28/2022 6:19 PM, Oliver O'Halloran wrote:
> On Tue, Mar 29, 2022 at 10:35 AM Tanjore Suresh <tansuresh@google.com> wrote:
>>
>> This changes the bus driver interface with additional entry points
>> to enable devices to implement asynchronous shutdown. The existing
>> synchronous interface to shutdown is unmodified and retained for
>> backward compatibility.
>>
>> This changes the common device shutdown code to enable devices to
>> participate in asynchronous shutdown implementation.
> 
> nice to see someone looking at improving the shutdown path
> 
>> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
>> ---
>>   drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++-
>>   include/linux/device/bus.h | 10 ++++++++++
>>   2 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 3d6430eb0c6a..359e7067e8b8 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
>> *snip*
> 
> This all seems a bit dangerous and I'm wondering what systems you've
> tested these changes with. I had a look at implementing something
> similar a few years ago and one case that always concerned me was
> embedded systems where the PCIe root complex also has a driver bound.
> Say you've got the following PCIe topology:
> 
> 00:00.0 - root port
> 01:00.0 - nvme drive
> 
> With the current implementation of device_shutdown() we can guarantee
> that the child device (the nvme) is shut down before we start trying
> to shut down the parent device (the root complex) so there's no
> possibility of deadlocks and other dependency headaches. With this
> implementation of async shutdown we lose that guarantee and I'm not
> sure what the consequences are. Personally I was never able to
> convince myself it was safe, but maybe you're braver than I am :)
> 
> That all said, there's probably only a few kinds of device that will
> really want to implement async shutdown support so maybe you can
> restrict it to leaf devices and flip the ordering around to something
> like:

It seems like it might be helpful to split the async shutdowns into 
refcounted hierarchies and proceed with the next level up when all the 
refs are in.

Ex:
00:00.0 - RP
   01:00.0 - NVMe A
   02:00.0 - Bridge USP
     03:00.0 - Bridge DSP
       04:00.0 - NVMe B
     03:00.1 - Bridge DSP
       05:00.0 - NVMe C

NVMe A could start shutting down at the beginning of the hierarchy 
traversal. Then async shutdown of bus 3 wouldn't start until all 
children of bus 3 are shutdown.

You could probably do this by having the async_shutdown_list in the pci_bus.

> 
> for_each_device(dev) {
>     if (can_async(dev) && has_no_children(dev))
>        start_async_shutdown(dev)
> }
> wait_for_all_async_shutdowns_to_finish()
> 
> // tear down the remaining system devices synchronously
> for_each_device(dev)
>     do_sync_shutdown(dev)
> 
>>   /*
>> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
>> index a039ab809753..e261819601e9 100644
>> --- a/include/linux/device/bus.h
>> +++ b/include/linux/device/bus.h
>> @@ -93,6 +101,8 @@ struct bus_type {
>>          void (*sync_state)(struct device *dev);
>>          void (*remove)(struct device *dev);
>>          void (*shutdown)(struct device *dev);
>> +       void (*shutdown_pre)(struct device *dev);
>> +       void (*shutdown_post)(struct device *dev);
> 
> Call them shutdown_async_start() / shutdown_async_end() or something
> IMO. These names are not at all helpful and they're easy to mix up
> their role with the class based shutdown_pre / _post
> 
