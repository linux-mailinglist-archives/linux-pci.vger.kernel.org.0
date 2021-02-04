Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83C730F2B5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhBDLuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 06:50:19 -0500
Received: from foss.arm.com ([217.140.110.172]:56926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235683AbhBDLuS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 06:50:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E69ABD6E;
        Thu,  4 Feb 2021 03:49:31 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C76A3F73B;
        Thu,  4 Feb 2021 03:49:25 -0800 (PST)
Subject: Re: [PATCH RFC v1 2/6] swiotlb: convert variables to arrays
To:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nouveau@lists.freedesktop.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        akpm@linux-foundation.org, benh@kernel.crashing.org,
        bskeggs@redhat.com, bhelgaas@google.com, bp@alien8.de,
        boris.ostrovsky@oracle.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, hpa@zytor.com, mingo@kernel.org,
        mingo@redhat.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, jgross@suse.com,
        konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        matthew.auld@intel.com, mpe@ellerman.id.au, rppt@kernel.org,
        paulus@samba.org, peterz@infradead.org, rodrigo.vivi@intel.com,
        sstabellini@kernel.org, bauerman@linux.ibm.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de,
        ulf.hansson@linaro.org, joe.jin@oracle.com,
        thomas.lendacky@amd.com, Claire Chang <tientzu@chromium.org>
References: <20210203233709.19819-1-dongli.zhang@oracle.com>
 <20210203233709.19819-3-dongli.zhang@oracle.com>
 <20210204072947.GA29812@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b46ddefe-d91a-fa6a-0e0d-cf1edc343c2e@arm.com>
Date:   Thu, 4 Feb 2021 11:49:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204072947.GA29812@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-02-04 07:29, Christoph Hellwig wrote:
> On Wed, Feb 03, 2021 at 03:37:05PM -0800, Dongli Zhang wrote:
>> This patch converts several swiotlb related variables to arrays, in
>> order to maintain stat/status for different swiotlb buffers. Here are
>> variables involved:
>>
>> - io_tlb_start and io_tlb_end
>> - io_tlb_nslabs and io_tlb_used
>> - io_tlb_list
>> - io_tlb_index
>> - max_segment
>> - io_tlb_orig_addr
>> - no_iotlb_memory
>>
>> There is no functional change and this is to prepare to enable 64-bit
>> swiotlb.
> 
> Claire Chang (on Cc) already posted a patch like this a month ago,
> which looks much better because it actually uses a struct instead
> of all the random variables.

Indeed, I skimmed the cover letter and immediately thought that this 
whole thing is just the restricted DMA pool concept[1] again, only from 
a slightly different angle.

Robin.

[1] 
https://lore.kernel.org/linux-iommu/20210106034124.30560-1-tientzu@chromium.org/
