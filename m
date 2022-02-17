Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873944BA080
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 14:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiBQM75 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 07:59:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240504AbiBQM74 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 07:59:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE057284212;
        Thu, 17 Feb 2022 04:59:41 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso4511788wmi.0;
        Thu, 17 Feb 2022 04:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7rmjPsLtV4G+TjNG0elhETU6mLmTTjv5AD4/rOwwzBw=;
        b=HhZ14F/NSsEFbD4lTqQGvP5UI5oC9I+lWOHQ/pQRZRwsEDThCe5WbPDd41bX9LPtuQ
         UT1uaiBh977Q4gw+IRndMXW2t0ideUUMvlPYBfQaO8ns8xx5W2kBLKZbfWn02GfskzNY
         NqtfJuiI2/pvZXZGTmpfHjJLEj+cAe/vbYLUglXaYqExKgXegSuInv+MnCmU+Z0uTL+V
         bMTdnDRzxoB8DV9sH/jMquslypcNmF7sOGnJvftJaJXVcrxYTxMCKyLwWL12x+mTPaRo
         utMRmzDekWh4fX03CITeFCW7JdhSLR7XqF7pz6E7bvhGfe/djYgLOcRVqHNXMh+vZoSK
         rInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7rmjPsLtV4G+TjNG0elhETU6mLmTTjv5AD4/rOwwzBw=;
        b=S8NrjP6JDw2LKmvupRBoPV236zNAnrr5G+lgHqrLqIWKNBPBDTAAaqTZ+C91kuTtNf
         1u0n/Gsm85GOKDUavBT4EGpu8Q3od+o/pQROO+iXkSCIjk4ULsicd5lIDFPd15fbAHwu
         IvuG3klvx2VnCx7JnAgnaLLkuch0CR53do4CjNyXbf3auc76Dd0Sp/PygbSQOzql34Q+
         aEdv2zIpLKvPS2CwE/HUdFYVaXve19vbKh5w0XcWmcogb4QjZyoITESQE0h9eK3E4+sk
         +qDZVJHaGScPRACa/3LIqpNkYBlWBK0UuE1Zow/cef7DopJP7C6XhaSu9frPrq0DkVIf
         3KdQ==
X-Gm-Message-State: AOAM530uNnja72N3ddY6O18UqPzKesDrusP3ijHa/t0tPXbQbgo5LIK0
        d5+zXFo/8G8TkIkzhJa2nek=
X-Google-Smtp-Source: ABdhPJyolI2RKbkc1EGDzeuLcXsFP1hgjKcz40uSalA61du3Ao75UaOm4nzdqzH2rQLk9ebHYfs5Sg==
X-Received: by 2002:a05:600c:1583:b0:346:3f83:6b8 with SMTP id r3-20020a05600c158300b003463f8306b8mr2596253wmf.75.1645102780194;
        Thu, 17 Feb 2022 04:59:40 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id x10sm1511101wre.110.2022.02.17.04.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 04:59:39 -0800 (PST)
Message-ID: <ae4dcb09-98d0-64e8-79a8-1bff16505abc@gmail.com>
Date:   Thu, 17 Feb 2022 13:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which triggered
 an exception
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20220122221554.196311-1-marek.vasut@gmail.com>
 <20220122221554.196311-2-marek.vasut@gmail.com>
 <20220123153147.sv6eoayxqvqbaa66@pali>
 <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
 <20220123164936.cmzvkkkuw5chz3ek@pali>
 <9d89314c-8757-8965-0f5d-14fd95669320@gmail.com>
 <20220124093752.l2kpenot6wj76753@pali>
 <65a09af0-f09d-cf46-3d04-d7c9d2750227@gmail.com>
 <20220131125341.7jzckjihz3cwrxg3@pali> <20220217112949.xt6saomde47prbom@pali>
