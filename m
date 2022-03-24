Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D974E617D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 11:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349419AbiCXKJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 06:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349413AbiCXKJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 06:09:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA6289F6F9
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 03:08:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E46321515;
        Thu, 24 Mar 2022 03:08:23 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B35B3F73D;
        Thu, 24 Mar 2022 03:08:22 -0700 (PDT)
Message-ID: <2d314989-874c-a547-1192-5b5ff49d98b2@arm.com>
Date:   Thu, 24 Mar 2022 10:08:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] iommu/dma: Explicitly sort PCI DMA windows
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        dann frazier <dann.frazier@canonical.com>
References: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
 <CAL_Jsq+x5kOcr6J1w2v0Xc=5M+51f5Qy_zkm5yFP9c4ZitSMTQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAL_Jsq+x5kOcr6J1w2v0Xc=5M+51f5Qy_zkm5yFP9c4ZitSMTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-03-24 00:56, Rob Herring wrote:
> On Tue, Mar 22, 2022 at 12:27 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Originally, creating the dma_ranges resource list in pre-sorted fashion
>> was the simplest and most efficient way to enforce the order required by
>> iova_reserve_pci_windows(). However since then at least one PCI host
>> driver is now re-sorting the list for its own probe-time processing,
>> which doesn't seem entirely unreasonable, so that basic assumption no
>> longer holds. Make iommu-dma robust and get the sort order it needs by
>> explicitly sorting, which means we can also save the effort at creation
>> time and just build the list in whatever natural order the DT had.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> Looking at this area off the back of the XGene thread[1] made me realise
>> that we need to do it anyway, regardless of whether it might also happen
>> to restore the previous XGene behaviour or not. Presumably nobody's
>> tried to use pcie-cadence-host behind an IOMMU yet...
>>
>> Boot-tested on Juno to make sure I hadn't got the sort comparison
>> backwards.
>>
>> Robin.
>>
>> [1] https://lore.kernel.org/linux-pci/20220321104843.949645-1-maz@kernel.org/
>>
>>   drivers/iommu/dma-iommu.c | 13 ++++++++++++-
>>   drivers/pci/of.c          |  7 +------
>>   2 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index b22034975301..91d134c0c9b1 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/iommu.h>
>>   #include <linux/iova.h>
>>   #include <linux/irq.h>
>> +#include <linux/list_sort.h>
>>   #include <linux/mm.h>
>>   #include <linux/mutex.h>
>>   #include <linux/pci.h>
>> @@ -414,6 +415,15 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
>>          return 0;
>>   }
>>
>> +static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
>> +               const struct list_head *b)
>> +{
>> +       struct resource_entry *res_a = list_entry(a, typeof(*res_a), node);
>> +       struct resource_entry *res_b = list_entry(b, typeof(*res_b), node);
>> +
>> +       return res_a->res->start > res_b->res->start;
>> +}
>> +
>>   static int iova_reserve_pci_windows(struct pci_dev *dev,
>>                  struct iova_domain *iovad)
>>   {
>> @@ -432,6 +442,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>>          }
>>
>>          /* Get reserved DMA windows from host bridge */
>> +       list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
>>          resource_list_for_each_entry(window, &bridge->dma_ranges) {
>>                  end = window->res->start - window->offset;
>>   resv_iova:
>> @@ -440,7 +451,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>>                          hi = iova_pfn(iovad, end);
>>                          reserve_iova(iovad, lo, hi);
>>                  } else if (end < start) {
>> -                       /* dma_ranges list should be sorted */
>> +                       /* DMA ranges should be non-overlapping */
>>                          dev_err(&dev->dev,
>>                                  "Failed to reserve IOVA [%pa-%pa]\n",
>>                                  &start, &end);
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index cb2e8351c2cc..d176b4bc6193 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -393,12 +393,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>>                          goto failed;
>>                  }
>>
>> -               /* Keep the resource list sorted */
>> -               resource_list_for_each_entry(entry, ib_resources)
>> -                       if (entry->res->start > res->start)
>> -                               break;
>> -
>> -               pci_add_resource_offset(&entry->node, res,
> 
> entry is now unused and causes a warning.

Sigh, seems the problem with CONFIG_WERROR is that once you think it's 
enabled, you then stop paying much attention to the build log...

Thanks for the catch,
Robin.

> 
>> +               pci_add_resource_offset(ib_resources, res,
>>                                          res->start - range.pci_addr);
>>          }
>>
>> --
>> 2.28.0.dirty
>>
