Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73E709479
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 12:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjESKIn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 06:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjESKIn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 06:08:43 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31635102;
        Fri, 19 May 2023 03:08:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vj-PkJA_1684490913;
Received: from 30.240.113.228(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vj-PkJA_1684490913)
          by smtp.aliyun-inc.com;
          Fri, 19 May 2023 18:08:34 +0800
Message-ID: <09097e1e-fdf3-31ce-fadf-3c75dfc71fa2@linux.alibaba.com>
Date:   Fri, 19 May 2023 18:08:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v3 2/3] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, yangyicong@huawei.com,
        will@kernel.org, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        linux-cxl@vger.kernel.org
References: <ZGUAWxoEngmqFcLJ@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ZGUAWxoEngmqFcLJ@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/5/18 00:27, Bjorn Helgaas wrote:
> On Wed, May 17, 2023 at 10:54:21AM +0100, Jonathan Cameron wrote:
>> On Tue, 16 May 2023 14:17:52 -0500
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>>> On Tue, May 16, 2023 at 04:03:04PM +0100, Jonathan Cameron wrote:
>> ...
> 
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

I agree "walk all PCI devices looking for one we like" approach is terrible
in general. And I am glad to modify my code to adapt to a more suitable solution
when it comes.

For now, I will collect comments from v3 and v4 and send a new version after
addressed them. Any alternative option is welcomed, always :)

> Bjorn

Thank you.

Best Regards,
Shuai
