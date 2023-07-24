Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A775F5B6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 14:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGXMNj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjGXMNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 08:13:38 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68B7E61;
        Mon, 24 Jul 2023 05:13:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vo91cmw_1690200808;
Received: from 30.240.115.26(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vo91cmw_1690200808)
          by smtp.aliyun-inc.com;
          Mon, 24 Jul 2023 20:13:30 +0800
Message-ID: <3dba0c90-9673-eadd-4f82-353ae48567a7@linux.alibaba.com>
Date:   Mon, 24 Jul 2023 20:13:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/4] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com
References: <20230606074938.97724-1-xueshuai@linux.alibaba.com>
 <204e3891-c041-53ae-a965-f3abec2cc091@linux.alibaba.com>
 <161dc5b6-7c20-ea8c-2efb-9594e94df2d3@linux.alibaba.com>
 <5db5aaf0-4fb7-a017-3b6f-017d04a93d33@linux.alibaba.com>
 <20230724101807.000012bf@Huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230724101807.000012bf@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/24 17:18, Jonathan Cameron wrote:
> Really a question for Bjorn I think, but here is my 2 cents...
> 
> The problem here is that we need to do that fundamental redesign of the
> way the PCI ports drivers work.  I'm not sure there is a path to merging
> this until that is done.  The bigger problem is that I'm not sure anyone
> is actively looking at that yet.  I'd like to look at this (as I have
> the same problem for some other drivers), but it is behind various
> other things on my todo list.
> 
> Bjorn might be persuaded on a temporary solution, but that would come
> with some maintenance problems, particularly when we try to do it
> 'right' in the future.  Maybe adding another service driver would be
> a stop gap as long as we know we won't keep doing so for ever. Not sure.

Thank you for your reply, and got your point, :)

+ Bjorn


>>>> The approach used here is to separately walk the PCI topology and
>>>> register the devices.  It can 'maybe' get away with that because no
>>>> interrupts and I assume resets have no nasty impacts on it because
>>>> the device is fairly simple.  In general that's not going to work.
>>>> CXL does a similar trick (which I don't much like, but too late
>>>> now), but we've also run into the problem of how to get interrupts
>>>> if not the main driver.
>>>
>>> Yes, this is a real problem.  I think the "walk all PCI devices
>>> looking for one we like" approach is terrible because it breaks a lot
>>> of driver model assumptions (no device ID to autoload module via udev,
>>> hotplug doesn't work, etc), but we don't have a good alternative right
>>> now.
>>>
>>> I think portdrv is slightly better because at least it claims the
>>> device in the usual way and gives a way for service drivers to
>>> register with it.  But I don't really like that either because it
>>> created a new weird /sys/bus/pci_express hierarchy full of these
>>> sub-devices that aren't really devices, and it doesn't solve the
>>> module load and hotplug issues.
>>>
>>> I would like to have portdrv be completely built into the PCI core and
>>> not claim Root Ports or Switch Ports.  Then those devices would be
>>> available via the usual driver model for driver loading and binding
>>> and for hotplug.
>>
>> Let me see if I understand this correctly as I can think of a few options
>> that perhaps are inline with what you are thinking.
>>
>> 1) All the portdrv stuff converted to normal PCI core helper functions
>>    that a driver bound to the struct pci_dev can use.
>> 2) Driver core itself provides a bunch of extra devices alongside the
>>    struct pci_dev one to which additional drivers can bind? - so kind
>>    of portdrv handling, but squashed into the PCI device topology?
>> 3) Have portdrv operated under the hood, so all the services etc that
>>    it provides don't require a driver to be bound at all.  Then
>>    allow usual VID/DID based driver binding.
>>
>> If 1 - we are going to run into class device restrictions and that will
>> just move where we have to handle the potential vendor specific parts.
>> We probably don't want that to be a hydra with all the functionality
>> and lookups etc driven from there, so do we end up with sub devices
>> of that new PCI port driver with a discover method based on either
>> vsec + VID or DVSEC with devices created under the main pci_dev.
>> That would have to include nastiness around interrupt discovery for
>> those sub devices. So ends up roughly like port_drv.
>>
>> I don't think 2 solves anything.
>>
>> For 3 - interrupts and ownership of facilities is going to be tricky
>> as initially those need to be owned by the PCI core (no device driver bound)
>> and then I guess handed off to the driver once it shows up?  Maybe that
>> driver should call a pci_claim_port() that gives it control of everything
>> and pci_release_port() that hands it all back to the core.  That seems
>> racey.
>
> Yes, 3 is the option I want to explore.  That's what we already do for
> things like ASPM.  Agreed, interrupts is a potential issue.  I think
> the architected parts of config space should be implicitly owned by
> the PCI core, with interfaces à la pci_disable_link_state() if drivers
> need them.
>
> Bjorn
> https://lore.kernel.org/lkml/ZGUAWxoEngmqFcLJ@bhelgaas/

@Bjorn Is there a path to merging this patch set until your explore is done?
And are you still actively looking at that yet?

I am not quite familiar with PCI core, but I would like to help work on that.

Thank you.

Best Regards,
Shuai
