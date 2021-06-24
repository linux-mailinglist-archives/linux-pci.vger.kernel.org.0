Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E73B2D75
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 13:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhFXLRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 07:17:12 -0400
Received: from foss.arm.com ([217.140.110.172]:54180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232118AbhFXLRL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 07:17:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3321E1063;
        Thu, 24 Jun 2021 04:14:52 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72B7B3F718;
        Thu, 24 Jun 2021 04:14:44 -0700 (PDT)
Subject: Re: [PATCH v14 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
To:     Claire Chang <tientzu@chromium.org>, Christoph Hellwig <hch@lst.de>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
        peterz@infradead.org, benh@kernel.crashing.org,
        joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
        chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
        mingo@kernel.org, Jianxiong Gao <jxgao@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bskeggs@redhat.com, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
        jani.nikula@linux.intel.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, bauerman@linux.ibm.com
References: <20210619034043.199220-1-tientzu@chromium.org>
 <20210619034043.199220-7-tientzu@chromium.org>
 <76c3343d-72e5-9df3-8924-5474ee698ef4@quicinc.com>
 <20210623183736.GA472@willie-the-truck>
 <19d4c7a2-744d-21e0-289c-a576e1f0e6f3@quicinc.com>
 <20210624054315.GA25381@lst.de>
 <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <364e6715-eafd-fc4a-e0af-ce2a042756b4@arm.com>
Date:   Thu, 24 Jun 2021 12:14:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-06-24 07:05, Claire Chang wrote:
> On Thu, Jun 24, 2021 at 1:43 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Wed, Jun 23, 2021 at 02:44:34PM -0400, Qian Cai wrote:
>>> is_swiotlb_force_bounce at /usr/src/linux-next/./include/linux/swiotlb.h:119
>>>
>>> is_swiotlb_force_bounce() was the new function introduced in this patch here.
>>>
>>> +static inline bool is_swiotlb_force_bounce(struct device *dev)
>>> +{
>>> +     return dev->dma_io_tlb_mem->force_bounce;
>>> +}
>>
>> To me the crash looks like dev->dma_io_tlb_mem is NULL.  Can you
>> turn this into :
>>
>>          return dev->dma_io_tlb_mem && dev->dma_io_tlb_mem->force_bounce;
>>
>> for a quick debug check?
> 
> I just realized that dma_io_tlb_mem might be NULL like Christoph
> pointed out since swiotlb might not get initialized.
> However,  `Unable to handle kernel paging request at virtual address
> dfff80000000000e` looks more like the address is garbage rather than
> NULL?
> I wonder if that's because dev->dma_io_tlb_mem is not assigned
> properly (which means device_initialize is not called?).

What also looks odd is that the base "address" 0xdfff800000000000 is 
held in a couple of registers, but the offset 0xe looks too small to 
match up to any relevant structure member in that dereference chain :/

Robin.
