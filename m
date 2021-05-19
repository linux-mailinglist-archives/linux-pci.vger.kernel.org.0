Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF14389668
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 21:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhESTTm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 15:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhESTTl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 15:19:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F70C06175F;
        Wed, 19 May 2021 12:18:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q2so10564680pfh.13;
        Wed, 19 May 2021 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qkzCD1nWkBURpBrpJXY23W3vLoZSck6AY/wcT/olSRk=;
        b=Jr32Uvht2cSrNILgfPTD5ViC6pT8b+8Rv+juxOSQTQwrJ1CAD0MBJHubcHjyOKsUbI
         JfDjb6IlvhZ8t3+ym7sOQ4a9U6dHEsOXxzesVMPv6UDrlo59kYq82tWRbs9w2uqU+yYo
         8oA/biTXJEGtIK7ZUbiBmZQYbJzsutIezjLCjW+be0py6uPVuz9vfS/rc828YcCt+zVs
         WRnXVlWSjrk7BMwlJdqMQwTvyoJQltUeu2a7CMQB207kX6rGqLkbNNdIKCNuEPYfxlj8
         c8CbGpi6xXQEr0VSmTVe/i1v9YaB96qj2/4NW8B/lTGCTjbb7h0/a34Yz4Z5jXjVRuz+
         oRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qkzCD1nWkBURpBrpJXY23W3vLoZSck6AY/wcT/olSRk=;
        b=Khc2XaRWNqgDbdgm3Nn2SqFJ09OSaaICwhw6j52vX+rZdQQLDq6SZf3f+8QKhj71QG
         daRm7KeN2vUsnT2SijkJotWz/OgXi019lLqVdlFCR1LprDkyPzWqbsDoBFe3+nby93KK
         FydyihlzAsQjpJ9bsG4fJHCeswf7RUjxboZ9OC9zMib3d+ydueFuEHDNcjZ410rWqCDG
         Ju2Y+QMbc2fNw9OaTbxSN8CgPA3R0kP3uCT5L2w6ZXnlsMrQvM7E58YBJEXyK7bfppKN
         2Ez9mzOsqwkSKjpKUj3Yc8myyunjdW1EAh5/Ev+PgijJOz9tmDO0/6OUmo/F3Zg7HJ61
         jXRQ==
X-Gm-Message-State: AOAM533Cu7xev0GFCinyjcgArWFAF7XOTcQLhJRjJvlkiTfz+c081MWK
        rnB07vPued00DzHN2lzT4TuX4McJLes=
X-Google-Smtp-Source: ABdhPJyun5zEd3qUDcE/GtFSWzJiED1dVWEJkkT2Lvnwoihmboc879WuDVAjjHLr8vtaHKK8YVFCpg==
X-Received: by 2002:a65:4286:: with SMTP id j6mr636207pgp.261.1621451900054;
        Wed, 19 May 2021 12:18:20 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d131sm147671pfd.176.2021.05.19.12.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 12:18:19 -0700 (PDT)
Subject: Re: [PATCH v7 05/15] swiotlb: Add a new get_io_tlb_mem getter
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
 <20210518064215.2856977-6-tientzu@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <52714d95-3562-97fc-0dee-761adfc364cb@gmail.com>
Date:   Wed, 19 May 2021 12:18:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-6-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Add a new getter, get_io_tlb_mem, to help select the io_tlb_mem struct.
> The restricted DMA pool is preferred if available.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
