Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C9568148
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2019 23:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfGNVdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Jul 2019 17:33:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37132 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfGNVdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Jul 2019 17:33:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so6494443pfa.4;
        Sun, 14 Jul 2019 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gy72qOCVAIdmdsywBTPJMwMFI2UfguzvzgBUaCOS3cI=;
        b=mhLS8G5f27clneXSt/29L9BZPXPPIwtSiIkfnTu4koUXyCOrOmmj/YyDfVhDJs9kfk
         z1EPxgaiIjuLLdi4Bsb6caTIJWEy+k7GjMtgOES5BUlvUEAojvcBCPQKx8S6P3IEalpv
         SqBWWUzphh9EgFGT7aJr8rLNZSRqg4Xj0vr4LhO8iPy9sjq8HVjYFphB0aa6JVrR1VW3
         y0k06PoS6OiU0T08Zj63FoZA9strYQAicpRw4hNCdZX9t+d27T5NeF9W4JQx6dqWSW82
         GJ1JzmDhLQQIQb/mmzbrEIiPxTCSd2QmYObIg2hWLRnS8hQad+SDxOFNx3y/S8YEXEPf
         Y+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gy72qOCVAIdmdsywBTPJMwMFI2UfguzvzgBUaCOS3cI=;
        b=XmfXN23GG65g+Zxf9Dx8mGR4Ur0N7k3cizcUWKl4VJQ30tIRYIkE6rEGCHjTWAXpch
         NTWOZvNBpflix5Qr5qMXGCWYA/pIbaMlIB6r9nX8tcQGb9fmhquau3p4+34cfhJ8Sl41
         3KNSaCb/jKpstpNRowPaoXsioRW8Q3D06p3qo9tAl0mcQ6JTchJQR/PfJQ5eLXyboYM9
         gUIPFySInMUuMFj0esdpCdWTvhu83ibsJChn2rwyXtBJVLwkYy+qL5fqxOrB3188lneR
         R4RV9GF+8VSB0AI8FFUScF5sn4lxOzL65DkxGlC+A1V/qM/6kBy1jEwx9ydFddlaB24K
         vS+w==
X-Gm-Message-State: APjAAAVHFZl5QYhXoXtGatvivNLD92/TqK3fxIszQ8bUXrUbOeBniVq0
        JihAc9fY8Qhb/5IZLBJaI9E=
X-Google-Smtp-Source: APXvYqxHMQCGiLuddtlpw2+gyPVgh5o8fo0D081hq39D+PjGVDt2xk9h8LQx5EhDFgiTrKeDr9Omsw==
X-Received: by 2002:a63:2cc7:: with SMTP id s190mr11719128pgs.236.1563140010564;
        Sun, 14 Jul 2019 14:33:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12sm14108425pgo.85.2019.07.14.14.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 14:33:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: (k10temp) Add PCI device IDs for family 17h,
 model 70h
To:     Vicki Pfau <vi@endrift.com>, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org, Brian Woods <brian.woods@amd.com>
References: <20190714183209.29916-1-vi@endrift.com>
 <20190714183209.29916-2-vi@endrift.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <94313f9f-e37a-40f5-ddbe-ebc9e6b01539@roeck-us.net>
Date:   Sun, 14 Jul 2019 14:33:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714183209.29916-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/14/19 11:32 AM, Vicki Pfau wrote:
> Add PCI device IDs for the new AMD Ryzen 3xxx (Matisse) CPUs to k10temp,
> as they function identically from k10temp's point of view.
> 
> Signed-off-by: Vicki Pfau <vi@endrift.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I can not directly apply this patch since it depends on patch 1
of the series. You might want to resubmit and include x86 maintainers;
otherwise I don't see a path to get it accepted.

Guenter

> ---
>   drivers/hwmon/k10temp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index c77e89239dcd..5c1dddde193c 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -349,6 +349,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>   	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{}
>   };
> 

