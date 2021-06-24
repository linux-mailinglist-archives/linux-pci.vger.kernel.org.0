Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36B3B3103
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhFXONS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 10:13:18 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:7502 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhFXONS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 10:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1624543859; x=1656079859;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jIPt55RUzMMbkq7vhbeD6czYPulB4Zz8LFVe0v3gRZ0=;
  b=HPrafZwejBwzC36jkSdbvaUBdQLBaQtfGa+xaiqEN//oDn9ae67TJgVg
   ZXIdONhObbr4ReCMTBBnx/aEivFxDvcYeamgta7UWJaQfTCDEDHFmdWLy
   xgRFgkPBIu9kR20CxGZsaLUNEcHr+WoXRoSVLx26W/JWJh1lnMehhlZ39
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jun 2021 07:10:59 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Jun 2021 07:10:57 -0700
Received: from [10.111.163.161] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 24 Jun
 2021 07:10:52 -0700
Subject: Re: [PATCH v14 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC:     Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>, <mpe@ellerman.id.au>,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <heikki.krogerus@linux.intel.com>,
        <thomas.hellstrom@linux.intel.com>, <peterz@infradead.org>,
        <benh@kernel.crashing.org>, <joonas.lahtinen@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <chris@chris-wilson.co.uk>,
        <grant.likely@arm.com>, <paulus@samba.org>, <mingo@kernel.org>,
        Jianxiong Gao <jxgao@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Saravana Kannan <saravanak@google.com>, <xypron.glpk@gmx.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <bskeggs@redhat.com>, <linux-pci@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>,
        Thierry Reding <treding@nvidia.com>,
        <intel-gfx@lists.freedesktop.org>, <matthew.auld@intel.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, <airlied@linux.ie>,
        <maarten.lankhorst@linux.intel.com>,
        <linuxppc-dev@lists.ozlabs.org>, <jani.nikula@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <rodrigo.vivi@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        <bauerman@linux.ibm.com>
References: <20210619034043.199220-1-tientzu@chromium.org>
 <20210619034043.199220-7-tientzu@chromium.org>
 <76c3343d-72e5-9df3-8924-5474ee698ef4@quicinc.com>
 <20210623183736.GA472@willie-the-truck>
 <19d4c7a2-744d-21e0-289c-a576e1f0e6f3@quicinc.com>
 <20210624054315.GA25381@lst.de>
 <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
 <364e6715-eafd-fc4a-e0af-ce2a042756b4@arm.com>
 <20210624111855.GA1382@willie-the-truck>
 <452155d2-c98e-23f6-86d6-3a2ff2e74783@arm.com>
 <20210624114829.GB1382@willie-the-truck>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <43ec9dd6-12c0-98ec-8d5d-b2904292721e@quicinc.com>
Date:   Thu, 24 Jun 2021 10:10:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624114829.GB1382@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03c.na.qualcomm.com (10.85.0.106) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/24/2021 7:48 AM, Will Deacon wrote:
> Ok, diff below which attempts to tackle the offset issue I mentioned as
> well. Qian Cai -- please can you try with these changes?

This works fine.

> 
> Will
> 
> --->8
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 175b6c113ed8..39284ff2a6cd 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -116,7 +116,9 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  
>  static inline bool is_swiotlb_force_bounce(struct device *dev)
>  {
> -       return dev->dma_io_tlb_mem->force_bounce;
> +       struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +
> +       return mem && mem->force_bounce;
>  }
>  
>  void __init swiotlb_exit(void);
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 44be8258e27b..0ffbaae9fba2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -449,6 +449,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>                 dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>         unsigned int nslots = nr_slots(alloc_size), stride;
>         unsigned int index, wrap, count = 0, i;
> +       unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>         unsigned long flags;
>  
>         BUG_ON(!nslots);
> @@ -497,7 +498,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>         for (i = index; i < index + nslots; i++) {
>                 mem->slots[i].list = 0;
>                 mem->slots[i].alloc_size =
> -                       alloc_size - ((i - index) << IO_TLB_SHIFT);
> +                       alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
>         }
>         for (i = index - 1;
>              io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
> 
