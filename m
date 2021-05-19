Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808BD3895CB
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 20:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhESSvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhESSvf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 14:51:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A758C06175F;
        Wed, 19 May 2021 11:50:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so2350174plf.7;
        Wed, 19 May 2021 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dYfUs37GH26f9qor1VLh+dBs069CWpkdAXD/ElhmJms=;
        b=TrWBAUFZb5IOcZqvzjceFmBdD//LhG3J/GS/NNJVT3gU+F4jePK2De3KUi6WMq1NHA
         zndANjSseMb1Pp2JRwuG0SKzESIJZgHwjEgadrwQvWeoPO53UCfAxaiTf1Zb6HKEWFg+
         KxvquRqXRHR2JXs6tVsspVphZHfh6QRuiwDBKvnzs/KhFOZgDEomwsEaIwbkEmyXnii1
         Zfxo7hizbKJjteQW7iRhmVRGFo9GFw0B11Cxe44wbA/ziDpsrbDsCg/BzVUrrcWoLnZb
         /YnwocBrRVTzDPZIHZwS44CV6X61m/f/ggI85MB9OD/nN5l0XNYHfp13C3qnJ0yxFZH1
         QMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYfUs37GH26f9qor1VLh+dBs069CWpkdAXD/ElhmJms=;
        b=V8Ad7F9/r0fB7AZC4X0pRU2FuyOCDz+tMtd/JREAwBixs5e0smMriV7zhdTwXcDknt
         hr6bO3L4xMPk8tRRP1RLH4h/sUbs9FWVr2YJZ0DntV6+oNcMlc8euPG3ynk0CnKRA/m4
         Ig5EGrxvpdsWlLKnttIIVcvuX7qwdANSVdOxSFERSGh4Zy24EJlfaGADfg9wpksweo2x
         tOK/DmzA1Cn4jjCLsmDuc9DeAjmDRMR0WI3pe9O19+1aTBF7+kdNczVOTM/ZgG50ADln
         b3Z8d/CMr7Kwd/ApeBaUFGZqAMpdCZXKhb9nWe0EMrEGhtZRBoS6KHbwdH5MffV5DO7r
         DEbA==
X-Gm-Message-State: AOAM530owLz146Q7MqjoFwV9uwV9TkcWTkrJNyn4F7ho2DAVeRLEwrCZ
        RdQapOj81AxP5xIFDGdhtDU=
X-Google-Smtp-Source: ABdhPJxg56VOtjzCy0nTcRzR5TrWV2NzF6pi2y8FSlVZjGvfF9DZQZKizJXSGDAHfIg8aWG5cZking==
X-Received: by 2002:a17:90b:1949:: with SMTP id nk9mr742999pjb.220.1621450213929;
        Wed, 19 May 2021 11:50:13 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 204sm126125pfy.56.2021.05.19.11.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 11:50:13 -0700 (PDT)
Subject: Re: [PATCH v7 01/15] swiotlb: Refactor swiotlb init functions
To:     Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jxgao@google.com, joonas.lahtinen@linux.intel.com,
        linux-pci@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        matthew.auld@intel.com, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-2-tientzu@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <170a54f2-be20-ec29-1d7f-3388e5f928c6@gmail.com>
Date:   Wed, 19 May 2021 11:50:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-2-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Add a new function, swiotlb_init_io_tlb_mem, for the io_tlb_mem struct
> initialization to make the code reusable.
> 
> Note that we now also call set_memory_decrypted in swiotlb_init_with_tbl.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  kernel/dma/swiotlb.c | 51 ++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 8ca7d505d61c..d3232fc19385 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -168,9 +168,30 @@ void __init swiotlb_update_mem_attributes(void)
>  	memset(vaddr, 0, bytes);
>  }
>  
> -int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> +static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> +				    unsigned long nslabs, bool late_alloc)
>  {
> +	void *vaddr = phys_to_virt(start);
>  	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
> +
> +	mem->nslabs = nslabs;
> +	mem->start = start;
> +	mem->end = mem->start + bytes;
> +	mem->index = 0;
> +	mem->late_alloc = late_alloc;
> +	spin_lock_init(&mem->lock);
> +	for (i = 0; i < mem->nslabs; i++) {
> +		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> +		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> +		mem->slots[i].alloc_size = 0;
> +	}
> +
> +	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
> +	memset(vaddr, 0, bytes);

You are doing an unconditional set_memory_decrypted() followed by a
memset here, and then:

> +}
> +
> +int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> +{
>  	struct io_tlb_mem *mem;
>  	size_t alloc_size;
>  
> @@ -186,16 +207,8 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  	if (!mem)
>  		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
>  		      __func__, alloc_size, PAGE_SIZE);
> -	mem->nslabs = nslabs;
> -	mem->start = __pa(tlb);
> -	mem->end = mem->start + bytes;
> -	mem->index = 0;
> -	spin_lock_init(&mem->lock);
> -	for (i = 0; i < mem->nslabs; i++) {
> -		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> -		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> -		mem->slots[i].alloc_size = 0;
> -	}
> +
> +	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);

You convert this call site with swiotlb_init_io_tlb_mem() which did not
do the set_memory_decrypted()+memset(). Is this okay or should
swiotlb_init_io_tlb_mem() add an additional argument to do this
conditionally?
-- 
Florian