From:   Marek Vasut <marek.vasut@gmail.com>
In-Reply-To: <20220217112949.xt6saomde47prbom@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/17/22 12:29, Pali Rohár wrote:
> On Monday 31 January 2022 13:53:41 Pali Rohár wrote:
>> On Saturday 29 January 2022 05:39:40 Marek Vasut wrote:
>>> On 1/24/22 10:37, Pali Rohár wrote:
>>>> On Monday 24 January 2022 06:46:47 Marek Vasut wrote:
>>>>> On 1/23/22 17:49, Pali Rohár wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> [...]
>>>>>
>>>>>>>> I must admit that this patch from its initial version evolved into giant hack...
>>>>>>>> https://lore.kernel.org/linux-pci/20210514200549.431275-1-marek.vasut@gmail.com/
>>>>>>>>
>>>>>>>> During review of the previous patch I have asked some important
>>>>>>>> questions but I have not got any answer to them. So I'm reminding it:
>>>>>>>> https://lore.kernel.org/linux-pci/20210805183024.ftdwknkttfwwogks@pali/
>>>>>>>>
>>>>>>>> So could please answer what happens when PCIe controller is in some
>>>>>>>> non-L* state and either MMIO happen or config read happens or config
>>>>>>>> write happens?
>>>>>>>
>>>>>>> What kind of non-L state ?
>>>>>>
>>>>>> E.g. Hot Reset, Detect, Polling, Configuration or Recovery.
>>>>>>
>>>>>>> Do you have some specific test which fails ?
>>>>>>
>>>>>> Yes, by putting PCIe controller into one of those states. I have already
>>>>>> wrote you in some previous email to trigger hot reset as this is the
>>>>>> easiest test and can be done also by userspace (setpci).
>>>>>>
>>>>>> Link goes to Recovery state automatically when doing link retraining
>>>>>> (e.g. by setting RT bit in PCIe Root Port config space) and from
>>>>>> Recovery to Configuration or directly back to L0. So testing this path
>>>>>> needs precise timing and repeating it more times to trigger.
>>>>>>
>>>>>> So the easiest test is really via PCIe Hot Reset by setting Secondary
>>>>>> Bus Reset bit in Bridge Control register of PCIe Root Port. After this
>>>>>> is link in Hot Reset and does not go back to L0 until you clear that
>>>>>> bit. So in this state you can do all these operations which cause
>>>>>> aborts, like calling that kernel function which is reading from config
>>>>>> space which belongs to device on the other end of the PCIe link or doing
>>>>>> MMIO read / write operation of mapped memory which again belongs to
>>>>>> other end of PCIe link.
>>>>>>
>>>>>> Or instead of Hot Reset, you can set link disable bit in config space of
>>>>>> PCIe Root Port. Then link also would not be in L0 state (until you clear
>>>>>> that bit), so again you have lot of time to do same tests.
>>>>>
>>>>> Can you give me the exact setpci invocation ? If so, then I can test this
>>>>> for you on the hardware.
>>>>
>>>> Call "setpci -s $bdf_root_port BRIDGE_CONTROL" with address of the PCIe
>>>> Root Port device (parent of selected device). This will print value of
>>>> bridge control register. Logical OR it with value 0x20 (Secondary Bus
>>>> Reset Bit) and call "setpci -s $bdf_root_port BRIDGE_CONTROL=$new_value".
>>>> After this call is link in the Hot Reset state and you can do any test.
>>>> To bring link back, call setpci again with cleared 0x20 bit mask.
>>>>
>>>> Similar test you can done also with setting Link Disable bit (bit 4) in
>>>> PCIe Link Control register. Offset to this register is not static and
>>>> you can figure it out from lspci -s $bdf_root_port -vv output.
>>>> Retrain Link is bit 5 in the same register.
>>>
>>> Flipping either bit makes no difference, suspend/resume behaves the same and
>>> the link always recovers.
>>
>> Ok, perfect! And what happens without suspend/resume (just in normal
>> conditions)? E.g. during active usage of some PCIe card (wifi, sata, etc..).
> 
> PING? Also what lspci see for the root port and card itself during hot reset?

If I recall, lspci showed the root port and card.
