Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5574235B3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 04:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhJFCJc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 22:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbhJFCJb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 22:09:31 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F04C061753;
        Tue,  5 Oct 2021 19:07:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g21so932248qki.11;
        Tue, 05 Oct 2021 19:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1KHdowUwAPHkcsSFMeTkk2K8mdh38Vk2CyxBkaIJorc=;
        b=L8YihqYmPy4BvFxToVpOLSSFAP8vsUnYOS7aFQ0rT92GfMzaOJmCw2VTAYorRcso8y
         WTBF7AIG+2FCVJGw2wKVjuPiYZhFx4Qw3WVfhrjz+8mdLzSRakSOxxCObgluoQaXZtnn
         74WLDYgiDht+0ZPaoxWWlKLTpdA3JY62KeTyg1JOHNZKQ7rUcBt4E3T87bap9XFSn9c7
         4JgoGwtBdRnlVhj5ABe8ZcBAbpJUlBvM36Nw0PuaG7Ftigh5sQthOHqSH2NFprV9NYqf
         lb8AR+R+7AfNOxa+FIafHvkGoVLNJM00ksitWouvyNm5Ls8zX/vTeGGw6r6mJt8X2VZw
         orLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1KHdowUwAPHkcsSFMeTkk2K8mdh38Vk2CyxBkaIJorc=;
        b=hBA/0YEs48xBPFCyCgASsyDTSPSrrcn7+5Hc1Mp59j3biWbmFve5Pliarv94m+/Ifh
         +eYZuQ/SsaVdMDtT9ryNeWkEBqbvFmWb8Ttgy1ngY97VS04A8wKf3gelWmeW++paFrkA
         dxV20XGsIQSiQ4icHDKphRQWR2vq5Xxgk5f1xqf8hhnPoCUins7UlrH5JSrSslZGalle
         +HA2LaAQqRiVrXR+nIpv7Z+vLnTNNwqsn8cdWKryxWrKx6EJp1fT3MUQPmulD54bChKU
         /XECYBP3xpAhpizxAN/yUSDgzznE8iapXOPNzh8RjuT42b/Sh3w6u4BryTscx2cCFu2F
         Tkgg==
X-Gm-Message-State: AOAM531fslOC/aLlSysdUm8AcI6QaK5z6Ca1Cbf79EN0AoT7QHuUalWg
        KskpVspmVpxCeDtC/r/qBdE=
X-Google-Smtp-Source: ABdhPJwnC4ol34I01EFnyvRqTYCjtBOKq9mS9+5fIYuqW3Dhiz4i6cWKdyo2dW1o4KhdRYMMdF8PkA==
X-Received: by 2002:a37:6553:: with SMTP id z80mr17594261qkb.42.1633486059467;
        Tue, 05 Oct 2021 19:07:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:dfe0:49f0:c86a:e663:3309:49d7? ([2600:1700:dfe0:49f0:c86a:e663:3309:49d7])
        by smtp.gmail.com with ESMTPSA id o202sm10554288qke.51.2021.10.05.19.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 19:07:39 -0700 (PDT)
Message-ID: <6be712f8-c794-aa55-8679-5ddb5a16bcef@gmail.com>
Date:   Tue, 5 Oct 2021 19:07:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
Content-Language: en-US
To:     Jeremy Linton <jeremy.linton@arm.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211005153209.GA1083986@bhelgaas>
 <d4b34193-31e5-2f95-6365-b58239c0dabb@arm.com>
 <20211005194301.enb5jddzdgczcolx@pali>
 <694bb355-3b5e-9801-3772-ff784b49a603@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <694bb355-3b5e-9801-3772-ff784b49a603@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/5/2021 3:25 PM, Jeremy Linton wrote:
> Hi,
> 
> On 10/5/21 2:43 PM, Pali Rohár wrote:
>> Hello!
>>
>> On Tuesday 05 October 2021 10:57:18 Jeremy Linton wrote:
>>> Hi,
>>>
>>> On 10/5/21 10:32 AM, Bjorn Helgaas wrote:
>>>> On Thu, Aug 26, 2021 at 02:15:55AM -0500, Jeremy Linton wrote:
>>>>> Additionally, some basic bus/device filtering exist to avoid sending
>>>>> config transactions to invalid devices on the RP's primary or
>>>>> secondary bus. A basic link check is also made to assure that
>>>>> something is operational on the secondary side before probing the
>>>>> remainder of the config space. If either of these constraints are
>>>>> violated and a config operation is lost in the ether because an EP
>>>>> doesn't respond an unrecoverable SERROR is raised.
>>>>
>>>> It's not "lost"; I assume the root port raises an error because it
>>>> can't send a transaction over a link that is down.
>>>
>>> The problem is AFAIK because the root port doesn't do that.
>>
>> Interesting! Does it mean that PCIe Root Complex / Host Bridge (which I
>> guess contains also logic for Root Port) does not signal transaction
>> failure for config requests? Or it is just your opinion? Because I'm
>> dealing with similar issues and I'm trying to find a way how to detect
>> if some PCIe IP signal transaction error via AXI SLVERR response OR it
>> just does not send any response back. So if you know some way how to
>> check which one it is, I would like to know it too.
> 
> This is my _opinion_ based on what I've heard of some other IP 
> integration issues, and what i've seen poking at this one from the 
> perspective of a SW guy rather than a HW guy. So, basically worthless. 
> But, you should consider that most of these cores/interconnects aren't 
> aware of PCIe completion semantics so its the root ports responsibility 
> to say, gracefully translate a non-posted write that doesn't have a 
> completion for the interconnects its attached to, rather than tripping 
> something generic like a SLVERR.
> 
> Anyway, for this I would poke around the pile of exception registers, 
> with your specific processors manual handy because a lot of them are 
> implementation defined.

I should be able to get you an answer in the new few days whether 
configuration space requests also generate an error towards the ARM CPU, 
since memory space requests most definitively do.
-- 
Florian
