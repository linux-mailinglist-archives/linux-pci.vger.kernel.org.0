Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05723B2086
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 20:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFWSrA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 14:47:00 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40932 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWSrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 14:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624473882; x=1656009882;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=N07wTNJU87j8J0GwX4jxR069BiU3mP0B1FK82hyEXsU=;
  b=tY8226zhhKnXNPU9rX3v+Qz+lpCfzG0jhsIEWrTpx/TST7X0tgEf4JgD
   2Y65V4YOehsiJf6flFqbR62zZsZj1Fr0VeDsZ0dICzu+iEBowFahrbO1N
   M+Lk8k1v/CZYWkPQ3v2k4YcFQh8UvSkuxoUrK8gIPb4Nh2AeXXZFycKKY
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Jun 2021 11:44:42 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Jun 2021 11:44:41 -0700
Received: from [10.38.240.33] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 23 Jun
 2021 11:44:35 -0700
Subject: Re: [PATCH v14 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
To:     Will Deacon <will@kernel.org>
CC:     Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, <mpe@ellerman.id.au>,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <heikki.krogerus@linux.intel.com>,
        <thomas.hellstrom@linux.intel.com>, <peterz@infradead.org>,
        <benh@kernel.crashing.org>, <joonas.lahtinen@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <chris@chris-wilson.co.uk>,
        <grant.likely@arm.com>, <paulus@samba.org>, <mingo@kernel.org>,
        <jxgao@google.com>, <sstabellini@kernel.org>,
        Saravana Kannan <saravanak@google.com>, <xypron.glpk@gmx.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <bskeggs@redhat.com>, <linux-pci@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>,
        Thierry Reding <treding@nvidia.com>,
        <intel-gfx@lists.freedesktop.org>, <matthew.auld@intel.com>,
        linux-devicetree <devicetree@vger.kernel.org>, <daniel@ffwll.ch>,
        <airlied@linux.ie>, <maarten.lankhorst@linux.intel.com>,
        <linuxppc-dev@lists.ozlabs.org>, <jani.nikula@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <rodrigo.vivi@intel.com>, <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        <thomas.lendacky@amd.com>, Robin Murphy <robin.murphy@arm.com>,
        <bauerman@linux.ibm.com>
References: <20210619034043.199220-1-tientzu@chromium.org>
 <20210619034043.199220-7-tientzu@chromium.org>
 <76c3343d-72e5-9df3-8924-5474ee698ef4@quicinc.com>
 <20210623183736.GA472@willie-the-truck>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <19d4c7a2-744d-21e0-289c-a576e1f0e6f3@quicinc.com>
Date:   Wed, 23 Jun 2021 14:44:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623183736.GA472@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/23/2021 2:37 PM, Will Deacon wrote:
> On Wed, Jun 23, 2021 at 12:39:29PM -0400, Qian Cai wrote:
>>
>>
>> On 6/18/2021 11:40 PM, Claire Chang wrote:
>>> Propagate the swiotlb_force into io_tlb_default_mem->force_bounce and
>>> use it to determine whether to bounce the data or not. This will be
>>> useful later to allow for different pools.
>>>
>>> Signed-off-by: Claire Chang <tientzu@chromium.org>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
>>> Tested-by: Will Deacon <will@kernel.org>
>>> Acked-by: Stefano Stabellini <sstabellini@kernel.org>
>>
>> Reverting the rest of the series up to this patch fixed a boot crash with NVMe on today's linux-next.
> 
> Hmm, so that makes patch 7 the suspicious one, right?

Will, no. It is rather patch #6 (this patch). Only the patch from #6 to #12 were reverted to fix the issue. Also, looking at this offset of the crash,

pc : dma_direct_map_sg+0x304/0x8f0
is_swiotlb_force_bounce at /usr/src/linux-next/./include/linux/swiotlb.h:119

is_swiotlb_force_bounce() was the new function introduced in this patch here.

+static inline bool is_swiotlb_force_bounce(struct device *dev)
+{
+	return dev->dma_io_tlb_mem->force_bounce;
+}

> 
> Looking at that one more closely, it looks like swiotlb_find_slots() takes
> 'alloc_size + offset' as its 'alloc_size' parameter from
> swiotlb_tbl_map_single() and initialises 'mem->slots[i].alloc_size' based
> on 'alloc_size + offset', which looks like a change in behaviour from the
> old code, which didn't include the offset there.
> 
> swiotlb_release_slots() then adds the offset back on afaict, so we end up
> accounting for it twice and possibly unmap more than we're supposed to?
> 
> Will
> 
