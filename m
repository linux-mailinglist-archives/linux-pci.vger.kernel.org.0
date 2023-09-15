Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4284D7A168E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 08:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjIOGyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 02:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjIOGyj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 02:54:39 -0400
X-Greylist: delayed 12719 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 23:54:26 PDT
Received: from sphereful.davidgow.net (sphereful.davidgow.net [IPv6:2404:9400:4:0:216:3eff:fee2:5328])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2417271D;
        Thu, 14 Sep 2023 23:54:26 -0700 (PDT)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
        id A95151D5805; Fri, 15 Sep 2023 14:54:24 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1694760864;
        bh=XQJ2LhjuNHohn0bHVIdFmH9hk8s09g6V1/dd6q+mxl4=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=Hi7bUTflxnCeGBuuAKp14El2swhWK5tWcAapHEg3de2fTQU6NBfDRPKa4jXx2zmUe
         P3OS1/0zKsB0I0ubf/NJLGCyc2TnTCE16rlAvDg0GOMR0xVDCI4qNZ1QZVAO8qxY6J
         udSVZJQG7wgRG5FbYBcOyEOsQ8s/OzsZcAuESJ0aaePWqWt65nBk0CxLeOpKJNh3Gn
         DbLWw+i1FrhidC5iGnOYXIzw//tiqa4JHbGheXZe98W/TCFD7kV1TaBTjDzn3h15Lz
         8gIijtfs6seGFfwgbuOJKW8l0hlScP/oXIhh3Pyef616LpuaqkMBHU5g16TNJ1c8oD
         Q0b5RvN/COip609Jmc48of4fiTtZdHY/0U7ifuMa7PTF/QN3OJuh8VG6r+mgBikNEX
         bTUz4uAp2e5wcfBjOYQQDYfQEzHdazOs4nR5gBoQKNxRt6zY+YX86O0E1t2taUvVsa
         BsBPgTz+uIdkx4gD2z9qxZXMpIVcTfvhSsxwIMaG0drLHcrQJ2zsM/nerJeXdkATnW
         dqp3hMyKbvn0fACk4hCwVR0TwgWIwSs1j+W7D0DMXDXeCE8YQZyDOWb9mzbnCqjtgR
         w3DMqvnfuHx2PJhY07WvXoXlMlWBptgG6OSebLag6FOjlY3SY/WWEsizMX+wXbRdsL
         SRD3S/bYUwwkqz7xuEMgRVD8=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from [IPV6:2001:8003:8824:9e00::bec] (unknown [IPv6:2001:8003:8824:9e00::bec])
        by sphereful.davidgow.net (Postfix) with ESMTPSA id BBF301D57EA;
        Fri, 15 Sep 2023 14:54:22 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1694760862;
        bh=XQJ2LhjuNHohn0bHVIdFmH9hk8s09g6V1/dd6q+mxl4=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=Jej7U/B4T8o2MgYP5f8UWtS28guozrDrTC7WC6oqvXoSKGqaWbRMEGVpKUhrEZQGg
         EbibmUQ6IxYXOSlKUPfQKpVFC6cIGeBnb2D4c06lfpshqqNValvN/dlh+WBk20t6cE
         fNtZKkQ64+PLc1ISP7u4li7ZivHnHKdWovnlxw23nfDnt0DaKPNk547v9mDpv8IBci
         WHyIutQ8GYLYc1X9fKbMpcWircDacFZbfkm/NbE3eyuNo3yJIBhJUeZ5kNIukNgM1d
         dIEG7A2RbBu8Ln6cyy+ZzhKNp1raRpn6XGHoM2HY7+NYhV0TCQ2l0xbHb+xqZlgaPz
         aCE1Bj9LKLbaNEmPbfREQy7a+C2midogYrFUcij2iFM86fDe36r2nMluOOVonw6k/z
         xERgOWxCroNQ/vj5flzR7RFU9Bb5LNAojq+8JFKuVH32aB9GL1ji84DuD0NHtsSvrR
         9B1C2zkTyyTUNm0yx0vE0C/ucxIUZ/yFtNFsnB40Y/3VMT2iI1WNjTijxTEF+9S/q3
         C3SV0L3/OUrt5Q5crk3gab5Q6jbxX2C4fUw7jW0oE/7ayZL+6BXpdH37gdr5PtZ4vz
         3T3Jj+qCetW8q62Epm0SotdKBUB1avEM5Q81zdeayxq9uxFrrb9/L4wn6ZZ7BZNB9N
         qd9VQgBgjMiN+AXVVTxi7SlU=
Message-ID: <658b9285-e030-4987-86a7-57cdb6c7f161@davidgow.net>
Date:   Fri, 15 Sep 2023 14:54:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   David Gow <david@davidgow.net>
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
To:     Damien Le Moal <dlemoal@kernel.org>,
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
 <10f65dfe-5e8a-10ab-4d89-efe693c07caa@kernel.org>
