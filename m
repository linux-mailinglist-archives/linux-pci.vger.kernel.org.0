Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2215303C7B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 13:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbhAZMGR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 07:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392347AbhAZLW7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2021 06:22:59 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD083C0617A7;
        Tue, 26 Jan 2021 03:22:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f19so10166559ljn.5;
        Tue, 26 Jan 2021 03:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ih68eaA45lBBxmQYA23SwMPQQkvJWOCkqoNeRhWoVxA=;
        b=SZSR9Ot2y5b48JnRdH/RMmEtPWH8qvYSBx38TV13Bkx1yVPhqktWsAsPQ9cnyCtjSM
         bPv3D+Z2RxpheCJ7BxfPj0JZaJ6N72UBfHA63H0EYB/RljKoDaHdNCEw1dbikyidKowM
         udIZKhOodSnSAyjB82QXJlqFdA/vwduKj2CzY8cZkrSwipEQUSVqHCyogRovlUoIQrMz
         tcDbTZRKPjowN+Dy6lcUFBgF8LyBSicNVGzIU3UbeD9C3nthE6jtNXLdC2br+MJPS5kv
         QkI84rX+q0a6seCzAdtRWzRl/trbJjFJCPAkJJfNRyDBq398zLVT10MnL7GH372igzKv
         8dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ih68eaA45lBBxmQYA23SwMPQQkvJWOCkqoNeRhWoVxA=;
        b=bq9ApbaBmd/UAg7hrzpsmEmMRRTeUEJjYUDEPHOiZ4GEf9F10Izo+C2ZxeHHtYF9s2
         Wr79oOciqUi+jlyPF42mREQt3XHP9fTAoFrG2x6keTKT9t6GWHnrsEPuIR2nKHtsUSZw
         9TF0KXtP6+pSu6B0rTKGc1JJJ6PXLjnA4WVeRm7aH1N/9373puGoeNvvBG2QuFzpaco3
         7vIp6Trv7WawRAUHAEe0LwPrSgjXNaGvIbruwmGSzumVvXa15xqX97CIvcUKDphDuekl
         39VE58Z8jmwyjBcdZZw8bKim07Dbcga8muEDiL9VoqKHSOpBM/r+Yqrc0G+J2RIFmvVS
         QtVw==
X-Gm-Message-State: AOAM532TwAxN/iLQ3oeKtVkWC1q8Wl2FTYcfWGESjYTYL9+h0vT67tqf
        cGFpL3JXEwdtQkj2reqr2qTz5qo/rGY53Sgx
X-Google-Smtp-Source: ABdhPJxlHcU65g68jSBIsU3oU5EeHqmac+DMXdsDz2KHWAycRsq/x3U1+YM/r4OUEIaXZX0+4NkpWw==
X-Received: by 2002:a2e:9610:: with SMTP id v16mr2560339ljh.374.1611660131427;
        Tue, 26 Jan 2021 03:22:11 -0800 (PST)
Received: from ?IPv6:2001:14ba:efe:51f0:444e:3bca:7345:a707? (db7-gd8cfl498z86gz8dt-3.rev.dnainternet.fi. [2001:14ba:efe:51f0:444e:3bca:7345:a707])
        by smtp.gmail.com with ESMTPSA id 201sm692077lfm.25.2021.01.26.03.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 03:22:10 -0800 (PST)
Subject: Re: [PATCH] PCI: quirk for preventing bus reset on TI C667X
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20210121235547.GA2705432@bjorn-Precision-5520>
From:   =?UTF-8?Q?Antti_J=c3=a4rvinen?= <antti.jarvinen@gmail.com>
Message-ID: <35612e76-0b97-7bb4-60b7-88ae6d53f0be@gmail.com>
Date:   Tue, 26 Jan 2021 13:22:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121235547.GA2705432@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22.1.2021 1.55, Bjorn Helgaas wrote:> 

> It looks like we would probably be trying a Secondary Bus Reset using
> the bridge leading to the C667X.  Can you confirm? 

Yes, this is my understanding too.

> Wonder if you
> could try doing what pci_reset_secondary_bus() does by hand:
> 

I tried this by hand. It looks that result is same as through VFIO.

# cat sbr.sh
BRIDGE=10:00.0
C667X=11:00.0

setpci -s$C667X VENDOR_ID.w

VAL=$(setpci -s$BRIDGE BRIDGE_CONTROL.w)
echo $VAL
setpci -s$BRIDGE BRIDGE_CONTROL.w=$(($VAL | 0x40))
sleep 1
setpci -s$BRIDGE BRIDGE_CONTROL.w=$VAL
sleep 1
setpci -s$C667X VENDOR_ID.w=0
setpci -s$C667X VENDOR_ID.w


# ./sbr.sh
104c
0003
ffff


>   # BRIDGE=...                              # PCI address, e.g., 00:1c.0
>   # C667X=...
>   # setpci -s$C667X VENDOR_ID.w
>   # setpci -s$BRIDGE BRIDGE_CONTROL.w       # prints "val"
>   # setpci -s$BRIDGE BRIDGE_CONTROL.w=      # val | 0x40 (set SBR)
>   # sleep 1
>   # setpci -s$BRIDGE BRIDGE_CONTROL.w=      # val (clear SBR)
>   # sleep 1
>   # setpci -s$C667X VENDOR_ID.w=0
>   # setpci -s$C667X VENDOR_ID.w
> 
> If we use this quirk and avoid the reset, I assume that means
> assigning the device to VMs with VFIO will leak state between VMs?

I think this is true.

