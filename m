Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34D437B6E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhJVRHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 13:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhJVRHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 13:07:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B36C061220;
        Fri, 22 Oct 2021 10:04:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t11so3151022plq.11;
        Fri, 22 Oct 2021 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Atun2XzPcF2gQ2cFelDuDf6hZcJLP5wmun4wG8uLgTg=;
        b=ehEzXEOXQ5KJlHU9KCtkcgahWx9N0fv7UE3GOTTVaIufyIpBM+KyE/epTJk/OoX19P
         fOigU8PZHpOyeR3j4P/Uotf1L1t7gXFyZNLqIIU3hxuweVI9m5XiSUoiNz2+WFpT90C6
         6c/SFE0gpdFA/YZrv4WxXHh8KZ0F0uOlDhi9Sn/2FKpnGNFvwlLbAgX0zMnYAJ3AHkUh
         1TjxxEK7CVpDHYNBMTkquO4Uzo7gaMSQKFd3QDlsUHV6efe6gm4tL/nhNKqcFmQkxz5B
         mvgIhrACvFzxgqvubJaADiftt+3VvWYl28faULNSMlfbf22CsmzI2oHujfv3A9dnSeeC
         wwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Atun2XzPcF2gQ2cFelDuDf6hZcJLP5wmun4wG8uLgTg=;
        b=PRtqmbPuXcuDCQrpVqQZiXcD2slkeZY3SGIN2gMyJ95n2EUeyId80XkKv0TzVQCrMj
         gLjsYoKjHcEOLhKwwG9nqbjVl0Ah5ZMeBBK7hsBYeggp/+dQGFSRNuizOiOEgL6XrNOc
         ZcQHAMKQKPL5Wt0KPPrVpuNa5XkBk8HAmIilQaMOYMROszVgNWsOw+WUPi72r3SgHkG5
         L9ahbg7VrHmOOUH2VezfhthogIMbWCseSpCiNIeTgsJSa3L9obL9JoBBVjrttj96iaEc
         GjBKir7XnOKN0EANuF2/FJAkA9I5nl6Zae6NWmNlTXAWm+QSL+Yza5R6Zg5/YGUBz0KC
         5waw==
X-Gm-Message-State: AOAM530AcJLNk+viXBOztQwI0dZMV3dUd1mXY1Yrm2Ve23wJUcgU6iQc
        f5RlaiGTJNANQp5hCTUfppyBj1zM1cM=
X-Google-Smtp-Source: ABdhPJyuD+kv4M42bYgaTqWiN3Mb9J60eG5D/doNRTJOmZ58uBqcEdy0PxPDH30tAimIyAsdKxFPnA==
X-Received: by 2002:a17:90a:e57:: with SMTP id p23mr1232215pja.154.1634922279448;
        Fri, 22 Oct 2021 10:04:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p25sm12262866pfh.86.2021.10.22.10.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 10:04:38 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211005153209.GA1083986@bhelgaas>
 <d4b34193-31e5-2f95-6365-b58239c0dabb@arm.com>
 <20211005194301.enb5jddzdgczcolx@pali>
 <694bb355-3b5e-9801-3772-ff784b49a603@arm.com>
 <6be712f8-c794-aa55-8679-5ddb5a16bcef@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f648bc89-f08b-e806-45f9-5a1b61686e19@gmail.com>
Date:   Fri, 22 Oct 2021 10:04:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6be712f8-c794-aa55-8679-5ddb5a16bcef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/5/21 7:07 PM, Florian Fainelli wrote:
> 
> 
> On 10/5/2021 3:25 PM, Jeremy Linton wrote:
>> Hi,
>>
>> On 10/5/21 2:43 PM, Pali Rohár wrote:
>>> Hello!
>>>
>>> On Tuesday 05 October 2021 10:57:18 Jeremy Linton wrote:
>>>> Hi,
>>>>
>>>> On 10/5/21 10:32 AM, Bjorn Helgaas wrote:
>>>>> On Thu, Aug 26, 2021 at 02:15:55AM -0500, Jeremy Linton wrote:
>>>>>> Additionally, some basic bus/device filtering exist to avoid sending
>>>>>> config transactions to invalid devices on the RP's primary or
>>>>>> secondary bus. A basic link check is also made to assure that
>>>>>> something is operational on the secondary side before probing the
>>>>>> remainder of the config space. If either of these constraints are
>>>>>> violated and a config operation is lost in the ether because an EP
>>>>>> doesn't respond an unrecoverable SERROR is raised.
>>>>>
>>>>> It's not "lost"; I assume the root port raises an error because it
>>>>> can't send a transaction over a link that is down.
>>>>
>>>> The problem is AFAIK because the root port doesn't do that.
>>>
>>> Interesting! Does it mean that PCIe Root Complex / Host Bridge (which I
>>> guess contains also logic for Root Port) does not signal transaction
>>> failure for config requests? Or it is just your opinion? Because I'm
>>> dealing with similar issues and I'm trying to find a way how to detect
>>> if some PCIe IP signal transaction error via AXI SLVERR response OR it
>>> just does not send any response back. So if you know some way how to
>>> check which one it is, I would like to know it too.
>>
>> This is my _opinion_ based on what I've heard of some other IP
>> integration issues, and what i've seen poking at this one from the
>> perspective of a SW guy rather than a HW guy. So, basically worthless.
>> But, you should consider that most of these cores/interconnects aren't
>> aware of PCIe completion semantics so its the root ports
>> responsibility to say, gracefully translate a non-posted write that
>> doesn't have a completion for the interconnects its attached to,
>> rather than tripping something generic like a SLVERR.
>>
>> Anyway, for this I would poke around the pile of exception registers,
>> with your specific processors manual handy because a lot of them are
>> implementation defined.
> 
> I should be able to get you an answer in the new few days whether
> configuration space requests also generate an error towards the ARM CPU,
> since memory space requests most definitively do.

