Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1867D229
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 17:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjAZQx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 11:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAZQx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 11:53:59 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17593470BF
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 08:53:58 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j9so1764842qtv.4
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 08:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LzJPe3EcmggiRO10VtpQvAAZOYxUCc3B6VhZOb/rnEw=;
        b=K9TssC2tvO2bl8n5jggZPVlhfeYQA8WE8uf9tMmK56dMGQPG7N0fHRGvT6nLRRW0OR
         cvECnIrifJy5t2grFtdHCWFWvgrk4YchKyMB4JSCq3pO5zlIWgEKa0Fcsgb/P24YUkCH
         AKpYjVAVirzZFaUypwoVxeTrsUf5efj9VRfehK5FSm759KRZCmP+PCchYGUJXk8tT59E
         N8Mk6fCm52vPaHtfswZfUL/DuKsSVtdeUt1SAwOaE7P1d+kOPv1Q7yDRLxKX2rPmYoj7
         4q6ubtQzoLCD0uPVfPwyh0WsWdAds6p3bEJo7guqowOUuoxg5VFjhClE/eQGsQ2wDaI4
         WhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzJPe3EcmggiRO10VtpQvAAZOYxUCc3B6VhZOb/rnEw=;
        b=lm/sa8DISZWLwvG+jU3zyHf8x+0I0KDMtpXkXl8yeZoEl7Yeas0QzkSsGgQZRzZXhd
         jZiZsdxgngbPM7F5WQZcqp3SVpxrhIW+OfpQsbXATwJGetDBQcRbuw/UJ/SFOzK1NvA8
         +TcMmI3mrQkVvvHxqAPL1mN0CI1ze3pKhARvgEiw9gqHGVMrw8zKwhBdOiH37QiV/R56
         DSwxgbrVhdjiKv62rpWBTDWfLfRpOwkLOgua9nzq9mhtQGRwlYhZHPjnDEewh9Bvn7u4
         +zdutebG8FRDdeIPJM+FhntuzGYvqJwskVkUlQc+3BCYJYinEarCwRg2svtgG04BNMPp
         C9Dg==
X-Gm-Message-State: AO0yUKVi62KkyAWeSAtas+Wz+KDWbctSgNsIKLwRkoogTy3bhdRtSdes
        vgr7KmoisheYbJcfDvMeUpz5AA==
X-Google-Smtp-Source: AK7set9r/4Hyn4M9sc6jcdezlIBVvONhF3rWFQnGmP2n/9pOWDxYJ2xHS+Yylyek0nIDjSOCY08+KA==
X-Received: by 2002:ac8:5c09:0:b0:3b6:377d:4330 with SMTP id i9-20020ac85c09000000b003b6377d4330mr12132504qti.29.1674752037055;
        Thu, 26 Jan 2023 08:53:57 -0800 (PST)
Received: from [10.230.45.5] ([38.32.73.2])
        by smtp.gmail.com with ESMTPSA id i12-20020ac84f4c000000b003b63c9c59easm973869qtw.97.2023.01.26.08.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 08:53:56 -0800 (PST)
Message-ID: <7b4a981b-2ee8-0021-0c3a-984d6171f680@ixsystems.com>
Date:   Thu, 26 Jan 2023 11:53:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] PCI: Align extra resources for hotplug bridges
 properly
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
References: <20230112110000.59974-1-mika.westerberg@linux.intel.com>
 <20230112110000.59974-2-mika.westerberg@linux.intel.com>
From:   Alexander Motin <mav@ixsystems.com>
In-Reply-To: <20230112110000.59974-2-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika,

Unfortunately my system was de-racked meanwhile, so it will take few 
more days for me to test this.  So far I only successfully built it on 
my 5.15.79 kernel.  Meanwhile some comments below:

On 12.01.2023 05:59, Mika Westerberg wrote:
> After division the extra resource space per hotplug bridge may not be
> aligned according to the window alignment so do that before passing it
> down for further distribution.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/pci/setup-bus.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..34a74bc581b0 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1891,6 +1891,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>   	 * resource space between hotplug bridges.
>   	 */
>   	for_each_pci_bridge(dev, bus) {
> +		struct resource *res;
>   		struct pci_bus *b;
>   
>   		b = dev->subordinate;
> @@ -1902,16 +1903,28 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>   		 * hotplug-capable downstream ports taking alignment into
>   		 * account.
>   		 */
> -		io.end = io.start + io_per_hp - 1;
> -		mmio.end = mmio.start + mmio_per_hp - 1;
> -		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
> +		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
> +		align = pci_resource_alignment(dev, res);
> +		io.end = align ? io.start + ALIGN_DOWN(io_per_hp, align) - 1
> +			       : io.start + io_per_hp - 1;

Not bug probably, but if we align x_per_b down for one bridge, we could 
be able to increase it for other(s).

> +
> +		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> +		align = pci_resource_alignment(dev, res);
> +		mmio.end = align ? mmio.start + ALIGN_DOWN(mmio_per_hp, align) - 1
> +				 : mmio.start + io_per_hp - 1;

Here is a typo, it should be mmio_per_hp here   ^^^.

> +
> +		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +		align = pci_resource_alignment(dev, res);
> +		mmio_pref.end = align ? mmio_pref.start +
> +					ALIGN_DOWN(mmio_pref_per_hp, align) - 1
> +				      : mmio_pref.start + mmio_pref_per_hp;
>   
>   		pci_bus_distribute_available_resources(b, add_list, io, mmio,
>   						       mmio_pref);
>   
> -		io.start += io_per_hp;
> -		mmio.start += mmio_per_hp;
> -		mmio_pref.start += mmio_pref_per_hp;
> +		io.start += io.end + 1;
> +		mmio.start += mmio.end + 1;
> +		mmio_pref.start += mmio_pref.end + 1;
>   	}
>   }
>   

-- 
Alexander Motin
