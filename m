Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE22D89A4
	for <lists+linux-pci@lfdr.de>; Sat, 12 Dec 2020 20:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439857AbgLLTUH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Dec 2020 14:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLLTUG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Dec 2020 14:20:06 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EFCC0613D3;
        Sat, 12 Dec 2020 11:19:25 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id u19so12980587edx.2;
        Sat, 12 Dec 2020 11:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oPc/r9BQ5UB7YK8Ckj/oZJBlPi1FTCS20ucGiOtOZTo=;
        b=M19p5ocdhhgKmeZNbHWkuzmEYib3WwK/6Psg+ocbHeQpxriAN4mBTnUA2Q/mBHd4A4
         gnF4GvQ0Gz+7VoyKtOqpG2aAxhgkEe0phmcojk+DT84MYY2qnzn5zI8bZRVK/h65x2RH
         k0Nh+HVvfcGD1nZJz7p6HSTlt78mxkhLVPmFxk+Tw9D/LwLmtlxBiYvtGGBsiEiiSk8e
         153FmjTu7M4JBvT+C4svEHjp2pyXZYEGwN7oINXsfhcv1DM6ChXsiqLx0WeP14aBCe/w
         MFBV4tzB1GA57nSducizMVnpmLxl63ju4/TbIFtWepV8ryxM0P+VyeS0fsJ/Upp86GPy
         kliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPc/r9BQ5UB7YK8Ckj/oZJBlPi1FTCS20ucGiOtOZTo=;
        b=iaFWO3KwC+XwkeyN9bIVmZ5VSPBXug1eUUwkv7gvoJgMV4uNskxDaUN8kXllQDFFAS
         3Hj5LUgaqA/TAhJN4/cFwtUk6xfy9WpNQ682RFtidwgpT4WIfQezYDWh+OLkHDRjSNqM
         I2HP7Wue6PdqqggIbuAycYBHu0ce2KBciPFhtUP8qQamcfcDO/D/iaZDt9RJ6+Yt2dpB
         ksm8ATfjWJyQtuYqw9CQbIGiZQ45UcuA0vKGgGLsX4D+AWMDhxcDHir4RIKz3jYJCFfP
         cUpsd/uzSgGwI2zSFbUL3pmz8tCMreDpyqMVpIy+LdUioXgNbk1Z04hPt1gbLVcfqKBW
         JIfg==
X-Gm-Message-State: AOAM532Is4vIToyeJvWAuNVPeXz1IIjCJTvPSBA8TzRdrMsy+SolInft
        9Zga/kFEdKY/v+pwi62DqBAJwcmgLryixg==
X-Google-Smtp-Source: ABdhPJzfvYCXPMJh6F26oER8D4cDCKw1FFhifttRoCFfjMThdKwBNP/R5vZp7/mxGvbhqFeaG9IZfQ==
X-Received: by 2002:aa7:c749:: with SMTP id c9mr3414285eds.3.1607800764541;
        Sat, 12 Dec 2020 11:19:24 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id ot18sm9544548ejb.54.2020.12.12.11.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 11:19:23 -0800 (PST)
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <a65139b9-3b06-0562-7b6e-9a438aecff66@gmail.com>
 <20201208184627.GA2393103@bjorn-Precision-5520>
 <20201210121250.GA31998@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b569d614-2548-5ce1-32f0-dc923a508710@gmail.com>
Date:   Sat, 12 Dec 2020 20:12:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210121250.GA31998@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/10/20 1:12 PM, Lorenzo Pieralisi wrote:

[...]

>>>>> +static int __init rcar_pcie_init(void)
>>>>> +{
>>>>> +	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
>>>>> +#ifdef CONFIG_ARM_LPAE
>>>>> +		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>>>>> +				"asynchronous external abort");
>>>>> +#else
>>>>> +		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>>>>> +				"imprecise external abort");
>>>>> +#endif
>>>>> +	}
>>>>> +
>>>>> +	return platform_driver_register(&rcar_pcie_driver);
>>>>> +}
>>>>> +device_initcall(rcar_pcie_init);
>>>>> +#else
>>>>>    builtin_platform_driver(rcar_pcie_driver);
>>>>> +#endif
>>>>
>>>> Is the device_initcall() vs builtin_platform_driver() something
>>>> related to the hook_fault_code()?  What would break if this were
>>>> always builtin_platform_driver()?
>>>
>>> rcar_pcie_init() would not be called before probe.
>>
>> Sorry to be slow, but why does it need to be called before probe?
>> Obviously software isn't putting the controller in D3 or enabling ASPM
>> before probe.
> 
> I don't understand it either so it would be good to clarify.

The hook_fault_code() is marked __init, so if probe() was deferred and 
the kernel __init memory was free'd, attempt to call hook_fault_code() 
from probe would lead to a crash.

> Also, some of these platforms are SMP systems, I don't understand
> what prevents multiple cores to fault at once given that the faults
> can happen for config/io/mem accesses alike.
> 
> I understand that the immediate fix is for S2R, that is single
> threaded but I would like to understand how comprehensive this fix
> is.

Are you suggesting to add some sort of locking ?
