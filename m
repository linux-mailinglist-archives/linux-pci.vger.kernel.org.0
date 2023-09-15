Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142847A158F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 07:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjIOFmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 01:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjIOFmG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 01:42:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0961C1FC8;
        Thu, 14 Sep 2023 22:42:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B76C433C8;
        Fri, 15 Sep 2023 05:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694756521;
        bh=qgukgSQliG5UKLUjUQfOpI4jxUuXNFnLMEkfK97Qfo4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gZUjdtteoNW6CcWoDJntN+p7gfh0GNXx985j6AdwtgeZBRxu2QE841FlY+FMMwhxU
         a8PBs0RrljCbKmh2M2WCmamq6BcW9zqJ+33K4sSDwBVgc8R+IZ3COUOrfOHFzBu+ef
         s+k+Nc+sny+Bd+bQFY6U4USE+RSmAzHqLZcpCH/jrY9mRsTUvDQ18DmP8Nk2H36jFc
         NgLYjkPdt7TqH8FaD6QPxmkASuwvWx8WKe/TimRdhCYjDYf9fc70iAsW7ITvGEciAv
         aaskqs/oSZnb4WUzbdXAFwbrHUT3uI/TBjVIb8Jn/jYPkxVnv4imOAp8KFzriy8aDQ
         itkGGdEMzw5jw==
Message-ID: <10f65dfe-5e8a-10ab-4d89-efe693c07caa@kernel.org>
Date:   Fri, 15 Sep 2023 14:41:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Content-Language: en-US
To:     David Gow <david@davidgow.net>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        patenteng <dimitar@daskalov.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
 <ZQHRQHAPQdG+Nu1o@x1-carbon>
 <59f6ff78-6b45-465a-bd41-28c7a5d10931@davidgow.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <59f6ff78-6b45-465a-bd41-28c7a5d10931@davidgow.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/15/23 12:22, David Gow wrote:
> Le 2023/09/13 à 23:12, Niklas Cassel a écrit :
>> On Wed, Sep 13, 2023 at 06:25:31PM +0700, Bagas Sanjaya wrote:
>>> Hi,
>>>
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>
>>>> After upgrading to 6.5.2 from 6.4.12 I keep getting the following kernel messages around three times per second:
>>>>
>>>> [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>> [ 9683.270399] ata16.00: configured for UDMA/66
>>>>
>>>> So I've tracked the offending device:
>>>>
>>>> ll /sys/class/ata_port/ata16
>>>> lrwxrwxrwx 1 root root 0 Sep 10 21:51 /sys/class/ata_port/ata16 -> ../../devices/pci0000:00/0000:00:1c.7/0000:0a:00.0/ata16/ata_port/ata16
>>>>
>>>> cat /sys/bus/pci/devices/0000:0a:00.0/uevent
>>>> DRIVER=ahci
>>>> PCI_CLASS=10601
>>>> PCI_ID=1B4B:9130
>>>> PCI_SUBSYS_ID=1043:8438
>>>> PCI_SLOT_NAME=0000:0a:00.0
>>>> MODALIAS=pci:v00001B4Bd00009130sv00001043sd00008438bc01sc06i01
>>>>
>>>> lspci | grep 0a:00.0
>>>> 0a:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SATA 6 Gb/s RAID controller with HyperDuo (rev 11)
>>>>
>>>> I am not using the 88SE9128, so I have no way of knowing whether it works or not. It may simply be getting reset a couple of times per second or it may not function at all.
>>>
>>> See Bugzilla for the full thread.
>>>
>>> patenteng: I have asked you to bisect this regression. Any conclusion?
>>>
>>> Anyway, I'm adding this regression to regzbot:
>>>
>>> #regzbot: introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217902
>>
>> Hello Bagas, patenteng,
>>
>>
>> FYI, the prints:
>> [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [ 9683.270399] ata16.00: configured for UDMA/66
>>
>> Just show that ATA error handler has been invoked.
>> There was no reset performed.
>>
>> If there was a reset, you would have seen something like:
>> [    1.441326] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [    1.541250] ata8.00: configured for UDMA/133
>> [    1.541411] ata8: hard resetting link
>>
>>
>> Could you please try this patch and see if it improves things for you:
>> https://lore.kernel.org/linux-ide/20230913150443.1200790-1-nks@flawful.org/T/#u
>>
> 
> FWIW, I'm seeing a very similar issue both in 6.5.2 and in git master 
> [aed8aee11130 ("Merge tag 'pmdomain-v6.6-rc1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm") with that 
> patch applied.
> 
> 
> The log is similar (the last two lines repeat several times a second):
> [    0.369632] ata14: SATA max UDMA/133 abar m2048@0xf7c10000 port 
> 0xf7c10480 irq 33
> [    0.683693] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.031662] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
> [    1.031852] ata14.00: configured for UDMA/66
> [    1.414145] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.414505] ata14.00: configured for UDMA/66
> [    1.744094] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.744368] ata14.00: configured for UDMA/66
> [    2.073916] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    2.074276] ata14.00: configured for UDMA/66
> 
> 
> lspci shows:
> 09:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0 
> x2 4-port SATA 6 Gb/s RAID Controller (rev 10) (prog-if 01 [AHCI 1.0])
>          Subsystem: Gigabyte Technology Co., Ltd Device b000
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 64 bytes
>          Interrupt: pin A routed to IRQ 33
>          Region 0: I/O ports at b050 [size=8]
>          Region 1: I/O ports at b040 [size=4]
>          Region 2: I/O ports at b030 [size=8]
>          Region 3: I/O ports at b020 [size=4]
>          Region 4: I/O ports at b000 [size=32]
>          Region 5: Memory at f7c10000 (32-bit, non-prefetchable) [size=2K]
>          Expansion ROM at f7c00000 [disabled] [size=64K]
>          Capabilities: <access denied>
>          Kernel driver in use: ahci
> 
> The controller in question lives on a Gigabyte Z87X-UD5H-CF motherboard. 
> I'm using the controller for several drives, and it's working, it's just 
> spammy. (At worst, there's some performance hitching, but that might 
> just be journald rotating logs as they fill up with the message).
> 
> I haven't had a chance to bisect yet (this is a slightly awkward machine 
> for me to install test kernels on), but can also confirm it worked with 
> 6.4.12.
> 
> Hopefully that's useful. I'll get back to you if I manage to bisect it.

Bisect will definitely be welcome. But first, please try adding the patch that
Niklas mentioned above:

https://lore.kernel.org/linux-ide/20230913150443.1200790-1-nks@flawful.org/T/#u

If that fixes the issue, we know the culprit :)

> 
> Cheers,
> -- David

-- 
Damien Le Moal
Western Digital Research

