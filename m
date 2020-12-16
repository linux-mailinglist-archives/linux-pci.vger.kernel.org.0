Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F32DC5E3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 19:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgLPSFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 13:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgLPSFi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2020 13:05:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA9C06179C;
        Wed, 16 Dec 2020 10:04:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g24so203543edw.9;
        Wed, 16 Dec 2020 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PIsfJm9r8GfVDKwqzG92PdIULR8PFcPCijNg/BORHc4=;
        b=SD5d0WXl32ecdaJwZeNDb7GbX3sVMbwdNyEmuJoiJzqZ9+Pphp4pXOmpY5F6v3ZGAa
         S08UiVynwm4lR9kiz2AFJCFbJUUFi/Xr5btk6m6NMptPB2QYe0DtYKqh7LGKfcikXSyn
         Fl1oqgmel3FxXqgBWV07tBx7/JByMn2oT3i1rSUDrUAXqVEho4i+6r06SMOT0XDFmAzd
         X5D4cFVRx6GON7T+hWKhZ46Opc6iKbzR/Xr0brkjKElpWtHdKcYMHRBH9RJjfm7kcsO0
         8E+B9HDyW+95CQD3yfCQwGWDjkZs9li3CuO4/IWmvMdgfzgRprEbyYNq9E44no7dnmIw
         5zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PIsfJm9r8GfVDKwqzG92PdIULR8PFcPCijNg/BORHc4=;
        b=ZwY3ItnBJO/+ofv8+oRUmbEa7V23S+P7OMLSk5iAm7seshBFAcoqI4DUdrEfI+k3fC
         Gha8MVYuk8ciM8430UTEylBslEyd/Oi+c6Uj+2BcTozGbL9XjTJSvRFT2kVpgD3ZDdp3
         CrB6bhvT/mdnQKf7NBcG4jptvcNWkx5NV4U1v/hvG9M16p7sCuYhhzQxT/8Q+ljyk3kl
         lDgr5FZasVcSlKA9+MENywK74lOivH/sXduiTatVxGYRwwRvzUbBQ9c8gKiCxtetlJ3k
         9FP5A00/jUyzl4N4EnYGbdlD+wKaIVWlpQLP2QN4aCFvroIJasOojshEbf2KHNiJvYuU
         boiA==
X-Gm-Message-State: AOAM533x+V2UAD+qKUhbAAXFcwadHDvuWBk4FjhmuSQTkUoTsbkufMmT
        SS1o5dxno8VJAEjcIQAq0YGpzuouNj0=
X-Google-Smtp-Source: ABdhPJwvE7hRtHvr1QVHol3CFCVMK88NY30Iuiyl8UfILmzzGvykL7kygIdBBVoqga2nnHcniQbJeg==
X-Received: by 2002:aa7:d999:: with SMTP id u25mr34331011eds.297.1608141896424;
        Wed, 16 Dec 2020 10:04:56 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id e11sm1876751ejz.94.2020.12.16.10.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 10:04:55 -0800 (PST)
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <a65139b9-3b06-0562-7b6e-9a438aecff66@gmail.com>
 <20201208184627.GA2393103@bjorn-Precision-5520>
 <20201210121250.GA31998@e121166-lin.cambridge.arm.com>
 <b569d614-2548-5ce1-32f0-dc923a508710@gmail.com>
 <20201214171314.GA4278@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <68e2f34d-cafb-5250-9370-9ebb2fe002a1@gmail.com>
Date:   Wed, 16 Dec 2020 18:52:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201214171314.GA4278@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/14/20 6:13 PM, Lorenzo Pieralisi wrote:
[...]

>>>>>> Is the device_initcall() vs builtin_platform_driver() something
>>>>>> related to the hook_fault_code()?  What would break if this were
>>>>>> always builtin_platform_driver()?
>>>>>
>>>>> rcar_pcie_init() would not be called before probe.
>>>>
>>>> Sorry to be slow, but why does it need to be called before probe?
>>>> Obviously software isn't putting the controller in D3 or enabling ASPM
>>>> before probe.
>>>
>>> I don't understand it either so it would be good to clarify.
>>
>> The hook_fault_code() is marked __init, so if probe() was deferred and the
>> kernel __init memory was free'd, attempt to call hook_fault_code() from
>> probe would lead to a crash.
> 
> Understood - I don't think there is a point though in keeping
> the builtin_platform_driver() call then, something like:
> 
> #ifdef CONFIG_ARM
> ...
> static __init void init_platform_hook_fault(void) {
> 	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> 		#ifdef CONFIG_ARM_LPAE
> 			hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> 					"asynchronous external abort");
> 		#else
> 			hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> 					"imprecise external abort");
> 		#endif
> 	}
> }
> #else
> static inline void init_platform_hook_fault(void)
> {}
> #endif
> 
> static int __init rcar_pcie_init(void)
> {
> 	init_platform_hook_fault();
> 	return platform_driver_register(&rcar_pcie_driver);
> }
> device_initcall(rcar_pcie_init);

Does this look simpler than the code in this patch ?

> Or we remove the __init marker from hook_fault_code().

This is a bugfix, it should be possible to backport this through the 
stable tree easily, without changing core architecture code.

>>> Also, some of these platforms are SMP systems, I don't understand
>>> what prevents multiple cores to fault at once given that the faults
>>> can happen for config/io/mem accesses alike.
>>>
>>> I understand that the immediate fix is for S2R, that is single
>>> threaded but I would like to understand how comprehensive this fix
>>> is.
>>
>> Are you suggesting to add some sort of locking ?
> 
> If we merge a fix the fix has to work, by reading the code if multiple
> cores fault at once this fix seems to have an issue that's why I asked,
> you may still end up with an unhandled fault by reading the code.

So, are you suggesting the hook needs some locking ?
