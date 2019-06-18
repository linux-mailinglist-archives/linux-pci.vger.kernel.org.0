Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753514AC0F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 22:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfFRUvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 16:51:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39742 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbfFRUvi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 16:51:38 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hdL4q-0008UQ-Iv; Tue, 18 Jun 2019 14:51:37 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190522201252.2997-1-logang@deltatee.com>
 <20190618204007.GB110859@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <69724119-5037-000c-a711-856703c60429@deltatee.com>
Date:   Tue, 18 Jun 2019 14:51:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618204007.GB110859@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: christian.koenig@amd.com, linux-pci@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,SARE_LWSHORTT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-18 2:40 p.m., Bjorn Helgaas wrote:
> On Wed, May 22, 2019 at 02:12:52PM -0600, Logan Gunthorpe wrote:
>> Presently, there is no path to DMA map P2PDMA memory, so if a TLP
>> targeting this memory hits the root complex and an IOMMU is present,
>> the IOMMU will reject the transaction, even if the RC would support
>> P2PDMA.
>>
>> So until the kernel knows to map these DMA addresses in the IOMMU,
>> we should not enable the whitelist when an IOMMU is present.
>>
>> While we are at it, remove the comment mentioning future work
>> to add a white list.
> 
> There was a lot of discussion about this.  Did everybody come to a
> consensus about what should be done?  Can you post a patch with
> reviewed-by if appropriate?

I think we have consensus that it's broken and needs to be fixed for the
short term. Preferably before 5.3. I'm not sure we have consensus on the
proper fix.

The two easy things I can see to do is to either revert it or add the
iommu_is_present() check that I did in the above patch.

@Christian, which do you prefer? I think I'd prefer the
iommu_is_present() route as it maintains the information about
white-listed devices and is easier to change once we have the correct
solution.

I can send a patch tomorrow one way or another.

Thanks,

Logan
