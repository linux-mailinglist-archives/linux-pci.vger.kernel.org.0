Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EDA7202A0
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbjFBNHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 09:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjFBNHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 09:07:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B58E40;
        Fri,  2 Jun 2023 06:07:25 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q54Uy-0000CX-Jv; Fri, 02 Jun 2023 15:07:20 +0200
Message-ID: <c7da7095-7d68-c65b-daf8-7eee43b79d53@leemhuis.info>
Date:   Fri, 2 Jun 2023 15:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Robin Murphy <robin.murphy@arm.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Jason Adriaanse <jason_a69@yahoo.co.uk>, hch@lst.de,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230416065503.GB6410@lst.de>
 <fc9f4cef-9426-c9d2-3c2c-3ce12fe5f6c3@yahoo.co.uk>
 <5f37b0b0-6cb5-b210-a894-d1e91976126e@arm.com>
 <2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk>
 <07ee0cf7-a5c2-f87a-d627-8dd8fb082345@arm.com>
 <9648f668-a3bc-3296-71d1-c91cd4c9980e@yahoo.co.uk>
 <1539e760-392f-a33e-436e-bbf043e79bfc@arm.com>
 <14f2b1ab-2c7c-fa4d-5854-3df08ac9feef@yahoo.co.uk>
 <1928df45-7b56-a8a4-21b5-22e5d8ef95eb@leemhuis.info>
 <9b602abc-37e9-f236-37ee-71bcf1b7ce66@arm.com>
 <211f3938-2f93-cad7-a92b-821d3ac45b9e@leemhuis.info>
In-Reply-To: <211f3938-2f93-cad7-a92b-821d3ac45b9e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685711246;3491e0ec;
X-HE-SMSGID: 1q54Uy-0000CX-Jv
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Christoph, could you do me a favor and...

