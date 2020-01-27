Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A3614AA53
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 20:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgA0TRQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 14:17:16 -0500
Received: from ale.deltatee.com ([207.54.116.67]:44268 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgA0TRQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 14:17:16 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iw9sn-0002SN-SE; Mon, 27 Jan 2020 12:17:14 -0700
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Skidanov, Alexey" <alexey.skidanov@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Heilper, Anat" <anat.heilper@intel.com>,
        "Zadicario, Guy" <guy.zadicario@intel.com>
References: <BYAPR11MB29171883468FD79722FF3652EE0B0@BYAPR11MB2917.namprd11.prod.outlook.com>
 <3b62f9d6-5b93-e252-3419-3fe5307f7935@amd.com>
 <c09a2da5-25e5-445c-3f34-ca6c96686130@deltatee.com>
 <1f3f0f67-865b-0657-da17-896c7b1053fb@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <66ed4842-348d-5bb0-52ba-0236f91ef935@deltatee.com>
Date:   Mon, 27 Jan 2020 12:17:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1f3f0f67-865b-0657-da17-896c7b1053fb@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: guy.zadicario@intel.com, anat.heilper@intel.com, linux-pci@vger.kernel.org, alex.williamson@redhat.com, bhelgaas@google.com, alexey.skidanov@intel.com, christian.koenig@amd.com
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



On 2020-01-27 12:12 p.m., Christian König wrote:
> Am 27.01.20 um 17:58 schrieb Logan Gunthorpe:
>>
>> On 2020-01-27 1:18 a.m., Christian König wrote:
>>> Am 27.01.20 um 08:18 schrieb Skidanov, Alexey:
>>>> Hello,
>>>>
>>>> I have recently found the below commit to disabling ACS bits. Using kernel parameter is pretty simple but requires to know in advance which devices might be participated in peer-to-peer sessions.
>>>>
>>>>    Why we can't disable the ACS bits *after* the driver is initialized (and there is a request to connect between two peers) and not *during* device discovering?.
>>> That's exactly what was initially proposed but we have seen hardware
>>> which reacts allergic to disabling those bits on the fly.
>> I wasn't aware of that and haven't seen anything like that.
>>
>>> Please read up the discussion on the mailing list leading to this patch.
>> The issue was the IOMMU code does not allow for any kind of dynamic
>> changes in the groups devices are assigned in. In theory, this could be
>> possible but you'd still at least have to unbind the devices from their
>> driver because you definitely can't change the IOMMU group while there
>> are DMA requests in flight. Ultimately it's easier for most use cases to
>> just disable it on boot.
> 
> As far as I know you can't change the ACS bit either when there are 
> transactions in flight on the affected devices/bridges.

No, I think the ACS bits are fine to change at any time. I've never had
any issue changing them. The problem is the act of changing them changes
the isolation between the devices which means the IOMMU groups have to
change.

It's certainly possible today to just use setpci to adjust those bits at
any time. It just means the isolation the IOMMU is expecting will be
wrong and that may mean you broke the security between VMs on your machine.

> Otherwise what could happen is that the response of an transaction takes 
> a different path than the request. That in turn can result in quite a 
> bunch of ordering problem on the PCIe bus.
> 
> But the idea of unbinding a device, changing the bit and rebinding it 
> would probably work.

Well, no, you can't just change the bit, you have to change the IOMMU
group the device belongs to. Right now, we don't have any interface to
do that except during scanning at boot.

Logan
