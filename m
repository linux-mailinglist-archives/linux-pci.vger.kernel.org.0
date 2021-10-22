Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0819F437BE1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhJVRcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 13:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhJVRcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 13:32:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43319C061764;
        Fri, 22 Oct 2021 10:29:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso6280587pjm.4;
        Fri, 22 Oct 2021 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9g3SS96B24RbA0UM0N0/J0717Xuebx832cXs0RhSY7g=;
        b=l/2NN9IRgQDaV1hDk4pHNDsUHOTFbp3o+nZCTFf6GnamLb9K/Sn36TQf8TlNmX1cFh
         12Ubuvp4UHnBWV0HihqyjYnBjSou7UBSFem2RURf42hm7Ynk8nAXsXAK9nqxbUqacCRZ
         HV4IogaW0XmEdAFQv4dzTzJj7g6WVlCq2hWR5l+k/fy+qQwmNWHI7NIaq54m0nlkpAuD
         eUKbom5zYkxPnBIutfY4OwsAbxdfVuWv+M8+3AuoH6ukrrEqeMXBiMlfymTq2jKrsMLT
         aPEjAfdFpsgWwxM1JlB/7DDbuSOefAi4xCGX1l351+gyapj6V+T2f3YiA25bikwKEodS
         BEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9g3SS96B24RbA0UM0N0/J0717Xuebx832cXs0RhSY7g=;
        b=su2XhJO1n4Nz0uNglJ62+MsqkrdvXcxCR/0Tm9Urqfzaz3T5Hx8pCSc1khGGy+Zo9M
         ZlmEBdd/fCCAY9lySEQ2L1HSguhdjC4ZSmwIqfxa+NIuSmOQuSsd2pT9wJ+ypvkcWy5S
         E0gURbVrlPqopnGHfJlMdk/4ptOGTKhBoqVZ4Y9O3ccdCB8itNcf5HFtObaqJXBI4w3v
         bsZMU3UQRuscXA3pWimoaHZJppvo+986vzasOb4ZfJHEH9rEjj714z28aJ0dDp04bOFW
         CQFLNW5wmeIqOAQBDZW3KrgPL0kUxirNk5cOcLkcaVaAf8FKy/Q7WvPpDcEJZq+yVccc
         4taQ==
X-Gm-Message-State: AOAM531zB1mm/b6DNfwI6R/O4KgulE6YJt//aFBnGyPti+YnuD/HrRO8
        NYNj2He5heANo5HYPncFHsYyLVtPC54=
X-Google-Smtp-Source: ABdhPJxezLurfmK5izcjd7eKKLaTo3YUGvjArBGaamxSn1mIbVxxT9SKHmOZQoQpE1e3adlA2481hw==
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr16062293pjb.139.1634923791080;
        Fri, 22 Oct 2021 10:29:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gk1sm11992725pjb.2.2021.10.22.10.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 10:29:50 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
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
 <f648bc89-f08b-e806-45f9-5a1b61686e19@gmail.com>
 <20211022171728.vlxb3sfebfpgijmp@pali>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3a956549-3304-5a4c-3058-eccfac44d31b@gmail.com>
Date:   Fri, 22 Oct 2021 10:29:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211022171728.vlxb3sfebfpgijmp@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/22/21 10:17 AM, Pali Rohár wrote:
> On Friday 22 October 2021 10:04:36 Florian Fainelli wrote:
>> On 10/5/21 7:07 PM, Florian Fainelli wrote:
>>>
>>>
>>> On 10/5/2021 3:25 PM, Jeremy Linton wrote:
>>>> Hi,
>>>>
>>>> On 10/5/21 2:43 PM, Pali Rohár wrote:
>>>>> Hello!
>>>>>
>>>>> On Tuesday 05 October 2021 10:57:18 Jeremy Linton wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 10/5/21 10:32 AM, Bjorn Helgaas wrote:
>>>>>>> On Thu, Aug 26, 2021 at 02:15:55AM -0500, Jeremy Linton wrote:
>>>>>>>> Additionally, some basic bus/device filtering exist to avoid sending
>>>>>>>> config transactions to invalid devices on the RP's primary or
>>>>>>>> secondary bus. A basic link check is also made to assure that
>>>>>>>> something is operational on the secondary side before probing the
>>>>>>>> remainder of the config space. If either of these constraints are
>>>>>>>> violated and a config operation is lost in the ether because an EP
>>>>>>>> doesn't respond an unrecoverable SERROR is raised.
>>>>>>>
>>>>>>> It's not "lost"; I assume the root port raises an error because it
>>>>>>> can't send a transaction over a link that is down.
>>>>>>
>>>>>> The problem is AFAIK because the root port doesn't do that.
>>>>>
>>>>> Interesting! Does it mean that PCIe Root Complex / Host Bridge (which I
>>>>> guess contains also logic for Root Port) does not signal transaction
>>>>> failure for config requests? Or it is just your opinion? Because I'm
>>>>> dealing with similar issues and I'm trying to find a way how to detect
>>>>> if some PCIe IP signal transaction error via AXI SLVERR response OR it
>>>>> just does not send any response back. So if you know some way how to
>>>>> check which one it is, I would like to know it too.
>>>>
>>>> This is my _opinion_ based on what I've heard of some other IP
>>>> integration issues, and what i've seen poking at this one from the
>>>> perspective of a SW guy rather than a HW guy. So, basically worthless.
>>>> But, you should consider that most of these cores/interconnects aren't
>>>> aware of PCIe completion semantics so its the root ports
>>>> responsibility to say, gracefully translate a non-posted write that
>>>> doesn't have a completion for the interconnects its attached to,
>>>> rather than tripping something generic like a SLVERR.
>>>>
>>>> Anyway, for this I would poke around the pile of exception registers,
>>>> with your specific processors manual handy because a lot of them are
>>>> implementation defined.
>>>
>>> I should be able to get you an answer in the new few days whether
>>> configuration space requests also generate an error towards the ARM CPU,
>>> since memory space requests most definitively do.
>>
>> Did not get an answer from the design team, but going through our bug
>> tracker, there were evidences of configuration space accesses also
>> generating external aborts:
>>
>> [    8.988237] Unhandled fault: synchronous external abort (0x96000210) at 0xffffff8009539004
>> [    9.026698] PC is at pci_generic_config_read32+0x30/0xb0
> 
> So this is error caused by reading from config space.
> 
> Can you check if also writing to config space can trigger some crash? If
> yes, I would like to know if write would be also synchronous or rather
> asynchronous abort.

