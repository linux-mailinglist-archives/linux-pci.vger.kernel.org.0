Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CFF29BC6
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390152AbfEXQG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 12:06:29 -0400
Received: from ale.deltatee.com ([207.54.116.67]:56182 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390099AbfEXQG3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 12:06:29 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.141])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hUCiB-0007Lj-A2; Fri, 24 May 2019 10:06:28 -0600
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
 <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
 <20190523094322.GA14986@lst.de>
 <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
 <20190523095057.GA15185@lst.de>
 <252313a9-9af4-14bd-1bfa-1c2327baf2b2@deltatee.com>
 <20190523155922.GA21552@lst.de>
 <c5b050f4-0584-8262-9285-f1c628ed4e27@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <60a2518c-b241-d7a3-28b4-da5b58f0d8d2@deltatee.com>
Date:   Fri, 24 May 2019 10:06:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c5b050f4-0584-8262-9285-f1c628ed4e27@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de, Christian.Koenig@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-05-24 6:40 a.m., Koenig, Christian wrote:
> Am 23.05.19 um 17:59 schrieb Christoph Hellwig:
>> [CAUTION: External Email]
>>
>> On Thu, May 23, 2019 at 09:53:53AM -0600, Logan Gunthorpe wrote:
>>>> The problem shows up if pci_bus_address() returns a different address
>>>> than pci_resource_start(), should be easy to check if that happens.
>>>> IIRC it is something mostly seen on embedded SOCs.
>>>>
>>> I think it's a bit more complicated then that: If you're calling
>>> dma_map_resource() to program the IOMMU then I'm pretty sure you'd want
>>> to use the pci_resource_start() address as the phys_addr_t. If you're
>>> bypassing the root complex (like the current p2pdma code enforces), then
>>> you'd simply use a pci_bus_address() directly as the dma_addr and would
>>> not program the IOMMU at all seeing it's not involved (which is what is
>>> currently done).
>> True.  What we need is:
>>
>>   if (both device are behind the same root port (using a switch)) {
>>          use the current direct map + offset code
>>   } else {
>>          call ->map_resource()
>>   }
> 
> Sounds sane to me as well.
> 
> But since I don't have a struct pages backing my PCI BAR I won't be able 
> to use pci_p2pdma_map_sg.
> 
> How should we work around that?

I'd add something like:

int pci_p2pdma_map_resource(struct pci_dev *provider, struct device
*mapper, phys_addr_t addr, size_t size,  enum dma_data_direction dir,
unsigned long attrs);

But keep in mind we have to update pci_p2pdma_map_sg() as well before we
can enable the whitelist as there are existing users. The map_sg()
command should be able to get the provider device through the pgmap. And
that will be easier to do once Dan's patch[1] lands because he creates a
private pgmap struct.

Logan

[1]
https://lore.kernel.org/lkml/155727338646.292046.9922678317501435597.stgit@dwillia2-desk3.amr.corp.intel.com/T/#u
