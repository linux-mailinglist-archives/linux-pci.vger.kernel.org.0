Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5B4EEE7A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 15:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiDANww (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiDANwu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 09:52:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710ED1C6483
        for <linux-pci@vger.kernel.org>; Fri,  1 Apr 2022 06:51:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g22so3066310edz.2
        for <linux-pci@vger.kernel.org>; Fri, 01 Apr 2022 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6aSqh8t2BYpvepsKwdaEj1ou1yqlDXevbgf6RBEOluU=;
        b=x3RG4p4AlxUrIj7eUzOZ6cZozpv8RTywvdn4EP59i7LoI96cwfCaT5l0+fbQnFblma
         +wNNDGBYFwGlcpEYNNoJryJBmUtVCemDP5ARcPJPiY60skPIooA06/jTvtoI3PjSknfS
         0sOyVa/raQ1hOk2rQwXkHh99El3lQ9AvIMBFQnSFk7Y/7mS+zbjthNgt1xFQR0PnIWlC
         sG2pq75816M4FXl+p+75fr310eoi8BMpYO49AzzAmXoDawC16grvK7cbcfPXtllQPugI
         JoeIwxL+wlQjO7kDuDv87TaZWJgjUEJ6pcq3n4LM1xcCNO86p8pxkSuqOXyHZvY1SJ2J
         WZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6aSqh8t2BYpvepsKwdaEj1ou1yqlDXevbgf6RBEOluU=;
        b=1PQTd2kbhPVmCWPsr8YvAaZhWSZ73I0YbfBmMFfuZB3HRgm/+b6eo8NuQIRcNkGMdR
         0EHqEHdcIkhgV6QqeF3sbivq4gWD4go6TlCF4RTOwKQ+zxGlW8ci528Z0OlJhNR/r9T1
         2WnQ0RR3uVVOEo/PzgkgjTIdQY4VhqRls4tXIMbMR8ah5efo0ACH1kY86CWSGK6TkTnp
         +6yD4Ks6ymxcYVxEJWR5p3vnydSpihuawCxUn2NlBIhS9EX3t6xJyFn8FDqjjv0Nw9mm
         juwXQMbA6e0VHl7zy2v6cuD9p/9hs0Mcu3Cik48GSoNeNir9wyVCU69nzYWZMxNX+JKT
         oYWA==
X-Gm-Message-State: AOAM532DYyVZvdGZ/cfTn2duRZ3bOdT+gFCXf77/DKaL1R/DHDES3kDs
        xb+CKKX1PcmZ/mMe88dH90IBhw==
X-Google-Smtp-Source: ABdhPJwov9JVqDZYwNLrmlDFC6Zy6ucgTQHK2aKYXvX/V3O2PQ2vQl6iReZ6zhqmXsvUWRyA2+pIJw==
X-Received: by 2002:a05:6402:26c7:b0:41b:7aef:bdf6 with SMTP id x7-20020a05640226c700b0041b7aefbdf6mr8221907edd.210.1648821058896;
        Fri, 01 Apr 2022 06:50:58 -0700 (PDT)
Received: from [10.202.0.7] ([31.31.140.89])
        by smtp.gmail.com with ESMTPSA id d23-20020aa7d5d7000000b00418f7b2f1dbsm1217075eds.71.2022.04.01.06.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 06:50:57 -0700 (PDT)
Message-ID: <46ae7788-dade-3ff4-a353-985544f12c19@citymesh.com>
Date:   Fri, 1 Apr 2022 15:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Dexuan Cui <dexuan.linux@gmail.com>
References: <20220208234023.GA505306@bhelgaas> <m3czjovdqn.fsf@t19.piap.pl>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
In-Reply-To: <m3czjovdqn.fsf@t19.piap.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 15.02.22 07:35, Krzysztof Hałasa wrote:
> Hi Bjorn,
>
> Bjorn Helgaas <helgaas@kernel.org> writes:
>
>> Koen collected some interesting logs at
>> https://lore.kernel.org/all/cd4812f0-1de3-0582-936c-ba30906595af@citymesh.com/
>> They're from v5.10, which was before all of Krzysztof W's nice work
>> converting to static attributes, but Koen's log shows the error
>> happening in the pci_sysfs_init() initcall, which is *after*
>> imx6_pcie_probe():
>>
>>    imx6_pcie_probe                # probably device initcall (level 6)
>>      ...
>>        pci_create_sysfs_dev_files
>>
>>    pci_sysfs_init                 # late initcall (level 7)
>>      pci_create_sysfs_dev_files
>>        "sysfs: cannot create duplicate filename"
> Well, imx6_pcie_probe() is called indirectly by
> platform_driver_register(). I guess it doesn't know about the initcall
> ordering, after it's registered.
>
> It looks like the problem is the imx6_pcie_probe() (via
> dw_pcie_host_init() -> pci_host_probe()) is interfering with
> pci_sysfs_init(). This may eventually cause some invalid memory access
> as well.
>
> BTW I thought for a moment that maybe 5.14 is free from this. I was
> wrong. The problem doesn't manifest itself on my custom i.MX6 device
> (using Tinyrex CPU module from Voipac/Fedevel, perhaps because I don't
> use any PCI devices there). It does on Ventana SBC from Gateworks,
> though. BTW the above (and below) is v5.16.
>
> It goes like this:
> [0.096212] do_initcall_level: 6
> [0.105625] imx6_pcie_init
> [0.106106] imx6_pcie_probe       <<<<<<<<<<<<<<<<<<<<<
> [0.106412] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
>
> [0.322613] imx6q-pcie 1ffc000.pcie: Link up
> [0.322776] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> [0.322790] pci_bus 0000:00: root bus resource [bus 00-ff]
>
> [0.405251] do_initcall_level: 6 ENDs but imx6_pcie_probe() still active
> [0.405262] do_initcall_level: 7
>
> [0.410393] pci_sysfs_init        <<<<<<<<<<<<<<<<<<<<<
> [0.410423] pci 0000:00:00.0: pci_create_sysfs_dev_files
>
> [0.410532] [<8068091c>] (pci_create_sysfs_dev_files)
> [0.410551] [<80918710>] (pci_sysfs_init)
> [0.410568] [<8010166c>] (do_one_initcall)
>
> [0.410717] pci_sysfs_init END    <<<<<<<<<<<<<<<<<<<<<
>
> [0.533843] [<803f1c74>] (pci_bus_add_devices)
> [0.533862] [<803f574c>] (pci_host_probe)
> [0.533879] [<80414310>] (dw_pcie_host_init)
> [0.533895] [<80681ac8>] (imx6_pcie_probe)
> [0.533915] [<8045e9e4>] (platform_probe)
> (Repeats multiple times, I guess for each PCI device)
>
> [0.543893] imx6_pcie_probe END   <<<<<<<<<<<<<<<<<<<<<
>
> [0.692244] do_initcall_level: 7 END


Hi all,

Any update on this topic?
I just tested kernel 5.15 on imx6 (gateworks Ventana 5200) and as soon 
as I connect a pcie device on one of the ports,

following happens:

https://pastebin.com/raw/mgfSvTRB

Any idea if this is related?


Thanks,

Koen

