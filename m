Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06A94F65DE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiDFQrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiDFQrM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 12:47:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB53E8FCC
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 07:08:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n6so4447049ejc.13
        for <linux-pci@vger.kernel.org>; Wed, 06 Apr 2022 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=0vB0HGTZga7f1q5BSSNIpY7EWpeHhv69aCzFJKru474=;
        b=YR4saWBL03E5JaVc5I7gV8BN7YddSjnralclSOIA6N4CT86w8Y+PrzP2yiWNIYoyZM
         oOmgZhEt7oeM0Al7wehEE9ouNObjhMHFCyMBxsibfCG1e3Tov9AU2WFrgVEMLUMw/hoP
         n9RCd8vAADzKkDqum4k8a/tPXDIyJp7voCAViQpsRROlOWrlnPgVca5aanhGOI1btz2h
         7qskbxHhy6FSG5HhYgePw18LUjQR/m4Ut6ak5P8Osjb5mq0Y88CmThNYnL4QHTJXnKeu
         0uFO8OQDuflKtWMKqFfCe1Xxgo3jXicCZZuRnIZ1XN6Uw9hLHBGE5lBIfvRHqdXjg6Ij
         I8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=0vB0HGTZga7f1q5BSSNIpY7EWpeHhv69aCzFJKru474=;
        b=yfF1r3WM8PE5FLFNvf69hRSd18pO0tBXVG2Ybw8x/r8gOi78s+Kl17rIkNzAy4XIlL
         AScVXqQgfOL9V1es7UlFVp+Va2U0A9cstFBx+GULIIVPiwQe7ykMQwdgOEOI2bpMif80
         ++R/BQi+WsDfo39s60w6xYKCbAKQtsfj39I8O5AMVBX8MBFliUJwEx8e8Ptg7ItKktw2
         2zA6UOaHDefIWDAfOi4LmNleRgNC/jNdxleiw8zSXrL7HZIEcNiNpKulUoI5XtU+Zl2C
         b4rCwXqAPrRSZai9sdOlDODj2yxLnESkUc6VNS9tH4/E4ZDe0xwyrawHfQCKqRSWMCCv
         fC9Q==
X-Gm-Message-State: AOAM5312k/GaNGvNUSAbTD2ykYZGrANcEPL1esZIo5rzDF+uM1Ebwwio
        zGiPhkrYuHnPydtoNbAKfi0hkg==
X-Google-Smtp-Source: ABdhPJw9oE6Losxsk+Z0emo1fbJJlduNDMQ8sX3pFzKkyVHy5fezPiUDK0Jq4fmiAF1JkWQdHNjQzg==
X-Received: by 2002:a17:907:7815:b0:6ce:5242:1280 with SMTP id la21-20020a170907781500b006ce52421280mr8545575ejc.217.1649254111344;
        Wed, 06 Apr 2022 07:08:31 -0700 (PDT)
Received: from [10.202.0.7] ([31.31.140.89])
        by smtp.gmail.com with ESMTPSA id e26-20020a50ec9a000000b004193fe50151sm8228591edr.9.2022.04.06.07.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 07:08:30 -0700 (PDT)
Message-ID: <7873617a-b2ab-1f26-55ac-d98229aa4485@citymesh.com>
Date:   Wed, 6 Apr 2022 16:08:29 +0200
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
In-Reply-To: <46ae7788-dade-3ff4-a353-985544f12c19@citymesh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 01.04.22 15:50, Koen Vandeputte wrote:
>
> On 15.02.22 07:35, Krzysztof Hałasa wrote:
>> Hi Bjorn,
>>
>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>
>>> Koen collected some interesting logs at
>>> https://lore.kernel.org/all/cd4812f0-1de3-0582-936c-ba30906595af@citymesh.com/ 
>>>
>>> They're from v5.10, which was before all of Krzysztof W's nice work
>>> converting to static attributes, but Koen's log shows the error
>>> happening in the pci_sysfs_init() initcall, which is *after*
>>> imx6_pcie_probe():
>>>
>>>    imx6_pcie_probe                # probably device initcall (level 6)
>>>      ...
>>>        pci_create_sysfs_dev_files
>>>
>>>    pci_sysfs_init                 # late initcall (level 7)
>>>      pci_create_sysfs_dev_files
>>>        "sysfs: cannot create duplicate filename"
>> Well, imx6_pcie_probe() is called indirectly by
>> platform_driver_register(). I guess it doesn't know about the initcall
>> ordering, after it's registered.
>>
>> It looks like the problem is the imx6_pcie_probe() (via
>> dw_pcie_host_init() -> pci_host_probe()) is interfering with
>> pci_sysfs_init(). This may eventually cause some invalid memory access
>> as well.
>>
>> BTW I thought for a moment that maybe 5.14 is free from this. I was
>> wrong. The problem doesn't manifest itself on my custom i.MX6 device
>> (using Tinyrex CPU module from Voipac/Fedevel, perhaps because I don't
>> use any PCI devices there). It does on Ventana SBC from Gateworks,
>> though. BTW the above (and below) is v5.16.
>>
>> It goes like this:
>> [0.096212] do_initcall_level: 6
>> [0.105625] imx6_pcie_init
>> [0.106106] imx6_pcie_probe <<<<<<<<<<<<<<<<<<<<<
>> [0.106412] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 
>> ranges:
>>
>> [0.322613] imx6q-pcie 1ffc000.pcie: Link up
>> [0.322776] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
>> [0.322790] pci_bus 0000:00: root bus resource [bus 00-ff]
>>
>> [0.405251] do_initcall_level: 6 ENDs but imx6_pcie_probe() still active
>> [0.405262] do_initcall_level: 7
>>
>> [0.410393] pci_sysfs_init <<<<<<<<<<<<<<<<<<<<<
>> [0.410423] pci 0000:00:00.0: pci_create_sysfs_dev_files
>>
>> [0.410532] [<8068091c>] (pci_create_sysfs_dev_files)
>> [0.410551] [<80918710>] (pci_sysfs_init)
>> [0.410568] [<8010166c>] (do_one_initcall)
>>
>> [0.410717] pci_sysfs_init END <<<<<<<<<<<<<<<<<<<<<
>>
>> [0.533843] [<803f1c74>] (pci_bus_add_devices)
>> [0.533862] [<803f574c>] (pci_host_probe)
>> [0.533879] [<80414310>] (dw_pcie_host_init)
>> [0.533895] [<80681ac8>] (imx6_pcie_probe)
>> [0.533915] [<8045e9e4>] (platform_probe)
>> (Repeats multiple times, I guess for each PCI device)
>>
>> [0.543893] imx6_pcie_probe END <<<<<<<<<<<<<<<<<<<<<
>>
>> [0.692244] do_initcall_level: 7 END
>
>
> Hi all,
>
> Any update on this topic?
> I just tested kernel 5.15 on imx6 (gateworks Ventana 5200) and as soon 
> as I connect a pcie device on one of the ports,
>
> following happens:
>
> https://pastebin.com/raw/mgfSvTRB
>
> Any idea if this is related?
>
>
> Thanks,
>
> Koen
>
Hi all,

I tested a bit more today and simply let the board reboot all day long.
After roughly 20 reboots, it suddenly booted once stable without any 
errors/warnings.

Looks like a race condition ..

Any idea?

Thanks,

Koen

