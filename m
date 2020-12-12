Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722362D89A1
	for <lists+linux-pci@lfdr.de>; Sat, 12 Dec 2020 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439853AbgLLTUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Dec 2020 14:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLLTUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Dec 2020 14:20:04 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DC5C0613CF;
        Sat, 12 Dec 2020 11:19:24 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id d17so17021402ejy.9;
        Sat, 12 Dec 2020 11:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZO0EINQxqxncVEQ2XCrcBsREkS1Llq3e2spp8JjZbcc=;
        b=LvrIb9MHH8lR3Cau4zAXZQL1m1R2/bVc3qPWTrZJxJQESRl9LOd6zsTCtuMMxtKJv9
         H6dXziyUl3Xs+QZ8TSY6N1/dYaqG+Ppjrkcl428c3OpUFRlnKbdAk1ykxCkaxcOukdlH
         HDb8g3U2q1xAQKiEg5C1HKPLxbgYxPE8wQZ8FGIJyOy9F+Qb1y6xmn6R+5wTuvkvY4tq
         Q8eshJyyiLB/5zWCZ12L2h8mTvShatBVyRWWxBmnhywnBTBWseOXsHWIT72VGFnJRQbP
         AwvV5lBfMQDxdzWKUPcsDa6EbADCSDfkQomxmUb7h0clhh8b8dAYZcfrPIFNvhhXePB3
         lT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZO0EINQxqxncVEQ2XCrcBsREkS1Llq3e2spp8JjZbcc=;
        b=NHtQAB8tPnTesnzHDkMfIq0oWmAoGUjJ2QDQPH3zBP5NatjLWHHKeXxjWpCOYhITKD
         TeN7wTwU0VQ2yZRI8lKLZxb2n18oKIA+Gxa79SgwOXzZiA2pl+OibzEAfRrR7sOOtPEG
         YuaenGD8u0QwElCVNU5rK75t4qIAvuX1bzqaEX1UQqFThTtSBf9ioAV6Ujr3KVb0Ij//
         cx4iV1y+IhdgwkbFXhk2uRqq11Y3aDoXSJoVWDzYqK57fdDxNYiN+mWBZfL0w5syawiM
         reF1iE0QiCs+BpTykytgGU/VKXk4YbLGoV3DU6B9+Kws/sCAfANHxs7a9EgmMUTmSuAt
         l/Fw==
X-Gm-Message-State: AOAM53245xbE3sBE0BhmnWD/qArZukfrR6IS8meFi0/des3O9YWvHjZU
        gnuZ1AcWJVTV2ff64NZ2wEb52ISGyJONKQ==
X-Google-Smtp-Source: ABdhPJz1YTl5s1ImO9jwncBxC13DtW7e+NWS2xYCyyCH24q0UqG51B0PjH+lN2tm3jRQvL7W+5aOWg==
X-Received: by 2002:a17:906:34ca:: with SMTP id h10mr16498366ejb.417.1607800762899;
        Sat, 12 Dec 2020 11:19:22 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id rl7sm9618286ejb.107.2020.12.12.11.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 11:19:22 -0800 (PST)
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20201208184627.GA2393103@bjorn-Precision-5520>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <0688fa35-74ab-91d8-7e3c-aae93439e6fd@gmail.com>
Date:   Sat, 12 Dec 2020 20:10:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208184627.GA2393103@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/8/20 7:46 PM, Bjorn Helgaas wrote:

[...]

>>>> +static int __init rcar_pcie_init(void)
>>>> +{
>>>> +	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
>>>> +#ifdef CONFIG_ARM_LPAE
>>>> +		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>>>> +				"asynchronous external abort");
>>>> +#else
>>>> +		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>>>> +				"imprecise external abort");
>>>> +#endif
>>>> +	}
>>>> +
>>>> +	return platform_driver_register(&rcar_pcie_driver);
>>>> +}
>>>> +device_initcall(rcar_pcie_init);
>>>> +#else
>>>>    builtin_platform_driver(rcar_pcie_driver);
>>>> +#endif
>>>
>>> Is the device_initcall() vs builtin_platform_driver() something
>>> related to the hook_fault_code()?  What would break if this were
>>> always builtin_platform_driver()?
>>
>> rcar_pcie_init() would not be called before probe.
> 
> Sorry to be slow, but why does it need to be called before probe?
> Obviously software isn't putting the controller in D3 or enabling ASPM
> before probe.

The hook_fault_code() is marked __init, so if probe() was deferred and 
the kernel __init memory was free'd, attempt to call hook_fault_code() 
from probe would lead to a crash.
