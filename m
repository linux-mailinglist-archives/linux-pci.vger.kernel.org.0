Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF214BDFB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 17:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgA1QqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 11:46:17 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60252 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1QqR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 11:46:17 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iwU0E-0002I5-OE; Tue, 28 Jan 2020 09:46:16 -0700
To:     "Skidanov, Alexey" <alexey.skidanov@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Heilper, Anat" <anat.heilper@intel.com>,
        "Zadicario, Guy" <guy.zadicario@intel.com>
References: <BYAPR11MB29171883468FD79722FF3652EE0B0@BYAPR11MB2917.namprd11.prod.outlook.com>
 <3b62f9d6-5b93-e252-3419-3fe5307f7935@amd.com>
 <c09a2da5-25e5-445c-3f34-ca6c96686130@deltatee.com>
 <1f3f0f67-865b-0657-da17-896c7b1053fb@amd.com>
 <66ed4842-348d-5bb0-52ba-0236f91ef935@deltatee.com>
 <BYAPR11MB2917B3A25964230EEE61F779EE0A0@BYAPR11MB2917.namprd11.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e07b27a0-9785-2d20-8575-e4f32c0970b3@deltatee.com>
Date:   Tue, 28 Jan 2020 09:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB2917B3A25964230EEE61F779EE0A0@BYAPR11MB2917.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: guy.zadicario@intel.com, anat.heilper@intel.com, linux-pci@vger.kernel.org, alex.williamson@redhat.com, bhelgaas@google.com, christian.koenig@amd.com, alexey.skidanov@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: Disabling ACS for peer-to-peer support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-01-28 12:13 a.m., Skidanov, Alexey wrote:
>> On 2020-01-27 12:12 p.m., Christian König wrote:
>>> Am 27.01.20 um 17:58 schrieb Logan Gunthorpe:
>>>>
>>>> On 2020-01-27 1:18 a.m., Christian König wrote:
>>>>> Am 27.01.20 um 08:18 schrieb Skidanov, Alexey:
>>>>>> Hello,
>>>>>>
>>>>>> I have recently found the below commit to disabling ACS bits. Using kernel parameter
>> is pretty simple but requires to know in advance which devices might be participated in
>> peer-to-peer sessions.
>>>>>>
>>>>>>    Why we can't disable the ACS bits *after* the driver is initialized (and there is a
>> request to connect between two peers) and not *during* device discovering?.
>>>>> That's exactly what was initially proposed but we have seen hardware
>>>>> which reacts allergic to disabling those bits on the fly.
>>>> I wasn't aware of that and haven't seen anything like that.
>>>>
>>>>> Please read up the discussion on the mailing list leading to this patch.
>>>> The issue was the IOMMU code does not allow for any kind of dynamic
>>>> changes in the groups devices are assigned in. In theory, this could be
>>>> possible but you'd still at least have to unbind the devices from their
>>>> driver because you definitely can't change the IOMMU group while there
>>>> are DMA requests in flight. Ultimately it's easier for most use cases to
>>>> just disable it on boot.
>>>
>>> As far as I know you can't change the ACS bit either when there are
>>> transactions in flight on the affected devices/bridges.
>>
>> No, I think the ACS bits are fine to change at any time. I've never had
>> any issue changing them. The problem is the act of changing them changes
>> the isolation between the devices which means the IOMMU groups have to
>> change.
>>
>> It's certainly possible today to just use setpci to adjust those bits at
>> any time. It just means the isolation the IOMMU is expecting will be
>> wrong and that may mean you broke the security between VMs on your machine.
>>
> 
> According to the PCIe spec, there are two mechanisms to deal with isolation:
> - Redirected Request Validation logic within the RC and
> - ACS P2P Egress Control
> So anyone who cares about the isolation must use at least one of these mechanisms. 
> I would expect that on VM creation, the above mechanisms will be configured appropriately. 

That was my expectation too, a long time ago, but that is not how it
works. IOMMU groups are created, on boot, based on the ACS bit settings
(and other mechanisms). Any devices that are not isolated are put in the
same groups. The groups are then used to program the IOMMU such that
each group has it's own virtual address region.

When a VM is created with a PCI passthru device, it will fail if you
don't pass through every device in a each group involved. If the ACS
bits are updated after boot, there is no mechanism to change the groups
so you could create a VM with a device that is not isolated.

Logan