On 22.05.23 13:33, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 22.05.23 13:01, Robin Murphy wrote:
>> On 2023-05-22 11:26, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>
>>> I might be missing something, but it looks to me like this regression
>>> was never fixed in mainline. Which is strange, as we apparently had a
>>> patch from Robin that fixed the issue for the reporter.
>>>
>>> Did it fall through the cracks or what am I missing?
>>
>> Strictly, the regression itself has not been fixed - I guess it does
>> just about qualify since the rather-out-of-date
>> Documentation/arch/x86/x86_64/boot-options.rst does still say that
>> iommu=soft "can be used to prevent the usage of an available hardware
>> IOMMU", and that seems to be what has stopped happening here.
>>
>> What it exposed was a latent issue that this particular device has never
>> been properly supported for use with an IOMMU, and that's what I guessed
>> at a fix for.
> 
> Thx for the summary. This sounds a lot like you have no interest in
> submitting the quirk entry yourself (please correct me if I'm wrong).
> Jason from looking at lore doesn't seem to be involved in kernel
> development regularly. And I try to stay out of such waters as well, as
> I try to draw a line there. Which leads to the question:
> 
> Who will now submit the quirk entry?
> 
> From "git blame" it seems Bjorn and Alex added most of the other quirk
> entries for the marvel controllers (both CCed now). Could one of you add
> this one that Ron suggested in [1] as well?

...submit that quirk, as Bjorn and Alex apparently didn't pick this up?
I could do so myself, but prefer to leave that to people that actually
known what they are doing -- and thus can also handle problems later, in
case any show up. And strictly speaking it apparently was you who caused
this regression with 78013eaadf6 ("x86: remove the IOMMU table
infrastructure").

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> /me wonders if they'd need a "Signed-off-by" from Ron for a one-liner
> that is mainly copy-n-paste
> 
> Ciao, Thorsten
> 
> [1]
> https://lore.kernel.org/all/1539e760-392f-a33e-436e-bbf043e79bfc@arm.com/
> 
>>> On 25.04.23 15:58, Jason Adriaanse wrote:
>>>> I am happy to report that the change worked, this is what
>>>> drivers/pci/quirks.c looks like
>>>>
>>>> /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
>>>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
>>>>                           quirk_dma_func1_alias);
>>>> /* https://bugzilla.kernel.org/show_bug.cgi?id=217218 */
>>>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
>>>>                           quirk_dma_func1_alias);
>>>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
>>>>                           quirk_dma_func1_alias);
>>>>
>>>> Relevant output of dmesg -T with the new kernel running
>>>>
>>>> Tue Apr 25 21:45:13 2023] scsi host0: ahci
>>>> [Tue Apr 25 21:45:13 2023] scsi host1: ahci
>>>> [Tue Apr 25 21:45:13 2023] scsi host2: ahci
>>>> [Tue Apr 25 21:45:13 2023] scsi host3: ahci
>>>> [Tue Apr 25 21:45:13 2023] ata1: SATA max UDMA/133 abar m2048@0xf7d06000
>>>> port 0xf7d06100 irq 40
>>>> [Tue Apr 25 21:45:13 2023] ata2: SATA max UDMA/133 abar m2048@0xf7d06000
>>>> port 0xf7d06180 irq 40
>>>> [Tue Apr 25 21:45:13 2023] ata3: DUMMY
>>>> [Tue Apr 25 21:45:13 2023] ata4: DUMMY
>>>> [Tue Apr 25 21:45:13 2023] igb 0000:05:00.0 enp5s0: renamed from eth0
>>>> [Tue Apr 25 21:45:13 2023] ahci 0000:07:00.0: AHCI 0001.0000 32 slots 4
>>>> ports 6 Gbps 0xf impl SATA mode
>>>> [Tue Apr 25 21:45:13 2023] ahci 0000:07:00.0: flags: 64bit ncq sntf led
>>>> only pmp fbs pio slum part sxs
>>>> [Tue Apr 25 21:45:13 2023] scsi host4: ahci
>>>> [Tue Apr 25 21:45:13 2023] scsi host5: ahci
>>>> [Tue Apr 25 21:45:13 2023] scsi host6: ahci
>>>> [Tue Apr 25 21:45:13 2023] scsi host7: ahci
>>>> [Tue Apr 25 21:45:13 2023] ata5: SATA max UDMA/133 abar m2048@0xf7b10000
>>>> port 0xf7b10100 irq 41
>>>> [Tue Apr 25 21:45:13 2023] ata6: SATA max UDMA/133 abar m2048@0xf7b10000
>>>> port 0xf7b10180 irq 41
>>>> [Tue Apr 25 21:45:13 2023] ata7: SATA max UDMA/133 abar m2048@0xf7b10000
>>>> port 0xf7b10200 irq 41
>>>> [Tue Apr 25 21:45:13 2023] ata8: SATA max UDMA/133 abar m2048@0xf7b10000
>>>> port 0xf7b10280 irq 41
>>>> [Tue Apr 25 21:45:13 2023] usb 1-1: new high-speed USB device number 2
>>>> using ehci-pci
>>>> [Tue Apr 25 21:45:14 2023] usb 3-1: new high-speed USB device number 2
>>>> using ehci-pci
>>>> [Tue Apr 25 21:45:14 2023] ata8: SATA link up 6.0 Gbps (SStatus 133
>>>> SControl 300)
>>>> [Tue Apr 25 21:45:14 2023] ata6: SATA link up 6.0 Gbps (SStatus 133
>>>> SControl 300)
>>>> [Tue Apr 25 21:45:14 2023] ata7: SATA link up 6.0 Gbps (SStatus 133
>>>> SControl 300)
>>>> [Tue Apr 25 21:45:14 2023] ata5: SATA link up 6.0 Gbps (SStatus 133
>>>> SControl 300)
>>>> [Tue Apr 25 21:45:14 2023] ata7.00: ATA-9: WDC WD40EFRX-68WT0N0,
>>>> 80.00A80, max UDMA/133
>>>> [Tue Apr 25 21:45:14 2023] ata6.00: ATA-9: WDC WD40EFRX-68WT0N0,
>>>> 80.00A80, max UDMA/133
>>>> [Tue Apr 25 21:45:14 2023] ata8.00: ATA-9: WDC WD40EFRX-68WT0N0,
>>>> 80.00A80, max UDMA/133
>>>> [Tue Apr 25 21:45:14 2023] ata5.00: ATA-10: CT2000BX500SSD1, M6CR030,
>>>> max UDMA/133
>>>> [Tue Apr 25 21:45:14 2023] ata6.00: 7814037168 sectors, multi 0: LBA48
>>>> NCQ (depth 32), AA
>>>> [Tue Apr 25 21:45:14 2023] ata7.00: 7814037168 sectors, multi 0: LBA48
>>>> NCQ (depth 32), AA
>>>> [Tue Apr 25 21:45:14 2023] ata8.00: 7814037168 sectors, multi 0: LBA48
>>>> NCQ (depth 32), AA
>>>> [Tue Apr 25 21:45:14 2023] ata5.00: 3907029168 sectors, multi 1: LBA48
>>>> NCQ (depth 32), AA
>>>> [Tue Apr 25 21:45:14 2023] ata6.00: configured for UDMA/133
>>>> [Tue Apr 25 21:45:14 2023] ata7.00: configured for UDMA/133
>>>> [Tue Apr 25 21:45:14 2023] ata8.00: configured for UDMA/133
>>>> [Tue Apr 25 21:45:14 2023] ata1: SATA link down (SStatus 0 SControl 300)
>>>> [Tue Apr 25 21:45:14 2023] ata5.00: Features: Dev-Sleep
>>>> [Tue Apr 25 21:45:14 2023] ata5.00: configured for UDMA/133
>>>> [Tue Apr 25 21:45:14 2023] usb 1-1: New USB device found, idVendor=8087,
>>>> idProduct=0024, bcdDevice= 0.00
>>>> [Tue Apr 25 21:45:14 2023] usb 1-1: New USB device strings: Mfr=0,
>>>> Product=0, SerialNumber=0
>>>> [Tue Apr 25 21:45:14 2023] hub 1-1:1.0: USB hub found
>>>> [Tue Apr 25 21:45:14 2023] hub 1-1:1.0: 4 ports detected
>>>> [Tue Apr 25 21:45:14 2023] usb 3-1: New USB device found, idVendor=8087,
>>>> idProduct=0024, bcdDevice= 0.00
>>>> [Tue Apr 25 21:45:14 2023] usb 3-1: New USB device strings: Mfr=0,
>>>> Product=0, SerialNumber=0
>>>> [Tue Apr 25 21:45:14 2023] hub 3-1:1.0: USB hub found
>>>> [Tue Apr 25 21:45:14 2023] hub 3-1:1.0: 6 ports detected
>>>> [Tue Apr 25 21:45:14 2023] ata2: SATA link down (SStatus 0 SControl 300)
>>>> [Tue Apr 25 21:45:14 2023] scsi 4:0:0:0: Direct-Access ATA
>>>> CT2000BX500SSD1  030  PQ: 0 ANSI: 5
>>>> [Tue Apr 25 21:45:14 2023] scsi 5:0:0:0: Direct-Access ATA      WDC
>>>> WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
>>>> [Tue Apr 25 21:45:14 2023] scsi 6:0:0:0: Direct-Access ATA      WDC
>>>> WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
>>>> [Tue Apr 25 21:45:14 2023] scsi 7:0:0:0: Direct-Access ATA      WDC
>>>> WD40EFRX-68W 0A80 PQ: 0 ANSI: 5
>>>>
>>>> Thanks everyone for all your help.
>>>>
>>>> Jason
>>>>
>>>>
>>>> On 25/04/2023 19:37, Robin Murphy wrote:
>>>>> On 2023-04-25 05:17, Jason Adriaanse wrote:
>>>>>> Ok great,
>>>>>>
>>>>>> I take it a change needs to be made in
>>>>>> drivers/pci/quirks.c
>>>>>> ?
>>>>>> I do not mind making the change locally here and letting you know if
>>>>>> it works or not.
>>>>>
>>>>> Indeed, something like this (make sure the IDs actually match what your
>>>>> device reports, I'm just guessing):
>>>>>
>>>>>
>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>> index 44cab813bf95..a9166e886b75 100644
>>>>> --- a/drivers/pci/quirks.c
>>>>> +++ b/drivers/pci/quirks.c
>>>>> @@ -4161,6 +4161,8 @@
>>>>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
>>>>>   /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
>>>>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
>>>>>                quirk_dma_func1_alias);
>>>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
>>>>> +             quirk_dma_func1_alias);
>>>>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
>>>>>                quirk_dma_func1_alias);
>>>>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
>>>>>
>>>>>
>>>>> Marvell themselves seem to lump the 88SE92xx products together as a
>>>>> closely-related family, so given that we do have quirks for 3 of the 4
>>>>> already, this one does rather seem conspicuous by its absence...
>>>>>
>>>>> Thanks,
>>>>> Robin.
>>>>>
>>>>>> On 24/04/2023 22:07, Robin Murphy wrote:
>>>>>>> On 2023-04-24 14:44, Jason Adriaanse wrote:
>>>>>>>> I took out "iommu=soft" and the server failed to boot, so yes it
>>>>>>>> does break.
>>>>>>>>
>>>>>>>> The first error was
>>>>>>>> ata7.00: Failed to IDENTIFY (INIT_DEV_PARAMS failed , err_mask=0x80)
>>>>>>>
>>>>>>> OK, great, that confirms the underlying issue existed all along, so
>>>>>>> the regression is only a change in who wins a fight between certain
>>>>>>> conflicting command-line arguments, which is arguably not so
>>>>>>> critical.
>>>>>>>
>>>>>>> The rest of the evidence points to 88SE9235 wanting the same phantom
>>>>>>> function quirk as most other Marvell controllers, since although
>>>>>>> it's apparently been half-fixed such that DMA for two of the ports
>>>>>>> is being correctly emitted from function 0 - given that you say two
>>>>>>> of the disks *are* detected OK - the other two are still claiming to
>>>>>>> be function 1 after all.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Robin.
>>>>>>>
>>>>>>>> On 24/04/2023 21:20, Robin Murphy wrote:
>>>>>>>>> On 2023-04-22 07:25, Jason Adriaanse wrote:
>>>>>>>>>> Hi Christoph,
>>>>>>>>>>
>>>>>>>>>> Sorry for my late reply, I have been on the road.
>>>>>>>>>>
>>>>>>>>>> So, if I boot with
>>>>>>>>>> intel_iommu=off
>>>>>>>>>> Then the server boots fine..although that is not a solution
>>>>>>>>>> because I need Intel iommu for virtualisation.
>>>>>>>>>>
>>>>>>>>>> Also, I build all my kernels with CONFIG_INTEL_IOMMU=y
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> If you boot 5.15 *without* the "iommu=soft" argument, just
>>>>>>>>> "intel_iommu=on", does that also break?
>>>>>>>>>
>>>>>>>>> Robin.
>>>>
>>>>
>>
>>
