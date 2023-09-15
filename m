Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56907A145F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 05:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjIOD2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 23:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjIOD2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 23:28:30 -0400
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 20:28:25 PDT
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF11FCE;
        Thu, 14 Sep 2023 20:28:24 -0700 (PDT)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
        id 10F751D57FC; Fri, 15 Sep 2023 11:22:21 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1694748141;
        bh=yXQyOokVKuRuBBGZrk5jYZQNuKOW+gvtulUP9frgc30=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rAI9KNCTGOfH9Y/6xji5DOjHpGEGwwZ+ZnUriMWVeYVdctJXRs0SEDiLErZwyrw2D
         mSPmK7tD54B8o3crc7Uel+uImTo4ScMn9GghjOVC7jKoLuqhNFVAGL9/iH+2AjAiHY
         aGfw2Bz619HInRZ9LTtJb681AdWHos5CeBTgGMJT/cAn8zlLAL0vmi/lvrCgHrmvI5
         vgPwTCwF002HsirhkGiWmvl2ZokYG0yp0tmgDAQgLx08JNJH1I4bI+t23CjGUuazXb
         ZQNLMzMB+5C2fc5/kUHPkMUb/1qGOh6QqBddgHHhjeuxUpRedq0ewWiiM4lrqS8jky
         8uEYO77qqz97GcXIv9QUuPzi1D4bVCSZWzPP7g6nFQqFTV1+Av2nlr6Ead/6R86r+4
         Nk0JRs2mBPlz6UeBrsDkKAleiiaiX2VQSR96eokzeZ26KR2WCXi/EWU501AaDGnrSR
         oZTtJDS2nfn73LayND+owWa6tmfaAg4fS+HVWb31LoBfywRaE80ZpJHf0iRC7zr3/t
         nyuzl1jP5Xc3bRIVByQGsD5t4IdQpWAAnD7xSZugAEuqVtyPewWfgXReG4RJCWvv0Q
         McBxOXcK4xAzmue/0V5KFfhgstI5jyT91VLT3WGDzmjKYWxkq1DW3Q2xO9KJeuwGFO
         5vLcRG+EhU9Pb5+yP1mMjcN8=
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        sphereful.davidgow.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU autolearn=unavailable autolearn_force=no
        version=3.4.4
Received: from [IPV6:2001:8003:8824:9e00::bec] (unknown [IPv6:2001:8003:8824:9e00::bec])
        by sphereful.davidgow.net (Postfix) with ESMTPSA id 573341D57F7;
        Fri, 15 Sep 2023 11:22:19 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1694748139;
        bh=yXQyOokVKuRuBBGZrk5jYZQNuKOW+gvtulUP9frgc30=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FT+c/0nqvmmJ8ErjgrsLbfav1tec05UdP3xK4Pvl4IDdhNFHWnqdOMMiKVwE2a/6q
         0gzNpznDu0czUXO9709+kdU0dJlEPQFGhFt3coVTkhsmlHnOl1SBNu2RGVnMYt0gyg
         NouksuUX6OEKW1uRbFrpUJMdTyM94q84t3m6BTH2zpkoBt1qkuXkQs7ELsyxoFVG9q
         EOlDdN6BmyqhcAXxNeHTULTq9ednE/5dH6M2X5m07JRYEflxGfB4CEz5/KSjdWpdh6
         JOFJZ9ptoJ5ugjymetQ/5b7WFkOp7ULrwNAfVya4DO4g4M++VEpKeXf9FQoDsGUD1+
         tyGBgmk3qlaJjiv3kS+maOTnE9s/Ok5hd4SGYGQ06dwSPX3u4/+Vkl36zOQoAxHHE/
         Wx44cg97pDuj3VECDJFUqntpgwKKwlSXQ17fVDRWGXm39mG2KGA/+eKKgo3nCi7soz
         0lBVQ51ROAz8zIOZRLiVoLBAqWFOcw7RX8y72LyjjZSQtzuiR716/ybba7/S1jbl7k
         hpxsYNjHSNWoenDDnsArDnHnTFDaySmaVAfu+6ZZR0Js6VoR8UyG1vd6Tv3GW1udIi
         4qwg2zV5DFRiM23LeJjRu4I9h1evATV/4/yHeDmf9qqAAw4BKSenvA4Znagx7WE/DW
         awbxQbN5I0CRTF47i5YiUT0c=
