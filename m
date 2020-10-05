Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AAA283145
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEIAb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 04:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEIAb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 04:00:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEF6C0613CE;
        Mon,  5 Oct 2020 01:00:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l16so1034188eds.3;
        Mon, 05 Oct 2020 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DxvT4dUHvLDSlRAbaeKYV/ezETviNmoPzmW8OvVTpX0=;
        b=L8r9T7OcF6XUGXBl53WZEW22hogNFZ/yKdvsl8J8d5vad5B9OQGjZJy2rg+Er2fI+A
         gD+qMeXGsFJUqubfslJHhGmJGCnE6xVMjo1M4DuUPiSSM4r9wSVko/dno+/8OwLk7W6Y
         Sk4fuooK1rGMNdXGjzx0ZGZwlV9gX5sGFkoLCbwG0GbzfIaXniVKX1CFnFS3gy+BIN+E
         ZrLPZ04KGUtxWsAO+YT6NrEgiSetlYiL9i/RhCwLaljdYMwTHYrmLA5o74QP8qp+Ys9u
         vM72ffdrBJDvMfKbZNvq6V6zTMwa8Y+bKGaeQjxzoZDR/YLa6BhWHGpzjyTVIC4x9zn/
         ONFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DxvT4dUHvLDSlRAbaeKYV/ezETviNmoPzmW8OvVTpX0=;
        b=N4wz/AZUAMuZCSMUFkqluTzaRpthUZwS3asWN/bfyEoxFgLXD6sSr+6M7pttvSFpFD
         YaYl1Kgvilrl8ujcrh7giXQ4pkw+0XB12Tx5IFFxjBTi05zw1yVJhXRoWn1Hnscx3Oqh
         z+tMPI9LjjtCZ6w1qY6u8t029P36BJJfoB6715jggDoUFOT0+o2SugBdmRz+qQpMZNHz
         7GxgCn3IaSxU76/l9tscixdw4Qb+DsUGnPFmWOTkMyNpHiikjWLZRrMVGBXXtgydErih
         sh5A1HHiGs3yPFeENv8b8yt0GB3LoMGt1QukAOU8yW+yPeEtEUWMOQKfVN4YvuZp0P/s
         jMtg==
X-Gm-Message-State: AOAM532eozYEEm7eBd1pxuI9ZVtHtc/DWlMId6ppq4C+xt88+cefYnBB
        n7+Fo/9SMTWdWOND3+pFnmc=
X-Google-Smtp-Source: ABdhPJxi4ltmoPB1vIe8O7pCNnp0snOEIghXZulZar3m7uJ1FNiwZSxGitw14ipraj8R+YjK/EIduQ==
X-Received: by 2002:aa7:ccd7:: with SMTP id y23mr14737792edt.106.1601884828010;
        Mon, 05 Oct 2020 01:00:28 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id r4sm5695951edv.16.2020.10.05.01.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 01:00:27 -0700 (PDT)
Subject: Re: [PATCH V2] PCI: rcar: Add L1 link state fix into data abort hook
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        m-karicheri2@ti.com
References: <20200926160934.136182-1-marek.vasut@gmail.com>
 <CAMuHMdURuSsYRwi10FT+s-rVjok0f-FgS6G8rmpg46u98scMkQ@mail.gmail.com>
 <1431d12a-0e19-6795-b2e0-fb652f8a95c1@gmail.com>
 <CAMuHMdWtj=c=y7a2+W10HgYNj3rh2P6nSDd-j4RKKuUiztCxjA@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <668471a3-af14-e083-bed9-722015546830@gmail.com>
Date:   Mon, 5 Oct 2020 10:00:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWtj=c=y7a2+W10HgYNj3rh2P6nSDd-j4RKKuUiztCxjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/5/20 9:31 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Sun, Oct 4, 2020 at 4:16 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 9/28/20 11:35 AM, Geert Uytterhoeven wrote:
>> [...]
>>>> +static int __init rcar_pcie_init(void)
>>>> +{
>>>> +#ifdef CONFIG_ARM_LPAE
>>>> +       hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>>>> +                       "asynchronous external abort");
>>>> +#else
>>>> +       hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>>>> +                       "imprecise external abort");
>>>> +#endif
>>>
>>> As there can be only a single handler, this may interfere with a handler
>>> for another platform in a multi-platform kernel.
>>> Hence I think this should not be done unconditionally, but be moved to
>>> the driver's .probe() callback.
>>
>> Why is nobody doing this in the probe code then ? It seems all the other
> 
> drivers/pci/controller/dwc/pci-keystone.c is:
> 
>   ks_pcie_probe()
>     ks_pcie_add_pcie_port()
>       dw_pcie_host_init()
>         pp->ops->host_init(pp) = ks_pcie_host_init()
>           hook_fault_code()

Well that one is interesting. I wonder whether that driver has the same
LPAE bug (different fault code for LPAE and non-LPAE configuration) we
found here too, since it is used on CA15 TI SoCs.

>> drivers which hook fault code do it in init as well. I can imagine that
> 
> Probably nobody bothered exercising the external abort handler on
> multi-platform kernels?
> 
>> something might trip the fault handler even before probe is called, e.g.
>> some PM handling or simply user accessing that PCIe area using setpci.
> 
> If that is the case, it must indeed by done earlier, but still
> conditional on the presence of the actual PCIe controller.

I am open to suggestions how to do that part.
