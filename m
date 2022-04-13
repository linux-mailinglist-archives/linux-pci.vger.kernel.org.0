Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEAD4FF724
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiDMMzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 08:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiDMMzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 08:55:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0567554AF
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 05:53:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bv19so3740616ejb.6
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=rFOS/YEtLTZTs3XK8yDit+vtofEO5aVtPZCCQ6IQw8I=;
        b=G6mvPzPI+QdIOqo+VYv/p+nCyqq+tAdC/wMXqCeZncqy2ddvPeNP+6T37RdsQcK1A0
         07yGip5Nu23NDeYdAL/sgPpoq2ZZOpZGm8vEYX1X22+4WPP8w8rMs5sHFDmguV7Ttu+j
         Rg8swcismTypgyA2IqKcvu8yc8KEHLMM9gOjIF4OcFa7hfETv9eq9r8YB32/cKI4g6A3
         /06tyyB9+m8wcSslUriQwO03ELxravLqBMrTpnvtIw9cvpGVObSFbiTYcJW2/D/ZKs36
         re1fpPaY/CTYfcJN9mOmyOcoStPt/SA24PKVyRmQHAyWH+QpYQNk6dikipmoqPmT0ppX
         AMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=rFOS/YEtLTZTs3XK8yDit+vtofEO5aVtPZCCQ6IQw8I=;
        b=6LyJXI8ViAYL/2sm9cSu/DVXh/a7BGG8dpCeHpIVuWuHUx55Hdc8wth82lMQfXJpQn
         aRn4UYhvjG7IyC3xJbB6dGYrPWl2qqsstya6lMUugE490erbgWpkVGlm9/BIyrz6yojh
         7GfGZ2Lbwi9dfk14BTtLoeTots01cOCh98D4c3FqbQAJWSFUlUlnu9BtYVbzIKA8BlGB
         prxNfT5VuJq5aNR/BhbFqH+X63OECq7Kd7Aozg/TrzQetSxZWcmQK8dXwIrq647Kwneu
         Yq0SqKly4JdWQXLqW5op3/UahLrYwnyfIxog9zLbQTOZxHz4GTQ+P0jr03Kg9NtSrD7g
         SM8g==
X-Gm-Message-State: AOAM533iYbnOEmTdt0WlvRFB1SVTgyJdUyiBV/sBysWva387O+QSc/5g
        dejmb0iZzLloD5t2EqESAjz2/g==
X-Google-Smtp-Source: ABdhPJza/BKaw96pPtHS6TkEzygBE95yc9sVcnWMfkYr0fvTC1gw4NlPK214LqNeY0A3srRlwLUMKQ==
X-Received: by 2002:a17:907:8a15:b0:6e8:d28e:83d7 with SMTP id sc21-20020a1709078a1500b006e8d28e83d7mr1295827ejc.640.1649854379336;
        Wed, 13 Apr 2022 05:52:59 -0700 (PDT)
Received: from [10.202.0.7] ([31.31.140.89])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm14146420ejo.190.2022.04.13.05.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 05:52:58 -0700 (PDT)
Message-ID: <1945c8da-99f8-8d87-343d-ff66c02df6de@citymesh.com>
Date:   Wed, 13 Apr 2022 14:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
Content-Language: en-US
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
To:     =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Dexuan Cui <dexuan.linux@gmail.com>,
        =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
        Piotr Dymacz <pepe2k@gmail.com>
References: <20220208234023.GA505306@bhelgaas> <m3czjovdqn.fsf@t19.piap.pl>
 <46ae7788-dade-3ff4-a353-985544f12c19@citymesh.com>
 <7873617a-b2ab-1f26-55ac-d98229aa4485@citymesh.com>
