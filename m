Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E43BA19A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhGBNvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 09:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhGBNvd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 09:51:33 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C0DC061762;
        Fri,  2 Jul 2021 06:49:01 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so10158636otl.0;
        Fri, 02 Jul 2021 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9x+juvDeOlaCtKmozneQfrCt9yo0Whbh1MNkOy7JJZU=;
        b=UEjOTwG3dEw4BMs9zskTAlB/qyEqwJyHyp2F3uc3IEyjANLR6uP1/H9KR/MbGUoN+q
         uXXp5fn/iI8ZGaLxshXE1VQxeK5/3UWORkO2pNxSV6JX6TB55C98dgtqR+ifQCzwR/+E
         tWXw5g4HJNLzPOLmN5ZESxRdKK1SlSI9vIjSxu/oxrzoNqDVDJAp6devlE/I9vjje1jl
         UriRs+KKNlto9yhu5Cc6j3zBlDtCEQbiH6DoyRIcLxwtvRuZjbkzbi0yal/mv3qJLt2a
         3fiDvGnsl5Hudqdx9BEktUwL9MS3wAY6jCzLNb0Q5Ly1c+F45rGX3brSqu3cPed6aviv
         JOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9x+juvDeOlaCtKmozneQfrCt9yo0Whbh1MNkOy7JJZU=;
        b=rnp0loDKExb81NYcW1AVOHl744/ODWsZUzxHbAbWJc0miKokU545NYq3Rz7QPAPK72
         GwULTgjZUxBqiqYTF70JCIHnOeo3/Z4EOOvx07wBr4bsuXoFeAqQ0BujCV6RCjF8MDfP
         gHRGREagbqIRnlAGxqrFCJLMZJqNOh+wLDIBSAnkaq4HLhNRS4P/zd6mMHaJrTWMEiyk
         8fVNiX5LKysRYdgxIJyYKGdrO+9/xqYR8eheEaA2ieIVKMjwyf75yp7o1ok7qKwyatem
         hiemxfZwp94wMU1zBsaW6BuYK4+5BODilwjvEOORoSpDQRzoADkB2jv9DtbnAfBz6YKW
         Dp2g==
X-Gm-Message-State: AOAM530uHP2fDw7tqNwZQknCUqcTMqZBNawru59BLhD0+ikifK75dzqv
        QtGOvzY6ZPCeZwa8S7OykTE=
X-Google-Smtp-Source: ABdhPJzlnGPxxKYZSXkVHHmfsdkLH9E7ecEfVsvBHCQZR82klKUBGGO/PYD4fEoEphoBmS1gKABKng==
X-Received: by 2002:a05:6830:823:: with SMTP id t3mr4518459ots.334.1625233740480;
        Fri, 02 Jul 2021 06:49:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26sm599488oos.14.2021.07.02.06.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 06:48:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v15 12/12] of: Add plumbing for restricted DMA pool
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
        peterz@infradead.org, dri-devel@lists.freedesktop.org,
        chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
        mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
        Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bskeggs@redhat.com, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
        linux-devicetree <devicetree@vger.kernel.org>, airlied@linux.ie,
        Nicolas Boichat <drinkcat@chromium.org>,
        rodrigo.vivi@intel.com, bhelgaas@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, quic_qiancai@quicinc.com,
        lkml <linux-kernel@vger.kernel.org>, tfiga@chromium.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        thomas.lendacky@amd.com, linuxppc-dev@lists.ozlabs.org,
        bauerman@linux.ibm.com
References: <20210624155526.2775863-1-tientzu@chromium.org>
 <20210624155526.2775863-13-tientzu@chromium.org>
 <20210702030807.GA2685166@roeck-us.net>
 <87ca3ada-22ed-f40c-0089-ca6fffc04f24@arm.com>
 <20210702131829.GA11132@willie-the-truck>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2f2d6633-2457-f7eb-81c1-355f56dc34ce@roeck-us.net>
Date:   Fri, 2 Jul 2021 06:48:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702131829.GA11132@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/2/21 6:18 AM, Will Deacon wrote:
> On Fri, Jul 02, 2021 at 12:39:41PM +0100, Robin Murphy wrote:
>> On 2021-07-02 04:08, Guenter Roeck wrote:
>>> On Thu, Jun 24, 2021 at 11:55:26PM +0800, Claire Chang wrote:
>>>> If a device is not behind an IOMMU, we look up the device node and set
>>>> up the restricted DMA when the restricted-dma-pool is presented.
>>>>
>>>> Signed-off-by: Claire Chang <tientzu@chromium.org>
>>>> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
>>>> Tested-by: Will Deacon <will@kernel.org>
>>>
>>> With this patch in place, all sparc and sparc64 qemu emulations
>>> fail to boot. Symptom is that the root file system is not found.
>>> Reverting this patch fixes the problem. Bisect log is attached.
>>
>> Ah, OF_ADDRESS depends on !SPARC, so of_dma_configure_id() is presumably
>> returning an unexpected -ENODEV from the of_dma_set_restricted_buffer()
>> stub. That should probably be returning 0 instead, since either way it's not
>> an error condition for it to simply do nothing.
> 
> Something like below?
> 

Yes, that does the trick.

> Will
> 
> --->8
> 
>>From 4d9dcb9210c1f37435b6088284e04b6b36ee8c4d Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Fri, 2 Jul 2021 14:13:28 +0100
> Subject: [PATCH] of: Return success from of_dma_set_restricted_buffer() when
>   !OF_ADDRESS
> 
> When CONFIG_OF_ADDRESS=n, of_dma_set_restricted_buffer() returns -ENODEV
> and breaks the boot for sparc[64] machines. Return 0 instead, since the
> function is essentially a glorified NOP in this configuration.
> 
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Link: https://lore.kernel.org/r/20210702030807.GA2685166@roeck-us.net
> Signed-off-by: Will Deacon <will@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/of/of_private.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 8fde97565d11..34dd548c5eac 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -173,7 +173,8 @@ static inline int of_dma_get_range(struct device_node *np,
>   static inline int of_dma_set_restricted_buffer(struct device *dev,
>   					       struct device_node *np)
>   {
> -	return -ENODEV;
> +	/* Do nothing, successfully. */
> +	return 0;
>   }
>   #endif
>   
> 

