Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9427A1EB2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 14:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjIOM1Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 08:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjIOM1P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 08:27:15 -0400
Received: from sphereful.davidgow.net (sphereful.davidgow.net [IPv6:2404:9400:4:0:216:3eff:fee2:5328])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF1C2119;
        Fri, 15 Sep 2023 05:27:06 -0700 (PDT)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
        id E1F391D5819; Fri, 15 Sep 2023 20:27:04 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1694780824;
        bh=hnw4+F5CXXiG5poJbVxyNM5eJG1cjLqBF2kaMkJl0BE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TxAAlBJPFVqzL5j2iwYtGs7mBBQ/yKL1dlnrWvpkKxXMg3zmQLkokz1LgK2na3hyy
         +h6/HT48rgVqpm6bQaSFOFiOHBqVsWwXaezs0JVuS9IteiuUQXGgfarvlOa01eVKdp
         wJs80VPWh2Ey6Zj9gKZsxxIqwtWq6cL9du1+Md0WLDKWWP1xNcQwWPY1YQruAelOzR
         dvtW2Aa4WRClAoxlaS9Qp7DxP/B4P94Ay1UERSSqwgTHXUL35gX3RDb6wuz78smsqw
         Stul+Ii4Ph3WyutepaBHYWbAmBjZpUcfmpEzt28TJtXVN41b3peOkN9B0tFXR9TJx6
         e182cwHt0mCk8aHHzVctogl2ozDKIT9o8LAqJonWQWXHc8kiNnerCY8A7f0ET16qXd
         xh+ljsxHIn3rdH+HUmdzjRIG+Dn9QjJTHOcOkdofzxAvItWRbD+3JvwG1FBwd677b4
         coSTKmF0lvmr57xcv51zOEe6tJfCpfpMdXBqxqWupIPERsjD9ra1I9BLYoR0gjpXZ9
         e4G69UbqD0moCQFpvsgig5g3ah1WnagsicVirVnNwpMK2m09tPwla9YfakakTJFNk3
         sQdewDiiHHhcTMFjKaD80HA4aws6jgXbo/wfQ99jAw3r0jpGYK/fcYVlUMS5nyzQZ3
         SoUhb+pBnBf+6BhQzfEygQ+8=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from [IPV6:2001:8003:8824:9e00::bec] (unknown [IPv6:2001:8003:8824:9e00::bec])
        by sphereful.davidgow.net (Postfix) with ESMTPSA id 8B6BA1D5811;
        Fri, 15 Sep 2023 20:27:01 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1694780821;
        bh=hnw4+F5CXXiG5poJbVxyNM5eJG1cjLqBF2kaMkJl0BE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=elX93ZgJtmwnMCrAD2oBI6HWJnjcy9PNuzOd3e4eJyOtbszyDSKZQoQYoi+JH9clH
         SqpQwsqAGdn6J5reO9koZ++WxMvFFXVU1Nv/OxaPnRs5TXKk4xt0wl2uAMPDqAe7Ju
         Z1X39iB7bev37B+NYUfvrnzHky5wefVyMFrCqBGPA0mkXq1D2yAYHGFuc59tpOCIX7
         cygWhQVbs8rp8wZoglyLPlAhy/64JtSAVooYUI6+2Y0K2z2F5xZPOLNyonK7PWNGpO
         RZhV6mMfr6xQCAJ3vwVyDiyNO9KWCUrbU8xVafJCH4jSbDrIe+BoE1K+YxMVbh3EV2
         6bqP3XQYvAN8+wUehyvAEHXeeyXBtppeSquAYNt2F8wNIBvSOzWcS9K+ZJXUNOEIS6
         eHRxYrV377uKCvegcxdT2/wOg8IMeai7KGSm9YJuylqVphBEHWDQ0ms65sbgHRmNgT
         tUJK2OpBaKr9CN7lgcHsqKHG+2hX/5UnAvThy2qmTDvOZpYjlFiOFEwYilsu0FZwYs
         i5mRH1hqc0fDkBFAT7AeXowq8Jxl6v0jji3GRS6tEr6yTrJeYcr65sWlonw9kElwPd
         6PlAvyBsedAF0D++e2p+6sYvaDaI/Gb3ynqDMudnnIy1YIkjnjLM/ZREaf7z8MbWEa
         TRFKuB55Eae8ZYxvRmq9w93c=
