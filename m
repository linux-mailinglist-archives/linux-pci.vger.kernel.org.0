Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13484C459F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 14:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbiBYNNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 08:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241007AbiBYNNI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 08:13:08 -0500
Received: from mail-mut.mcl.gg (mail-mut.mcl.gg [IPv6:2a0f:85c1:beef:2011::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50155181E55
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 05:12:35 -0800 (PST)
Message-ID: <3db2e80c-76aa-2f93-7be2-d2c34283289d@mcl.gg>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mcl.gg; s=mail;
        t=1645794750; bh=owDrh3jCAesAqtGwF9HgH+X6SWFko8JbNWCP+uD6IEs=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=je/XYiqXaH5Z2Bee6ZIklrkt2Qg0VMP1DqN1x+Sh8CA4LsEO4QK3jF6kh0XrVB7uh
         di9TnhVDuXIaGtuAP0bkJUTGFzV88ZkxOU0s6EYvtlwmkdIpDLpPGwGnpTlv1rerP7
         vN8IYcq4ccdRFAseIsQCpkGVJsWPu3qCrAQKbWoEjFS/tObIBdqBAnyCzu1BKYYIR7
         hsBhBBWy2XgrcOLPQLVqBZlPlPmVsfw0k+ZOPJf/CrKI41Nho8ZmgaxkQDL87R/3+e
         PI5QMkN4/5TURU/z8SnFol5aRHDnj35YnytO6mSiGNXgmR7bnA1a7ky4nZOz5y5jDy
         0iBYGgthdjPgQ==
Date:   Fri, 25 Feb 2022 14:12:30 +0100
MIME-Version: 1.0
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <d4dd76f4-19e4-c35a-bd46-6e014707402e@mcl.gg>
 <20220224162532.GA274119@bhelgaas> <20220224172136.ydx4wu7avmfq4ndt@pali>
From:   Marcel Menzel <mail@mcl.gg>
Subject: Re: Kernel 5.16.3 and above fails to detect PCIe devices on Turris
 Omnia (Armada 385 / mvebu)
In-Reply-To: <20220224172136.ydx4wu7avmfq4ndt@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Am 24.02.2022 um 18:21 schrieb Pali Rohár:
> On Thursday 24 February 2022 10:25:32 Bjorn Helgaas wrote:
>> On Thu, Feb 24, 2022 at 05:00:30PM +0100, Marcel Menzel wrote:
>>> +linux-pci
>>>
>>> Am 24.02.2022 um 14:52 schrieb Marcel Menzel:
>>>> Am 24.02.2022 um 14:09 schrieb Marcel Menzel:
>>>>> Hello,
>>>>>
>>>>> When upgrading from kernel 5.16.2 to a newer version (tried 5.16.3
>>>>> and 5.16.10 with unchanged .config), the Kernel fails to detect both
>>>>> my installed mPCIe WiFi cards in my Turris Omnia (newer version,
>>>>> silver case, GPIO pins installed again).
>>>>> I have two Mediatek MT7915 based cards installed. I also tried with
>>>>> one Atheros at9k and one ath10k based card, yielding the same
>>>>> result. On a Kernel version newer than 5.16.2, all cards aren't
>>>>> getting recognized correctly.
>>>>>
>>>>> Before 5.16.3 I also had to disable PCIe ASPM via boot aragument,
>>>>> otherwise the WiFi drivers would complain about weird device
>>>>> behaviors and failing to initialize them, but re-enabling it does
>>>>> not yield any different results.
>> Please try this commit, which is headed to mainline today:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=c49ae619905eebd3f54598a84e4cd2bd58ba8fe9
>>
>> This commit should fix the PCI enumeration problem.
> It should fix that regression. If not, please let me know.
Can confirm this patch solving the issue. Many thanks!

>> If you still have
>> to disable ASPM, that sounds like a separate problem that we should
>> also try to debug.
> This is different and known issue and **not** related to ASPM. I spend
> some time on it, initially I thought it is bug in Atheros cards, but now
> I'm in impression that this is issue in Marvell PCIe HW that link
> retraining (required step of ASPM) triggers either Link Down or Hot
> Reset which triggers another Atheros issue (this one is already
> documented in kernel pci quirks code).
>
> I will try to implement some workaround for this but requirement is to
> have all new improvements in pci-mvebu.c + pci-aardvark.c drivers... and
> review process is slow. So it would not be before all those changes are
> reviewed and merged.
Removing "pcie_aspm=off" works for my MT7915E based cards, having had no 
issues so far. So it doesn't seem to be an issue with the Marvell 
hardware itself at least.

Regarding Atheros cards: I disabled it back then for my Atheros AR9582 & 
QCA9880 cards and never re-enabled it when I switched to the MT7915E 
cards, which I forgot to mention in my first mail, sorry!
I put those two cards back into the device to test it, and the same 
problem occurs why I disabled it back then. The router completely 
freezes while booting with this as the last log lines (gathered via serial):

[   10.400986] ath9k 0000:02:00.0: can't change power state from D3cold 
to D0 (config space inaccessible)
[   10.466924] ath10k_pci 0000:03:00.0: can't change power state from 
D3cold to D0 (config space inaccessible)
[   10.613847] ath10k_pci 0000:03:00.0: failed to wake up device : -110
[   10.622944] usb 1-1: New USB device found, idVendor=0cf3, 
idProduct=3004, bcdDevice= 0.02
[   10.635092] usb 1-1: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[   10.659930] ath10k_pci: probe of 0000:03:00.0 failed with error -110

This seems to be another topic however. I'd be glad to test and try to 
debug fixes and / or gather additional information on my hardware 
regarding this problem.