In-Reply-To: <7873617a-b2ab-1f26-55ac-d98229aa4485@citymesh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 06.04.22 16:08, Koen Vandeputte wrote:
>
> On 01.04.22 15:50, Koen Vandeputte wrote:
>>
>> On 15.02.22 07:35, Krzysztof Hałasa wrote:
>>> Hi Bjorn,
>>>
>>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>>
>>>> Koen collected some interesting logs at
>>>> https://lore.kernel.org/all/cd4812f0-1de3-0582-936c-ba30906595af@citymesh.com/ 
>>>>
>>>> They're from v5.10, which was before all of Krzysztof W's nice work
>>>> converting to static attributes, but Koen's log shows the error
>>>> happening in the pci_sysfs_init() initcall, which is *after*
>>>> imx6_pcie_probe():
>>>>
>>>>    imx6_pcie_probe                # probably device initcall (level 6)
>>>>      ...
>>>>        pci_create_sysfs_dev_files
>>>>
>>>>    pci_sysfs_init                 # late initcall (level 7)
>>>>      pci_create_sysfs_dev_files
>>>>        "sysfs: cannot create duplicate filename"
>>> Well, imx6_pcie_probe() is called indirectly by
>>> platform_driver_register(). I guess it doesn't know about the initcall
>>> ordering, after it's registered.
>>>
>>> It looks like the problem is the imx6_pcie_probe() (via
>>> dw_pcie_host_init() -> pci_host_probe()) is interfering with
>>> pci_sysfs_init(). This may eventually cause some invalid memory access
>>> as well.
>>>
>>> BTW I thought for a moment that maybe 5.14 is free from this. I was
>>> wrong. The problem doesn't manifest itself on my custom i.MX6 device
>>> (using Tinyrex CPU module from Voipac/Fedevel, perhaps because I don't
>>> use any PCI devices there). It does on Ventana SBC from Gateworks,
>>> though. BTW the above (and below) is v5.16.
>>>
>>> It goes like this:
>>> [0.096212] do_initcall_level: 6
>>> [0.105625] imx6_pcie_init
>>> [0.106106] imx6_pcie_probe <<<<<<<<<<<<<<<<<<<<<
>>> [0.106412] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 
>>> ranges:
>>>
>>> [0.322613] imx6q-pcie 1ffc000.pcie: Link up
>>> [0.322776] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
>>> [0.322790] pci_bus 0000:00: root bus resource [bus 00-ff]
>>>
>>> [0.405251] do_initcall_level: 6 ENDs but imx6_pcie_probe() still active
>>> [0.405262] do_initcall_level: 7
>>>
>>> [0.410393] pci_sysfs_init <<<<<<<<<<<<<<<<<<<<<
>>> [0.410423] pci 0000:00:00.0: pci_create_sysfs_dev_files
>>>
>>> [0.410532] [<8068091c>] (pci_create_sysfs_dev_files)
>>> [0.410551] [<80918710>] (pci_sysfs_init)
>>> [0.410568] [<8010166c>] (do_one_initcall)
>>>
>>> [0.410717] pci_sysfs_init END <<<<<<<<<<<<<<<<<<<<<
>>>
>>> [0.533843] [<803f1c74>] (pci_bus_add_devices)
>>> [0.533862] [<803f574c>] (pci_host_probe)
>>> [0.533879] [<80414310>] (dw_pcie_host_init)
>>> [0.533895] [<80681ac8>] (imx6_pcie_probe)
>>> [0.533915] [<8045e9e4>] (platform_probe)
>>> (Repeats multiple times, I guess for each PCI device)
>>>
>>> [0.543893] imx6_pcie_probe END <<<<<<<<<<<<<<<<<<<<<
>>>
>>> [0.692244] do_initcall_level: 7 END
>>
>>
>> Hi all,
>>
>> Any update on this topic?
>> I just tested kernel 5.15 on imx6 (gateworks Ventana 5200) and as 
>> soon as I connect a pcie device on one of the ports,
>>
>> following happens:
>>
>> https://pastebin.com/raw/mgfSvTRB
>>
>> Any idea if this is related?
>>
>>
>> Thanks,
>>
>> Koen
>>
> Hi all,
>
> I tested a bit more today and simply let the board reboot all day long.
> After roughly 20 reboots, it suddenly booted once stable without any 
> errors/warnings.
>
> Looks like a race condition ..
>
> Any idea?
>
> Thanks,
>
> Koen
>
As an additional addendum:

This issue is seen on a Gateworks Ventana gw5200 which has a PLX bridge.
I also have a GW5100 which is identical but without the PLX bridge, and 
it works fine every time.

So when a PCI device is sitting behind a bridge, the issue is triggered.


Hope this helps to easily reproduce.

Koen

