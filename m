Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB632DC5E1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 19:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgLPSFg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 13:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgLPSFg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2020 13:05:36 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2529C061794;
        Wed, 16 Dec 2020 10:04:55 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 6so19418820ejz.5;
        Wed, 16 Dec 2020 10:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H84hohhtAqK/9czLCk7eWnRTskJbqxdwaPZ3PkL4jCc=;
        b=EwQv360yLtMHKK1QY4Up+rntBZWNZmlyW6dYplZoiTyrUTgILcz0/2tdfBqBcQ3p8M
         ed0FtyqM3K3K+jkuRcwZUF3/FDG4Umw5ExRKxu1pz55/2cBsIL+M2fLsUbm1Bk/JsOCa
         YRcWOo4adeKTHBRN1zYfgAkE/O+Op9nfb4vCdJt1K2LKr+Qiqa5bUMRjoo4RrSsb/1Tj
         /NwIHtooTuL730Cw4SsSFRHabAXQ7KSXcjqzxwVJURZSNWD/JQLhM9wDL0C61H8cEOCj
         pe//NfV4TmnsSi9Bxk3uQStIRTsWh++Fs2MEP7f+uvUSEgI7rw2ColA7n5GPYgwspb1J
         qDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H84hohhtAqK/9czLCk7eWnRTskJbqxdwaPZ3PkL4jCc=;
        b=rxtkL2X9hqCWBVEYh0N/AHe+jdfHiFsU8eFvWIMEeglWcA1oknvbBs8HgQk7OJ31tA
         dBCtz6wvBNrd9AKro7K8EbnpPd1H32QK07UQ5HYByIn1CfFSMIiIKB4ADn9uvnlIm9cI
         mUOax1QFZw4uEmZltC6/V82iDMapfjKZ4/ixUO3Y01PfPgxH1zECCTLKeKdSQzIVRLoW
         bXZil3BQuciXy34npsgrmYE4G6gHjC6rMK13hNc4SLEPoRx8cHltWX2WD6WuhmcsqKIm
         CBrLGkpIsofGP5dtHU6SVksQEOLex65XEubiQ8McWlQuwc+4RMo/seqpuatKG1AhIUCz
         rnKA==
X-Gm-Message-State: AOAM530Gm3zWBkxEnc4LLefjhLgRBDlBD8jubAgBVqb3GuBRtGQZe5ZW
        GE5kp+j7MV2dCkFnBv9zzCYikd9L8dQ=
X-Google-Smtp-Source: ABdhPJyiniqvnHK7bwY8xMQAcyz/XAR0iE8CvGunP7iNFrEqnZszK4awLq3nX1L8pcCzOCTDDhXg0g==
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr31638700ejd.160.1608141894561;
        Wed, 16 Dec 2020 10:04:54 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id l1sm1919066eje.12.2020.12.16.10.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 10:04:53 -0800 (PST)
Subject: Re: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20201016120431.7062-1-marek.vasut@gmail.com>
 <20201210181133.GA3766@e121166-lin.cambridge.arm.com>
 <83135f6f-8a98-4537-0df5-91a06af07955@gmail.com>
 <20201214160829.GA3623@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <d7279eff-2129-f58c-baed-aa805f26429d@gmail.com>
Date:   Wed, 16 Dec 2020 18:49:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201214160829.GA3623@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/14/20 5:08 PM, Lorenzo Pieralisi wrote:
> On Sat, Dec 12, 2020 at 08:13:54PM +0100, Marek Vasut wrote:
>> On 12/10/20 7:11 PM, Lorenzo Pieralisi wrote:
>>
>> [...]
>>
>>>> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
>>>> index 1194d5f3341b..ac5c7d7573a6 100644
>>>> --- a/drivers/pci/controller/pcie-rcar-host.c
>>>> +++ b/drivers/pci/controller/pcie-rcar-host.c
>>>> @@ -753,7 +753,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>>>>    	}
>>>>    	/* setup MSI data target */
>>>> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>>>> +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);
>>>
>>> This does not do what you want on !CONFIG_ZONE_DMA32 (ie arm LPAE).
>>
>> How come? I would expect GFP_DMA32 allocates a buffer below 4 GiB in any
>> case.
> 
> For ARM LPAE allocation falls back to ZONE_NORMAL that happens to work
> because if there is memory > 4GB it ends up in ZONE_HIGHMEM, so this
> patch should still work on ARM LPAE too.
> 
> Regardless, thoughts above the alternative approach (that saves you
> a page allocation) ?

Since this is a bugfix, I would prefer it to be minimal.

Also, in case there was some yet undiscovered hardware bug which would 
let the MSI write through, having unused memory as the MSI destination 
address would only lead to write into that memory -- instead of a write 
into some other address.

Changing this to some hard-coded address (any suggestions?) can be a 
subsequent patch.
