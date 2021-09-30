Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6946841D17B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 04:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347852AbhI3CfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 22:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347848AbhI3CfQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 22:35:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B6C06176A
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 19:33:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n2so2903223plk.12
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I3Ka97zNeP725BXVDk5arDvDOWeoP2d7phzXrFZ8n4s=;
        b=IlRJhaJg6rWVYyPM3VkfA65JEOSMQR6+oGsrVfOjOVHxL4WefefiLThzdZ40jTO6g8
         Zx06WckyPxrt7Uy1K+0hnl1HZNYlZYL10ofG/bR9wh4e8/Sdc4VuKMTRKIl8zPF5jJ7b
         sjkMrT9HnS0yDqFDQe+M7s9gEumGF4V6wnL/r/ioJHTbv1B5hcwZr7q3Q7Fh0N9xwdBQ
         mKHz1fKGbNjriH5rlOs5OE5DOSH3XOBzj8Lukkx/0TWYEppgGXItvcJmX816w6eG33kU
         rLof2DKdxqbIKj9nn22MFA22Eph/X4eFxJFCLPGAno38hVvSmS7EidBFKjCNQxoU0tMa
         AGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I3Ka97zNeP725BXVDk5arDvDOWeoP2d7phzXrFZ8n4s=;
        b=USl7z0+9E+ELyah4fiwWntoraD5VWfVMcFbicZ3pfN8pxaRkQswIK+eb5LYAhsPfiY
         GtYcW+w1VxWUpwCigSt6fRxNJcfbt2faf1zNRhwh4qJnO2ISLCG7n4sVG1+7PIc0KmG9
         u9TV6tdDd74PrH/wJ/ILbzJZgRbGeSck4m29jWv6SfGLLD3Vr4EvNZnAVZdufspeSf7w
         cMLUXnreTyWFoulg6pBWtmbBvmpEjQlyGOL6xvWoGCRr3yXfSnwT18fz0xR1wlX3Dv9O
         EldKaxdfbXhD+EiuVMGTBt0t6t/ZOABH0R1nSI/7upRw3C0kEXFN8wR75rZkdZRbAutI
         YBdA==
X-Gm-Message-State: AOAM533irGWFHZZYoKFuw5GcXVJCjz19m6cfAvApDKEk31jUm6qzQNYM
        VNeh9Z/8Qk2klxsMDZI1+kpfm6iuGJSRnjzZ
X-Google-Smtp-Source: ABdhPJxE6Hl3kX+pF11sEnIDGPtqYsZz4qjfhIf79ZIQfd0DSxRKUumrZjOUcb3ap3qqZ7YvCqj5eQ==
X-Received: by 2002:a17:90a:af86:: with SMTP id w6mr3675210pjq.8.1632969213549;
        Wed, 29 Sep 2021 19:33:33 -0700 (PDT)
Received: from [10.50.0.6] ([94.177.118.147])
        by smtp.gmail.com with ESMTPSA id y3sm834162pjg.7.2021.09.29.19.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 19:33:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] PCI: Use software node API with additional device
 properties
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210929170804.GA778424@bhelgaas>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <b3e3e9a3-c430-db98-9e6d-0e3526ddc6f7@linaro.org>
Date:   Thu, 30 Sep 2021 10:33:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210929170804.GA778424@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/9/30 上午1:08, Bjorn Helgaas wrote:
> [+cc Zhangfei, author of 8304a3a199ee ("PCI: Set dma-can-stall for
> HiSilicon chips"), which added this]
>
> On Wed, Sep 29, 2021 at 04:37:28PM +0300, Heikki Krogerus wrote:
>> Using device_create_managed_software_node() to inject the
>> properties in quirk_huawei_pcie_sva() instead of with the
>> old device_add_properties() API.
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> This is fine with me, but please update the subject line and commit
> log something like this:
>
>    PCI: Convert to device_create_managed_software_node()
>
>    In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
>    instead of device_add_properties() to set the "dma-can-stall"
>    property.
>
>    This resolves a software node lifetime issue (see 151f6ff78cdf
>    ("software node: Provide replacement for device_add_properties()"))
>    and paves the way for removing device_add_properties() completely.
>
> Actually, 8304a3a199ee was merged during the v5.15 merge window, so if
> this does in fact fix a lifetime issue, I can merge this before
> v5.15-final.
>
> I know *this* quirk applies to AMBA devices, and I assume they cannot
> be removed, so there's no actual lifetime problem in this particular
> case, but in general it looks like a problem for PCI devices.
Thanks Bjorn
This patch also works, though the quirk is for platform devices and not 
removed.

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>
>> ---
>>   drivers/pci/quirks.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index b6b4c803bdc94..fe5eedba47908 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1850,7 +1850,7 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
>>   	 * can set it directly.
>>   	 */
>>   	if (!pdev->dev.of_node &&
>> -	    device_add_properties(&pdev->dev, properties))
>> +	    device_create_managed_software_node(&pdev->dev, properties, NULL))
>>   		pci_warn(pdev, "could not add stall property");
>>   }
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
>> -- 
>> 2.33.0
>>

