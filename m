Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD1A29E9C1
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 11:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgJ2K4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 06:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgJ2K4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 06:56:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6899C0613CF
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 03:56:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c16so1982627wmd.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:reply-to:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rLLEiU8Fwe0/lSCXGhoqh/qPwh4yaenf7E7w2fMD9ww=;
        b=eLjsEaafHh/DZ11OWvZ4ZL4iwVhKSyMNO9E7AoiQ9ktC0nzp3pHBCLIRwDRtFzEPtI
         krOajDC+IRBxBpMUKGXM2GHWKwwnAzb+WK4fOM280cySHLAPSoITDTWRjQJ+rEEZMIVt
         g39G2v5IMmDeGtg4eSKj2XJJOgARQ0IrIhzpTiLt3U2tZJfjkY8QYJMCw4WuqTobQIhN
         /RsHghR23yPM9jNs17/qutJu4BE6EKyWYdrFSOrftgWOlXimy7vopxb2B0KGN88buNXy
         mj7z9Qhr9tFcBdXFVxHnRP+62vxOFmv9BLQf/EjlqdLLnaBBpJ9/FUCJWyhGKjk1L/fl
         NE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=rLLEiU8Fwe0/lSCXGhoqh/qPwh4yaenf7E7w2fMD9ww=;
        b=Lj4QwS5DynKE+6gGuaNfJrQF1Qu+QgT49ECgdJMXNxnfc54yIooMVT00m5YFqgYqQX
         eCXxZX60NAnWMcqYpyJIPbPjV+F6NOjpzbrDaydMhvdUYFdt8TDwVxadCCleBoUIIGEC
         yQZV+paF6wdedawCpfxwnk2I7iBxq4igM4hPt+cbZIJA4XdBgIhrJ938F1Q53bwoLRcv
         7Tm9lG4WNA77XX1WP8Nss2wa1GpahNZH6TO9SVtePzVzF3qXcpRhWhZ3eWK/2Y50nOG6
         ihWsmrUBBc7dDp4IsrKpLD+WvtOKq0jBKpCKpUdLe70NgjzN6rDgv2M4ctJoChqv7cK/
         hLwg==
X-Gm-Message-State: AOAM531OuWlp/P/QACth/9Hs4UWrJOxRKcUuSA8PQmJo4edZkqIhMlcX
        Gb6P18KW6PV3j4GyPuyjO1Q=
X-Google-Smtp-Source: ABdhPJx+ADqu+40617bJ/YguCXUYxUeWHbt8uTcKyKvIBuG0k2Y2Y6raP0ukwIZUZvMI7l0126EKmA==
X-Received: by 2002:a1c:2283:: with SMTP id i125mr3639702wmi.41.1603968975395;
        Thu, 29 Oct 2020 03:56:15 -0700 (PDT)
Received: from [192.168.43.216] (x590fedf7.dyn.telefonica.de. [89.15.237.247])
        by smtp.gmail.com with UTF8SMTPSA id 205sm3850291wme.38.2020.10.29.03.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 03:56:14 -0700 (PDT)
From:   "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
X-Google-Original-From: =?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?= <vtolkm@gmail.com>
Reply-To: vtolkm@gmail.com
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201029100914.2e5x7lkbvks2gu4a@pali>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <84536849-2a4b-90bf-7772-472bf4e6dca1@gmail.com>
Date:   Thu, 29 Oct 2020 10:56:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201029100914.2e5x7lkbvks2gu4a@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/10/2020 11:09, Pali Roh=C3=A1r wrote:
> Hello!
>
> On Wednesday 28 October 2020 18:16:26 Bjorn Helgaas wrote:
>> [+cc Pali, Marek, Thomas, Jason]
>>
>> On Wed, Oct 28, 2020 at 04:40:00PM +0000, =E2=84=A2=D6=9F=E2=98=BB=D2=87=
=CC=AD =D1=BC =D2=89 =C2=AE wrote:
>>> On 28/10/2020 16:08, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>>>> On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>>>>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>>>>>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>>>>>>
>>>>>>>> [+cc vtolkm]
>>>>>>>>
>>>>>>>> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>>>>>>>>> Hi everyone
>>>>>>>>>
>>>>>>>>> I'm trying to get a mainline kernel to run on my Turris Omnia, =
and am
>>>>>>>>> having some trouble getting the PCI bus to work correctly. Spec=
ifically,
>>>>>>>>> I'm running a 5.10-rc1 kernel (torvalds/master as of this momen=
t), with
>>>>>>>>> the resource request fix[0] applied on top.
>>>>>>>>>
>>>>>>>>> The kernel boots fine, and the patch in [0] makes the PCI devic=
es show
>>>>>>>>> up. But I'm still getting initialisation errors like these:
>>>>>>>>>
>>>>>>>>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000=
004 !=3D 0xffffffff)
>>>>>>>>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x=
000000 !=3D 0xffffffff)
>>>>>>>>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200=
004 !=3D 0xffffffff)
>>>>>>>>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x=
000000 !=3D 0xffffffff)
>>>>>>>>>
>>>>>>>>> and the WiFi drivers fail to initialise with what appears to me=
 to be
>>>>>>>>> errors related to the bus rather than to the drivers themselves=
:
>>>>>>>>>
>>>>>>>>> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not support=
ed by this driver
>>>>>>>>> [    3.517049] ath: phy0: Unable to initialize hardware; initia=
lization status: -95
>>>>>>>>> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
>>>>>>>>> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -=
95
>>>>>>>>> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: faile=
d with rc=3D134
>>>>>>>>> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)=

>>>>>>>>> [    3.548735] ath10k_pci 0000:02:00.0: can't change power stat=
e from D3hot to D0 (config space inaccessible)
>>>>>>>>> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up devic=
e : -110
>>>>>>>>> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with er=
ror -110
>>>>>>>>>
>>>>>>>>> lspci looks OK, though:
>>>>>>>>>
>>>>>>>>> # lspci
>>>>>>>>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (=
rev 04)
>>>>>>>>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (=
rev 04)
>>>>>>>>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (=
rev 04)
>>>>>>>>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Ne=
twork Adapter (PCI-Express) (rev 01)
>>>>>>>>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.1=
1ac Wireless Network Adapter (rev ff)
>>>>>>>>>
>>>>>>>>> Does anyone have any clue what could be going on here? Is this =
a bug, or
>>>>>>>>> did I miss something in my config or other initialisation? I've=
 tried
>>>>>>>>> with both the stock u-boot distributed with the board, and with=
 an
>>>>>>>>> upstream u-boot from latest master; doesn't seem to make any di=
fferent.
>>>>>>>> Can you try turning off CONFIG_PCIEASPM?  We had a similar recen=
t
>>>>>>>> report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833 b=
ut I
>>>>>>>> don't think we have a fix yet.
>>>>>>> Yes! Turning that off does indeed help! Thanks a bunch :)
> I have been testing mainline kernel on Turris Omnia with two PCIe
> default cards (WLE200 and WLE900) and it worked fine. But I do not know=

> if I had ASPM enabled or not.
>
> So it is working fine for you when CONFIG_PCIEASPM is disabled and whol=
e
> issue is only when CONFIG_PCIEASPM is enabled?

Yes, that is the gist of it.

