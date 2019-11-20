Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B047104459
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 20:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKTTay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 14:30:54 -0500
Received: from ale.deltatee.com ([207.54.116.67]:57986 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfKTTay (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 14:30:54 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iXVgh-00024K-6G; Wed, 20 Nov 2019 12:30:52 -0700
To:     Dmitry Safonov <0x7f454c46@gmail.com>,
        James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <A3FA9DE1-2EEF-41D8-9AC2-B1F760E7F5D5@arista.com>
 <0B8FAD0D-B598-4CEA-A614-67F4C7C5B9CA@arista.com>
 <5c3b56dd-7088-e544-6628-01506f7b84e8@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c683ec65-40a9-6430-ae85-ce3934ed8af5@deltatee.com>
Date:   Wed, 20 Nov 2019 12:30:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5c3b56dd-7088-e544-6628-01506f7b84e8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, dima@arista.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jamessewart@arista.com, 0x7f454c46@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] Ensure pci transactions coming from PLX NTB are handled
 when IOMMU is turned on
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-11-20 10:48 a.m., Dmitry Safonov wrote:
> +Cc: linux-pci@vger.kernel.org
> +Cc: Bjorn Helgaas <bhelgaas@google.com>
> +Cc: Logan Gunthorpe <logang@deltatee.com>
> 
> On 11/5/19 12:17 PM, James Sewart wrote:
>> Any comments on this?
>>
>> Cheers,
>> James.
>>
>>> On 24 Oct 2019, at 13:52, James Sewart <jamessewart@arista.com> wrote:
>>>
>>> The PLX PEX NTB forwards DMA transactions using Requester ID's that don't exist as
>>> PCI devices. The devfn for a transaction is used as an index into a lookup table
>>> storing the origin of a transaction on the other side of the bridge.
>>>
>>> This patch aliases all possible devfn's to the NTB device so that any transaction
>>> coming in is governed by the mappings for the NTB.
>>>
>>> Signed-Off-By: James Sewart <jamessewart@arista.com>
>>> ---
>>> drivers/pci/quirks.c | 22 ++++++++++++++++++++++
>>> 1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 320255e5e8f8..647f546e427f 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
>>> SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
>>> SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
>>>
>>> +/*
>>> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
>>> + * are used to forward responses to the originator on the other side of the
>>> + * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
>>> + * turned on.
>>> + */
>>> +static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)
>>> +{
>>> +	if (!pdev->dma_alias_mask)
>>> +		pdev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
>>> +					      sizeof(long), GFP_KERNEL);
>>> +	if (!pdev->dma_alias_mask) {
>>> +		dev_warn(&pdev->dev, "Unable to allocate DMA alias mask\n");
>>> +		return;
>>> +	}
>>> +
>>> +	// PLX NTB may use all 256 devfns
>>> +	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);

I think it would be better to create a pci_add_dma_alias_range()
function instead of directly accessing dma_alias_mask. We could then use
that function to clean up quirk_switchtec_ntb_dma_alias() which is
essentially doing the same thing.

It's also quite ugly that you're allocating with kcalloc here instead of
bitmap_zalloc() seeing it will be free'd with bitmap_free(). Also, you
should probably use bitmap_set() instead of memset().

Logan