Content-Language: fr
In-Reply-To: <10f65dfe-5e8a-10ab-4d89-efe693c07caa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 2023/09/15 à 13:41, Damien Le Moal a écrit :
> On 9/15/23 12:22, David Gow wrote:
>> Le 2023/09/13 à 23:12, Niklas Cassel a écrit :
>>> On Wed, Sep 13, 2023 at 06:25:31PM +0700, Bagas Sanjaya wrote:
>>>> Hi,
>>>>
>>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>>
>>>>> After upgrading to 6.5.2 from 6.4.12 I keep getting the following kernel messages around three times per second:
>>>>>
>>>>> [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>> [ 9683.270399] ata16.00: configured for UDMA/66
>>>>>
>>>>> So I've tracked the offending device:
>>>>>
>>>>> ll /sys/class/ata_port/ata16
>>>>> lrwxrwxrwx 1 root root 0 Sep 10 21:51 /sys/class/ata_port/ata16 -> ../../devices/pci0000:00/0000:00:1c.7/0000:0a:00.0/ata16/ata_port/ata16
>>>>>
>>>>> cat /sys/bus/pci/devices/0000:0a:00.0/uevent
>>>>> DRIVER=ahci
>>>>> PCI_CLASS=10601
>>>>> PCI_ID=1B4B:9130
>>>>> PCI_SUBSYS_ID=1043:8438
>>>>> PCI_SLOT_NAME=0000:0a:00.0
>>>>> MODALIAS=pci:v00001B4Bd00009130sv00001043sd00008438bc01sc06i01
>>>>>
>>>>> lspci | grep 0a:00.0
>>>>> 0a:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SATA 6 Gb/s RAID controller with HyperDuo (rev 11)
>>>>>
>>>>> I am not using the 88SE9128, so I have no way of knowing whether it works or not. It may simply be getting reset a couple of times per second or it may not function at all.
>>>>
>>>> See Bugzilla for the full thread.
>>>>
>>>> patenteng: I have asked you to bisect this regression. Any conclusion?
>>>>
>>>> Anyway, I'm adding this regression to regzbot:
>>>>
>>>> #regzbot: introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217902
>>>
>>> Hello Bagas, patenteng,
>>>
>>>
>>> FYI, the prints:
>>> [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [ 9683.270399] ata16.00: configured for UDMA/66
>>>
>>> Just show that ATA error handler has been invoked.
>>> There was no reset performed.
>>>
>>> If there was a reset, you would have seen something like:
>>> [    1.441326] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [    1.541250] ata8.00: configured for UDMA/133
>>> [    1.541411] ata8: hard resetting link
>>>
>>>
>>> Could you please try this patch and see if it improves things for you:
>>> https://lore.kernel.org/linux-ide/20230913150443.1200790-1-nks@flawful.org/T/#u
>>>
>>
>> FWIW, I'm seeing a very similar issue both in 6.5.2 and in git master
>> [aed8aee11130 ("Merge tag 'pmdomain-v6.6-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm") with that
>> patch applied.
>>
>>
>> The log is similar (the last two lines repeat several times a second):
>> [    0.369632] ata14: SATA max UDMA/133 abar m2048@0xf7c10000 port
>> 0xf7c10480 irq 33
>> [    0.683693] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    1.031662] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
>> [    1.031852] ata14.00: configured for UDMA/66
>> [    1.414145] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    1.414505] ata14.00: configured for UDMA/66
>> [    1.744094] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    1.744368] ata14.00: configured for UDMA/66
>> [    2.073916] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [    2.074276] ata14.00: configured for UDMA/66
>>
>>
>> lspci shows:
>> 09:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0
>> x2 4-port SATA 6 Gb/s RAID Controller (rev 10) (prog-if 01 [AHCI 1.0])
>>           Subsystem: Gigabyte Technology Co., Ltd Device b000
>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0, Cache Line Size: 64 bytes
>>           Interrupt: pin A routed to IRQ 33
>>           Region 0: I/O ports at b050 [size=8]
>>           Region 1: I/O ports at b040 [size=4]
>>           Region 2: I/O ports at b030 [size=8]
>>           Region 3: I/O ports at b020 [size=4]
>>           Region 4: I/O ports at b000 [size=32]
>>           Region 5: Memory at f7c10000 (32-bit, non-prefetchable) [size=2K]
>>           Expansion ROM at f7c00000 [disabled] [size=64K]
>>           Capabilities: <access denied>
>>           Kernel driver in use: ahci
>>
>> The controller in question lives on a Gigabyte Z87X-UD5H-CF motherboard.
>> I'm using the controller for several drives, and it's working, it's just
>> spammy. (At worst, there's some performance hitching, but that might
>> just be journald rotating logs as they fill up with the message).
>>
>> I haven't had a chance to bisect yet (this is a slightly awkward machine
>> for me to install test kernels on), but can also confirm it worked with
>> 6.4.12.
>>
>> Hopefully that's useful. I'll get back to you if I manage to bisect it.
> 
> Bisect will definitely be welcome. But first, please try adding the patch that
> Niklas mentioned above:
> 
> https://lore.kernel.org/linux-ide/20230913150443.1200790-1-nks@flawful.org/T/#u
> 
> If that fixes the issue, we know the culprit :)
> 


Sorry: I wasn't clear. I did try with that patch (applied on top of 
torvalds/master), and the issue remained.

I've started bisecting, but fear it'll take a while.

Thanks,
-- David