Message-ID: <59f6ff78-6b45-465a-bd41-28c7a5d10931@davidgow.net>
Date:   Fri, 15 Sep 2023 11:22:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Content-Language: fr
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        patenteng <dimitar@daskalov.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
 <ZQHRQHAPQdG+Nu1o@x1-carbon>
From:   David Gow <david@davidgow.net>
In-Reply-To: <ZQHRQHAPQdG+Nu1o@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 2023/09/13 à 23:12, Niklas Cassel a écrit :
> On Wed, Sep 13, 2023 at 06:25:31PM +0700, Bagas Sanjaya wrote:
>> Hi,
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> After upgrading to 6.5.2 from 6.4.12 I keep getting the following kernel messages around three times per second:
>>>
>>> [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [ 9683.270399] ata16.00: configured for UDMA/66
>>>
>>> So I've tracked the offending device:
>>>
>>> ll /sys/class/ata_port/ata16
>>> lrwxrwxrwx 1 root root 0 Sep 10 21:51 /sys/class/ata_port/ata16 -> ../../devices/pci0000:00/0000:00:1c.7/0000:0a:00.0/ata16/ata_port/ata16
>>>
>>> cat /sys/bus/pci/devices/0000:0a:00.0/uevent
>>> DRIVER=ahci
>>> PCI_CLASS=10601
>>> PCI_ID=1B4B:9130
>>> PCI_SUBSYS_ID=1043:8438
>>> PCI_SLOT_NAME=0000:0a:00.0
>>> MODALIAS=pci:v00001B4Bd00009130sv00001043sd00008438bc01sc06i01
>>>
>>> lspci | grep 0a:00.0
>>> 0a:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SATA 6 Gb/s RAID controller with HyperDuo (rev 11)
>>>
>>> I am not using the 88SE9128, so I have no way of knowing whether it works or not. It may simply be getting reset a couple of times per second or it may not function at all.
>>
>> See Bugzilla for the full thread.
>>
>> patenteng: I have asked you to bisect this regression. Any conclusion?
>>
>> Anyway, I'm adding this regression to regzbot:
>>
>> #regzbot: introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217902
> 
> Hello Bagas, patenteng,
> 
> 
> FYI, the prints:
> [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [ 9683.270399] ata16.00: configured for UDMA/66
> 
> Just show that ATA error handler has been invoked.
> There was no reset performed.
> 
> If there was a reset, you would have seen something like:
> [    1.441326] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.541250] ata8.00: configured for UDMA/133
> [    1.541411] ata8: hard resetting link
> 
> 
> Could you please try this patch and see if it improves things for you:
> https://lore.kernel.org/linux-ide/20230913150443.1200790-1-nks@flawful.org/T/#u
> 

FWIW, I'm seeing a very similar issue both in 6.5.2 and in git master 
[aed8aee11130 ("Merge tag 'pmdomain-v6.6-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm") with that 
patch applied.


The log is similar (the last two lines repeat several times a second):
[    0.369632] ata14: SATA max UDMA/133 abar m2048@0xf7c10000 port 
0xf7c10480 irq 33
[    0.683693] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.031662] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
[    1.031852] ata14.00: configured for UDMA/66
[    1.414145] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.414505] ata14.00: configured for UDMA/66
[    1.744094] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.744368] ata14.00: configured for UDMA/66
[    2.073916] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.074276] ata14.00: configured for UDMA/66


lspci shows:
09:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0 
x2 4-port SATA 6 Gb/s RAID Controller (rev 10) (prog-if 01 [AHCI 1.0])
         Subsystem: Gigabyte Technology Co., Ltd Device b000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 33
         Region 0: I/O ports at b050 [size=8]
         Region 1: I/O ports at b040 [size=4]
         Region 2: I/O ports at b030 [size=8]
         Region 3: I/O ports at b020 [size=4]
         Region 4: I/O ports at b000 [size=32]
         Region 5: Memory at f7c10000 (32-bit, non-prefetchable) [size=2K]
         Expansion ROM at f7c00000 [disabled] [size=64K]
         Capabilities: <access denied>
         Kernel driver in use: ahci

The controller in question lives on a Gigabyte Z87X-UD5H-CF motherboard. 
I'm using the controller for several drives, and it's working, it's just 
spammy. (At worst, there's some performance hitching, but that might 
just be journald rotating logs as they fill up with the message).

I haven't had a chance to bisect yet (this is a slightly awkward machine 
for me to install test kernels on), but can also confirm it worked with 
6.4.12.

Hopefully that's useful. I'll get back to you if I manage to bisect it.

Cheers,
-- David