Message-ID: <49d92af6-4968-4066-b33c-0fd06f8fdf28@davidgow.net>
Date:   Fri, 15 Sep 2023 20:26:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Content-Language: fr
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        patenteng <dimitar@daskalov.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
 <ZQHRQHAPQdG+Nu1o@x1-carbon>
 <59f6ff78-6b45-465a-bd41-28c7a5d10931@davidgow.net>
 <10f65dfe-5e8a-10ab-4d89-efe693c07caa@kernel.org>
 <658b9285-e030-4987-86a7-57cdb6c7f161@davidgow.net>
 <ZQQa0QRhm1BuI5IT@x1-carbon>
From:   David Gow <david@davidgow.net>
In-Reply-To: <ZQQa0QRhm1BuI5IT@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 2023/09/15 à 16:50, Niklas Cassel a écrit :
> On Fri, Sep 15, 2023 at 02:54:19PM +0800, David Gow wrote:
>> Le 2023/09/15 à 13:41, Damien Le Moal a écrit :
>>> On 9/15/23 12:22, David Gow wrote:
>>>> Le 2023/09/13 à 23:12, Niklas Cassel a écrit :
>>>>> On Wed, Sep 13, 2023 at 06:25:31PM +0700, Bagas Sanjaya wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>>>>
>>>>>>> After upgrading to 6.5.2 from 6.4.12 I keep getting the following kernel messages around three times per second:
>>>>>>>
>>>>>>> [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>>>> [ 9683.270399] ata16.00: configured for UDMA/66
>>>>>>>
>>>>>>> So I've tracked the offending device:
>>>>>>>
>>>>>>> ll /sys/class/ata_port/ata16
>>>>>>> lrwxrwxrwx 1 root root 0 Sep 10 21:51 /sys/class/ata_port/ata16 -> ../../devices/pci0000:00/0000:00:1c.7/0000:0a:00.0/ata16/ata_port/ata16
>>>>>>>
>>>>>>> cat /sys/bus/pci/devices/0000:0a:00.0/uevent
>>>>>>> DRIVER=ahci
>>>>>>> PCI_CLASS=10601
>>>>>>> PCI_ID=1B4B:9130
>>>>>>> PCI_SUBSYS_ID=1043:8438
>>>>>>> PCI_SLOT_NAME=0000:0a:00.0
>>>>>>> MODALIAS=pci:v00001B4Bd00009130sv00001043sd00008438bc01sc06i01
>>>>>>>
>>>>>>> lspci | grep 0a:00.0
>>>>>>> 0a:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SATA 6 Gb/s RAID controller with HyperDuo (rev 11)
>>>>>>>
>>>>>>> I am not using the 88SE9128, so I have no way of knowing whether it works or not. It may simply be getting reset a couple of times per second or it may not function at all.
>>>>>>
>>>>>> See Bugzilla for the full thread.
>>>>>>
>>>>>> patenteng: I have asked you to bisect this regression. Any conclusion?
>>>>>>
>>>>>> Anyway, I'm adding this regression to regzbot:
>>>>>>
>>>>>> #regzbot: introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217902
>>>>>
>>>>> Hello Bagas, patenteng,
>>>>>
>>>>>
>>>>> FYI, the prints:
>>>>> [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>>> [ 9683.270399] ata16.00: configured for UDMA/66
>>>>>
>>>>> Just show that ATA error handler has been invoked.
>>>>> There was no reset performed.
>>>>>
>>>>> If there was a reset, you would have seen something like:
>>>>> [    1.441326] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>>>> [    1.541250] ata8.00: configured for UDMA/133
>>>>> [    1.541411] ata8: hard resetting link
>>>>>
>>>>>
>>>>> Could you please try this patch and see if it improves things for you:
>>>>> https://lore.kernel.org/linux-ide/20230913150443.1200790-1-nks@flawful.org/T/#u
>>>>>
>>>>
>>>> FWIW, I'm seeing a very similar issue both in 6.5.2 and in git master
>>>> [aed8aee11130 ("Merge tag 'pmdomain-v6.6-rc1' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm") with that
>>>> patch applied.
>>>>
>>>>
>>>> The log is similar (the last two lines repeat several times a second):
>>>> [    0.369632] ata14: SATA max UDMA/133 abar m2048@0xf7c10000 port
>>>> 0xf7c10480 irq 33
>>>> [    0.683693] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>> [    1.031662] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
>>>> [    1.031852] ata14.00: configured for UDMA/66
>>>> [    1.414145] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>> [    1.414505] ata14.00: configured for UDMA/66
>>>> [    1.744094] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>> [    1.744368] ata14.00: configured for UDMA/66
>>>> [    2.073916] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>> [    2.074276] ata14.00: configured for UDMA/66
>>>>
>>>>
>>>> lspci shows:
>>>> 09:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0
>>>> x2 4-port SATA 6 Gb/s RAID Controller (rev 10) (prog-if 01 [AHCI 1.0])
>>>>            Subsystem: Gigabyte Technology Co., Ltd Device b000
>>>>            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>>>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>>>            Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>            Latency: 0, Cache Line Size: 64 bytes
>>>>            Interrupt: pin A routed to IRQ 33
>>>>            Region 0: I/O ports at b050 [size=8]
>>>>            Region 1: I/O ports at b040 [size=4]
>>>>            Region 2: I/O ports at b030 [size=8]
>>>>            Region 3: I/O ports at b020 [size=4]
>>>>            Region 4: I/O ports at b000 [size=32]
>>>>            Region 5: Memory at f7c10000 (32-bit, non-prefetchable) [size=2K]
>>>>            Expansion ROM at f7c00000 [disabled] [size=64K]
>>>>            Capabilities: <access denied>
>>>>            Kernel driver in use: ahci
>>>>
>>>> The controller in question lives on a Gigabyte Z87X-UD5H-CF motherboard.
>>>> I'm using the controller for several drives, and it's working, it's just
>>>> spammy. (At worst, there's some performance hitching, but that might
>>>> just be journald rotating logs as they fill up with the message).
>>>>
>>>> I haven't had a chance to bisect yet (this is a slightly awkward machine
>>>> for me to install test kernels on), but can also confirm it worked with
>>>> 6.4.12.
>>>>
>>>> Hopefully that's useful. I'll get back to you if I manage to bisect it.
>>>
>>> Bisect will definitely be welcome. But first, please try adding the patch that
>>> Niklas mentioned above:
>>>
>>> https://lore.kernel.org/linux-ide/20230913150443.1200790-1-nks@flawful.org/T/#u
>>>
>>> If that fixes the issue, we know the culprit :)
>>>
>>
>>
>> Sorry: I wasn't clear. I did try with that patch (applied on top of
>> torvalds/master), and the issue remained.
>>
>> I've started bisecting, but fear it'll take a while.
> 
> I can recommend using QEMU and PCI passthrough to bisect, as it is much
> faster to boot a kernel using QEMU with KVM than to do a real reboot.
> 
> It takes a while to set up the first time, but you know what they say:
> "give a man a fish and you feed him for a day;
> teach a man to fish and you feed him for a lifetime".
> 
> There are many ways to do it, but here is an example guide:
> https://github.com/floatious/qemu-bisect-doc
> 

