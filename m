Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA139281D5
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 17:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfEWPxz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 11:53:55 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49658 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbfEWPxz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 11:53:55 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hTq2U-0007Ph-6a; Thu, 23 May 2019 09:53:54 -0600
To:     Christoph Hellwig <hch@lst.de>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
 <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
 <20190523094322.GA14986@lst.de>
 <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
 <20190523095057.GA15185@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <252313a9-9af4-14bd-1bfa-1c2327baf2b2@deltatee.com>
Date:   Thu, 23 May 2019 09:53:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523095057.GA15185@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, Christian.Koenig@amd.com, hch@lst.de
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



On 2019-05-23 3:50 a.m., Christoph Hellwig wrote:
> On Thu, May 23, 2019 at 09:48:40AM +0000, Koenig, Christian wrote:
>> I don't adjust the address manually anywhere. I just call 
>> dma_map_resource() and use the resulting DMA address to access the other 
>> devices PCI BAR.
>>
>> At least on my test system (AMD CPU + AMD GPUs) this seems to work 
>> totally fine. Currently trying to find time and an Intel box to test it 
>> there as well.
> 
> The problem shows up if pci_bus_address() returns a different address
> than pci_resource_start(), should be easy to check if that happens.
> IIRC it is something mostly seen on embedded SOCs.
> 

I think it's a bit more complicated then that: If you're calling
dma_map_resource() to program the IOMMU then I'm pretty sure you'd want
to use the pci_resource_start() address as the phys_addr_t. If you're
bypassing the root complex (like the current p2pdma code enforces), then
you'd simply use a pci_bus_address() directly as the dma_addr and would
not program the IOMMU at all seeing it's not involved (which is what is
currently done).

Logan