Did not get an answer from the design team, but going through our bug
tracker, there were evidences of configuration space accesses also
generating external aborts:

[    8.988237] Unhandled fault: synchronous external abort (0x96000210)
at 0xffffff8009539004
[    8.996539] Internal error: : 96000210 [#1] SMP
[    9.001107] Modules linked in:
[    9.004215] CPU: 2 PID: 6 Comm: kworker/u8:0 Not tainted
4.9.51-gstb-4.9 #1
[    9.011216] Hardware name: BCM97278SV (DT)
[    9.015365] Workqueue: events_unbound async_run_entry_fn
[    9.020728] task: ffffffc00a4ab5c0 task.stack: ffffffc00a4e4000
[    9.026698] PC is at pci_generic_config_read32+0x30/0xb0
[    9.032053] LR is at pci_generic_config_read32+0x2c/0xb0
[    9.037403] pc : [<ffffff8008394eb8>] lr : [<ffffff8008394eb4>]
pstate: 800000c5
[    9.044852] sp : ffffffc00a4e7ba0
[    9.048197] x29: ffffffc00a4e7ba0 x28: ffffffc00a40caa8
[    9.053574] x27: ffffffc00a40c878 x26: ffffffc00a40c820
[    9.058949] x25: ffffff800935c77d x24: 0000000000000040
[    9.064323] x23: ffffff80093d5ac0 x22: ffffffc00a4e7c66
[    9.069698] x21: ffffffc00a4e7c24 x20: 0000000000000002
[    9.075072] x19: 000000000000004c x18: ffffffffffffffff
[    9.080448] x17: fffeffffb7ffffff x16: fffffdffb6ffffff
[    9.085822] x15: 0000000000000000 x14: ffffffc009e8fdb8
[    9.091196] x13: 0000000000000014 x12: 0000000000000000
[    9.096571] x11: 0000000000000000 x10: 00000000000006d0
[    9.101946] x9 : ffffffc00a4e4000 x8 : ffffffc00a4abcf0
[    9.107322] x7 : 0000000000005ec7 x6 : 0000000000000005
[    9.112696] x5 : ffffff8009530000 x4 : ffffff80087da530
[    9.118073] x3 : ffffff8009539000 x2 : 000000000000004c
[    9.123448] x1 : 0000000000009004 x0 : ffffff8009539004
[    9.128823]
[    9.130341] Process kworker/u8:0 (pid: 6, stack limit =
0xffffffc00a4e4020)
[    9.137346] Stack: (0xffffffc00a4e7ba0 to 0xffffffc00a4e8000)
[    9.143136] 7ba0: ffffffc00a4e7bd0 ffffff8008394be4 ffffff8009306000
0000000000000087
[    9.151029] 7bc0: ffffffc009838000 ffffff800878a170 ffffffc00a4e7c30
ffffff800839b004
[    9.158923] 7be0: ffffffc00a5bb000 0000000000000000 ffffff8009306000
ffffff80088f7048
[    9.166814] 7c00: 0000000000000000 ffffffc00a40c800 ffffff80092d7440
000000000000004c
[    9.174706] 7c20: 0000000000000002 0000000000040933 ffffffc00a4e7c70
ffffff800839e570
[    9.182598] 7c40: ffffffc00a5bb000 ffffff80093d5000 0000000000000000
ffffff80088f7048
[    9.190490] 7c60: ffffffc00a5bb0a0 0000000000040933 ffffffc00a4e7c90
ffffff80083a1cc4
[    9.198383] 7c80: ffffffc00a5bb0a0 ffffffc00a5bb000 ffffffc00a4e7cc0
ffffff800845c9cc
[    9.206275] 7ca0: ffffffc00a5bb0a0 ffffff80083a1ca0 0000000000000010
ffffffc00a4ab5c0
[    9.214167] 7cc0: ffffffc00a4e7d00 ffffff800845cab4 ffffffc00a5bb0a0
0000000000000000
[    9.222060] 7ce0: 0000000000000010 0000000000000000 ffffffc00a455100
ffffff800845ca80
[    9.229953] 7d00: ffffffc00a4e7d30 ffffff800845cc84 ffffff80093d9828
ffffffc00a5bb0a0
[    9.237845] 7d20: ffffffc009decd00 0000000000000000 ffffffc00a4e7d50
ffffff80080ba464
[    9.245737] 7d40: ffffffc009decd20 ffffff80093a3000 ffffffc00a4e7d80
ffffff80080b0f28
[    9.253628] 7d60: 0000000000000000 ffffffc00a454e40 ffffffc009decd20
0000000000000000
[    9.261521] 7d80: ffffffc00a4e7dc0 ffffff80080b1130 ffffffc00a454e40
ffffffc00a40c800
[    9.269413] 7da0: ffffffc00a454e70 ffffffc00a40c820 ffffff8009306000
ffffffc00a4e4000
[    9.277305] 7dc0: ffffffc00a4e7e20 ffffff80080b7194 ffffffc00a494400
ffffffc00a4e4000
[    9.285198] 7de0: ffffff80088afc00 ffffffc00a454e40 ffffff80080b10e8
0000000000000000
[    9.293088] 7e00: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    9.300981] 7e20: 0000000000000000 ffffff8008082900 ffffff80080b70a0
ffffffc00a494400
[    9.308872] 7e40: 0000000000000000 0000000000000000 0000000000000000
705afddc1b1ccaa8
[    9.316764] 7e60: 0000000000000000 ffffff80080bff90 ffffffc00a454e40
ffffffc000000000
[    9.324656] 7e80: 0000000000000000 ffffffc00a4e7e88 ffffffc00a4e7e88
0000000000000000
[    9.332547] 7ea0: 0000000000000000 ffffffc00a4e7ea8 ffffffc00a4e7ea8
0000000000040933
[    9.340438] 7ec0: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    9.348329] 7ee0: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    9.356219] 7f00: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    9.364111] 7f20: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    9.372002] 7f40: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    9.379894] 7f60: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    9.387785] 7f80: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    9.395675] 7fa0: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[    9.403566] 7fc0: 0000000000000000 0000000000000005 0000000000000000
0000000000000000
[    9.411458] 7fe0: 0000000000000000 0000000000000000 46525cd6105c6384
aa9421d6b6fa9074
[    9.419343] Call trace:
[    9.421821] Exception stack(0xffffffc00a4e79b0 to 0xffffffc00a4e7ae0)
[    9.428301] 79a0:                                   000000000000004c
0000008000000000
[    9.436193] 79c0: ffffffc00a4e7ba0 ffffff8008394eb8 00000000800000c5
ffffffc07fe8e440
[    9.444086] 79e0: ffffffc00a4efd98 0000000000000007 ffffffc000000000
ffffff8009539004
[    9.451977] 7a00: 0000000000000000 ffffffc009bfbe40 ffffff80092d7440
ffffff80092d7440
[    9.459869] 7a20: 0000000000000002 ffffff80080c3ee8 ffffffc009bfbe40
ffffffc07fe64440
[    9.467761] 7a40: 0000000200000000 ffffffc07fe8e440 ffffffc00a4e7a90
ffffff80080c3ee8
[    9.475652] 7a60: 0000000000000001 0000000000040933 ffffff8009539004
0000000000009004
[    9.483544] 7a80: 000000000000004c ffffff8009539000 ffffff80087da530
ffffff8009530000
[    9.491435] 7aa0: 0000000000000005 0000000000005ec7 ffffffc00a4abcf0
ffffffc00a4e4000
[    9.499327] 7ac0: 00000000000006d0 0000000000000000 0000000000000000
0000000000000014
[    9.507223] [<ffffff8008394eb8>] pci_generic_config_read32+0x30/0xb0
[    9.513623] [<ffffff8008394be4>] pci_bus_read_config_word+0x9c/0xc0
[    9.519936] [<ffffff800839b004>] pci_raw_set_power_state+0x7c/0x248
[    9.526250] [<ffffff800839e570>] pci_power_up+0x50/0x68
[    9.531516] [<ffffff80083a1cc4>] pci_pm_resume_noirq+0x24/0xc0
[    9.537395] [<ffffff800845c9cc>] dpm_run_callback+0x4c/0xc0
[    9.543008] [<ffffff800845cab4>] device_resume_noirq+0x74/0x220
[    9.548969] [<ffffff800845cc84>] async_resume_noirq+0x24/0x58
[    9.554757] [<ffffff80080ba464>] async_run_entry_fn+0x3c/0x160
[    9.560635] [<ffffff80080b0f28>] process_one_work+0x1d0/0x390
[    9.566424] [<ffffff80080b1130>] worker_thread+0x48/0x4b0
[    9.571863] [<ffffff80080b7194>] kthread+0xf4/0x108
[    9.576782] [<ffffff8008082900>] ret_from_fork+0x10/0x50
[    9.582136] Code: f9406005 f94008a3 d63f0060 b4000320 (b9400001)
[    9.588311] ---[ end trace efc83c99ae7412ee ]---
-- 
Florian