Thanks. Alas, this machine doesn't have an IOMMU, which makes that 
difficult. I've definitely saved the link for the future, though.

In any case, the bisect is done:

624885209f31eb9985bf51abe204ecbffe2fdeea is the first bad commit
commit 624885209f31eb9985bf51abe204ecbffe2fdeea
Author: Damien Le Moal <dlemoal@kernel.org>
Date:   Thu May 11 03:13:41 2023 +0200

     scsi: core: Detect support for command duration limits

     Introduce the function scsi_cdl_check() to detect if a device supports
     command duration limits (CDL). Support for the READ 16, WRITE 16, 
READ 32
     and WRITE 32 commands are checked using the function 
scsi_report_opcode()
     to probe the rwcdlp and cdlp bits as they indicate the mode page 
defining
     the command duration limits descriptors that apply to the command being
     tested.

     If any of these commands support CDL, the field cdl_supported of struct
     scsi_device is set to 1 to indicate that the device supports CDL.

     Support for CDL for a device is advertizes through sysfs using the new
     cdl_supported device attribute. This attribute value is 1 for a device
     supporting CDL and 0 otherwise.

     Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
     Reviewed-by: Hannes Reinecke <hare@suse.de>
     Co-developed-by: Niklas Cassel <niklas.cassel@wdc.com>
     Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
     Link: https://lore.kernel.org/r/20230511011356.227789-9-nks@flawful.org
     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

  Documentation/ABI/testing/sysfs-block-device |  9 ++++
  drivers/scsi/scsi.c                          | 81 
++++++++++++++++++++++++++++
  drivers/scsi/scsi_scan.c                     |  3 ++
  drivers/scsi/scsi_sysfs.c                    |  2 +
  include/scsi/scsi_device.h                   |  3 ++
  5 files changed, 98 insertions(+)


This seems to match what was found on the Arch Linux forums, too:
https://bbs.archlinux.org/viewtopic.php?id=288723&p=3

I haven't tried it yet, but according to that forum thread, removing the 
calls to scsi_cdl_check() seems to resolve the issue. This is all well 
beyond my SCSI knowledge, but maybe a quirk to disable these CDL checks 
for these older marvell controllers is required? Though it seems odd 
that the device would be rescanned and/or scsi_add_lun called multiple 
times a second -- is that normal?

In any case, this seems to be the cause.

Thanks!
-- David