Yes it does and AFAICT it always shows up as a system error interrupt,
here is an example:

# setpci -d *:* latency_timer=40
[   25.909644] SError Interrupt on CPU2, code 0xbf000002 -- SError
[   25.909647] CPU: 2 PID: 1676 Comm: setpci Not tainted
5.10.70-0.2pre-ge3872e15011b #2
[   25.909649] Hardware name: BCM972165SV_V10 (DT)
[   25.909651] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[   25.909652] pc : pci_user_write_config_byte+0x6c/0x78
[   25.909654] lr : pci_user_write_config_byte+0x68/0x78
[   25.909655] sp : ffffffc015853c20
[   25.909656] x29: ffffffc015853c20 x28: ffffff8003053000
[   25.909661] x27: 0000000000000000 x26: 0000000000000000
[   25.909664] x25: 0000000000000001 x24: ffffff8004a23780
[   25.909668] x23: ffffff80049aa000 x22: ffffffc015853d68
[   25.909671] x21: 0000000000000040 x20: 000000000000000d
[   25.909674] x19: 000000000000000e x18: 0000000000000000
[   25.909677] x17: 0000000000000000 x16: 0000000000000000
[   25.909680] x15: 0000000000000000 x14: 0000000000000000
[   25.909684] x13: 0000000000000000 x12: 0000000000000000
[   25.909687] x11: 0000000000000000 x10: 0000000000000000
[   25.909690] x9 : ffffffc010483214 x8 : 0000000000000000
[   25.909693] x7 : ffffff800498df00 x6 : ffffff80049a8380
[   25.909696] x5 : ffffffc015510000 x4 : ffffff80049a9800
[   25.909699] x3 : 0000000000000000 x2 : 000000000000000d
[   25.909702] x1 : 0000000000000000 x0 : 0000000000000000
[   25.909706] Kernel panic - not syncing: Asynchronous SError Interrupt
[   25.909708] CPU: 2 PID: 1676 Comm: setpci Not tainted
5.10.70-0.2pre-ge3872e15011b #2
[   25.909710] Hardware name: BCM972165SV_V10 (DT)
[   25.909711] Call trace:
[   25.909712]  dump_backtrace+0x0/0x1d0
[   25.909713]  show_stack+0x1c/0x24
[   25.909714]  dump_stack+0xd0/0x12c
[   25.909716]  panic+0x128/0x308
[   25.909717]  nmi_panic+0x50/0x70
[   25.909718]  arm64_serror_panic+0x74/0x80
[   25.909720]  do_serror+0x28/0x60
[   25.909721]  el1_error+0x8c/0x10c
[   25.909722]  pci_user_write_config_byte+0x6c/0x78
[   25.909724]  pci_write_config+0x7c/0x1a0
[   25.909725]  sysfs_kf_bin_write+0x64/0x84
[   25.909727]  kernfs_fop_write_iter+0xbc/0x170
[   25.909728]  new_sync_write+0x80/0xcc
[   25.909729]  vfs_write+0xec/0x110
[   25.909730]  ksys_pwrite64+0x50/0x8c
[   25.909732]  __arm64_sys_pwrite64+0x20/0x28
[   25.909733]  el0_svc_common.constprop.4+0x100/0x184
[   25.909735]  do_el0_svc+0x38/0x78
[   25.909736]  el0_svc+0x1c/0x28
[   25.909737]  el0_sync_handler+0x64/0x12c
[   25.909738]  el0_sync+0x148/0x180
[   25.909775] brcm-pcie 8b20000.pcie: Error: CFG Acc, 32bit, Write,
Bus=1, Dev=0, Fun=0, Reg=0xc, lanes=01000000
[   26.136082] brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnsupReq=0
AccTO=0 AccDsbld=1 Acc64bit=0
[   26.144709] SMP: stopping secondary CPUs
[   26.144711] Kernel Offset: disabled
[   26.144712] CPU features: 0x0040002,24002004
[   26.144713] Memory Limit: none

-- 
Florian
