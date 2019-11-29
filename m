Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6810D90F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 18:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK2R1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 12:27:04 -0500
Received: from ale.deltatee.com ([207.54.116.67]:35734 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfK2R1E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Nov 2019 12:27:04 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iak2k-0008Lo-N5; Fri, 29 Nov 2019 10:26:59 -0700
To:     James Sewart <jamessewart@arista.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
 <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
Date:   Fri, 29 Nov 2019 10:26:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: helgaas@kernel.org, alex.williamson@redhat.com, dima@arista.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, 0x7f454c46@gmail.com, hch@infradead.org, linux-pci@vger.kernel.org, jamessewart@arista.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v4 1/2] PCI: Add parameter nr_devfns to pci_add_dma_alias
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-11-29 10:19 a.m., James Sewart wrote:
> 
> 
>> On 29 Nov 2019, at 16:50, Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2019-11-29 5:49 a.m., James Sewart wrote:
>>> pci_add_dma_alias can now be used to create a dma alias for a range of
>>> devfns.
>>>
>>> Signed-off-by: James Sewart <jamessewart@arista.com>
>>> ---
>>> drivers/pci/pci.c    | 23 ++++++++++++++++++-----
>>> drivers/pci/quirks.c | 14 +++++++-------
>>> include/linux/pci.h  |  2 +-
>>> 3 files changed, 26 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index a97e2571a527..9b0e3481fe17 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -5857,7 +5857,8 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>>> /**
>>>  * pci_add_dma_alias - Add a DMA devfn alias for a device
>>>  * @dev: the PCI device for which alias is added
>>> - * @devfn: alias slot and function
>>> + * @devfn_from: alias slot and function
>>> + * @nr_devfns: Number of subsequent devfns to alias
>>>  *
>>>  * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
>>>  * which is used to program permissible bus-devfn source addresses for DMA
>>> @@ -5873,8 +5874,14 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>>>  * cannot be left as a userspace activity).  DMA aliases should therefore
>>>  * be configured via quirks, such as the PCI fixup header quirk.
>>>  */
>>> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>>> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
>>> {
>>> +	int devfn_to;
>>> +
>>> +	if (nr_devfns > U8_MAX+1)
>>> +		nr_devfns = U8_MAX+1;
>>
>> Why +1? That doesn't seem right to me….
> 
> U8_MAX is the max number U8 can represent(255) but is one less than the number 
> of values it can represent(256). devfns can be 0.0 to 1f.7 inclusive(I think) 
> so the number of possible devfns is 256. Thinking about it, maybe the 
> zalloc should be U8_MAX+1 too?
> 
> I might be wrong though, what do you reckon?

Right, yes, but I actually think the original code is wrong. It's only
allocating a bitmap that holds 255 values and you're trying to insert
256 ones into that bitmap. It's probably ok, because there's no way to
allocate an odd sized bitmap, but it's probably worth fixing for clarity.

It also looks wrong in pci_for_each_dma_alias() as well, so I'd probably
fix both those up in a separate prep-patch.

Logan
