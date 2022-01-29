Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35664A2BA5
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jan 2022 05:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352378AbiA2Ejp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 23:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352374AbiA2Ejn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 23:39:43 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC43C061714;
        Fri, 28 Jan 2022 20:39:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w14so14133198edd.10;
        Fri, 28 Jan 2022 20:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3OecJ37pcQL5aRYNC2dOVzKqi2LbasJ1/aIqniIUW1Q=;
        b=Zg7xmqdd4NUnwzPU0ybvDcqzL5jvIKDvF0qXny9ZTF1kVK7icQeI9V0qKF8hrtOGN6
         VSiltb8sSCiPWN7ZSXQS5rK8JIrVITTwBvG0YRgJGVC56V818zWtIkXLRwUnUQeOMTn3
         eboodizvTlQK/wmbnDo2K0n39/HNVjf5j4tiJcGcfWW9bhGDm4BQtdV8ODDFtp/JNY75
         0AHJCTugw+/eV/KLGmHZgXoooojaWAHjwLkYzoMhnI7IwmMzEFRNXJFLGKqyKgxGupCQ
         Wm9CXDeWdTz9xPQcrRW0kfVgbIWoA4utfMPvX9i7U7KLueMYfAH98MOuuu8X0uhkpEEi
         e0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3OecJ37pcQL5aRYNC2dOVzKqi2LbasJ1/aIqniIUW1Q=;
        b=gC0ej1IV1vBKkEmYUoLEqxpdHs4TNG8Amqf3IV7wDv5jslVytGLhfmRm2PVF0wN8af
         bPlO4Py1I5CAWkJ2R8cX8ebq+r221d6cmneyAtn15F2qZMCCh7qELFs3Ebq2rxQIhjWv
         zsfn+0deMlGzVseGRyVYcVC+vB67ECScNA+A2OqlDm+IyVNy0kF/KpgIITO51Omtxtfi
         eFoeavtqpmj1aqyiqV2j/W125eC5H0kgEIGJj28OMNr2t6XByOTai8gMw6C17f1MEBdU
         //b6039QOKKQkUu2PcEHYtoOeTznRsk1mf3IBHkWZSxSZM0nfPvQiSwmTBfSXz6VYobZ
         YF7g==
X-Gm-Message-State: AOAM531H2InbkTEpvvaIUzsSt3zs0nBIJcZfa9cFalSD8ym4RXMn/QwX
        j1CCg6FfVKbc/HKwL1wsXQM=
X-Google-Smtp-Source: ABdhPJzWy3t1VBdtr9PZ/Ee9Wx7sOn6pz/+1xGR20Euji56ItwbyKicJ/Qlt30s+nb+enLhfyZx+lw==
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr7381950edx.399.1643431181925;
        Fri, 28 Jan 2022 20:39:41 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id g6sm8529383ejz.170.2022.01.28.20.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 20:39:41 -0800 (PST)
Message-ID: <65a09af0-f09d-cf46-3d04-d7c9d2750227@gmail.com>
Date:   Sat, 29 Jan 2022 05:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
From:   Marek Vasut <marek.vasut@gmail.com>
In-Reply-To: <20220124093752.l2kpenot6wj76753@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/24/22 10:37, Pali Rohár wrote:
> On Monday 24 January 2022 06:46:47 Marek Vasut wrote:
>> On 1/23/22 17:49, Pali Rohár wrote:
>>
>> Hi,
>>
>> [...]
>>
>>>>> I must admit that this patch from its initial version evolved into giant hack...
>>>>> https://lore.kernel.org/linux-pci/20210514200549.431275-1-marek.vasut@gmail.com/
>>>>>
>>>>> During review of the previous patch I have asked some important
>>>>> questions but I have not got any answer to them. So I'm reminding it:
>>>>> https://lore.kernel.org/linux-pci/20210805183024.ftdwknkttfwwogks@pali/
>>>>>
>>>>> So could please answer what happens when PCIe controller is in some
>>>>> non-L* state and either MMIO happen or config read happens or config
>>>>> write happens?
>>>>
>>>> What kind of non-L state ?
>>>
>>> E.g. Hot Reset, Detect, Polling, Configuration or Recovery.
>>>
>>>> Do you have some specific test which fails ?
>>>
>>> Yes, by putting PCIe controller into one of those states. I have already
>>> wrote you in some previous email to trigger hot reset as this is the
>>> easiest test and can be done also by userspace (setpci).
>>>
>>> Link goes to Recovery state automatically when doing link retraining
>>> (e.g. by setting RT bit in PCIe Root Port config space) and from
>>> Recovery to Configuration or directly back to L0. So testing this path
>>> needs precise timing and repeating it more times to trigger.
>>>
>>> So the easiest test is really via PCIe Hot Reset by setting Secondary
>>> Bus Reset bit in Bridge Control register of PCIe Root Port. After this
>>> is link in Hot Reset and does not go back to L0 until you clear that
>>> bit. So in this state you can do all these operations which cause
>>> aborts, like calling that kernel function which is reading from config
>>> space which belongs to device on the other end of the PCIe link or doing
>>> MMIO read / write operation of mapped memory which again belongs to
>>> other end of PCIe link.
>>>
>>> Or instead of Hot Reset, you can set link disable bit in config space of
>>> PCIe Root Port. Then link also would not be in L0 state (until you clear
>>> that bit), so again you have lot of time to do same tests.
>>
>> Can you give me the exact setpci invocation ? If so, then I can test this
>> for you on the hardware.
> 
> Call "setpci -s $bdf_root_port BRIDGE_CONTROL" with address of the PCIe
> Root Port device (parent of selected device). This will print value of
> bridge control register. Logical OR it with value 0x20 (Secondary Bus
> Reset Bit) and call "setpci -s $bdf_root_port BRIDGE_CONTROL=$new_value".
> After this call is link in the Hot Reset state and you can do any test.
> To bring link back, call setpci again with cleared 0x20 bit mask.
> 
> Similar test you can done also with setting Link Disable bit (bit 4) in
> PCIe Link Control register. Offset to this register is not static and
> you can figure it out from lspci -s $bdf_root_port -vv output.
> Retrain Link is bit 5 in the same register.

Flipping either bit makes no difference, suspend/resume behaves the same 
and the link always recovers.
