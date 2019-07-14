Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5BC68144
	for <lists+linux-pci@lfdr.de>; Sun, 14 Jul 2019 23:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfGNVbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Jul 2019 17:31:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42888 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfGNVbK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Jul 2019 17:31:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so6739937pgb.9;
        Sun, 14 Jul 2019 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OI4xMsbqQf5Vrd3dbjB5Xy9DidSLC6HJyzC9HwJmKsc=;
        b=g2MZ8iXz8S/AlMluHGjv4oQC1mY+0D/ljETpIWRRPq182JjTgW2cnnDPjIOnQt/k3w
         UfEea+BmOISa844HIgTuHyLAR+SrTZdEZTiHadCfcSxV4ooXq+TCb44jhKV5qk89nlmS
         v5VD031lLiPuvNE4VouuW7v39Zu7TzwXzNSbU/j+43dqDyeu2DDoYRaTrUSdV0o63PKm
         xRSn0YTIODcWloeFdwg4alsqpc/gHas6sHe41OsyV7InGDmm076cHHFsl7u0YHoR/iUm
         mulmlwfH8ixWiXktfZWEh6hWV6hTOvnvbyC55FfMbSjaVIB9WmscMqOooDp63NsXEQNR
         rzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OI4xMsbqQf5Vrd3dbjB5Xy9DidSLC6HJyzC9HwJmKsc=;
        b=bG9+QK5zaYUvX/15Wl70bkbZefPzz81JsLnxxj75ZkrecioDk9/wARqNGHvgNu2GO/
         vO9rz2ZK2/IBv/w1Jpv7iWRYl1I1uK5dij7BtchnbseQ72DvMpTaWmeQWTtjKnJkic9H
         el2YiqHahaxCl5srvWb6UX10CcSyQhwjHt8YZg+ckqX2v08QczmceASJTen5QQXZ2AQm
         /ICbb/O98Tnn7pZIK9QV70tA4M62GlGMf5mxi1ZyoAYKetW12DOIqokQfIGQEGrSJnHZ
         Co5Y6jCFn7rprlUKXt8G9iHDNtdokiNmwI0ieVBXvhltMhLCa+ScsTsl6tvMEMmnCJSI
         3rSw==
X-Gm-Message-State: APjAAAXyrkn8v/4mX1rqhB4xmK23CtvPWvtLaUQUD5pTTciVGmA211r1
        85tE4j0gA6HKOlezay0cOk8z89xB
X-Google-Smtp-Source: APXvYqyQaAFBCaC86ytdeR9B0pAZgAmoPfDBUUULGmeEknrNkALndeNS+Fb2DqFr5/rNgTrPOoCIZw==
X-Received: by 2002:a63:2148:: with SMTP id s8mr22928413pgm.336.1563139869899;
        Sun, 14 Jul 2019 14:31:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14sm30337287pfh.153.2019.07.14.14.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 14:31:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] x86/amd_nb: Add PCI device IDs for family 17h, model
 70h
To:     Vicki Pfau <vi@endrift.com>, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org, Brian Woods <brian.woods@amd.com>
References: <20190714183209.29916-1-vi@endrift.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <425d3dfd-ab13-2fe2-f8ae-58aa8a3422cc@roeck-us.net>
Date:   Sun, 14 Jul 2019 14:31:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714183209.29916-1-vi@endrift.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/14/19 11:32 AM, Vicki Pfau wrote:
> Add the PCI device IDs for the newly released AMD Ryzen 3xxx desktop
> (Matisse) CPU line northbridge link and misc devices.
> 
> Signed-off-by: Vicki Pfau <vi@endrift.com>

You didn't copy any of the x86 maintainers.

FWIW:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/x86/kernel/amd_nb.c | 3 +++
>   include/linux/pci_ids.h  | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index d63e63b7d1d9..0a8b816857c1 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -21,6 +21,7 @@
>   #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>   #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>   #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
> +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>   
>   /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>   static DEFINE_MUTEX(smn_mutex);
> @@ -49,6 +50,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>   	{}
>   };
> @@ -63,6 +65,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>   	{}
>   };
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..862556761bbf 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -548,6 +548,7 @@
>   #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
>   #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
>   #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
> +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>   #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>   #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>   #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> 

