Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC62728199
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfEWPrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 11:47:49 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49554 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbfEWPrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 11:47:49 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hTpwZ-0007MW-BY; Thu, 23 May 2019 09:47:48 -0600
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
 <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d7de51fc-b231-407e-ecad-0cf6be08541e@deltatee.com>
Date:   Thu, 23 May 2019 09:47:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de, Christian.Koenig@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-05-23 2:12 a.m., Koenig, Christian wrote:
>> Are you DMA-mapping the addresses outside the P2PDMA code? If so there's
>> a huge mismatch with the existing users of P2PDMA (nvme-fabrics). If
>> you're not dma-mapping then I can't see how it could work because the
>> IOMMU should reject any requests to access those addresses.
> 
> Well, we are using the DMA API (dma_map_resource) for this. If the P2P 
> code is not using this then I would rather say that the P2P code is 
> actually broken.

No, the P2P code is doing what it was designed to do: peer-to-peer
without going through the root complex. If you DMA map in the presence
of an IOMMU, then you force the TLPs to go through the root complex.
This is not what we want and will not be supported by some RCs so you
effectively drop support for everything but the one entry you've added
in the white list. If we're going to start allowing transactions to go
through an IOMMU then the existing users of P2PDMA needs to be updated
to support this without dropping support for existing use cases.

>> By adding the whitelist in this way you will break any user that
>> attempts to use P2P in nvme-fabrics on whitelisted RCs with an IOMMU
>> enabled.
>>
>> Currently, the users of P2PDMA use pci_p2pdma_map_sg() which only
>> returns the PCI bus address. If P2PDMA transactions can now go through
>> an IOMMU, then this is wrong and broken.
>>
>> We need to ensure that all users of P2PDMA map this memory in the same
>> way. Which means, if the TLPs will go through an IOMMU they get
>> dma-map'd and, if they don't, they use the PCI Bus address (as the
>> current code does).
> 
> Well that is exactly what dma_map_resource() already does, so we should 
> probably just make using the DMA API mandatory.

No, it's absolutely not what dma_map_resource() does. DMA map resource
only adds IOVA addresses in the IOMMU for a physical address (if an
IOMMU is present). It does not determine whether that's appropriate to
do for a given transaction. Such logic would belong in pci_p2pdma_map_*
helpers.

>> Without the change proposed in this patch, I have to retract my review
>> and NAK your patch until we can sort out the mapping issues.
> 
> Yeah, completely agree we can't do that right now.

Why not? It's not that complicated. We just need a way for
pci_p2pdma_map_* to determine if the transfer path involves the IOMMU.
If it does, call an existing dma_map_* function, if it does not then do
what it currently does and use the PCI bus address. This probably means
creating some kind of cache with flags for the distance between devices.

Logan
