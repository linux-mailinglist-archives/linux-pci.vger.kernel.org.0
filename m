Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656132E78AA
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 13:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgL3MsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 07:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgL3MsK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 07:48:10 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96061C061799;
        Wed, 30 Dec 2020 04:47:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jx16so21731586ejb.10;
        Wed, 30 Dec 2020 04:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CxkO0u2DDwUDwNphu1UviJaEoDhcWRliv36UwNI4aGY=;
        b=QslWLCJgjOU7NNKBwav3kamaDcSD2lumG4jYniC18TZ8KmgzBsIwwVGSAOVgut1kmV
         r6e1rw3PpDAdNPpBsWkmob7CT6svYXEHNjVKHwuIiTL9g/nrsdmVFaxjDBIYU1b08222
         FtDInV6q1DOXnzw6hcUPccwKcxu5qMb4c1APbPMwPnKYV6FsQ1YUZO9ZRWa+yzcLbXcV
         xZWfRxbGh4MMV1BoDDs1+Myt243aBaPkENsMFL9dvKeNxi5UYAjjLBnoSBNN3zXHTGCz
         FrlwcWFwMRpkkm//VQiTQO/2k6P2TWVRPHqcWobKJRIa5VibnbmIeBFPi3ELooEeofWj
         x9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CxkO0u2DDwUDwNphu1UviJaEoDhcWRliv36UwNI4aGY=;
        b=Xgt9gIHyllT6MYDI/RU0wmh/HX3wu9NyWMObCwt9MdJ3so3SXAMeI9bhR+fop/LcOb
         q9zxKXoK/5Qc14JuGYWMOkvJpwc4vT5CjRX58kO4CRHP2Gijk+FgaLEPo7b+b7W2bR+o
         n5O+oHe3k/XpI8Oefjz5btRK4vLNwcvyCoCIiWmsPEdXeHq4xHZaAPedBjJTIpwLyUAh
         2atvhS98mcEJdZUty61MPINF3Advl84gzn7G4ps6O1KOewgOQ0cM/EJQ+C/nAUHc1wsi
         AXqbag91gtMvjK3an5A1pzvBKBltGePKLpNo8poLwCNiZiHrp+7mILYsNIbd2EYgUKvx
         dfeg==
X-Gm-Message-State: AOAM5303Os9a3B5MLcOqlYtHnHQGuTMHeiHUfOLmThc7vsLN3pz1JJOz
        hXV6LzFLsRVeDyAZvrCghDvc3nKodjQ=
X-Google-Smtp-Source: ABdhPJzR0vPLyKG2eczVD2tEQ/EjhXsZ7i5VyvaGVd/JjcsZYoRGFsPxFz/PsOphpadmj2NtE7L4mQ==
X-Received: by 2002:a17:906:2257:: with SMTP id 23mr23014355ejr.497.1609332448324;
        Wed, 30 Dec 2020 04:47:28 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id d13sm24338666edx.27.2020.12.30.04.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 04:47:27 -0800 (PST)
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
 <d7279eff-2129-f58c-baed-aa805f26429d@gmail.com>
 <20201221100129.GA15846@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b72d6558-64a5-6936-d46d-fddc0aa49b8a@gmail.com>
Date:   Wed, 30 Dec 2020 13:47:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201221100129.GA15846@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/21/20 11:01 AM, Lorenzo Pieralisi wrote:

[...]

>>>>>> --- a/drivers/pci/controller/pcie-rcar-host.c
>>>>>> +++ b/drivers/pci/controller/pcie-rcar-host.c
>>>>>> @@ -753,7 +753,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>>>>>>     	}
>>>>>>     	/* setup MSI data target */
>>>>>> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>>>>>> +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);
>>>>>
>>>>> This does not do what you want on !CONFIG_ZONE_DMA32 (ie arm LPAE).
>>>>
>>>> How come? I would expect GFP_DMA32 allocates a buffer below 4 GiB in any
>>>> case.
>>>
>>> For ARM LPAE allocation falls back to ZONE_NORMAL that happens to work
>>> because if there is memory > 4GB it ends up in ZONE_HIGHMEM, so this
>>> patch should still work on ARM LPAE too.
>>>
>>> Regardless, thoughts above the alternative approach (that saves you
>>> a page allocation) ?
>>
>> Since this is a bugfix, I would prefer it to be minimal.
> 
> Yes, I agree with you on that.

Then maybe it makes sense to apply this bugfix so others can benefit 
from it too ?

>> Also, in case there was some yet undiscovered hardware bug which would
>> let the MSI write through, having unused memory as the MSI destination
>> address would only lead to write into that memory -- instead of a
>> write into some other address.
>>
>> Changing this to some hard-coded address (any suggestions?) can be a
>> subsequent patch.
> 
> The idea was taking the address from the host controller inbound window
> (ie an address outside the dma-ranges ~(dma-ranges) and < 4GB), it
> should not matter which one.

Wouldn't that make the code quite unnecessarily complex for no gain ?
The above fix does just that in one line, unless there is some code in 
the PCI subsystem to select such an address already ?

> I agree though that this can be a
> subsequent patch even though usually we send for -rc* only fixes for
> patches that hit the previous merge window - this seems a quite
> longstanding (I traced it back to v3.16) one so it would wait till
> v5.12, there is time to refactor it.

I see, I was not aware of this policy toward bugfixes.
